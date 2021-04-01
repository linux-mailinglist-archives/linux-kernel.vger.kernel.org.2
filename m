Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE269350D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhDADar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233151AbhDADaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:30:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 006A661057;
        Thu,  1 Apr 2021 03:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617247810;
        bh=/vQCieIrXYf5JV3JhH2VEYQnbptP3BXFE+txfjDIrIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhSzNk6veOeD3Tf3r4gxlUM3sUYpY2cAyiQcUt4Xby1GkbauojWBfyYY/gzyhsr9f
         w8M+kGjC06B3+SUKndOskse4VzZmkHaxP8rE7MdB0Td43V9kzwM2kCaJp4w+Flyulb
         Kgcd/VDWD6P6qHIL1H4YnBmP1k+rl187VFQ65pUOm8wtf2EgA4TA71INJRsGOjH+ua
         j8RNXgWH9H/R94hplCx3E6BBjXeJV8zmS5kCp2/fb1JYOmMVuNLqpNHBW5EHHFq9oC
         3xlxLZFx/e2Z9CbByXiG8sqkPhrWolJMHhM7SRukwBzHypttbCXB8nuS3iijEEoSZh
         XEnf2zBtzb78A==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 04/10] erofs: fix up inplace I/O pointer for big pcluster
Date:   Thu,  1 Apr 2021 11:29:48 +0800
Message-Id: <20210401032954.20555-5-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

When picking up inplace I/O pages, it should be traversed in reverse
order in aligned with the traversal order of file-backed online pages.
Also, index should be updated together when preloading compressed pages.

Previously, only page-sized pclustersize was supported so no problem
at all. Also rename `compressedpages' to `icpage_ptr' to reflect its
functionality.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 7f572086b4e3..03f106ead8d2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -204,7 +204,8 @@ struct z_erofs_collector {
 
 	struct z_erofs_pcluster *pcl, *tailpcl;
 	struct z_erofs_collection *cl;
-	struct page **compressedpages;
+	/* a pointer used to pick up inplace I/O pages */
+	struct page **icpage_ptr;
 	z_erofs_next_pcluster_t owned_head;
 
 	enum z_erofs_collectmode mode;
@@ -238,17 +239,19 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     enum z_erofs_cache_alloctype type,
 				     struct list_head *pagepool)
 {
-	const struct z_erofs_pcluster *pcl = clt->pcl;
-	struct page **pages = clt->compressedpages;
-	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
+	struct z_erofs_pcluster *pcl = clt->pcl;
 	bool standalone = true;
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+	struct page **pages;
+	pgoff_t index;
 
 	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
 
-	for (; pages < pcl->compressed_pages + pcl->pclusterpages; ++pages) {
+	pages = pcl->compressed_pages;
+	index = pcl->obj.index;
+	for (; index < pcl->obj.index + pcl->pclusterpages; ++index, ++pages) {
 		struct page *page;
 		compressed_page_t t;
 		struct page *newpage = NULL;
@@ -360,16 +363,14 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 }
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
-static inline bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
-					  struct page *page)
+static bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
+				   struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = clt->pcl;
 
-	while (clt->compressedpages <
-	       pcl->compressed_pages + pcl->pclusterpages) {
-		if (!cmpxchg(clt->compressedpages++, NULL, page))
+	while (clt->icpage_ptr > pcl->compressed_pages)
+		if (!cmpxchg(--clt->icpage_ptr, NULL, page))
 			return true;
-	}
 	return false;
 }
 
@@ -576,9 +577,8 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  clt->cl->pagevec, clt->cl->vcnt);
 
-	clt->compressedpages = clt->pcl->compressed_pages;
-	if (clt->mode <= COLLECT_PRIMARY) /* cannot do in-place I/O */
-		clt->compressedpages += clt->pcl->pclusterpages;
+	/* since file-backed online pages are traversed in reverse order */
+	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
 	return 0;
 }
 
-- 
2.20.1

