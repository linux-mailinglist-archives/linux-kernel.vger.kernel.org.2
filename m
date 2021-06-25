Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDF3B3AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhFYCXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233067AbhFYCXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624587676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVF+yBkqDYOUwCcDvKcI0pdyyfRgoEI6L6WiisW4bFA=;
        b=WeqzRoifDMFkAHsWaHj51GjWSeUXZORlXzlm1i1K+6tIJbzZAAMLM9x3Bh/f8H4nprIxCi
        ymORVFL+7UJ2NCXqwE0eFtL+l25REo9Tsr5UMm3s7C2tCKXTsPilkRJ7JJWbld7tvq4Xm1
        W9dQSBpKv0h+a+l3CAT12DEYcHWSYsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-XPV7t3a-MFiJzce4OlbM1A-1; Thu, 24 Jun 2021 22:21:14 -0400
X-MC-Unique: XPV7t3a-MFiJzce4OlbM1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ED251084F57;
        Fri, 25 Jun 2021 02:21:13 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 406785C1A3;
        Fri, 25 Jun 2021 02:21:00 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 3/4] mm/page_reporting: Allow driver to specify reporting
Date:   Fri, 25 Jun 2021 12:21:49 +0800
Message-Id: <20210625042150.46964-4-gshan@redhat.com>
In-Reply-To: <20210625042150.46964-1-gshan@redhat.com>
References: <20210625042150.46964-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page reporting order (threshold) is sticky to @pageblock_order
by default. The page reporting can never be triggered because the
freeing page can't come up with a free area like that huge. The
situation becomes worse when the system memory becomes heavily
fragmented.

For example, the following configurations are used on ARM64 when 64KB
base page size is enabled. In this specific case, the page reporting
won't be triggered until the freeing page comes up with a 512MB free
area. That's hard to be met, especially when the system memory becomes
heavily fragmented.

   PAGE_SIZE:          64KB
   HPAGE_SIZE:         512MB
   pageblock_order:    13       (512MB)
   MAX_ORDER:          14

This allows the drivers to specify the page reporting order when the
page reporting device is registered. It falls back to @pageblock_order
if it's not specified by the driver. The existing users (hv_balloon
and virtio_balloon) don't specify it and @pageblock_order is still
taken as their page reporting order. So this shouldn't introduce any
functional changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
v5: Restore @page_reporting_order to @pageblock_order when device
    is registered and minimal page reporting order isn't provided
---
 include/linux/page_reporting.h |  3 +++
 mm/page_reporting.c            | 11 ++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

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
index 133222234f25..077925cfcc06 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -319,6 +319,7 @@ DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
+	unsigned int order;
 	int err = 0;
 
 	mutex_lock(&page_reporting_mutex);
@@ -329,9 +330,13 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 		goto err_out;
 	}
 
-	/* Update the page reporting order with @pageblock_order */
-	if (page_reporting_order > pageblock_order)
-		page_reporting_order = pageblock_order;
+	/*
+	 * Update the page reporting order if it's specified by driver.
+	 * Otherwise, it falls back to @pageblock_order.
+	 */
+	order = prdev->order ? : pageblock_order;
+	if (page_reporting_order > order)
+		page_reporting_order = order;
 
 	/* initialize state and work structures */
 	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
-- 
2.23.0

