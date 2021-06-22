Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109B3AFCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFVFvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhFVFvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624340934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHxgv1eTquCmD6Mjigwdi8Spxl8dlyPH5NJv2Jh2SZk=;
        b=VALaCyrqUDjYjv/gCKwCAeMPoDbaDmXCImKx2v4GV9XL64OIMvjNPWdqGtzxP0burxgj7w
        kiZfatAkFg6AZ7Ps0JMXcUGsxyj910UyLG7ouBUyNC3Ei6coaPW8exPLpMQOGYyHck5zE+
        UKNI6UMjiYHOHmTYT/DbOB41gKtUIKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-jb35Z6bBMmWL9YqXuM2NyQ-1; Tue, 22 Jun 2021 01:48:52 -0400
X-MC-Unique: jb35Z6bBMmWL9YqXuM2NyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B742106B7D8;
        Tue, 22 Jun 2021 05:48:51 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D71AA5D9DE;
        Tue, 22 Jun 2021 05:48:47 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 2/3] mm/page_reporting: Allow driver to specify threshold
Date:   Tue, 22 Jun 2021 15:49:25 +0800
Message-Id: <20210622074926.333223-3-gshan@redhat.com>
In-Reply-To: <20210622074926.333223-1-gshan@redhat.com>
References: <20210622074926.333223-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page reporting threshold is currently sticky to @pageblock_order.
The page reporting can never be triggered because the freeing page
can't come up with a free area like that huge. The situation becomes
worse when the system memory becomes heavily fragmented.

For example, the following configurations are used on ARM64 when 64KB
base page size is enabled. In this specific case, the page reporting
won't be triggered until the freeing page comes up with a 512MB free
area. That's hard to be met, especially when the system memory becomes
heavily fragmented.

   PAGE_SIZE:          64KB
   HPAGE_SIZE:         512MB
   pageblock_order:    13       (512MB)
   MAX_ORDER:          14

This allows the drivers to specify the threshold when the page
reporting device is registered. The threshold falls back to
@pageblock_order if it's not specified by the driver. The existing
users (hv_balloon and virtio_balloon) don't specify the threshold
and @pageblock_order is still taken as their page reporting order.
So this shouldn't introduce functional changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/page_reporting.h |  3 +++
 mm/page_reporting.c            | 14 ++++++++++----
 mm/page_reporting.h            | 10 ++--------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 3b99e0ec24f2..fe648dfa3a7c 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -18,6 +18,9 @@ struct page_reporting_dev_info {
 
 	/* Current state of page reporting */
 	atomic_t state;
+
+	/* Minimal order of page reporting */
+	unsigned int order;
 };
 
 /* Tear-down and bring-up for page reporting devices */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index df9c5054e1b4..27670360bae6 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -47,7 +47,7 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
 }
 
 /* notify prdev of free page reporting request */
-void __page_reporting_notify(void)
+void __page_reporting_notify(unsigned int order)
 {
 	struct page_reporting_dev_info *prdev;
 
@@ -58,7 +58,7 @@ void __page_reporting_notify(void)
 	 */
 	rcu_read_lock();
 	prdev = rcu_dereference(pr_dev_info);
-	if (likely(prdev))
+	if (likely(prdev && order >= prdev->order))
 		__page_reporting_request(prdev);
 
 	rcu_read_unlock();
@@ -229,7 +229,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
-		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
+		    (PAGE_REPORTING_CAPACITY << prdev->order);
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -239,7 +239,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 		return err;
 
 	/* Process each free list starting from lowest order/mt */
-	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+	for (order = prdev->order; order < MAX_ORDER; order++) {
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
@@ -324,6 +324,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 		goto err_out;
 	}
 
+	/*
+	 * We need to choose the minimal order of page reporting if it's
+	 * not specified by the driver.
+	 */
+	prdev->order = prdev->order ? prdev->order : pageblock_order;
+
 	/* initialize state and work structures */
 	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
 	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index 2c385dd4ddbd..d9f972e72649 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -10,11 +10,9 @@
 #include <linux/pgtable.h>
 #include <linux/scatterlist.h>
 
-#define PAGE_REPORTING_MIN_ORDER	pageblock_order
-
 #ifdef CONFIG_PAGE_REPORTING
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
-void __page_reporting_notify(void);
+void __page_reporting_notify(unsigned int order);
 
 static inline bool page_reported(struct page *page)
 {
@@ -37,12 +35,8 @@ static inline void page_reporting_notify_free(unsigned int order)
 	if (!static_branch_unlikely(&page_reporting_enabled))
 		return;
 
-	/* Determine if we have crossed reporting threshold */
-	if (order < PAGE_REPORTING_MIN_ORDER)
-		return;
-
 	/* This will add a few cycles, but should be called infrequently */
-	__page_reporting_notify();
+	__page_reporting_notify(order);
 }
 #else /* CONFIG_PAGE_REPORTING */
 #define page_reported(_page)	false
-- 
2.23.0

