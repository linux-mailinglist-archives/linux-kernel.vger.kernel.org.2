Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8221D38907C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354151AbhESORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354129AbhESOQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:16:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E70C61363;
        Wed, 19 May 2021 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621433690;
        bh=rRFc0ILonpYJdVr2TDsn36MJ5mLmgIkTfeLqsV9zN18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BA6uFoGr6PP2RAvPnkryuSxFifPl/Ue7ySDROfWzKgKQq3GkQKW9rq19ourCeWb3A
         EVJMLpe52ov/1XQQRzdo/VMfIwHU3UIiKVOc/e0zRsSODYzLbhnNMsgknLdyUdKnJv
         q4iJsh/+6FOA/smUL0yOT0rWAfbHqgYQ7/UZWFsOziOXkd5aB0b+rDKfw/oX9/s7r+
         sB+ROfVm0ePvuMaE86faSHvNK6NUa3W5f8n0Znzu2JG7TXH+VqTR9UacVSZVeUQ7XC
         iIt3V/eHuYSB9QaVMwoY6ly0izSm/TjTkBDb2sD6JCQKoGFKh1fKzEVoVuex31/Pok
         JvLmqqr6QESjA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 3/3] arm: extend pfn_valid to take into accound freed memory map alignment
Date:   Wed, 19 May 2021 17:14:36 +0300
Message-Id: <20210519141436.11961-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210519141436.11961-1-rppt@kernel.org>
References: <20210519141436.11961-1-rppt@kernel.org>
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

