Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA3632BF88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579833AbhCCScV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:21 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42025 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbhCCQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:49:49 -0500
Received: by mail-ed1-f54.google.com with SMTP id v13so14441598edw.9;
        Wed, 03 Mar 2021 08:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rp1enDoynMMCAy1S3lbocBoRsP5P8h6wvE7fEWAoRY=;
        b=t0JYNroYUnBhO0ThstOgiO57sRpfvdxF7P+pDymHDYHS5lsmFj5QwySuhkfexl8QQR
         vbKQtx/wE+vyZfvRSsUDMLM7ZUDCCyuHLYFkEU8pPzuB5svgFSOizd7jL795x4SWU0Cw
         mBbmqYU5IAWiQUdG2agGmUAjruu+ypfHftI3fFsX79xbRvobRrNVmUzlt4b3ip+TiSeA
         VNu2ZJmngRDmKQ355uZ3FAaB79UZvs2dJQdSf2AbcrJFbQQsG/93mFV4mz8tGU8P6Dhn
         wRDgLNaOBFvCBVT39O/Z5UBX1ypOe9ou6WDIQt4iNKZaaVfkUIMx0sxgjBsvdUsWS267
         5KDw==
X-Gm-Message-State: AOAM53116eVBpBLkTsoC56FfZRgFePCjeORZmx20tedsAQu1FEKJnwA/
        BSFKtvUJEOAhsKc8rnfJ8viGMqV1ViM=
X-Google-Smtp-Source: ABdhPJyDu7b8+dHL4mbHB04vYAeSdPadl+EsScQqVFClm+0yDvqDbAyRYexrHANhz/Dn2G4Nw6Op7A==
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr140953edr.115.1614790142876;
        Wed, 03 Mar 2021 08:49:02 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r4sm3542441ejd.125.2021.03.03.08.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 08:49:01 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        taehyun cho <taehyun.cho@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com>
 <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
 <YD+mkse29UwwYbFB@kroah.com>
 <6e9d6831-f88e-477f-6256-7ab155bfa7ac@kernel.org>
 <CAK8P3a2TAZELiqzy8Xv8hKvZwM6_+rF5OW9_AkP2TBoDRS3skQ@mail.gmail.com>
 <YD+8q/hSWNKQS1tE@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <a6ac3887-38d0-48f4-e06f-81b45484a54a@kernel.org>
Date:   Wed, 3 Mar 2021 17:49:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YD+8q/hSWNKQS1tE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 17:43, Greg Kroah-Hartman wrote:
>>>>> I don't think that will work in practice. Many ARCH_ symbols for various
>>>>> architectures contradict with each other. Almost all watchdog drivers
>>>>> only _build_ for specific platforms/architectures.
>>>>
>>>> Great, that's horrible to hear, so much for a "generic arm64 kernel
>>>> binary" which I _thought_ was the goal.
>>>>
>>>> ugh, you would have thought we would have learned our lesson with
>>>> arm32...
>>
>> I have no idea what you are talking about here. arm64 kernels have
>> always been generic, but you still need drivers for each piece of
>> hardware, we unfortunately can't stop SoC vendors from reinventing
>> the wheel with each new platform and then having to add yet another
>> driver for each subsystems.
> 
> That's fine, drivers are easy, but when I see comments like "ARCH_
> symbols contradict" that means that we can not make a generic kernel
> image.  Otherwise there's no contradiction :)

No, they don't contradict.

> 
> And "new drivers" are almost always not really "new" as everyone uses
> much the same IP blocks.  As proof of this patch where the DWC3 IP block
> is being used by multiple SoC vendors.  To handle that, you split out
> the SoC-specific portions into sub-drivers, so that you can build a
> single image of the driver that works on multiple platforms.  Nothing
> new, we've been doing this for years, it's just that out-of-mainline SoC
> trees that think they can touch "core IP block code" break this all the
> time, which is what I am pushing back on.

I am perfectly fine with (and like it!) putting dwc3 exynos back into 
base/main dwc3  and getting rid of USB_DWC3_EXYNOS entirely. But this 
was not part of this patch...

> 
> Anyway, this is just me as a driver subsystem maintainer being grumpy to
> see ARCH_ dependancies on tiny little things like SoC-portions for
> generic IP drivers.  Or on individual drivers (i.e. Samsung serial port
> driver), where they don't belong at all.

At least with Samsung serial driver we see adding new SoC - Apple M1.

Here, the guys in Samsung want to tweak several kernel parts to work 
with their out-of-tree code without contributing this code back. It's 
not a community-friendly approach. The upstream kernel should be tweaked 
to the out-of-tree unknown, hidden and uncontrollable code.

Instead I expect from Samsung to contribute the basic Exynos9 support to 
the upstream.


Best regards,
Krzysztof
