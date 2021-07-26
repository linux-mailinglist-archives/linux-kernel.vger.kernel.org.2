Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333503D530F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhGZF2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhGZF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:28:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E369C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:09:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e2so9628055wrq.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZVKCP8Qh4j6BGKMY5nXfHNRMKDgyZJqwrMNgLxmLGs=;
        b=Iyd28bGiCj/XuvcAgb+jewKLoCiGp6sGccD4QdXCk2WgD+DDWP1zSDQ2Rx7eCscL2u
         AlTSEPIvew41eQnArBGJFGH0Sdls3C04iccnKBo1v8JHjSu68Trw/qFEPOotcy8/kYaM
         cCekp1a2tUpyuDeLREiZtur+M/YMa/awEGuw4mUluIYT2suVv/7SU1vRYdRoIBRP3dO4
         /3iEgtsL7v/fF3aMKzw3RN5c1r8g7a4TIWQjNOKtMIn5HWq9hgXJ+Im+9Gagm4CBZBTd
         brWxAwj98kvq5jnGRpeFEmqAQWh7lsYWmwXJUpcUJRxZ66saEB9gBy/c94k33hRL7/cj
         2trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZVKCP8Qh4j6BGKMY5nXfHNRMKDgyZJqwrMNgLxmLGs=;
        b=peDd2IkSqOclu9hgBpGy/wsfSND3+UGRc2HqCbTK9s6s/l9x/D0wUf7ZCkiodxiBMB
         l/FmctRVT6ux+wWlMtEkS8jGCQ5MNPUAqtSwUDyEoRQgLjT0Iqyfjkh/UkK7ZqsFf8DJ
         lsfaH6s/dlXOwYkgT1AJMA+aJHjURbVXCLtYL0FKUqNUqDvCrr7SB00a13oxRF4AfJUq
         7AXguGjb6PLtvT+GgruEd6aMwY/o6Wl2rckAiDsPHbYgjNs5KmXwFlgNkf2K1HYrqdJg
         1Xgmj4YzsJ6MBeaFDBH194ATozqHII2Zd+tvh0BJ9tNt35vxd2OxalFxhQIUYB5O7MbJ
         ++XA==
X-Gm-Message-State: AOAM531r2eu6dUvTE9LpqPUDHQxJ7AJw6V4o3tEhG0pYd6iycorKMyXA
        gW/N+8eU+y/7iCUPCFFvqw4=
X-Google-Smtp-Source: ABdhPJyU5AKwW6DkSOtsEuvIMWj+KzzMIx4aP9QX+6K6OJElhNNOVS7TYhD1jT/jujoeQUXDkINYmA==
X-Received: by 2002:adf:d086:: with SMTP id y6mr18127766wrh.247.1627279754222;
        Sun, 25 Jul 2021 23:09:14 -0700 (PDT)
Received: from lb01399.fkb.profitbricks.net (p200300ca572b5e23c4ffd69035d3b735.dip0.t-ipconnect.de. [2003:ca:572b:5e23:c4ff:d690:35d3:b735])
        by smtp.gmail.com with ESMTPSA id j2sm5817548wrd.14.2021.07.25.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:09:13 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, jmoyer@redhat.com, david@redhat.com,
        mst@redhat.com, cohuck@redhat.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com,
        pankaj.gupta.linux@gmail.com, Pankaj Gupta <pankaj.gupta@ionos.com>
Subject: [RFC v2 1/2] virtio-pmem: Async virtio-pmem flush
Date:   Mon, 26 Jul 2021 08:08:54 +0200
Message-Id: <20210726060855.108250-2-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@ionos.com>

Implement asynchronous flush for virtio pmem using work queue
to solve the preflush ordering issue. Also, coalesce the flush
requests when a flush is already in process.

Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
---
 drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
 drivers/nvdimm/virtio_pmem.c | 10 ++++-
 drivers/nvdimm/virtio_pmem.h | 14 +++++++
 3 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fa..61b655b583be 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -97,29 +97,69 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	return err;
 };
 
+static void submit_async_flush(struct work_struct *ws);
+
 /* The asynchronous flush callback function */
 int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 {
-	/*
-	 * Create child bio for asynchronous flush and chain with
-	 * parent bio. Otherwise directly call nd_region flush.
+	/* queue asynchronous flush and coalesce the flush requests */
+	struct virtio_device *vdev = nd_region->provider_data;
+	struct virtio_pmem *vpmem  = vdev->priv;
+	ktime_t req_start = ktime_get_boottime();
+
+	spin_lock_irq(&vpmem->lock);
+	/* flush requests wait until ongoing flush completes,
+	 * hence coalescing all the pending requests.
 	 */
-	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
-
-		if (!child)
-			return -ENOMEM;
-		bio_copy_dev(child, bio);
-		child->bi_opf = REQ_PREFLUSH;
-		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
-		return 0;
+	wait_event_lock_irq(vpmem->sb_wait,
+			    !vpmem->flush_bio ||
+			    ktime_before(req_start, vpmem->prev_flush_start),
+			    vpmem->lock);
+	/* new request after previous flush is completed */
+	if (ktime_after(req_start, vpmem->prev_flush_start)) {
+		WARN_ON(vpmem->flush_bio);
+		vpmem->flush_bio = bio;
+		bio = NULL;
+	}
+	spin_unlock_irq(&vpmem->lock);
+
+	if (!bio) {
+		INIT_WORK(&vpmem->flush_work, submit_async_flush);
+		queue_work(vpmem->pmem_wq, &vpmem->flush_work);
+		return 1;
+	}
+
+	/* flush completed in other context while we waited */
+	if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
+		bio->bi_opf &= ~REQ_PREFLUSH;
+		submit_bio(bio);
+	} else if (bio && (bio->bi_opf & REQ_FUA)) {
+		bio->bi_opf &= ~REQ_FUA;
+		bio_endio(bio);
 	}
-	if (virtio_pmem_flush(nd_region))
-		return -EIO;
 
 	return 0;
 };
 EXPORT_SYMBOL_GPL(async_pmem_flush);
+
+static void submit_async_flush(struct work_struct *ws)
+{
+	struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
+	struct bio *bio = vpmem->flush_bio;
+
+	vpmem->start_flush = ktime_get_boottime();
+	bio->bi_status = errno_to_blk_status(virtio_pmem_flush(vpmem->nd_region));
+	vpmem->prev_flush_start = vpmem->start_flush;
+	vpmem->flush_bio = NULL;
+	wake_up(&vpmem->sb_wait);
+
+	/* Submit parent bio only for PREFLUSH */
+	if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
+		bio->bi_opf &= ~REQ_PREFLUSH;
+		submit_bio(bio);
+	} else if (bio && (bio->bi_opf & REQ_FUA)) {
+		bio->bi_opf &= ~REQ_FUA;
+		bio_endio(bio);
+	}
+}
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 726c7354d465..56780a6140c7 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
 		return PTR_ERR(vpmem->req_vq);
 
 	spin_lock_init(&vpmem->pmem_lock);
+	spin_lock_init(&vpmem->lock);
 	INIT_LIST_HEAD(&vpmem->req_list);
 
 	return 0;
@@ -57,7 +58,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
 		goto out_err;
 	}
-
+	vpmem->pmem_wq = alloc_workqueue("vpmem_wq", WQ_MEM_RECLAIM, 0);
+	if (!vpmem->pmem_wq) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+	init_waitqueue_head(&vpmem->sb_wait);
 	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
 			start, &vpmem->start);
 	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
@@ -90,10 +96,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_nd;
 	}
 	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
+	vpmem->nd_region = nd_region;
 	return 0;
 out_nd:
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
+	destroy_workqueue(vpmem->pmem_wq);
 	vdev->config->del_vqs(vdev);
 out_err:
 	return err;
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index 0dddefe594c4..d9abc8d052b6 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -35,9 +35,23 @@ struct virtio_pmem {
 	/* Virtio pmem request queue */
 	struct virtqueue *req_vq;
 
+	struct bio *flush_bio;
+	/* last_flush is when the last completed flush was started */
+	ktime_t prev_flush_start, start_flush;
+
+	/* work queue for deferred flush */
+	struct work_struct flush_work;
+	struct workqueue_struct *pmem_wq;
+
+	/* Synchronize flush wait queue data */
+	spinlock_t lock;
+	/* for waiting for previous flush to complete */
+	wait_queue_head_t sb_wait;
+
 	/* nvdimm bus registers virtio pmem device */
 	struct nvdimm_bus *nvdimm_bus;
 	struct nvdimm_bus_descriptor nd_desc;
+	struct nd_region *nd_region;
 
 	/* List to store deferred work if virtqueue is full */
 	struct list_head req_list;
-- 
2.25.1

