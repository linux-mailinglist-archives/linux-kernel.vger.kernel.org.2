Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD830F826
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhBDQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbhBDQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:38:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:37:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so2455646pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwObsRzKSVhqA/EbWV8d9m9v2JwQDreOVTF8iuaBQ+g=;
        b=Qs76dodtfk29vh9y2oWEdTMAEgX8pR7GDXBRZt11OnuF+F3yrCFpGCfE3EUSAGkLGg
         5jkQJMKtoXCFCFsOw41yy0P24mbEQnUU/PN1vC734l1/K39+46+VS6bbscHzj2L55Whw
         FW22EBkyNiVCxmkNsXDYGEsP+zGH6f3LFIpXAoDhgixEHEseFXS8agAF7cSt15vBfmIu
         sa7oQOcvJtNzr/K6/r+vpvpUh+C2Mr6l1bM36mquA5Xn9VwjHxOLJnJ4Q3BcPgr4LZ4Y
         ey0TsDb+L/fowZ7+gofPOCsnCxtE2ihWeCgNDWMxadMu+izWumzDBNC7nofrD9894P78
         GvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwObsRzKSVhqA/EbWV8d9m9v2JwQDreOVTF8iuaBQ+g=;
        b=edbR+gW56WmKxEOhwO/bTKWEEfbGWrepjMBWifC8A7unN2AA0VPWs8r5jdC3wEtPD5
         6CFDv8p/dahugual1Q4+Al+RmhG6PZHTYm7RP1gymci33SaF2L6ZTSOlZjASM+pverIa
         QTKhgivSV0im7ARgD8emb0uCOyjSn0H9zXz5mgrjLZ2LMra0gVjvv3QyFvBarfHVkdUD
         cgYF2CCple0erJT5ORNaYp4x78bj7mkjFf67usM3tb4jcTJc9dFL1r5zJO7x4Pqc/UmQ
         lCRlONGXy0mcVQQO+WtBtGLk/zIy1aPJ+sykKbNNbfif7hyoPBj3UJeZPdnrIz130yzd
         lCyA==
X-Gm-Message-State: AOAM5306/GYjXtdh2IGQ9ToLw2Vu9orKIbHZM3WXepLvED0xYfMRptZ5
        8kXN6Z/PXnoZUqbpoj+I8f8=
X-Google-Smtp-Source: ABdhPJwYeZjRTrriYxBENEsGDiTCAauUg/JSwi9Ur6XUH/miSvOUu2eE8co0/Eh8tRvQGVqY8tG4fw==
X-Received: by 2002:a62:e217:0:b029:1c1:59ed:ae73 with SMTP id a23-20020a62e2170000b02901c159edae73mr77195pfi.6.1612456652596;
        Thu, 04 Feb 2021 08:37:32 -0800 (PST)
Received: from localhost.localdomain (61-230-45-44.dynamic-ip.hinet.net. [61.230.45.44])
        by smtp.gmail.com with ESMTPSA id 9sm2371133pgw.61.2021.02.04.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:37:31 -0800 (PST)
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
Date:   Fri,  5 Feb 2021 00:37:21 +0800
Message-Id: <20210204163721.91295-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204150100.GE20815@willie-the-truck>
References: <20210204150100.GE20815@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Feb 04, 2021 at 10:46:12PM +0800, Lecopzer Chen wrote:
> > > On Sat, Jan 09, 2021 at 06:32:49PM +0800, Lecopzer Chen wrote:
> > > > Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > > > ("kasan: support backing vmalloc space with real shadow memory")
> > > >
> > > > Like how the MODULES_VADDR does now, just not to early populate
> > > > the VMALLOC_START between VMALLOC_END.
> > > > similarly, the kernel code mapping is now in the VMALLOC area and
> > > > should keep these area populated.
> > > >
> > > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > > > ---
> > > >  arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
> > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > > > index d8e66c78440e..39b218a64279 100644
> > > > --- a/arch/arm64/mm/kasan_init.c
> > > > +++ b/arch/arm64/mm/kasan_init.c
> > > > @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
> > > >  {
> > > >   u64 kimg_shadow_start, kimg_shadow_end;
> > > >   u64 mod_shadow_start, mod_shadow_end;
> > > > + u64 vmalloc_shadow_start, vmalloc_shadow_end;
> > > >   phys_addr_t pa_start, pa_end;
> > > >   u64 i;
> > > >
> > > > @@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
> > > >   mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
> > > >   mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> > > >
> > > > + vmalloc_shadow_start = (u64)kasan_mem_to_shadow((void *)VMALLOC_START);
> > > > + vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> > > > +
> > > >   /*
> > > >    * We are going to perform proper setup of shadow memory.
> > > >    * At first we should unmap early shadow (clear_pgds() call below).
> > > > @@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void)
> > > >
> > > >   kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
> > > >                              (void *)mod_shadow_start);
> > > > - kasan_populate_early_shadow((void *)kimg_shadow_end,
> > > > -                            (void *)KASAN_SHADOW_END);
> > > > + if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> > >
> > > Do we really need yet another CONFIG option for KASAN? What's the use-case
> > > for *not* enabling this if you're already enabling one of the KASAN
> > > backends?
> >
> > As I know, KASAN_VMALLOC now only supports KASAN_GENERIC and also
> > KASAN_VMALLOC uses more memory to map real shadow memory (1/8 of vmalloc va).
>
> The shadow is allocated dynamically though, isn't it?

Yes, but It's still a cost.

> > There should be someone can enable KASAN_GENERIC but can't use VMALLOC
> > due to memory issue.
>
> That doesn't sound particularly realistic to me. The reason I'm pushing here
> is because I would _really_ like to move to VMAP stack unconditionally, and
> that would effectively force KASAN_VMALLOC to be set if KASAN is in use.
>
> So unless there's a really good reason not to do that, please can we make
> this unconditional for arm64? Pretty please?

I think it's fine since we have a good reason.
Also if someone have memory issue in KASAN_VMALLOC,
they can use SW_TAG, right?

However the SW_TAG/HW_TAG is not supported VMALLOC yet.
So the code would be like

	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
		/* explain the relationship between 
		 * KASAN_GENERIC and KASAN_VMALLOC in arm64
		 * XXX: because we want VMAP stack....
		 */
		kasan_populate_early_shadow((void *)vmalloc_shadow_end,
					    (void *)KASAN_SHADOW_END);
	else {
		kasan_populate_early_shadow((void *)kimg_shadow_end,
					    (void *)KASAN_SHADOW_END);
		if (kimg_shadow_start > mod_shadow_end)
			kasan_populate_early_shadow((void *)mod_shadow_end,
						    (void *)kimg_shadow_start);
	}

and the arch/arm64/Kconfig will add
	select KASAN_VMALLOC if KASAN_GENERIC

Is this code same as your thought?

BRs,
Lecopzer

