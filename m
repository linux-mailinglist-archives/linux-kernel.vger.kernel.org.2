Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391E83E99BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhHKUg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231787AbhHKUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628714191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdoYRV/z4Dd8uSFdD6ay/3sfgEd/T31YzbcYRTGN8LA=;
        b=ZHHsfaCUu68P0EG2Ek7Tk5T46goSdavDRZxoAAI+oNM8KrVSYJ7XnbNoSzWL9VdFeu0Vpc
        o8Tp9pUquXZs+oWl/0UY7m3neTZITWN4Nn5WUxDh0Roa9ZgjJRNvTiyo4FuD3+XYyRqWgI
        40s/xfuSGYENYnTD7NEAnVArMVn0aQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-zetTXEeyOXmFS2Sqm3pD5A-1; Wed, 11 Aug 2021 16:36:29 -0400
X-MC-Unique: zetTXEeyOXmFS2Sqm3pD5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 346671082922;
        Wed, 11 Aug 2021 20:36:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 201861B46B;
        Wed, 11 Aug 2021 20:36:24 +0000 (UTC)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 1/3] /dev/mem: disallow access to explicitly excluded system RAM regions
Date:   Wed, 11 Aug 2021 22:36:10 +0200
Message-Id: <20210811203612.138506-2-david@redhat.com>
In-Reply-To: <20210811203612.138506-1-david@redhat.com>
References: <20210811203612.138506-1-david@redhat.com>
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

virtio-mem wants to make sure that in a sane environment, nobody
"accidentially" accesses unplugged memory inside the device managed
region. After /proc/kcore has been sanitized and /dev/kmem has been
removed, /dev/mem is the remaining interface that still allows uncontrolled
access to the device-managed region of virtio-mem devices from user
space.

There is no known sane use case for mapping virtio-mem device memory
via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
that region. So once the driver was loaded and detected the device
along the device-managed region, we just want to disallow any access via
/dev/mem to it.

Let's add the basic infrastructure to exclude some physical memory
regions completely from /dev/mem access, on any architecture and under
any system configuration (independent of CONFIG_STRICT_DEVMEM and
independent of "iomem=").

Any range marked with "IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE"
will be excluded, even if not busy. For now, there are no applicable
ranges and we'll modify virtio-mem next to properly set
IORESOURCE_EXCLUSIVE on the parent resource.

As next_resource() will iterate over children although we might want to
skip a certain range completely, let's add and use
next_range_skip_children() to optimize that case, avoding having to
traverse subtrees that are not of interest.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/char/mem.c     | 22 +++++++++-------------
 include/linux/ioport.h |  1 +
 kernel/resource.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug      |  4 +++-
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 1c596b5cdb27..bb6d95daab45 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -60,13 +60,18 @@ static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 }
 #endif
 
-#ifdef CONFIG_STRICT_DEVMEM
 static inline int page_is_allowed(unsigned long pfn)
 {
-	return devmem_is_allowed(pfn);
+#ifdef CONFIG_STRICT_DEVMEM
+	if (!devmem_is_allowed(pfn))
+		return 0;
+#endif /* CONFIG_STRICT_DEVMEM */
+	return !iomem_range_contains_excluded(PFN_PHYS(pfn), PAGE_SIZE);
 }
+
 static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 {
+#ifdef CONFIG_STRICT_DEVMEM
 	u64 from = ((u64)pfn) << PAGE_SHIFT;
 	u64 to = from + size;
 	u64 cursor = from;
@@ -77,18 +82,9 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 		cursor += PAGE_SIZE;
 		pfn++;
 	}
-	return 1;
-}
-#else
-static inline int page_is_allowed(unsigned long pfn)
-{
-	return 1;
-}
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	return 1;
+#endif /* CONFIG_STRICT_DEVMEM */
+	return !iomem_range_contains_excluded(PFN_PHYS(pfn), size);
 }
-#endif
 
 #ifndef unxlate_dev_mem_ptr
 #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..50523c28a5f1 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -308,6 +308,7 @@ extern struct resource * __devm_request_region(struct device *dev,
 extern void __devm_release_region(struct device *dev, struct resource *parent,
 				  resource_size_t start, resource_size_t n);
 extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
+extern bool iomem_range_contains_excluded(u64 addr, u64 size);
 extern bool iomem_is_exclusive(u64 addr);
 
 extern int
diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..2938cf520ca3 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -73,6 +73,13 @@ static struct resource *next_resource(struct resource *p)
 	return p->sibling;
 }
 
+static struct resource *next_resource_skip_children(struct resource *p)
+{
+	while (!p->sibling && p->parent)
+		p = p->parent;
+	return p->sibling;
+}
+
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct resource *p = v;
@@ -1700,6 +1707,41 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 	return err;
 }
 
+/*
+ * Check if a physical memory range is completely excluded from getting
+ * mapped/accessed via /dev/mem.
+ */
+bool iomem_range_contains_excluded(u64 addr, u64 size)
+{
+	const unsigned int flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE;
+	bool excluded = false;
+	struct resource *p;
+
+	read_lock(&resource_lock);
+	for (p = iomem_resource.child; p ;) {
+		if (p->start >= addr + size)
+			break;
+		if (p->end < addr) {
+			/* No need to consider children */
+			p = next_resource_skip_children(p);
+			continue;
+		}
+		/*
+		 * A system RAM resource is excluded if IORESOURCE_EXCLUSIVE
+		 * is set, even if not busy and even if we don't have strict
+		 * checks enabled -- no ifs or buts.
+		 */
+		if ((p->flags & flags) == flags) {
+			excluded = true;
+			break;
+		}
+		p = next_resource(p);
+	}
+	read_unlock(&resource_lock);
+
+	return excluded;
+}
+
 #ifdef CONFIG_STRICT_DEVMEM
 static int strict_iomem_checks = 1;
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ddd575159fb..d0ce6e23a6db 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1780,7 +1780,9 @@ config STRICT_DEVMEM
 	  access to this is obviously disastrous, but specific access can
 	  be used by people debugging the kernel. Note that with PAT support
 	  enabled, even in this case there are restrictions on /dev/mem
-	  use due to the cache aliasing requirements.
+	  use due to the cache aliasing requirements. Further, some drivers
+	  will still restrict access to some physical memory regions either
+	  already used or to be used in the future as system RAM.
 
 	  If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
 	  file only allows userspace access to PCI space and the BIOS code and
-- 
2.31.1

