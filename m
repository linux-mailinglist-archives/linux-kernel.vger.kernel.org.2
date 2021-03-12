Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4D338705
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhCLIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:04:15 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:53218 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhCLIDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:03:53 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id E926BB9646;
        Fri, 12 Mar 2021 16:03:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24306T139684564936448S1615536202373594_;
        Fri, 12 Mar 2021 16:03:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f24013f2c7f2bb4a81e23a76373eb9fd>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: cl@linux.co
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     cl@linux.co, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH] mm/slab: kmalloc with GFP_DMA32 allocate from SLAB_CACHE_DMA32
Date:   Fri, 12 Mar 2021 16:03:20 +0800
Message-Id: <20210312080320.1965201-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag GFP_DMA32 only effect in kmalloc_large currently.

This patch will create caches with GFP_DMA32 to support kmalloc with
size under KMALLOC_MAX_CACHE_SIZE.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 include/linux/slab.h |  7 +++++++
 mm/slab_common.c     | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index be4ba5867ac5..f4317663d148 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -307,6 +307,9 @@ enum kmalloc_cache_type {
 	KMALLOC_RECLAIM,
 #ifdef CONFIG_ZONE_DMA
 	KMALLOC_DMA,
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	KMALLOC_DMA32,
 #endif
 	NR_KMALLOC_TYPES
 };
@@ -331,6 +334,10 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 	 */
 	return flags & __GFP_DMA ? KMALLOC_DMA : KMALLOC_RECLAIM;
 #else
+#ifdef CONFIG_ZONE_DMA32
+	if (unlikely(flags & __GFP_DMA32))
+		return KMALLOC_DMA32;
+#endif
 	return flags & __GFP_RECLAIMABLE ? KMALLOC_RECLAIM : KMALLOC_NORMAL;
 #endif
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e981c80d216c..2a04736fe8f5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -805,6 +805,20 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 		}
 	}
 #endif
+#ifdef CONFIG_ZONE_DMA32
+	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
+		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
+
+		if (s) {
+			unsigned int size = kmalloc_size(i);
+			const char *n = kmalloc_cache_name("dma32-kmalloc", size);
+
+			BUG_ON(!n);
+			kmalloc_caches[KMALLOC_DMA32][i] = create_kmalloc_cache(
+				n, size, SLAB_CACHE_DMA32 | flags, 0, 0);
+		}
+	}
+#endif
 }
 #endif /* !CONFIG_SLOB */
 
-- 
2.25.1



