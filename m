Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35B2350532
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhCaRBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhCaRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:01:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACCEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:01:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so31080090ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KspNwzuOj9aLMXGk2fyODvGz7byP37BIX3QwCShIa1U=;
        b=mfCmqZgpg+o9P0WseEbaUpCianBH4aueY2MbD8bcRz6g31+B/W8uqpCcIgaz3s+6w9
         B0DEL4KazRRSF3ycZPlJQacoS5R8vwFLdizPiIHLKr6NRPhtivQPzY+ydqccz6WdECeF
         O9w8aBRWZXB8CrStVsCGVOg+VVpeXOAUuUBrDsrfoLGjN8uatANCivyzTQta7ROHu8Om
         0H+2zkFEz0BU4WV9JH4KXpWpxC/tZFC+aYcgqc6ccm8dJwzce/71lo6OmV9/nkpe8sII
         VARSSWDSzJMYOlQHWKnHElfGLNq7GnFgsyJkbOZj9zOYYqrGYbr2dMUE8Fx2wy7+8uJ2
         RNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KspNwzuOj9aLMXGk2fyODvGz7byP37BIX3QwCShIa1U=;
        b=nuF2Y0v/Bmo2eKcaNWk0W/ox/7bZEuVz2sO0QDn3FJQ4MXtouf9De39wCyfBv4zh9K
         UcXUgKpV5C9UqYFf7sC8t0vxMn6JKoqI2QI3zZFUGrGug9qcv/NbekPWMJV0EDlmsw+k
         p2tlv3p3RB080zTO1sa02+pSB8v6Ek+G/Sv/JMRMkL1S1zAaWgoBq5DzchQKmEvQBXXd
         qLoPikbR/28jajqDmXtH+i3sF76d88McHRoUEP0g3Ge2nSzdcLmIJQ08sv95Do+fPADV
         2cXzYWxR3Pb2HegncXx8h7O9wk7PrTS57Fg8nNnH6AmkZlL+UZhSHGgW+cBW1u7JLxcr
         mHPg==
X-Gm-Message-State: AOAM531PTm8zz4OJ5oifSXXBGHOfprr5O9J8dZZze7siC/Su3dGtIL31
        vM9YTPFBm57xMzOA8yMXILNqWw==
X-Google-Smtp-Source: ABdhPJyZ/YGsfKKEJ78XYWOEq3oaf4XoaUn3hoN0mkzXk+2J11yt+vHn3WhwhlT7kxbdZeQ4exjF9A==
X-Received: by 2002:a17:906:3882:: with SMTP id q2mr4587674ejd.540.1617210076003;
        Wed, 31 Mar 2021 10:01:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id rs24sm1515247ejb.75.2021.03.31.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 10:01:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: qcom: wait for fifo space to be available before read/write
Date:   Wed, 31 Mar 2021 18:00:33 +0100
Message-Id: <20210331170033.17174-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/qcom.c | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6affa3cd4039..9b45717577f2 100644
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
@@ -238,6 +245,63 @@ static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
 	return val;
 }
 
+static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
+{
+	u32 fifo_outstanding_cmd, value;
+	u8 fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
+
+	/* Check for fifo underflow during read */
+	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+	fifo_outstanding_cmd = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
+
+	 /* Check number of outstanding commands in fifo before read */
+	if (fifo_outstanding_cmd)
+		return 0;
+
+	do {
+		usleep_range(500, 510);
+		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+		fifo_outstanding_cmd = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
+		if (fifo_outstanding_cmd > 0)
+			break;
+	} while (fifo_retry_count--);
+
+	if (fifo_outstanding_cmd == 0) {
+		dev_err_ratelimited(swrm->dev, "%s err read underflow\n", __func__);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *swrm)
+{
+	u32 fifo_outstanding_cmd, value;
+	u8 fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
+
+	/* Check for fifo overflow during write */
+	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+	fifo_outstanding_cmd = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
+
+	/* Check number of outstanding commands in fifo before write */
+	if (fifo_outstanding_cmd != swrm->wr_fifo_depth)
+		return 0;
+
+	do {
+		usleep_range(500, 510);
+		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+		fifo_outstanding_cmd = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
+		if (fifo_outstanding_cmd < swrm->wr_fifo_depth)
+			break;
+	} while (fifo_retry_count--);
+
+	if (fifo_outstanding_cmd == swrm->wr_fifo_depth) {
+		dev_err_ratelimited(swrm->dev, "%s err write overflow\n", __func__);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
 
 static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
 				     u8 dev_addr, u16 reg_addr)
@@ -256,6 +320,9 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
 					      dev_addr, reg_addr);
 	}
 
+	if (swrm_wait_for_wr_fifo_avail(swrm))
+		return SDW_CMD_FAIL_OTHER;
+
 	/* Its assumed that write is okay as we do not get any status back */
 	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
 
@@ -295,6 +362,9 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
 	/* wait for FIFO RD CMD complete to avoid overflow */
 	usleep_range(250, 255);
 
+	if (swrm_wait_for_rd_fifo_avail(swrm))
+		return SDW_CMD_FAIL_OTHER;
+
 	do {
 		swrm->reg_read(swrm, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
 		rval[0] = cmd_data & 0xFF;
@@ -586,6 +656,10 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
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

