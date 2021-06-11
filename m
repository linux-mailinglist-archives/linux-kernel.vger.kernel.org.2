Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2013A3E13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFKIge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:36:34 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:56117 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbhFKIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:36:33 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 2C0F91C33CB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:34:35 +0100 (IST)
Received: (qmail 18836 invoked from network); 11 Jun 2021 08:34:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Jun 2021 08:34:34 -0000
Date:   Fri, 11 Jun 2021 09:34:33 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored
 on the per-cpu lists
Message-ID: <20210611083433.GA30378@techsingularity.net>
References: <20210603142220.10851-1-mgorman@techsingularity.net>
 <20210603142220.10851-3-mgorman@techsingularity.net>
 <88FCC7AA-FAAA-4B87-B382-50BD54B2886B@nvidia.com>
 <20210610111821.GY30378@techsingularity.net>
 <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 07:40:47AM -0400, Zi Yan wrote:
> >> qemu-system-x86_64 -kernel ~/repos/linux-1gb-thp/arch/x86/boot/bzImage \
> >>     -drive file=~/qemu-image/vm.qcow2,if=virtio \
> >>     -append "nokaslr root=/dev/vda1 rw console=ttyS0 " \
> >>     -pidfile vm.pid \
> >>     -netdev user,id=mynet0,hostfwd=tcp::11022-:22 \
> >>     -device virtio-net-pci,netdev=mynet0 \
> >>     -m 16g -smp 6 -cpu host -enable-kvm -nographic \
> >>     -machine hmat=on -object memory-backend-ram,size=8g,id=m0 \
> >>     -object memory-backend-ram,size=8g,id=m1 \
> >>     -numa node,memdev=m0,nodeid=0 -numa node,memdev=m1,nodeid=1
> >>
> >> The attached config has THP disabled. The VM cannot boot with THP enabled,
> >> either.
> >>
> >
> > There is not a lot of information to go on here. Can you confirm that a
> > revert of that specific patch from mmotm-2021-06-07-18-33 also boots? It
> > sounds like your console log is empty, does anything useful appear if
> > you add "earlyprintk=serial,ttyS0,115200" to the kernel command line?
> 
> Sure. I can confirm that reverting the patch makes the VM boot.
> The important information I forgot to mention is that after I remove
> the NUMA setting in the QEMU, the VM can boot too.
> 
> earlyprintk gave the error message (page out of zone boundary) when the VM could not boot:
> 

Can you test with the following patch please?

--8<---
mm/page_alloc: Allow high-order pages to be stored on the per-cpu lists -fix

Zi Ya reported the following problem

  I am not able to boot my QEMU VM with v5.13-rc5-mmotm-2021-06-07-18-33.
  git bisect points to this patch. The VM got stuck at "Booting from ROM"

"This patch" is "mm/page_alloc: Allow high-order pages to be stored on
the per-cpu lists" and earlyprintk showed the following

  [    0.161237] Memory: 16396772K/16776684K available (18452K kernel code, 3336K rwdata, 8000K rodata, 1852K init, 1444K bss, 379656K reserved, 0K cma-reserve)
  [    0.162451] page 0x100041 outside node 1 zone Normal [ 0x240000 - 0x440000 ]
  [    0.163057] page:(____ptrval____) refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100041

The patch is allowing pages from different zones to exist on the PCP
lists which is not allowed. Review found two problems -- first, the
bulk allocator is not using the correct PCP lists. It happens to work
because it's order-0 only but it's wrong. The real problem is that the
boot pagesets can store free pages which is not allowed.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6d90f046c94..8472bae567f0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3625,7 +3625,15 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = READ_ONCE(pcp->batch);
 			int alloced;
 
-			batch = max(batch >> order, 2);
+			/*
+			 * Scale batch relative to order if batch implies
+			 * free pages can be stored on the PCP. Batch can
+			 * be 1 for small zones or for boot pagesets which
+			 * should never store free pages as the pages may
+			 * belong to arbitrary zones.
+			 */
+			if (batch > 1)
+				batch = max(batch >> order, 2);
 			alloced = rmqueue_bulk(zone, order,
 					batch, list,
 					migratetype, alloc_flags);
@@ -5265,7 +5273,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	/* Attempt the batch allocation */
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	pcp_list = &pcp->lists[ac.migratetype];
+	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 
 	while (nr_populated < nr_pages) {
 
