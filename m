Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2DA338C39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhCLMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhCLMAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:00:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAFFC061763
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v4so1622788wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McMRGa+k2wYhi+9vmCrUwcgebhPfYzfC04NyJL/Hc1k=;
        b=n9tFVto6RRq8v6s1Rub2Qm0ophWbFgmh9Ud/YccjDR3kMoMIcuXtN4PuH9bDyb4Ez5
         z92NLQrilIoMeI++fWg+xbzTYOL+3dtmXjnr17qt748thtz1RIHlaWCcchsjBtDUUndh
         QRTzZ1ABy9K8LFdZzwGcZJ/aQ9l7l26zg3R5KR8XZN8GGvihSP4N3TUILQo6ffOQKiiF
         dA2MQRu5KGVbreOncoqYELOWlS565l8lO0LOEnNazdq9eVFwccXEXXE+gCl/OLL+jC7X
         cYNFR3w4oz6xh5f700LqhTXiZSGSav+0lJMIEiN5Tj8v4ssaKTo7vs3Y/emepHljblnA
         mHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McMRGa+k2wYhi+9vmCrUwcgebhPfYzfC04NyJL/Hc1k=;
        b=dx+DZnyVRDTOjf8wYAu48mXYUhEVLSGMNqjbobWNcb+dvA8HIq2hu+VFXrGGgmwr57
         DgSXqBX2Go75uUU9tTnl8EL7oye6oRQKmM0iWlwZB0mnTdCWPDA16xXcQK6mbrEDsTzL
         oxtwIGWZOt8HhlhDaXS/CZ7XbhmhUT9gi6oyAZ0glqxWLXKYxESz6NNqMcoIxmHm8k5X
         eLeTxblLW8ClKR1ZrApXx62aeu2W+hhxfliYVzctqpHQbL+8qFXCvxoFFA8LIgp1JjOQ
         e8zYINyBglpQae/8U2+mv81eX1/PbTN5oEbY6F5D2gHkD5oZHKGHOpn85meceacnHm9y
         HZoA==
X-Gm-Message-State: AOAM5333hW8XWmT3IsLCbuo9k87J0W0JErI9l5wNNTEojNhRdrdtCfHL
        yvMInlwOUBSjMJkdfbVpoNn9EQ==
X-Google-Smtp-Source: ABdhPJxy6BPF9ppF0+7adLNIuGg8jfai0L0+HSnffGPxpIRZcI9SbnLRWQgLRcl95vbG5E0nL9oZ0A==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr13343571wrq.339.1615550431803;
        Fri, 12 Mar 2021 04:00:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h25sm2268315wml.32.2021.03.12.04.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:00:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 8/9] soundwire: qcom: add auto enumeration support
Date:   Fri, 12 Mar 2021 12:00:08 +0000
Message-Id: <20210312120009.22386-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SoundWire controller supports Auto Enumeration of the
devices within the IP. This patch enables support for this feature.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 86 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6a563fb52444..c6c923329b15 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -57,6 +57,8 @@
 #define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
 #define SWRM_RD_FIFO_CMD_ID_MASK				GENMASK(11, 8)
 #define SWRM_ENUMERATOR_CFG_ADDR				0x500
+#define SWRM_ENUMERATOR_SLAVE_DEV_ID_1(m)		(0x530 + 0x8 * (m))
+#define SWRM_ENUMERATOR_SLAVE_DEV_ID_2(m)		(0x534 + 0x8 * (m))
 #define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
 #define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
 #define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK			GENMASK(7, 3)
@@ -143,6 +145,7 @@ struct qcom_swrm_ctrl {
 	enum sdw_slave_status status[SDW_MAX_DEVICES];
 	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
 	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
+	u32 slave_status;
 };
 
 struct qcom_swrm_data {
@@ -342,6 +345,7 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 	int i;
 
 	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
+	ctrl->slave_status = val;
 
 	for (i = 0; i < SDW_MAX_DEVICES; i++) {
 		u32 s;
@@ -352,10 +356,74 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
 	}
 }
 
+static void qcom_swrm_set_slave_dev_num(struct sdw_bus *bus,
+					struct sdw_slave *slave, int devnum)
+{
+	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
+	u32 status;
+
+	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &status);
+	status = (status >> (devnum * SWRM_MCP_SLV_STATUS_SZ));
+	status &= SWRM_MCP_SLV_STATUS_MASK;
+
+	if (status == SDW_SLAVE_ATTACHED) {
+		if (slave)
+			slave->dev_num = devnum;
+		mutex_lock(&bus->bus_lock);
+		set_bit(devnum, bus->assigned);
+		mutex_unlock(&bus->bus_lock);
+	}
+}
+
+static int qcom_swrm_enumerate(struct sdw_bus *bus)
+{
+	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
+	struct sdw_slave *slave, *_s;
+	struct sdw_slave_id id;
+	u32 val1, val2;
+	bool found;
+	u64 addr;
+	int i;
+	char *buf1 = (char *)&val1, *buf2 = (char *)&val2;
+
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+		/*SCP_Devid5 - Devid 4*/
+		ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_1(i), &val1);
+
+		/*SCP_Devid3 - DevId 2 Devid 1 Devid 0*/
+		ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_2(i), &val2);
+
+		if (!val1 && !val2)
+			break;
+
+		addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
+			((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
+			((u64)buf1[0] << 40);
+
+		sdw_extract_slave_id(bus, addr, &id);
+		found = false;
+		/* Now compare with entries */
+		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
+			if (sdw_compare_devid(slave, id) == 0) {
+				qcom_swrm_set_slave_dev_num(bus, slave, i);
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			qcom_swrm_set_slave_dev_num(bus, NULL, i);
+			sdw_slave_add(bus, &id, NULL);
+		}
+	}
+
+	return 0;
+}
+
 static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 {
 	struct qcom_swrm_ctrl *swrm = dev_id;
-	u32 value, intr_sts, intr_sts_masked;
+	u32 value, intr_sts, intr_sts_masked, slave_status;
 	u32 i;
 	u8 devnum = 0;
 	int ret = IRQ_HANDLED;
@@ -384,8 +452,15 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
 				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
 					__func__);
-				qcom_swrm_get_device_status(swrm);
-				sdw_handle_slave_status(&swrm->bus, swrm->status);
+				swrm->reg_read(swrm, SWRM_MCP_SLV_STATUS, &slave_status);
+				if (swrm->slave_status == slave_status) {
+					dev_err(swrm->dev, "Slave status not changed %x\n",
+						slave_status);
+				} else {
+					qcom_swrm_get_device_status(swrm);
+					qcom_swrm_enumerate(&swrm->bus);
+					sdw_handle_slave_status(&swrm->bus, swrm->status);
+				}
 				break;
 			case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
 				dev_err_ratelimited(swrm->dev,
@@ -472,8 +547,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
-	/* Disable Auto enumeration */
-	ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 0);
+	/* Enable Auto enumeration */
+	ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 1);
 
 	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
 	/* Mask soundwire interrupts */
@@ -507,6 +582,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN,
 				SWRM_INTERRUPT_STATUS_RMSK);
 	}
+	ctrl->slave_status = 0;
 	return 0;
 }
 
-- 
2.21.0

