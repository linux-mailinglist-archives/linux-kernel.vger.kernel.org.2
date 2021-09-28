Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC241AE46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbhI1L5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240381AbhI1L5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632830169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjm7Vjsi8Ok261qADZaLGin7Csvz6AWK9T4SwjSAPz8=;
        b=CeU1wAA51AT6lgEVj+OHNRnLDNX0NSeUJ65Wea11gnWYRVVNZbzIhRYXfWKxIhimi1ZJvb
        bvLkwHdi65fT40f3aJkPBmMrcKMiTjAl/lxJijBkJtY8T/VQkKMf3PzfSeeoSDyTC7svad
        colEZsn1m0pydR3ULQceu5IjTdXR7zg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-HUQ-ryWxO_-wjF5VOoQvKA-1; Tue, 28 Sep 2021 07:56:08 -0400
X-MC-Unique: HUQ-ryWxO_-wjF5VOoQvKA-1
Received: by mail-ed1-f70.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so21496728edy.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rjm7Vjsi8Ok261qADZaLGin7Csvz6AWK9T4SwjSAPz8=;
        b=tFLefB4WvjE5P5vQ/7WjjgaK5FKOEXUlzambakX0bNv203cnn4h6pmIECMmxQSlzRI
         0CCHaNbNz8pyxdC0rI4pNb/7qJKvE0tlvD/BKrNq2/QWRtwUAzqVBdTq8Oaix4L0LndJ
         a1X/dTWfd4FM8aO31FszdBpMhC+kdTfYFi8y9Kq8qsGN0ipveUkHVVCWXYS3Mb5n6ln6
         AEwrCVNSY60x7KQAlGzmJfibntbON90tIpKRMbh0uXUJnn9lCO8O8tt2jHf+JpBWbtZu
         adu46poR7urFDXLa/ofbi5/WLt7ZmyMPdKQjCR4LDLEFmYhG2wZs5B+PfeJTqjxeDRih
         2N1Q==
X-Gm-Message-State: AOAM5316Lw9RbenFLu9Q7yQv/ZM0LKhCHNnVVpuvODGJfKFuoD3+zG+N
        zSxNqdnnIKz5YPepbW5BKCGLGC/OC8ZosnOURztKdH3+ZfiaIzhDkq0IwCwLnzqM1xxfYAFHeaI
        sX+fB0ZkcN3OPwFZtO9LjV4ky
X-Received: by 2002:a50:bec9:: with SMTP id e9mr7113711edk.33.1632830166939;
        Tue, 28 Sep 2021 04:56:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH7yKYuEerR6UE9XimQ1zulbKazvbUFmJoANPIYrxAPb6qFWAqhdNrwSAjGBKWoOLuei0Bkw==
X-Received: by 2002:a50:bec9:: with SMTP id e9mr7113695edk.33.1632830166786;
        Tue, 28 Sep 2021 04:56:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d7sm12925886eds.42.2021.09.28.04.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 04:56:06 -0700 (PDT)
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Luke Jones <luke@ljones.dev>, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, pobrn@protonmail.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
References: <20210907232232.5205-1-luke@ljones.dev>
 <20210907232232.5205-2-luke@ljones.dev>
 <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
 <99750R.GZYR2PKX93HX@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <10be9244-0d89-ef79-08d0-fe7024609ee2@redhat.com>
Date:   Tue, 28 Sep 2021 13:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <99750R.GZYR2PKX93HX@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/21 1:43 PM, Luke Jones wrote:
> Sure, the path is similar to /sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable where hwmon4 will likely be different depending on init, and pwm2_enable is the second fan if it exists. The values are 1,2,3 - where 1 = fan curve enabled/manual, 2 = auto. 3 here is custom extra that writes default curve back then defaults to 2.
> 
> As I understand it, this should be adhering to the accepted kernel standard, so if you use this for ASUS laptops, then it should carry over to other brands that implement it also.

Ah, so this is a bit different then how I thought this would work
(this is probably better though).

<snip>

>>>  The fans have settings [1,2,3] under pwm<N>_enable:
>>>  1. Enable and write settings out
>>>  2. Disable and use factory fan mode
>>>  3. Same as 2, additionally restoring default factory curve.

Quoting Documentation/hwmon/sysfs-interface.rst

`pwm[1-*]_enable`
                Fan speed control method:

                - 0: no fan speed control (i.e. fan at full speed)
                - 1: manual fan speed control enabled (using `pwm[1-*]`)
                - 2+: automatic fan speed control enabled

1 normally means the fans runs at a fixed speed, but you are using it
for the custom/manual profile, which is still a temp<->pwm table,
right?

I guess this make sense since full manual control is not supported
and this keeps "2" aka auto as being the normal factory auto
setting which is good.

Bastien is this interface usable for p-p-d ?

I guess that it is a bit annoying that you need to figure out
the # in the hwmon# part of the path, but there will be only
one hwmon child.

You could also go through /sys/class/hwmon but then you really
have no idea which one to use. Ideally we would have some way
to indicate that there is a hmwon class-dev associated with
/sys/firmware/acpi/platform_profile but as we mentioned before
we should defer coming up with a generic solution for this
until we have more then 1 user, so that we hopefully get the
generic solution right in one go.

Regards,

Hans





>>>
>>>  Use of 2 means that the curve the user has set is still stored and
>>>  won't be erased, but the laptop will be using its default auto-fan
>>>  mode. Re-enabling the manual mode then activates the curves again.
>>>
>>>  Notes:
>>>  - pwm<N>_enable = 0 is an invalid setting.
>>>  - pwm is actually a percentage and is scaled on writing to device.
>>
>> I was trying to update:
>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
>> but I don't understand what files I need to check for what values to
>> detect whether custom fan curves were used.
>>
>> Can you help me out here?
>>
>> Also, was this patch accepted in the pdx86 tree?
>>
>> Cheers
>>
> 
> 

