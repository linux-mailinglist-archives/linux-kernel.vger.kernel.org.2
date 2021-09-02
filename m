Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05DB3FF0CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbhIBQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346128AbhIBQKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630598981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35N7k3a81h8IFJDkaZOQjP2o+rAflN0TIT3sjhQeT4w=;
        b=Aay2kq7+EAIwvmE8ielZguSKNhA0KG0o0VM+I13/hKZiZuKTuBh7m/VFtQms3TNRJ4bUCf
        ekx57dyUrMDjA4SMVdVrLH8X4hiQPIkr329lGZ3OL+wOzYN5VWaKs2OWGodd+BAX5YEeds
        ZpAqBprMv5pjeAW4fYOru/vzBCBEG4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-gkxFaDnrPoCByd5TPmeHqg-1; Thu, 02 Sep 2021 12:09:38 -0400
X-MC-Unique: gkxFaDnrPoCByd5TPmeHqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FAE06D5C2;
        Thu,  2 Sep 2021 16:09:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D3B160853;
        Thu,  2 Sep 2021 16:09:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v4 2/3] kernel/resource: disallow access to exclusive system RAM regions
Date:   Thu,  2 Sep 2021 18:09:18 +0200
Message-Id: <20210902160919.25683-3-david@redhat.com>
In-Reply-To: <20210902160919.25683-1-david@redhat.com>
References: <20210902160919.25683-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-mem dynamically exposes memory inside a device memory region as
system RAM to Linux, coordinating with the hypervisor which parts are
actually "plugged" and consequently usable/accessible. On the one hand, the
virtio-mem driver adds/removes whole memory blocks, creating/removing busy
IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
memory inside added memory blocks, dynamically either exposing them to
the buddy or hiding them from the buddy and marking them PG_offline.

In contrast to physical devices, like a DIMM, the virtio-mem driver
is required to actually make use of any of the device-provided memory,
because it performs the handshake with the hypervisor. virtio-mem memory
cannot simply be access via /dev/mem without a driver.

There is no safe way to:
a) Access plugged memory blocks via /dev/mem, as they might contain
   unplugged holes or might get silently unplugged by the virtio-mem
   driver and consequently turned inaccessible.
b) Access unplugged memory blocks via /dev/mem because the virtio-mem
   driver is required to make them actually accessible first.

The virtio-spec states that unplugged memory blocks MUST NOT be
written, and only selected unplugged memory blocks MAY be read. We want
to make sure, this is the case in sane environments -- where the
virtio-mem driver was loaded.

We want to make sure that in a sane environment, nobody "accidentially"
accesses unplugged memory inside the device managed region. For example,
a user might spot a memory region in /proc/iomem and try accessing it via
/dev/mem via gdb or dumping it via something else. By the time the mmap()
happens, the memory might already have been removed by the virtio-mem
driver silently: the mmap() would succeeed and user space might
accidentially access unplugged memory.

So once the driver was loaded and detected the device along the
device-managed region, we just want to disallow any access via
/dev/mem to it.

In an ideal world, we would mark the whole region as busy ("owned by a
driver") and exclude it; however, that would be wrong, as we don't
really have actual system RAM at these ranges added to Linux ("busy system
RAM"). Instead, we want to mark such ranges as "not actual busy system RAM
but still soft-reserved and prepared by a driver for future use."

Let's teach iomem_is_exclusive() to reject access to any range
with "IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE", even if not busy
and even if "iomem=relaxed" is set.

For now, there are no applicable ranges and we'll modify virtio-mem next to
properly set IORESOURCE_EXCLUSIVE on the parent resource container it
creates to contain all actual busy system RAM added via
add_memory_driver_managed().

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2999f57da38c..5ad3eba619ba 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1719,26 +1719,23 @@ static int strict_iomem_checks;
 #endif
 
 /*
- * check if an address is reserved in the iomem resource tree
- * returns true if reserved, false if not reserved.
+ * Check if an address is exclusive to the kernel and must not be mapped to
+ * user space, for example, via /dev/mem.
+ *
+ * Returns true if exclusive to the kernel, otherwise returns false.
  */
 bool iomem_is_exclusive(u64 addr)
 {
+	const unsigned int exclusive_system_ram = IORESOURCE_SYSTEM_RAM |
+						  IORESOURCE_EXCLUSIVE;
 	bool skip_children = false, err = false;
 	int size = PAGE_SIZE;
 	struct resource *p;
 
-	if (!strict_iomem_checks)
-		return false;
-
 	addr = addr & PAGE_MASK;
 
 	read_lock(&resource_lock);
 	for_each_resource(&iomem_resource, p, skip_children) {
-		/*
-		 * We can probably skip the resources without
-		 * IORESOURCE_IO attribute?
-		 */
 		if (p->start >= addr + size)
 			break;
 		if (p->end < addr) {
@@ -1747,12 +1744,24 @@ bool iomem_is_exclusive(u64 addr)
 		}
 		skip_children = false;
 
+		/*
+		 * IORESOURCE_SYSTEM_RAM resources are exclusive if
+		 * IORESOURCE_EXCLUSIVE is set, even if they
+		 * are not busy and even if "iomem=relaxed" is set. The
+		 * responsible driver dynamically adds/removes system RAM within
+		 * such an area and uncontrolled access is dangerous.
+		 */
+		if ((p->flags & exclusive_system_ram) == exclusive_system_ram) {
+			err = true;
+			break;
+		}
+
 		/*
 		 * A resource is exclusive if IORESOURCE_EXCLUSIVE is set
 		 * or CONFIG_IO_STRICT_DEVMEM is enabled and the
 		 * resource is busy.
 		 */
-		if ((p->flags & IORESOURCE_BUSY) == 0)
+		if (!strict_iomem_checks || !(p->flags & IORESOURCE_BUSY))
 			continue;
 		if (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM)
 				|| p->flags & IORESOURCE_EXCLUSIVE) {
-- 
2.31.1

