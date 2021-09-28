Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587AD41AE55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhI1MBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240491AbhI1MBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632830375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAoG+j8UKMenUQnqu15XTOWrPN4U2+w1VHziEgbKg4k=;
        b=Co9y+vwJ9UgAZ7dbNUfVNnEFviRQ65dUY1HJCadVZ6PlZEIJRBh+uWm9d8Y/SaUHONsQpV
        L6HGTZN+VGYfcf7Yo3v1GHEqQ0/mB8xAuK6aC07xjeZCRPlVWqBsrUWLjAAckRkmWzReAw
        +ELA6Kl1eWJV/sLhJ4EloJovJ7lCXnc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-1autF3BINwSUV8QV5ITgOg-1; Tue, 28 Sep 2021 07:59:34 -0400
X-MC-Unique: 1autF3BINwSUV8QV5ITgOg-1
Received: by mail-ed1-f71.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so21505581edy.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qAoG+j8UKMenUQnqu15XTOWrPN4U2+w1VHziEgbKg4k=;
        b=s+41U1M7881yOPuMqGZSonSH6+Vpv/dQUQJLz8jjlwkBDrMQLfgf34AgmU6GYv/Z8+
         C3VPgOwj+AeBOniRQSQyykuRwQAAVNHulUASLJP2N2k4DLX7I8HgCWyhIbdgnR/+6l9E
         HgzAjQxe4w7eZDz9p9Ex+fzTjJmuDlLwzWtSEKq1L0VbqpHGXMk9EePYU8j/XiIqHXqa
         TclWJEuJ4u9rWrV3QyvZkBGVRyT2YBUV2pmxO2U0WrQZKMlIR9y0aQECED5XG6ogS4+W
         Wjh91HmjYa4h/MtIGME62hf89Okf+xe/m3YugUhYcUtZQD2QH5pyOGcy7gjc03kNJktk
         m9rQ==
X-Gm-Message-State: AOAM531WrNFp1p2Tx2P2Y8zZque+UpmO+mGNTCJl0DyNhyc8E3pfvXnj
        OEKgGgOOWk+c7lpQqk/9+wNpm/0X6xa/uQh5EXqSF1wW0L3Pe3DH5Ot44tYEK+/hgBe50bxm/Cn
        FPkTMCKzR8oivZXbrFsU+bkit
X-Received: by 2002:a50:c949:: with SMTP id p9mr7211707edh.326.1632830372993;
        Tue, 28 Sep 2021 04:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy85bhb7l4Z3bR/ctw6qoHoDN25ubj8Jgy1YzcuauMVNO97EAc8CWGKruyqOZk6ws/R1jf2Hg==
X-Received: by 2002:a50:c949:: with SMTP id p9mr7211679edh.326.1632830372839;
        Tue, 28 Sep 2021 04:59:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l8sm10302505ejn.103.2021.09.28.04.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 04:59:32 -0700 (PDT)
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Luke Jones <luke@ljones.dev>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
References: <20210907232232.5205-1-luke@ljones.dev>
 <20210907232232.5205-2-luke@ljones.dev>
 <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
 <ef22aa1f-288a-4e5a-0210-d62c7fc89307@redhat.com>
 <TT750R.ES1JPTD16XUL@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b3eee6a7-5c8b-e0f9-d7cc-291fbdebd3b1@redhat.com>
Date:   Tue, 28 Sep 2021 13:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <TT750R.ES1JPTD16XUL@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/21 1:56 PM, Luke Jones wrote:
> Hmm,
> A change via /sys/firmware/acpi/platform_profile does disable the fan-curve until a user re-enables it.

Ah ok, so did get that part right :)

So basically any write to /sys/firmware/acpi/platform_profile
will reset the pwm1_enable to "2" if it was not "2" already.

> It doesn't wipe the actual curve setting though, I thought that would be bad UX,

Ok that is fine.

> but yes the curve is definitely disabled on profile change and will remain disabled until turned on again. At which point another profile change will disable it again.
> 
> And as stated in previous reply use of /sys/devices/platform/asus-nb-wmi/hwmon/hwmon<N>/pwm<N>_enable to check the status is stabilised (1 = manual fan).
> 
> Looking at it with fresh eyes I just spotted some things I can clean up further. Very sorry, there'll be a v15 :(

No worries, maybe wait a bit with posting v15 till Bastien has a chance
to way in on this discussion though.

Regards,

Hans



> On Tue, Sep 28 2021 at 13:44:32 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 9/28/21 1:36 PM, Bastien Nocera wrote:
>>>  On Wed, 2021-09-08 at 11:22 +1200, Luke D. Jones wrote:
>>>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>>>
>>>>  These laptops have the ability to set a custom curve for the CPU
>>>>  and GPU fans via two ACPI methods.
>>>>
>>>>  This patch adds two pwm<N> attributes to the hwmon sysfs,
>>>>  pwm1 for CPU fan, pwm2 for GPU fan. Both are under the hwmon of the
>>>>  name `asus_custom_fan_curve`. There is no safety check of the set
>>>>  fan curves - this must be done in userspace.
>>>>
>>>>  The fans have settings [1,2,3] under pwm<N>_enable:
>>>>  1. Enable and write settings out
>>>>  2. Disable and use factory fan mode
>>>>  3. Same as 2, additionally restoring default factory curve.
>>>>
>>>>  Use of 2 means that the curve the user has set is still stored and
>>>>  won't be erased, but the laptop will be using its default auto-fan
>>>>  mode. Re-enabling the manual mode then activates the curves again.
>>>>
>>>>  Notes:
>>>>  - pwm<N>_enable = 0 is an invalid setting.
>>>>  - pwm is actually a percentage and is scaled on writing to device.
>>>
>>>  I was trying to update:
>>>  
>>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
>>>  but I don't understand what files I need to check for what values to
>>>  detect whether custom fan curves were used.
>>>
>>>  Can you help me out here?
>>
>> How to deal with this is actually one of my remaining questions too.
>>
>> I've not looked at the new code closely yet, but if I understand
>> things correctly, the now code basically only allows to set 1
>> custom profile and setting that profile overrides the last
>> profile set through /sys/firmware/acpi/platform_profile.
>>
>> And any write to /sys/firmware/acpi/platform_profile will
>> overwrite / replace the last custom set profile (if any) with
>> the one matching the requested platform-profile.
>>
>> So basically users of custom fan profiles are expected to
>> disable power-profiles-daemon or at least to refrain from
>> making any platform_profile changes.
>>
>> And if power-profile-daemon is actually active and
>> makes a change then any custom settings will be thrown away,
>> IOW p-p-d will always win. So I believe that it no longer needs
>> to check for custom profiles, since any time it requests a
>> standard profile that will overwrite any custom profile
>> which may be present.
>>
>> Luke, do I have that right ?
>>
>>>  Also, was this patch accepted in the pdx86 tree?
>>
>> No, I still need to find/make some time to review it and
>> I still have the same question as you :)
>>
>> Regards,
>>
>> Hans
>>
> 
> 

