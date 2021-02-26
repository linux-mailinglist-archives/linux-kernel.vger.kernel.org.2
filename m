Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEADD32651E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBZP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBZP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:59:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A65C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:34 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e10so8819503wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACrw971yAgpkUR4/L7V2TXxp1p7AkYh2+bA6//6+xVM=;
        b=nt+NOOI7NBlV/6Ismb0rbOJmNUXS7wtzbVx8cywzg+mIG2JMktJk5t+8JTS2nKLGRe
         BUWcpo/43CBrA/PxSs6p6f5o7TH0/vjvHk/Cc13X4Bcdf7rgSF/HDj5RS1bL7nTytdZu
         DpbcaEY8Tld9yyPDibWSV7OnN66G7AOk6SEmZ5mG+BgnquiHoELukUS7PhaMBwuLzt+y
         Rc+PCUGyLi8q1A1MdWDClJVmCcZxmwa/6WK6LyxwEjp4fbJ3i1kRoEJfZSPhgMRizllB
         wJ2bzzyFsA3LLNaZJl3yuer2CZLah7ES1qGy+j8zxCoImnJE6uTf1nq9BCzCdDT3JXPs
         ZoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACrw971yAgpkUR4/L7V2TXxp1p7AkYh2+bA6//6+xVM=;
        b=P6UuLK/Bu3gQD7ZCEh68RuFNLSKekZHE4AHIh6r+lbqdpRvYEgDHvSiib8VNs7dRar
         /z8Lk+AFZ+jioRslB1X1crVdr51NSblZ+KJUlNPEz2ZmYAauk4azHwDoJcizAR9fS81r
         OunwjpXg2PRZ6dKTfGJ3QKoXG2qLF16QobgriBjUo5PrirVwET35s/iCWSfI4Uj8WWU1
         uGgeT0szxMaGA3KtYJIi8+wp6ABUT2QKmEBeuMw2zGIRzpJxHbhhBZqfX5TUT4ZlVR72
         n9ThsEbEGlFuMXl4xq19BCiDs3Au8TwqmhfxOsXG16fmi3JicPsGYbu3aRuRtG6wG80P
         BkUA==
X-Gm-Message-State: AOAM5309ygttL5VJsDfnTkVlbk9ziZDhS2qOPHX9pS0i+107mF+vHuBx
        ciEgtrwyo9adUlzSMAaFQHJ/sA==
X-Google-Smtp-Source: ABdhPJzA2z0cz9so79hkFwLF7OyM7c6mN8IfcMiKzK6fgfQZUgfl1Yd/C5e4m2PgtkBxlnAavixdMQ==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr2862111wrs.135.1614355112854;
        Fri, 26 Feb 2021 07:58:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v6sm14398945wrx.32.2021.02.26.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:58:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/5] soundwire: qcom: add support to new interrupts
Date:   Fri, 26 Feb 2021 15:58:14 +0000
Message-Id: <20210226155814.27536-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
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
---
 drivers/soundwire/qcom.c | 161 ++++++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 26 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index e1cf821ea5e0..8438f9812d7c 100644
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
@@ -304,6 +317,25 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
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
@@ -322,36 +354,112 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 
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
+			value = intr_sts_masked & (1 << i);
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
@@ -367,6 +475,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	/* Disable Auto enumeration */
 	ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 0);
 
+	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
 	/* Mask soundwire interrupts */
 	ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
 			SWRM_INTERRUPT_STATUS_RMSK);
-- 
2.21.0

