Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB145EF58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbhKZNsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhKZNqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637934172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pf5AnwtjuEWZEkz9IxLXg6YM4NriRbnw6GmkdEx/NUY=;
        b=MEoPtkIEC3nSdJ9vKQtcGYGIgu8NgNHCjtFda92wn4EQ3V8B2IqG07JuXm7D1pD3s1xzul
        ach2l61ntSGO7kJZODLBtH1IqRX0Ih0oK1KhFUVlKE2A+oGR1sz37Yn3tO+pirq9gup0rj
        DXeKVgsRd1pmNR38w7f/BeiTGvW8pcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-105-abeeqz1VPJ-LBBU3vF8z-A-1; Fri, 26 Nov 2021 08:42:47 -0500
X-MC-Unique: abeeqz1VPJ-LBBU3vF8z-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B40584B9AC;
        Fri, 26 Nov 2021 13:42:45 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E861872FA6;
        Fri, 26 Nov 2021 13:42:35 +0000 (UTC)
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
Subject: [PATCH v1 1/2] virtio-mem: prepare page onlining code for granularity smaller than MAX_ORDER - 1
Date:   Fri, 26 Nov 2021 14:42:08 +0100
Message-Id: <20211126134209.17332-2-david@redhat.com>
In-Reply-To: <20211126134209.17332-1-david@redhat.com>
References: <20211126134209.17332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's prepare our page onlining code for subblock size smaller than
MAX_ORDER - 1: we'll get called for a MAX_ORDER - 1 page but might have
some subblocks in the range plugged and some unplugged. In that case,
fallback to subblock granularity to properly only expose the plugged
parts to the buddy.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 86 ++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 96e5a8782769..03e1c5743699 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/bitmap.h>
 #include <linux/lockdep.h>
+#include <linux/log2.h>
 
 #include <acpi/acpi_numa.h>
 
@@ -1228,28 +1229,46 @@ static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
 		page_ref_inc(pfn_to_page(pfn + i));
 }
 
-static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
+static void virtio_mem_online_page(struct virtio_mem *vm,
+				   struct page *page, unsigned int order)
 {
-	const unsigned long addr = page_to_phys(page);
-	unsigned long id, sb_id;
-	struct virtio_mem *vm;
+	const unsigned long start = page_to_phys(page);
+	const unsigned long end = start + PFN_PHYS(1 << order);
+	unsigned long addr, next, id, sb_id, count;
 	bool do_online;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
-		if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
-			continue;
+	/*
+	 * We can get called with any order up to MAX_ORDER - 1. If our
+	 * subblock size is smaller than that and we have a mixture of plugged
+	 * and unplugged subblocks within such a page, we have to process in
+	 * smaller granularity. In that case we'll adjust the order exactly once
+	 * within the loop.
+	 */
+	for (addr = start; addr < end; ) {
+		next = addr + PFN_PHYS(1 << order);
 
 		if (vm->in_sbm) {
-			/*
-			 * We exploit here that subblocks have at least
-			 * MAX_ORDER_NR_PAGES size/alignment - so we cannot
-			 * cross subblocks within one call.
-			 */
 			id = virtio_mem_phys_to_mb_id(addr);
 			sb_id = virtio_mem_phys_to_sb_id(vm, addr);
-			do_online = virtio_mem_sbm_test_sb_plugged(vm, id,
-								   sb_id, 1);
+			count = virtio_mem_phys_to_sb_id(vm, next - 1) - sb_id + 1;
+
+			if (virtio_mem_sbm_test_sb_plugged(vm, id, sb_id, count)) {
+				/* Fully plugged. */
+				do_online = true;
+			} else if (count == 1 ||
+				   virtio_mem_sbm_test_sb_unplugged(vm, id, sb_id, count)) {
+				/* Fully unplugged. */
+				do_online = false;
+			} else {
+				/*
+				 * Mixture, process sub-blocks instead. This
+				 * will be at least the size of a pageblock.
+				 * We'll run into this case exactly once.
+				 */
+				order = ilog2(vm->sbm.sb_size) - PAGE_SHIFT;
+				do_online = virtio_mem_sbm_test_sb_plugged(vm, id, sb_id, 1);
+				continue;
+			}
 		} else {
 			/*
 			 * If the whole block is marked fake offline, keep
@@ -1260,18 +1279,38 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 				    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE;
 		}
 
+		if (do_online)
+			generic_online_page(pfn_to_page(PFN_DOWN(addr)), order);
+		else
+			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
+						    false);
+		addr = next;
+	}
+}
+
+static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
+{
+	const unsigned long addr = page_to_phys(page);
+	struct virtio_mem *vm;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
 		/*
-		 * virtio_mem_set_fake_offline() might sleep, we don't need
-		 * the device anymore. See virtio_mem_remove() how races
+		 * Pages we're onlining will never cross memory blocks and,
+		 * therefore, not virtio-mem devices.
+		 */
+		if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
+			continue;
+
+		/*
+		 * virtio_mem_set_fake_offline() might sleep. We can safely
+		 * drop the RCU lock at this point because the device
+		 * cannot go away. See virtio_mem_remove() how races
 		 * between memory onlining and device removal are handled.
 		 */
 		rcu_read_unlock();
 
-		if (do_online)
-			generic_online_page(page, order);
-		else
-			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
-						    false);
+		virtio_mem_online_page(vm, page, order);
 		return;
 	}
 	rcu_read_unlock();
@@ -2438,8 +2477,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	/*
 	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
 	 * pageblock_nr_pages pages. This:
-	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
-	 *   and fake page onlining code (virtio_mem_fake_online).
+	 * - Simplifies our fake page onlining code (virtio_mem_fake_online).
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-- 
2.31.1

