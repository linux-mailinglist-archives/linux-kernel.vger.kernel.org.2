Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F223FCE45
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhHaUT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhHaUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:19:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADABC061575;
        Tue, 31 Aug 2021 13:18:31 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n24so520543ion.10;
        Tue, 31 Aug 2021 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zD2jk9ErOAZNolbqQHEVl04hUOv8D/uzEqonG0UfPIo=;
        b=mpH5oM2SXJ34SXVOgUxRfB5weIx+CX1uTuM+lJX1i+8CDz8M2zimtUhZh/s29zuta+
         e22qDCGwGt8gStZQOkEvfk8gWnnEVyw5I9ZljjvMha9C7dzVtwnXb94PAkZoF+V053W5
         m29wKXP4QOma0KyawwdS+2g2xysC9Vwau3nQhbSj9HjuQ8NDUKgcgSQft3t5bAfZPzMu
         +j8YhFxUfhlvJDvA93NiSmiQb7aluG1VNXBQgx6NCGGIlcC7EjaZi5liqX+LDpLdughL
         wQ79f/Qb1B6E43yXpigqUGfQMpTqsQwlvOURu2627w8D2ddXhvDkYg8uBe1DWBqmlcrc
         IcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zD2jk9ErOAZNolbqQHEVl04hUOv8D/uzEqonG0UfPIo=;
        b=p200p35CO++h5+rXltBs1nZqHnGoB3JHK9g+NjSQbavHA37HkMTzxRHX+TqJOqworf
         034PzMgF3LeLt6KyGlA7gh6l2fbGFFkz/yBtgAFi+TVABdyYw8KKsk9cdcaZp9mf709f
         b7lQbmtPBihNtfTPE3YPHStSQ/2CuL9kNeLDSo+o/pP0yNolo9cNVxJ6INLqPVLEZpkL
         teGWfgYp56oH9tIROcIliCpNh/nem/sGeiXRnwUHdmdSqsR1olQJT33roPWW0GSrOD+b
         oesQj85BPCp4Mz2CWfSxgVwuYD17o5VrYJq2QrnfcGwJi/M0GkOtjtzskmH70U/O8zXN
         2Lpg==
X-Gm-Message-State: AOAM53037UdJX+LbALfHmXwKayuaY7OKGLYehZd/XvM/cmCBbbZS3sRm
        FZNuvz5H7craOLt5PQxaxNOETEhYrxhj7w==
X-Google-Smtp-Source: ABdhPJwxMDE0PK0GnmBrS6FYKYMCEbeISyoYF9IP5FjDDKFlC9n9GUdD4UU2WFGqcvf4XtgQRIBsrw==
X-Received: by 2002:a5d:928c:: with SMTP id s12mr23690427iom.151.1630441110832;
        Tue, 31 Aug 2021 13:18:30 -0700 (PDT)
Received: from [192.168.4.31] (199-48-94-117.rochmnaa.metronetinc.net. [199.48.94.117])
        by smtp.gmail.com with ESMTPSA id u10sm10958269ilg.15.2021.08.31.13.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 13:18:30 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Do not swap max_power_out
To:     Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210827230433.3596370-1-bjwyman@gmail.com>
 <20210828155250.GA820265@roeck-us.net>
 <e9de99d88fb9e2e34552806fa47efa488332325c.camel@linux.ibm.com>
 <cac545d4-3840-898c-4950-8262fea9e2ab@gmail.com>
 <51149737-4ec6-032b-607e-9aaa48951efc@roeck-us.net>
From:   Brandon Wyman <bjwyman@gmail.com>
Message-ID: <e95c8f49-53ea-9319-43e7-3a05f335a0b2@gmail.com>
Date:   Tue, 31 Aug 2021 15:18:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <51149737-4ec6-032b-607e-9aaa48951efc@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-08-30 16:27, Guenter Roeck wrote:
> On 8/30/21 2:07 PM, Brandon Wyman wrote:
>>
>> On 2021-08-30 08:50, Eddie James wrote:
>>> On Sat, 2021-08-28 at 08:52 -0700, Guenter Roeck wrote:
>>>> On Fri, Aug 27, 2021 at 11:04:33PM +0000, Brandon Wyman wrote:
>>>>> The bytes for max_power_out from the ibm-cffps devices do not need
>>>>> to be
>>>>> swapped.
>>>>>
>>>>> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
>>>> Eddie, can you confirm this ?
>>> This can't be true for all the power supplies supported by this driver,
>>> no. I think we need to check the version first. Brandon, I tested this
>>> on witherspoon (which is psu version 1) and get 3148 watts. If it's not
>>> swapped, that would be 19468 watts...
>>>
>>> Thanks,
>>> Eddie
>> I had tested this on a variety of systems with a variety of different 
>> power supplies, but I did *NOT* test this on the Witherspoon power 
>> supplies.
>>
>> This apparently requires a bit more thought to figure out how to 
>> handle the other types and also not get Witherspoon wrong.
>>
>
> Is the specification for those power supplies available in public ?
>
> Thanks,
> Guenter
>
No, unfortunately those power supply specifications are not available to 
the public.

Sorry,

Brandon

>> Thanks for checking Eddie.
>>
>>>> Thanks,
>>>> Guenter
>>>>
>>>>> ---
>>>>>   drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c
>>>>> b/drivers/hwmon/pmbus/ibm-cffps.c
>>>>> index df712ce4b164..29b77f192c9e 100644
>>>>> --- a/drivers/hwmon/pmbus/ibm-cffps.c
>>>>> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
>>>>> @@ -171,7 +171,7 @@ static ssize_t ibm_cffps_debugfs_read(struct
>>>>> file *file, char __user *buf,
>>>>>           cmd = CFFPS_SN_CMD;
>>>>>           break;
>>>>>       case CFFPS_DEBUGFS_MAX_POWER_OUT:
>>>>> -        rc = i2c_smbus_read_word_swapped(psu->client,
>>>>> +        rc = i2c_smbus_read_word_data(psu->client,
>>>>>                            CFFPS_MAX_POWER_OUT_CM
>>>>> D);
>>>>>           if (rc < 0)
>>>>>               return rc;
>>>>> -- 
>>>>> 2.25.1
>>>>>
>
