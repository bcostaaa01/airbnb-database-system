-- statements to create the tables for the Airbnb database system using PostgreSQL
CREATE TABLE IF NOT EXISTS "User" (
    user_id UUID PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    birthdate DATE,
    user_type VARCHAR(10) CHECK (user_type IN ('guest', 'host')),
    profile_picture VARCHAR(255),
    social_media_link VARCHAR(255),
    referred_by UUID REFERENCES "User"(user_id)
);

CREATE TABLE IF NOT EXISTS "Address" (
    address_id UUID PRIMARY KEY,
    street VARCHAR(150),
    city VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100),
    coordinates VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS "Verification" (
    verification_id UUID PRIMARY KEY,
    user_id UUID REFERENCES "User"(user_id),
    method VARCHAR(50),
    status VARCHAR(10) CHECK (status IN ('pending', 'approved', 'rejected')),
    verified_at TIMESTAMP
);

// 🏠 Listing & Accommodation Domain

CREATE TABLE IF NOT EXISTS "Listing" (
    listing_id UUID PRIMARY KEY,
    host_id UUID REFERENCES "User"(user_id),
    address_id UUID REFERENCES "Address"(address_id),
    title VARCHAR(150),
    description TEXT,
    created_at TIMESTAMP,
    is_active BOOLEAN,
    cancellation_policy_id UUID REFERENCES "CancellationPolicy"(policy_id)
);

CREATE TABLE IF NOT EXISTS "RoomType" (
    room_type_id UUID PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE IF NOT EXISTS "ListingRoomType" (
    listing_id UUID REFERENCES "Listing"(listing_id),
    room_type_id UUID REFERENCES "RoomType"(room_type_id),
    PRIMARY KEY (listing_id, room_type_id)
);

CREATE TABLE IF NOT EXISTS "Amenity" (
    amenity_id UUID PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS "ListingAmenity" (
    listing_id UUID REFERENCES "Listing"(listing_id),
    amenity_id UUID REFERENCES "Amenity"(amenity_id),
    PRIMARY KEY (listing_id, amenity_id)
);

CREATE TABLE IF NOT EXISTS "Booking" (
    booking_id UUID PRIMARY KEY,
    guest_id UUID REFERENCES "User"(user_id),
    listing_id UUID REFERENCES "Listing"(listing_id),
    start_date DATE,
    end_date DATE,
    num_guests INTEGER,
    booking_status VARCHAR(20) CHECK (booking_status IN ('pending', 'confirmed', 'cancelled', 'completed')),
    created_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Payment" (
    payment_id UUID PRIMARY KEY,
    booking_id UUID REFERENCES "Booking"(booking_id),
    amount DECIMAL(10,2),
    currency VARCHAR(10),
    payment_date TIMESTAMP,
    payment_method VARCHAR(50),
    commission_fee DECIMAL(10,2),
    payout_amount DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS "Pricing" (
    pricing_id UUID PRIMARY KEY,
    listing_id UUID REFERENCES "Listing"(listing_id),
    date DATE,
    price_per_night DECIMAL(10,2),
    min_nights INTEGER,
    max_nights INTEGER,
    discount DECIMAL(5,2)
);

CREATE TABLE IF NOT EXISTS "CancellationPolicy" (
    policy_id UUID PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    refund_terms TEXT
);

CREATE TABLE IF NOT EXISTS "Availability" (
    listing_id UUID REFERENCES "Listing"(listing_id),
    date DATE,
    is_available BOOLEAN,
    note TEXT,
    PRIMARY KEY (listing_id, date)
);

CREATE TABLE IF NOT EXISTS "Review" (
    review_id UUID PRIMARY KEY,
    reviewer_id UUID REFERENCES "User"(user_id),
    reviewee_id UUID REFERENCES "User"(user_id),
    booking_id UUID REFERENCES "Booking"(booking_id),
    rating INTEGER,
    comment TEXT,
    created_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "ReviewCategory" (
    category_id UUID PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS "ReviewScore" (
    review_id UUID REFERENCES "Review"(review_id),
    category_id UUID REFERENCES "ReviewCategory"(category_id),
    score INTEGER,
    PRIMARY KEY (review_id, category_id)
);

// 📊 Analytics / Meta Domain

CREATE TABLE IF NOT EXISTS "SearchQueryLog" (
    search_id UUID PRIMARY KEY,
    user_id UUID REFERENCES "User"(user_id),
    location_text VARCHAR(150),
    num_guests INT,
    start_date DATE,
    end_date DATE,
    timestamp TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Wishlist" (
    wishlist_id UUID PRIMARY KEY,
    guest_id UUID REFERENCES "User"(user_id),
    name VARCHAR(100),
    created_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "WishlistItem" (
    wishlist_id UUID REFERENCES "Wishlist"(wishlist_id),
    listing_id UUID REFERENCES "Listing"(listing_id),
    added_at TIMESTAMP,
    PRIMARY KEY (wishlist_id, listing_id)
);

CREATE TABLE IF NOT EXISTS "SupportTicket" (
    ticket_id UUID PRIMARY KEY,
    user_id UUID REFERENCES "User"(user_id),
    category VARCHAR(100),
    description TEXT,
    status VARCHAR(100) CHECK (status IN ('open', 'in_progress', 'resolved', 'closed')),
    created_at TIMESTAMP,
    resolved_at TIMESTAMP
);
