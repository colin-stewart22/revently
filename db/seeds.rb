# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ADDRESS = [
  "204 Brick Lane Shoreditch, London, E1 6SA, England",
  "675 Finchley Road, London, NW2 2JP, England",
  "48 Goodge Street, London, W1T 4LX, England",
  "383 Kennington Lane Vauxhall, London, SE11 5QY, England",
  "4 Noel Street Soho, London, W1F 8GB, England",
  "8 Plender Street Bayham Street, London, NW1 0JT, England",
  "97 Colney Hatch Lane, London, N10 1LR, England",
  "1A Launceston Place, London, W8 5RL, England",
  "3-4 Park Close, Knightsbridge, London, SW1X 7PQ, England",
  "10A Strathearn Place Paddington, London, W2 2NH, England",
  "12 Newport Place, London, WC2H 7PR, England",
  "4 Bedford Corner South Parade, London, W4 1LD, England"
]

puts "Destroy all database..."
Menu.destroy_all
Reservation.destroy_all
Restaurant.destroy_all
User.destroy_all

puts "Create new database..."

host = User.create!(
  email: "host@lewagon.com",
  password: "lewagon",
  first_name: "host",
  last_name: "lewagon",
  phone_number: "07595096963",
  is_host: true
)

visitor = User.create!(
  email: "visitor@lewagon.com",
  password: "lewagon",
  first_name: "visitor",
  last_name: "lewagon",
  phone_number: "07595096963",
  is_host: false
)

i = 0
12.times do
  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name,
    address: ADDRESS[i],
    cuisine: ["American", "Japanese", "Mexican", "Chinese", "Bar", "Vegan"].sample,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164,
    venue_type: ["Private room only", "Whole floor", "Whole venue"].sample,
    chairs: rand(5..40),
    max_guests: rand(5..99),
    price: rand(100..1999),
    rating: rand(2.0..5.0),
    user_id: host.id
  )
  5.times do
    Menu.create!(
      name: Faker::Food.dish,
      description: Faker::Food.description,
      category: ["Breakfast", "Lunch", "Dinner", "Starters", "Mains", "Desserts", "Drinks"].sample,
      price: rand(1..50),
      restaurant_id: restaurant.id
    )
  end
  i += 1
end

Reservation.create!(
  booking: Faker::Date.between(from: '2022-06-23', to: '2022-11-23'),
  restaurant_id: Restaurant.first.id,
  user_id: visitor.id
)

Reservation.create!(
  booking: Faker::Date.between(from: '2022-06-23', to: '2022-11-23'),
  restaurant_id: Restaurant.last.id,
  user_id: visitor.id
)

puts "Completed!"
