Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCC3D34F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhGWGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:21:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45448 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234089AbhGWGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:21:10 -0400
X-UUID: 42790fba2b7741d88ac8bd1a6ae43166-20210723
X-UUID: 42790fba2b7741d88ac8bd1a6ae43166-20210723
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 733327149; Fri, 23 Jul 2021 15:01:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Jul 2021 15:01:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Jul 2021 15:01:38 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [RESEND PATCH v2] mm/sparse: clarify pgdat_to_phys
Date:   Fri, 23 Jul 2021 15:01:37 +0800
Message-ID: <20210723070137.23321-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify pgdat_to_phys() by testing if
pgdat == &contig_page_data when CONFIG_NUMA=n.

contig_page_data is only available when CONFIG_NUMA=n
so we have to use #ifndef here.

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

Comment from Mike [2]:
"
I'm not sure a macro is better than a static inline.

Maybe we'd want to warn if pgdat passed to pgtat_to_phys() is not
&contig_page_data, e.g something like

static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
{
	if (!IS_ENABLED(CONFIG_NUMA)) {
		if (pgdat == &contig_page_data)
			return __pa_symbol(&contig_page_data);
		else
			pr_warn("Unexpected pglist_data pointer!\n");
	}

	return __pa(pgdat);
}
"

[1] https://lore.kernel.org/linux-arm-kernel/20210615131902.GB47121@C02TD0UTHF1T.local/
[2] https://lore.kernel.org/patchwork/patch/1452903/#1650759

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>

---

Change since v1:
Thanks for Mike's comment, check if pgdat == &contig_page_data,
so it is clearer that we only expect contig_page_data when
CONFIG_NUMA=n.
---
 mm/sparse.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 6326cdf36c4f..f73ff3c124c5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -348,10 +348,11 @@ size_t mem_section_usage_size(void)
 static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
 {
 #ifndef CONFIG_NUMA
-	return __pa_symbol(pgdat);
-#else
+	if (pgdat == &contig_page_data)
+		return __pa_symbol(&contig_page_data);
+	pr_warn("Unexpected pglist_data pointer!\n");
+#endif /* !CONFIG_NUMA */
 	return __pa(pgdat);
-#endif
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-- 
2.18.0

