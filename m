Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26BC3B7DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhF3HPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232870AbhF3HO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:14:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6071461CC0;
        Wed, 30 Jun 2021 07:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625037149;
        bh=4lZi2ByWBD8jlDCnRUevXMAgObek5/VFvTH3/bPm2EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBvVmkTL7uSEHD2WwVlJBNvtGcC3Nz2xDzvqmK6ZcNj5hRA6FngfMVPlL0aibIm8u
         uEPDLDjmIIdw9FQn+/aU0YvjiLRUNocqpEEDIuwSwldZsMnTaU8lVtEUR5JvU0zEcG
         nObX//WWjwB6evvr3tDnXVSsyH0pe5ZY2IO8HR9NCxuaHy1RYl2xrk9PaQGSfCdVxE
         +qmmiZf0i7VDXIlUsNYq67zVblQV30eInCyDmURwF+PeAlq2IHi8y6PGm9Co7K/MtZ
         +NREM9+ObdR7OyR+ZAPwk+7ltrC5w2qxCIRvSEpsFkG9NZ3y34h8MPqmFlUu7T+89T
         IWQQ7Mh5z9itw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 4/4] arm: extend pfn_valid to take into account freed memory map alignment
Date:   Wed, 30 Jun 2021 10:12:11 +0300
Message-Id: <20210630071211.21011-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210630071211.21011-1-rppt@kernel.org>
References: <20210630071211.21011-1-rppt@kernel.org>
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
Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/init.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 9d4744a632c6..6162a070a410 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -125,11 +125,22 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 int pfn_valid(unsigned long pfn)
 {
 	phys_addr_t addr = __pfn_to_phys(pfn);
+	unsigned long pageblock_size = PAGE_SIZE * pageblock_nr_pages;
 
 	if (__phys_to_pfn(addr) != pfn)
 		return 0;
 
-	return memblock_is_map_memory(addr);
+	/*
+	 * If address less than pageblock_size bytes away from a present
+	 * memory chunk there still will be a memory map entry for it
+	 * because we round freed memory map to the pageblock boundaries.
+	 */
+	if (memblock_overlaps_region(&memblock.memory,
+				     ALIGN_DOWN(addr, pageblock_size),
+				     pageblock_size))
+		return 1;
+
+	return 0;
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
2.28.0

