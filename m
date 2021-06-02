Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898863992FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFBS7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbhFBS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622660274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zts3hO4yt/sw1o4BgZOiDS7Tbu4JXrDTlvuTJ5wSywM=;
        b=cb+KaUp+c8rnFeUp0zIiSH8uV76eBovqPtORrKR6aleoLdEm342CROOFCd/T7O+IaqaVXo
        lbe+BsWRQHez/s0GyNhG/CnaanVU7rXxrZf5KqjwF68B+fQGqdFhJ/hUpCxo01D1eGM0qb
        ACITZ2o4IY3sPbePmW6DWuH8cO8boNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-rOQJ4P8jONWC_Q1RiMUD8A-1; Wed, 02 Jun 2021 14:57:51 -0400
X-MC-Unique: rOQJ4P8jONWC_Q1RiMUD8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1252F1009465;
        Wed,  2 Jun 2021 18:57:50 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FEFA100238C;
        Wed,  2 Jun 2021 18:57:38 +0000 (UTC)
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
Subject: [PATCH v1 3/7] virtio-mem: simplify high-level plug handling in Sub Block Mode
Date:   Wed,  2 Jun 2021 20:57:16 +0200
Message-Id: <20210602185720.31821-4-david@redhat.com>
In-Reply-To: <20210602185720.31821-1-david@redhat.com>
References: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's simplify high-level memory block selection when plugging in Sub
Block Mode.

No need for two separate loops when selecting memory blocks for plugging
memory. Avoid passing the "online" state by simply obtaining the state
in virtio_mem_sbm_plug_any_sb().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 45 ++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1d4b1e25ac8b..c0e6ea6244e4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1583,9 +1583,9 @@ static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
  * Note: Can fail after some subblocks were successfully plugged.
  */
 static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
-				      unsigned long mb_id, uint64_t *nb_sb,
-				      bool online)
+				      unsigned long mb_id, uint64_t *nb_sb)
 {
+	const int old_state = virtio_mem_sbm_get_mb_state(vm, mb_id);
 	unsigned long pfn, nr_pages;
 	int sb_id, count;
 	int rc;
@@ -1607,7 +1607,7 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
 		if (rc)
 			return rc;
 		*nb_sb -= count;
-		if (!online)
+		if (old_state == VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL)
 			continue;
 
 		/* fake-online the pages if the memory block is online */
@@ -1617,23 +1617,21 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
 		virtio_mem_fake_online(pfn, nr_pages);
 	}
 
-	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
-		if (online)
-			virtio_mem_sbm_set_mb_state(vm, mb_id,
-						    VIRTIO_MEM_SBM_MB_ONLINE);
-		else
-			virtio_mem_sbm_set_mb_state(vm, mb_id,
-						    VIRTIO_MEM_SBM_MB_OFFLINE);
-	}
+	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
+		virtio_mem_sbm_set_mb_state(vm, mb_id, old_state - 1);
 
 	return 0;
 }
 
 static int virtio_mem_sbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 {
+	const int mb_states[] = {
+		VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL,
+		VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL,
+	};
 	uint64_t nb_sb = diff / vm->sbm.sb_size;
 	unsigned long mb_id;
-	int rc;
+	int rc, i;
 
 	if (!nb_sb)
 		return 0;
@@ -1641,22 +1639,13 @@ static int virtio_mem_sbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 	/* Don't race with onlining/offlining */
 	mutex_lock(&vm->hotplug_mutex);
 
-	/* Try to plug subblocks of partially plugged online blocks. */
-	virtio_mem_sbm_for_each_mb(vm, mb_id,
-				   VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
-		rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb, true);
-		if (rc || !nb_sb)
-			goto out_unlock;
-		cond_resched();
-	}
-
-	/* Try to plug subblocks of partially plugged offline blocks. */
-	virtio_mem_sbm_for_each_mb(vm, mb_id,
-				   VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
-		rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb, false);
-		if (rc || !nb_sb)
-			goto out_unlock;
-		cond_resched();
+	for (i = 0; i < ARRAY_SIZE(mb_states); i++) {
+		virtio_mem_sbm_for_each_mb(vm, mb_id, mb_states[i]) {
+			rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb);
+			if (rc || !nb_sb)
+				goto out_unlock;
+			cond_resched();
+		}
 	}
 
 	/*
-- 
2.31.1

