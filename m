Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1D387CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350454AbhERPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239415AbhERPyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:54:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7738F6113C;
        Tue, 18 May 2021 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621353180;
        bh=4kv5abT7oiIIz6ju/18dV+Xm4OFZ4dg7wtiIMxBVNrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHqvuXdCSTQAybR5GKviZoMp2zbr3jh0AzGIHTEo+mVmumadAVcTmX6KvLiEWKlvH
         VVMN6YXlKCtqxvOy5fl6pB178SSAowK9hxaATMdpefG+ogxpaEENuASLJnXgMtQbNv
         eFODP0LHIR+XGAH8tRO1J7Zx4GT1yT+FGVTLO3Lbqh1APd4npnopsZeVGMNJKeb0YA
         uL1oRiqkx7soA023g/pM0wqKG5/PKczPcS/QBt6Ahe7hs0gMUyAx+pnn1aMR5Yegfg
         0KHGNYYZio0R6zOesUXiaZZazYtxiMwYpm5NcOr5b2Q5DjoH6YzFGgi1L+vWxDCLrz
         usic/dp1IaiJw==
Date:   Tue, 18 May 2021 18:52:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] arm: extend pfn_valid to take into accound freed
 memory map alignment
Message-ID: <YKPi0eBWsHBDZCg/@kernel.org>
References: <20210518090613.21519-1-rppt@kernel.org>
 <20210518090613.21519-4-rppt@kernel.org>
 <2d34f990-c609-88aa-1dc0-f8e9e9623fc3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d34f990-c609-88aa-1dc0-f8e9e9623fc3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 08:49:43PM +0800, Kefeng Wang wrote:
> 
> 
> On 2021/5/18 17:06, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > When unused memory map is freed the preserved part of the memory map is
> > extended to match pageblock boundaries because lots of core mm
> > functionality relies on homogeneity of the memory map within pageblock
> > boundaries.
> > 
> > Since pfn_valid() is used to check whether there is a valid memory map
> > entry for a PFN, make it return true also for PFNs that have memory map
> > entries even if there is no actual memory populated there.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   arch/arm/mm/init.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index 9d4744a632c6..bb678c0ba143 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -125,11 +125,24 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
> >   int pfn_valid(unsigned long pfn)
> >   {
> >   	phys_addr_t addr = __pfn_to_phys(pfn);
> > +	unsigned long pageblock_size = PAGE_SIZE * pageblock_nr_pages;
> >   	if (__phys_to_pfn(addr) != pfn)
> >   		return 0;
> > -	return memblock_is_map_memory(addr);
> > +	if (memblock_is_map_memory(addr))
> > +		return 1;
> > +
> > +	/*
> > +	 * If address less than pageblock_size bytes away from a present
> > +	 * memory chunk there still will be a memory map entry for it
> > +	 * because we round freed memory map to the pageblock boundaries
> > +	 */
> > +	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
> > +	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
> > +		return 1;
> 
> Hi Mike, with patch3, the system won't boot.

Hmm, apparently I've miscalculated the ranges...

Can you please check with the below patch on top of this series:

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index bb678c0ba143..2fafbbc8e73b 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -138,8 +138,9 @@ int pfn_valid(unsigned long pfn)
 	 * memory chunk there still will be a memory map entry for it
 	 * because we round freed memory map to the pageblock boundaries
 	 */
-	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
-	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
+	if (memblock_overlaps_region(&memblock.memory,
+				     ALIGN_DOWN(addr, pageblock_size),
+				     pageblock_size);
 		return 1;
 
 	return 0;

-- 
Sincerely yours,
Mike.
