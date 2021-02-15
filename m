Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2631B946
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhBOMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230172AbhBOM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613391876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEB/obzSHOtmTVEsdMgjSRNQj0mbOgdNvz1v5u4sJFQ=;
        b=fSmRjhsIgmbs8BYNXwkSBrUmvA2ayigjDpvX3EfiAilqjUaltMsSXGvU1PC+ywiVNHvg7M
        nrTbzWuaQmDfSUmqKsWDA3aHYPG9HfrkZjjtsfyvO1HgjyqKhbbdbToyLPh3/3xbypC6h0
        rjSCU9krjD2QsvjFp147CxfF52lKREI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-4uUu5GQgMdqoALxrJqkUWw-1; Mon, 15 Feb 2021 07:24:32 -0500
X-MC-Unique: 4uUu5GQgMdqoALxrJqkUWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F82B801962;
        Mon, 15 Feb 2021 12:24:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-89.ams2.redhat.com [10.36.114.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0E9D60C0F;
        Mon, 15 Feb 2021 12:24:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 2/2] virtio-mem: support VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
Date:   Mon, 15 Feb 2021 13:24:21 +0100
Message-Id: <20210215122421.27964-1-david@redhat.com>
In-Reply-To: <20210215122143.27608-1-david@redhat.com>
References: <20210215122143.27608-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec currently states that while unplugged memory should not be
read, the device has to allow for reading unplugged memory inside the
usable region. The primary motivation for this default handling was that
in some corner cases in Linux, unplugged memory inside added Linux memory
blocks (and exposed via /proc/iomem as "System RAM (...)") might still
be read. So to support SBM (Sub Block Mode) in Linux cleanly, the device
has to support reading unplugged memory.

One example is kdump(): when makedumpfile isn't used
or when an older version is used, PG_offline is ignored and unplugged
memory might still be read. Another corner-case example is /dev/mem: even
with STRICT_DEVMEM, some unplugged memory might be read by tools
automatically.

For example, QEMU won't support reading unplugged memory with
file-backed memory backends initially: there is no shared zero page,
thus, special handling will be required in the future to allow for
reading unplugged memory when using a file backing (tmpfs/shmem, hugetlbfs,
...).

The device will indicate VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE and fail
device initialization if the driver does not indicate support. The
result is that Linux won't be able to make use of any memory without
this change. With this change, Linux will at least be able to (un)plug
in Linux memory block granularity. Print an info so this handling can
be identified.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c     | 12 ++++++++++++
 include/uapi/linux/virtio_mem.h | 10 +++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 6d4e01c4e2fa..58d8df528728 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2425,6 +2425,17 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			pageblock_nr_pages) * PAGE_SIZE;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
+	/*
+	 * Unplugged memory might be read in corner cases, for example, via
+	 * kdump. Fallback to adding/removing individual Linux memory blocks.
+	 */
+	if (sb_size < memory_block_size_bytes() && !force_bbm &&
+	    virtio_has_feature(vm->vdev, VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE)) {
+		sb_size = memory_block_size_bytes();
+		dev_info(&vm->vdev->dev,
+			 "The device does not support reading unplugged memory: using big block mode\n");
+	}
+
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
 		/* SBM: At least two subblocks per Linux memory block. */
 		vm->in_sbm = true;
@@ -2711,6 +2722,7 @@ static unsigned int virtio_mem_features[] = {
 #if defined(CONFIG_NUMA) && defined(CONFIG_ACPI_NUMA)
 	VIRTIO_MEM_F_ACPI_PXM,
 #endif
+	VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE,
 };
 
 static const struct virtio_device_id virtio_mem_id_table[] = {
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index 70e01c687d5e..6ac77cfb8aca 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -68,9 +68,11 @@
  * explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
  *
  * There are no guarantees what will happen if unplugged memory is
- * read/written. Such memory should, in general, not be touched. E.g.,
- * even writing might succeed, but the values will simply be discarded at
- * random points in time.
+ * read/written. Often, unplugged memory inside the usable region can
+ * be read, to simplify creation of memory dumps; however, some devices
+ * don't even support that. Unplugged memory should, in general, not be
+ * touched. E.g., even writing might succeed, but the values will simply be
+ * discarded at random points in time.
  *
  * It can happen that the device cannot process a request, because it is
  * busy. The device driver has to retry later.
@@ -87,6 +89,8 @@
 
 /* node_id is an ACPI PXM and is valid */
 #define VIRTIO_MEM_F_ACPI_PXM		0
+/* any unplugged memory must never be accessed */
+#define VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE	1
 
 
 /* --- virtio-mem: guest -> host requests --- */
-- 
2.29.2

