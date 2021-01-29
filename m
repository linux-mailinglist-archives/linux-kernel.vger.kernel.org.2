Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B84308BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhA2RoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhA2RdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:33:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B9CC061794
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:33:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z16so5132831wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fQnIeDdTUxBAr6l3vp1ORx9UuoQYgPBVBZK73OUIcY=;
        b=NhwCVNm5d5wkapM7WXyCslt4uHsCJMfHIkh2N6ZPD7Kiz43VjFTUJ3WGoDUrbOSM40
         TSNuUKp360IRtT4NgLnvPOVBk/qGz0Bh+MV8st5BjeL0tjsX69eYzTdlRo8VAjCdHjSf
         hbODNeqKx7R2W3it+CpPh2pgM7CPeI60RpZ04QkI5kS5XH5lQImoAFAQZreIpbCxKKf9
         VAI/GnNYr+64XAyFiSqaag1QSsaQ0HKAzSESOS3mzmp2YV2O5XYa93M6TDVr12PzGfuB
         Jh9UWTV7fFHTsD7Z9N8tWfrakGYdrunlOce0VBx284pyDyTu7okENSXGHvuUJSSjmspK
         vvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fQnIeDdTUxBAr6l3vp1ORx9UuoQYgPBVBZK73OUIcY=;
        b=LMt8YklSNj2h59HmtWXU+g0usM++I12VmIwOlsVYM85zK88mNdV9hJoyadDDEvX0H1
         NL6PM8+J46XrevamPzvD5XaBHts8ggOMk+tOBjeieAXdLgHwN4AaOvCXOagoHOJuFqVH
         ZUShfA0iqWclY950qgf4g6I5tYMT6+jfxKtrySGv+RKSATZY9A6aPiLdTNDS70ORYXOB
         y73c6Zt+ep6pPIAS/AtQh6pUcBmEehhWTQ1tzQXQSHl9TJC75i0Ayg4S8RnWcgqa2Hwn
         8DV6NI1NBKPNOtuMt3/iY5RxApSUIkIjoJf/ObhL04ezwchM92oWEsjwl1xOYrPQV2B+
         5tkA==
X-Gm-Message-State: AOAM5317c1tKmNNx1T1QFLhgzoSHEhpBwus7hnJaZrCdrNUngPuWEPUy
        klrKAiTe7s1Q/FrliCBzCk18+A==
X-Google-Smtp-Source: ABdhPJxYDdAfu3AvEMBvcxDmX8dssE8w3/ONknTq2dkpwIBGWAy7AuRBT27Ja7UI48fEW8OT+JJbFw==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr90633wmc.27.1611941581207;
        Fri, 29 Jan 2021 09:33:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:33:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] soundwire: qcom: update register read/write routine
Date:   Fri, 29 Jan 2021 17:32:47 +0000
Message-Id: <20210129173248.5941-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the existing code every soundwire register read and register write
are kinda blocked. Each of these are using a special command id that
generates interrupt after it successfully finishes. This is really
overhead, limiting and not really necessary unless we are doing
something special.

We can simply read/write the fifo that should also give exactly
what we need! This will also allow to read/write registers in
interrupt context, which was not possible with the special
command approach.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 148 +++++++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 52 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 83df15d83935..d61b204dc284 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -78,13 +78,15 @@
 #define SWRM_SPECIAL_CMD_ID	0xF
 #define MAX_FREQ_NUM		1
 #define TIMEOUT_MS		(2 * HZ)
-#define QCOM_SWRM_MAX_RD_LEN	0xf
+#define QCOM_SWRM_MAX_RD_LEN	0x1
 #define QCOM_SDW_MAX_PORTS	14
 #define DEFAULT_CLK_FREQ	9600000
 #define SWRM_MAX_DAIS		0xF
 #define SWR_INVALID_PARAM 0xFF
 #define SWR_HSTOP_MAX_VAL 0xF
 #define SWR_HSTART_MIN_VAL 0x0
+#define SWR_BROADCAST_CMD_ID    0x0F
+#define MAX_FIFO_RD_FAIL_RETRY 3
 
 struct qcom_swrm_port_config {
 	u8 si;
@@ -104,11 +106,13 @@ struct qcom_swrm_ctrl {
 	struct regmap *regmap;
 	void __iomem *mmio;
 	struct completion *comp;
+	struct completion broadcast;
 	struct work_struct slave_work;
 	/* read/write lock */
 	spinlock_t comp_lock;
 	/* Port alloc/free lock */
 	struct mutex port_lock;
+	struct mutex io_lock;
 	struct clk *hclk;
 	u8 wr_cmd_id;
 	u8 rd_cmd_id;
@@ -122,6 +126,8 @@ struct qcom_swrm_ctrl {
 	int rows_index;
 	unsigned long dout_port_mask;
 	unsigned long din_port_mask;
+	u8 rcmd_id;
+	u8 wcmd_id;
 	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
 	struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
 	enum sdw_slave_status status[SDW_MAX_DEVICES];
@@ -200,75 +206,111 @@ static int qcom_swrm_cpu_reg_write(struct qcom_swrm_ctrl *ctrl, int reg,
 	return SDW_CMD_OK;
 }
 
-static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
-				     u8 dev_addr, u16 reg_addr)
+static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
+				 u8 dev_addr, u16 reg_addr)
 {
-	DECLARE_COMPLETION_ONSTACK(comp);
-	unsigned long flags;
 	u32 val;
-	int ret;
-
-	spin_lock_irqsave(&ctrl->comp_lock, flags);
-	ctrl->comp = &comp;
-	spin_unlock_irqrestore(&ctrl->comp_lock, flags);
-	val = SWRM_REG_VAL_PACK(cmd_data, dev_addr,
-				SWRM_SPECIAL_CMD_ID, reg_addr);
-	ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
-	if (ret)
-		goto err;
-
-	ret = wait_for_completion_timeout(ctrl->comp,
-					  msecs_to_jiffies(TIMEOUT_MS));
+	u8 id = *cmd_id;
 
-	if (!ret)
-		ret = SDW_CMD_IGNORED;
-	else
-		ret = SDW_CMD_OK;
-err:
-	spin_lock_irqsave(&ctrl->comp_lock, flags);
-	ctrl->comp = NULL;
-	spin_unlock_irqrestore(&ctrl->comp_lock, flags);
+	if (id != SWR_BROADCAST_CMD_ID) {
+		if (id < 14)
+			id += 1;
+		else
+			id = 0;
+		*cmd_id = id;
+	}
+	val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, id, reg_addr);
 
-	return ret;
+	return val;
 }
 
-static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
-				     u8 dev_addr, u16 reg_addr,
-				     u32 len, u8 *rval)
+
+static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
+				     u8 dev_addr, u16 reg_addr)
 {
-	int i, ret;
+
 	u32 val;
-	DECLARE_COMPLETION_ONSTACK(comp);
-	unsigned long flags;
+	int ret = 0;
+	u8 cmd_id = 0x0;
+
+	mutex_lock(&swrm->io_lock);
+	if (dev_addr == SDW_BROADCAST_DEV_NUM) {
+		cmd_id = SWR_BROADCAST_CMD_ID;
+		val = swrm_get_packed_reg_val(&cmd_id, cmd_data,
+					      dev_addr, reg_addr);
+	} else {
+		val = swrm_get_packed_reg_val(&swrm->wcmd_id, cmd_data,
+					      dev_addr, reg_addr);
+	}
 
-	spin_lock_irqsave(&ctrl->comp_lock, flags);
-	ctrl->comp = &comp;
-	spin_unlock_irqrestore(&ctrl->comp_lock, flags);
+	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
 
-	val = SWRM_REG_VAL_PACK(len, dev_addr, SWRM_SPECIAL_CMD_ID, reg_addr);
-	ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
-	if (ret)
-		goto err;
+	/* version 1.3 or less */
+	if (swrm->version_major == 1 && swrm->version_minor <= 3)
+		usleep_range(150, 155);
 
-	ret = wait_for_completion_timeout(ctrl->comp,
-					  msecs_to_jiffies(TIMEOUT_MS));
+	if (cmd_id == SWR_BROADCAST_CMD_ID) {
+		/*
+		 * sleep for 10ms for MSM soundwire variant to allow broadcast
+		 * command to complete.
+		 */
+		ret = wait_for_completion_timeout(&swrm->broadcast, (2 * HZ/10));
+		if (!ret)
+			ret = SDW_CMD_IGNORED;
+		else
+			ret = SDW_CMD_OK;
 
-	if (!ret) {
-		ret = SDW_CMD_IGNORED;
-		goto err;
 	} else {
 		ret = SDW_CMD_OK;
 	}
+	mutex_unlock(&swrm->io_lock);
+	return ret;
+}
 
-	for (i = 0; i < len; i++) {
-		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_RD_FIFO_ADDR, &val);
-		rval[i] = val & 0xFF;
+static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
+				     u8 dev_addr, u16 reg_addr,
+				     u32 len, u8 *rval)
+{
+	u32 val;
+	u32 retry_attempt = 0;
+	u32 cmd_data;
+	int ret = SDW_CMD_OK;
+
+	mutex_lock(&swrm->io_lock);
+	val = swrm_get_packed_reg_val(&swrm->rcmd_id, len, dev_addr, reg_addr);
+
+	/* wait for FIFO RD to complete to avoid overflow */
+	usleep_range(100, 105);
+	swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
+	/* wait for FIFO RD CMD complete to avoid overflow */
+	usleep_range(250, 255);
+
+retry_read:
+
+	swrm->reg_read(swrm, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
+	rval[0] = cmd_data & 0xFF;
+
+	if ((((cmd_data) & 0xF00) >> 8) != swrm->rcmd_id) {
+		if (retry_attempt < MAX_FIFO_RD_FAIL_RETRY) {
+			/* wait 500 us before retry on fifo read failure */
+			usleep_range(500, 505);
+			if (retry_attempt == (MAX_FIFO_RD_FAIL_RETRY - 1)) {
+				swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
+				swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
+			}
+			retry_attempt++;
+			goto retry_read;
+		} else {
+			dev_err(swrm->dev,
+					"failed to read fifo: reg: 0x%x, \
+					rcmd_id: 0x%x, dev_num: 0x%x, cmd_data: 0x%x\n",
+					reg_addr, swrm->rcmd_id,
+					dev_addr, cmd_data);
+			ret = SDW_CMD_IGNORED;
+		}
 	}
 
-err:
-	spin_lock_irqsave(&ctrl->comp_lock, flags);
-	ctrl->comp = NULL;
-	spin_unlock_irqrestore(&ctrl->comp_lock, flags);
+	mutex_unlock(&swrm->io_lock);
 
 	return ret;
 }
@@ -949,6 +991,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ctrl);
 	spin_lock_init(&ctrl->comp_lock);
 	mutex_init(&ctrl->port_lock);
+	mutex_init(&ctrl->io_lock);
+	init_completion(&ctrl->broadcast);
 	INIT_WORK(&ctrl->slave_work, qcom_swrm_slave_wq);
 
 	ctrl->bus.ops = &qcom_swrm_ops;
-- 
2.21.0

