Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC5370172
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhD3TsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhD3Tr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:47:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5707C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:47:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso2318441pjn.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JpP3SOMsyKbKdgdhycOI1PqF+crmAFSB33V4ZUkSKZs=;
        b=GUZvOaan0TFHPmegXK/2LcZXVUNAnqkcrhKPmSPfOOdVTkxQQV08BB/++nr1roQ096
         m8TSef8NvmbWBtrEh6mmfqt8Ghgq4ttaWzNUYXMhngaolLTlhz/xtLqUGAx3E9C/NdCp
         WLoKm7MoGvdgUz71VGXN9eIpOwvF29VtzQpMDckGIIu/0mx4xyW2sBmVDKa9fA0PamPE
         QKtZkIgr6HvzdPu4lxnLDqcMdTI9KKopz1YYMJwvJBh8/okjHYzPLT1VWQtnSEmmya4x
         ibBHsOZ4etXDJGLTKU3q0dVUrsawI+U/66jRoXZLSmIAYKHYVLyc2qWFreqeRfzbw5W/
         NamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JpP3SOMsyKbKdgdhycOI1PqF+crmAFSB33V4ZUkSKZs=;
        b=qAU23pqK1zH8dHnIU0LTaP9wIpHHELaFqiNr/zVRAst3dbHIp2tftNuCb1h8k5DPOp
         C0PkciVTWQzii9BDjQeAPh7O1TzRVux8oFcnDmVoitRDCK20/h7+x7t2it/NQigBHWZo
         XqqDOzeox2hE9LyH8vFvRh0YJX8NscvDAhpViCieCfgwugfVvajVYIafMV+jdZBRR0DL
         zDRJVPSTJktGaqwEZ4jp3oLHNaaeQ9SaFGKA4a6bOiz4ITEjrXkcvW8DoZKGlfsBzgDx
         iwa1jGJJYOl7lqJ8CUHoH8EqJ+qXTNZhIWpe+Krod9mVAObDZP99c/WGVbwIEYCltCkn
         wkLw==
X-Gm-Message-State: AOAM5327uUkVEoVRtnsZCPGW/zmkXP8zkDyCObvJN363KJFR/2WowXcS
        bt9N9VX4WSXbsfIqrZwp7c5ITQ==
X-Google-Smtp-Source: ABdhPJx+PObPLCgu6rRhjlUXqLxkXBqF/d+dgd6UMd6Or54JjNDlPQAy4zbB21j8eBcs+s2bJeR7Yw==
X-Received: by 2002:a17:90a:fa0e:: with SMTP id cm14mr16606392pjb.59.1619812030129;
        Fri, 30 Apr 2021 12:47:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e65sm3120704pfe.9.2021.04.30.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:47:09 -0700 (PDT)
Date:   Fri, 30 Apr 2021 12:47:09 -0700 (PDT)
X-Google-Original-Date: Fri, 30 Apr 2021 12:47:08 PDT (-0700)
Subject:     Re: [PATCH] riscv: Disallow to build XIP_KERNEL with SOC_SIFIVE
In-Reply-To: <35b97408-328a-a9cd-1bb8-6758f42bde2d@ghiti.fr>
CC:     vitaly.wool@konsulko.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-16ec61ad-00c2-4d7e-a85e-6f651bdff654@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 01:09:14 PDT (-0700), alex@ghiti.fr wrote:
> Le 4/29/21 à 8:13 AM, Alex Ghiti a écrit :
>> Le 4/29/21 à 5:11 AM, Vitaly Wool a écrit :
>>> On Thu, Apr 29, 2021 at 10:47 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is not
>>>> possible when
>>>> the kernel is executed from the flash in XIP mode, and as the SIFIVE
>>>> errata must be fixed somehow, disallow to build a XIP kernel that
>>>> supports SIFIVE socs.
>>>
>>> Could you please hold off this patch for a bit? I will try to come up
>>> with an alternative solution. It should be possible to define a
>>> special section within the RW area and place the functions that need
>>> such patching there.
>>> Not that I like that much but at least we'll keep the ability to use
>>> XIP on SiFive.
>>
>> Ok, I'm wondering why I did not think of that...I'll give it a try just
>> to punish myself.
>>
>> Thanks Vitaly,
>>
>> Alex
>>
>
> I tried what you proposed and it works well, *callers* must be placed
> into this writable section in RAM and that's it, that may be more
> complicated if at some point the patched functions are generic but I
> think we can use an intermediate riscv function to patch instead or
> something else.
>
> The modifications I did only consist in putting alternative section in
> RAM and place the exception vector table in this section.
>
> If you can do the proper patch, I'll let you do it, otherwise I'll do
> that later as I have other things to do before.
>
> So Palmer you can drop this patch.

Great.  I was going to push back and just say "we should swap the 
alternatives over to the errata implemnetation for XIP, as the current 
ones are just a performance hit when unnecessary and XIP users are 
likely to build for a single SOC anyway".  That would mean we'd need to 
sort something out WRT errata that rely on design-specific 
functionality, and everything I came up with there was a headache.

It's way better if we can just full support the alternatives stuff, so 
I'll just wait for that.

>
> Thanks again,
>
>>>
>>> Best regards,
>>>     Vitaly
>>>
>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>>> ---
>>>>   arch/riscv/Kconfig.erratas | 2 +-
>>>>   arch/riscv/Kconfig.socs    | 1 +
>>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
>>>> index d5d03ae8d685..9537dbd67357 100644
>>>> --- a/arch/riscv/Kconfig.erratas
>>>> +++ b/arch/riscv/Kconfig.erratas
>>>> @@ -2,7 +2,7 @@ menu "CPU errata selection"
>>>>
>>>>   config RISCV_ERRATA_ALTERNATIVE
>>>>          bool "RISC-V alternative scheme"
>>>> -       default y
>>>> +       default y if !XIP_KERNEL
>>>>          help
>>>>            This Kconfig allows the kernel to automatically patch the
>>>>            errata required by the execution platform at run time. The
>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>>> index 00c2b205654c..9cb38bc9d7cd 100644
>>>> --- a/arch/riscv/Kconfig.socs
>>>> +++ b/arch/riscv/Kconfig.socs
>>>> @@ -9,6 +9,7 @@ config SOC_MICROCHIP_POLARFIRE
>>>>
>>>>   config SOC_SIFIVE
>>>>          bool "SiFive SoCs"
>>>> +       depends on !XIP_KERNEL
>>>>          select SERIAL_SIFIVE if TTY
>>>>          select SERIAL_SIFIVE_CONSOLE if TTY
>>>>          select CLK_SIFIVE
>>>> --
>>>> 2.20.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
