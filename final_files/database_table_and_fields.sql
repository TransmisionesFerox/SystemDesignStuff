-- Users (User accounts)
Users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE,
  email VARCHAR(100) UNIQUE,
  password_hash VARCHAR(255),
  created_at TIMESTAMP
)

-- Posts (User posts)
Posts (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES Users(id),
  content TEXT,
  created_at TIMESTAMP
)

-- Comments (Post comments)
Comments (
  id SERIAL PRIMARY KEY,
  post_id INT REFERENCES Posts(id),
  user_id INT REFERENCES Users(id),
  text TEXT,
  created_at TIMESTAMP
)

-- Friends (Friendship relationships)
Friends (
  user1_id INT REFERENCES Users(id),
  user2_id INT REFERENCES Users(id),
  status VARCHAR(20) -- 'pending', 'accepted'
  PRIMARY KEY (user1_id, user2_id)
)

-- FriendRequests (Friend requests)
FriendRequests (
  id SERIAL PRIMARY KEY,
  sender_id INT REFERENCES Users(id),
  receiver_id INT REFERENCES Users(id),
  status VARCHAR(20) -- 'pending', 'rejected'
)