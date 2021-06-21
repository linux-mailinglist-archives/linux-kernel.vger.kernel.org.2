Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11A3AE92F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFUMhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:37:42 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46352 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhFUMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:37:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ud9mD0E_1624278924;
Received: from localhost(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0Ud9mD0E_1624278924)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 20:35:24 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com, tglx@linutronix.de
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        luoben@linux.alibaba.com, yaohuiwang@linux.alibaba.com
Subject: [PATCH v3 1/2] x86/ioremap: fix the pfn calculation mistake in __ioremap_check_ram()
Date:   Mon, 21 Jun 2021 20:34:18 +0800
Message-Id: <20210621123419.2976-2-yaohuiwang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
References: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __ioremap_check_ram(), the pfn wrapping calculation supposes res->start
to be page-aligned and res->end to be PAGE_SIZE - 1 aligned. But
res->start and res->end may not follow such alignment, which may make the
RAM checking be omitted for the very start page or the very end page of
the memory range. This can cause ioremap_xxx() to succeed on normal RAM by
mistake.

For example, suppose memory range [phys_addr ~ phys_addr + PAGE_SIZE - 1]
is a normal RAM page. ioremap(phys_addr, PAGE_SIZE - 1) will succeed
(but it should not) because the pfn wrapping prevents this page to be
checked whether it touches non-ioremappable resources.

The new pfn wrapping calculation makes sure the resulting pfn range covers
[res->start, res->end] completely.

Fixes: 0e4c12b45aa8 (x86/mm, resource: Use PAGE_KERNEL protection for ioremap of memory pages)
Signed-off-by: Yahui Wang <yaohuiwang@linux.alibaba.com>
Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 arch/x86/mm/ioremap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7dd71bd..609a8bd6f680 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -68,19 +68,19 @@ int ioremap_change_attr(unsigned long vaddr, unsigned long size,
 /* Does the range (or a subset of) contain normal RAM? */
 static unsigned int __ioremap_check_ram(struct resource *res)
 {
-	unsigned long start_pfn, stop_pfn;
+	unsigned long start_pfn, stop_pfn, npages;
 	unsigned long i;
 
 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
 		return 0;
 
-	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
-	if (stop_pfn > start_pfn) {
-		for (i = 0; i < (stop_pfn - start_pfn); ++i)
-			if (pfn_valid(start_pfn + i) &&
-			    !PageReserved(pfn_to_page(start_pfn + i)))
-				return IORES_MAP_SYSTEM_RAM;
+	start_pfn = PFN_DOWN(res->start);
+	stop_pfn = PFN_DOWN(res->end);
+	npages = stop_pfn - start_pfn + 1;
+	for (i = 0; i < npages; ++i) {
+		if (pfn_valid(start_pfn + i) &&
+		    !PageReserved(pfn_to_page(start_pfn + i)))
+			return IORES_MAP_SYSTEM_RAM;
 	}
 
 	return 0;
-- 
2.25.1

