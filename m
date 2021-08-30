Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66963FB4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhH3LjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:39:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhH3LjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:39:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E7502212A;
        Mon, 30 Aug 2021 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630323505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fSfuQ22SzTNGNd9t1JZAkZpVyjkxYu6JIuqPwozZ1cE=;
        b=2Pz9rsGOy43Kq+Kzo8vuii027ExhBsR/EzWdiIIFMM+tRBJ0DupqmhCTUx8DoRUC79Nohu
        CxwAjKn6dCDphc5ePJUFDMIczz7DwMeyH0Bld9EhMXj5HR4qlKtK054nO9C4+NqazPCHC+
        20LPSvz1cr37RoAqIUEOe5qPE2Vam0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630323505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fSfuQ22SzTNGNd9t1JZAkZpVyjkxYu6JIuqPwozZ1cE=;
        b=df9AzpVWNygv1w+CmQE6lf9ieT9eFcDE27v1YicNmKOVT9VymvI08i55+kpcaWoedICtuW
        WwhiCbvfynkm0XBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 26A5AA3B9F;
        Mon, 30 Aug 2021 11:38:25 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 113C0518DCDA; Mon, 30 Aug 2021 13:38:25 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, yi.he@emc.com,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4] nvme-tcp: Do not reset transport on data digest errors
Date:   Mon, 30 Aug 2021 13:38:22 +0200
Message-Id: <20210830113822.104516-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec says

  7.4.6.1 Digest Error handling

  When a host detects a data digest error in a C2HData PDU, that host
  shall continue processing C2HData PDUs associated with the command and
  when the command processing has completed, if a successful status was
  returned by the controller, the host shall fail the command with a
  non-fatal transport error.

Currently the transport is reseted when a data digest error is
detected. Instead, when a digest error is detected, mark the final
status as NVME_SC_DATA_XFER_ERROR and let the upper layer handle
the error.

In order to keep track of the final result maintain a status field in
nvme_tcp_request object and use it to overwrite the completion queue
status (which might be successful even though a digest error has been
detected) when completing the request.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v4:
 - use req->status directly, avoid local variable. Suggested by Sagi.

v3:
 - https://lore.kernel.org/linux-nvme/20210826082137.23826-1-dwagner@suse.de/
 - initialize req->status in nvme_tcp_setup_cmd_pdu()
 - add rb tag from Hannes

v2:
 - https://lore.kernel.org/linux-nvme/20210825124259.28707-1-dwagner@suse.de/
 - moved 'status' from nvme_tcp_queue to nvme_tcp_request.

v1:
 - https://lore.kernel.org/linux-nvme/20210805121541.77613-1-dwagner@suse.de/

 drivers/nvme/host/tcp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 645025620154..ce1a7f5be72b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -45,6 +45,7 @@ struct nvme_tcp_request {
 	u32			pdu_len;
 	u32			pdu_sent;
 	u16			ttag;
+	u16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
 	__le32			ddgst;
@@ -485,6 +486,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
@@ -496,7 +498,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	req = blk_mq_rq_to_pdu(rq);
+	if (req->status == NVME_SC_SUCCESS)
+		req->status = cqe->status;
+
+	if (!nvme_try_complete_req(rq, req->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -758,7 +764,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+				nvme_tcp_end_request(rq, req->status);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -788,18 +794,24 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 		return 0;
 
 	if (queue->recv_ddgst != queue->exp_ddgst) {
+		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+					pdu->command_id);
+		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+		req->status = NVME_SC_DATA_XFER_ERROR;
+
 		dev_err(queue->ctrl->ctrl.device,
 			"data digest error: recv %#x expected %#x\n",
 			le32_to_cpu(queue->recv_ddgst),
 			le32_to_cpu(queue->exp_ddgst));
-		return -EIO;
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
 		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
 					pdu->command_id);
+		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+		nvme_tcp_end_request(rq, req->status);
 		queue->nr_cqe++;
 	}
 
@@ -2293,6 +2305,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 
 	req->state = NVME_TCP_SEND_CMD_PDU;
+	req->status = NVME_SC_SUCCESS;
 	req->offset = 0;
 	req->data_sent = 0;
 	req->pdu_len = 0;
-- 
2.29.2

