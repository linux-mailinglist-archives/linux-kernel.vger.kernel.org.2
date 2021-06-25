Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBBB3B39D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 01:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhFXXtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 19:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232903AbhFXXtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 19:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624578406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ADOV9wK2MiGvNZBTCp7t2S2endD4UPlZ/ROABcvCTw=;
        b=a4pu6ZKzMF0iy26mOVUdNmqBpVk4EpCSL8kRn+xr+UMHDZ9komJn17dlBToGN3j4SBy1Sl
        /kwAlFGxXuJBGEEyLjLeSAmxd6O6A3DlOBTu8WWOc47PgSsVFAkYP+Q7yPRPT1EKOWhMeg
        TLh2GdJ7NJmQ7RoHzLzSooMvLOg0wo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-Gs-XqaiPMC-waEtC2iDSIg-1; Thu, 24 Jun 2021 19:46:42 -0400
X-MC-Unique: Gs-XqaiPMC-waEtC2iDSIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4669D18414A1;
        Thu, 24 Jun 2021 23:46:41 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEC7660871;
        Thu, 24 Jun 2021 23:46:37 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v4 2/4] mm/page_reporting: Export reporting order as module parameter
Date:   Fri, 25 Jun 2021 09:47:08 +0800
Message-Id: <20210625014710.42954-3-gshan@redhat.com>
In-Reply-To: <20210625014710.42954-1-gshan@redhat.com>
References: <20210625014710.42954-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro PAGE_REPORTING_MIN_ORDER is defined as the page reporting
threshold. It can't be adjusted at runtime.

This introduces a variable (@page_reporting_order) to replace the
marcro (PAGE_REPORTING_MIN_ORDER). MAX_ORDER is assigned to it initially,
meaning the page reporting is disabled. It will be specified by driver
if valid one is provided. Otherwise, it will fall back to @pageblock_order.
It's also exported so that the page reporting order can be adjusted at
runtime.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 mm/page_reporting.c                             | 9 +++++++--
 mm/page_reporting.h                             | 5 ++---
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..566c4b9af3cd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3566,6 +3566,12 @@
 			off: turn off poisoning (default)
 			on: turn on poisoning
 
+	page_reporting.page_reporting_order=
+			[KNL] Minimal page reporting order
+			Format: <integer>
+			Adjust the minimal page reporting order. The page
+			reporting is disabled when it exceeds (MAX_ORDER-1).
+
 	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
 			timeout = 0: wait forever
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index df9c5054e1b4..34bf4d26c2c4 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -4,12 +4,17 @@
 #include <linux/page_reporting.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
 
 #include "page_reporting.h"
 #include "internal.h"
 
+unsigned int page_reporting_order = MAX_ORDER;
+module_param(page_reporting_order, uint, 0644);
+MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
+
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
@@ -229,7 +234,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
-		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
+		    (PAGE_REPORTING_CAPACITY << page_reporting_order);
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -239,7 +244,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 		return err;
 
 	/* Process each free list starting from lowest order/mt */
-	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+	for (order = page_reporting_order; order < MAX_ORDER; order++) {
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index 2c385dd4ddbd..c51dbc228b94 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -10,10 +10,9 @@
 #include <linux/pgtable.h>
 #include <linux/scatterlist.h>
 
-#define PAGE_REPORTING_MIN_ORDER	pageblock_order
-
 #ifdef CONFIG_PAGE_REPORTING
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
+extern unsigned int page_reporting_order;
 void __page_reporting_notify(void);
 
 static inline bool page_reported(struct page *page)
@@ -38,7 +37,7 @@ static inline void page_reporting_notify_free(unsigned int order)
 		return;
 
 	/* Determine if we have crossed reporting threshold */
-	if (order < PAGE_REPORTING_MIN_ORDER)
+	if (order < page_reporting_order)
 		return;
 
 	/* This will add a few cycles, but should be called infrequently */
-- 
2.23.0

