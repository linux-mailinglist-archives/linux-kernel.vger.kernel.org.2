Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7E34A20D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCZGmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCZGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:41:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1750CC0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dm8so5084465edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENz5XBbvEDbbbtw8iA6jo2aOeQQAzNhPJSQZvZsIFcY=;
        b=t0K+FB49i0EB8i0bKq6FlIB6jT/8VZNPaM0qKcZF8VlixXk8LlkAJHWNxAUqSmN5xB
         isO+N1x52Cbz/aCSrvnQCwf9nKriAK2PnNdDyf0Hp9kU8ZrYNVc4HuA9YkLhC9W4f2jm
         YLYVmr/ywto8tZXLdE4BtQalu5bzg+pNkGvpkR2Z0cpgiSh02RI14msKTDJyr67z+nEq
         wwodbIe6ADWAJieaV8AZTXhTWfbEUfKp4trCyQF7vcMt++pau3ClTpfSrDWSRpMLL9KA
         Z0eHnnaJmlW3MfpyYTTXVKbYmJbDo9Ayk4TcUBhhK9iBaSqVEpRkgd0ePrblQVFRwRAU
         /P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENz5XBbvEDbbbtw8iA6jo2aOeQQAzNhPJSQZvZsIFcY=;
        b=aNUyq9R4z28YEKBY8CNJYGwgZqhl+eGaJhv2O43m3ATZ5E9VMItNPShrI2C85jZC7v
         OgkzybQyNEC8zFtjx+jk9T3EwKEOjp4KNr4n+oiiqspmqjCLL1VPQiILUEocWhVRrQwV
         0KDz+g0FS/SOVWcRK/+ib7V797AD/kWybx7T2LAH5uP55aqpDdoIeNEV1FLThOLaLQ7X
         OkXf4TeFGryzfTkoUJ67oQBuQ4p2dlxt1EcHGRFwcshYw3iOHZfzRxkjtDvxBhOTxOmP
         l03mnNbi4jy8/9d7k4nNQf9KvGhPT5t4grvNyV7kuOb9y0RnXowgdTWsBtcReOmyiu3g
         nJOA==
X-Gm-Message-State: AOAM530iADwqXSB76zQzgsVhPYhQxh6GQB/Pe8b2IqlIPlsqgZBKQkS9
        nCxGhw5FP+gYQkH1/8D1QA3IHQ==
X-Google-Smtp-Source: ABdhPJxwc/kiNw+hAhKPzVPmmb39f3ZBAN2IWKgflXX1Yz87sp/E8zRO3ryLPzvIIRJ2iyvYOB0qyw==
X-Received: by 2002:a50:ed90:: with SMTP id h16mr13138677edr.101.1616740882396;
        Thu, 25 Mar 2021 23:41:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:41:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 6/9] soundwire: qcom: add support to new interrupts
Date:   Fri, 26 Mar 2021 06:39:41 +0000
Message-Id: <20210326063944.31683-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
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
index 0cbd611fb8c6..6a563fb52444 100644
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

