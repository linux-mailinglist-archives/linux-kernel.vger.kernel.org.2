Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB23AE1CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhFUDNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhFUDNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624245087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbiv+cFTXBFp5gF7k53CNJkWgbULAtjtz+qRUfUDDUY=;
        b=I6llYlEyrLLVW3f27Ji20IptQuTVzyBxE5aWiRIl4AqSOZClrvAaKM3kt7sCUM9xvbC7oM
        H7E9yyLgmAZu811TN0gAyc8ktjqJABCVaNoqXz7NBYOyh1WeMqYmXNItWRGzBNUKC5DK6E
        mRN30u/DKU1MLiTVmUiBIFlAN3nroNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-GNIjilfyM_mW_SDaATr7RQ-1; Sun, 20 Jun 2021 23:11:26 -0400
X-MC-Unique: GNIjilfyM_mW_SDaATr7RQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9FE1835AC2;
        Mon, 21 Jun 2021 03:11:24 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED79460C9D;
        Mon, 21 Jun 2021 03:11:21 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        akpm@linux-foundation.org, david@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH 1/3] mm/page_reporting: Allow to set reporting order
Date:   Mon, 21 Jun 2021 13:11:50 +0800
Message-Id: <20210621051152.305224-2-gshan@redhat.com>
In-Reply-To: <20210621051152.305224-1-gshan@redhat.com>
References: <20210621051152.305224-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro PAGE_REPORTING_MIN_ORDER is defined as the page reporting
threshold. Without a variable, it's impossible to be changed at runtime.

This introduces variable (@page_reporting_order) so that the threshold
can be changed at runtime.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 mm/page_reporting.c                             | 8 ++++++--
 mm/page_reporting.h                             | 3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

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
index c50d93ffa252..759b29f6e845 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -10,6 +10,10 @@
 #include "page_reporting.h"
 #include "internal.h"
 
+unsigned int page_reporting_order = PAGE_REPORTING_MIN_ORDER;
+module_param(page_reporting_order, uint, 0644);
+MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
+
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
@@ -229,7 +233,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
-		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
+		    (PAGE_REPORTING_CAPACITY << page_reporting_order);
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -239,7 +243,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 		return err;
 
 	/* Process each free list starting from lowest order/mt */
-	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+	for (order = page_reporting_order; order < MAX_ORDER; order++) {
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index 2c385dd4ddbd..19d58a590cc2 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -14,6 +14,7 @@
 
 #ifdef CONFIG_PAGE_REPORTING
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
+extern unsigned int page_reporting_order;
 void __page_reporting_notify(void);
 
 static inline bool page_reported(struct page *page)
@@ -38,7 +39,7 @@ static inline void page_reporting_notify_free(unsigned int order)
 		return;
 
 	/* Determine if we have crossed reporting threshold */
-	if (order < PAGE_REPORTING_MIN_ORDER)
+	if (order < page_reporting_order)
 		return;
 
 	/* This will add a few cycles, but should be called infrequently */
-- 
2.23.0

