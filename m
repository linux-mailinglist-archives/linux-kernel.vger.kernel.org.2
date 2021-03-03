Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B811332C002
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386393AbhCCSO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:14:57 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44166 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhCCPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:47:31 -0500
Received: by mail-ed1-f49.google.com with SMTP id g3so30521224edb.11;
        Wed, 03 Mar 2021 07:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FGedAH/WSb7Haous5rA0I81fQoY4mqnQ+QpVc2HQfyI=;
        b=ha6joqd35V1rb+qGxsL2IYzvNR+O0yycuNGqCXN9mw3/IepSuPktcDbFYXmrTMm9E8
         U0Mk6Y2PmYNF9yCJCtUxctELn+wjzvLnRTpjSM9CaaSfn0fBGRtHsJ8CBEiEwdgKlqF0
         qDeSv4EzctHhO+zsxf4gT/ydFZ82a5TerP/iCDaI8jFyxc5wK5VcackbmOzI1qiWiki1
         EXgjEuw+SkjjgmPHoKU9NkUGXvML5kAygenM2li/w0wayvk3o0fFQYCWktit58QgjhuF
         ehWoFrYshkBxqaoD4/yDDLU07NYhuv+m7tDbTngNu54ptv+HxWZWx+e1EQQRMGA2ouPM
         wv8w==
X-Gm-Message-State: AOAM530K1H19c94Dtb+Vznx4NssdRtLwNxaBoyBcnKRtwk+doCUEpiK+
        NXIs0q0EGcLZI4IdqO12whw=
X-Google-Smtp-Source: ABdhPJyfWEgPI3HMjClvGzUw4IdZZ8yKXY0cYpHRoUeaP2UHUBWyZEwws5T0LeEg1WxiFVwO/1BbHg==
X-Received: by 2002:a50:bec3:: with SMTP id e3mr25827097edk.290.1614786384255;
        Wed, 03 Mar 2021 07:46:24 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s18sm25561008edc.21.2021.03.03.07.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 07:46:23 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com>
 <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
 <YD+mkse29UwwYbFB@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <6e9d6831-f88e-477f-6256-7ab155bfa7ac@kernel.org>
Date:   Wed, 3 Mar 2021 16:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YD+mkse29UwwYbFB@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 16:09, Greg Kroah-Hartman wrote:
> On Wed, Mar 03, 2021 at 06:56:38AM -0800, Guenter Roeck wrote:
>> On 3/3/21 6:05 AM, Greg Kroah-Hartman wrote:
>> [ ... ]
>>>> Anyway, that's the convention or consensus so far for entire SoC. If we
>>>> want to change it - sure, but let's make it for everyone, not for just
>>>> this one USB driver.
>>>
>>> Great, let's change it for everyone, I don't see a need for ARCH_*
>>> symbols except for people who want to make it simpler for their one
>>> board type.  And for that, use a defconfig.
>>>
>>
>> I don't think that will work in practice. Many ARCH_ symbols for various
>> architectures contradict with each other. Almost all watchdog drivers
>> only _build_ for specific platforms/architectures.
> 
> Great, that's horrible to hear, so much for a "generic arm64 kernel
> binary" which I _thought_ was the goal.
> 
> ugh, you would have thought we would have learned our lesson with
> arm32...

I think Guenter here refers to drivers which actually came from arm32 
and were not cleaned up to be build without machine-specific bits 
(arch/arm/mach-xxx).

Most or all of the new code is made buildable outside of 
machine/ARCH_xxx (so COMPILE_TEST).

Best regards,
Krzysztof
