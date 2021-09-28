Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7041AE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbhI1MKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240352AbhI1MKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632830944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrMZ42g/G3Kkz26yMPZtqroMl+g6CgMq/DrfJClCp8w=;
        b=HsIrCTjdCPEzxX93I6wP3YVH4/SlILN6ca+2T3a2+olebOdi9skqctP/niiXIadR3lspQt
        4mm/rdkM2lWiopCD+DX3ID1N0V7HMp1S9s0tyAlde2MCcKiggp0EPA/cUiKRS6dLYEBZb/
        Cdv7eAIuVjXKA89qgwJdhguBPilOYTQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-lDsaUIGdOyS8VoWTyr2CWA-1; Tue, 28 Sep 2021 08:09:03 -0400
X-MC-Unique: lDsaUIGdOyS8VoWTyr2CWA-1
Received: by mail-ed1-f72.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso21568248edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TrMZ42g/G3Kkz26yMPZtqroMl+g6CgMq/DrfJClCp8w=;
        b=WyKmhnzumxeOQ3RWmIQXJwWUw4Dlo6ThwIerV1NZbPFind1P12P2z3QHKdsZEGAYwo
         oYyA/5dm0fOofRw8ZQY4w8rAw3yGws4nrJ1Sh+DRL3ZAWuvKuC4zyVFze4KGVGvwte0V
         1eCjVblvYAqUbspvx/fFhB6pMS0XMhgGqj8HPdIXNawVoV6r3rpxof5+3HJf+QnB3axV
         D6GX9BvLNSxYozDQX0vT68ycMFz1ZN3NHV7c4Yv2qrwl6OMjh0Nx52kZmuoZL0FdUt5W
         wWbgG7Kxh72Lsa+/e/EABF364ceNI3XXqqMsMThofrU2TSefqt2D5scbQt/fZOJK8Tk6
         nKVQ==
X-Gm-Message-State: AOAM532E4MyVyVqoJ/WGtRsnet7OuKxE2LyUHvVq9Xt2DZUhMWroulRf
        EQ6C9vFEZOyAxKAFEQlNNObKnEjGJfsrnpcxYH8VPvjoMqglkErWdui8rT0gAeO6Q2OEuTcXHaE
        YbnlDWSaajdHlgc4evfUd+4iV
X-Received: by 2002:a17:907:e91:: with SMTP id ho17mr2782016ejc.287.1632830635197;
        Tue, 28 Sep 2021 05:03:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE1hWUA634mQtZ+6fBawrpxRt9f5U+RYXzP767pfFl9nRwH1KVSbGCqC4TA3dHZBG9VmuQ2A==
X-Received: by 2002:a17:907:e91:: with SMTP id ho17mr2781996ejc.287.1632830635003;
        Tue, 28 Sep 2021 05:03:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s11sm12867225edy.64.2021.09.28.05.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:03:54 -0700 (PDT)
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Luke Jones <luke@ljones.dev>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
References: <20210907232232.5205-1-luke@ljones.dev>
 <20210907232232.5205-2-luke@ljones.dev>
 <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
 <99750R.GZYR2PKX93HX@ljones.dev>
 <10be9244-0d89-ef79-08d0-fe7024609ee2@redhat.com>
 <NY750R.JRUHTBKNLH1F1@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <461e3768-7c6d-7351-3482-2545ad0af754@redhat.com>
Date:   Tue, 28 Sep 2021 14:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <NY750R.JRUHTBKNLH1F1@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/21 1:59 PM, Luke Jones wrote:
> 
> 
> On Tue, Sep 28 2021 at 13:56:05 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 9/28/21 1:43 PM, Luke Jones wrote:
>>>  Sure, the path is similar to /sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable where hwmon4 will likely be different depending on init, and pwm2_enable is the second fan if it exists. The values are 1,2,3 - where 1 = fan curve enabled/manual, 2 = auto. 3 here is custom extra that writes default curve back then defaults to 2.
>>>
>>>  As I understand it, this should be adhering to the accepted kernel standard, so if you use this for ASUS laptops, then it should carry over to other brands that implement it also.
>>
>> Ah, so this is a bit different then how I thought this would work
>> (this is probably better though).
>>
>> <snip>
>>
>>>>>   The fans have settings [1,2,3] under pwm<N>_enable:
>>>>>   1. Enable and write settings out
>>>>>   2. Disable and use factory fan mode
>>>>>   3. Same as 2, additionally restoring default factory curve.
>>
>> Quoting Documentation/hwmon/sysfs-interface.rst
>>
>> `pwm[1-*]_enable`
>>                 Fan speed control method:
>>
>>                 - 0: no fan speed control (i.e. fan at full speed)
>>                 - 1: manual fan speed control enabled (using `pwm[1-*]`)
>>                 - 2+: automatic fan speed control enabled
>>
>> 1 normally means the fans runs at a fixed speed, but you are using it
>> for the custom/manual profile, which is still a temp<->pwm table,
>> right?
>>
>> I guess this make sense since full manual control is not supported
>> and this keeps "2" aka auto as being the normal factory auto
>> setting which is good.
>>
>> Bastien is this interface usable for p-p-d ?
>>
>> I guess that it is a bit annoying that you need to figure out
>> the # in the hwmon# part of the path, but there will be only
>> one hwmon child.
>>
>> You could also go through /sys/class/hwmon but then you really
>> have no idea which one to use. Ideally we would have some way
>> to indicate that there is a hmwon class-dev associated with
>> /sys/firmware/acpi/platform_profile but as we mentioned before
>> we should defer coming up with a generic solution for this
>> until we have more then 1 user, so that we hopefully get the
>> generic solution right in one go.
> 
> If it's at all helpful, I named the interface as "asus_custom_fan_curve". I use this to verify I have the correct hwmon for asusctl. Open to suggestions on that.

Ah yes, that means the interface could be looked up through /sys/class/hwmon
too, that is probably the safest route to go then, as the
/sys/devices/platform/asus-nb-wmi/ path might change if we e.g. ever
convert the asus-wmi code to use the new wmi bus interface.

Now that you have confirmed that any writes to
/sys/firmware/acpi/platform_profile override any custom profiles
I wonder if p-p-d needs to take this into account at all though.

The easiest way to deal with this in p-p-d, is just to not deal
with it at all...    If that turns out to be a bad idea, we
can always reconsider and add some special handling to p-p-d for
this later.

Regards,

Hans

