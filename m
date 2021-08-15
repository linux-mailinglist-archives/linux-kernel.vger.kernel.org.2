Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E0B3EC95A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbhHONqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 09:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232796AbhHONqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629035130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8B+TmvstR2yPUGoHdC8uxAdnIKs5WSO53Wi10geMgg=;
        b=cKGTgJc6dAVRrhZahlx7u7kRxTRCimXuTy2HYb1OeEXgy+I/iFOpJZV3A+gCCxrzANYeoX
        09Ypz7A7ZRDRJXZpHxmYwfsh7VH8TRrVkBV2zdG9S608n0ysIjhcS3UHY/77xE/GCYvkhp
        wzCEXUxvh3PY85Ll8WwhmC5IsiBn/3E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-S6C9D3YcNWGwxI8TY5BSwA-1; Sun, 15 Aug 2021 09:45:29 -0400
X-MC-Unique: S6C9D3YcNWGwxI8TY5BSwA-1
Received: by mail-ed1-f70.google.com with SMTP id n4-20020aa7c6840000b02903be94ce771fso6881523edq.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 06:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8B+TmvstR2yPUGoHdC8uxAdnIKs5WSO53Wi10geMgg=;
        b=XNeJnRRDGO8AeKEd4nhM7yPBRoVdi/T5g+lOwXlXzWH5YrV1CA/aFleYVnVoRmgaNr
         oEJ8KEht/ISC89+/GNoSl8k7RL9n8i/7IsOI8piR6QohcatoyDieC1bPn1P6ndCu88s1
         AL9r1rJLRbEnamJYIPhvLLI55PJKZjtxWz1qkJr1HwtyoMOxO/6UmFYW43mNlW06+GJK
         kQ2YMcv4czjWcchiRMHyoksVAjHCEskVHkBzvgFWyTLM1UQwkUNUccZAE+dc60sSpqZC
         RIACMSRI8p2Kr0E4zpU+iKYWlG9sCC0FXxzMWGRU8Ncz6J2rkBIUNuvIpyF6ip6jkqUz
         LSkw==
X-Gm-Message-State: AOAM531sPikNmbLwj+fGYdMev/DWqCFhlniTLHRHnMJ4GLDjRxvUOv5f
        udvFeBKu+yrAb9r16MXNA5v4GRdoRU8OnfbETcMrfkU4fCsmtZN+an7wDWbbUUJ/4CuUb58pc+E
        Fr7HXnJx0H+ahWOTvDk24dR1+
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr11477534ejd.488.1629035128183;
        Sun, 15 Aug 2021 06:45:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy91aTWep0PLKd5PIBkUrd5mfEx8czH6APFx7rCpLIpaFRb+C4ZEXYh/DO7CbGxscjorxr6Zg==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr11477517ejd.488.1629035127941;
        Sun, 15 Aug 2021 06:45:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id 8sm2705382ejy.65.2021.08.15.06.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 06:45:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] asus-wmi: Add support for platform_profile
To:     Luke Jones <luke@ljones.dev>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20210814043103.2535842-1-luke@ljones.dev>
 <20210814043103.2535842-2-luke@ljones.dev>
 <CAHp75VcCzjb7TKZ84iVjJr27+nCcA10n38nwCAGATucfAAMkKA@mail.gmail.com>
 <UCVTXQ.8ME64G0S1BQ8@ljones.dev> <T6YTXQ.N7QG3527OXWU1@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7846a887-a96b-fb8e-d1ee-e105b88a77bf@redhat.com>
Date:   Sun, 15 Aug 2021 15:45:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <T6YTXQ.N7QG3527OXWU1@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/21 2:47 PM, Luke Jones wrote:
> A very quick question: should I be enabling platform_profile by default if asus_wmi is enabled in kconfig?

You should add a "select ACPI_PLATFORM_PROFILE" to the Kconfig part for ASUS_WMI,
the PLATFORM_PROFILE support / common code is a library, so it needs to be selected
by the drivers which need it.

Regards,

Hans


> 
> On Sat, Aug 14 2021 at 23:46:06 +1200, Luke Jones <luke@ljones.dev> wrote:
>> Hi Andy, thanks for the feedback. All is addressed, and some inline comment/reply. New version incoming pending pr_info() vs dev_info()
>>
>> On Sat, Aug 14 2021 at 12:40:39 +0300, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Sat, Aug 14, 2021 at 7:33 AM Luke D. Jones <luke@ljones.dev> wrote:
>>>>
>>>>  Add initial support for platform_profile where the support is
>>>>  based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>>>>
>>>>  Because throttle_thermal_policy is used by platform_profile and is
>>>>  writeable separately to platform_profile any userspace changes to
>>>>  throttle_thermal_policy need to notify platform_profile.
>>>>
>>>>  In future throttle_thermal_policy sysfs should be removed so that
>>>>  only one method controls the laptop power profile.
>>>
>>> Some comments below.
>>>
>>> ...
>>>
>>>>  +       /*
>>>>  +        * Ensure that platform_profile updates userspace with the change to ensure
>>>>  +        * that platform_profile and throttle_thermal_policy_mode are in sync
>>>
>>> Missed period here and in other multi-line comments.
>>>
>>>>  +        */
>>>
>>> ...
>>>
>>>>  +       /* All possible toggles like throttle_thermal_policy here */
>>>>  +       if (asus->throttle_thermal_policy_available) {
>>>>  +               tp = asus->throttle_thermal_policy_mode;
>>>>  +       } else {
>>>>  +               return -1;
>>>>  +       }
>>>>  +
>>>>  +       if (tp < 0)
>>>>  +               return tp;
>>>
>>> This will be better in a form
>>>
>>>     if (!..._available)
>>>         return -ENODATA; // what -1 means?
>>>
>>
>> I wasn't sure what the best return was here. On your suggestion I've changed to ENODATA
>>
>>>     tp = ...;
>>>     if (tp < 0)
>>>         return tp;
>>>
>>> ...
>>>
>>>>  +       /* All possible toggles like throttle_thermal_policy here */
>>>>  +       if (!asus->throttle_thermal_policy_available) {
>>>>  +               return -1;
>>>
>>> See above.
>>>
>>>>  +       }
>>>
>>> ...
>>>
>>>>  +       if (asus->throttle_thermal_policy_available) {
>>>>  +               pr_info("Using throttle_thermal_policy for platform_profile support\n");
>>>
>>> Why pr_*()?
>>
>> That seemed to be the convention? I see there is also dev_info(), so I've switched to that as it seems more appropriate.
>>
>>>
>>>>  +       } else {
>>>>  +               /*
>>>>  +                * Not an error if a component platform_profile relies on is unavailable
>>>>  +                * so early return, skipping the setup of platform_profile.
>>>>  +               */
>>>>  +               return 0;
>>>
>>> Do it other way around,
>>>
>>> /*
>>>  * Comment
>>>  */
>>> if (!...)
>>>   return 0;
>>
>> Thanks, I think I was transliterating thought process to code as I went along.
>> All updated now.
>>
>>>
>>>>  +       }
>>>
>>>
>>> -- 
>>> With Best Regards,
>>> Andy Shevchenko
>>
> 
> 

