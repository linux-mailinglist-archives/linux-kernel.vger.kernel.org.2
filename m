Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98043FCE81
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbhHaUXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241192AbhHaUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630441321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrJn03sgZ88g+0B73iP7rR7hukfKfXOSP0HDgzZ3C3M=;
        b=UWLER0H9x3NF843uxr0rauOb6bQ8IsCeYAvr6fF3ube8OIEZZMlyE1zzdGKhqJpEKc30rg
        bDL/t3f7wdCIWpatGCDSPzlK9xsUDcsKu1R+gLOzahoNdZc9E+RC6fK8nEcCRTZnej9n1c
        V94FLlYfXA4KQkxJr839XGIp97S65Bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-z7vELFjoPaGA0EQ_Bm6TIQ-1; Tue, 31 Aug 2021 16:21:59 -0400
X-MC-Unique: z7vELFjoPaGA0EQ_Bm6TIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E16FE87D541
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 20:21:58 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ABA86A915;
        Tue, 31 Aug 2021 20:21:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 3/3] virtio-mem: disallow mapping virtio-mem memory via /dev/mem
Date:   Tue, 31 Aug 2021 22:21:41 +0200
Message-Id: <20210831202141.13846-4-david@redhat.com>
In-Reply-To: <20210831202141.13846-1-david@redhat.com>
References: <20210831202141.13846-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want user space to be able to map virtio-mem device memory
directly (e.g., via /dev/mem) in order to have guarantees that in a sane
setup we'll never accidentially access unplugged memory within the
device-managed region of a virtio-mem device, just as required by the
virtio-spec.

As soon as the virtio-mem driver is loaded, the device region is visible
in /proc/iomem via the parent device region. From that point on user space
is aware of the device region and we want to disallow mapping anything
inside that region (where we will dynamically (un)plug memory) until
the driver has been unloaded cleanly and e.g., another driver might take
over.

By creating our parent IORESOURCE_SYSTEM_RAM resource with
IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
device region until the driver was unloaded cleanly and removed the
parent region. This will work even though only some memory blocks are
actually currently added to Linux and appear as busy in the resource tree.

So access to the region from user space is only possible
a) if we don't load the virtio-mem driver.
b) after unloading the virtio-mem driver cleanly.

Don't build virtio-mem if access to /dev/mem cannot be restricticted --
if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig      | 1 +
 drivers/virtio/virtio_mem.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index ce1b3f6ec325..ff80cd03f1d1 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -101,6 +101,7 @@ config VIRTIO_MEM
 	depends on MEMORY_HOTPLUG_SPARSE
 	depends on MEMORY_HOTREMOVE
 	depends on CONTIG_ALLOC
+	depends on !DEVMEM || STRICT_DEVMEM
 	help
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b91bc810a87e..c2d93492cf0f 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2523,8 +2523,10 @@ static int virtio_mem_create_resource(struct virtio_mem *vm)
 	if (!name)
 		return -ENOMEM;
 
+	/* Disallow mapping device memory via /dev/mem completely. */
 	vm->parent_resource = __request_mem_region(vm->addr, vm->region_size,
-						   name, IORESOURCE_SYSTEM_RAM);
+						   name, IORESOURCE_SYSTEM_RAM |
+						   IORESOURCE_EXCLUSIVE);
 	if (!vm->parent_resource) {
 		kfree(name);
 		dev_warn(&vm->vdev->dev, "could not reserve device region\n");
-- 
2.31.1

