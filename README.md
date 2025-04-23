# SystemDesignStuff
Stuff for system design

# TASK 4
## API RATE LIMITER

### Algorithm Choice
### Token Bucket

    - Why? Balances burstability and simplicity.

    How it works:

        - Each client gets a bucket of tokens (e.g., 100 tokens).

        - Tokens refill at a fixed rate (e.g., 10 tokens/sec).

        - Requests consume tokens; rejected if bucket is empty.

Alternatives considered:

    - Leaky Bucket: Strict FIFO, but less burst-friendly.

    - Fixed Window: Simpler but allows spikes at window edges.

### Configuration (.yaml)
```
rate_limits:  
  default:  
    capacity: 100    # Max requests  
    refill_rate: 10  # Requests/sec  
  premium:  
    capacity: 200  
    refill_rate: 20  
```

### Usage
FastAPI Middleware (python)
```
from fastapi import FastAPI  
from rate_limiter import RateLimiterMiddleware  

app = FastAPI()  
app.add_middleware(RateLimiterMiddleware)  

@app.get("/protected")  
async def protected_route():  
    return {"message": "Request allowed!"}  
```

### Response Headers
```
HTTP/1.1 200 OK  
X-RateLimit-Limit: 100  
X-RateLimit-Remaining: 95  
X-RateLimit-Reset: 30  # Seconds until refill  
```

### Metrics (.yaml)
```
metrics:  
  prometheus:  
    enable: true  
    port: 9090  
```