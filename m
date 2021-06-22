Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FEE3B0719
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhFVOOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhFVONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:13:50 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD439C061787;
        Tue, 22 Jun 2021 07:11:29 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E3D961FAF2;
        Tue, 22 Jun 2021 16:11:27 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        robh+dt@kernel.org, stephan@gerhold.net,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v7 4/5] soc: qcom: spm: Add compatible for MSM8998 SAWv4.1 L2
Date:   Tue, 22 Jun 2021 16:11:16 +0200
Message-Id: <20210622141117.358893-5-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622141117.358893-1-angelogioacchino.delregno@somainline.org>
References: <20210622141117.358893-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SAWv4.1 parameters for MSM8998's Gold and Silver clusters.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/soc/qcom/spm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 1401db8373dd..8077e337ee7e 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -54,6 +54,18 @@ static const struct spm_reg_data spm_reg_660_silver_l2  = {
 	.avs_limit = 0x4580458,
 };
 
+static const struct spm_reg_data spm_reg_8998_gold_l2  = {
+	.reg_offset = spm_reg_offset_v4_1,
+	.avs_ctl = 0x1010031,
+	.avs_limit = 0x4700470,
+};
+
+static const struct spm_reg_data spm_reg_8998_silver_l2  = {
+	.reg_offset = spm_reg_offset_v4_1,
+	.avs_ctl = 0x1010031,
+	.avs_limit = 0x4200420,
+};
+
 static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x30,
@@ -149,6 +161,10 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_660_gold_l2 },
 	{ .compatible = "qcom,sdm660-silver-saw2-v4.1-l2",
 	  .data = &spm_reg_660_silver_l2 },
+	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
+	  .data = &spm_reg_8998_gold_l2 },
+	{ .compatible = "qcom,msm8998-silver-saw2-v4.1-l2",
+	  .data = &spm_reg_8998_silver_l2 },
 	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
-- 
2.32.0

