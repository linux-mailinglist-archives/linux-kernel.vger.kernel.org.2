Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E03AE931
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUMiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:38:08 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48286 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhFUMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:38:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UdA8ykB_1624278944;
Received: from localhost(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0UdA8ykB_1624278944)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 20:35:44 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com, tglx@linutronix.de
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        luoben@linux.alibaba.com, yaohuiwang@linux.alibaba.com
Subject: [PATCH v3 2/2] kernel/resource: fix boundary judgment issues in find_next_iomem_res() and __walk_iomem_res_desc()
Date:   Mon, 21 Jun 2021 20:34:19 +0800
Message-Id: <20210621123419.2976-3-yaohuiwang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
References: <20210621123419.2976-1-yaohuiwang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory resources are described with the start address and the inclusive
end address, which means for a resource with 1 byte length the start
address is the same as the end address.

find_next_iomem_res() and __walk_iomem_res_desc() ignore resources with
1 byte length, which prevents that ioremap_xxx(phys_addr, 1) is checked
whether it touches non-ioremappable resources.

Fixes: 010a93bf97c7 (resource: Fix find_next_iomem_res() iteration issue)
Fixes: b69c2e20f6e4 (resource: Clean it up a bit)
Signed-off-by: Yahui Wang <yaohuiwang@linux.alibaba.com>
Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 kernel/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..31e371babfad 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -344,7 +344,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 	if (!res)
 		return -EINVAL;
 
-	if (start >= end)
+	if (start > end)
 		return -EINVAL;
 
 	read_lock(&resource_lock);
@@ -392,7 +392,7 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 	struct resource res;
 	int ret = -EINVAL;
 
-	while (start < end &&
+	while (start <= end &&
 	       !find_next_iomem_res(start, end, flags, desc, &res)) {
 		ret = (*func)(&res, arg);
 		if (ret)
-- 
2.25.1

