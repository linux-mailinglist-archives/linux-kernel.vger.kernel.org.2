Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B363367B18
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhDVHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231262AbhDVHah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:30:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 997EC6145E;
        Thu, 22 Apr 2021 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619076603;
        bh=GvHLrkjv+8OSfv0DFhto7kn97jmH4HlTtc9KLl6FFu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEdSmllRyEg3GlL6fG+QQxGmjjh8mn5FNwFOz2dK6HPHJ1DKQtONjppKpwZX6WwKm
         zTUBFONStme9eAX5Yp/tucFTyfUDifV52Jvk8/tweFJz5h0Tkur33U7zK+IqoecPxG
         AfclCDbDXzUtfM6wF4InX3oVYpnK3IIedrZy4BeCuEOvfnQaXLluNnvDW/cOCMdHUN
         4Du5U0a0uJxKBTiXnTTi1OhiOY2WwDNVY3ruGLAnY3bsSS+D0zn0jgIrIGIWA+2518
         UgTkkoL86MmFKi0SjMPoGNYnwfLu3Ag78kGee/2AQLjNwy7ccbIGvoODA1pjeLgfdb
         KGl0OzJVIPfZA==
Date:   Thu, 22 Apr 2021 10:29:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-ID: <YIEl8aKr8Ly0Zd3O@kernel.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 03:00:20PM +0800, Kefeng Wang wrote:
> 
> On 2021/4/21 14:51, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> > pfn_valid_within() to 1.
> > 
> > The idea is to mark NOMAP pages as reserved in the memory map and restore
> > the intended semantics of pfn_valid() to designate availability of struct
> > page for a pfn.
> > 
> > With this the core mm will be able to cope with the fact that it cannot use
> > NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> > will be treated correctly even without the need for pfn_valid_within.
> > 
> > The patches are only boot tested on qemu-system-aarch64 so I'd really
> > appreciate memory stress tests on real hardware.
> > 
> > If this actually works we'll be one step closer to drop custom pfn_valid()
> > on arm64 altogether.
> 
> Hi Mike，I have a question, without HOLES_IN_ZONE, the pfn_valid_within() in
> move_freepages_block()->move_freepages()
> will be optimized, if there are holes in zone, the 'struce page'(memory map)
> for pfn range of hole will be free by
> free_memmap(), and then the page traverse in the zone(with holes) from
> move_freepages() will meet the wrong page，
> then it could panic at PageLRU(page) test, check link[1],

First, HOLES_IN_ZONE name us hugely misleading, this configuration option
has nothing to to with memory holes, but rather it is there to deal with
holes or undefined struct pages in the memory map, when these holes can be
inside a MAX_ORDER_NR_PAGES region.

In general pfn walkers use pfn_valid() and pfn_valid_within() to avoid
accessing *missing* struct pages, like those that are freed at
free_memmap(). But on arm64 these tests also filter out the nomap entries
because their struct pages are not initialized.

The panic you refer to happened because there was an uninitialized struct
page in the middle of MAX_ORDER_NR_PAGES region because it corresponded to
nomap memory.

With these changes I make sure that such pages will be properly initialized
as PageReserved and the pfn walkers will be able to rely on the memory map.

Note also, that free_memmap() aligns the parts being freed on MAX_ORDER
boundaries, so there will be no missing parts in the memory map within a
MAX_ORDER_NR_PAGES region.
 
> "The idea is to mark NOMAP pages as reserved in the memory map", I see the
> patch2 check memblock_is_nomap() in memory region
> of memblock, but it seems that memblock_mark_nomap() is not called(maybe I
> missed), then memmap_init_reserved_pages() won't
> work, so should the HOLES_IN_ZONE still be needed for generic mm code?
> 
> [1] https://lore.kernel.org/linux-arm-kernel/541193a6-2bce-f042-5bb2-88913d5f1047@arm.com/
> 

-- 
Sincerely yours,
Mike.
