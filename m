Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E78355F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbhDFX27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhDFX26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:28:58 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E58C06174A;
        Tue,  6 Apr 2021 16:28:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so16279708oty.12;
        Tue, 06 Apr 2021 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GFnX4aUOtKqNUV8OKuRHzNfnOMT6/lsB7pdIKVdj1d0=;
        b=TXoVHHmpRlnGOWMuoxtDPCJfySJEV3fsJRCIYff1sKkMI7gpNVHbCH4koTnsFo2Q7N
         yeGNVJfYqfyJvNJtRad5Udna9KQuIlDS/l4Oleh4SDNDWj8vqVc+8CiyhY1I+xJRs/Fu
         6OObZ7v2rANnIiL7OmTW9MF5STj6oPxcr8+7IIXaVFjn3z4U6HbDoiIsGZjAAuqhxN56
         NP+YYAnqyEiAwdXLk+juUqg08f5FR4tHp6DfpwsOWA/4p4fCuZRhgrSb9/TjLqnRz1et
         mt6cScFAapuCUlIdVg8DNiMGliZBt6ZFmamyArdZv9VsVmfRez4VGn28vXP0G3LKBnaS
         If5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GFnX4aUOtKqNUV8OKuRHzNfnOMT6/lsB7pdIKVdj1d0=;
        b=n7ob/MYp4Vn8rvE9ZV/6RIQO8zYoZeI9QL0n7F4G04VbA3OttVKT5ehuFEUGG1CD65
         f0sBwWq05dNbLGR273D6ozhaF1NEUSAmB5HlRBWjtjInStW2A7BAprwYCLuaj4eI+Y0C
         luOvk6GQX6yDggqhZMPI68AYjJZr+BI5iqr0cZMJAJhjoT8bDSSzS4YoIvtr/LTahBhy
         frUNs+c7rhHAwyXC3PxkVOZpq1HS1q6YEzLXaqZMJINQPtLLyByXf/Oiu9fvatpG9PjF
         INn+MpgYXlMEb/4VWWjhbsVItxvyv/53Ui6Px2AA+1mg3y0FJHBqmSBiu89ZuWM/BARz
         4ZJQ==
X-Gm-Message-State: AOAM53130NH1C5UvQ8eSIf3drJGXIz4Zy34XdXtXhNLXvdWD7zts+5lj
        v6najD/9LfvEa7MSU3Y1pV1/yjqUvUg=
X-Google-Smtp-Source: ABdhPJwSuG9Mk8QNzkv+LipLKIDC6MtaBfMz+xDT2azAdWy3a9yHBkPCAil7sYJMiYGRmJl1m9Vv6g==
X-Received: by 2002:a9d:20c6:: with SMTP id x64mr433097ota.262.1617751728651;
        Tue, 06 Apr 2021 16:28:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm5101476otl.48.2021.04.06.16.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 16:28:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] hwmon: (sbtsi) Don't read sensor more than once if it
 doesn't respond
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Kun Yi <kunyi@google.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed438518-66ad-6e08-2a1b-597ac3f2ae8d@roeck-us.net>
 <20210406181624.713-1-aladyshev22@gmail.com>
 <0ba1d271-78cd-c30a-e662-97ab8ba6451a@roeck-us.net>
 <CACSj6VUCgxCQeA9EF4Oz+pKY+TdF9Gp=DV1V=-TcVE4ixtg45Q@mail.gmail.com>
 <40d02688-d40c-fcdd-b8eb-580a1e44b244@roeck-us.net>
 <CACSj6VVjJ9Avd0Ni0Zp4-skv-7Dk9cQkhB5hrsEyb+0ZQR5eJg@mail.gmail.com>
 <422092a4-a87d-59d2-f6cb-9adf19e8f006@roeck-us.net>
 <CACSj6VW2+8TBh971CERjxPzhyO5JeP0rbkrw0ZjfE4bkhMfo4Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e66d22ee-cc55-8794-7f39-5af67271347f@roeck-us.net>
Date:   Tue, 6 Apr 2021 16:28:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACSj6VW2+8TBh971CERjxPzhyO5JeP0rbkrw0ZjfE4bkhMfo4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 3:25 PM, Konstantin Aladyshev wrote:
> What I'm trying to say, shouldn't the call
> "i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG)" be
> surrounded with the "mutex_lock/mutex_unlock" like it is done for the
> others "i2c_smbus_read_byte_data" calls?
> Something like:
> ```
> mutex_lock(&data->lock);
> err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> if (err < 0)
>     return err;
> mutex_unlock(&data->lock);
> ```
> Because it is not surrounded with the mutex lock/unlock in the original driver.
> 

Why would that be necessary ? My understanding is that the returned value
is read-only and won't change. FWIW, I don't even understand why it is
read more than once to start with.

On a side note, the above code would leave the mutex locked on error.

Guenter

> Best regards,
> Konstantin Aladyshev
> 
> 
> On Wed, Apr 7, 2021 at 12:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 4/6/21 2:09 PM, Konstantin Aladyshev wrote:
>>> Thanks for the answer!
>>> Sorry for the confusion, by the "CPU is off" I meant "CPU is present,
>>> but currently it is in the powered off state".
>>> Therefore it is not possible to put these checks only in a probe
>>> function. And I don't know either if it is a good idea to cache
>>> config/min/max values.
>>>
>>> I use this driver on an OpenBMC system, which uses other software
>>> rather than lm-sensors utility. I guess that is why my priorities are
>>> shifted.
>>>
>>> By the way, I've noticed that the mutex check is absent in a
>>> SBTSI_REG_CONFIG read call both in the original driver version and in
>>> my patch, is this an error?
>>>
>>
>> What do you mean with "mutex check" ?
>>
>> Thanks,
>> Guenter
>>
>>
>>> Best regards,
>>> Konstantin Aladyshev
>>>
>>>
>>> On Tue, Apr 6, 2021 at 11:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 4/6/21 12:20 PM, Konstantin Aladyshev wrote:
>>>>> Thanks for the comment.
>>>>> Yes, you are correct, this patch adds an extra 'i2c_smbus_read_byte_data' call for the temp_max/temp_min reads.
>>>>> I guess I did that intentionally because I just wanted to keep the restructured code concise. After all I thought, 'temp_input' generally is read more often than 'temp_max/temp_min'.
>>>>> As I understand now, it seems like it is not acceptable. Therefore could you point me in the right direction about what I should do?
>>>>> Should I just stick with the original driver version and simply add two more i2c call checks for the first operations for min/max?
>>>>>
>>>>
>>>> Correct, it is not acceptable. A normal use case for hwmon devices is to use the "sensors"
>>>> command which _will_ read all attributes. i2c reads are expensive, and unnecessary read
>>>> operations should be avoided.
>>>>
>>>> There are several ways to solve the problem. Checking return values after each
>>>> read is the simple option. There are other possibilities, such as reading the limits
>>>> and the read order only once during probe, but I don't know enough about the
>>>> hardware to suggest a more sophisticated solution. For example, I don't know
>>>> what "CPU is off" means. Offline ? Not present ? If it means "not present",
>>>> or if the status is permanent, the condition should be handled in the is_visible
>>>> function (or the driver should not be instantiated in the first place).
>>>> Otherwise, the code should possibly return -ENODATA instead of -ETIMEDOUT
>>>> on error. But, again, I can not really suggest a better solution since
>>>> I don't know enough (nothing, actually) about the hardware (and the public
>>>> part of the SBTSI specification doesn't say anything about expected behavior
>>>> for offline CPUs or CPU cores).
>>>>
>>>> What I did find, though, is that the driver does not implement temperature
>>>> offset support, and it that doesn't support reporting alerts. I'd have assumed
>>>> this to be more important than optimizing error handling, but that is just
>>>> my personal opinion.
>>>>
>>>> Thanks,
>>>> Guenter
>>>>
>>>>> Best regards,
>>>>> Konstantin Aladyshev
>>>>>
>>>>>
>>>>> On Tue, Apr 6, 2021 at 9:42 PM Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>>>>>
>>>>>     On 4/6/21 11:16 AM, Konstantin Aladyshev wrote:
>>>>>     > SBTSI sensors don't work when the CPU is off.
>>>>>     > In this case every 'i2c_smbus_read_byte_data' function would fail
>>>>>     > by a timeout.
>>>>>     > Currently temp1_max/temp1_min file reads can cause two such timeouts
>>>>>     > for every read.
>>>>>     > Restructure code so there will be no more than one timeout for every
>>>>>     > read operation.
>>>>>     >
>>>>>     > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com <mailto:aladyshev22@gmail.com>>
>>>>>     > ---
>>>>>     > Changes in v2:
>>>>>     >   - Fix typo in a commit message
>>>>>     >   - Don't swap temp_int/temp_dec checks at the end of the 'sbtsi_read' function
>>>>>     >
>>>>>
>>>>>     This doesn't explain the reason for the extra read operation for
>>>>>     limits. Preventing a second read in error cases is not an argument
>>>>>     for adding an extra read for non-error cases.
>>>>>
>>>>>     Guenter
>>>>>
>>>>>     >  drivers/hwmon/sbtsi_temp.c | 55 +++++++++++++++++++-------------------
>>>>>     >  1 file changed, 27 insertions(+), 28 deletions(-)
>>>>>     >
>>>>>     > diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
>>>>>     > index e35357c48b8e..4ae48635bb31 100644
>>>>>     > --- a/drivers/hwmon/sbtsi_temp.c
>>>>>     > +++ b/drivers/hwmon/sbtsi_temp.c
>>>>>     > @@ -74,48 +74,47 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
>>>>>     >                     u32 attr, int channel, long *val)
>>>>>     >  {
>>>>>     >       struct sbtsi_data *data = dev_get_drvdata(dev);
>>>>>     > +     u8 temp_int_reg, temp_dec_reg;
>>>>>     >       s32 temp_int, temp_dec;
>>>>>     >       int err;
>>>>>     >
>>>>>     >       switch (attr) {
>>>>>     >       case hwmon_temp_input:
>>>>>     > -             /*
>>>>>     > -              * ReadOrder bit specifies the reading order of integer and
>>>>>     > -              * decimal part of CPU temp for atomic reads. If bit == 0,
>>>>>     > -              * reading integer part triggers latching of the decimal part,
>>>>>     > -              * so integer part should be read first. If bit == 1, read
>>>>>     > -              * order should be reversed.
>>>>>     > -              */
>>>>>     > -             err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
>>>>>     > -             if (err < 0)
>>>>>     > -                     return err;
>>>>>     > -
>>>>>     > -             mutex_lock(&data->lock);
>>>>>     > -             if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
>>>>>     > -                     temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
>>>>>     > -                     temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
>>>>>     > -             } else {
>>>>>     > -                     temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
>>>>>     > -                     temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
>>>>>     > -             }
>>>>>     > -             mutex_unlock(&data->lock);
>>>>>     > +             temp_int_reg = SBTSI_REG_TEMP_INT;
>>>>>     > +             temp_dec_reg = SBTSI_REG_TEMP_DEC;
>>>>>     >               break;
>>>>>     >       case hwmon_temp_max:
>>>>>     > -             mutex_lock(&data->lock);
>>>>>     > -             temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_INT);
>>>>>     > -             temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_DEC);
>>>>>     > -             mutex_unlock(&data->lock);
>>>>>     > +             temp_int_reg = SBTSI_REG_TEMP_HIGH_INT;
>>>>>     > +             temp_dec_reg = SBTSI_REG_TEMP_HIGH_DEC;
>>>>>     >               break;
>>>>>     >       case hwmon_temp_min:
>>>>>     > -             mutex_lock(&data->lock);
>>>>>     > -             temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_INT);
>>>>>     > -             temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_DEC);
>>>>>     > -             mutex_unlock(&data->lock);
>>>>>     > +             temp_int_reg = SBTSI_REG_TEMP_LOW_INT;
>>>>>     > +             temp_dec_reg = SBTSI_REG_TEMP_LOW_DEC;
>>>>>     >               break;
>>>>>     >       default:
>>>>>     >               return -EINVAL;
>>>>>     >       }
>>>>>     >
>>>>>     > +     /*
>>>>>     > +      * ReadOrder bit specifies the reading order of integer and
>>>>>     > +      * decimal part of CPU temp for atomic reads. If bit == 0,
>>>>>     > +      * reading integer part triggers latching of the decimal part,
>>>>>     > +      * so integer part should be read first. If bit == 1, read
>>>>>     > +      * order should be reversed.
>>>>>     > +      */
>>>>>     > +     err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
>>>>>     > +     if (err < 0)
>>>>>     > +             return err;
>>>>>     > +
>>>>>     > +     mutex_lock(&data->lock);
>>>>>     > +     if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
>>>>>     > +             temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
>>>>>     > +             temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
>>>>>     > +     } else {
>>>>>     > +             temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
>>>>>     > +             temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
>>>>>     > +     }
>>>>>     > +     mutex_unlock(&data->lock);
>>>>>     >
>>>>>     >       if (temp_int < 0)
>>>>>     >               return temp_int;
>>>>>     >
>>>>>
>>>>
>>

