Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBE30BB4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBBJqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhBBJpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:45:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4DC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:44:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w4so462663wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSSaPfRwvDGbQxdeByNUZ9wyHZguwKJIHB4orZkRX1U=;
        b=icnf8IsQd9Q4RXyrczWdoSkwbyXLaEO6875Us6xORHCs9Jiwot3EFoxuqn8jHAGlqJ
         WC9WKxlkoKRuzYW5lQfPyf4X37E2NgGZDBulxh+ddu/9JSwp7kTe2nPHMnMwFxfB+YhR
         7c1qWY/YfsE22reCcr1x+CsicRskIT1cq/Bh9JrQ3TPma5wZyf9A53G78pmr9m62vImQ
         6gIsG+A2mm3O1Ic7fDPm1buPDEDNp0MEFD3zZx1FYOsCutARFZKGY4yA1Umv41CoszTH
         /FUg8mWpEJuh2GWVvmFLwAv7tvSIGUo4oSD0BvbjJXwUDW/SYj1Q2/JACFpZ/hiIf/u8
         SkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSSaPfRwvDGbQxdeByNUZ9wyHZguwKJIHB4orZkRX1U=;
        b=Wg8pCAell45PcwfXIrbH+G6HTQAFYFqlVeh1ENe9gE+amVl7kDf6Yks5hqZu4tSGeG
         rkx+sVlxsk/SGKkC6ayPGDrFtF+qd6VyRKMD6nwau6uXHs9FB7qORcDZM0923Qx+fVvC
         1mThA3/s4AisSKbaEtJ+l0JOZOckJfUrffwuKQ8GqCj3BOtdC+es5K8AfYajKnXq2Pkn
         IUM8CGOZXiZV4fw2zYpuMmv7e/XPo6z27kWr/486SCF3/1nBW2VWixk/Nx9+Avb6RokG
         UMh4i+iXZ3bYcvpoEnC9MCnLnkh0XXN1OMqq5liMvroT37bxEVEOjqLy9vgcDOhjPpyF
         OQGQ==
X-Gm-Message-State: AOAM5312Ui727dvLW5wW3n+ltj97lpmIyJ/ir/ipz1v15Kcqi309q41u
        jy07JoANNltYshKo73yyajuExw==
X-Google-Smtp-Source: ABdhPJyFiDDkIMMluTAJ82TQKsuEQkfwk62lc0hmMunFauchGHnGuIDHT9S1UODUlL2ZopO0LOlhTQ==
X-Received: by 2002:a05:600c:24e:: with SMTP id 14mr2705390wmj.87.1612259076914;
        Tue, 02 Feb 2021 01:44:36 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id u1sm2169128wml.11.2021.02.02.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:44:36 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:44:33 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 10/26] KVM: arm64: Introduce an early Hyp page
 allocator
Message-ID: <YBkfAVC4KWPUnvI4@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-11-qperret@google.com>
 <20210201190008.GI15632@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201190008.GI15632@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 Feb 2021 at 19:00:08 (+0000), Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:08PM +0000, Quentin Perret wrote:
> > diff --git a/arch/arm64/kvm/hyp/nvhe/early_alloc.c b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
> > new file mode 100644
> > index 000000000000..de4c45662970
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 Google LLC
> > + * Author: Quentin Perret <qperret@google.com>
> > + */
> > +
> > +#include <asm/kvm_pgtable.h>
> > +
> > +#include <nvhe/memory.h>
> > +
> > +struct kvm_pgtable_mm_ops hyp_early_alloc_mm_ops;
> > +s64 __ro_after_init hyp_physvirt_offset;
> > +
> > +static unsigned long base;
> > +static unsigned long end;
> > +static unsigned long cur;
> > +
> > +unsigned long hyp_early_alloc_nr_pages(void)
> > +{
> > +	return (cur - base) >> PAGE_SHIFT;
> > +}
> 
> nit: but I find this function name confusing (it's returning the number of
> _allocated_ pages, not the number of _free_ pages!). How about something
> like hyp_early_alloc_size() to match hyp_s1_pgtable_size() which you add
> later? [and move the shift out to the caller]?

Works for me.

> > +extern void clear_page(void *to);
> 
> Stick this in a header?

Right, that, or perhaps just use asm/page.h directly -- I _think_ that
should work fine assuming with have the correct symbol aliasing in
place.

> > +
> > +void *hyp_early_alloc_contig(unsigned int nr_pages)
> 
> I think order might make more sense, or do you need to allocate
> non-power-of-2 batches of pages?

Indeed, I allocate page-aligned blobs of arbitrary size (e.g.
divide_memory_pool() in patch 16), so I prefer it that way.

> > +{
> > +	unsigned long ret = cur, i, p;
> > +
> > +	if (!nr_pages)
> > +		return NULL;
> > +
> > +	cur += nr_pages << PAGE_SHIFT;
> > +	if (cur > end) {
> 
> This would mean that concurrent hyp_early_alloc_nr_pages() would transiently
> give the wrong answer. Might be worth sticking the locking expectations with
> the function prototypes.

This is only called from a single CPU from a non-preemptible section, so
that is not a problem. But yes, I'll stick a comment.

> That said, maybe it would be better to write this check as:
> 
> 	if (end - cur < (nr_pages << PAGE_SHIFT))
> 
> as that also removes the need to worry about overflow if nr_pages is huge
> (which would be a bug in the hypervisor, which we would then catch here).

Sounds good.

> > +		cur = ret;
> > +		return NULL;
> > +	}
> > +
> > +	for (i = 0; i < nr_pages; i++) {
> > +		p = ret + (i << PAGE_SHIFT);
> > +		clear_page((void *)(p));
> > +	}
> > +
> > +	return (void *)ret;
> > +}
> > +
> > +void *hyp_early_alloc_page(void *arg)
> > +{
> > +	return hyp_early_alloc_contig(1);
> > +}
> > +
> > +void hyp_early_alloc_init(unsigned long virt, unsigned long size)
> > +{
> > +	base = virt;
> > +	end = virt + size;
> > +	cur = virt;
> 
> nit: base = cur = virt;

Ack.

Thanks for the review,
Quentin
