Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD5310A50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBELdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:33:15 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:31757 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhBELaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:30:09 -0500
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 05 Feb 2021 03:29:18 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Feb 2021 03:29:16 -0800
X-QCInternal: smtphost
Received: from c-rbokka-linux.qualcomm.com ([10.206.24.149])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Feb 2021 16:58:58 +0530
Received: by c-rbokka-linux.qualcomm.com (Postfix, from userid 203305)
        id 1AEAC3416; Fri,  5 Feb 2021 16:58:57 +0530 (IST)
From:   Ravi Kumar Bokka <rbokka@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>
Subject: [PATCH] drivers: nvmem: Fix voltage settings for QTI qfprom-efuse
Date:   Fri,  5 Feb 2021 16:58:52 +0530
Message-Id: <1612524533-3970-1-git-send-email-rbokka@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QFPROM controller hardware requires 1.8V min for fuse blowing.
So, this change sets the voltage to 1.8V, required to blow the fuse
for qfprom-efuse controller.

To disable fuse blowing, we set the voltage to 0V since this may
be a shared rail and may be able to run at a lower rate when we're
not blowing fuses.

Fixes: 93b4e49f8c86 ("nvmem: qfprom: Add fuse blowing support")
Reported-by: Douglas Anderson <dianders@chromium.org>
Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
---
 drivers/nvmem/qfprom.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 6cace24..100d69d 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -127,6 +127,16 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
 {
 	int ret;
 
+	/*
+	 * This may be a shared rail and may be able to run at a lower rate
+	 * when we're not blowing fuses.  At the moment, the regulator framework
+	 * applies voltage constraints even on disabled rails, so remove our
+	 * constraints and allow the rail to be adjusted by other users.
+	 */
+	ret = regulator_set_voltage(priv->vcc, 0, INT_MAX);
+	if (ret)
+		dev_warn(priv->dev, "Failed to set 0 voltage (ignoring)\n");
+
 	ret = regulator_disable(priv->vcc);
 	if (ret)
 		dev_warn(priv->dev, "Failed to disable regulator (ignoring)\n");
@@ -172,6 +182,17 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 		goto err_clk_prepared;
 	}
 
+	/*
+	 * Hardware requires 1.8V min for fuse blowing; this may be
+	 * a rail shared do don't specify a max--regulator constraints
+	 * will handle.
+	 */
+	ret = regulator_set_voltage(priv->vcc, 1800000, INT_MAX);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set 1.8 voltage\n");
+		goto err_clk_rate_set;
+	}
+
 	ret = regulator_enable(priv->vcc);
 	if (ret) {
 		dev_err(priv->dev, "Failed to enable regulator\n");
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

