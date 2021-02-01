Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41CA30B233
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBAVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhBAVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:39:25 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C93FC06174A;
        Mon,  1 Feb 2021 13:38:45 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id k142so6066372oib.7;
        Mon, 01 Feb 2021 13:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oFWfbtQXqNDNsvzjC2sD6zbLLIN1a5K026e29c7VrKw=;
        b=WGZBWWmsH9N8JeF2gsgW/L4qHY3LUFmdTWTv45M4BkdYO4hdjUt8WiaskO2nzdNKQo
         //pTX85C9UQzzfnPtv/+UV6r44wGcjfcV69O5ldrjQLner0iMmHRd4U9tih1Mgn1/GCK
         c2mdgzK8D1xskZZ7thEOaDL4bnzo8FI3su9vtwRJ2cSSnnVk1HKNvaWCAG+Q2NujWF6I
         SFbGsybZZEjjffCPXtYurN+BYkcSzPrDxxXyYX7oYK4i4jPO/WdGKAo+agptgbnhdY6M
         18LGAbwXDoRme/t4CtwQi9CfjM/xxLOd6Q1HCNOZOd3PADigXuOLBkzQoKMP7cttu+eq
         4kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oFWfbtQXqNDNsvzjC2sD6zbLLIN1a5K026e29c7VrKw=;
        b=YKrh4O0HeiPmdxrgCdkdqPiTdQxpa1AxOQD14jFuQkWyUfZtBWJ9eE3jS8meu9lkp9
         m4Uc7s0uiSF6i0NUNmpJGzZTY0DQ6ABEIB++uwODLTlYkUVDXlMg8bAjCsBW4llBsLdK
         /GzQ89HFG3qVOF7uuLlkjLUFIozp07PLy/XD3PP43WugJhkXU4oLTQDAD2tVODKAtdRl
         GeRnlCOcvIHZskpk3siVYtIcX31fZr5akvbJwR0sfw//7+SEJ/JreoBLApcwgOWL1bNJ
         eyW8rKdic7zQdBu+fs847+4waR7Y7jHEF+eSByabpD/F1+s1l/XoL45N6aFJBdO0MQl3
         y+dQ==
X-Gm-Message-State: AOAM532rDHvzvSI+hFVdh1tuBP74q6HifDsHiBQcZKXmoxKgx1awo2mY
        gohe4zHFU6l4WB/PgHZHLkIfWvNByqE=
X-Google-Smtp-Source: ABdhPJw2jv99FKIwNMWAsuZ9QQ2cV+INC9m8uIJ4MitnXY2L7bdtXjU40KRr5kiAMWftRpALRDsdqQ==
X-Received: by 2002:aca:5208:: with SMTP id g8mr600511oib.2.1612215524529;
        Mon, 01 Feb 2021 13:38:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14sm4516043oof.38.2021.02.01.13.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 13:38:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/1] Add ST STPDDC60 pmbus driver
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
References: <20210127084140.35626-1-erik.rosen@metormote.com>
 <20210127084140.35626-2-erik.rosen@metormote.com>
 <20210127173255.GA144627@roeck-us.net>
 <CA+ui0HmbcQe_CD-0d+AMgx_jSuY=AG9Qx4Ab2g71kPVFrMDe_w@mail.gmail.com>
 <ee2a89f6-0f55-9328-b53d-b5893eb625db@roeck-us.net>
 <CA+ui0H=UC495kfZuZeg-ryPh_aSa0wFqf=hnn7oS782qFgh60A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <778339a4-501c-d73f-4378-9b0c2a6a03c0@roeck-us.net>
Date:   Mon, 1 Feb 2021 13:38:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+ui0H=UC495kfZuZeg-ryPh_aSa0wFqf=hnn7oS782qFgh60A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 8:48 AM, Erik Rosen wrote:
> Hi Guenter
> 
> 
> On Fri, Jan 29, 2021 at 4:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi Erik,
>>
>> On 1/29/21 5:07 AM, Erik Rosen wrote:
>> [ ... ]
>>>>
>>>>> +             break;
>>>>> +     case PMBUS_VOUT_OV_FAULT_LIMIT:
>>>>> +     case PMBUS_VOUT_UV_FAULT_LIMIT:
>>>>> +             ret = pmbus_read_word_data(client, page, phase, reg);
>>>>> +             if (ret < 0)
>>>>> +                     return ret;
>>>>> +             ret &= 0x07ff;
>>>>
>>>> This needs explanation. The BMR481 datasheet does not suggest that only
>>>> 11 bits are valid.
>>>
>>> Ok, I will add a clarification. These registers use LINEAR11 whereas
>>> LINEAR16 is expected for vout-related registers.
>>>
>> Is that the correct fix, then ? LINEAR11 means that the exponent is flexible,
>> while it is fixed for LINEAR16. Just assuming that the exponents always match
>> seems risky. Also, bit 11 in LINEAR11 is the sign bit, meaning negative limits
>> (which seem at least theoretically be possible) would be reported as large
>> positive values.
> 
> The chip actually uses fixed exponents for representing all linear values and
> the specification explicitly states the values of the LSB for all registers.
> It also states that the limits can be handled as linear format when
> writing  _if_
> the exponent is the fixed value used for that limit. This means I'll have to
> convert all limit writes to use the expected exponent.

I understand the datasheet a bit differently. You are correct, the exponent for
VOUT limits is always the same (LSB=0.00390625V, exponent -8), as it should be.
But it also seems to me that the data format is LINEAR16, not LINEAR11.
The datasheet says that the vout limit values are in bit 0..15.

For other sensors, the datasheet is a bit ambiguous. I can read it as always
using a fixed exponent when reading, or that it expects a fixed exponent when
writing. It might make sense to check this with an actual chip instead of
guessing. In this context, it is a bit odd that the datasheet keeps talking
about a "System Register IOUT_EXP" without actually specifying it.

In this context, you might want to watch out for register MFR_SVID_SLOW_SR_SELECTOR.
Its value seems to impact the exponents used for IOUT and POUT.

Also, I am not sure about the scale of other registers. It almost seems as if
limit registers are LINEAR11, but actual READ_xxx registers are LINEAR16.
For example, READ_IOUT is supposed to be bit 15:0 with the LSB determined
by IOUT_EXP, but IOUT_OC_WARN_LIMIT is in bit 9:0. This would be a problem
if READ_IOUT does not include the exponent, since it is interpreted as
LINEAR11 and expects the exponent in bit 11..15. With an expected exponent
of -1, the reported value would always be wrong. The same might apply
to pretty much all READ_xxx registers (what a mess).

Thanks,
Guenter

> Given this, I think it's safe to assume that the exponents are
> constant, but I'll
> add a check to handle potential negative values.
> 
>>
>>>>
>>>>> +             break;
>>>>> +     default:
>>>>> +             ret = -ENODATA;
>>>>> +             break;
>>>>> +     }
>>>>> +
>>>>> +     return ret;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * The vout under- and over-voltage limits are readonly for this chip.
>>>>> + */
>>>>
>>>> Not really. The BMR481 datasheet suggests that the value can be changed
>>>> by writing to MFR_OV_LIMIT_OFFSET and MFR_UV_LIMIT_OFFSET.
>>>> I am not saying that you should implement that if you don't want to,
>>>> but I would suggest a better (more accurate) explanation.
>>>
>>> I have looked into this a bit more and it's a bit more to it than I expected.
>>> The limits are actually dynamic values that will follow both commanded
>>> output voltage via the PMBus or SVID/AVSBus as well as current
>>> load (droop). To account for this I propose a mechanism to set the
>>
>> Yes, I noticed.
>>
>>> 'update' flag on selected sensors after auto-detection of limit attributes.
>>>
>>> Maybe add a function like this to pmbus_core that can be called
>>> after the probing is done?
>>>
>>> int pmbus_set_update(struct i2c_client *client, u8 reg)
>>> {
>>>         struct pmbus_data *data = i2c_get_clientdata(client);
>>>         struct pmbus_sensor *sensor;
>>>
>>>         for (sensor = data->sensors; sensor; sensor = sensor->next) {
>>>                 if (sensor->reg == reg) {
>>>                         sensor->update = true;
>>>                         return 0;
>>>                 }
>>>         }
>>>         return -ENXIO;
>>> }
>>>
>>
>> Add a boolean 'update' parameter (to be able to disable updates),
>> and make the function void. Also, remember that 'reg' may be repeated
>> on a chip with multiple pages, so you can't return after the first match.
>> Otherwise looks ok.
> 
> Ok
> 
>>
>>> I did also implemented writes to the limit registers via the offset
>>> registers but it might be
>>> a bit confusing to the user since the limits are set in relation to
>>> the current commanded
>>> output voltage and will change together with this. In the worst case,
>>> the voltage might
>>> change at the same time as the limit is written to, which will give
>>> unexpected results.
>>
>> Agreed, that can be tricky.
>>
>>> The alternative would be to just set these limits read-only. What is
>>> your opinion?
>>>
>>
>> Your call. Just add a note explaining why it is made read-only to explain
>> the reasoning for future readers.
> 
> Ok, I'll keep the functionality and add a note in the docs.
> 
> 
>>
>>> Also, I found a problem in how pmbus_set_sensor() works together with
>>> pmbus_clear_cache()
>>> as used in the zl6100 and lm25066 drivers. The new value is written to
>>> the sensor struct _after_
>>> the _pmbus_write_word_data() has returned and thus after
>>> pmbus_clear_cache() is called.
>>> The effect is that all values are cleared, except the one just written
>>> to, which I believe defeats
>>> the purpose of clearing the cache in the first place.> One solution would be to write the new value to sensor->data before
>>> the _pmbus_write_word_data
>>> is called and to restore the old value in case of error.
>>> I can make a separate patch for this if it seems like a reasonable solution?
>>>
>>
>> Good catch.
>>
>> An alternate and more generic solution might be to set sensor->data to
>> -ENODATA after updates. After all, it seems risky to assume that the chip
>> returns the value that was written (I have seen it often enough in other
>> drivers that this is not necessarily the case). That would also mean that
>> it would no longer be necessary to call pmbus_clear_cache() in the zl6100
>> and lm25066 drivers. Impact would be that a limit read after a write would
>> always be sent to the chip for all drivers, but that seems minimal compared
>> to the gain (and presumably limit registers are not frequently updated).
> 
> I agree that this is a more robust solution. I'll send a separate patch for this
> update. The zl6100 in fact still needs to clear the cache since a write to the
> fault limit also changes the value of the warning limit and vice versa. As far
> as I can see the usage in lm25066 can be removed however.
> 
>>
>> Thanks,
>> Guenter

