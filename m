Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D2540276F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbhIGK54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhIGK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:57:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43899C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:56:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v10so13774407wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 03:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jf2SWVGaNmOrOjfVQv/T4Tpx94jOzzs6milpHwoyx9I=;
        b=hBnCU/tuN3jguOyrT+1udXl5wHXyM+y4SeMQfmVECFk39N7zAPTo7oQWWFLD0o0hls
         aOhJqUwsv9h0cS4HtPAG7ryCkJwUo1e6piyDzOT5FjkMAAT/25j8u7qla4kBpuw9oE1w
         fKjqUfB9yF6Y4f6jMbpY6U6fsfrgsAkMNwq/qavoxARxOWmPcT1melIcf5rgsdj63T+f
         DgVu9f/5B/zwWFToKa1xy+M4d28EabK0oQ4kqOK1mjveVA3457k6QgX8KKmatX3tW00T
         8tL09h9rueQ5F98YThsKZHZo3EbPXF8yr8Crh4vCaXnPARIj4pf8eJ3lqdnXPvPurlOl
         HyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jf2SWVGaNmOrOjfVQv/T4Tpx94jOzzs6milpHwoyx9I=;
        b=kOgdC3djEyv+5m1wpn2VeUX7NIZ98sKtADyrzDAIcFt2yMJDBFWtVDKoG8PR1QW3l+
         1KQIh0Z72xFJrshYJxIlBaycuUjDTJuKQ3q+j3ULRHCt2LKEgNttwA5bXhYxnGOwC8YM
         MTLHF9X+ykbFoIRj8qkRFo5lR3T4xXyRQGTUzCnvzBT9xBFCBUraaBW9sEgkHz4IL/U6
         RoQLSLliIQ/rrHKvxR+hWg3Q1f27T2NNdPfJU3cukPlLOG58j9624ctB7lo+Zj4RRknz
         faTZ3l6JkwjVOQjNRrfa32MS1QbZ00MC9H3pxC2An186F8V8RZCU6ODHbG3nFegv9npx
         r/ZQ==
X-Gm-Message-State: AOAM533Vp0qX6jg87llmqcbl8pTLzsJ1XRoZsGqVqVF67cB+ag3hsdFe
        ktXAEU91Dwk6fxNLVgMZwDV7EQ==
X-Google-Smtp-Source: ABdhPJyjDIF2vdnP0upc775RB0EE3BjACLiY3q5D5UHZXXm4SR3RMHUxHSoorkMInTA1rSpoXSjEEA==
X-Received: by 2002:adf:9003:: with SMTP id h3mr17956872wrh.75.1631012207773;
        Tue, 07 Sep 2021 03:56:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v62sm2042052wme.21.2021.09.07.03.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:56:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: qcom: add debugfs entry for soundwire register dump
Date:   Tue,  7 Sep 2021 11:56:36 +0100
Message-Id: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For debug purposes add an entry in debugfs to dump Qualcomm
SoundWire Controller registers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 0ef79d60e88e..a317bea2d42d 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
@@ -83,6 +84,7 @@
 #define SWRM_DP_PORT_HCTRL_BANK(n, m)	(0x1134 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
+#define SWR_MSTR_MAX_REG_ADDR		(0x1740)
 
 #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
 #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
@@ -127,6 +129,9 @@ struct qcom_swrm_ctrl {
 	struct device *dev;
 	struct regmap *regmap;
 	void __iomem *mmio;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
 	struct completion broadcast;
 	struct completion enumeration;
 	struct work_struct slave_work;
@@ -1192,6 +1197,22 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int swrm_reg_show(struct seq_file *s_file, void *data)
+{
+	struct qcom_swrm_ctrl *swrm = s_file->private;
+	int reg, reg_val;
+
+	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
+		swrm->reg_read(swrm, reg, &reg_val);
+		seq_printf(s_file, "0x%.3x: 0x%.2x\n", reg, reg_val);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(swrm_reg);
+#endif
+
 static int qcom_swrm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1302,6 +1323,12 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
 		 ctrl->version & 0xffff);
 
+#ifdef CONFIG_DEBUG_FS
+	ctrl->debugfs = debugfs_create_dir("qualcomm-sdw", ctrl->bus.debugfs);
+	debugfs_create_file("qualcomm-registers", 0400, ctrl->debugfs, ctrl,
+			    &swrm_reg_fops);
+#endif
+
 	return 0;
 
 err_master_add:
-- 
2.21.0

