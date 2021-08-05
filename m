Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5393E1484
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbhHEMQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:16:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhHEMQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:16:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC07220231;
        Thu,  5 Aug 2021 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628165752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Cst26t9NjVGD4Ogh3bGKp0IaNkcfUTEKl3siw2LT0dg=;
        b=D3EovsqUGGr/thltOMMCBf8NgIniq7Uojb5v9ejKl5228pVV7ZEfsAAUPPaSgeFhPJjxKI
        RYnaOR/TYOjF72dG14sqUyCLM3bRTwhrygBD2sjQvWqK8uL2US1Fz+l04fVLwT4t6c42KQ
        ECP2IQTUK7Ie4ROlqd1s63FnClEI/gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628165752;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Cst26t9NjVGD4Ogh3bGKp0IaNkcfUTEKl3siw2LT0dg=;
        b=C9WDK3SnRp7AsJyzBS/ZO5P3eau52XlZZJJSVY+xqTo5YxPZDh8xQjqYHIANxT1cKshYK5
        hLWOCclsK97RqiCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0CD22A3B94;
        Thu,  5 Aug 2021 12:15:51 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id DB07D518C254; Thu,  5 Aug 2021 14:15:51 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, yi.he@emc.com,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Date:   Thu,  5 Aug 2021 14:15:41 +0200
Message-Id: <20210805121541.77613-1-dwagner@suse.de>
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

The new member can be placed adjacent to the receive related members and
fits in the cacheline as there is a 4 byte hole.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

Hi,

I've tested this by modifying the receive path. Via the fault_inject
interface I injecting wrong hash values. The request would then be
completed with status != 0 and nvme_decide_disposition decices to
retry the request. So this seems be in more sync with what the spec
says on this topic.

Daniel

 drivers/nvme/host/tcp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 097f7dd10ed3..5253147df4c7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -89,6 +89,7 @@ struct nvme_tcp_queue {
 	size_t			data_remaining;
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
+	u16			status;
 
 	/* send state */
 	struct nvme_tcp_request *request;
@@ -496,7 +497,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	if (!nvme_try_complete_req(rq, queue->status ?
+			queue->status : cqe->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -676,6 +678,7 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 	switch (hdr->type) {
 	case nvme_tcp_c2h_data:
+		queue->status = NVME_SC_SUCCESS;
 		return nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
 	case nvme_tcp_rsp:
 		nvme_tcp_init_recv_ctx(queue);
@@ -758,7 +761,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+				nvme_tcp_end_request(rq, queue->status);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -792,14 +795,14 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			"data digest error: recv %#x expected %#x\n",
 			le32_to_cpu(queue->recv_ddgst),
 			le32_to_cpu(queue->exp_ddgst));
-		return -EIO;
+		queue->status = NVME_SC_DATA_XFER_ERROR;
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
 		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
 					pdu->command_id);
 
-		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+		nvme_tcp_end_request(rq, queue->status);
 		queue->nr_cqe++;
 	}
 
-- 
2.29.2

