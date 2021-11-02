Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132C64438BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKBWwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhKBWwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635893408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMXDJ1TPpIpn3w6SGHe+O23bhwkvcD2ThXDJ734AXLg=;
        b=FYtOoSuHGrWIWJ7s46DEdqTk6k9twit9duBZutYvlI+vLJmPVkskNWJdQa4ALZ6M3ix2mp
        jOcs1evG4pdvhzWlXco45/20iHrRuuuoP5HVYfcWHf+TUoUN/WkuzPgYg/D8D2ed6sjO3u
        J2NinMKIHOdUawRAVqig/ikMUrxjTlw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-ZvM0qGG5NiaAisvQfePClQ-1; Tue, 02 Nov 2021 18:50:03 -0400
X-MC-Unique: ZvM0qGG5NiaAisvQfePClQ-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640240d400b003dce046ab51so766822edb.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 15:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fMXDJ1TPpIpn3w6SGHe+O23bhwkvcD2ThXDJ734AXLg=;
        b=8DoQLUK1eTynx9jL7nIqYkbw+qgXoxkcoYqDN3BFjc3FduC1mHRjFmqXi32Kb+jHxR
         wZkTrowuXDfrV9Dpyeocfba/SDJB24yO8CWMFd0+BCyxygyX5RmieGc7AtGiTEujRhu3
         fk27LqA1qHR08MoQ4J8aVjbN/0Nr+Yr2Ro/xAbyGEERaXLTN6PBguyYKw1o4haArwEPx
         kviGfqXMBC+2IhOp3kEwaOoRbxQF8RCaSXZD4RkEpTcE0wULZBywaANnz43fpt3EwONz
         uWHitBg3/CgGg9eeFbH5Gr+48HNWqvrmhutqzk/EoQEtawR0SS3rC23iU7wXV3U+HeFJ
         uL5g==
X-Gm-Message-State: AOAM533y0Ch3eZ3aHwp3W6Ua6sVmMcDaB1OZVEBa7aLqUN3CWd2wOXNI
        yyaBVjPlq46rTPYOBOK6j6QQkhDIJGiET3SqtowvbmZLLXSp5CCJvyUU4S/FzB/463sBiQoL/jr
        kZBuZKbgpYQHBTXv5aWoAnKY6
X-Received: by 2002:a05:6402:d59:: with SMTP id ec25mr31128468edb.214.1635893402045;
        Tue, 02 Nov 2021 15:50:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvBLodOSLu5Kq97Smd47uhb24ifUvlhre7oO0RKS63qU7RqbIA2l2rnERIbXVcB7N0SNeKUA==
X-Received: by 2002:a05:6402:d59:: with SMTP id ec25mr31128445edb.214.1635893401899;
        Tue, 02 Nov 2021 15:50:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gb2sm141913ejc.52.2021.11.02.15.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 15:50:01 -0700 (PDT)
Message-ID: <812ff68b-2b4a-3993-245a-ea791e6caf7c@redhat.com>
Date:   Tue, 2 Nov 2021 23:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] backlight: lp855x: Add support ACPI enumeration
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211101185518.306728-1-hdegoede@redhat.com>
 <20211101185518.306728-3-hdegoede@redhat.com>
 <20211102122253.s4oc2p7hmy7w2qgn@maple.lan>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211102122253.s4oc2p7hmy7w2qgn@maple.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the quick review of this series.

On 11/2/21 13:22, Daniel Thompson wrote:
> On Mon, Nov 01, 2021 at 07:55:17PM +0100, Hans de Goede wrote:
>> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
>> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
>> "XMCC0001", add support for this.
>>
>> Note the new "if (id)" check also fixes a NULL pointer deref when a user
>> tries to manually bind the driver from sysfs.
>>
>> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
>> so the lp855x_parse_acpi() call will get optimized away.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/video/backlight/lp855x_bl.c | 70 ++++++++++++++++++++++++-----
>>  1 file changed, 60 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
>> index d1d27d5eb0f2..f075ec84acfb 100644
>> --- a/drivers/video/backlight/lp855x_bl.c
>> +++ b/drivers/video/backlight/lp855x_bl.c
>> @@ -338,10 +339,6 @@ static int lp855x_parse_dt(struct lp855x *lp)
>>  		return -EINVAL;
>>  	}
>>  
>> -	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> -	if (!pdata)
>> -		return -ENOMEM;
>> -
>>  	of_property_read_string(node, "bl-name", &pdata->name);
>>  	of_property_read_u8(node, "dev-ctrl", &pdata->device_control);
>>  	of_property_read_u8(node, "init-brt", &pdata->initial_brightness);
> 
> Shouldn't there be a removal of an `lp->pdata = pdata` from somewhere in
> this function?

Ack, fixed for v2.

>> @@ -379,8 +376,31 @@ static int lp855x_parse_dt(struct lp855x *lp)
>>  }
>>  #endif
>>  
>> +static int lp855x_parse_acpi(struct lp855x *lp)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * On ACPI the device has already been initialized by the firmware
> 
> Perhaps nitpicking but ideally I'd like "and is in register mode" here 
> since I presume it can also be assumed that everything with this HID
> has adopted that).

Nope not nitpicking, that is a good point, also fixed for v2.

Regards,

Hans

