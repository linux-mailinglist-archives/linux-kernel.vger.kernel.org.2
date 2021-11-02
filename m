Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF0442A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhKBJZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:25:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:25:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E11D221639;
        Tue,  2 Nov 2021 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635844955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wjUVlYSScgX+OmSU5aFm2lY0ZdVm0SHe4hr+4+EhpKA=;
        b=Fq6gsuUWwTEs4RqfwQozDhHZplDrV2RJIwElae0+AgPb6Yul0eRSO/tR+pfvpt8ayvJPJM
        ouZzVufSVYz/WBm+RWlOHcRxaj0mIqA4xXfpYAtix+dvJwKhdOBHXMdLAGr65bb+gjYUv1
        kR+LUkAZP0xrkHq26uLJL+TO54wRrE0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B76F013BAA;
        Tue,  2 Nov 2021 09:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D2KPK1sDgWHZfwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 Nov 2021 09:22:35 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2] xen/balloon: rename alloc/free_xenballooned_pages
Date:   Tue,  2 Nov 2021 10:22:34 +0100
Message-Id: <20211102092234.17852-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_xenballooned_pages() and free_xenballooned_pages() are used as
direct replacements of xen_alloc_unpopulated_pages() and
xen_free_unpopulated_pages() in case CONFIG_XEN_UNPOPULATED_ALLOC isn't
defined.

Guard both functions with !CONFIG_XEN_UNPOPULATED_ALLOC and rename them
to the xen_*() variants they are replacing. This allows to remove some
ifdeffery from the xen.h header file. Adapt the prototype of the
functions to match.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- adapt prototypes (kernel test robot)
---
 drivers/xen/balloon.c | 24 +++++++++++++-----------
 include/xen/balloon.h |  3 ---
 include/xen/xen.h     |  6 ------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 3a661b7697d4..7b692636fad6 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -580,7 +580,8 @@ void balloon_set_new_target(unsigned long target)
 }
 EXPORT_SYMBOL_GPL(balloon_set_new_target);
 
-static int add_ballooned_pages(int nr_pages)
+#ifndef CONFIG_XEN_UNPOPULATED_ALLOC
+static int add_ballooned_pages(unsigned int nr_pages)
 {
 	enum bp_state st;
 
@@ -608,14 +609,14 @@ static int add_ballooned_pages(int nr_pages)
 }
 
 /**
- * alloc_xenballooned_pages - get pages that have been ballooned out
+ * xen_alloc_unpopulated_pages - get pages that have been ballooned out
  * @nr_pages: Number of pages to get
  * @pages: pages returned
  * @return 0 on success, error otherwise
  */
-int alloc_xenballooned_pages(int nr_pages, struct page **pages)
+int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 {
-	int pgno = 0;
+	unsigned int pgno = 0;
 	struct page *page;
 	int ret;
 
@@ -650,7 +651,7 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 	return 0;
  out_undo:
 	mutex_unlock(&balloon_mutex);
-	free_xenballooned_pages(pgno, pages);
+	xen_free_unpopulated_pages(pgno, pages);
 	/*
 	 * NB: free_xenballooned_pages will only subtract pgno pages, but since
 	 * target_unpopulated is incremented with nr_pages at the start we need
@@ -659,16 +660,16 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 	balloon_stats.target_unpopulated -= nr_pages - pgno;
 	return ret;
 }
-EXPORT_SYMBOL(alloc_xenballooned_pages);
+EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
 
 /**
- * free_xenballooned_pages - return pages retrieved with get_ballooned_pages
+ * xen_free_unpopulated_pages - return pages retrieved with get_ballooned_pages
  * @nr_pages: Number of pages
  * @pages: pages to return
  */
-void free_xenballooned_pages(int nr_pages, struct page **pages)
+void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 {
-	int i;
+	unsigned int i;
 
 	mutex_lock(&balloon_mutex);
 
@@ -685,9 +686,9 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
 
 	mutex_unlock(&balloon_mutex);
 }
-EXPORT_SYMBOL(free_xenballooned_pages);
+EXPORT_SYMBOL(xen_free_unpopulated_pages);
 
-#if defined(CONFIG_XEN_PV) && !defined(CONFIG_XEN_UNPOPULATED_ALLOC)
+#if defined(CONFIG_XEN_PV)
 static void __init balloon_add_region(unsigned long start_pfn,
 				      unsigned long pages)
 {
@@ -710,6 +711,7 @@ static void __init balloon_add_region(unsigned long start_pfn,
 	balloon_stats.total_pages += extra_pfn_end - start_pfn;
 }
 #endif
+#endif
 
 static int __init balloon_init(void)
 {
diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 6dbdb0b3fd03..e93d4f0088c5 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -26,9 +26,6 @@ extern struct balloon_stats balloon_stats;
 
 void balloon_set_new_target(unsigned long target);
 
-int alloc_xenballooned_pages(int nr_pages, struct page **pages);
-void free_xenballooned_pages(int nr_pages, struct page **pages);
-
 #ifdef CONFIG_XEN_BALLOON
 void xen_balloon_init(void);
 #else
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 43efba045acc..9f031b5faa54 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -52,13 +52,7 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 extern u64 xen_saved_max_mem_size;
 #endif
 
-#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
-#else
-#define xen_alloc_unpopulated_pages alloc_xenballooned_pages
-#define xen_free_unpopulated_pages free_xenballooned_pages
-#include <xen/balloon.h>
-#endif
 
 #endif	/* _XEN_XEN_H */
-- 
2.26.2

