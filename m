Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7C399304
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhFBTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhFBS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622660295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=di/rBgpO3ofh6oyQUWmcuqLGaaUuBYS2slt2/XE3Gtc=;
        b=BO+G5/BK2L0Km6r7FQLPfgLuXGGQmx3saBaV/7Q3pokYS0SlJf5bWEVZdGv0/hZm7X2mic
        +7TD2z4YHQFjsIOUqVt4lf1sd9myzZkhkl8U5YS3CedFyC909/NL5a6bms/DkadNcoyTJH
        T473NDJ0W2bkzFbP90EnQ95N6TrYuz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-dILL77kCN9SXtJzC6wQM5Q-1; Wed, 02 Jun 2021 14:58:14 -0400
X-MC-Unique: dILL77kCN9SXtJzC6wQM5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 616608015F8;
        Wed,  2 Jun 2021 18:58:12 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6C30100238C;
        Wed,  2 Jun 2021 18:57:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 7/7] virtio-mem: prioritize unplug from ZONE_MOVABLE in Big Block Mode
Date:   Wed,  2 Jun 2021 20:57:20 +0200
Message-Id: <20210602185720.31821-8-david@redhat.com>
In-Reply-To: <20210602185720.31821-1-david@redhat.com>
References: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's handle unplug in Big Block Mode similar to Sub Block Mode --
prioritize memory blocks onlined to ZONE_MOVABLE.

We won't care further about big blocks with mixed zones, as it's
rather a corner case that won't matter in practice.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 43199389c414..d3e874b6b50b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2121,6 +2121,29 @@ static bool virtio_mem_bbm_bb_is_offline(struct virtio_mem *vm,
 	return true;
 }
 
+/*
+ * Test if a big block is completely onlined to ZONE_MOVABLE (or offline).
+ */
+static bool virtio_mem_bbm_bb_is_movable(struct virtio_mem *vm,
+					 unsigned long bb_id)
+{
+	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
+	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
+	struct page *page;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < start_pfn + nr_pages;
+	     pfn += PAGES_PER_SECTION) {
+		page = pfn_to_online_page(pfn);
+		if (!page)
+			continue;
+		if (page_zonenum(page) != ZONE_MOVABLE)
+			return false;
+	}
+
+	return true;
+}
+
 static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
 	uint64_t nb_bb = diff / vm->bbm.bb_size;
@@ -2134,7 +2157,7 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	 * Try to unplug big blocks. Similar to SBM, start with offline
 	 * big blocks.
 	 */
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 3; i++) {
 		virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
 			cond_resched();
 
@@ -2144,6 +2167,8 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 			 */
 			if (i == 0 && !virtio_mem_bbm_bb_is_offline(vm, bb_id))
 				continue;
+			if (i == 1 && !virtio_mem_bbm_bb_is_movable(vm, bb_id))
+				continue;
 			rc = virtio_mem_bbm_offline_remove_and_unplug_bb(vm, bb_id);
 			if (rc == -EBUSY)
 				continue;
-- 
2.31.1

