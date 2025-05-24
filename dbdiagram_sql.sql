Table User {
user_id UUID [pk]
name VARCHAR(100)
email VARCHAR(100)
phone VARCHAR(20)
birthdate DATE
user_type ENUM('guest', 'host')
profile_picture VARCHAR(255)
social_media_link VARCHAR(255)
referred_by UUID [ref: > User.user_id]
}

Table Address {
address_id UUID [pk]
street VARCHAR(150)
city VARCHAR(100)
zip_code VARCHAR(20)
country VARCHAR(100)
coordinates VARCHAR(100)
}

Table Verification {
verification_id UUID [pk]
user_id UUID [ref: > User.user_id]
method VARCHAR(50)
status ENUM('pending', 'approved', 'rejected')
verified_at TIMESTAMP
}

// 🏠 Listing & Accommodation Domain

Table Listing {
listing_id UUID [pk]
host_id UUID [ref: > User.user_id]
address_id UUID [ref: > Address.address_id]
title VARCHAR(150)
description TEXT
created_at TIMESTAMP
is_active BOOLEAN
}

Table RoomType {
room_type_id UUID [pk]
name VARCHAR(100)
description TEXT
}

Table ListingRoomType {
  listing_id UUID [ref: > Listing.listing_id, pk]
  room_type_id UUID [ref: > RoomType.room_type_id, pk]
}

Table Amenity {
amenity_id UUID [pk]
name VARCHAR(100)
category VARCHAR(100)
}

Table ListingAmenity {
  listing_id UUID [ref: > Listing.listing_id, pk]
  amenity_id UUID [ref: > Amenity.amenity_id, pk]
}

// 💸 Booking & Payments Domain

Table Booking {
booking_id UUID [pk]
guest_id UUID [ref: > User.user_id]
listing_id UUID [ref: > Listing.listing_id]
start_date DATE
end_date DATE
num_guests INT
booking_status ENUM('pending', 'confirmed', 'cancelled', 'completed')
created_at TIMESTAMP
}

Table Payment {
payment_id UUID [pk]
booking_id UUID [ref: > Booking.booking_id]
amount DECIMAL(10,2)
currency VARCHAR(10)
payment_date TIMESTAMP
payment_method VARCHAR(50)
commission_fee DECIMAL(10,2)
payout_amount DECIMAL(10,2)
}

Table Pricing {
pricing_id UUID [pk]
listing_id UUID [ref: > Listing.listing_id]
date DATE
price_per_night DECIMAL(10,2)
min_nights INT
max_nights INT
discount DECIMAL(5,2)
}

Table CancellationPolicy {
policy_id UUID [pk]
name VARCHAR(100)
description TEXT
refund_terms TEXT
}

// 📅 Calendar & Availability Domain

Table Availability {
  listing_id UUID [ref: > Listing.listing_id, pk]
  date DATE [pk]
  is_available BOOLEAN
  note TEXT
}

// 🗣️ Reviews & Ratings Domain

Table Review {
review_id UUID [pk]
reviewer_id UUID [ref: > User.user_id]
reviewee_id UUID [ref: > User.user_id]
booking_id UUID [ref: > Booking.booking_id]
rating INT
comment TEXT
created_at TIMESTAMP
}

Table ReviewCategory {
category_id UUID [pk]
name VARCHAR(50)
}

Table ReviewScore {
  review_id UUID [ref: > Review.review_id, pk]
  category_id UUID [ref: > ReviewCategory.category_id, pk]
  score INT
}

// 📊 Analytics / Meta Domain

Table SearchQueryLog {
search_id UUID [pk]
user_id UUID [ref: > User.user_id]
location_text VARCHAR(150)
num_guests INT
start_date DATE
end_date DATE
timestamp TIMESTAMP
}

Table Wishlist {
wishlist_id UUID [pk]
guest_id UUID [ref: > User.user_id]
name VARCHAR(100)
created_at TIMESTAMP
}

Table WishlistItem {
  wishlist_id UUID [ref: > Wishlist.wishlist_id, pk]
  listing_id UUID [ref: > Listing.listing_id, pk]
  added_at TIMESTAMP
}

Table SupportTicket {
ticket_id UUID [pk]
user_id UUID [ref: > User.user_id]
category VARCHAR(100)
description TEXT
status ENUM('open', 'in_progress', 'resolved', 'closed')
created_at TIMESTAMP
resolved_at TIMESTAMP
}