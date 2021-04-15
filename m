Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6536036A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhDOHcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhDOHcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=y065v3sS7iQ67BPMJsfUR3YKWdqlGuSLEniDjFK1rEM=;
        b=CP2WjzqqKGKjOj7+VElYiqTRTskAm9m5LG+l9D1VXBc9IbMbv9USBgnmCLQhCg+58Gjp0w
        SVmK2GtjQqA7sYenPxi3vorjr/HZqWNIMl6EJSLaM60kFISQ27SE8GFxOVu+LGCoGu+BrO
        gdb/r2GKiugAZfCW3GzVmztvaqdVMfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fDVhN6ksNsGBHCS9UEHFcA-1; Thu, 15 Apr 2021 03:32:21 -0400
X-MC-Unique: fDVhN6ksNsGBHCS9UEHFcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD14784E20A;
        Thu, 15 Apr 2021 07:32:19 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0BCB60657;
        Thu, 15 Apr 2021 07:32:17 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: [PATCH 5/7] virito_pci libray: hide vp_modern_map_capability()
Date:   Thu, 15 Apr 2021 03:31:45 -0400
Message-Id: <20210415073147.19331-6-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No user now and the capability should not be setup
externally. Instead, every access to the capability should be done via
virtio_pci_modern_device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 10 ++++------
 include/linux/virtio_pci_modern.h      |  5 -----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 5a657e56b46d..9c241c9bd920 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -16,11 +16,10 @@
  *
  * Returns the io address of for the part of the capability
  */
-void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
-				       size_t minlen,
-				       u32 align,
-				       u32 start, u32 size,
-				       size_t *len)
+static void __iomem *
+vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
+			 size_t minlen, u32 align, u32 start, u32 size,
+			 size_t *len)
 {
 	struct pci_dev *dev = mdev->pci_dev;
 	u8 bar;
@@ -90,7 +89,6 @@ void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, in
 			length, offset, bar);
 	return p;
 }
-EXPORT_SYMBOL_GPL(vp_modern_map_capability);
 
 /**
  * virtio_pci_find_capability - walk capabilities to find device info.
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 179a2fb4bf37..e6e7072413c1 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -99,11 +99,6 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
 u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 			     u16 idx);
 u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
-void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
-				       size_t minlen,
-				       u32 align,
-				       u32 start, u32 size,
-				       size_t *len);
 void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
                               u16 index);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
-- 
2.18.1

