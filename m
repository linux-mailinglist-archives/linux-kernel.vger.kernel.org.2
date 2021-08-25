Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D243F753B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbhHYMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:43:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49814 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhHYMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:43:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44C5E2219D;
        Wed, 25 Aug 2021 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629895381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4kUx+sQ8CSqEaO7GPPLBgapAahK109tcvO/jd+AOX+Q=;
        b=0v3D66/VWl5VwtuUVLi7azpsB5kwsB3G/qzDtq+FCviTauChbMyvmPG54jixHg2Zr4Anca
        wAkNBH0ZOn3tnpfjZiWV8ooqrYW0eIyFukDEeEf1d95VklxiZ7nHoWoslmSeufnrK66Bqd
        jCTRrWW7Oa1RQ6Eg54WyENa1dl/NGaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629895381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4kUx+sQ8CSqEaO7GPPLBgapAahK109tcvO/jd+AOX+Q=;
        b=eXJUomYAUbFs+cKMSJoXt65WQaqqOyls7E00EmE9HVlDq1o1MlaMoDy089wND7ahDW17PE
        MzhyCi1qjIqv0sBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 3773AA3B83;
        Wed, 25 Aug 2021 12:43:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 195D8518DA06; Wed, 25 Aug 2021 14:43:01 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, yi.he@emc.com,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme-tcp: Do not reset transport on data digest errors
Date:   Wed, 25 Aug 2021 14:42:59 +0200
Message-Id: <20210825124259.28707-1-dwagner@suse.de>
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
detected. To fix this, keep track of the final status in the queue
object and use it when completing the request.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

The status member placed so that it fills up a hole in struct
nvme_tcp_request:

struct nvme_tcp_request {
        struct nvme_request        req;                  /*     0    32 */
        void *                     pdu;                  /*    32     8 */
        struct nvme_tcp_queue *    queue;                /*    40     8 */
        u32                        data_len;             /*    48     4 */
        u32                        pdu_len;              /*    52     4 */
        u32                        pdu_sent;             /*    56     4 */
        u16                        ttag;                 /*    60     2 */
        u16                        status;               /*    62     2 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct list_head           entry;                /*    64    16 */
        struct llist_node          lentry;               /*    80     8 */
        __le32                     ddgst;                /*    88     4 */

        /* XXX 4 bytes hole, try to pack */

        struct bio *               curr_bio;             /*    96     8 */
        struct iov_iter            iter;                 /*   104    40 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        size_t                     offset;               /*   144     8 */
        size_t                     data_sent;            /*   152     8 */
        enum nvme_tcp_send_state   state;                /*   160     4 */

        /* size: 168, cachelines: 3, members: 16 */
        /* sum members: 160, holes: 1, sum holes: 4 */
        /* padding: 4 */
        /* last cacheline: 40 bytes */
};

v1:
 - https://lore.kernel.org/linux-nvme/20210805121541.77613-1-dwagner@suse.de/
 - moved 'status' from nvme_tcp_queue to nvme_tcp_request.

 drivers/nvme/host/tcp.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 645025620154..23a8f7e11cfa 100644
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
@@ -485,7 +486,9 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
+	u16 status;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
 	if (!rq) {
@@ -496,7 +499,12 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	req = blk_mq_rq_to_pdu(rq);
+	status = req->status;
+	if (status == NVME_SC_SUCCESS)
+		status = cqe->status;
+
+	if (!nvme_try_complete_req(rq, status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -506,6 +514,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		struct nvme_tcp_data_pdu *pdu)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
@@ -534,6 +543,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	req = blk_mq_rq_to_pdu(rq);
+	req->status = NVME_SC_SUCCESS;
 	return 0;
 }
 
@@ -758,7 +769,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+				nvme_tcp_end_request(rq, req->status);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -788,18 +799,24 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
 
-- 
2.29.2

