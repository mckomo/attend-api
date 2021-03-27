# attend-api

Use `curl` to register attendance in Zoho People. Service will skip holidays or days off. Use `dry` paramter to verify witch days will be registered.

```shell
curl https://api-attend.herokuapp.com/ \
    -X POST \
    -H "Authorization: Berer <your-token>" \
    -d "email=name@example.com" \
    -d "from=2021-03-01" \
    -d "to=2021-03-31" \
    -d "check_in=9:30" \
    -d "check_out=17:30" \
    -d "verbose=1" \
    -d "dry=1"
```

### Authorization

Pass `Authorization` header with `Berer` token.

```http request
Authorization: Berer <your-token>
```

### Parameters:

- `email` - your email address
- `from` - date in ISO 8601 format
- `to` - date in ISO 8601 format
- `check_in` - check in time (default is `9:00`)
- `check_out` - check out time (default is `17:00`)
- `verbose`- flag enables verbose output of error massage
- `dry` - flag enables dry run

### Examples

Register current day with default check in times.

```shell
curl https://api-attend.herokuapp.com/ \
    -X POST \
    -H "Authorization: Berer <your-token>" \
    -d "email=name@example.com"
```

Register one week with custom check in times.

```shell
curl https://api-attend.herokuapp.com/ \
    -X POST \
    -H "Authorization: Berer <your-token>" \
    -d "email=name@example.com" \
    -d "from=2021-03-22" \
    -d "to=2021-03-26" \
    -d "check_in=10:00" \
    -d "check_out=18:00"
```
