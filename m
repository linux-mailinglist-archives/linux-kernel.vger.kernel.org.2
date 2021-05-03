Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5ED37128D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhECIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhECIpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:45:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD14B610EA;
        Mon,  3 May 2021 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620031465;
        bh=ayNupM3q5p2pA01eseLR8Dv+rDUcAmtcqGwl5AQ6O2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0mYXgd4+L6ElyJNZknXe3/27PpgI89ZAmo86Oo4Jh3B2bGUBoxOcR0uTAMwEH42P
         NRNWtYOMGR2ig6xRKT6656l72sNDNMGgG9hqtDUEy8BBcdk//kuvaH+acF5uh8tTsC
         QgsVPqfImbiGiTIo2EqQs4UGludApb8J0jFv0y3dmZ7/W/gVgXowjEJ3RKmLCIYsbZ
         sWxNbolPcs6NXVZczlnCV7WNJzUGXU45ZN7NoZvYUzdp+JM+uEumnuJiLL3zfAREMa
         +SbRCvNmMD+sE2VHxro6dsvN/Q2vzTHIGwhN/5RQfz3IC1cvDC15rPef4cWPSu6W20
         xCKxVUWPMoB/A==
Date:   Mon, 3 May 2021 11:44:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
Message-ID: <YI+32ocTbec5Rm4e@kernel.org>
References: <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
 <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
 <YIpY8TXCSc7Lfa2Z@kernel.org>
 <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
 <YIvTM5Yqit8AB4W8@kernel.org>
 <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
 <YI+XrAg4KOzOyt7c@kernel.org>
 <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 10:07:01AM +0200, David Hildenbrand wrote:
> On 03.05.21 08:26, Mike Rapoport wrote:
> > On Fri, Apr 30, 2021 at 07:24:37PM +0800, Kefeng Wang wrote:
> > > 
> > > 
> > > On 2021/4/30 17:51, Mike Rapoport wrote:
> > > > On Thu, Apr 29, 2021 at 06:22:55PM +0800, Kefeng Wang wrote:
> > > > > 
> > > > > On 2021/4/29 14:57, Mike Rapoport wrote:
> > > > > 
> > > > > > > > Do you use SPARSMEM? If yes, what is your section size?
> > > > > > > > What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?
> > > > > > > Yes,
> > > > > > > 
> > > > > > > CONFIG_SPARSEMEM=y
> > > > > > > 
> > > > > > > CONFIG_SPARSEMEM_STATIC=y
> > > > > > > 
> > > > > > > CONFIG_FORCE_MAX_ZONEORDER = 11
> > > > > > > 
> > > > > > > CONFIG_PAGE_OFFSET=0xC0000000
> > > > > > > CONFIG_HAVE_ARCH_PFN_VALID=y
> > > > > > > CONFIG_HIGHMEM=y
> > > > > > > #define SECTION_SIZE_BITS    26
> > > > > > > #define MAX_PHYSADDR_BITS    32
> > > > > > > #define MAX_PHYSMEM_BITS     32
> > > > > 
> > > > > 
> > > > > With the patch,  the addr is aligned, but the panic still occurred,
> > > > 
> > > > Is this the same panic at move_freepages() for range [de600, de7ff]?
> > > > 
> > > > Do you enable CONFIG_ARM_LPAE?
> > > 
> > > no, the CONFIG_ARM_LPAE is not set, and yes with same panic at
> > > move_freepages at
> > > 
> > > start_pfn/end_pfn [de600, de7ff], [de600000, de7ff000] :  pfn =de600, page
> > > =ef3cc000, page-flags = ffffffff,  pfn2phy = de600000
> > > 
> > > > > __free_memory_core, range: 0xb0200000 - 0xc0000000, pfn: b0200 - b0200
> > > > > __free_memory_core, range: 0xcc000000 - 0xdca00000, pfn: cc000 - b0200
> > > > > __free_memory_core, range: 0xde700000 - 0xdea00000, pfn: de700 - b0200
> > 
> > Hmm, [de600, de7ff] is not added to the free lists which is correct. But
> > then it's unclear how the page for de600 gets to move_freepages()...
> > 
> > Can't say I have any bright ideas to try here...
> 
> Are we missing some checks (e.g., PageReserved()) that pfn_valid_within()
> would have "caught" before?

Unless I'm missing something the crash happens in __rmqueue_fallback():

do_steal:
	page = get_page_from_free_area(area, fallback_mt);

	steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
								can_steal);
		-> move_freepages() 
			-> BUG()

So a page from free area should be sane as the freed range was never added
it to the free lists.

And honestly, with the memory layout reported elsewhere in the stack I'd
say that the bootloader/fdt beg for fixes...

-- 
Sincerely yours,
Mike.
