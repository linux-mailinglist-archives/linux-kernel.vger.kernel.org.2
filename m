Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94C30CD61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhBBUyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhBBUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:54:51 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE996C061573;
        Tue,  2 Feb 2021 12:54:10 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id w8so24301701oie.2;
        Tue, 02 Feb 2021 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gfp5Wubi9kJH3jYYB/shKlrSDDynt76ZZ+uDiCu9JDw=;
        b=Lap1UaXysWsq+yYLR7Wp6DuXJz64qcHJMTAYJZoR4qiIgYbO+1/qa+lI7QOr0L8Q+q
         hifNBjNgd52MVjTY3Dy/Ofw8ebTtUHaq1Bt045pEBqMJFY/a38VHMQseKafjSyyps0u5
         fLEf4ZCse+Tz5jJD22UjblR1nkJYwqEX96MI9k7Bvhw+7NyCeMD6cKr7xMa0WYYM0u8w
         kE7CEWRXxG9jITJt83SKEgYkMHmHW3yzA8xy36tUYKurtylGk8PnYDs9qzPWPMAsL/5V
         Ltx13/At0X7gDKqA3vfMTlLbOsnfXtV9Ba+BGk+GiBBxSrnrAnvn6s9S4sYayryjxsF4
         TpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gfp5Wubi9kJH3jYYB/shKlrSDDynt76ZZ+uDiCu9JDw=;
        b=YIS3D8adu7bwJwkSbrXIb4Ec6DVHIsAER0LdbPHXFxCEPELqIIPRdmXtQl7EyAWLry
         BDLP8OumkHm3HxwmZETdm3mTCOzfNHrUOy2aSiGFzHHBFKZLsjpoGTvChYrLhhuNKH2a
         /3ZcQYnHZ/QRQdMuzGiBhKg5G+8iEQ10I4rquy++nsaqd7spohbW6OfhNHMaoF34P9Au
         AQbTr37BTn9a9Pco52F7gfN/E2olICkAHT5EhbGFXQcXKbfjaKK/d1JGdK5lonhbLdTT
         Ov6DvQjdpKbxwXToou05lCc2+REjkLbXeAGqmsGg8HH3OkXBRcUsQtib9fYumWZb6SIA
         RO5Q==
X-Gm-Message-State: AOAM532SXoMVowKGhuo6VYyQ+/cq2BYGmrD/yVTSllxRMXhJquonC/3n
        Uu/YSO7Lqy1AuOyfvLIUgXZArNAdUNg=
X-Google-Smtp-Source: ABdhPJxKyveeVP9PhpVj3Oe6AXEyGHws55UPuEbPU1/AJXVOMJBIwSuuuJove4lsFdI7sYzKO2S8hA==
X-Received: by 2002:a05:6808:24a:: with SMTP id m10mr4147662oie.95.1612299250111;
        Tue, 02 Feb 2021 12:54:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6sm13208oij.29.2021.02.02.12.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 12:54:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3] hwmon: lm75: Handle broken device nodes gracefully
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210202142113.5456-1-matwey@sai.msu.ru>
 <20210202183737.28747-1-matwey@sai.msu.ru>
 <c0cf9573-74bb-fef9-a14b-7a5eef781c4a@roeck-us.net>
 <CAJs94Ea--d7tW6ZYOjMhHsaXAJZjtivazw+0CAopFmNbYsgAgQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4055b084-6042-2a75-03d0-1c475df81295@roeck-us.net>
Date:   Tue, 2 Feb 2021 12:54:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJs94Ea--d7tW6ZYOjMhHsaXAJZjtivazw+0CAopFmNbYsgAgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 11:31 AM, Matwey V. Kornilov wrote:
> 
> 
> вт, 2 февр. 2021 г. в 22:29, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>:
>>
>> On 2/2/21 10:37 AM, Matwey V. Kornilov wrote:
>> > There is a logical flaw in lm75_probe() function introduced in
>> >
>> >     commit e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")
>> >
>> > Note, that of_device_get_match_data() returns NULL when no match
>> > is found. This is the case when OF node exists but has unknown
>> > compatible line, while the module is still loaded via i2c
>> > detection.
>> >
>> > arch/powerpc/boot/dts/fsl/p2041rdb.dts:
>> >
>> >     lm75b@48 {
>> >       compatible = "nxp,lm75a";
>> >       reg = <0x48>;
>> >     };
>> >
>> > In this case, the sensor is mistakenly considered as ADT75 variant.
>> >
>> > Fixes: e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")
>> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru <mailto:matwey@sai.msu.ru>>
>>
>> Looks good, but we'll also need a solution for the existing devicetree
>> nodes since they are being used. The best solution would probably
>> be to document and add "nxp,lm75a" to the list of devicetree nodes.
>> The same applies to other used but not documented compatible strings
>> (I think you sent a list earlier if I recall correctly).
>>
>> Sorry that I didn't bring this up earlier, but I am concerned that
>> if we don't do this, this patch might be considered a regression.
> 
> 
> What if I just concatenate this patch with the other patch series where "nxp,lm75a" compatible string is introduced?
>  

It just has to be handled in one series, best with the compatible string(s)
introduced first and then this patch as last patch of the series.

Thanks,
Guenter

>>
>>
>> Thanks,
>> Guenter
>>
>> > ---
>> >  Changes since v2:
>> >  * fixed typo in the message
>> >  * fixed brackets
>> >
>> >  drivers/hwmon/lm75.c | 13 ++++++++++---
>> >  1 file changed, 10 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
>> > index e447febd121a..53882c334a0d 100644
>> > --- a/drivers/hwmon/lm75.c
>> > +++ b/drivers/hwmon/lm75.c
>> > @@ -561,10 +561,17 @@ static int lm75_probe(struct i2c_client *client)
>> >       int status, err;
>> >       enum lm75_type kind;
>> >
>> > -     if (client->dev.of_node)
>> > -             kind = (enum lm75_type)of_device_get_match_data(&client->dev);
>> > -     else
>> > +     if (dev->of_node) {
>> > +             const struct of_device_id *match =
>> > +                     of_match_device(dev->driver->of_match_table, dev);
>> > +
>> > +             if (!match)
>> > +                     return -ENODEV;
>> > +
>> > +             kind = (enum lm75_type)(match->data);
>> > +     } else {
>> >               kind = i2c_match_id(lm75_ids, client)->driver_data;
>> > +     }
>> >
>> >       if (!i2c_check_functionality(client->adapter,
>> >                       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>> >
>>
> 
> 
> --
> With best regards,
> Matwey V. Kornilov

