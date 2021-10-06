Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2D423DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhJFM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231277AbhJFM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633523242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z94u7XbK2wF6s34vY9KUD9mohTYfAbMaUfJBt8dLs3c=;
        b=cueJmjSu5UokN2pDzUgq5AT5WSrrYI4OVf7tSo4KA4dmB0u1s/UFF7/jiGcU6kGM4BZdfQ
        7Q+uVqR/o+9Stv6/s0p7v2kQwp/dajA2oad4nH7HXypbQAm60t3znvINdIKh3eA8oz0IEV
        bn8HmMNVA+EUAj3606GeV51EPonMg8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-_bzA9wiOMvO9ETZzWd959w-1; Wed, 06 Oct 2021 08:27:20 -0400
X-MC-Unique: _bzA9wiOMvO9ETZzWd959w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7946579EDF;
        Wed,  6 Oct 2021 12:27:18 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A083E5F4E3;
        Wed,  6 Oct 2021 12:27:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v2] virtio-mem: support VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
Date:   Wed,  6 Oct 2021 14:27:09 +0200
Message-Id: <20211006122709.27885-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial virtio-mem spec states that while unplugged memory should not
be read, the device still has to allow for reading unplugged memory inside
the usable region. The primary motivation for this default handling was
to simplify bringup of virtio-mem, because there were corner cases where
Linux might have accidentially read unplugged memory inside added Linux
memory blocks.

In the meantime, we:
* Removed /dev/kmem
* Disallowed access to virtio-mem device memory via /dev/mem
* Sanitized access to virtio-mem device memory via /proc/kcore
* Sanitized access to virtio-mem device memory via /proc/vmcore

"Accidential" access to unplugged memory is no longer possible; we can
support the new VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE feature that will be
required by some hypervisors implementing virtio-mem in the near future.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Michael, I want this patch in v5.16 if the following two series that
are already queued by Andrew via the -MM tree go into v5.16 (which I
I assume but we never know :) ):
* [PATCH v5 0/3] virtio-mem: disallow mapping virtio-mem memory via
  /dev/mem
  https://lkml.kernel.org/r/20210920142856.17758-1-david@redhat.com
* [PATCH v2 0/9] proc/vmcore: sanitize access to virtio-mem memory
  https://lkml.kernel.org/r/20211005121430.30136-1-david@redhat.com

This is the follow-up of:
  https://lkml.kernel.org/r/20210215122143.27608-1-david@redhat.com
The spec updated was proposed in:
  https://lists.oasis-open.org/archives/virtio-comment/202109/msg00027.html

v1 -> v2:
- Now that we handle /dev/mem and /proc/vmcore cleaner, we can get
  simplify and just support the flag unconditionally

---
 drivers/virtio/virtio_mem.c     | 1 +
 include/uapi/linux/virtio_mem.h | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index bef8ad6bf466..78dfdc9c98a1 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2758,6 +2758,7 @@ static unsigned int virtio_mem_features[] = {
 #if defined(CONFIG_NUMA) && defined(CONFIG_ACPI_NUMA)
 	VIRTIO_MEM_F_ACPI_PXM,
 #endif
+	VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE,
 };
 
 static const struct virtio_device_id virtio_mem_id_table[] = {
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index 70e01c687d5e..e9122f1d0e0c 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -68,9 +68,10 @@
  * explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
  *
  * There are no guarantees what will happen if unplugged memory is
- * read/written. Such memory should, in general, not be touched. E.g.,
- * even writing might succeed, but the values will simply be discarded at
- * random points in time.
+ * read/written. In general, unplugged memory should not be touched, because
+ * the resulting action is undefined. There is one exception: without
+ * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, unplugged memory inside the usable
+ * region can be read, to simplify creation of memory dumps.
  *
  * It can happen that the device cannot process a request, because it is
  * busy. The device driver has to retry later.
@@ -87,6 +88,8 @@
 
 /* node_id is an ACPI PXM and is valid */
 #define VIRTIO_MEM_F_ACPI_PXM		0
+/* unplugged memory must not be accessed */
+#define VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE	1
 
 
 /* --- virtio-mem: guest -> host requests --- */

base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
-- 
2.31.1

