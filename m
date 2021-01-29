Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21102308BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhA2Rft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhA2RdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:33:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1597C061574
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:33:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d16so9616574wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfBwc9juEmKkxkxZ+pO3/BcQV7OceEBCypkwLET1fg8=;
        b=uvfKtwZ+T+jaeCOa7MNOKZfp60TG0xHw1yFeeUlABkXUrcEGJZTU9RvbFJyNAZKfJx
         dqPKTYpJuaYqQBYTlFm/Osci30S6/dforVLpqtBtApXrauErCfKDvMwKBZefyB38Fa3p
         K1XG/4EK9DNo3TgpZNW99vQiSSvqhbNy5ifvq30ceq1Rwo2mYV4/CW5dXJ5p1kJTZL7t
         tX4Zyyjmsgz8A9LrujvHVCrSWdvnnU0Fq6hxuJdybGxlu0Jx7/PTRlqY7cQaTv3TMAVD
         BzdfhBxTFCibbfKvSR4+/9VrQj+vPeH/QP6WCOXHQetQ/j+fdMA0MM40rz3lIcUchCOf
         hQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfBwc9juEmKkxkxZ+pO3/BcQV7OceEBCypkwLET1fg8=;
        b=Ts84ak5L5V0LqUHY/RT3h/0S/OwxpGRz7UqBJwleJ/5M1SaszJh737FEbrINnloqx6
         BVmNfrT72b1yJSqVAhxGHSgzToPnrvPh0BnuNnfZjDlB2IuZr7AACfOpzBP99u8R75Ak
         E8H9V9IbTdQLTvDi9BI6k5iL7VLAKeoqPE50pMEiY6mg77Crj2Vnc9bNX2y9QAhKeYt9
         MhWsd/z9xG1jCIzR2ngMVNsoWvbkvB4I1dRF87inrzkZ9Ve8yuzy4CxEHOaCohQJlOP4
         oFTnO/BMqB5XAzfqqKbxatfSh2mg6bZ6JJwJ+Yvj8I90Jl17zOtxb61wYyWb3huRicS7
         HZnA==
X-Gm-Message-State: AOAM530rCnVPGd8bHq/aHjEl2xGAH1TTkkChZDd/ooPDDd+FG6NGY+Lm
        dU5/+Gx9zSCNa2QSDyzVmJCTvA==
X-Google-Smtp-Source: ABdhPJypI7k4bXA5pHWf/48AXFmkMjvKoIOtDoMh0UHVenxHzDUzT5M1TkUPZZyd5Pv9Y3kJRSV3Jg==
X-Received: by 2002:a05:6000:143:: with SMTP id r3mr4474424wrx.357.1611941582598;
        Fri, 29 Jan 2021 09:33:02 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:33:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] soundwire: qcom: add support to new interrupts
Date:   Fri, 29 Jan 2021 17:32:48 +0000
Message-Id: <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to new interrupts and update irq routine in a way
to deal with multiple pending interrupts with in a single interrupt!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 191 ++++++++++++++++++++++++++++++---------
 1 file changed, 146 insertions(+), 45 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d61b204dc284..c699bd51d29a 100644
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
@@ -105,11 +116,8 @@ struct qcom_swrm_ctrl {
 	struct device *dev;
 	struct regmap *regmap;
 	void __iomem *mmio;
-	struct completion *comp;
 	struct completion broadcast;
 	struct work_struct slave_work;
-	/* read/write lock */
-	spinlock_t comp_lock;
 	/* Port alloc/free lock */
 	struct mutex port_lock;
 	struct mutex io_lock;
@@ -126,6 +134,7 @@ struct qcom_swrm_ctrl {
 	int rows_index;
 	unsigned long dout_port_mask;
 	unsigned long din_port_mask;
+	u32 intr_mask;
 	u8 rcmd_id;
 	u8 wcmd_id;
 	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
@@ -315,6 +324,27 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
 	return ret;
 }
 
+static int qcom_swrm_get_alert_slave(struct qcom_swrm_ctrl *ctrl)
+{
+	u32 val;
+	int i;
+
+	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
+
+	for (i = 0; i < SDW_MAX_DEVICES; i++) {
+		u32 s;
+
+		s = (val >> (i * 2));
+
+		if ((s & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
+			ctrl->status[i] = s;
+			return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 {
 	u32 val;
@@ -333,40 +363,122 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 
 static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 {
-	struct qcom_swrm_ctrl *ctrl = dev_id;
-	u32 sts, value;
-	unsigned long flags;
-
-	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
-
-	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
-		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
-		dev_err_ratelimited(ctrl->dev,
-				    "CMD error, fifo status 0x%x\n",
-				     value);
-		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
-	}
+	struct qcom_swrm_ctrl *swrm = dev_id;
+	u32 value, intr_sts, intr_sts_masked;
+	u32 i;
+	u8 devnum = 0;
+	int ret = IRQ_HANDLED;
+
+
+	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
+	intr_sts_masked = intr_sts & swrm->intr_mask;
+
+handle_irq:
+	for (i = 0; i < SWRM_INTERRUPT_MAX; i++) {
+		value = intr_sts_masked & (1 << i);
+		if (!value)
+			continue;
+
+		switch (value) {
+		case SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ:
+			devnum = qcom_swrm_get_alert_slave(swrm);
+			if (devnum < 0) {
+				dev_err_ratelimited(swrm->dev,
+				    "no slave alert found.spurious interrupt\n");
+			} else {
+				sdw_handle_slave_status(&swrm->bus, swrm->status);
+			}
 
-	if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
-	    sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
-		schedule_work(&ctrl->slave_work);
-
-	/**
-	 * clear the interrupt before complete() is called, as complete can
-	 * schedule new read/writes which require interrupts, clearing the
-	 * interrupt would avoid missing interrupts in such cases.
-	 */
-	ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);
-
-	if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED) {
-		spin_lock_irqsave(&ctrl->comp_lock, flags);
-		if (ctrl->comp)
-			complete(ctrl->comp);
-		spin_unlock_irqrestore(&ctrl->comp_lock, flags);
+			break;
+		case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
+		case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
+			dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
+				__func__);
+			qcom_swrm_get_device_status(swrm);
+			sdw_handle_slave_status(&swrm->bus, swrm->status);
+			break;
+		case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
+			dev_err_ratelimited(swrm->dev,
+					"%s: SWR bus clsh detected\n",
+					__func__);
+			swrm->intr_mask &=
+				~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
+			swrm->reg_write(swrm,
+				SWRM_INTERRUPT_CPU_EN,
+				swrm->intr_mask);
+			break;
+		case SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW:
+			swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+			dev_err_ratelimited(swrm->dev,
+				"%s: SWR read FIFO overflow fifo status 0x%x\n",
+				__func__, value);
+			break;
+		case SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW:
+			swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+			dev_err_ratelimited(swrm->dev,
+				"%s: SWR read FIFO underflow fifo status 0x%x\n",
+				__func__, value);
+			break;
+		case SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW:
+			swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+			dev_err(swrm->dev,
+				"%s: SWR write FIFO overflow fifo status %x\n",
+				__func__, value);
+			swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
+			break;
+		case SWRM_INTERRUPT_STATUS_CMD_ERROR:
+			swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+			dev_err_ratelimited(swrm->dev,
+			"%s: SWR CMD error, fifo status 0x%x, flushing fifo\n",
+					__func__, value);
+			swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
+			break;
+		case SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION:
+			dev_err_ratelimited(swrm->dev,
+					"%s: SWR Port collision detected\n",
+					__func__);
+			swrm->intr_mask &= ~SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION;
+			swrm->reg_write(swrm,
+				SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
+			break;
+		case SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH:
+			dev_err_ratelimited(swrm->dev,
+				"%s: SWR read enable valid mismatch\n",
+				__func__);
+			swrm->intr_mask &=
+				~SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH;
+			swrm->reg_write(swrm,
+				SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
+			break;
+		case SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED:
+			complete(&swrm->broadcast);
+			break;
+		case SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2:
+			break;
+		case SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2:
+			break;
+		case SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP:
+			break;
+		default:
+			dev_err_ratelimited(swrm->dev,
+					"%s: SWR unknown interrupt value: %d\n",
+					__func__, value);
+			ret = IRQ_NONE;
+			break;
+		}
 	}
+	swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, intr_sts);
+	swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, 0x0);
+
+	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
+	intr_sts_masked = intr_sts & swrm->intr_mask;
+
+	if (intr_sts_masked)
+		goto handle_irq;
 
-	return IRQ_HANDLED;
+	return ret;
 }
+
 static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 {
 	u32 val;
@@ -380,6 +492,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	/* Disable Auto enumeration */
 	ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 0);
 
+	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
 	/* Mask soundwire interrupts */
 	ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
 			SWRM_INTERRUPT_STATUS_RMSK);
@@ -615,16 +728,6 @@ static u32 qcom_swrm_freq_tbl[MAX_FREQ_NUM] = {
 	DEFAULT_CLK_FREQ,
 };
 
-static void qcom_swrm_slave_wq(struct work_struct *work)
-{
-	struct qcom_swrm_ctrl *ctrl =
-			container_of(work, struct qcom_swrm_ctrl, slave_work);
-
-	qcom_swrm_get_device_status(ctrl);
-	sdw_handle_slave_status(&ctrl->bus, ctrl->status);
-}
-
-
 static void qcom_swrm_stream_free_ports(struct qcom_swrm_ctrl *ctrl,
 					struct sdw_stream_runtime *stream)
 {
@@ -989,11 +1092,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 
 	ctrl->dev = dev;
 	dev_set_drvdata(&pdev->dev, ctrl);
-	spin_lock_init(&ctrl->comp_lock);
 	mutex_init(&ctrl->port_lock);
 	mutex_init(&ctrl->io_lock);
 	init_completion(&ctrl->broadcast);
-	INIT_WORK(&ctrl->slave_work, qcom_swrm_slave_wq);
 
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
-- 
2.21.0

