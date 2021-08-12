Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DC33E9BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhHLAld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhHLAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:41:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BFCC061765;
        Wed, 11 Aug 2021 17:41:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id w197so4638197qkb.1;
        Wed, 11 Aug 2021 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hbfvVge12xVCxobyeYjszV9eiBtTs7pNE52AeEkb8Co=;
        b=pRVFKKI1+hNqJTo4iFD7BFfnhkTV1JuHmKsTFvtwZBTOlGwiXo0TQ6nnOaCl2DJ25r
         wvgj9LEjHiq8zuijSE0v3tbM4h6ewzYfh6uk3EZoYHz9Euu31G0zZHDs/KRt+ISWBNna
         Wc511tYsWF6jo8+GByA4bJECnUueRsKQsyZuq02jbB3opLpe/aP7kT/K5/WYk4bwR7Mu
         NeljhZhAcWWslNn0HCDh9lI8eaLqzWH+GGwlx3gcr5rgyaQrxMam7YnouREpQftRkvGl
         FgvFl6ReGzo5Td4oxlVX9Ejg0RYmmQPUPWo0KlyUfn1ociRbdLHO4u68kMV/tLSbczWc
         0H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbfvVge12xVCxobyeYjszV9eiBtTs7pNE52AeEkb8Co=;
        b=SrBaKufa3DBdNYqYN0Or7MsWuckxy2mslh198d+01/y6fuvcBptYTyAicaYeeF5dDC
         u0rY8l0bs8SmtRLbRmXyYK/HB+wlpuNwssIYag21ZWChWZj2D8GGMIAcAoRAk2WMtk1z
         B81q4nFMJ4Zz3kgek9xlRLLbzj5hKsSpEdwmvz710x54RwsVuW54njTHbFPYUEeHukrX
         IZMD67E4qujQPnzTtXzIP42ZOe9V5rhB0JV2syvcgL2BuSisvMf6GkXYpHNpCFaOCs7G
         1H6vH7JD03e88XQ5TAuabyGbEksMylI3nl944Q7tFu2EjM4jAj4B3k4cCX7frIr8Ag+f
         kU1w==
X-Gm-Message-State: AOAM533DmEvlccyx9jqkdUDyFIMLc9TIeHe6aLnUJmR/koSxnc5hEj5M
        owTpJDKyN21rAskFoRoXikMsFr+HJos=
X-Google-Smtp-Source: ABdhPJzm3NLGvXxD5pWXL8BV2fBwL8vqf5e+4/p1FGd6eEENubDdxUkh9+fE1ZtJM1136RXbzy//OQ==
X-Received: by 2002:a05:620a:22b:: with SMTP id u11mr1891332qkm.423.1628728865746;
        Wed, 11 Aug 2021 17:41:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18sm396806qtq.16.2021.08.11.17.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 17:41:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for incorrect
 Pin max
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <20210811041738.15061-3-chris.packham@alliedtelesis.co.nz>
 <20210811195327.GA966160@roeck-us.net>
 <b02c3a4d-4d91-0506-7833-6266efc0a2fc@alliedtelesis.co.nz>
 <20210811231805.GA1095781@roeck-us.net>
 <f6d3654f-c1b1-65d2-2593-392e2cc2f0d2@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e86b8a83-bb5d-6d9b-298f-67a772e17539@roeck-us.net>
Date:   Wed, 11 Aug 2021 17:41:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f6d3654f-c1b1-65d2-2593-392e2cc2f0d2@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 4:25 PM, Chris Packham wrote:
> 
> On 12/08/21 11:18 am, Guenter Roeck wrote:
>> On Wed, Aug 11, 2021 at 10:19:44PM +0000, Chris Packham wrote:
>>> On 12/08/21 7:53 am, Guenter Roeck wrote:
>>>> On Wed, Aug 11, 2021 at 04:17:38PM +1200, Chris Packham wrote:
>>>>> BPD-RS600 modules running firmware v5.70 misreport the MFR_PIN_MAX.
>>>>> The indicate a maximum of 1640W instead of 700W. Detect the invalid
>>>>> reading and return a sensible value instead.
>>>>>
>>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>>> ---
>>>>>     drivers/hwmon/pmbus/bpa-rs600.c | 21 ++++++++++++++++++++-
>>>>>     1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
>>>>> index d495faa89799..f4baed9ce8a4 100644
>>>>> --- a/drivers/hwmon/pmbus/bpa-rs600.c
>>>>> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
>>>>> @@ -65,6 +65,24 @@ static int bpa_rs600_read_vin(struct i2c_client *client)
>>>>>     	return ret;
>>>>>     }
>>>>>     
>>>>> +/*
>>>>> + * The firmware on some BPD-RS600 models incorrectly reports 1640W
>>>>> + * for MFR_PIN_MAX. Deal with this by returning a sensible value.
>>>>> + */
>>>>> +static int bpa_rs600_read_pin_max(struct i2c_client *client)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>> +	if (ret == 0x0b34)
>>>>> +		return 0x095e;
>>>> The comments from the descriotion need to be here.
>>> will update
>>>> Thanks,
>>>> Guenter
>>>>
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>>     static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>>>>>     {
>>>>>     	int ret;
>>>>> @@ -92,7 +110,8 @@ static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int pha
>>>>>     		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IOUT_MAX);
>>>>>     		break;
>>>>>     	case PMBUS_PIN_OP_WARN_LIMIT:
>>>>> -		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
>>>>> +	case PMBUS_MFR_PIN_MAX:
>>>>> +		ret = bpa_rs600_read_pin_max(client);
>>>> So the idea is to return the same value for PMBUS_PIN_OP_WARN_LIMIT
>>>> (max_alarm) and PMBUS_MFR_PIN_MAX (rated_max) ? That doesn't really
>>>> make sense. The meaning of those limits is distinctly different.
>>> For the BPA-RS600/BPD-RS600 these appear to be treated the same.
>> What a mess.
> *sigh* I know. I've also got another 2 BluTek supplies I haven't got
> round to dealing with yet.
>> This needs to be documented in the driver, including the
>> behavior if any of those attributes is written into.
> 
> Mercifully these attributes are all read-only. So at least we don't have
> to deal with that.
> 
Ok.

> It's probably not too late to return -ENXIO for the WARN_LIMITs and have
> lm-sensors display the rated_max (we also have a custom consumer of the
> sysfs API that I'd need to sort out).
> 

That would indeed be much better if it works for you.

Thanks,
Guenter

>>
>> Guenter
>>
>>>> Guenter
>>>>
>>>>>     		break;
>>>>>     	case PMBUS_POUT_OP_WARN_LIMIT:
>>>>>     		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_POUT_MAX);
>>>>> -- 
>>>>> 2.32.0
>>>> >

