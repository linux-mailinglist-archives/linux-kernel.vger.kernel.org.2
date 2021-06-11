Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E93E3A3AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFKEYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 00:24:49 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45541 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhFKEYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:24:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uc0I8O5_1623385368;
Received: from localhost(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0Uc0I8O5_1623385368)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jun 2021 12:22:48 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ben Luo <luoben@linux.alibaba.com>,
        Yahui Wang <yaohuiwang@linux.alibaba.com>
Subject: [PATCH v2 1/2] mm: fix the pfn calculation mistake in __ioremap_check_ram
Date:   Fri, 11 Jun 2021 12:21:46 +0800
Message-Id: <20210611042147.80744-2-yaohuiwang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com>
References: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/x86/mm/ioremap.c:__ioremap_check_ram, the original pfn wrapping
calculation may cause the pfn range to ignore the very start page, if
res->start is not page-aligned, or the very end page, if res->end is not
page aligned.

So start_pfn should wrap down the res->start address, and end_pfn should
wrap up the res->end address. This makes the pfn range completely
contain [res->start, res->end] ram range. This check is more strict and is
more reasonable.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
Signed-off-by: Yahui Wang <yaohuiwang@linux.alibaba.com>
---
 arch/x86/mm/ioremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 9e5ccc56f..79adf0d2d 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -74,8 +74,8 @@ static unsigned int __ioremap_check_ram(struct resource *res)
 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
 		return 0;
 
-	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
+	start_pfn = res->start >> PAGE_SHIFT;
+	stop_pfn = (res->end + PAGE_SIZE) >> PAGE_SHIFT;
 	if (stop_pfn > start_pfn) {
 		for (i = 0; i < (stop_pfn - start_pfn); ++i)
 			if (pfn_valid(start_pfn + i) &&
-- 
2.25.1

