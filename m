Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3D3A3AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFKEY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 00:24:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56426 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhFKEY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:24:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uc0K0DG_1623385376;
Received: from localhost(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0Uc0K0DG_1623385376)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jun 2021 12:22:57 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ben Luo <luoben@linux.alibaba.com>,
        Yahui Wang <yaohuiwang@linux.alibaba.com>
Subject: [PATCH v2 2/2] mm: fix boundary judgment issues in kernel/resource.c
Date:   Fri, 11 Jun 2021 12:21:47 +0800
Message-Id: <20210611042147.80744-3-yaohuiwang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com>
References: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original boundary judgment may ignore @end if @end equals @start. For
example, if we call ioremap(phys, 1), then @end == @start, and the memory
check will not be applied on the page where @end lives, which is
unexpected.

In kernel/resource.c:find_next_iomem_res, the mem region is a closed
interval (i.e. [@start..@end]). So @start == @end should be allowed.

In kernel/resource.c:__walk_iomem_res_desc, the mem region is a closed
interval (i.e. [@start..@end]). So @start == @end should be allowed.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
Signed-off-by: Yahui Wang <yaohuiwang@linux.alibaba.com>
---
 kernel/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 16e0c7e8e..b29c8c720 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -353,7 +353,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 	if (!res)
 		return -EINVAL;
 
-	if (start >= end)
+	if (start > end)
 		return -EINVAL;
 
 	read_lock(&resource_lock);
@@ -408,7 +408,7 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 	struct resource res;
 	int ret = -EINVAL;
 
-	while (start < end &&
+	while (start <= end &&
 	       !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
 		ret = (*func)(&res, arg);
 		if (ret)
-- 
2.25.1

