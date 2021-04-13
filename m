Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FDA35D76E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbhDMFsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344607AbhDMFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618292873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQ4VlAVqH25DzMLpMhdVuF4QUuvJ8Qp+k4bIKP2VcN4=;
        b=AMglUGWKLeX+8MahgknUuNEDg+2vLirmEC/1yF70M4Rex+Ahmg+KxqM6TMOVZHCmMhuaGK
        i+/XPONjSfeEnXFr2EAJYI6f4vK7OFd3dXExMF7qSpEoA5nALYhL2jFCeppDgAK7hfmjQP
        vM2ggCTtA/DZjZlvV8hwlRKgs91JCRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-9vXx92PfNw2icD0fyMpt9g-1; Tue, 13 Apr 2021 01:47:51 -0400
X-MC-Unique: 9vXx92PfNw2icD0fyMpt9g-1
Received: by mail-wm1-f71.google.com with SMTP id l6-20020a1c25060000b029010ee60ad0fcso666236wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQ4VlAVqH25DzMLpMhdVuF4QUuvJ8Qp+k4bIKP2VcN4=;
        b=GbcbhnFScKk7f3OnT4S59IlIWK+r0LEtsQ7UBXbiKtAq1kC0spYY0YKkm6XGGcOCCi
         FhGOvxeOnJcJsiVp8PSLJZgQUatx+24/d8DN/NYZFbxiy7JkkOrPLV1uXlkQRuHByZs1
         phtIJe0YSsGPV8RgVxSqs7xpR677OVEdDwtvZIAv8uoL/ldPDU/TGrxAdi1JkPFCluv1
         ac2KSJFrXPihgb3oaelVTml4cCV4OWPqYIwKhCEj9TfhpZiySolAWKem/wqB+wnTPdzc
         0LXByi5l3E/WxdBR11hgUf0SR+rQrh7hPQ7+j1h1JY9EcQIf45KvNZj1NNH5irfBr9Pp
         pktw==
X-Gm-Message-State: AOAM532tbR44GoFeA2eWvCQfhQI9sPREbLwA6FFkkTW3LvQWnavGWKao
        +Y8wzhN4ngShlCWAiIXV1k+KEDBaguuGqvcyOX4AJw88e/UGTPs01wfJ2qSttNFRV/vHbahwwTC
        lVNPQndl1p+cUXECrJ22ARTZWrwDtChN5CeF8EFJRsUWf45V383xk951tC7Nd7xW4V90Jfg==
X-Received: by 2002:adf:e650:: with SMTP id b16mr14712024wrn.273.1618292869983;
        Mon, 12 Apr 2021 22:47:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9v8kGgKLvQMgN2NEqBuuP7XEFD5CaexgqT8HLJgbkC/63U6daM4nldTQE5UiI0lEBV0QuFA==
X-Received: by 2002:adf:e650:: with SMTP id b16mr14712006wrn.273.1618292869792;
        Mon, 12 Apr 2021 22:47:49 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id b6sm20176538wrv.12.2021.04.12.22.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 22:47:49 -0700 (PDT)
Date:   Tue, 13 Apr 2021 01:47:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
        Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
Message-ID: <20210413054733.36363-2-mst@redhat.com>
References: <20210413054733.36363-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413054733.36363-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_disable_cb is currently a nop for split ring with event index.
This is because it used to be always called from a callback when we know
device won't trigger more events until we update the index.  However,
now that we run with interrupts enabled a lot we also poll without a
callback so that is different: disabling callbacks will help reduce the
number of spurious interrupts.
Further, if using event index with a packed ring, and if being called
from a callback, we actually do disable interrupts which is unnecessary.

Fix both issues by tracking whenever we get a callback. If that is
the case disabling interrupts with event index can be a nop.
If not the case disable interrupts. Note: with a split ring
there's no explicit "no interrupts" value. For now we write
a fixed value so our chance of triggering an interupt
is 1/ring size. It's probably better to write something
related to the last used index there to reduce the chance
even further. For now I'm keeping it simple.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b53e9c1..88f0b16b11b8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -113,6 +113,9 @@ struct vring_virtqueue {
 	/* Last used index we've seen. */
 	u16 last_used_idx;
 
+	/* Hint for event idx: already triggered no need to disable. */
+	bool event_triggered;
+
 	union {
 		/* Available for split ring */
 		struct {
@@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
+		if (vq->event)
+			/* TODO: this is a hack. Figure out a cleaner value to write. */
+			vring_used_event(&vq->split.vring) = 0x0;
+		else
 			vq->split.vring.avail->flags =
 				cpu_to_virtio16(_vq->vdev,
 						vq->split.avail_flags_shadow);
@@ -1605,6 +1611,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->packed_ring = true;
 	vq->use_dma_api = vring_use_dma_api(vdev);
@@ -1919,6 +1926,12 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	/* If device triggered an event already it won't trigger one again:
+	 * no need to disable.
+	 */
+	if (vq->event_triggered)
+		return;
+
 	if (vq->packed_ring)
 		virtqueue_disable_cb_packed(_vq);
 	else
@@ -1942,6 +1955,9 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (vq->event_triggered)
+		vq->event_triggered = false;
+
 	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
 				 virtqueue_enable_cb_prepare_split(_vq);
 }
@@ -2005,6 +2021,9 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (vq->event_triggered)
+		vq->event_triggered = false;
+
 	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
 				 virtqueue_enable_cb_delayed_split(_vq);
 }
@@ -2044,6 +2063,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 	if (unlikely(vq->broken))
 		return IRQ_HANDLED;
 
+	/* Just a hint for performance: so it's ok that this can be racy! */
+	if (vq->event)
+		vq->event_triggered = true;
+
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
 		vq->vq.callback(&vq->vq);
@@ -2083,6 +2106,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
+	vq->event_triggered = false;
 	vq->num_added = 0;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 #ifdef DEBUG
-- 
MST

