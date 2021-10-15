Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF942ECE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhJOI6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233419AbhJOI6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAD2E61053;
        Fri, 15 Oct 2021 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634288170;
        bh=Q7ariDqv81ESrlC2dW0PuAyGJAandYcqDaiSNHfbxQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHWFxjgN0j6uy54kk+PuKWsQXZAravsfZY8pZKixqTo8/t9859egP1Fzz/r/UFP3j
         pKRuamEiuY/Dwc/+QpnfWTf/sWNNfhMwZbVWxVfub1kH4CRYdWRn5CQYjdbgLCac9o
         sh7ORqtEfm9q5AKGtzFZlP/kLNO/R2oFHLN3PRlxsXtO7/HYTzofgjq4C072XXT9lh
         KbGmTC7vqWacVxEn3eNhUgZ/EA7McQ1YvxSRGhlsTVouHPeADKh3UBp0IaceH36bIf
         Y9c+6PGwmjdmSCJ0ZadDxaYmKgTuJ65zPH3wNm8vQE6+zKn5B8ls+d97XXK85PZn9u
         zx39wdy59p99g==
Date:   Fri, 15 Oct 2021 11:55:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Oliver Glitta <glittao@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kasan-dev@googlegroups.com
Subject: Re: [lib/stackdepot] 1cd8ce52c5:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <YWlCHtDOLAzDTU67@kernel.org>
References: <20211014085450.GC18719@xsang-OptiPlex-9020>
 <4d99add1-5cf7-c608-a131-18959b85e5dc@suse.cz>
 <YWgDkjqtJO4e3DM6@kernel.org>
 <137e4211-266f-bdb3-6830-e101c27c3be4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137e4211-266f-bdb3-6830-e101c27c3be4@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:27:17AM +0200, Vlastimil Babka wrote:
> On 10/14/21 12:16, Mike Rapoport wrote:
> > On Thu, Oct 14, 2021 at 11:33:03AM +0200, Vlastimil Babka wrote:
> >> On 10/14/21 10:54, kernel test robot wrote:
> >> 
> >> In my local testing of the patch, when stackdepot was initialized through
> >> page owner init, it was using kvmalloc() so slab_is_available() was true.
> >> Looks like the exact order of slab vs page_owner alloc is non-deterministic,
> >> could be arch-dependent or just random ordering of init calls. A wrong order
> >> will exploit the apparent fact that slab_is_available() is not a good
> >> indicator of using memblock vs page allocator, and we would need a better one.
> >> Thoughts?
> > 
> > The order of slab vs page_owner is deterministic, but it is different for
> > FLATMEM and SPARSEMEM. And page_ext_init_flatmem_late() that initializes
> > page_ext for FLATMEM is called exactly between buddy and slab setup:
> 
> Oh, so it was due to FLATMEM, thanks for figuring that out!
> 
> > static void __init mm_init(void)
> > {
> > 	...
> > 
> > 	mem_init();
> > 	mem_init_print_info();
> > 	/* page_owner must be initialized after buddy is ready */
> > 	page_ext_init_flatmem_late();
> > 	kmem_cache_init();
> > 
> > 	...
> > }
> > 
> > I've stared for a while at page_ext init and it seems that the
> > page_ext_init_flatmem_late() can be simply dropped because there is anyway
> > a call to invoke_init_callbacks() in page_ext_init() that is called much
> > later in the boot process.
> 
> Yeah, but page_ext_init() only does something for SPARSEMEM, and is empty on
> FLATMEM. Otherwise it would be duplicating all the work. So I'll just move
> page_ext_init_flatmem_late() below kmem_cache_init() in mm_init().

I hope at some point we'll have cleaner mm_init(), but for now simply
moving page_ext_init_flatmem_late() should work.

> Thanks again!

Welcome :)
 

-- 
Sincerely yours,
Mike.
