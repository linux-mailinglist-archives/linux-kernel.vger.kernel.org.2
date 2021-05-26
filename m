Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7339123E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhEZI0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232363AbhEZI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622017486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQ4VlAVqH25DzMLpMhdVuF4QUuvJ8Qp+k4bIKP2VcN4=;
        b=VbCJBpN5sfVfjhpT6yHTPPLNGbOld9cjVPoWj8oDGuQH01AKHcHD6EVRu2ToO13KBmOGTJ
        MoKHfJhGv2ohFRIVdtaGbMYtEICvHYV6h8/N7d5LT1MBYv0NbAIW9sPg9g2jAREEzDC3ef
        tvF9ldPM9xspWWn1rCNVKMb4JdtDoF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-NZ60hA1zMg-C2rTDJlqI8Q-1; Wed, 26 May 2021 04:24:45 -0400
X-MC-Unique: NZ60hA1zMg-C2rTDJlqI8Q-1
Received: by mail-wr1-f70.google.com with SMTP id d12-20020adfc3cc0000b029011166e2f1a7so24179wrg.19
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQ4VlAVqH25DzMLpMhdVuF4QUuvJ8Qp+k4bIKP2VcN4=;
        b=s1V/qtiSupJCBbCwxhgLERAvzBD52Dl94gikhfF3JwtXQp90iPx+lbWl/tb6wl7dR7
         Xk0pwdjgPdmoq/Ctk/nkaArb9z/hwms7AH1xqBE0qQgl9nG3BmKR5EWRWjHC4Uc9U+qg
         aM4FNtWKR+PSUiZw3QFr0XhPnU7NslkEt+Yu+84iXNWBzdPVa4tWoZF+EBOrexjBpFqN
         QsuvNVx5i+YcwvsjZPb+O4sEmVedMqM/lirnH93xKyqjK6FyM7EImSWCWKuWFkVzkRWB
         n1e3pX6tmQIC7hSEHTqdiUZriBmzJmjTANsbC0PPotWCKct95tQpDbSYh8ZeIAqKf0JF
         dRjg==
X-Gm-Message-State: AOAM5308oI4VgoX6BBP2tWVJfPl88xctZWf2MUB1MIUkhfUSKAIIqhiY
        YApneKrMN2kTK1mxSNq8Z05guGv49EYti1TSV6beXUFY1UrIEihmZHdXtkF/BOQV122yH4AsQs5
        vVXw9VpkcfEmypXKFlVb/dZcEIOevWMVUvvVAcrTC/y2RLwVtu/+iIXKFnTb5ElioPtmEFQ==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr31087420wrx.252.1622017483375;
        Wed, 26 May 2021 01:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBruCkcm4GOWWMpK9+L6RBQgOo0DFFffIWCQmTsoaoIsXJIdCDaUTvqMzWEVx0KNyBacvMzw==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr31087397wrx.252.1622017483114;
        Wed, 26 May 2021 01:24:43 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
        by smtp.gmail.com with ESMTPSA id r7sm5281221wmq.3.2021.05.26.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:24:42 -0700 (PDT)
Date:   Wed, 26 May 2021 04:24:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 3/4] virtio: fix up virtio_disable_cb
Message-ID: <20210526082423.47837-4-mst@redhat.com>
References: <20210526082423.47837-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526082423.47837-1-mst@redhat.com>
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

