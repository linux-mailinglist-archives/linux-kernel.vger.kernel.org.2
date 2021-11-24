Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BECC45CE75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245074AbhKXU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbhKXU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:57:08 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA21C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:57 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l22so10547604lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bBzcwXnF7StEF2GaOPBNcx1Wl0n3Nu3jkY6wILUpfDk=;
        b=hNSawdtIKqKkXOdFHN2uTZ0q0K/gYr/34I9n/95muvOE5k4g8r+/1VT/CEy0n8w4yR
         mj7aGi00URp6vPVAr3zzo3ZJS82dif3B1J3L2dF9gRosbTigq5HX/z0BdZBEHbPLZ2ko
         GDWMNBuqcmEkLkmPC9CEM01MzlukwawY1hbayiZATGlp+CoVm1Lr7iq6wk2W88noX3VJ
         h+wTXLNwR8grH/ovbjNGU8Jia0Iu9rImbPH5g/o26POuEJdgKdP0NzDrZf9f70bq65Yc
         fCyX8tWWRf0Ro8Tef40cCZtJ61FnNnVIuFocKr5I+1pdq3wdVxSS06cpqfiFNU8/BPDo
         gUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bBzcwXnF7StEF2GaOPBNcx1Wl0n3Nu3jkY6wILUpfDk=;
        b=rwTzSlZi8hW+ISKBlQMhOP3ZXlm0rdJKWJYngEdH4J7dEKkfrqjI4BN+meCHpqK3t7
         M4hFKKZfjbB8+cYYk9tOHz0nRQnPR8Sc/ndmXhdJwOkgrIqc6gdFbQ57cZ93jkM+t22D
         N1lmpcg+oT+1vfcOJ+9vj1iqznnVSDFG79+OthckEmUjZyp8qWmeiKo7ku/qeCcoDrBm
         oN9u1Iic7SQmnJKIojmLbezjcZ1S9AGkAeYKD4euGLCu7fcI+iIBFEZmU+omtVlc53s/
         efD1aW33CLnQEejbZOtjaAWuTB5gtblMgkjan3BFlItOLp3PLmMJzLDe79HRpuhmMipi
         Cczg==
X-Gm-Message-State: AOAM531LbcfxfU7SoxknrYD5E5lQuGvmpeehlwzerOVS0IIFLuqx5HUW
        9wmhIBtO1QdsqJkOydGHAAA=
X-Google-Smtp-Source: ABdhPJyAtC2rXXgB00e51jXJeM37wdOSE76oQzRhOwTYzttgAcdt/wMbcWS+vs/AGA/z25Ivcp2rgQ==
X-Received: by 2002:a05:6512:3f0f:: with SMTP id y15mr18956817lfa.263.1637787236043;
        Wed, 24 Nov 2021 12:53:56 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id j11sm97608ljc.9.2021.11.24.12.53.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:53:55 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V3 3/6] xen/balloon: Bring alloc(free)_xenballooned_pages helpers back
Date:   Wed, 24 Nov 2021 22:53:40 +0200
Message-Id: <1637787223-21129-4-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

This patch rolls back some of the changes introduced by commit
121f2faca2c0a "xen/balloon: rename alloc/free_xenballooned_pages"
in order to make possible to still allocate xenballooned pages
if CONFIG_XEN_UNPOPULATED_ALLOC is enabled.

On Arm the unpopulated pages will be allocated on top of extended
regions provided by Xen via device-tree (the subsequent patches
will add required bits to support unpopulated-alloc feature on Arm).
The problem is that extended regions feature has been introduced
into Xen quite recently (during 4.16 release cycle). So this
effectively means that Linux must only use unpopulated-alloc on Arm
if it is running on "new Xen" which advertises these regions.
But, it will only be known after parsing the "hypervisor" node
at boot time, so before doing that we cannot assume anything.

In order to keep working if CONFIG_XEN_UNPOPULATED_ALLOC is enabled
and the extended regions are not advertised (Linux is running on
"old Xen", etc) we need the fallback to alloc_xenballooned_pages().

This way we wouldn't reduce the amount of memory usable (wasting
RAM pages) for any of the external mappings anymore (and eliminate
XSA-300) with "new Xen", but would be still functional ballooning
out RAM pages with "old Xen".

Also rename alloc(free)_xenballooned_pages to xen_alloc(free)_ballooned_pages
and make xen_alloc(free)_unpopulated_pages static inline in xen.h
if CONFIG_XEN_UNPOPULATED_ALLOC is disabled.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
@Stefano, I decided to retain your R-b after making a minor
change (make xen_alloc(free)_unpopulated_pages static inline
in xen.h if CONFIG_XEN_UNPOPULATED_ALLOC is disabled).
Please let me know if you think otherwise.

Changes V2 -> V3:
   - new patch
---
 drivers/xen/balloon.c | 20 +++++++++-----------
 include/xen/balloon.h |  3 +++
 include/xen/xen.h     | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index ba2ea11..a2c4fc49 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -581,7 +581,6 @@ void balloon_set_new_target(unsigned long target)
 }
 EXPORT_SYMBOL_GPL(balloon_set_new_target);
 
-#ifndef CONFIG_XEN_UNPOPULATED_ALLOC
 static int add_ballooned_pages(unsigned int nr_pages)
 {
 	enum bp_state st;
@@ -610,12 +609,12 @@ static int add_ballooned_pages(unsigned int nr_pages)
 }
 
 /**
- * xen_alloc_unpopulated_pages - get pages that have been ballooned out
+ * xen_alloc_ballooned_pages - get pages that have been ballooned out
  * @nr_pages: Number of pages to get
  * @pages: pages returned
  * @return 0 on success, error otherwise
  */
-int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+int xen_alloc_ballooned_pages(unsigned int nr_pages, struct page **pages)
 {
 	unsigned int pgno = 0;
 	struct page *page;
@@ -652,23 +651,23 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 	return 0;
  out_undo:
 	mutex_unlock(&balloon_mutex);
-	xen_free_unpopulated_pages(pgno, pages);
+	xen_free_ballooned_pages(pgno, pages);
 	/*
-	 * NB: free_xenballooned_pages will only subtract pgno pages, but since
+	 * NB: xen_free_ballooned_pages will only subtract pgno pages, but since
 	 * target_unpopulated is incremented with nr_pages at the start we need
 	 * to remove the remaining ones also, or accounting will be screwed.
 	 */
 	balloon_stats.target_unpopulated -= nr_pages - pgno;
 	return ret;
 }
-EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
+EXPORT_SYMBOL(xen_alloc_ballooned_pages);
 
 /**
- * xen_free_unpopulated_pages - return pages retrieved with get_ballooned_pages
+ * xen_free_ballooned_pages - return pages retrieved with get_ballooned_pages
  * @nr_pages: Number of pages
  * @pages: pages to return
  */
-void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages)
 {
 	unsigned int i;
 
@@ -687,9 +686,9 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 
 	mutex_unlock(&balloon_mutex);
 }
-EXPORT_SYMBOL(xen_free_unpopulated_pages);
+EXPORT_SYMBOL(xen_free_ballooned_pages);
 
-#if defined(CONFIG_XEN_PV)
+#if defined(CONFIG_XEN_PV) && !defined(CONFIG_XEN_UNPOPULATED_ALLOC)
 static void __init balloon_add_region(unsigned long start_pfn,
 				      unsigned long pages)
 {
@@ -712,7 +711,6 @@ static void __init balloon_add_region(unsigned long start_pfn,
 	balloon_stats.total_pages += extra_pfn_end - start_pfn;
 }
 #endif
-#endif
 
 static int __init balloon_init(void)
 {
diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index e93d4f0..f78a6cc 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -26,6 +26,9 @@ extern struct balloon_stats balloon_stats;
 
 void balloon_set_new_target(unsigned long target);
 
+int xen_alloc_ballooned_pages(unsigned int nr_pages, struct page **pages);
+void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages);
+
 #ifdef CONFIG_XEN_BALLOON
 void xen_balloon_init(void);
 #else
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 9f031b5..86c5b37 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -52,7 +52,21 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 extern u64 xen_saved_max_mem_size;
 #endif
 
+#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
+#else
+#include <xen/balloon.h>
+static inline int xen_alloc_unpopulated_pages(unsigned int nr_pages,
+		struct page **pages)
+{
+	return xen_alloc_ballooned_pages(nr_pages, pages);
+}
+static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
+		struct page **pages)
+{
+	xen_free_ballooned_pages(nr_pages, pages);
+}
+#endif
 
 #endif	/* _XEN_XEN_H */
-- 
2.7.4

