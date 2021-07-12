Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED13C5E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhGLOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:21:56 -0400
Received: from foss.arm.com ([217.140.110.172]:55880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234972AbhGLOV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:21:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E772106F;
        Mon, 12 Jul 2021 07:19:07 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 737B93F774;
        Mon, 12 Jul 2021 07:19:04 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: [PATCH v6 03/17] firmware: arm_scmi: Add support for type handling in common functions
Date:   Mon, 12 Jul 2021 15:18:19 +0100
Message-Id: <20210712141833.6628-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCMI type handling to pack/unpack_scmi_header common helper functions.
Initialize hdr.type properly when initializing a command xfer.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Needed later in the series to support serialization
---
 drivers/firmware/arm_scmi/common.h | 6 +++++-
 drivers/firmware/arm_scmi/driver.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 8685619d38f9..7c2b9fd7e929 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -70,6 +70,7 @@ struct scmi_msg_resp_prot_version {
  *
  * @id: The identifier of the message being sent
  * @protocol_id: The identifier of the protocol used to send @id message
+ * @type: The SCMI type for this message
  * @seq: The token to identify the message. When a message returns, the
  *	platform returns the whole message header unmodified including the
  *	token
@@ -80,6 +81,7 @@ struct scmi_msg_resp_prot_version {
 struct scmi_msg_hdr {
 	u8 id;
 	u8 protocol_id;
+	u8 type;
 	u16 seq;
 	u32 status;
 	bool poll_completion;
@@ -89,13 +91,14 @@ struct scmi_msg_hdr {
  * pack_scmi_header() - packs and returns 32-bit header
  *
  * @hdr: pointer to header containing all the information on message id,
- *	protocol id and sequence id.
+ *	protocol id, sequence id and type.
  *
  * Return: 32-bit packed message header to be sent to the platform.
  */
 static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 {
 	return FIELD_PREP(MSG_ID_MASK, hdr->id) |
+		FIELD_PREP(MSG_TYPE_MASK, hdr->type) |
 		FIELD_PREP(MSG_TOKEN_ID_MASK, hdr->seq) |
 		FIELD_PREP(MSG_PROTOCOL_ID_MASK, hdr->protocol_id);
 }
@@ -110,6 +113,7 @@ static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
 {
 	hdr->id = MSG_XTRACT_ID(msg_hdr);
 	hdr->protocol_id = MSG_XTRACT_PROT_ID(msg_hdr);
+	hdr->type = MSG_XTRACT_TYPE(msg_hdr);
 }
 
 /**
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d2c98642cb14..53c17fba0059 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -565,6 +565,7 @@ static int xfer_get_init(const struct scmi_protocol_handle *ph,
 
 	xfer->tx.len = tx_size;
 	xfer->rx.len = rx_size ? : info->desc->max_msg_size;
+	xfer->hdr.type = MSG_TYPE_COMMAND;
 	xfer->hdr.id = msg_id;
 	xfer->hdr.poll_completion = false;
 
-- 
2.17.1

