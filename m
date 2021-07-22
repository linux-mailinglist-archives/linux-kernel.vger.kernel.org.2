Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3F3D1BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhGVBjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhGVBjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:39:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5248FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZAUM6JsORpXKtfzwUl7e2bOgLpFXq7TN7LD+yIvdhvk=; b=FMiOv7KeBzACwgx99SAkMWD60i
        ERupB85JGmpDr6YRZLeypz5ORgguEbKl9ZPRcYowzNk4fTnsDMoe8XBF40ihVy0Obi4HwvyayWDor
        WZMTWEbNY9BRwA95cdM5bw+Ff5xeB/At9x1xDM6J6RKCjAUt4n1nDL6A0dQBeUpvifH3ALeTSBS9z
        IJH1ND2GvhC2HoXcOihX/eR6sSMYR4yPoUouu0xV03W4r9KjLxRJrniYZymJeWuQnnIzsHaaFOUv0
        hmZ1jUB25EBqX8uBU+UYVgxSu34zW5FqFlNxvBNmnmggvReYyzv1Lpv+Zj/y6OylH0CXF8i29TEjU
        VhdpZRBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6OIS-009nkq-EC; Thu, 22 Jul 2021 02:18:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm/doc: Include highmem.h in kernel-doc
Date:   Thu, 22 Jul 2021 03:18:42 +0100
Message-Id: <20210722021843.2336117-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is lots of good documentation in highmem.h that isn't being pulled
into the html documentation.  Fix up a couple of minor glitches and
include it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/mm-api.rst |  1 +
 include/linux/highmem.h           | 17 +++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 395835f9289f..2027aee5f2d9 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -54,6 +54,7 @@ Virtually Contiguous Mappings
 
 .. kernel-doc:: mm/vmalloc.c
    :export:
+.. kernel-doc:: include/linux/highmem.h
 
 File Mapping and Page Cache
 ===========================
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 861ad00fb32a..fc43e81cf4db 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -37,8 +37,8 @@
 static inline void *kmap(struct page *page);
 
 /**
- * kunmap - Unmap the virtual address mapped by kmap()
- * @addr:	Virtual address to be unmapped
+ * kunmap - Unmap the page mapped by kmap()
+ * @page: Page to be unmapped
  *
  * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
  * pages in the low memory area.
@@ -69,13 +69,13 @@ static inline void kmap_flush_unused(void);
  *
  * Requires careful handling when nesting multiple mappings because the map
  * management is stack based. The unmap has to be in the reverse order of
- * the map operation:
+ * the map operation::
  *
- * addr1 = kmap_local_page(page1);
- * addr2 = kmap_local_page(page2);
- * ...
- * kunmap_local(addr2);
- * kunmap_local(addr1);
+ *   addr1 = kmap_local_page(page1);
+ *   addr2 = kmap_local_page(page2);
+ *   ...
+ *   kunmap_local(addr2);
+ *   kunmap_local(addr1);
  *
  * Unmapping addr1 before addr2 is invalid and causes malfunction.
  *
@@ -156,6 +156,7 @@ static inline void *kmap_atomic(struct page *page);
  * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
  * preemption.
  */
+static inline void kunmap_atomic(void *addr);
 
 /* Highmem related interfaces for management code */
 static inline unsigned int nr_free_highpages(void);
-- 
2.30.2

