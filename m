Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4044E657
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhKLMd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhKLMdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:33:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEE6860F93;
        Fri, 12 Nov 2021 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636720234;
        bh=jVMeD9Xk20NXP6AWwjjHfR2HjgtBJB3Z3ceF1QKverY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paws5f4rVZt1nXm7Q6IwM+hxWcIUNrorrVeh2cEKQvxOClklZsfcn9FIyB3OSUv2g
         eg6fMxriszXDHnYwutHZPGD9eRBDsRSdUNcx60CWBAUHOq9Wdvo4m9IouNE8EsmlNn
         yLBW/IgjkJLBelkdsn7AKuv76qGeqg5nBVZdivfbYHhVMPbRcWkybRZNnlJPnn++YX
         c7kFyCB6wio2I2KWvqAELJS7H5rSZJv96Lmr+kC593y2pSUukq/9+ZZA6Dd+CS2+ay
         jZrpsricauByxamcfg9GN710NVPjPMovagR2MRMEkTZhvPFodvgFJASPAab1bLdT2g
         7TyuuLbtWczCQ==
Date:   Fri, 12 Nov 2021 14:30:24 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 4/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for
 direct map allocations
Message-ID: <YY5eYEzsp0UKn4Xr@kernel.org>
References: <20211111110241.25968-1-rppt@kernel.org>
 <20211111110241.25968-5-rppt@kernel.org>
 <5aee7bcdf49b1c6b8ee902dd2abd9220169c694b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aee7bcdf49b1c6b8ee902dd2abd9220169c694b.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 09:35:56PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2021-11-11 at 13:02 +0200, Mike Rapoport wrote:
> > The allocations of the direct map pages are mostly happen very early
> > during
> > the system boot and they use either the page table cache in brk area
> > of bss
> > or memblock.
> > 
> > The few callers that effectively use page allocator for the direct
> > map
> > updates are gart_iommu_init() and memory hotplug. Neither of them
> > happen in
> > an atomic context so there is no reason to use GFP_ATOMIC for these
> > allocations.
> 
> There are some other places where these paths could get triggered.
> alloc_low_pages() gets called by a bunch of memremap_pages() callers.
> spp_getpage() gets called from the set_fixmap() family of functions. I
> guess you are saying those should not end up triggering an allocation
> post-after_bootmem?
> 
> I went ahead and did a search, and found this getting called in a timer
> delay:
> ghes_poll_func()
>   spin_lock_irqsave()
>   ghes_proc()
>     ghes_read_estatus()
>       __ghes_read_estatus()
>         ghes_copy_tofrom_phys()
>           ghes_map()
>             __set_fixmap()
>               ...spp_getpage()?
> 
> I’m not sure if it’s possible to hit, but potentially it could splat
> about not being able to sleep? It would depend on something else not
> already mapping the needed fixmap pte, which maybe would never happen.
> It seems a little rickety though.

The fixmap is less 2M so all the page tables will be allocated from gpt
cache/memblock so __set_fixmap() will be essentially a call to set_pte().

I'll see how to ensure that page tables for ghex fixmaps are explicitly
preallocated at init time.
 
> For alloc_low_pages(), I noticed the callers don’t check for allocation
> failure. I'm a little surprised that there haven't been reports of the
> allocation failing, because these operations could result in a lot more
> pages getting allocated way past boot, and failure causes a NULL
> pointer dereference.

The allocations at init time are really unlikely to succeed.
As for the memory hotplug, the hotplug will likely fail if there is no
memory, but the failure may be attributed to an error elsewhere.

I'm all for adding checks for allocation errors, but I don't think this is
strictly related to this patch.
 
> I checked over the alloc_low_pages() callers and I didn’t see any
> problems removing GFP_ATOMIC, but I wonder if it should try harder to
> allocate. Or properly check for allocation failure in the callers, to
> prevent pre-existing risk of crash. GFP_KERNEL doesn’t look to make it
> any worse though, and I guess probably slightly less likely to crash.

-- 
Sincerely yours,
Mike.
