Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D114F3E1BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbhHETEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:06 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43331 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241966AbhHETEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 251CE5C012C;
        Thu,  5 Aug 2021 15:03:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Aug 2021 15:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=v5NnXPi+8SUnu
        /jjhBdJO56OpiXwS+o/8RFQPthUdEk=; b=dqZLVVgc/tDrYGtB4C5omQ7wBpsS1
        MnMFDV2tagbRW7NA4p2dSfm3tIx+ggRIjXvWYNvw1udop9lR444i6ePE8POJeS6r
        hE5A15LzsO7KEbefolvXSLeqo3cAcKasgXjRQvr5e4evCbIg+iH7xgTblIZKLZFF
        Ox6B9FWTbLpOfvuig1I+lDE4kXgpYG/fjveQ5C0MHXM1zyqrRpHT9ux25Pq8QUj7
        FyiWmUCc+XhpJdkFVKMDJS5W/2VYF2OHUsrkPXsBXg1YCHLohN+KDxsO5LDZBeak
        xuMePxhOy2YgpDw+/cStHNtpJvnyG3IpSAHtesisym7qNSAeQ2KEwLb2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=v5NnXPi+8SUnu/jjhBdJO56OpiXwS+o/8RFQPthUdEk=; b=AuYeRFBk
        Fto0001rxUnyMnRKNl116YMle+RkuezGiD/vi0HS/1ASrOr7n8tmaRwS6rdZME06
        MPDnoXdFxi4PrJ5p6oKzFZoavo8NqhkTPtkUE/0gXozzw6yMZT9452j+6cft04M7
        RsHuCuGH/DApDj0tUcJ4iG3ikVvz89SQquFZTr/v9SEM91xMxvrStDAgnyZhr9AD
        FXVNeTr5jVorCNhaEHAwWcKo2YNmCmzCly0gerT9c6ME2KWgNLpxKaaJsalWv2W/
        iPZC5RwhRVQJBwP40oB8889yfy67E+5FAbkzmdxAngWVxL1lomVP6xuSKTPe5mPm
        OhAsCfNEqBJzCQ==
X-ME-Sender: <xms:EzYMYVhvb_LX73BNAEtBjjlSlApDWIE-EcUc8xqSXNK2LoG86HQAgg>
    <xme:EzYMYaCUkZTEIzZmxP70kg32pYBeLJ5OLx-Gd3nDYM6yUNFRUBFV0_FynaiwHkFG6
    9ICFTU7jnQ2BoNFXg>
X-ME-Received: <xmr:EzYMYVFgZMjGObau_MrrY6niYrPWAERIe4YD_k4dCsasgRrPhpZPGht9066l1j38PhGZHcMq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:EzYMYaQ01c7kPx5KK9t_AechyzaVtnN0wOWX8m2RDV9q6Fek_6xnAg>
    <xmx:EzYMYSyGhpnImdpfHo5cXZJdd1mXvj_XWTkjweQIqHyrOv5hSFsdYA>
    <xmx:EzYMYQ5FSZRJdIFmic_0yoZzrnFDwTm9kA2bQvnDXuAMPKawzxURHg>
    <xmx:FDYMYRn_n-ZeXOaGxae6fmB0EireL6z353acs5-vhGJaGPSZDhVn2w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:46 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 03/15] mm: check pfn validity when buddy allocator can merge pages across mem sections.
Date:   Thu,  5 Aug 2021 15:02:41 -0400
Message-Id: <20210805190253.2795604-4-zi.yan@sent.com>
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

When MAX_ORDER - 1 + PAGE_SHIFT > SECTION_SIZE_BITS, it is possible to
have holes in memory zones. Use pfn_valid to check holes during buddy
page merging and physical frame scanning.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mmzone.h | 13 +++++++++++++
 mm/compaction.c        | 20 +++++++++++++-------
 mm/memory_hotplug.c    |  7 +++++++
 mm/page_alloc.c        | 26 ++++++++++++++++++++++++--
 mm/page_isolation.c    |  7 ++++++-
 mm/page_owner.c        | 14 +++++++++++++-
 6 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 98e3297b9e09..04f790ed81b7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1535,6 +1535,19 @@ void sparse_init(void);
 #define subsection_map_init(_pfn, _nr_pages) do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
=20
+/*
+ * If it is possible to have holes within a MAX_ORDER_NR_PAGES when
+ * MAX_ORDER_NR_PAGES crosses multiple memory sections, then we
+ * need to check pfn validity within each MAX_ORDER_NR_PAGES block.
+ * pfn_valid_within() should be used in this case; we optimise this away
+ * when we have no holes within a MAX_ORDER_NR_PAGES block.
+ */
+#if ((MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
+#define pfn_valid_within(pfn) pfn_valid(pfn)
+#else
+#define pfn_valid_within(pfn) (1)
+#endif
+
 #endif /* !__GENERATING_BOUNDS.H */
 #endif /* !__ASSEMBLY__ */
 #endif /* _LINUX_MMZONE_H */
diff --git a/mm/compaction.c b/mm/compaction.c
index fbc60f964c38..dda640d51b70 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -306,14 +306,16 @@ __reset_isolation_pfn(struct zone *zone, unsigned lon=
g pfn, bool check_source,
 	 * is necessary for the block to be a migration source/target.
 	 */
 	do {
-		if (check_source && PageLRU(page)) {
-			clear_pageblock_skip(page);
-			return true;
-		}
+		if (pfn_valid_within(pfn)) {
+			if (check_source && PageLRU(page)) {
+				clear_pageblock_skip(page);
+				return true;
+			}
=20
-		if (check_target && PageBuddy(page)) {
-			clear_pageblock_skip(page);
-			return true;
+			if (check_target && PageBuddy(page)) {
+				clear_pageblock_skip(page);
+				return true;
+			}
 		}
=20
 		page +=3D (1 << PAGE_ALLOC_COSTLY_ORDER);
@@ -583,6 +585,8 @@ static unsigned long isolate_freepages_block(struct com=
pact_control *cc,
 			break;
=20
 		nr_scanned++;
+		if (!pfn_valid_within(blockpfn))
+			goto isolate_fail;
=20
 		/*
 		 * For compound pages such as THP and hugetlbfs, we can save
@@ -881,6 +885,8 @@ isolate_migratepages_block(struct compact_control *cc, =
unsigned long low_pfn,
 			cond_resched();
 		}
=20
+		if (!pfn_valid_within(low_pfn))
+			goto isolate_fail;
 		nr_scanned++;
=20
 		page =3D pfn_to_page(low_pfn);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 632cd832aef6..85029994a494 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1617,6 +1617,13 @@ struct zone *test_pages_in_a_zone(unsigned long star=
t_pfn,
 			continue;
 		for (; pfn < sec_end_pfn && pfn < end_pfn;
 		     pfn +=3D MAX_ORDER_NR_PAGES) {
+			int i =3D 0;
+
+			while ((i < MAX_ORDER_NR_PAGES) &&
+				!pfn_valid_within(pfn + i))
+				i++;
+			if (i =3D=3D MAX_ORDER_NR_PAGES || pfn + i >=3D end_pfn)
+				continue;
 			/* Check if we got outside of the zone */
 			if (zone && !zone_spans_pfn(zone, pfn))
 				return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 416859e94f86..e4657009fd4f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -594,6 +594,8 @@ static int page_outside_zone_boundaries(struct zone *zo=
ne, struct page *page)
=20
 static int page_is_consistent(struct zone *zone, struct page *page)
 {
+	if (!pfn_valid_within(page_to_pfn(page)))
+		return 0;
 	if (zone !=3D page_zone(page))
 		return 0;
=20
@@ -1023,12 +1025,16 @@ buddy_merge_likely(unsigned long pfn, unsigned long=
 buddy_pfn,
 	if (order >=3D MAX_ORDER - 2)
 		return false;
=20
+	if (!pfn_valid_within(buddy_pfn))
+		return false;
+
 	combined_pfn =3D buddy_pfn & pfn;
 	higher_page =3D page + (combined_pfn - pfn);
 	buddy_pfn =3D __find_buddy_pfn(combined_pfn, order + 1);
 	higher_buddy =3D higher_page + (buddy_pfn - combined_pfn);
=20
-	return page_is_buddy(higher_page, higher_buddy, order + 1);
+	return pfn_valid_within(buddy_pfn) &&
+	       page_is_buddy(higher_page, higher_buddy, order + 1);
 }
=20
 /*
@@ -1089,6 +1095,8 @@ static inline void __free_one_page(struct page *page,
 		buddy_pfn =3D __find_buddy_pfn(pfn, order);
 		buddy =3D page + (buddy_pfn - pfn);
=20
+		if (!pfn_valid_within(buddy_pfn))
+			goto done_merging;
 		if (!page_is_buddy(page, buddy, order))
 			goto done_merging;
 		/*
@@ -1118,6 +1126,9 @@ static inline void __free_one_page(struct page *page,
=20
 			buddy_pfn =3D __find_buddy_pfn(pfn, order);
 			buddy =3D page + (buddy_pfn - pfn);
+
+			if (!pfn_valid_within(buddy_pfn))
+				goto done_merging;
 			buddy_mt =3D get_pageblock_migratetype(buddy);
=20
 			if (migratetype !=3D buddy_mt
@@ -1746,7 +1757,8 @@ void __init memblock_free_pages(struct page *page, un=
signed long pfn,
 /*
  * Check that the whole (or subset of) a pageblock given by the interval of
  * [start_pfn, end_pfn) is valid and within the same zone, before scanning=
 it
- * with the migration of free compaction scanner.
+ * with the migration of free compaction scanner. The scanners then need t=
o use
+ * only pfn_valid_within() check for holes within pageblocks.
  *
  * Return struct page pointer of start_pfn, or NULL if checks were not pas=
sed.
  *
@@ -1862,6 +1874,8 @@ static inline void __init pgdat_init_report_one_done(=
void)
  */
 static inline bool __init deferred_pfn_valid(unsigned long pfn)
 {
+	if (!pfn_valid_within(pfn))
+		return false;
 	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
 		return false;
 	return true;
@@ -2508,6 +2522,11 @@ static int move_freepages(struct zone *zone,
 	int pages_moved =3D 0;
=20
 	for (pfn =3D start_pfn; pfn <=3D end_pfn;) {
+		if (!pfn_valid_within(pfn)) {
+			pfn++;
+			continue;
+		}
+
 		page =3D pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
 			/*
@@ -8825,6 +8844,9 @@ struct page *has_unmovable_pages(struct zone *zone, s=
truct page *page,
 	}
=20
 	for (; iter < pageblock_nr_pages - offset; iter++) {
+		if (!pfn_valid_within(pfn + iter))
+			continue;
+
 		page =3D pfn_to_page(pfn + iter);
=20
 		/*
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 471e3a13b541..bddf788f45bf 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -93,7 +93,8 @@ static void unset_migratetype_isolate(struct page *page, =
unsigned migratetype)
 			buddy_pfn =3D __find_buddy_pfn(pfn, order);
 			buddy =3D page + (buddy_pfn - pfn);
=20
-			if (!is_migrate_isolate_page(buddy)) {
+			if (pfn_valid_within(buddy_pfn) &&
+			    !is_migrate_isolate_page(buddy)) {
 				__isolate_free_page(page, order);
 				isolated_page =3D true;
 			}
@@ -249,6 +250,10 @@ __test_page_isolated_in_pageblock(unsigned long pfn, u=
nsigned long end_pfn,
 	struct page *page;
=20
 	while (pfn < end_pfn) {
+		if (!pfn_valid_within(pfn)) {
+			pfn++;
+			continue;
+		}
 		page =3D pfn_to_page(pfn);
 		if (PageBuddy(page))
 			/*
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d24ed221357c..23bfb074ca3f 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -276,6 +276,9 @@ void pagetypeinfo_showmixedcount_print(struct seq_file =
*m,
 		pageblock_mt =3D get_pageblock_migratetype(page);
=20
 		for (; pfn < block_end_pfn; pfn++) {
+			if (!pfn_valid_within(pfn))
+				continue;
+
 			/* The pageblock is online, no need to recheck. */
 			page =3D pfn_to_page(pfn);
=20
@@ -476,6 +479,10 @@ read_page_owner(struct file *file, char __user *buf, s=
ize_t count, loff_t *ppos)
 			continue;
 		}
=20
+		/* Check for holes within a MAX_ORDER area */
+		if (!pfn_valid_within(pfn))
+			continue;
+
 		page =3D pfn_to_page(pfn);
 		if (PageBuddy(page)) {
 			unsigned long freepage_order =3D buddy_order_unsafe(page);
@@ -553,9 +560,14 @@ static void init_pages_in_zone(pg_data_t *pgdat, struc=
t zone *zone)
 		block_end_pfn =3D min(block_end_pfn, end_pfn);
=20
 		for (; pfn < block_end_pfn; pfn++) {
-			struct page *page =3D pfn_to_page(pfn);
+			struct page *page;
 			struct page_ext *page_ext;
=20
+			if (!pfn_valid_within(pfn))
+				continue;
+
+			page =3D pfn_to_page(pfn);
+
 			if (page_zone(page) !=3D zone)
 				continue;
=20
--=20
2.30.2

