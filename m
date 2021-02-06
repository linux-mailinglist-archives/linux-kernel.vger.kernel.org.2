Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0EC311EF1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBFQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 11:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhBFQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:55:35 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C62C061756;
        Sat,  6 Feb 2021 08:54:55 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id u66so9137818oig.9;
        Sat, 06 Feb 2021 08:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:references:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t7LWk3fuhpB3iSPfRxS8n3m0KkkANHMzTxE3Vzuctms=;
        b=TF7CsRzvACrhtC7PRos8J+ThD+MSLtuHlSqW4bbBLwcxGnXcZ/DjUMAUG/mehV2AJu
         qfu5q3TGIikX77FYZ6WiMogLi5+7vPTgZXQsXiwBlRNpARFNtejecDmeqooQ8ebCp3rN
         BllD/BtrbC45Qu5sBEmSAVlWH7u/2y0M0qgNImxUTwVv1nXt6vW+XVWV5oc1vtQkM4Wa
         UfF85NUcFm7t9fWkpiBp3Gwviu9CMHursUxW+mPDabEDL0tdT5sDHxsoRxa1AlCBgPQt
         uauJ+ognGcKkvyPF0oFUkZEH1+0SwX9D2Q96Bs7oN27m0L7N/ssju7aysFhWkXvtSfwj
         vLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t7LWk3fuhpB3iSPfRxS8n3m0KkkANHMzTxE3Vzuctms=;
        b=d/11kLgkLmGsTZg4LER2oDiokh6rczf5ON4HCjP0scpZhycPPzMpNyFv2OPG+TMs1n
         fAzeNf6VKfgRweTeIyHGglLTRxE625L5DxHp9O0Utx7FpfnITRhLfC9xXhXzoo/Q00jf
         JO0UmtpJdMKjdidkaGKvE2XVNu9UKO2I9PKm8/+coF02gw76O+aFJ+rVjQZ/8X8Sgh1v
         sYyxWNAWush/PQWAejdw4c5ilBUIYCTZ/Q71bu7NjnmV41Bo6mlVzyYRTTAL7VDEsl/L
         S6lUem1uKCK6QUEdWUhHVoW11c2GZbyp9eAKVk8rvYsfKxHgX8GNHpl661Z/nVopSk5J
         FUZw==
X-Gm-Message-State: AOAM532b4b9Jq7Xcs115HpMLsMeQvRp6DZQ8uZr3vwIx1MB79pzUv7Fd
        UocGBLlpKZwwcKxZU9TkWkjzGwTC0mQ=
X-Google-Smtp-Source: ABdhPJymez97uJVyJmUzNG8ahXAfEf5w1sEGyW1kJhxOCbVPi/TiIS1A6maaO+32fFekzON9Cyi8WA==
X-Received: by 2002:a54:4886:: with SMTP id r6mr6517971oic.54.1612630494552;
        Sat, 06 Feb 2021 08:54:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s189sm2493743oif.19.2021.02.06.08.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 08:54:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 2/4] hwmon: lm75: Add nxp,lm75a to of_match list
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
 <20210206095121.20625-1-matwey@sai.msu.ru>
 <20210206095121.20625-3-matwey@sai.msu.ru>
 <cea0ffc3-9fd9-28b1-95f3-b6bee96137fc@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <358d0b0d-6a2d-7e7f-1962-7af3fa939f8a@roeck-us.net>
Date:   Sat, 6 Feb 2021 08:54:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cea0ffc3-9fd9-28b1-95f3-b6bee96137fc@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/21 8:48 AM, Guenter Roeck wrote:
> On 2/6/21 1:51 AM, Matwey V. Kornilov wrote:
>> NXP LM75A is compatible with original LM75A while it has improved
>> 11-bit precision.
>>
>> https://www.nxp.com/docs/en/data-sheet/LM75A.pdf
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>>  Documentation/devicetree/bindings/hwmon/lm75.yaml |  1 +
>>  drivers/hwmon/lm75.c                              | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
>> index aec8edd1e0c6..8c3848f4c277 100644
>> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
>> @@ -22,6 +22,7 @@ properties:
>>        - national,lm75
>>        - national,lm75a
>>        - national,lm75b
>> +      - nxp,lm75a

We'll also need nxp,lm75b because that is distinctly different to
national,lm75b / ti,lm75b. Also, we'll need to fix the entry for
those to reflect that the sensor resolution is only 9 bit, not
11 bit as currently claimed.

Thanks,
Guenter

>>        - maxim,max6625
>>        - maxim,max6626
>>        - maxim,max31725
>> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
>> index 08cde1c446db..9c54c7d86771 100644
>> --- a/drivers/hwmon/lm75.c
>> +++ b/drivers/hwmon/lm75.c
>> @@ -33,6 +33,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>>  	lm75,
>>  	lm75a,
>>  	lm75b,
>> +	nxp_lm75,
> 
> Please make this lm75a_nxp for improved alphabetical alignment
> and to reflect that it is LM75A.
> 
>>  	max6625,
>>  	max6626,
>>  	max31725,
>> @@ -182,6 +183,11 @@ static const struct lm75_params device_params[] = {
>>  		.default_resolution = 11,
>>  		.default_sample_time = MSEC_PER_SEC / 10,
>>  	},
>> +	[nxp_lm75] = {
>> +		.default_resolution = 11,
>> +		.default_sample_time = MSEC_PER_SEC / 10,
>> +		.resolution_limits = 9,
>> +	},
>>  	[max6625] = {
>>  		.default_resolution = 9,
>>  		.default_sample_time = MSEC_PER_SEC / 7,
>> @@ -644,6 +650,7 @@ static const struct i2c_device_id lm75_ids[] = {
>>  	{ "lm75", lm75, },
>>  	{ "lm75a", lm75a, },
>>  	{ "lm75b", lm75b, },
>> +	{ "nxp_lm75a", nxp_lm75, },
>>  	{ "max6625", max6625, },
>>  	{ "max6626", max6626, },
>>  	{ "max31725", max31725, },
>> @@ -703,6 +710,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>>  		.compatible = "national,lm75b",
>>  		.data = (void *)lm75b
>>  	},
>> +	{
>> +		.compatible = "nxp,lm75a",
>> +		.data = (void *)nxp_lm75
>> +	},
>>  	{
>>  		.compatible = "maxim,max6625",
>>  		.data = (void *)max6625
>>
> 

