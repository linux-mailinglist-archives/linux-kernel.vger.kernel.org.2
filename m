Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3908238DCC2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhEWTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhEWTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:49:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDBC061574;
        Sun, 23 May 2021 12:47:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so12019250otk.5;
        Sun, 23 May 2021 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHLDAzgoe5vMXOT6qvc9XW3WjXcB8oHFGvO+PGOSEkA=;
        b=tOm5hRgRSWahRImv8mT9HI56OCPJyeiYGi40rnGy8Ut/offKXTFD+HW02sui3m9LWa
         36L/NCKvydGR4iYml8jciKoaYvwux1Gy/UCWFwOAFVzXX+wEz0vo75rOC8SBp6WKj3wU
         TkcYGM36C2p/wOOxF0xpLSDVvu/RjkmVqwiw6RNP4avXu6RbUPOkjHqbQhbkiyAf0sag
         0pf4y9Z7/YmgzGRg5FEGn/QpOt9UiUs3Llcr/T/VfY6mSQoe+cIEYmrMXUn5KOriGWhe
         p0d7DnwNNa9wiHnVNb8txpno2cUKiCDINuZpH4lFWvGQAJlLVQNCro5k9xVDVNUfXeKn
         JoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHLDAzgoe5vMXOT6qvc9XW3WjXcB8oHFGvO+PGOSEkA=;
        b=hBqFjOdMuzB0UCzhgHv4hGXtOYC8zDMcZ/LE7y12rUukZNGcZoi0O9fc/yKIU9Rn2J
         RqGxq8OKVY32zMVjRYUjqRLW92yoiKeeAFV7PnSz/SLIoAtJbvnYW4PptYYwVl09TZDn
         rHWV9715TmZyIXfGUIWyCSOtpRI4nldtxyhjSQWcanHG0U3wSYnRLfd2J/LeXBtJY4Fv
         vQ/V3bAPElPxkPfQugsqO2uQkYxVuMiQzFf/lNsinpWcojc63arkyBeE2nxarLUaJFdv
         fABBD9e8l+sl+fZNxGOrGRJ7bEBxyEvOIdbK6unvNZDJDwKuyBw23wu2lCT1QC0arCKc
         Mcbw==
X-Gm-Message-State: AOAM532y+5REmO9OreO9dO5nYCRNGrEWNfNstpbh7aBAMkj1rj3TisrU
        rxSXzMFHRg+yu33KZ5mV3zSQwWPnL30=
X-Google-Smtp-Source: ABdhPJzlyduczU3Bl0kR/y3VWRo7DM8xlyYB1+qWH3ALYZnY0GBG5vhvGp93VRx1jjqWCxs8C6Qz+w==
X-Received: by 2002:a05:6830:2243:: with SMTP id t3mr15701122otd.142.1621799268745;
        Sun, 23 May 2021 12:47:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x31sm2665136ota.24.2021.05.23.12.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 12:47:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 3/6] hwmon: (pmbus/pim4328) Add support for reading
 direct format coefficients
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210522105528.87629-1-erik.rosen@metormote.com>
 <20210522105528.87629-4-erik.rosen@metormote.com>
 <24ff79b6-29f5-6921-7418-9ba93bcf7193@roeck-us.net>
 <CA+ui0H=Q5Xei0Uts_VzNV2PcKHc5jhM+dum59+Q4Lg5GYFdEJg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b3f16425-8406-9737-c22a-1e3beda54a04@roeck-us.net>
Date:   Sun, 23 May 2021 12:47:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+ui0H=Q5Xei0Uts_VzNV2PcKHc5jhM+dum59+Q4Lg5GYFdEJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 10:52 AM, Erik Rosen wrote:
> On Sat, May 22, 2021 at 3:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 5/22/21 3:55 AM, Erik Rosen wrote:
>>> Add support for reading and decoding direct format coefficients to
>>> the PMBus core driver. If the new flag PMBUS_USE_COEFFICIENTS_CMD
>>> is set, the driver will use the COEFFICIENTS register together with
>>> the information in the pmbus_sensor_attr structs to initialize
>>> relevant coefficients for the direct mode format.
>>>
>>> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
>>> ---
>>>    drivers/hwmon/pmbus/pmbus_core.c | 93 ++++++++++++++++++++++++++++++++
>>>    include/linux/pmbus.h            |  8 +++
>>>    2 files changed, 101 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>>> index 460cbfd716e4..03c169bf5633 100644
>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>> @@ -2177,6 +2177,38 @@ static int pmbus_find_attributes(struct i2c_client *client,
>>>        return ret;
>>>    }
>>>
>>> +static int pmbus_init_coefficients(struct i2c_client *client,
>>> +                                struct pmbus_data *data, int page,
>>
>> This seems wrong. Coefficients are not maintained per page but per class,
>> and (re-)reading them for each supported page doesn't really add value or
>> even make sense.
>>
>>> +                                enum pmbus_sensor_classes sensor_class,
>>> +                                const struct pmbus_sensor_attr *attrs,
>>> +                                int nattrs)
>>> +{
>>> +     int i, status;
>>> +
>>> +     for (i = 0; i < nattrs; i++) {
>>> +             if (attrs->class == sensor_class &&
>>> +                 (attrs->func & data->info->func[page])) {
>>> +                     status = pmbus_read_coefficients(client,
>>> +                                                      (struct pmbus_driver_info *)data->info,
>>> +                                                      sensor_class,
>>> +                                                      attrs->reg);
>>> +                     if (status < 0) {
>>> +                             dev_err(&client->dev,
>>> +                                     "Failed to read coefficients for register: %x\n",
>>> +                                     attrs->reg);
>>> +                             return status;
>>> +                     }
>>> +                     return 0;
>>> +             }
>>> +             attrs++;
>>> +     }
>>> +
>>> +     dev_err(&client->dev, "No coefficients found for register: %x\n",
>>> +             attrs->reg);
>>> +
>>
>> attrs points beyond the array size here, so attrs->reg does not point
>> to a valid array element. The problem would also not be the register
>> this happens to point to, but the class (ie the chip does not support
>> a sensor of the requested class).
>>
>> Not sure if this should trigger a message or error in the first place.
>> It won't matter since the chip will never need those coefficients.
>> If anything, this would be a misconfiguration (the driver should
>> not set direct format for this sensor class), and the return value
>> should be -EINVAL.
>>
>> Either case, I wonder if this can be handled with less complex code,
>> ie without having to check data->info->func[] for all pages. How
>> about just walking through attrs and try all class matches until
>> one is found that works (ie not return on error but keep trying) ?
> 
> Ok, I'll send a new version based on your comments.
> I'm not entirely comfortable with just silently ignoring any failure to
> retrieve the coefficients for a sensor class. I mean it could be due to any
> reason; a bus error for instance. I'll return a -EINVAL for now if you don't
> disagree.
> 
Ok. After all, it does suggest a misconfiguration.

Thanks,
Guenter

> /Erik
> 
>>
>>> +     return -ENODEV;
>>> +}
>>> +
>>>    /*
>>>     * Identify chip parameters.
>>>     * This function is called for all chips.
>>> @@ -2185,6 +2217,7 @@ static int pmbus_identify_common(struct i2c_client *client,
>>>                                 struct pmbus_data *data, int page)
>>>    {
>>>        int vout_mode = -1;
>>> +     int ret;
>>>
>>>        if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE))
>>>                vout_mode = _pmbus_read_byte_data(client, page,
>>> @@ -2214,6 +2247,66 @@ static int pmbus_identify_common(struct i2c_client *client,
>>>                }
>>>        }
>>>
>>> +     if (data->flags & PMBUS_USE_COEFFICIENTS_CMD) {
>>
>> I think there should be a separate function to handle that,
>> to be called only once, not once per page.
>>
>>> +             if (!i2c_check_functionality(client->adapter,
>>> +                                          I2C_FUNC_SMBUS_BLOCK_PROC_CALL))
>>> +                     return -ENODEV;
>>> +
>>> +             if (data->info->format[PSC_VOLTAGE_IN] == direct) {
>>> +                     ret = pmbus_init_coefficients(client, data, page,
>>> +                                                   PSC_VOLTAGE_IN,
>>> +                                                   voltage_attributes,
>>> +                                                   ARRAY_SIZE(voltage_attributes));
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>
>> It might be useful to have a little structure with {class, attribute list pointer,
>> attribute list size} and walk through that in a loop instead of repeating essentially
>> the same code multiple times.
>>
>>> +
>>> +             if (data->info->format[PSC_VOLTAGE_OUT] == direct) {
>>> +                     ret = pmbus_init_coefficients(client, data, page,
>>> +                                                   PSC_VOLTAGE_OUT,
>>> +                                                   voltage_attributes,
>>> +                                                   ARRAY_SIZE(voltage_attributes));
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +
>>> +             if (data->info->format[PSC_CURRENT_IN] == direct) {
>>> +                     ret = pmbus_init_coefficients(client, data, page,
>>> +                                                   PSC_CURRENT_IN,
>>> +                                                   current_attributes,
>>> +                                                   ARRAY_SIZE(current_attributes));
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +
>>> +             if (data->info->format[PSC_CURRENT_OUT] == direct) {
>>> +                     ret = pmbus_init_coefficients(client, data, page,
>>> +                                                   PSC_CURRENT_OUT,
>>> +                                                   current_attributes,
>>> +                                                   ARRAY_SIZE(current_attributes));
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +
>>> +             if (data->info->format[PSC_POWER] == direct) {
>>> +                     ret = pmbus_init_coefficients(client, data, page,
>>> +                                                   PSC_POWER,
>>> +                                                   power_attributes,
>>> +                                                   ARRAY_SIZE(power_attributes));
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +
>>> +             if (data->info->format[PSC_TEMPERATURE] == direct) {
>>> +                     ret = pmbus_init_coefficients(client, data, page,
>>> +                                                   PSC_TEMPERATURE,
>>> +                                                   temp_attributes,
>>> +                                                   ARRAY_SIZE(temp_attributes));
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +     }
>>> +
>>>        pmbus_clear_fault_page(client, page);
>>>        return 0;
>>>    }
>>> diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
>>> index f720470b1bab..7fdc282dab5a 100644
>>> --- a/include/linux/pmbus.h
>>> +++ b/include/linux/pmbus.h
>>> @@ -52,6 +52,14 @@
>>>     */
>>>    #define PMBUS_NO_WRITE_PROTECT                      BIT(4)
>>>
>>> +/*
>>> + * PMBUS_USE_COEFFICIENTS_CMD
>>> + *
>>> + * When this flag is set the PMBus core driver will use the COEFFICIENTS
>>> + * register to initialize the coefficients for the direct mode format.
>>> + */
>>> +#define PMBUS_USE_COEFFICIENTS_CMD           BIT(5)
>>> +
>>>    struct pmbus_platform_data {
>>>        u32 flags;              /* Device specific flags */
>>>
>>>
>>

