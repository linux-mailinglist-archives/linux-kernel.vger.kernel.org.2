Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E4399301
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFBS7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229818AbhFBS7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622660282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NyK0X+EeNFFf5kQFogzlz9x+jfPQbw0BsoidFV+dDX8=;
        b=ezp7LLBupBALftLJhkQw1YCnxv8pVvHYXVeFBfN9ZNIelU1IKhzQTpXVJMEcT8B7wTqEJy
        J7x/97NginoN9QvZpWOX+mRT+sABeYJiIdFuYJYg9fuVsgfhdfjtUBpCxdPa+F1R3vfLM4
        v/nUrqhpsiUq0aU+woEbUfTXozb4uGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-m0STjPqiPimH2TG1aJDxEw-1; Wed, 02 Jun 2021 14:58:01 -0400
X-MC-Unique: m0STjPqiPimH2TG1aJDxEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78A7A801B16;
        Wed,  2 Jun 2021 18:57:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC36D100238C;
        Wed,  2 Jun 2021 18:57:56 +0000 (UTC)
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
Subject: [PATCH v1 6/7] virtio-mem: simplify high-level unplug handling in Big Block Mode
Date:   Wed,  2 Jun 2021 20:57:19 +0200
Message-Id: <20210602185720.31821-7-david@redhat.com>
In-Reply-To: <20210602185720.31821-1-david@redhat.com>
References: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's simplify high-level big block selection when unplugging in
Big Block Mode.

Combine handling of offline and online blocks. We can get rid of
virtio_mem_bbm_bb_is_offline() and simply use
virtio_mem_bbm_offline_remove_and_unplug_bb(), as that already tolerates
offline parts.

We can race with concurrent onlining/offlining either way, so we don;t
have to be super correct by failing if an offline big block we'd like to
unplug just got (partially) onlined.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 96 ++++++++++---------------------------
 1 file changed, 24 insertions(+), 72 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 156a79ceb9fc..43199389c414 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -702,18 +702,6 @@ static int virtio_mem_sbm_remove_mb(struct virtio_mem *vm, unsigned long mb_id)
 	return virtio_mem_remove_memory(vm, addr, size);
 }
 
-/*
- * See virtio_mem_remove_memory(): Try to remove all Linux memory blocks covered
- * by the big block.
- */
-static int virtio_mem_bbm_remove_bb(struct virtio_mem *vm, unsigned long bb_id)
-{
-	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
-	const uint64_t size = vm->bbm.bb_size;
-
-	return virtio_mem_remove_memory(vm, addr, size);
-}
-
 /*
  * Try offlining and removing memory from Linux.
  *
@@ -2114,35 +2102,6 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 	return rc;
 }
 
-/*
- * Try to remove a big block from Linux and unplug it. Will fail with
- * -EBUSY if some memory is online.
- *
- * Will modify the state of the memory block.
- */
-static int virtio_mem_bbm_remove_and_unplug_bb(struct virtio_mem *vm,
-					       unsigned long bb_id)
-{
-	int rc;
-
-	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
-			 VIRTIO_MEM_BBM_BB_ADDED))
-		return -EINVAL;
-
-	rc = virtio_mem_bbm_remove_bb(vm, bb_id);
-	if (rc)
-		return -EBUSY;
-
-	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
-	if (rc)
-		virtio_mem_bbm_set_bb_state(vm, bb_id,
-					    VIRTIO_MEM_BBM_BB_PLUGGED);
-	else
-		virtio_mem_bbm_set_bb_state(vm, bb_id,
-					    VIRTIO_MEM_BBM_BB_UNUSED);
-	return rc;
-}
-
 /*
  * Test if a big block is completely offline.
  */
@@ -2166,42 +2125,35 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
 	uint64_t nb_bb = diff / vm->bbm.bb_size;
 	uint64_t bb_id;
-	int rc;
+	int rc, i;
 
 	if (!nb_bb)
 		return 0;
 
-	/* Try to unplug completely offline big blocks first. */
-	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
-		cond_resched();
-		/*
-		 * As we're holding no locks, this check is racy as memory
-		 * can get onlined in the meantime - but we'll fail gracefully.
-		 */
-		if (!virtio_mem_bbm_bb_is_offline(vm, bb_id))
-			continue;
-		rc = virtio_mem_bbm_remove_and_unplug_bb(vm, bb_id);
-		if (rc == -EBUSY)
-			continue;
-		if (!rc)
-			nb_bb--;
-		if (rc || !nb_bb)
-			return rc;
-	}
-
-	if (!unplug_online)
-		return 0;
+	/*
+	 * Try to unplug big blocks. Similar to SBM, start with offline
+	 * big blocks.
+	 */
+	for (i = 0; i < 2; i++) {
+		virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
+			cond_resched();
 
-	/* Try to unplug any big blocks. */
-	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
-		cond_resched();
-		rc = virtio_mem_bbm_offline_remove_and_unplug_bb(vm, bb_id);
-		if (rc == -EBUSY)
-			continue;
-		if (!rc)
-			nb_bb--;
-		if (rc || !nb_bb)
-			return rc;
+			/*
+			 * As we're holding no locks, these checks are racy,
+			 * but we don't care.
+			 */
+			if (i == 0 && !virtio_mem_bbm_bb_is_offline(vm, bb_id))
+				continue;
+			rc = virtio_mem_bbm_offline_remove_and_unplug_bb(vm, bb_id);
+			if (rc == -EBUSY)
+				continue;
+			if (!rc)
+				nb_bb--;
+			if (rc || !nb_bb)
+				return rc;
+		}
+		if (i == 0 && !unplug_online)
+			return 0;
 	}
 
 	return nb_bb ? -EBUSY : 0;
-- 
2.31.1

