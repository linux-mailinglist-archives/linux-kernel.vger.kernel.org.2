Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45643FBE44
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhH3V3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhH3V3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:29:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC6C06175F;
        Mon, 30 Aug 2021 14:27:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso9915801otu.0;
        Mon, 30 Aug 2021 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T6rOSktaGUzhxY0lut5nuLyqLxN9lcu2nym2eVvhLi0=;
        b=gAKEtxRUhFHRun4q84Gl+ELrsIYKSOYl4ACu6W5vDC5HwhrAGQaf0Myu8BLfGD0yzH
         bQ6W4cir+6Vg1OjGRyiOwIEBJbpHtmkGbj5uzt31TpMO6LN658abl/KZVgzs9hfC2sfQ
         BSpazCuu/pryRUBx9wv+oVy/gqI9Mc7p2gM0xeX1zaaEMrXvaeFb7xq5FkFWmRsHyl/J
         rURQMqpoDX9PHIqeZPH5NmU4Fbxi9LwlIWIqTe/AY9ZEdXpA0oKIhQDuCkpvmCizlLF/
         Xqj28174v5alPg7WHY1avyn68OEtTiYWs8NGK0umElB3Ga7WMSZQXErSUro3Xfxg/wZ2
         04pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T6rOSktaGUzhxY0lut5nuLyqLxN9lcu2nym2eVvhLi0=;
        b=exRswIujoK/W29Y2E1bJvUXIm9ilDfdeASw/4QCFhfOdyCfoyyqX1oIEWnSoZpoCNi
         sEXDpkqhJ/hS2aP9efhsxMiHLENupDEn0cf2I9N9rZmGjtOns3HFQf+3YebbR1az3gUS
         OYDrJYH3kI29KkMN8raDwkFuQZUtyEyRCNLvmCFlrmbdsDsqisvM4YvabITWSzWeE82h
         oG/VLemzmRPHF7LPKe9QaugaNMj35z7BwCG9stpBFVLa1qoBA/WALwyB8Mcy9VpUeIQy
         AfY1oY/1FWz9YZKAwSgLO3Bxvnjy5vsITWOt0BrctSADSxjfOVqNEB/3yQQzyYkSG+Yk
         bV2w==
X-Gm-Message-State: AOAM5301oTIPapLbOYLZBRWfe/dHAdwuHp/sL0p6MXIZZPB9ZfIsaI1e
        s99r7zWZPaQGVVRk5OKiPxMSoq4Jb2Q=
X-Google-Smtp-Source: ABdhPJwouwHN3AuNACLppRIQkrQrt6jltkPlQJPqmFt33SyskfjwqwVBTzsDEFmiIHTIGnEvfrSBvg==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr21469050ots.169.1630358865244;
        Mon, 30 Aug 2021 14:27:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v24sm2117102oov.18.2021.08.30.14.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 14:27:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Do not swap max_power_out
To:     Brandon Wyman <bjwyman@gmail.com>,
        Eddie James <eajames@linux.ibm.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210827230433.3596370-1-bjwyman@gmail.com>
 <20210828155250.GA820265@roeck-us.net>
 <e9de99d88fb9e2e34552806fa47efa488332325c.camel@linux.ibm.com>
 <cac545d4-3840-898c-4950-8262fea9e2ab@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <51149737-4ec6-032b-607e-9aaa48951efc@roeck-us.net>
Date:   Mon, 30 Aug 2021 14:27:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cac545d4-3840-898c-4950-8262fea9e2ab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 2:07 PM, Brandon Wyman wrote:
> 
> On 2021-08-30 08:50, Eddie James wrote:
>> On Sat, 2021-08-28 at 08:52 -0700, Guenter Roeck wrote:
>>> On Fri, Aug 27, 2021 at 11:04:33PM +0000, Brandon Wyman wrote:
>>>> The bytes for max_power_out from the ibm-cffps devices do not need
>>>> to be
>>>> swapped.
>>>>
>>>> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
>>> Eddie, can you confirm this ?
>> This can't be true for all the power supplies supported by this driver,
>> no. I think we need to check the version first. Brandon, I tested this
>> on witherspoon (which is psu version 1) and get 3148 watts. If it's not
>> swapped, that would be 19468 watts...
>>
>> Thanks,
>> Eddie
> I had tested this on a variety of systems with a variety of different power supplies, but I did *NOT* test this on the Witherspoon power supplies.
> 
> This apparently requires a bit more thought to figure out how to handle the other types and also not get Witherspoon wrong.
> 

Is the specification for those power supplies available in public ?

Thanks,
Guenter

> Thanks for checking Eddie.
> 
>>> Thanks,
>>> Guenter
>>>
>>>> ---
>>>>   drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c
>>>> b/drivers/hwmon/pmbus/ibm-cffps.c
>>>> index df712ce4b164..29b77f192c9e 100644
>>>> --- a/drivers/hwmon/pmbus/ibm-cffps.c
>>>> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
>>>> @@ -171,7 +171,7 @@ static ssize_t ibm_cffps_debugfs_read(struct
>>>> file *file, char __user *buf,
>>>>           cmd = CFFPS_SN_CMD;
>>>>           break;
>>>>       case CFFPS_DEBUGFS_MAX_POWER_OUT:
>>>> -        rc = i2c_smbus_read_word_swapped(psu->client,
>>>> +        rc = i2c_smbus_read_word_data(psu->client,
>>>>                            CFFPS_MAX_POWER_OUT_CM
>>>> D);
>>>>           if (rc < 0)
>>>>               return rc;
>>>> -- 
>>>> 2.25.1
>>>>

