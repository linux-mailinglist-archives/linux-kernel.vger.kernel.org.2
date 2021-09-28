Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AD41AE00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbhI1LqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231202AbhI1LqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632829476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/GcBGESWCJxTMtY+dJOGbH46SQBzVlIrQjmEWsgv24=;
        b=B7dIhxc6pn7Udp8oRM0CwrqQwJaOgV/OvTbdf6OYtMBqJvo9YaTNezZeyAgshZYbWtjtIt
        kgsK06BaWOkDMeRQVzCK8WNNvAHPBfGarJo8l3gtfVrfCObp2ela7iKXJdZ8LzMHF40NAA
        RaJnRvc9nsGHygs0Q7kLN4GG3/pOmC4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-xuXCuol-Nrebz9wGdjYuQQ-1; Tue, 28 Sep 2021 07:44:34 -0400
X-MC-Unique: xuXCuol-Nrebz9wGdjYuQQ-1
Received: by mail-ed1-f69.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so21392638edv.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/GcBGESWCJxTMtY+dJOGbH46SQBzVlIrQjmEWsgv24=;
        b=PMMJGOVQO9q6KCoMOsfIrzFxCwKN7PVp3Cks9Ezc6E/R+rssL3RjpqQQxprWwpUZDV
         b0oqy/vzu4us+Dn/GctTiNhs3SdVLdvOxm3Ne/wE89lCxySgddt955Z7loZz+rDu7ca5
         mKxoS/e1iIjAV3JPFDpPTMmbdVvTOUMavDP6srSPbRHvyymbUxmh1BaNvU9oPmGaT5h9
         IXlu4Q6lnNw1Xvx7VTPmH9jiIyBjto4SGv3vKWTwfHTm2YoChMLSN4tu3unXQstC8uEh
         4CpQjj/OYE+hobyh46jDBM897iuVERbMrtE3PCPKg6JQK4wQNI8puhaTL4HRPRphtYxk
         ARSw==
X-Gm-Message-State: AOAM530CWICtJsdh3tR1qbhCLxhLwfkaeTO3APlLEryYnpKVG8bGDrrn
        eBH4Cf6tY5YtIBc4QGpSdx/7SlVZwwCb70ZgWzyC0L+P34M9I2VdPfg4hyXLL5BERi+O78hzRla
        kJiG5HLY+dKlsHqbP5hhLq7Kt
X-Received: by 2002:a17:906:2a0a:: with SMTP id j10mr6179707eje.103.1632829473578;
        Tue, 28 Sep 2021 04:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE5bTFxg7e70zPwoN8crEg9Qss0Z9bN015k7W4gUSVrCbbPGG1chnatd83GydGMKgNwfNtQA==
X-Received: by 2002:a17:906:2a0a:: with SMTP id j10mr6179670eje.103.1632829473350;
        Tue, 28 Sep 2021 04:44:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g20sm1377797edw.71.2021.09.28.04.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 04:44:32 -0700 (PDT)
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Bastien Nocera <hadess@hadess.net>,
        "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
References: <20210907232232.5205-1-luke@ljones.dev>
 <20210907232232.5205-2-luke@ljones.dev>
 <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ef22aa1f-288a-4e5a-0210-d62c7fc89307@redhat.com>
Date:   Tue, 28 Sep 2021 13:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/21 1:36 PM, Bastien Nocera wrote:
> On Wed, 2021-09-08 at 11:22 +1200, Luke D. Jones wrote:
>> Add support for custom fan curves found on some ASUS ROG laptops.
>>
>> These laptops have the ability to set a custom curve for the CPU
>> and GPU fans via two ACPI methods.
>>
>> This patch adds two pwm<N> attributes to the hwmon sysfs,
>> pwm1 for CPU fan, pwm2 for GPU fan. Both are under the hwmon of the
>> name `asus_custom_fan_curve`. There is no safety check of the set
>> fan curves - this must be done in userspace.
>>
>> The fans have settings [1,2,3] under pwm<N>_enable:
>> 1. Enable and write settings out
>> 2. Disable and use factory fan mode
>> 3. Same as 2, additionally restoring default factory curve.
>>
>> Use of 2 means that the curve the user has set is still stored and
>> won't be erased, but the laptop will be using its default auto-fan
>> mode. Re-enabling the manual mode then activates the curves again.
>>
>> Notes:
>> - pwm<N>_enable = 0 is an invalid setting.
>> - pwm is actually a percentage and is scaled on writing to device.
> 
> I was trying to update:
> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
> but I don't understand what files I need to check for what values to
> detect whether custom fan curves were used.
> 
> Can you help me out here?

How to deal with this is actually one of my remaining questions too.

I've not looked at the new code closely yet, but if I understand
things correctly, the now code basically only allows to set 1
custom profile and setting that profile overrides the last
profile set through /sys/firmware/acpi/platform_profile.

And any write to /sys/firmware/acpi/platform_profile will
overwrite / replace the last custom set profile (if any) with
the one matching the requested platform-profile.

So basically users of custom fan profiles are expected to
disable power-profiles-daemon or at least to refrain from
making any platform_profile changes.

And if power-profile-daemon is actually active and
makes a change then any custom settings will be thrown away,
IOW p-p-d will always win. So I believe that it no longer needs
to check for custom profiles, since any time it requests a
standard profile that will overwrite any custom profile
which may be present.

Luke, do I have that right ?

> Also, was this patch accepted in the pdx86 tree?

No, I still need to find/make some time to review it and
I still have the same question as you :)

Regards,

Hans

