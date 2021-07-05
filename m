Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01D3BC2B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGESga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhGESga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:36:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5832261979;
        Mon,  5 Jul 2021 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625510032;
        bh=Nhk8oaNc/YSXElMkHHcyeooUYW+6uxxuUVYgdqIBHoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAvpDyZIG/mlWAa6w0lNWAp2QNd0gK45QNdNYann2xj1zik3T3HQU6l+6Zto76K1o
         J7qa+J077Aq69wMID1WI46LcNK++TU4PHwED8VNmyORtTCt1tpUo6IQ2aT0iDf6nn7
         m5CYsjxKgoH3F13VF/vBgy1Vc/tP3FCgXlQE5o+9rJbI7r+R+e25ntyxGhW0632oy1
         iFHrj2GLvnmGA4GH8oamJNeD5eb+w8zTT8FHUQY3e5Lcifi1IvJJSUAI6x6MJoGQW1
         WU5WrhkWHY1zSEGfAUtecia1pW0DWzcdTDhCrPYPbdLdKKOEzxigaSS8zlB9uljxku
         7CWdoEbbiAV3Q==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Gao Xiang <xiang@kernel.org>
Subject: [RFC PATCH 2/2] erofs: directly traverse pages in z_erofs_readahead()
Date:   Tue,  6 Jul 2021 02:32:53 +0800
Message-Id: <20210705183253.14833-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210705183253.14833-1-xiang@kernel.org>
References: <20210705183253.14833-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In that way, pages can be accessed directly with xarray.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
Just an open-coded PoC one, since that is what EROFS actually needs but
without the iteration API (see [PATCH 1/2] as well.)

 fs/erofs/zdata.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 054b9839e9db..210b2965ecc4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1416,7 +1416,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	bool sync = (sbi->ctx.readahead_sync_decompress &&
 			nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	struct page *page, *head = NULL;
+	struct page *page;
+	pgoff_t index;
 	LIST_HEAD(pagepool);
 
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
@@ -1434,26 +1435,19 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	 *  2) submission chain can be then in the forward order since
 	 *     pclusters are all inserted at head.
 	 */
-	while ((page = readahead_page(rac))) {
-		prefetchw(&page->flags);
-
-		/*
-		 * A pure asynchronous readahead is indicated if
-		 * a PG_readahead marked page is hitted at first.
-		 * Let's also do asynchronous decompression for this case.
-		 */
-		sync &= !(PageReadahead(page) && !head);
-
-		set_page_private(page, (unsigned long)head);
-		head = page;
-	}
-
-	while (head) {
-		struct page *page = head;
+	index = rac->_index + rac->_nr_pages;
+	while (rac->_nr_pages) {
+		struct page *head;
 		int err;
 
-		/* traversal in reverse order */
-		head = (void *)page_private(page);
+		--rac->_nr_pages;
+		page = xa_load(&rac->mapping->i_pages, --index);
+		/* XXX: very incomplete thp support */
+		head = thp_head(page);
+		if (head != page) {
+			index -= page->index - head->index;
+			page = head;
+		}
 
 		err = z_erofs_do_read_page(&f, page, &pagepool);
 		if (err)
-- 
2.20.1

