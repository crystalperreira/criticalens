# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150309214016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "critiques", force: true do |t|
    t.string   "fid"
    t.integer  "user_id"
    t.string   "sugg_ap"
    t.string   "sugg_sh"
    t.string   "sugg_iso"
    t.string   "sugg_wb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.string   "fid"
    t.string   "model"
    t.string   "lens"
    t.string   "focal_length"
    t.string   "max_aperture_value"
    t.string   "exposure_time"
    t.string   "iso"
    t.string   "white_balance"
    t.string   "f_number"
    t.string   "flash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "small"
    t.string   "small_320"
    t.string   "medium_640"
    t.string   "medium_800"
    t.string   "large_square"
    t.string   "ev"
  end

  create_table "users", force: true do |t|
    t.string   "fid"
    t.string   "avatar"
    t.string   "level"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
