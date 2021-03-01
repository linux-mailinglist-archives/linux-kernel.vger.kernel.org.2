Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0C5329812
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhCAXLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 18:11:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:40984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235318AbhCAR4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:56:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97D26ADDD;
        Mon,  1 Mar 2021 17:56:03 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme-tcp: Check if request has started before processing it
Date:   Mon,  1 Mar 2021 18:56:01 +0100
Message-Id: <20210301175601.116405-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_tag_to_rq() always returns a request if the tag id is in a
valid range [0...max_tags). If the target replies with a tag for which
we don't have a request but it's not started, the host will likely
corrupt data or simply crash.

Add an additional check if the a request has been started if not
reset the connection.

This addition check will not protected against an invalid tag which
maps to a request which has been started. There is nothing we can do
about this. Though it will at a least protect from crashing the host,
which generally thought to be the right thing to do.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

The patch is against nmve-5.12.

I noted that nvme_tcp_process_nvme_cqe() returns EINVAL
where as the rest uses ENOENT. Looks a bit odd to me.

I've tested this with blktests.

v2:
  - moved the check into a helper to avoid code duplication
  - use nvme_reset_ctrl if request has not been started
  - added nvme_tcp_recv_ddgst() callsite

 drivers/nvme/host/tcp.c | 56 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..af6f725b842b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -479,19 +479,38 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
-static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
-		struct nvme_completion *cqe)
+static bool nvme_tcp_tag_to_rq(struct nvme_tcp_queue *queue,
+			__u16 command_id, struct request **req)
 {
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag 0x%x not found\n",
-			nvme_tcp_queue_id(queue), cqe->command_id);
+			nvme_tcp_queue_id(queue), command_id);
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-		return -EINVAL;
+		return false;
 	}
+	if (!blk_mq_request_started(rq)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d received invalid tag\n",
+			nvme_tcp_queue_id(queue));
+		nvme_reset_ctrl(&queue->ctrl->ctrl);
+		return false;
+	}
+
+	*req = rq;
+	return true;
+}
+
+static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
+		struct nvme_completion *cqe)
+{
+	struct request *rq;
+
+	if (!nvme_tcp_tag_to_rq(queue, cqe->command_id, &rq))
+		return -EINVAL;
 
 	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
 		nvme_complete_rq(rq);
@@ -505,13 +524,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 {
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+	if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
 		return -ENOENT;
-	}
 
 	if (!blk_rq_payload_bytes(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -609,13 +623,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	struct request *rq;
 	int ret;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+	if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
 		return -ENOENT;
-	}
 	req = blk_mq_rq_to_pdu(rq);
 
 	ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
@@ -695,13 +704,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	struct nvme_tcp_request *req;
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
+	if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
 		return -ENOENT;
-	}
 	req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
@@ -794,8 +798,10 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
-						pdu->command_id);
+		struct request *rq;
+
+		if (!nvme_tcp_tag_to_rq(queue, pdu->command_id, &rq))
+			return -EINVAL;
 
 		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
 		queue->nr_cqe++;
-- 
2.29.2

