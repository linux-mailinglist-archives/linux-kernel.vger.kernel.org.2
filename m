Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4717B409D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbhIMTku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242358AbhIMTkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:40:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0390F61106;
        Mon, 13 Sep 2021 19:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631561971;
        bh=ooRGcVDKj7Dv93a/Z9qnGoOSA1XE9GpBNZlFtygLLWE=;
        h=From:To:Cc:Subject:Date:From;
        b=vMrBorZoZ6upfIv/vdp9QkrGhRmQqrVn/w5c6um4FDsC73vN71qC9d/I1IFffutnw
         fcusrX8orZiXPZY2JRXggmseO1D41XE51ioyozgkAFAg0VrOxY0ELC36d3wurIoEJY
         Bn3KEIR1rih7uqp/Etu+MBwFND22kwmALpJpv10r1UGorWGjlY/Ld8iJAleKLRm5vB
         jmeESLQJfMPLzNHHfd/BB/LsFn2N1aj8MXe39VfTma5HEJgMAwFLcCPcuKJfuBrLqL
         ZeIDe33PEUWNv0BhEfZIG527h0HoVtstisg/Tlp1r19rZCbKOaX1VNmF+ovxLcuyfU
         ptMDGkVop8wCw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 1/3] habanalabs: generalize COMMS message sending procedure
Date:   Mon, 13 Sep 2021 22:39:24 +0300
Message-Id: <20210913193926.17329-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

Instead of having dedicated function per message that we want to send
to the firmware in COMMS protocol, have a generic function that we can
call to from other parts of the driver

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 28 +++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 8d2568c63f19..4e68fb9d2a6b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2162,18 +2162,17 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 }
 
 /**
- * hl_fw_dynamic_report_reset_cause - send a COMMS message with the cause
- *                                    of the newly triggered hard reset
+ * hl_fw_dynamic_send_msg - send a COMMS message with attached data
  *
  * @hdev: pointer to the habanalabs device structure
  * @fw_loader: managing structure for loading device's FW
- * @reset_cause: enumerated cause for the recent hard reset
+ * @msg_type: message type
+ * @data: data to be sent
  *
  * @return 0 on success, otherwise non-zero error code
  */
-static int hl_fw_dynamic_report_reset_cause(struct hl_device *hdev,
-		struct fw_load_mgr *fw_loader,
-		enum comms_reset_cause reset_cause)
+static int hl_fw_dynamic_send_msg(struct hl_device *hdev,
+		struct fw_load_mgr *fw_loader, u8 msg_type, void *data)
 {
 	struct lkd_msg_comms msg;
 	int rc;
@@ -2181,11 +2180,20 @@ static int hl_fw_dynamic_report_reset_cause(struct hl_device *hdev,
 	memset(&msg, 0, sizeof(msg));
 
 	/* create message to be sent */
-	msg.header.type = HL_COMMS_RESET_CAUSE_TYPE;
+	msg.header.type = msg_type;
 	msg.header.size = cpu_to_le16(sizeof(struct comms_msg_header));
 	msg.header.magic = cpu_to_le32(HL_COMMS_MSG_MAGIC);
 
-	msg.reset_cause = reset_cause;
+	switch (msg_type) {
+	case HL_COMMS_RESET_CAUSE_TYPE:
+		msg.reset_cause = *(__u8 *) data;
+		break;
+	default:
+		dev_err(hdev->dev,
+			"Send COMMS message - invalid message type %u\n",
+			msg_type);
+		return -EINVAL;
+	}
 
 	rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader,
 			sizeof(struct lkd_msg_comms));
@@ -2252,8 +2260,8 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 		goto protocol_err;
 
 	if (hdev->curr_reset_cause) {
-		rc = hl_fw_dynamic_report_reset_cause(hdev, fw_loader,
-				hdev->curr_reset_cause);
+		rc = hl_fw_dynamic_send_msg(hdev, fw_loader,
+				HL_COMMS_RESET_CAUSE_TYPE, &hdev->curr_reset_cause);
 		if (rc)
 			goto protocol_err;
 
-- 
2.17.1

