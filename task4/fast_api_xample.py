from fastapi import FastAPI, Request
from middleware import RateLimiterMiddleware

app = FastAPI()
app.add_middleware(RateLimiterMiddleware, rules=load_config("config.yaml"))

@app.get("/api/protected")
async def protected_route(request: Request):
    return {"message": "You’re within rate limit!"}