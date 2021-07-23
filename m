Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C069F3D3A51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhGWLxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:53:30 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60102 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234751AbhGWLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:53:25 -0400
X-UUID: ee1dfeca99cb451e9e6338fd5619f132-20210723
X-UUID: ee1dfeca99cb451e9e6338fd5619f132-20210723
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 568177637; Fri, 23 Jul 2021 20:33:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Jul 2021 20:33:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Jul 2021 20:33:46 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH v3] mm/sparse: clarify pgdat_to_phys
Date:   Fri, 23 Jul 2021 20:33:42 +0800
Message-ID: <20210723123342.26406-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify pgdat_to_phys() by testing if
pgdat == &contig_page_data when CONFIG_NUMA=n.

We only expect contig_page_data in such case, so we
use &contig_page_data directly instead of pgdat.

No functional change intended when CONFIG_BUG_VM=n.

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

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>

--

Change since v1:
Thanks for Mike's comment, check if pgdat == &contig_page_data,
so it is clearer that we only expect contig_page_data when
CONFIG_NUMA=n.

Change since v2:
use VM_BUG_ON() to avoid runtime checking when CONFIG_BUG_VM=n
---
 mm/sparse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 6326cdf36c4f..d13d831f88a5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -348,7 +348,8 @@ size_t mem_section_usage_size(void)
 static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
 {
 #ifndef CONFIG_NUMA
-	return __pa_symbol(pgdat);
+	VM_BUG_ON(pgdat != &contig_page_data);
+	return __pa_symbol(&contig_page_data);
 #else
 	return __pa(pgdat);
 #endif
-- 
2.18.0

