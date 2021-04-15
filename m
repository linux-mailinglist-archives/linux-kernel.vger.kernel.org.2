Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA33360369
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhDOHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231429AbhDOHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=uRjAyfH2EocMqkl3avo14HGtZCvwSJwDpt6RMldr+oE=;
        b=S6ds40VybceZ/ymYIic5AwVjGXOPJfLNj9VEzafnTvld1RAVXYV+1PvYUZZSlt90Fykqgq
        RnNqLIBldYniORG+xaadfIIAGmZ3tzqTX4ea9NFDQowgCLbbQPkXc3sjXrzs1iqexejDyj
        eUIEf055wKLRIu1bPvG5tIyxwQUw0ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-i91gOzhSMYyoL9NgjpgkUg-1; Thu, 15 Apr 2021 03:32:18 -0400
X-MC-Unique: i91gOzhSMYyoL9NgjpgkUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52B3510054F6;
        Thu, 15 Apr 2021 07:32:17 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC7660657;
        Thu, 15 Apr 2021 07:32:10 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: [PATCH 4/7] virtio_pci_modern: hide vp_modern_get_queue_notify_off()
Date:   Thu, 15 Apr 2021 03:31:44 -0400
Message-Id: <20210415073147.19331-5-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users (both virtio-pci library and vp_vdpa driver) has been
switched to use vp_modern_map_vq_notify(). So there's no need to
export the low level helper of vp_modern_get_queue_notify_off().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 5 ++---
 include/linux/virtio_pci_modern.h      | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 28cb5847fafa..5a657e56b46d 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -584,14 +584,13 @@ EXPORT_SYMBOL_GPL(vp_modern_get_num_queues);
  *
  * Returns the notification offset for a virtqueue
  */
-u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
-				   u16 index)
+static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
+					  u16 index)
 {
 	vp_iowrite16(index, &mdev->common->queue_select);
 
 	return vp_ioread16(&mdev->common->queue_notify_off);
 }
-EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
 
 /*
  * vp_modern_map_vq_notify - map notification area for a
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 1b95d39b00fc..179a2fb4bf37 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -99,8 +99,6 @@ void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
 u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 			     u16 idx);
 u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
-u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
-				   u16 idx);
 void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 				       size_t minlen,
 				       u32 align,
-- 
2.18.1

