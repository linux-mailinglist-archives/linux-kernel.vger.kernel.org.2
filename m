Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF033D7E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhG0TYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231947AbhG0TYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627413882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hl/cGiqEzAVU0rHKnG8g1nyuMD2yVgSkAScv15/clJ8=;
        b=iV7QCClHKxj989ssfRDHBHDjqMR0D4az6uCznMGSqp4G2YUK9C2q7hsw0edKEpiYs2/+8l
        9Zr5k2eqzdqdAc4iOFMJykJccj/jxJ2UGcRePgkPTqHDAqWTxIOU74/cjg70mPQOitvWYV
        voXkYI9fh/H9soysHAPVzg8v36r78jI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-1bJ_0O0_OFutZ2YGCPbkXg-1; Tue, 27 Jul 2021 15:24:41 -0400
X-MC-Unique: 1bJ_0O0_OFutZ2YGCPbkXg-1
Received: by mail-ed1-f70.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso7081493edh.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hl/cGiqEzAVU0rHKnG8g1nyuMD2yVgSkAScv15/clJ8=;
        b=moPJaTKRDc7OsOl1+yCcd4T4CoHwJGcl4b+4e55zVI5lrVpvgdvuPIEj0DcA/UrHNv
         7FIteRQdEs33iwF6TmDpK+a+9BaxUG+/WMDKLsql9DbHAsl340z82trPTuOZdC+q9IpB
         NySu+b1IjY+0ZJ5dtDT7eG5NtGoD3q+XVw43D5xMk9TnroMAPIxFmxItPSTPSuy9lV8t
         y2GJfq0HL/bZkDmllHLlIvnrr24SDRmo8tE+NOUFmjp3657Otb4Xab2MwQRgSk0wLq0Q
         wo+2Dnb9agcZIB9bC3fJGWuzZNVSz84sdnfpMqfu9Onp7pXIHdkTETy5dShmcYTMDrMq
         +TOQ==
X-Gm-Message-State: AOAM531dkwqm0e9Iezr6qqEn4ZJsXilwI/25rb7ziH4bRDhXJdwB8hBF
        iUo2JSWul0AqA6Jd/StLJwyxbS2nktjrad+qvfEPapSbePMuBIpi/+SJ+0k1z6TYM+vr/Ie1pjC
        0rqhIzqfLzMhTI4naNrzY6setv2N/Te0M8uIZ4pTW8elsDnuIQSQ5z/2siZmVA+wKB4YqXZd1nz
        7+
X-Received: by 2002:a05:6402:28a4:: with SMTP id eg36mr9380447edb.84.1627413880127;
        Tue, 27 Jul 2021 12:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD01JP8SbHHK2+TtyUSp9PH9gcDvS1+ptAFI+fEqr3JDz3+Z/mXkz1Rd1PX8vv5wVguoboYg==
X-Received: by 2002:a05:6402:28a4:: with SMTP id eg36mr9380435edb.84.1627413879995;
        Tue, 27 Jul 2021 12:24:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id de19sm1635481edb.6.2021.07.27.12.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 12:24:39 -0700 (PDT)
Subject: Re: [PATCH] mfd: axp20x: Add supplied-from property to
 axp288_fuel_gauge cell
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, C++ / GCC <cpp@gcc.lt>,
        linux-kernel@vger.kernel.org
References: <20210717162528.272797-1-hdegoede@redhat.com>
 <YPVYc/mFKX14s1Yr@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a9fbf785-0dab-2e55-5983-ea279f8dc3a2@redhat.com>
Date:   Tue, 27 Jul 2021 21:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPVYc/mFKX14s1Yr@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 7/19/21 12:48 PM, Lee Jones wrote:
> On Sat, 17 Jul 2021, Hans de Goede wrote:
> 
>> The power-supply framework has the notion of one power-supply device
>> being supplied by another. A typical example of this is a charger
>> charging a battery.
>>
>> A tablet getting plugged in to charge (or plugged out) only results in
>> events seen by the axp288_charger device / MFD cell. Which means that
>> a change udev-event only gets send for the charger power-supply class
>> device, not for the battery (the axp288_fuel_gauge device).
>>
>> The axp288_fuel_gauge does have an external_power_change'd callback
>> which will generate a change udev-event when called. But before this
>> commit this never got called because the power-supply core only calls
>> this when a power-supply class device's supplier changes and the
>> supplier link from axp288_charger to axp288_fuel_gauge was missing.
>>
>> Add a "supplied-from" property to axp288_fuel_gauge cell, pointing
>> to the "axp288_charger" power-supply class device, so that the
>> axp288_fuel_gauge's external_power_change'd callback gets called on
>> axp288_charger state changes.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mfd/axp20x.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index d0ac019850d1..8161a5dc68e8 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -700,6 +700,18 @@ static const struct resource axp288_charger_resources[] = {
>>  	DEFINE_RES_IRQ(AXP288_IRQ_CBTO),
>>  };
>>  
>> +static const char * const axp288_fuel_gauge_suppliers[] = { "axp288_charger" };
>> +
>> +static const struct property_entry axp288_fuel_gauge_properties[] = {
>> +	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", axp288_fuel_gauge_suppliers),
>> +	{ }
>> +};
>> +
>> +static const struct software_node axp288_fuel_gauge_sw_node = {
>> +	.name = "axp288_fuel_gauge",
>> +	.properties = axp288_fuel_gauge_properties,
>> +};
>> +
>>  static const struct mfd_cell axp288_cells[] = {
>>  	{
>>  		.name		= "axp288_adc",
>> @@ -717,6 +729,7 @@ static const struct mfd_cell axp288_cells[] = {
>>  		.name		= "axp288_fuel_gauge",
>>  		.num_resources	= ARRAY_SIZE(axp288_fuel_gauge_resources),
>>  		.resources	= axp288_fuel_gauge_resources,
>> +		.swnode		= &axp288_fuel_gauge_sw_node,
>>  	}, {
>>  		.name		= "axp221-pek",
>>  		.num_resources	= ARRAY_SIZE(axp288_power_button_resources),
> 
> That's a lot of code to pass a string.
> 
> Is this really the most efficient method?

Currently there is no other method to provide information about the supplier
consumer relation for non device-tree platforms (in device-tree platforms
this info is present inside the device-tree), so yes this is the most
efficient method available.

Regards,

Hans

