Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1E34EAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhC3OsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhC3Orh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:47:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so18527691eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDuvVae9dYMWTsMVJn0mH5E7CRtvLZp7LEy51JWIliw=;
        b=LdyZGd8expr8h/EjgU0bBssrnLLgR7ljmGONAfHq0hFiB/MRuV04JeCDTXIYLGr+ZW
         rgE/fgtZVDtOYaYn1mnnRmprDdTtcShbtcJXSlgB/jHRO67eeJWkEuAnY2yB8JCvbjoh
         vUzBqyovHbCpc6IwyOpD85qrtaygFSKcRZHS8mDfuPL0VYxcu3eUtPmObS8jLRY+oqpE
         Uk8r8E/PB6nS+d9qXQ2oPtBfs1Fyu4ldVRhVwVa6he4Fdw57Bc3W1WLim3o5zQTFcosp
         tfymGYq+Q2xUK7U51DtFN9i9L+imbUJc3ZrYPQSDMMbFPtI7ZWFsxruWrduUh3iNkH9O
         e8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDuvVae9dYMWTsMVJn0mH5E7CRtvLZp7LEy51JWIliw=;
        b=tI0a7HbxJUNtVIxVR2RS0VO37pb8fIjQ+Ln+zgieMXR0S0u3QKT6ekU/qstJaTrzS5
         C/Q5EF8isPjlQGiDi6AKM1dpJDAHQdN7X5VmpI9OgNzrxKf5+JXbyIFqRUNn2dpvBX22
         2N2efy7odlQbNJn9HqO1Uduu0eRN68RBnl0+WgBcmHZE+e6h2fmj+RfGIfw70JX1WLv0
         BXq46sOSRPYL5RaeUBUGsuf5eHXeWR2rA3xJnri4rnQaayeQhX9R7HWHIR+Sj9S/CdGf
         GRv2qfIibBQlVfEDqtEC0dfEJY6Lfu953lPgLYgRAIQbSpYg0jXpGxR9FvimCjRD6/nH
         sw3w==
X-Gm-Message-State: AOAM532b98/v8rvB53Gtso7FyynakJ9RfdQ8cuOSPeBUqtuHN44wbU9M
        JwDSNWGwgDqyhdiHm5TQR2jyz2HfYnpqnw==
X-Google-Smtp-Source: ABdhPJymfc4iLNLxmLAvRo8NhUjMvvoOkrDbCSLVGSF+QfQR9jMcCvq8WnQ0fMR0DlBiwiZgkLZjQw==
X-Received: by 2002:a05:6402:518c:: with SMTP id q12mr22050828edd.11.1617115655904;
        Tue, 30 Mar 2021 07:47:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n16sm11520383edr.42.2021.03.30.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 07:47:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 6/9] soundwire: qcom: add support to new interrupts
Date:   Tue, 30 Mar 2021 15:47:16 +0100
Message-Id: <20210330144719.13284-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
References: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to new interrupts which includes reporting some of the
error interrupts and adding support to SLAVE pending interrupt!

This patch also changes the interrupt handler behaviour on handling
any pending interrupts by checking it before returning out of irq handler.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/qcom.c | 161 ++++++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 26 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index faa4c84dcf61..1ad07784db4b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -28,10 +28,21 @@
 #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
 #define SWRM_INTERRUPT_STATUS					0x200
 #define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
+#define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
 #define SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED		BIT(1)
 #define SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS		BIT(2)
+#define SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET			BIT(3)
+#define SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW			BIT(4)
+#define SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW			BIT(5)
+#define SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW		BIT(6)
 #define SWRM_INTERRUPT_STATUS_CMD_ERROR				BIT(7)
+#define SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION		BIT(8)
+#define SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH		BIT(9)
 #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
+#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2             BIT(13)
+#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
+#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
+#define SWRM_INTERRUPT_MAX					17
 #define SWRM_INTERRUPT_MASK_ADDR				0x204
 #define SWRM_INTERRUPT_CLEAR					0x208
 #define SWRM_INTERRUPT_CPU_EN					0x210
@@ -58,6 +69,7 @@
 #define SWRM_MCP_STATUS_BANK_NUM_MASK				BIT(0)
 #define SWRM_MCP_SLV_STATUS					0x1090
 #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
+#define SWRM_MCP_SLV_STATUS_SZ					2
 #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_PORT_CTRL_2_BANK(n, m)	(0x1128 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_BLOCK_CTRL_1(n)		(0x112C + 0x100 * (n - 1))
@@ -123,6 +135,7 @@ struct qcom_swrm_ctrl {
 	int rows_index;
 	unsigned long dout_port_mask;
 	unsigned long din_port_mask;
+	u32 intr_mask;
 	u8 rcmd_id;
 	u8 wcmd_id;
 	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
@@ -305,6 +318,25 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
 	return SDW_CMD_IGNORED;
 }
 
+static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
+{
+	u32 val, status;
+	int dev_num;
+
+	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
+
+	for (dev_num = 0; dev_num < SDW_MAX_DEVICES; dev_num++) {
+		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
+
+		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
+			ctrl->status[dev_num] = status;
+			return dev_num;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 {
 	u32 val;
@@ -323,36 +355,112 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 
 static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 {
-	struct qcom_swrm_ctrl *ctrl = dev_id;
-	u32 sts, value;
+	struct qcom_swrm_ctrl *swrm = dev_id;
+	u32 value, intr_sts, intr_sts_masked;
+	u32 i;
+	u8 devnum = 0;
+	int ret = IRQ_HANDLED;
 
-	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
+	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
+	intr_sts_masked = intr_sts & swrm->intr_mask;
 
-	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
-		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
-		dev_err_ratelimited(ctrl->dev,
-				    "CMD error, fifo status 0x%x\n",
-				     value);
-		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
-	}
-
-	if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
-	    sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS) {
-		qcom_swrm_get_device_status(ctrl);
-		sdw_handle_slave_status(&ctrl->bus, ctrl->status);
-	}
-
-	/**
-	 * clear the interrupt before complete() is called, as complete can
-	 * schedule new read/writes which require interrupts, clearing the
-	 * interrupt would avoid missing interrupts in such cases.
-	 */
-	ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);
+	do {
+		for (i = 0; i < SWRM_INTERRUPT_MAX; i++) {
+			value = intr_sts_masked & BIT(i);
+			if (!value)
+				continue;
+
+			switch (value) {
+			case SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ:
+				devnum = qcom_swrm_get_alert_slave_dev_num(swrm);
+				if (devnum < 0) {
+					dev_err_ratelimited(swrm->dev,
+					    "no slave alert found.spurious interrupt\n");
+				} else {
+					sdw_handle_slave_status(&swrm->bus, swrm->status);
+				}
 
-	if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED)
-		complete(&ctrl->broadcast);
+				break;
+			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
+			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
+				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
+					__func__);
+				qcom_swrm_get_device_status(swrm);
+				sdw_handle_slave_status(&swrm->bus, swrm->status);
+				break;
+			case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
+				dev_err_ratelimited(swrm->dev,
+						"%s: SWR bus clsh detected\n",
+						__func__);
+				swrm->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
+				swrm->reg_write(swrm, SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
+				break;
+			case SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW:
+				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+				dev_err_ratelimited(swrm->dev,
+					"%s: SWR read FIFO overflow fifo status 0x%x\n",
+					__func__, value);
+				break;
+			case SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW:
+				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+				dev_err_ratelimited(swrm->dev,
+					"%s: SWR read FIFO underflow fifo status 0x%x\n",
+					__func__, value);
+				break;
+			case SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW:
+				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+				dev_err(swrm->dev,
+					"%s: SWR write FIFO overflow fifo status %x\n",
+					__func__, value);
+				swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
+				break;
+			case SWRM_INTERRUPT_STATUS_CMD_ERROR:
+				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+				dev_err_ratelimited(swrm->dev,
+					"%s: SWR CMD error, fifo status 0x%x, flushing fifo\n",
+					__func__, value);
+				swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
+				break;
+			case SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION:
+				dev_err_ratelimited(swrm->dev,
+						"%s: SWR Port collision detected\n",
+						__func__);
+				swrm->intr_mask &= ~SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION;
+				swrm->reg_write(swrm,
+					SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
+				break;
+			case SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH:
+				dev_err_ratelimited(swrm->dev,
+					"%s: SWR read enable valid mismatch\n",
+					__func__);
+				swrm->intr_mask &=
+					~SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH;
+				swrm->reg_write(swrm,
+					SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
+				break;
+			case SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED:
+				complete(&swrm->broadcast);
+				break;
+			case SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2:
+				break;
+			case SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2:
+				break;
+			case SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP:
+				break;
+			default:
+				dev_err_ratelimited(swrm->dev,
+						"%s: SWR unknown interrupt value: %d\n",
+						__func__, value);
+				ret = IRQ_NONE;
+				break;
+			}
+		}
+		swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, intr_sts);
+		swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
+		intr_sts_masked = intr_sts & swrm->intr_mask;
+	} while (intr_sts_masked);
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
@@ -368,6 +476,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	/* Disable Auto enumeration */
 	ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 0);
 
+	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
 	/* Mask soundwire interrupts */
 	ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
 			SWRM_INTERRUPT_STATUS_RMSK);
-- 
2.21.0

