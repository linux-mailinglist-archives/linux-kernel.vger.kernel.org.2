Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7839D88A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFGJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:21:56 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46494 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhFGJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:21:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UbaGHXf_1623057601;
Received: from localhost(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0UbaGHXf_1623057601)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Jun 2021 17:20:01 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, yaohuiwang@linux.alibaba-inc.com,
        luoben@linux.alibaba.com, Yahui Wang <yaohuiwang@linux.alibaba.com>
Subject: [PATCH] mm: fix pfn calculation mistake in __ioremap_check_ram
Date:   Mon,  7 Jun 2021 17:19:39 +0800
Message-Id: <20210607091938.47960-1-yaohuiwang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the source code in function
arch/x86/mm/ioremap.c:__ioremap_caller, after __ioremap_check_mem, if the
mem range is IORES_MAP_SYSTEM_RAM, then __ioremap_caller should fail. But
because of the pfn calculation problem, __ioremap_caller can success
on IORES_MAP_SYSTEM_RAM region when the @size parameter is less than
PAGE_SIZE. This may cause misuse of the ioremap function and raise the
risk of performance issues. For example, ioremap(phys, PAGE_SIZE-1) may
cause the direct memory mapping of @phys to be uncached, and iounmap won't
revert this change. This patch fixes this issue.

In arch/x86/mm/ioremap.c:__ioremap_check_ram, start_pfn should wrap down
the res->start address, and end_pfn should wrap up the res->end address.
This makes the check more strict and should be more reasonable.

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

