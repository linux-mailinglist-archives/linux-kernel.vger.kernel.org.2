Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514F83B39D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 01:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhFXXtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 19:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232975AbhFXXtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 19:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624578411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvfjZ7OCWUeY0EJQb9/adqes8dgbSmVT3S2TSqMzQNI=;
        b=XZXBjiHajVvqzkNatadNrA4ZWaeSHr36YDFdINQeV/mPSMNcUKualBo8M3ls3bkH9xTE8m
        Cq/6T5Jm6PpyYOnsGJdQ+jcl3jBQZhetgtbJqvd0B03kZSvfNHwyvV9ZBcGggDixbfHMex
        W2X6OUw4JYHb4UotdvclVx2pxY/CZ7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-KDjT0tRvMKCIyk-3AmX9TA-1; Thu, 24 Jun 2021 19:46:47 -0400
X-MC-Unique: KDjT0tRvMKCIyk-3AmX9TA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF30804146;
        Thu, 24 Jun 2021 23:46:45 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D82A060871;
        Thu, 24 Jun 2021 23:46:41 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v4 3/4] mm/page_reporting: Allow driver to specify reporting order
Date:   Fri, 25 Jun 2021 09:47:09 +0800
Message-Id: <20210625014710.42954-4-gshan@redhat.com>
In-Reply-To: <20210625014710.42954-1-gshan@redhat.com>
References: <20210625014710.42954-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 include/linux/page_reporting.h | 3 +++
 mm/page_reporting.c            | 6 ++++++
 2 files changed, 9 insertions(+)

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
index 34bf4d26c2c4..382958eef8a9 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -329,6 +329,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 		goto err_out;
 	}
 
+	/*
+	 * Update the page reporting order if it's specified by driver.
+	 * Otherwise, it falls back to @pageblock_order.
+	 */
+	page_reporting_order = prdev->order ? : pageblock_order;
+
 	/* initialize state and work structures */
 	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
 	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
-- 
2.23.0

