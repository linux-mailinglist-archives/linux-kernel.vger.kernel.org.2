Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039BC3B7FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhF3JZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:25:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47912 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233717AbhF3JZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:25:44 -0400
X-UUID: 6e8b8836a5a34721866b2f09edb629ce-20210630
X-UUID: 6e8b8836a5a34721866b2f09edb629ce-20210630
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1851752082; Wed, 30 Jun 2021 17:23:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 17:23:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 17:23:11 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] mm/sparse: clarify pgdat_to_phys
Date:   Wed, 30 Jun 2021 17:23:09 +0800
Message-ID: <20210630092309.17654-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clarify pgdat_to_phys() by wrapping pgdat_to_phys
with CONFIG_NUMA. (the same config as contig_page_data)

No functional change intended.

Comment from Mark [1]:
"
... and I reckon it'd be clearer and more robust to define
pgdat_to_phys() in the same ifdefs as contig_page_data so
that these, stay in-sync. e.g. have:

| #ifdef CONFIG_NUMA
| #define pgdat_to_phys(x)	virt_to_phys(x)
| #else /* CONFIG_NUMA */
|
| extern struct pglist_data contig_page_data;
| ...
| #define pgdat_to_phys(x)	__pa_symbol(&contig_page_data)
|
| #endif /* CONIFIG_NUMA */
"

[1] https://lore.kernel.org/linux-arm-kernel/20210615131902.GB47121@C02TD0UTHF1T.local/

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 mm/sparse.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7272f7a1449d..62c21ec28e33 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -344,14 +344,15 @@ size_t mem_section_usage_size(void)
 	return sizeof(struct mem_section_usage) + usemap_size();
 }
 
-static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
-{
-#ifndef CONFIG_NUMA
-	return __pa_symbol(pgdat);
-#else
-	return __pa(pgdat);
-#endif
-}
+#ifdef CONFIG_NUMA
+#define pgdat_to_phys(pgdat) __pa(pgdat)
+#else /* CONFIG_NUMA */
+/*
+ * When !CONFIG_NUMA, we only expect pgdat == &contig_page_data,
+ * and use __pa_symbol().
+ */
+#define pgdat_to_phys(pgdat) __pa_symbol(pgdat)
+#endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static struct mem_section_usage * __init
-- 
2.18.0

