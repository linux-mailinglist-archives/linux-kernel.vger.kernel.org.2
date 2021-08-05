Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519843E1C06
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbhHETEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:31 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41351 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241964AbhHETEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 13EB55810C2;
        Thu,  5 Aug 2021 15:03:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 05 Aug 2021 15:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=RA0AsrTogxcWF
        pocSItHzob/KJFuxJUXcWJazBJO2Zo=; b=JyLRlPZXhY/YsYb3uK/2AGnlh+FwS
        Y1jht/x4sJjVPeILSUeUeMTghzUcayGRaVZDgpnxsOvRpmAiSuh3hqO8rhJNGCXw
        XnpfLgRSo6UFfeycRGYXWRZy13eZIcp8dJybYtR0iNuDORKLebq8bRn38Sh23LGM
        9TwR0bd5rzaKbcLN4pP/acBA7CG6bqvpMqFUDZaRJo6Xrg9R/dWHNT1sa0y4vbEQ
        3/4Zjb6ZIKiU3xOzNM83mwHjGalGkm5ddo+Pvk2NDovx7NjuJuuYw3f5S8ZhqB27
        iNEwOY5U5LtM4uWjDLJW7OHtfUDtsKQJsUWBI9rUkfboAfYXrEAB/HADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=RA0AsrTogxcWFpocSItHzob/KJFuxJUXcWJazBJO2Zo=; b=B5FDGE67
        RnzMlNvwvWbIZsWz0Btgst5jK279cYY4OL2hhNQZwrTnFWtR5/vIpHlSR0rysul5
        yRSOrqad7K1OmCGgnW32K8uy9JeZ5Gw7P4j0I/kqsaAv5Moah3NqkC1Kmyuh/KLT
        C8pSGOv5+aexvq5jIsSMwrINoDQY0K03XvHNNG3lyt3np+20i1m52n0WM1fYv0Q+
        BW/c4MSNPHs7jk/PLEz0UbcZ10a9uUgXBuncMSEaOW9dwjsIhFBYcjOcyQ9yv9Lm
        HQcnL3pNDdTZh4LSgC6sPeYU12SiZa4ZkyTkafWTNyh/JJt2hzsohF8wGWYp5axp
        GvdFUIpaS39cvA==
X-ME-Sender: <xms:HTYMYRkUzPR7VW8cGRl6f9vTLpkZLy3vCsBlKbO-JWLxrYQIsHwG_A>
    <xme:HTYMYc0g9RHM9jQ_Qngf2ag-VIJRO45X1LdSMTeJR3F3CNjx1zM3GynVwuX73DJOJ
    zhMqkjF5G-FJJ0h6A>
X-ME-Received: <xmr:HTYMYXp9M9sAGp-YGx8r0JYHQoE-FLMXeZSbT8cdKrkyCwQK0XWwwjHQHTqz5B2c93cemv_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:HTYMYRl1A1V9JIEEKl4pun9wJHt9Tq0Nkak8Q9npWjkBMxRCCjSO7A>
    <xmx:HTYMYf0V_Soq-HAmTQ7S8zJwgcLs6g-HYwWvvNGgZCdO9fzJGozbnA>
    <xmx:HTYMYQtHptvqudI1htwAHATcQ0whnE6gdmAcJi5e-uPcfvYS_ftPPA>
    <xmx:HjYMYW0JV12oxkVtR8TkCKSvvKewLODgM-y2fIHx-XF79Y_QukkffA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:57 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 15/15] mm: make MAX_ORDER a kernel boot time parameter.
Date:   Thu,  5 Aug 2021 15:02:53 -0400
Message-Id: <20210805190253.2795604-16-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

With the new buddy_alloc_max_order, users can specify larger MAX_ORDER
than set in CONFIG_ARCH_MAX_ORDER or CONFIG_SET_MAX_ORDER.
It can be set any value >=3D CONFIG_ARCH_MAX_ORDER or CONFIG_SET_MAX_ORDER,
but < 256 (limited by vmscan scan_control and per-cpu free page list).

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 include/linux/mmzone.h                        | 23 +++++++++++--
 mm/page_alloc.c                               | 34 ++++++++++++++++++-
 mm/vmscan.c                                   |  1 -
 4 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 5c59a5fb17c3..a37141aa28ae 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -465,6 +465,11 @@
 	bttv.pll=3D	See Documentation/admin-guide/media/bttv.rst
 	bttv.tuner=3D
=20
+	buddy_alloc_max_order=3D	[KNL] This parameter adjusts the size of largest
+			pages that can be allocated from kernel buddy allocator. The largest
+			page size is 2^buddy_alloc_max_order * PAGE_SIZE.
+            Format: integer
+
 	bulk_remove=3Doff	[PPC]  This parameter disables the use of the pSeries
 			firmware feature for flushing multiple hpte entries
 			at a time.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 379dada82d4b..9ca4d59722a1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -26,14 +26,25 @@
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
 #ifdef CONFIG_SET_MAX_ORDER
-#define MAX_ORDER CONFIG_SET_MAX_ORDER
+/* Defined in mm/page_alloc.c */
+extern int buddy_alloc_max_order;
+
+#define MAX_ORDER buddy_alloc_max_order
 #define MIN_MAX_ORDER CONFIG_SET_MAX_ORDER
 #else
 #define MAX_ORDER 11
 #define MIN_MAX_ORDER MAX_ORDER
 #endif /* CONFIG_SET_MAX_ORDER */
 #else
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+/* Defined in mm/page_alloc.c */
+extern int buddy_alloc_max_order;
+
+#define MAX_ORDER buddy_alloc_max_order
+#else
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
 #define MIN_MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
 #endif /* CONFIG_ARCH_FORCE_MAX_ORDER */
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
@@ -1557,8 +1568,14 @@ void sparse_init(void);
  * pfn_valid_within() should be used in this case; we optimise this away
  * when we have no holes within a MAX_ORDER_NR_PAGES block.
  */
-#if ((MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
-#define pfn_valid_within(pfn) pfn_valid(pfn)
+#if defined(CONFIG_ARCH_FORCE_MAX_ORDER) || defined(CONFIG_SET_MAX_ORDER)
+static inline bool pfn_valid_within(unsigned long pfn)
+{
+	if ((MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
+		return pfn_valid(pfn);
+
+	return 1;
+}
 #else
 #define pfn_valid_within(pfn) (1)
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bfa6962f7615..ea6f8d85a4cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1487,7 +1487,6 @@ static void free_pcppages_bulk(struct zone *zone, int=
 count,
 			batch_free =3D count;
=20
 		order =3D pindex_to_order(pindex);
-		BUILD_BUG_ON(MAX_ORDER >=3D (1<<NR_PCP_ORDER_WIDTH));
 		do {
 			page =3D list_last_entry(list, struct page, lru);
 			/* must delete to avoid corrupting pcp list */
@@ -9508,3 +9507,36 @@ bool take_page_off_buddy(struct page *page)
 	return ret;
 }
 #endif
+
+#if (defined(CONFIG_ARCH_FORCE_MAX_ORDER) && defined(CONFIG_SPARSEMEM_VMEM=
MAP)) \
+	|| defined(CONFIG_SET_MAX_ORDER)
+int buddy_alloc_max_order =3D MIN_MAX_ORDER;
+EXPORT_SYMBOL(buddy_alloc_max_order);
+
+static int __init buddy_alloc_set(char *val)
+{
+	int ret;
+	unsigned long max_order;
+
+	ret =3D kstrtoul(val, 10, &max_order);
+
+	if (ret < 0)
+		return -EINVAL;
+
+	/*
+	 * max_order is also limited at below locations:
+	 * 1. scan_control in mm/vmscan.c uses s8 field for order, max_order cann=
ot
+	 * be bigger than S8_MAX before the field is changed.
+	 * 2. free_pcppages_bulk has max_order upper limit.
+	 */
+	if (max_order > MIN_MAX_ORDER && max_order < S8_MAX &&
+	    max_order < (1<<NR_PCP_ORDER_WIDTH))
+		buddy_alloc_max_order =3D max_order;
+	else
+		buddy_alloc_max_order =3D MIN_MAX_ORDER;
+
+	return 0;
+}
+
+early_param("buddy_alloc_max_order", buddy_alloc_set);
+#endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 403a175a720f..9a3963c6166e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3610,7 +3610,6 @@ unsigned long try_to_free_pages(struct zonelist *zone=
list, int order,
 	 * scan_control uses s8 fields for order, priority, and reclaim_idx.
 	 * Confirm they are large enough for max values.
 	 */
-	BUILD_BUG_ON(MAX_ORDER > S8_MAX);
 	BUILD_BUG_ON(DEF_PRIORITY > S8_MAX);
 	BUILD_BUG_ON(MAX_NR_ZONES > S8_MAX);
=20
--=20
2.30.2

