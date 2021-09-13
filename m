Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6421C408431
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhIMF4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237249AbhIMF4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtqcK8OBOXRr6ZBw1JH6UfUdpU3S//kleHWjxjhJDLY=;
        b=E13gedwAcvXGPDy7HUOq8mgeAzSxRj+RkHlfalmXSzhRTOeVJVNkVVVwxmxUJbwlupqX1h
        NLg0Pn1uhFAOJRNSQePt3Y5NAaUSNJSjqrQ7xiOcmjZM6OUEngg+IuLtiqbE7FPNDCWA5c
        zg1ke8/csDdIcbjGP6J74jM9OC3srpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-eqVKmdeqNLGOQlI_rUhG-g-1; Mon, 13 Sep 2021 01:54:43 -0400
X-MC-Unique: eqVKmdeqNLGOQlI_rUhG-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D3C7800FF3;
        Mon, 13 Sep 2021 05:54:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 180445C3E0;
        Mon, 13 Sep 2021 05:54:39 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH 5/9] virtio_config: introduce a new ready method
Date:   Mon, 13 Sep 2021 13:53:49 +0800
Message-Id: <20210913055353.35219-6-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8519b3ae5d52..f2891c6221a1 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -23,6 +23,8 @@ struct virtio_shm_region {
  *       any of @get/@set, @get_status/@set_status, or @get_features/
  *       @finalize_features are NOT safe to be called from an atomic
  *       context.
+ * @ready: make the device ready
+ *      vdev: the virtio_device
  * @get: read the value of a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
@@ -75,6 +77,7 @@ struct virtio_shm_region {
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
+	void (*ready)(struct virtio_device *vdev);
 	void (*get)(struct virtio_device *vdev, unsigned offset,
 		    void *buf, unsigned len);
 	void (*set)(struct virtio_device *vdev, unsigned offset,
@@ -229,6 +232,9 @@ void virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
+	if (dev->config->ready)
+                  dev->config->ready(dev);
+
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
-- 
2.25.1

