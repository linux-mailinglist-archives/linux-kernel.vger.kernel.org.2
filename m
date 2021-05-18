Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60773874B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbhERJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347795AbhERJHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C13561209;
        Tue, 18 May 2021 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621328790;
        bh=9+8VlIrFfLEmzRoxqWF0ylaXDWsmZt0DQAU8LObraoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tum/Yu+aKBsznhRuVylQK1gPSXlk4/7f+dqaXzkFCAWeO/0tZdRrJZtzGTM6D28JO
         kNXoQsHu8pYcBj4X1N6ufEmYx14mMILc9d/2tIvJVWRyafGupktUOVExadKNVYaMGZ
         llENDa6we67Ooe34Xi2kSQ/P6XCtnqQ5WnnqX9SoyRCkHAwcWOxOdhZTeF86UzVNxL
         04embraLt7uvp7lZ/rLgrZ6w2rjJAcQRUn/cTkCXggepKY2CGsNGa+ScXwBTxXyKTs
         SBvoaM2ND8iIQF2D7E+02+2ciTrM3HEhoMf5yOI0k+bMMe8zfn6o1H8bWgy6toeWHM
         gbkuHTV/w6DmA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/3] arm: extend pfn_valid to take into accound freed memory map alignment
Date:   Tue, 18 May 2021 12:06:13 +0300
Message-Id: <20210518090613.21519-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210518090613.21519-1-rppt@kernel.org>
References: <20210518090613.21519-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When unused memory map is freed the preserved part of the memory map is
extended to match pageblock boundaries because lots of core mm
functionality relies on homogeneity of the memory map within pageblock
boundaries.

Since pfn_valid() is used to check whether there is a valid memory map
entry for a PFN, make it return true also for PFNs that have memory map
entries even if there is no actual memory populated there.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 9d4744a632c6..bb678c0ba143 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -125,11 +125,24 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 int pfn_valid(unsigned long pfn)
 {
 	phys_addr_t addr = __pfn_to_phys(pfn);
+	unsigned long pageblock_size = PAGE_SIZE * pageblock_nr_pages;
 
 	if (__phys_to_pfn(addr) != pfn)
 		return 0;
 
-	return memblock_is_map_memory(addr);
+	if (memblock_is_map_memory(addr))
+		return 1;
+
+	/*
+	 * If address less than pageblock_size bytes away from a present
+	 * memory chunk there still will be a memory map entry for it
+	 * because we round freed memory map to the pageblock boundaries
+	 */
+	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
+	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
+		return 1;
+
+	return 0;
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
2.28.0

