Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079F333D5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhCPO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:29:08 -0400
Received: from casper.infradead.org ([90.155.50.34]:34340 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbhCPO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:28:31 -0400
X-Greylist: delayed 1062 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 10:28:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3SHGazn862QXXOeWnSZKkghj7lRt7fQEJXYuLKN9RF0=; b=Ou9YRT2MIVxI7xlEk//ojVHvL1
        jUb2JV2gHAQ2B4XLqL9nqvIlIN6cLI4gpMvv7ZLL+ipVgHVhFUPsR9g/NhzyUTLgquxiD9yhBXzow
        JDwf+sWei38KgIHtyhZxl3uEODhvJDfzA8KRVlb7ypP4ZwcTJ0f2gS0ha2EeC/C95PhCgKVKX3UWS
        IhqJpoa32c7/uzfZkbA9FNSQQYkfuyE3IfTiZvo5mhPGOZc6q0mysbW5UOhERRL/1zQmRfD7GoDOU
        ocootX+9+C1iHfK2cX1MjXSKAjWnB+p7J39qu1lnhfb1OKnFdUL66ssYAgm6kVdtan+1Z5967kJE7
        cV9sgqzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMAPE-0009nt-Ja; Tue, 16 Mar 2021 14:10:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] mm: Move page_mapping_file to pagemap.h
Date:   Tue, 16 Mar 2021 14:10:40 +0000
Message-Id: <20210316141040.37576-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_mapping_file() is only used by some architectures, and then it
is usually only used in one place.  Make it a static inline function
so other architectures don't have to carry this dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
I'm not entirely sure all the affected architectures include pagemap.h,
so give this a couple of days for the buildbots to chew on it.

 include/linux/mm.h      |  1 -
 include/linux/pagemap.h | 10 ++++++++++
 mm/util.c               | 10 ----------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fbe0843daa90..f69a72f63e44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1645,7 +1645,6 @@ static inline pgoff_t page_index(struct page *page)
 
 bool page_mapped(struct page *page);
 struct address_space *page_mapping(struct page *page);
-struct address_space *page_mapping_file(struct page *page);
 
 /*
  * Return true only if the page has been allocated with
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 08fa117f405c..f68fe61c1dec 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -162,6 +162,16 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 
 void release_pages(struct page **pages, int nr);
 
+/*
+ * For file cache pages, return the address_space, otherwise return NULL
+ */
+static inline struct address_space *page_mapping_file(struct page *page)
+{
+	if (unlikely(PageSwapCache(page)))
+		return NULL;
+	return page_mapping(page);
+}
+
 /*
  * speculatively take a reference to a page.
  * If the page is free (_refcount == 0), then _refcount is untouched, and 0
diff --git a/mm/util.c b/mm/util.c
index 143c627fb3e8..972e7a0cda5e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -711,16 +711,6 @@ struct address_space *page_mapping(struct page *page)
 }
 EXPORT_SYMBOL(page_mapping);
 
-/*
- * For file cache pages, return the address_space, otherwise return NULL
- */
-struct address_space *page_mapping_file(struct page *page)
-{
-	if (unlikely(PageSwapCache(page)))
-		return NULL;
-	return page_mapping(page);
-}
-
 /* Slow path of page_mapcount() for compound pages */
 int __page_mapcount(struct page *page)
 {
-- 
2.30.1

