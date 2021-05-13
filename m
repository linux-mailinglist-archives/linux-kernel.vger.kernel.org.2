Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B107D37F54D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhEMKGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:06:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhEMKEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:04:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620900186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+55VMtjzppNIHp9ZFTWUzvbF11WwY57Fyil6Rw9VV3g=;
        b=WIbclcgSxN14F4SQTwhdICOoy/oKAZ9BoqgICnTIhIpgk6Erd4l4kEsUzugP1UaejvjNbV
        SF+VCrj+ofIatBefBM2F1ruGfq4tOuGWV2bH5lzn6RI0YeWS3mPXlGIxGVYjtjjZvVYhSc
        QH0d4mMri26CSMZx7ZAGaRASXWH8GmQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30CD0B021;
        Thu, 13 May 2021 10:03:06 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] xen/blkfront: don't trust the backend response data blindly
Date:   Thu, 13 May 2021 12:02:58 +0200
Message-Id: <20210513100302.22027-5-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210513100302.22027-1-jgross@suse.com>
References: <20210513100302.22027-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today blkfront will trust the backend to send only sane response data.
In order to avoid privilege escalations or crashes in case of malicious
backends verify the data to be within expected limits. Especially make
sure that the response always references an outstanding request.

Introduce a new state of the ring BLKIF_STATE_ERROR which will be
switched to in case an inconsistency is being detected.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 62 +++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index c6a05de4f15f..aa0f159829b4 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -80,6 +80,7 @@ enum blkif_state {
 	BLKIF_STATE_DISCONNECTED,
 	BLKIF_STATE_CONNECTED,
 	BLKIF_STATE_SUSPENDED,
+	BLKIF_STATE_ERROR,
 };
 
 struct grant {
@@ -89,6 +90,7 @@ struct grant {
 };
 
 enum blk_req_status {
+	REQ_PROCESSING,
 	REQ_WAITING,
 	REQ_DONE,
 	REQ_ERROR,
@@ -543,7 +545,7 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
 
 	id = get_id_from_freelist(rinfo);
 	rinfo->shadow[id].request = req;
-	rinfo->shadow[id].status = REQ_WAITING;
+	rinfo->shadow[id].status = REQ_PROCESSING;
 	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
 
 	rinfo->shadow[id].req.u.rw.id = id;
@@ -572,6 +574,7 @@ static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_inf
 
 	/* Copy the request to the ring page. */
 	*final_ring_req = *ring_req;
+	rinfo->shadow[id].status = REQ_WAITING;
 
 	return 0;
 }
@@ -847,8 +850,11 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 
 	/* Copy request(s) to the ring page. */
 	*final_ring_req = *ring_req;
-	if (unlikely(require_extra_req))
+	rinfo->shadow[id].status = REQ_WAITING;
+	if (unlikely(require_extra_req)) {
 		*final_extra_ring_req = *extra_ring_req;
+		rinfo->shadow[extra_id].status = REQ_WAITING;
+	}
 
 	if (new_persistent_gnts)
 		gnttab_free_grant_references(setup.gref_head);
@@ -1420,8 +1426,8 @@ static enum blk_req_status blkif_rsp_to_req_status(int rsp)
 static int blkif_get_final_status(enum blk_req_status s1,
 				  enum blk_req_status s2)
 {
-	BUG_ON(s1 == REQ_WAITING);
-	BUG_ON(s2 == REQ_WAITING);
+	BUG_ON(s1 < REQ_DONE);
+	BUG_ON(s2 < REQ_DONE);
 
 	if (s1 == REQ_ERROR || s2 == REQ_ERROR)
 		return BLKIF_RSP_ERROR;
@@ -1454,7 +1460,7 @@ static bool blkif_completion(unsigned long *id,
 		s->status = blkif_rsp_to_req_status(bret->status);
 
 		/* Wait the second response if not yet here. */
-		if (s2->status == REQ_WAITING)
+		if (s2->status < REQ_DONE)
 			return false;
 
 		bret->status = blkif_get_final_status(s->status,
@@ -1574,10 +1580,16 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	spin_lock_irqsave(&rinfo->ring_lock, flags);
  again:
 	rp = rinfo->ring.sring->rsp_prod;
+	if (RING_RESPONSE_PROD_OVERFLOW(&rinfo->ring, rp)) {
+		pr_alert("%s: illegal number of responses %u\n",
+			 info->gd->disk_name, rp - rinfo->ring.rsp_cons);
+		goto err;
+	}
 	rmb(); /* Ensure we see queued responses up to 'rp'. */
 
 	for (i = rinfo->ring.rsp_cons; i != rp; i++) {
 		unsigned long id;
+		unsigned int op;
 
 		RING_COPY_RESPONSE(&rinfo->ring, i, &bret);
 		id = bret.id;
@@ -1588,14 +1600,28 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		 * look in get_id_from_freelist.
 		 */
 		if (id >= BLK_RING_SIZE(info)) {
-			WARN(1, "%s: response to %s has incorrect id (%ld)\n",
-			     info->gd->disk_name, op_name(bret.operation), id);
-			/* We can't safely get the 'struct request' as
-			 * the id is busted. */
-			continue;
+			pr_alert("%s: response has incorrect id (%ld)\n",
+				 info->gd->disk_name, id);
+			goto err;
 		}
+		if (rinfo->shadow[id].status != REQ_WAITING) {
+			pr_alert("%s: response references no pending request\n",
+				 info->gd->disk_name);
+			goto err;
+		}
+
+		rinfo->shadow[id].status = REQ_PROCESSING;
 		req  = rinfo->shadow[id].request;
 
+		op = rinfo->shadow[id].req.operation;
+		if (op == BLKIF_OP_INDIRECT)
+			op = rinfo->shadow[id].req.u.indirect.indirect_op;
+		if (bret.operation != op) {
+			pr_alert("%s: response has wrong operation (%u instead of %u)\n",
+				 info->gd->disk_name, bret.operation, op);
+			goto err;
+		}
+
 		if (bret.operation != BLKIF_OP_DISCARD) {
 			/*
 			 * We may need to wait for an extra response if the
@@ -1620,7 +1646,8 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		case BLKIF_OP_DISCARD:
 			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
 				struct request_queue *rq = info->rq;
-				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
+
+				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
 					   info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 				info->feature_discard = 0;
@@ -1632,13 +1659,13 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		case BLKIF_OP_FLUSH_DISKCACHE:
 		case BLKIF_OP_WRITE_BARRIER:
 			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
-				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
+				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
 				       info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
 			if (unlikely(bret.status == BLKIF_RSP_ERROR &&
 				     rinfo->shadow[id].req.u.rw.nr_segments == 0)) {
-				printk(KERN_WARNING "blkfront: %s: empty %s op failed\n",
+				pr_warn_ratelimited("blkfront: %s: empty %s op failed\n",
 				       info->gd->disk_name, op_name(bret.operation));
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
@@ -1653,8 +1680,8 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		case BLKIF_OP_READ:
 		case BLKIF_OP_WRITE:
 			if (unlikely(bret.status != BLKIF_RSP_OKAY))
-				dev_dbg(&info->xbdev->dev, "Bad return from blkdev data "
-					"request: %x\n", bret.status);
+				dev_dbg_ratelimited(&info->xbdev->dev,
+					"Bad return from blkdev data request: %x\n", bret.status);
 
 			break;
 		default:
@@ -1680,6 +1707,11 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
 
 	return IRQ_HANDLED;
+
+ err:
+	info->connected = BLKIF_STATE_ERROR;
+	pr_alert("%s disabled for further use\n", info->gd->disk_name);
+	return IRQ_HANDLED;
 }
 
 
-- 
2.26.2

