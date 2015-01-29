require 'httparty'
require 'active_support/all'
class Flickr

  def self.photo_hash(flickr_id)
    id_hash_array = self.get_photos(flickr_id)
    complete_hash_array = []
    id_hash_array[0..10].each do |hash| #LIMITED - change this later
      url_hash = self.get_urls(hash[:id])
      combined = hash.merge(url_hash)
      complete_hash_array.push(combined)
    end
    complete_hash_array
  end

  def self.test(fid)
    extras = "&extras=url_q,url_m,url_n,url_z,url_c"
    response = self.response("flickr.people.getPublicPhotos", "user_id", fid, extras)
    photos = response['rsp']['photos']['photo']
    photo_array = []
    photos.each do |hash_element|
      photo_array.push(
        {
          :id => hash_element["id"], 
          :large_square => hash_element["url_q"], 
          :small => hash_element["url_m"], 
          :small_320 => hash_element["url_n"], 
          :medium_640 => hash_element["url_z"], 
          :medium_800  => hash_element["url_c"] 
        }
      )
    end
    photo_array
    photos
  end


  def self.get_photos(fid)
    response = self.response("flickr.people.getPublicPhotos", "user_id", fid, nil)
    photos = response['rsp']['photos']['photo']
    photo_array = []
    photos.each do |hash_element|
      photo_array.push({:id =>hash_element["id"]})
    end
    photo_array
  end

  def self.get_urls(fid)
    response = self.response("flickr.photos.getSizes", "photo_id", fid, nil)
    response = response['rsp']['sizes']['size']
    url_hash = {}
    response.each do |hash_element|
      url_hash[hash_element["label"].downcase.gsub(/\s+/, "_").to_sym] = hash_element['source']
    end
    url_hash.slice(:large_square, :small, :small_320, :medium_640, :medium_800)
  end

  def self.get_exif(fid)
    response = self.response("flickr.photos.getExif", "photo_id", fid, nil)
    if response["rsp"]["stat"] == "fail"
      return false
    else
      exif = response['rsp']['photo']['exif']
      exif_hash = {}
      exif.each do |hash_element|
        exif_hash[hash_element['tag'].to_sym] = hash_element['raw']
      end
      exif_hash.slice(
        :Model, 
        :Lens, 
        :FocalLength, 
        :MaxApertureValue, 
        :ExposureTime, 
        :ISO, 
        :WhiteBalance,
        :FNumber, 
        :Flash)
    end
  end

  def self.response(method, id_type, id, extras)
    url = "https://api.flickr.com/services/rest/?&method=#{method}&api_key=#{ENV['FLICKR_KEY']}&#{id_type}=#{id}#{extras}"
    response = HTTParty.get(url)
    response = response.parsed_response
  end

end
