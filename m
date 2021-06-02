Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884253992FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFBS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhFBS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622660276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opX8nHoEd36stvd7Apu9m63irxvh9gxuAe97ioC+BQQ=;
        b=fD48NnEuvCPuC4yiQh0nDutL1zJ8q0/wHyqh0PCVdy43bTntmiurHrLCjsJLLi5U1QQGSm
        Zu8jEkBiNdweYtlaBG3XVGQCYbXWwVTATGw5P/VqKFGFwSb4GDLRhR019dKBmW3bf7jUME
        n3cqfZDir+u/3Pt+76qSDb9c8R/WMso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-yPJ8YLn9PiC5J6o7nhb5Lg-1; Wed, 02 Jun 2021 14:57:54 -0400
X-MC-Unique: yPJ8YLn9PiC5J6o7nhb5Lg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C90E180FD64;
        Wed,  2 Jun 2021 18:57:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70247100238C;
        Wed,  2 Jun 2021 18:57:50 +0000 (UTC)
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
Subject: [PATCH v1 4/7] virtio-mem: simplify high-level unplug handling in Sub Block Mode
Date:   Wed,  2 Jun 2021 20:57:17 +0200
Message-Id: <20210602185720.31821-5-david@redhat.com>
In-Reply-To: <20210602185720.31821-1-david@redhat.com>
References: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's simplify by introducing a new virtio_mem_sbm_unplug_any_sb(),
similar to virtio_mem_sbm_plug_any_sb(), to simplify high-level memory
block selection when unplugging in Sub Block Mode.

Rename existing virtio_mem_sbm_unplug_any_sb() to
virtio_mem_sbm_unplug_any_sb_raw().

The only change is that we now temporarily unlock the hotplug mutex around
cond_resched() when processing offline memory blocks, which doesn't
make a real difference as we already have to temporarily unlock in
virtio_mem_sbm_unplug_any_sb_offline() when removing a memory block.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 103 ++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index c0e6ea6244e4..d54bb34a7ed8 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1453,8 +1453,8 @@ static int virtio_mem_bbm_plug_bb(struct virtio_mem *vm, unsigned long bb_id)
  *
  * Note: can fail after some subblocks were unplugged.
  */
-static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
-					unsigned long mb_id, uint64_t *nb_sb)
+static int virtio_mem_sbm_unplug_any_sb_raw(struct virtio_mem *vm,
+					    unsigned long mb_id, uint64_t *nb_sb)
 {
 	int sb_id, count;
 	int rc;
@@ -1496,7 +1496,7 @@ static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
 {
 	uint64_t nb_sb = vm->sbm.sbs_per_mb;
 
-	return virtio_mem_sbm_unplug_any_sb(vm, mb_id, &nb_sb);
+	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, &nb_sb);
 }
 
 /*
@@ -1806,7 +1806,7 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
 {
 	int rc;
 
-	rc = virtio_mem_sbm_unplug_any_sb(vm, mb_id, nb_sb);
+	rc = virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, nb_sb);
 
 	/* some subblocks might have been unplugged even on failure */
 	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
@@ -1929,11 +1929,46 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	return 0;
 }
 
+/*
+ * Unplug the desired number of plugged subblocks of a memory block that is
+ * already added to Linux. Will skip subblock of online memory blocks that are
+ * busy (by the OS). Will fail if any subblock that's not busy cannot get
+ * unplugged.
+ *
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
+ *
+ * Note: Can fail after some subblocks were successfully unplugged. Can
+ *       return 0 even if subblocks were busy and could not get unplugged.
+ */
+static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
+					unsigned long mb_id,
+					uint64_t *nb_sb)
+{
+	const int old_state = virtio_mem_sbm_get_mb_state(vm, mb_id);
+
+	switch (old_state) {
+	case VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL:
+	case VIRTIO_MEM_SBM_MB_ONLINE:
+		return virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, nb_sb);
+	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
+	case VIRTIO_MEM_SBM_MB_OFFLINE:
+		return virtio_mem_sbm_unplug_any_sb_offline(vm, mb_id, nb_sb);
+	}
+	return -EINVAL;
+}
+
 static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
+	const int mb_states[] = {
+		VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL,
+		VIRTIO_MEM_SBM_MB_OFFLINE,
+		VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL,
+		VIRTIO_MEM_SBM_MB_ONLINE,
+	};
 	uint64_t nb_sb = diff / vm->sbm.sb_size;
 	unsigned long mb_id;
-	int rc;
+	int rc, i;
 
 	if (!nb_sb)
 		return 0;
@@ -1945,47 +1980,23 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	 */
 	mutex_lock(&vm->hotplug_mutex);
 
-	/* Try to unplug subblocks of partially plugged offline blocks. */
-	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
-				       VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
-		rc = virtio_mem_sbm_unplug_any_sb_offline(vm, mb_id, &nb_sb);
-		if (rc || !nb_sb)
-			goto out_unlock;
-		cond_resched();
-	}
-
-	/* Try to unplug subblocks of plugged offline blocks. */
-	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_OFFLINE) {
-		rc = virtio_mem_sbm_unplug_any_sb_offline(vm, mb_id, &nb_sb);
-		if (rc || !nb_sb)
-			goto out_unlock;
-		cond_resched();
-	}
-
-	if (!unplug_online) {
-		mutex_unlock(&vm->hotplug_mutex);
-		return 0;
-	}
-
-	/* Try to unplug subblocks of partially plugged online blocks. */
-	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
-				       VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
-		rc = virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, &nb_sb);
-		if (rc || !nb_sb)
-			goto out_unlock;
-		mutex_unlock(&vm->hotplug_mutex);
-		cond_resched();
-		mutex_lock(&vm->hotplug_mutex);
-	}
-
-	/* Try to unplug subblocks of plugged online blocks. */
-	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_ONLINE) {
-		rc = virtio_mem_sbm_unplug_any_sb_online(vm, mb_id, &nb_sb);
-		if (rc || !nb_sb)
-			goto out_unlock;
-		mutex_unlock(&vm->hotplug_mutex);
-		cond_resched();
-		mutex_lock(&vm->hotplug_mutex);
+	/*
+	 * We try unplug from partially plugged blocks first, to try removing
+	 * whole memory blocks along with metadata.
+	 */
+	for (i = 0; i < ARRAY_SIZE(mb_states); i++) {
+		virtio_mem_sbm_for_each_mb_rev(vm, mb_id, mb_states[i]) {
+			rc = virtio_mem_sbm_unplug_any_sb(vm, mb_id, &nb_sb);
+			if (rc || !nb_sb)
+				goto out_unlock;
+			mutex_unlock(&vm->hotplug_mutex);
+			cond_resched();
+			mutex_lock(&vm->hotplug_mutex);
+		}
+		if (!unplug_online && i == 1) {
+			mutex_unlock(&vm->hotplug_mutex);
+			return 0;
+		}
 	}
 
 	mutex_unlock(&vm->hotplug_mutex);
-- 
2.31.1

