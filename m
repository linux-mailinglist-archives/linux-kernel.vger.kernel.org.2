Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906DF30FBDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbhBDSqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbhBDSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:42:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FDAC061794
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:41:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e12so2236276pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPJcixL5B72ONNeQTUrd/Ds+3cwL/OzxhJxazJOwdWU=;
        b=hZEBnFadWKNcM22cVRU/a7ekIXxiGnvJaR2OBmXSBWA6MhsJnQ2IP0Ye4V2wat6Zrl
         9XH7dXAdM9sS3FDL9bMNpEvQS1wZMWANxL4DrjDucQXa4SUlny92X0EuRxN1PAjCxlJC
         m2Rdnf0rreJ+30C4IzBRjr9B+mS3tkPN+k1uZbx/dni+WSpZMxs84jLLonRWdR1XL4iv
         Ol2ek6+pTFzt6KDgTWX+NVfz71eWtviLUCDaPXTDq6+0htUPSE9svu9bOcCSNrFn7Ufb
         YmAsPAVPCxvO32sPjMwPhd6eq4IPf/91C/Uugg+0biZoHhKZNN6+wyPWEY1UtAdmpX65
         uTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPJcixL5B72ONNeQTUrd/Ds+3cwL/OzxhJxazJOwdWU=;
        b=ot2lfdBd+yBKcJ/GUqokRFEZOkT5Ay+rzob+Wr5klZZDIew6Jm5TC1a7oYTTeuf5fC
         Ru9qkQcv+pNq4arxE2CWnDceUqB53r9r0Qbvmb+HzcT+0wHhYGU6FKKXbLqVpctbbWuZ
         wgL5bsaj/DJbQzvonjsvhyGLeP/4ceraKQIxvXmFaZtLiryv40rNMUS6GhF73F6zvMCi
         bHToHbkXUelDuqJIrEVT12kHlBaKzBHCyGQlrkgUbgmLBWx9WQfQHi/nqTHMP+fwneEQ
         +qtJggKNd4oMea+S4qxAZxV9hbiZfvAdBGd9N3QgYhFw3k+FPafijw6ZCggYfuF5nDAY
         CAYQ==
X-Gm-Message-State: AOAM5318wOVywXTnMOHY2tonbpGY5jlPtfC3JJm6pKc1iq93OMm0Fgkk
        82Y58HM9thfb4kimMdPRFKm93lPDlDkH/BzWHKM=
X-Google-Smtp-Source: ABdhPJzy/LIgldY2il/NtwAfXOaYXEinArlc3vM117wT2mWj8AdIkX1bTtfJpk8Qa6r89tNQKFjtw0VzqsMn2rxOEpY=
X-Received: by 2002:a17:90a:7787:: with SMTP id v7mr298480pjk.81.1612464105539;
 Thu, 04 Feb 2021 10:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20210204124914.GC20468@willie-the-truck> <20210204155346.88028-1-lecopzer@gmail.com>
 <20210204175659.GC21303@willie-the-truck>
In-Reply-To: <20210204175659.GC21303@willie-the-truck>
From:   Lecopzer Chen <lecopzer@gmail.com>
Date:   Fri, 5 Feb 2021 02:41:34 +0800
Message-ID: <CANr2M19xc+9UE3dZB5UA8HvgTGAcoSLOPAkeepExcUrKkNHt+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        dan.j.williams@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, gustavoars@kernel.org,
        kasan-dev@googlegroups.com,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        linux@roeck-us.net, robin.murphy@arm.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, vincenzo.frascino@arm.com,
        yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 04, 2021 at 11:53:46PM +0800, Lecopzer Chen wrote:
> > > On Sat, Jan 09, 2021 at 06:32:48PM +0800, Lecopzer Chen wrote:
> > > > Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > > > ("kasan: support backing vmalloc space with real shadow memory")
> > > >
> > > > Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> > > > but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> > > > by not to populate the vmalloc area except for kimg address.
> > >
> > > The one thing I've failed to grok from your series is how you deal with
> > > vmalloc allocations where the shadow overlaps with the shadow which has
> > > already been allocated for the kernel image. Please can you explain?
> >
> >
> > The most key point is we don't map anything in the vmalloc shadow address.
> > So we don't care where the kernel image locate inside vmalloc area.
> >
> >   kasan_map_populate(kimg_shadow_start, kimg_shadow_end,...)
> >
> > Kernel image was populated with real mapping in its shadow address.
> > I `bypass' the whole shadow of vmalloc area, the only place you can find
> > about vmalloc_shadow is
> >       kasan_populate_early_shadow((void *)vmalloc_shadow_end,
> >                       (void *)KASAN_SHADOW_END);
> >
> >       -----------  vmalloc_shadow_start
> >  |           |
> >  |           |
> >  |           | <= non-mapping
> >  |           |
> >  |           |
> >  |-----------|
> >  |///////////|<- kimage shadow with page table mapping.
> >  |-----------|
> >  |           |
> >  |           | <= non-mapping
> >  |           |
> >  ------------- vmalloc_shadow_end
> >  |00000000000|
> >  |00000000000| <= Zero shadow
> >  |00000000000|
> >  ------------- KASAN_SHADOW_END
> >
> > vmalloc shadow will be mapped 'ondemend', see kasan_populate_vmalloc()
> > in mm/vmalloc.c in detail.
> > So the shadow of vmalloc will be allocated later if anyone use its va.
>
> Indeed, but the question I'm asking is what happens when an on-demand shadow
> allocation from vmalloc overlaps with the shadow that we allocated early for
> the kernel image?
>
> Sounds like I have to go and read the code...
oh, sorry I misunderstood your question.

FWIW,
I think this won't happend because this mean vmalloc() provides va
which already allocated by kimg, as I know, vmalloc_init() will insert
early allocated vma into its vmalloc rb tree

, and this early allocated vma will include  kernel image.

After quick review of mm init code,
this early allocated for vma is at map_kernel() in arch/arm64/mm/mmu.c



BRs
Lecopzer
