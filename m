Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1730AF92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhBASi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhBASdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:33:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA7C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:32:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m1so165515wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X1e7uq4kR7Qyf8vg6mQEwE7WTrkblxRLBormJ+wirLs=;
        b=C+4W+EV1opsXLhh2x0cuvBhCUOHqnGSj5+6rJa/B97H211efoahq0vQlM+jCDl3Y11
         K/xnDxVOwdvdPMMtIhJl2y1H9K+Pz39rVMDLQKolNmGWRSrDK3aydtsvDvKnzpQGSGlc
         cJH5FXyeGzUJOWurqtWKI9wt13iOVpBgoYeuoKalIkMvCVjfRhn8iUmojlTBu46PM2Jg
         Azde8IEVIXhM6VChQ+l0bEdOCv+NIKRDoHIPvZ+2+SWEBn0cRXlHthRBW2XvJsGXuh17
         2rkOKp2NqChqqT08u3yV8IEAUhmZtM+DYYILNZnshe3Vvk+lOb1iEpYZ2NH/W8NZ6Zgy
         CBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X1e7uq4kR7Qyf8vg6mQEwE7WTrkblxRLBormJ+wirLs=;
        b=UHA5pRVx6NYqXHfJ5PrhrwZoqvB1VFKPXJSlsrYi9PnhY290AlkKdJ9Hqz+2FSDjqH
         n0F3C35YFS3qLZKc9xnkmSK0u07qn4edQhnFYmVXI9VULucmJzH/bQS5LHxjrIg1ICPp
         r87qI/nt1Rm9p9uFs2acWH1lsCEeGGYI4N/XCjP8SuLR1P9A5193zAs78+5cqUK/O753
         rKUx4osEBMYlJTlNM0TFDC61lT7dwoYBPkRFJnhOwgGau3ebno4omswkNkh8c6kllwb0
         ABFfcl6EU0C+Y569c4kgIu2gNHpXJT2n6O7NKrgQEpKjGqHKBh23YBNEdXzEas7Hv3Wz
         bHxg==
X-Gm-Message-State: AOAM531E1nOrVlm7WU9kUML/XnfGl/3Ja/h1A8pdhRmfmJ6aW65YZx/L
        suRCWHF0noCGLqmOo2sAy0w5Uw==
X-Google-Smtp-Source: ABdhPJxteAGEppN8MDkMgzCZyAxEHssuXAw6nVj17GUrFFkCiZmxU3XNsfUysd4wW5k56sT0G6SJHg==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr155625wmd.189.1612204375560;
        Mon, 01 Feb 2021 10:32:55 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id i15sm119475wmq.26.2021.02.01.10.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:32:54 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:32:52 +0000
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
Subject: Re: [RFC PATCH v2 06/26] KVM: arm64: Factor memory allocation out of
 pgtable.c
Message-ID: <YBhJVPz124QRAYFf@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-7-qperret@google.com>
 <20210201181607.GD15632@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201181607.GD15632@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 Feb 2021 at 18:16:08 (+0000), Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:04PM +0000, Quentin Perret wrote:
> > In preparation for enabling the creation of page-tables at EL2, factor
> > all memory allocation out of the page-table code, hence making it
> > re-usable with any compatible memory allocator.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h | 32 +++++++++-
> >  arch/arm64/kvm/hyp/pgtable.c         | 90 +++++++++++++++++-----------
> >  arch/arm64/kvm/mmu.c                 | 70 +++++++++++++++++++++-
> >  3 files changed, 154 insertions(+), 38 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 52ab38db04c7..45acc9dc6c45 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -13,17 +13,41 @@
> >  
> >  typedef u64 kvm_pte_t;
> >  
> > +/**
> > + * struct kvm_pgtable_mm_ops - Memory management callbacks.
> > + * @zalloc_page:	Allocate a zeroed memory page.
> 
> Please describe the 'arg' parameter.
> 
> > + * @zalloc_pages_exact:	Allocate an exact number of zeroed memory pages.
> 
> I think this comment coulld be expanded somewhat to make it clear that (a)
> the 'size' parameter is in bytes rather than pages (b) the rounding
> behaviour applied if 'size' is not page-aligned and (c) that the resulting
> allocation is physically contiguous.
> 
> > + * @free_pages_exact:	Free an exact number of memory pages.
> > + * @get_page:		Increment the refcount on a page.
> > + * @put_page:		Decrement the refcount on a page.
> > + * @page_count:		Returns the refcount of a page.
> > + * @phys_to_virt:	Convert a physical address into a virtual address.
> > + * @virt_to_phys:	Convert a virtual address into a physical address.
> 
> I think it would be good to be explicit about the nature of the virtual
> address here. We've dealing with virtual addresses that are mapped in the
> current context rather than e.g. guest virtual addresses.

Ack to all the above.

> > + */
> > +struct kvm_pgtable_mm_ops {
> > +	void*		(*zalloc_page)(void *arg);
> > +	void*		(*zalloc_pages_exact)(size_t size);
> > +	void		(*free_pages_exact)(void *addr, size_t size);
> > +	void		(*get_page)(void *addr);
> > +	void		(*put_page)(void *addr);
> > +	int		(*page_count)(void *addr);
> > +	void*		(*phys_to_virt)(phys_addr_t phys);
> > +	phys_addr_t	(*virt_to_phys)(void *addr);
> > +};
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 1f41173e6149..278e163beda4 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -88,6 +88,48 @@ static bool kvm_is_device_pfn(unsigned long pfn)
> >  	return !pfn_valid(pfn);
> >  }
> >  
> > +static void *stage2_memcache_alloc_page(void *arg)
> > +{
> > +	struct kvm_mmu_memory_cache *mc = arg;
> > +	kvm_pte_t *ptep = NULL;
> > +
> > +	/* Allocated with GFP_KERNEL_ACCOUNT, so no need to zero */
> 
> I couldn't spot where GFP_KERNEL_ACCOUNT implies __GFP_ZERO.

I'm not suprised, it doesn't. Broken comment clearly, I'll fix with
s/GFP_KERNEL_ACCOUNT/__GFP_ZERO

> Please can you elaborate?
> 
> > +	if (mc && mc->nobjs)
> > +		ptep = mc->objects[--mc->nobjs];
> > +
> > +	return ptep;
> > +}
> 
> Why can't we use kvm_mmu_memory_cache_alloc() directly instead of opening up
> the memory_cache?

I think we can -- that function didn't exist when I first wrote this,
but no good reason not to use it now.

> > +static void *kvm_host_zalloc_pages_exact(size_t size)
> > +{
> > +	return alloc_pages_exact(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> 
> Hmm, so now we're passing __GFP_ZERO? ;)

:-)

> > +static void kvm_host_get_page(void *addr)
> > +{
> > +	get_page(virt_to_page(addr));
> > +}
> > +
> > +static void kvm_host_put_page(void *addr)
> > +{
> > +	put_page(virt_to_page(addr));
> > +}
> > +
> > +static int kvm_host_page_count(void *addr)
> > +{
> > +	return page_count(virt_to_page(addr));
> > +}
> > +
> > +static phys_addr_t kvm_host_pa(void *addr)
> > +{
> > +	return __pa(addr);
> > +}
> > +
> > +static void *kvm_host_va(phys_addr_t phys)
> > +{
> > +	return __va(phys);
> > +}
> > +
> >  /*
> >   * Unmapping vs dcache management:
> >   *
> > @@ -351,6 +393,17 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
> >  	return 0;
> >  }
> >  
> > +static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
> > +	.zalloc_page		= stage2_memcache_alloc_page,
> > +	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
> > +	.free_pages_exact	= free_pages_exact,
> > +	.get_page		= kvm_host_get_page,
> > +	.put_page		= kvm_host_put_page,
> > +	.page_count		= kvm_host_page_count,
> > +	.phys_to_virt		= kvm_host_va,
> > +	.virt_to_phys		= kvm_host_pa,
> > +};
> 
> Idle thought, but I wonder whether it would be better to have these
> implementations as the default and make the mm_ops structure parameter
> to kvm_pgtable_stage2_init() optional? I guess you don't gain an awful
> lot though, so feel free to ignore me.

No strong opinion really, but I suppose I could do something as simple
as having static inline wrappers which provide kvm_s2_mm_ops to the
pgtable API for me. I'll probably want to make sure these are not
defined when compiling EL2 code, though, to avoid confusion.

Or maybe you had something else in mind?

Cheers,
Quentin
