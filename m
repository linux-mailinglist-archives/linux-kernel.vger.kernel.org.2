Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3A3F5C95
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhHXLBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236428AbhHXLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629802826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AITPksYvMoEXxNB1LWW4gg0jWVIK1CjIJ+gc/HJY6ys=;
        b=gDgOrjh90oTxVzrhfGvHeSZ5X39QvGIhLoZEvZwAPwqBVCHyOdiqyPzxRZYHvCsGBpTD50
        L/cHmOp7T5vZHvnq0TbWjtlrIysf7NiI2kkDIPQh/5nhS2a4VbHx5hmaG5r+1llWlVmQoC
        zjbdcX3FGtvYADVfkMIskOyAo+o97WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-eBmXFg38NdiFhZ25EZQvqQ-1; Tue, 24 Aug 2021 07:00:25 -0400
X-MC-Unique: eBmXFg38NdiFhZ25EZQvqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AFE58799ED;
        Tue, 24 Aug 2021 11:00:24 +0000 (UTC)
Received: from localhost (unknown [10.39.195.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA8C1346F;
        Tue, 24 Aug 2021 11:00:11 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, vgoyal@redhat.com,
        jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoling Gao <xiagao@redhat.com>
Subject: [RFC PATCH 1/1] fuse: disable local irqs when processing vq completions
Date:   Tue, 24 Aug 2021 11:59:44 +0100
Message-Id: <20210824105944.172659-2-stefanha@redhat.com>
In-Reply-To: <20210824105944.172659-1-stefanha@redhat.com>
References: <20210824105944.172659-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtqueue completion handler function runs on a work queue and local
irqs are still enabled. There is a race where the completion handler
function grabs the next completed request just before vring_interrupt()
runs. vring_interrupt() sees an empty virtqueue and returns IRQ_NONE,
falsely declaring this interrupt unhandled.

The unhandled irq causes the kernel to disable the irq:

  irq 77: nobody cared (try booting with the "irqpoll" option)
  ...
  handlers:
  [<00000000d33eeed7>] vring_interrupt
  Disabling IRQ #77

The driver hangs afterwards since virtqueue irqs are now ignored.

Disable local irqs before calling virtqueue_get_buf() and re-enable them
afterwards so that vring_interrupt() doesn't run during the race window.

Reported-by: Xiaoling Gao <xiagao@redhat.com>
Cc: Michael Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
I'm not 100% convinced this fixes everything because vring_interrupt()
can still run after our critical section and find the virtqueue empty.
virtqueue_disable_cb() should minimize that but it's only a hint and
there is a small window when the race condition can happen before it's
called.
---
 fs/fuse/virtio_fs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8f52cdaa8445..57e1f264b0a8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -319,9 +319,10 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 done_work);
 	struct virtqueue *vq = fsvq->vq;
+	unsigned long flags;
 
 	/* Free completed FUSE_FORGET requests */
-	spin_lock(&fsvq->lock);
+	spin_lock_irqsave(&fsvq->lock, flags);
 	do {
 		unsigned int len;
 		void *req;
@@ -333,7 +334,7 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 			dec_in_flight_req(fsvq);
 		}
 	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
-	spin_unlock(&fsvq->lock);
+	spin_unlock_irqrestore(&fsvq->lock, flags);
 }
 
 static void virtio_fs_request_dispatch_work(struct work_struct *work)
@@ -601,11 +602,15 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 	struct virtqueue *vq = fsvq->vq;
 	struct fuse_req *req;
 	struct fuse_req *next;
+	unsigned long flags;
 	unsigned int len;
 	LIST_HEAD(reqs);
 
-	/* Collect completed requests off the virtqueue */
-	spin_lock(&fsvq->lock);
+	/*
+	 * Collect completed requests off the virtqueue with irqs disabled to
+	 * prevent races with vring_interrupt().
+	 */
+	spin_lock_irqsave(&fsvq->lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
 
@@ -615,7 +620,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 			spin_unlock(&fpq->lock);
 		}
 	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
-	spin_unlock(&fsvq->lock);
+	spin_unlock_irqrestore(&fsvq->lock, flags);
 
 	/* End requests */
 	list_for_each_entry_safe(req, next, &reqs, list) {
-- 
2.31.1

