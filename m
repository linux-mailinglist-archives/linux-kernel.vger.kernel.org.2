Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03913318531
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 07:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBKGWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 01:22:50 -0500
Received: from foss.arm.com ([217.140.110.172]:47408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhBKGWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 01:22:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2AC411B3;
        Wed, 10 Feb 2021 22:22:02 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.94.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAD7D3F73B;
        Wed, 10 Feb 2021 22:21:57 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org, will@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/page_alloc: Fix pageblock_order when HUGETLB_PAGE_ORDER >= MAX_ORDER
Date:   Thu, 11 Feb 2021 11:52:09 +0530
Message-Id: <1613024531-19040-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With HUGETLB_PAGE_SIZE_VARIABLE enabled, pageblock_order cannot be assigned
as HUGETLB_PAGE_ORDER when it is greater than or equal to MAX_ORDER during
set_pageblock_order(). Otherwise  the following warning is triggered during
boot as detected on an arm64 platform.

WARNING: CPU: 5 PID: 124 at mm/vmstat.c:1080 __fragmentation_index+0xa4/0xc0
Modules linked in:
CPU: 5 PID: 124 Comm: kswapd0 Not tainted 5.11.0-rc6-00004-ga0ea7d62002 #159
Hardware name: linux,dummy-virt (DT)
[    8.810673] pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[    8.811732] pc : __fragmentation_index+0xa4/0xc0
[    8.812555] lr : fragmentation_index+0xf8/0x138
[    8.813360] sp : ffff0000864079b0
[    8.813958] x29: ffff0000864079b0 x28: 0000000000000372
[    8.814901] x27: 0000000000007682 x26: ffff8000135b3948
[    8.815847] x25: 1fffe00010c80f48 x24: 0000000000000000
[    8.816805] x23: 0000000000000000 x22: 000000000000000d
[    8.817764] x21: 0000000000000030 x20: ffff0005ffcb4d58
[    8.818712] x19: 000000000000000b x18: 0000000000000000
[    8.819656] x17: 0000000000000000 x16: 0000000000000000
[    8.820613] x15: 0000000000000000 x14: ffff8000114c6258
[    8.821560] x13: ffff6000bff969ba x12: 1fffe000bff969b9
[    8.822514] x11: 1fffe000bff969b9 x10: ffff6000bff969b9
[    8.823461] x9 : dfff800000000000 x8 : ffff0005ffcb4dcf
[    8.824415] x7 : 0000000000000001 x6 : 0000000041b58ab3
[    8.825359] x5 : ffff600010c80f48 x4 : dfff800000000000
[    8.826313] x3 : ffff8000102be670 x2 : 0000000000000007
[    8.827259] x1 : ffff000086407a60 x0 : 000000000000000d
[    8.828218] Call trace:
[    8.828667]  __fragmentation_index+0xa4/0xc0
[    8.829436]  fragmentation_index+0xf8/0x138
[    8.830194]  compaction_suitable+0x98/0xb8
[    8.830934]  wakeup_kcompactd+0xdc/0x128
[    8.831640]  balance_pgdat+0x71c/0x7a0
[    8.832327]  kswapd+0x31c/0x520
[    8.832902]  kthread+0x224/0x230
[    8.833491]  ret_from_fork+0x10/0x30
[    8.834150] ---[ end trace 472836f79c15516b ]---

The above warning happens because pageblock_order exceeds MAX_ORDER, caused
by large HUGETLB_PAGE_ORDER on certain platforms like arm64. Lets prevent
the scenario by first checking HUGETLB_PAGE_ORDER against MAX_ORDER, before
its assignment as pageblock_order.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d5b6f7..36473f2fa683 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6798,7 +6798,7 @@ void __init set_pageblock_order(void)
 	if (pageblock_order)
 		return;
 
-	if (HPAGE_SHIFT > PAGE_SHIFT)
+	if ((HPAGE_SHIFT > PAGE_SHIFT) && (HUGETLB_PAGE_ORDER < MAX_ORDER))
 		order = HUGETLB_PAGE_ORDER;
 	else
 		order = MAX_ORDER - 1;
-- 
2.20.1

