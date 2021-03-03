Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB232BFFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386373AbhCCSOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:14:50 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:34602 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452429AbhCCPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:44:53 -0500
Received: by mail-ej1-f53.google.com with SMTP id hs11so43095115ejc.1;
        Wed, 03 Mar 2021 07:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jmwkopkt3BG1/Et9G0GYQYsOFcnJ7f1RtzCYTDIXsGI=;
        b=hXiWnB2EPaqIKQ0qVPOA8F/bLBYdr9aagBmY6XvW7TrhVTTkV7Gs9UFyD8CEZxYYq/
         7bcVzuLk3l1nB7BqiNosypXS7e83YiDB49UbjMeXlyAq0EbAbuJJQ12ltex7qsxRIFMz
         gPPv/uaJuSdsMGtR00JD/E3tmzMB/TmOqwYzMnqPCa1mqmYMj15QFwt+32eqqZ9nC8T7
         I3WxUD6ePxqRlnR+YmADZe5aJPibeYm3Hw/a0KfqZziT9mAnlAyhaAfkPEGABXZC1KLc
         JZTvMDXpfgSghYPD/fBdrPn52YD+yy08WEbM27HSXr+iVlfwPayzFav+MuJyQWbqtURt
         3crg==
X-Gm-Message-State: AOAM530CD2OW4QZSgtY6zyEZFXEjxkk2N/yIUFrZeC6DUQNP1aqdGjb1
        xvpfTMJtIpa7geg0pcZWbqIr1kME2i0=
X-Google-Smtp-Source: ABdhPJx6ywcjp3HZcdfY4i3Kci8tvaNlhQba0HUoDE8H/AoVUR+4ZRHIO1GBjkOhvcqhPY282vCWOQ==
X-Received: by 2002:a17:907:ea3:: with SMTP id ho35mr25834832ejc.396.1614786250768;
        Wed, 03 Mar 2021 07:44:10 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a9sm3559544edt.82.2021.03.03.07.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 07:44:09 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <c50d2091-0f87-dd2c-a7bc-df1bed14c17f@kernel.org>
Date:   Wed, 3 Mar 2021 16:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YD+XkFAfoKpSsea3@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 15:05, Greg Kroah-Hartman wrote:
> On Wed, Mar 03, 2021 at 11:38:39AM +0100, Krzysztof Kozlowski wrote:
>> This is so far component of a SoC, so it cannot be re-used outside of
>> SoC. Unless it appears in a new SoC (just like recent re-use of Samsung
>> serial driver for Apple M1). Because of the architecture, you cannot
>> build universal kernel without ARCH_EXYNOS. You need it. Otherwise the
>> kernel won't boot on hardware with DWC Exynos.
> 
> So, to create a "generic" arm64 kernel, I need to go enable all of the
> ARCH_* variants as well?  I thought we were trying to NOT do the same
> mess that arm32 had for this type of thing.

The kernel itself is generic and could work on all arm64 platforms. You 
have to however enable all ARCH_* because of the design choice:
1. device tree sources are toggled with ARCH_xxx
2. the given ARCH_xxx might select specific drivers needed for the 
kernel to work (or the drivers depend on it).

Maybe except the device trees, the case 2. above could be solved not 
with dependency but "imply".

>> Since DWC Exynos won't work without ARCH_EXYNOS - the user will not get
>> any usable binary - I think all, or almost all, SoC specific drivers are
>> limited per ARCH. This limits the amount of choices for distro people
>> and other kernel configuring folks, so they won't have to consider
>> useless options.
> 
> Why do we have ARCH_EXYNOS at all?  x86-64 doesn't have this, why is
> arm64 somehow special here?

Because x86 is plug and play? Has BIOS? You can have generic kernel? ARM 
is not like this - you need to load for example proper device tree blob 
matching your hardware. This could be loaded/passed/chosen by 
bootloader, but it's not the same as BIOS.

> That's my complaint, it feels wrong that I have to go and enable all
> different ARCH_ symbols just to build these drivers.  If people want
> 'default' configurations, then provide an exynos default config file,
> right?

If you refer to only building, then options are usually 
compile-testable. But if you think about having a working kernel, why 
having a ARCH_xxx for given platform feels wrong? Isn't it nice to hide 
all stuff behind one option?

I think MIPS and RISC-V do similar.

> 
>> Anyway, that's the convention or consensus so far for entire SoC. If we
>> want to change it - sure, but let's make it for everyone, not for just
>> this one USB driver.
> 
> Great, let's change it for everyone, I don't see a need for ARCH_*
> symbols except for people who want to make it simpler for their one
> board type.  And for that, use a defconfig.
> 
> I've complained about this before, from a driver subsystem maintainer
> point of view, this is crazy, drivers should be building and working on
> everything.  Worst case, it's a cpu-type issue, to build or not build a
> driver (i.e. s390, i386), best case it's a feature-type issue to depend
> on (i.e. USB, TTY, etc.).  But never a "this one sub-architecture of
> this one cpu"-type issue.  That feels crazy to me...

 From the building point of view, I agree that the goal is to build them 
everywhere. This is why we have COMPILE_TEST. From the running/working 
point of view, these are not PCI or USB cards. These are dedicated 
blocks of System on Chip. They sometimes got reused on different SoCs 
but they do not exist outside the SoC.

Is there a point to split a complex PCI driver into 10 different parts 
and be able to use each of this part separately? Usually not...

Best regards,
Krzysztof
