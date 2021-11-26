Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA0045EF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377660AbhKZNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230147AbhKZNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637934178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4ASNgq1wvOne4qpYWmxZPMmbkQM20zd6LP7bCK7u48=;
        b=GffYIcIuewGHWowRNeQ8nWDm6xmQPJVqi2jQYUHqfhUt23hlQYbSKWW0IJ1bBr/qejDTIZ
        iIOoq+uxhIF6SLd2XszPmNsKgk4Ec/wSWrE+JDksme4+SUna3Tpgqbhz7E2MvAlo+z3ipF
        zDKlSvPXEBetTms/ZF46xkv9P67Sfv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-kLUfQrpTOl2g6qN_yUWUvQ-1; Fri, 26 Nov 2021 08:42:55 -0500
X-MC-Unique: kLUfQrpTOl2g6qN_yUWUvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB25E84B9A1;
        Fri, 26 Nov 2021 13:42:53 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F11E46C350;
        Fri, 26 Nov 2021 13:42:45 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Gavin Shan <gshan@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 2/2] virtio-mem: prepare fake page onlining code for granularity smaller than MAX_ORDER - 1
Date:   Fri, 26 Nov 2021 14:42:09 +0100
Message-Id: <20211126134209.17332-3-david@redhat.com>
In-Reply-To: <20211126134209.17332-1-david@redhat.com>
References: <20211126134209.17332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's prepare our fake page onlining code for subblock size smaller than
MAX_ORDER - 1: we might get called for ranges not covering properly
aligned MAX_ORDER - 1 pages. We have to detect the order to use
dynamically.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 03e1c5743699..50de7582c9f8 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1121,15 +1121,18 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
  */
 static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 {
-	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
+	unsigned long order = MAX_ORDER - 1;
 	unsigned long i;
 
 	/*
-	 * We are always called at least with MAX_ORDER_NR_PAGES
-	 * granularity/alignment (e.g., the way subblocks work). All pages
-	 * inside such a block are alike.
+	 * We might get called for ranges that don't cover properly aligned
+	 * MAX_ORDER - 1 pages; however, we can only online properly aligned
+	 * pages with an order of MAX_ORDER - 1 at maximum.
 	 */
-	for (i = 0; i < nr_pages; i += max_nr_pages) {
+	while (!IS_ALIGNED(pfn | nr_pages, 1 << order))
+		order--;
+
+	for (i = 0; i < nr_pages; i += 1 << order) {
 		struct page *page = pfn_to_page(pfn + i);
 
 		/*
@@ -1139,14 +1142,12 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 		 * alike.
 		 */
 		if (PageDirty(page)) {
-			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
-						      false);
-			generic_online_page(page, MAX_ORDER - 1);
+			virtio_mem_clear_fake_offline(pfn + i, 1 << order, false);
+			generic_online_page(page, order);
 		} else {
-			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
-						      true);
-			free_contig_range(pfn + i, max_nr_pages);
-			adjust_managed_page_count(page, max_nr_pages);
+			virtio_mem_clear_fake_offline(pfn + i, 1 << order, true);
+			free_contig_range(pfn + i, 1 << order);
+			adjust_managed_page_count(page, 1 << order);
 		}
 	}
 }
@@ -2477,7 +2478,6 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	/*
 	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
 	 * pageblock_nr_pages pages. This:
-	 * - Simplifies our fake page onlining code (virtio_mem_fake_online).
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-- 
2.31.1

