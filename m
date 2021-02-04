Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7405930F55C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhBDOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbhBDOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:47:04 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B8C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:46:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x23so744002pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONy/oQQmnX5TrrjNFytVoLv75B7UXC2fqKWnMIXbGzs=;
        b=JvJ1qeNfvw6BcOjaGVSW5FIeL8kmh8OwMEOC4re7970bU1N83umruRDn8+w+fLl4RN
         63EvVEhR6dqS8hoY8mApckXYpIrU6MSmB0GOny3r0m0f58w83FXlYnb2jj4OZptsfkYl
         6snfOqi/Hjk7v4Khp5TrGaVjItOSRxAJKXH0JgFYUJRg3aOfNVESawuqryyssousV9k9
         i3sK42o8TJSD0eIFg4IRMJJRoikqyjyUprXOlu9kS8USrZn1RAcAQXL2Rq+gdOoUjfFE
         DcF7Fq0L6QsyUr0wnVQhXzIMUVbuz0O+5BklkUnjDBuM2+9p2OSsbBkYK6hE7aGyJuKq
         gAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONy/oQQmnX5TrrjNFytVoLv75B7UXC2fqKWnMIXbGzs=;
        b=RWsYsw2KjaENj+omyx0x43RbZc8wyMqc211kpjZu+li/oiX7lkrKnQ+zLygz56t7VL
         5KHOJVzm09+ZPq7kfFbdRl97/lCR6mTfxpyDFwuuuSfuteti98cbTqWrXUZk2CFch78E
         j77YgKUDUrOKYUdoGivCDIMfGQDmwUQrBKlkHWaAHtOxeV7m0D8Q605/XlBzzai2e5gc
         s3sGhGhjLzhsICv/pN4B0jpwgHHwxPVcxQq+azr6d5D88pDHDNbPZfp6kywDfNxAwvvw
         ICn+nd/UnAEHeQQsCn2/ulGdpV0wGQWBxhRA7pvkk0ckxq9p9CFbQ6QGFeGvArqIQy8L
         m/PQ==
X-Gm-Message-State: AOAM533CeobjRNGE2F0//zrFNbveVH+VPkvzMIWLRqqDTTbyn1fNs8+Y
        xNEwEQWdodCciIQpVmhaLnc=
X-Google-Smtp-Source: ABdhPJzai0dWbSt7+WLA3WtD42I4vYknfBo+7vrNRDV/4Nj5JBi54UmO9JfeYGktAdgIawh4bBqF1A==
X-Received: by 2002:a62:a108:0:b029:1c1:119b:8713 with SMTP id b8-20020a62a1080000b02901c1119b8713mr8565016pff.74.1612449983550;
        Thu, 04 Feb 2021 06:46:23 -0800 (PST)
Received: from localhost.localdomain (61-230-45-44.dynamic-ip.hinet.net. [61.230.45.44])
        by smtp.gmail.com with ESMTPSA id z2sm6382878pfa.121.2021.02.04.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:46:22 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     will@kernel.org
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        catalin.marinas@arm.com, dan.j.williams@intel.com,
        dvyukov@google.com, glider@google.com, gustavoars@kernel.org,
        kasan-dev@googlegroups.com, lecopzer.chen@mediatek.com,
        lecopzer@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mm@kvack.org, linux@roeck-us.net, robin.murphy@arm.com,
        rppt@kernel.org, tyhicks@linux.microsoft.com,
        vincenzo.frascino@arm.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
Date:   Thu,  4 Feb 2021 22:46:12 +0800
Message-Id: <20210204144612.75582-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204124543.GA20468@willie-the-truck>
References: <20210204124543.GA20468@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jan 09, 2021 at 06:32:49PM +0800, Lecopzer Chen wrote:
> > Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > ("kasan: support backing vmalloc space with real shadow memory")
> > 
> > Like how the MODULES_VADDR does now, just not to early populate
> > the VMALLOC_START between VMALLOC_END.
> > similarly, the kernel code mapping is now in the VMALLOC area and
> > should keep these area populated.
> > 
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index d8e66c78440e..39b218a64279 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
> >  {
> >  	u64 kimg_shadow_start, kimg_shadow_end;
> >  	u64 mod_shadow_start, mod_shadow_end;
> > +	u64 vmalloc_shadow_start, vmalloc_shadow_end;
> >  	phys_addr_t pa_start, pa_end;
> >  	u64 i;
> >  
> > @@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
> >  	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
> >  	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> >  
> > +	vmalloc_shadow_start = (u64)kasan_mem_to_shadow((void *)VMALLOC_START);
> > +	vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> > +
> >  	/*
> >  	 * We are going to perform proper setup of shadow memory.
> >  	 * At first we should unmap early shadow (clear_pgds() call below).
> > @@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void)
> >  
> >  	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
> >  				   (void *)mod_shadow_start);
> > -	kasan_populate_early_shadow((void *)kimg_shadow_end,
> > -				   (void *)KASAN_SHADOW_END);
> > +	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> 
> Do we really need yet another CONFIG option for KASAN? What's the use-case
> for *not* enabling this if you're already enabling one of the KASAN
> backends?

As I know, KASAN_VMALLOC now only supports KASAN_GENERIC and also
KASAN_VMALLOC uses more memory to map real shadow memory (1/8 of vmalloc va).

There should be someone can enable KASAN_GENERIC but can't use VMALLOC
due to memory issue.
 
> > +		kasan_populate_early_shadow((void *)vmalloc_shadow_end,
> > +					    (void *)KASAN_SHADOW_END);
> > +		if (vmalloc_shadow_start > mod_shadow_end)
> 
> To echo Ard's concern: when is the above 'if' condition true?

After reviewing this code,
since VMALLOC_STAR is a compiler defined macro of MODULES_END,
this if-condition will never be true.

I also test it with removing this and works fine.

I'll remove this in the next version patch,
thanks a lot for pointing out this.

BRs,
Lecopzer
