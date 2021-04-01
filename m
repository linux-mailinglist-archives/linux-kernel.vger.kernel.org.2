Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13337351164
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhDAJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbhDAJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:01:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B15C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:01:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jy13so1778337ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeawG8MSfVqkUaUQtWGB1XMFCzIepDytNa9lre7e8Mw=;
        b=FEl2YMxTXVENiSYhVxaNieJr41QVaMPMGAbtjUf0Lcupljd9MFs4+63s/XEefLX86R
         j5pyDaWxXXyH+dA3uC9nREG6q9KH91YJevjvLMEA74/8t061DdCnVSgNU0LlpUaBoSdC
         etLUdWLlFDQvbOxuzIfkrR6e9+C3bZ+KmNQCkF7e6Asm3NqVojfmMsI4h8WR7NoR9bWN
         olH/pHoqmabUJbIDL2hHPAOPsNVGjKyoEZF4p77ig+wSAAnXyWZcw7O5ckhq+RdSfVOy
         A2RvwCS7fHrckzzFc99HthIuDG/Nsk1GhY0qp/q+eTKc/FVmfkOF18vif9+qlO+dh9I5
         MZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jeawG8MSfVqkUaUQtWGB1XMFCzIepDytNa9lre7e8Mw=;
        b=EmBXqO/ZaXNx8MV11K5jRrcB67tRKZRsVRpv0buOCJaME0RkISGf00qMjUYCr2CZfj
         DJ6kfkwLKRSIPmvky3xC+mkNQhPguopQjdCW4XOUXP33AMoxdjBg/KTuLQMmlIAQKA0R
         P1G14HBJX1+BNFTQubkNqt5tU1l96ZfnZXPfQWdAYKE6OHjhHEAQrhh4SwF7WdPqlqxH
         6UFZxOwhHpXZ7sKf1lUbgFYqgMTUUwqQIjAQr8B8N+ooOIEEbVpa+Nt6wnw6r6q7bowT
         qLvq43tb1a/jWQY8V6xeIAi6PFOpJdMNgqbcqVgqxyvw2th+xzw6W66Vkosq+wpCn3J0
         ugKQ==
X-Gm-Message-State: AOAM531moYo4BJLcTNXbmoL+i+x7afzVAkMcwsgGJOXJSicNcR8SC0fP
        DRUT8zt1Mo8D/B4HqrP+BMrYgKWRokUm8w==
X-Google-Smtp-Source: ABdhPJyND7NWGHCHO2SVFXcbvtjRs4Uug5GLJ9Z0wsMVcYpCzK4a0hP/S/pqmI46Vcx93pGbGdmXIQ==
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr8135406ejz.244.1617267680719;
        Thu, 01 Apr 2021 02:01:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q26sm2500264eja.45.2021.04.01.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:01:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] soundwire: qcom: wait for fifo space to be available before read/write
Date:   Thu,  1 Apr 2021 10:00:58 +0100
Message-Id: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we write registers very fast we can endup in a situation where some
of the writes will be dropped without any notice.

So wait for the fifo space to be available before reading/writing the
soundwire registers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v1:
        merged some of the loop code to make it simple as suggested by Pierre
        updated error code and comments as suggested by Vinod


 drivers/soundwire/qcom.c | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6affa3cd4039..5fd4a99cc8ac 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -24,6 +24,8 @@
 #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
 #define SWRM_COMP_CFG_ENABLE_MSK				BIT(0)
 #define SWRM_COMP_PARAMS					0x100
+#define SWRM_COMP_PARAMS_WR_FIFO_DEPTH				GENMASK(14, 10)
+#define SWRM_COMP_PARAMS_RD_FIFO_DEPTH				GENMASK(19, 15)
 #define SWRM_COMP_PARAMS_DOUT_PORTS_MASK			GENMASK(4, 0)
 #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
 #define SWRM_INTERRUPT_STATUS					0x200
@@ -51,6 +53,8 @@
 #define SWRM_CMD_FIFO_CMD					0x308
 #define SWRM_CMD_FIFO_FLUSH					0x1
 #define SWRM_CMD_FIFO_STATUS					0x30C
+#define SWRM_RD_CMD_FIFO_CNT_MASK				GENMASK(20, 16)
+#define SWRM_WR_CMD_FIFO_CNT_MASK				GENMASK(12, 8)
 #define SWRM_CMD_FIFO_CFG_ADDR					0x314
 #define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
 #define SWRM_RD_WR_CMD_RETRIES					0x7
@@ -104,6 +108,7 @@
 #define SWR_BROADCAST_CMD_ID    0x0F
 #define SWR_MAX_CMD_ID	14
 #define MAX_FIFO_RD_RETRY 3
+#define SWR_OVERFLOW_RETRY_COUNT 30
 
 struct qcom_swrm_port_config {
 	u8 si;
@@ -147,6 +152,8 @@ struct qcom_swrm_ctrl {
 	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
 	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
 	u32 slave_status;
+	u32 wr_fifo_depth;
+	u32 rd_fifo_depth;
 };
 
 struct qcom_swrm_data {
@@ -238,6 +245,55 @@ static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
 	return val;
 }
 
+static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
+{
+	u32 fifo_outstanding_data, value;
+	int fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
+
+	do {
+		/* Check for fifo underflow during read */
+		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+		fifo_outstanding_data = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
+
+		/* Check if read data is available in read fifo */
+		if (fifo_outstanding_data > 0)
+			return 0;
+
+		usleep_range(500, 510);
+	} while (fifo_retry_count--);
+
+	if (fifo_outstanding_data == 0) {
+		dev_err_ratelimited(swrm->dev, "%s err read underflow\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *swrm)
+{
+	u32 fifo_outstanding_cmds, value;
+	int fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
+
+	do {
+		/* Check for fifo overflow during write */
+		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+		fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
+
+		/* Check for space in write fifo before writing */
+		if (fifo_outstanding_cmds < swrm->wr_fifo_depth)
+			return 0;
+
+		usleep_range(500, 510);
+	} while (fifo_retry_count--);
+
+	if (fifo_outstanding_cmds == swrm->wr_fifo_depth) {
+		dev_err_ratelimited(swrm->dev, "%s err write overflow\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
 
 static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
 				     u8 dev_addr, u16 reg_addr)
@@ -256,6 +312,9 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
 					      dev_addr, reg_addr);
 	}
 
+	if (swrm_wait_for_wr_fifo_avail(swrm))
+		return SDW_CMD_FAIL_OTHER;
+
 	/* Its assumed that write is okay as we do not get any status back */
 	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
 
@@ -295,6 +354,9 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
 	/* wait for FIFO RD CMD complete to avoid overflow */
 	usleep_range(250, 255);
 
+	if (swrm_wait_for_rd_fifo_avail(swrm))
+		return SDW_CMD_FAIL_OTHER;
+
 	do {
 		swrm->reg_read(swrm, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
 		rval[0] = cmd_data & 0xFF;
@@ -586,6 +648,10 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 				SWRM_INTERRUPT_STATUS_RMSK);
 	}
 	ctrl->slave_status = 0;
+	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
+	ctrl->rd_fifo_depth = FIELD_GET(SWRM_COMP_PARAMS_RD_FIFO_DEPTH, val);
+	ctrl->wr_fifo_depth = FIELD_GET(SWRM_COMP_PARAMS_WR_FIFO_DEPTH, val);
+
 	return 0;
 }
 
-- 
2.21.0

