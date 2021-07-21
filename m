Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3240C3D1A00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGUWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhGUWOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:14:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E45C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:55:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso3621771otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIA/EHvm8TMC4nrq8jGhCGqjd/LXVCmlR0jUUrUwOI4=;
        b=gTOs/tdnGF3XjKpo9idP+49jKV0q8Jr5s7xrA3gYJC+uXy7B829NWRtUcB4SjYhK7s
         UmSVIQgvRP1DB49wIBXIFd7CaqkKBH07bZdVH1ViIGaaUcvxjsScTLeX2hFaRvXOfX2v
         EB9JQp73aOgo7KTcaffcJMZy/1T6RVhA3KhSATxMgXgndOp0xHgaJhgy9UhmqNVTknja
         5NYcNf2fvfk+/ZrdIYQcpox/PrQmG7oVF4ywnSMmnzLYsVM+P0A82/YIJP8SnxGc/CG8
         znReYiaisIMs4W84ky7dnwH0w7tthS5vPB1RkZQF9asApBZrvmlkp7ggyixc4T9jTHQR
         kT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIA/EHvm8TMC4nrq8jGhCGqjd/LXVCmlR0jUUrUwOI4=;
        b=W2Zk05AXiDTUtOrMC/fD7RxIhFYT6BKTQDI2dnh1KuAIWEd/Qg8zdzk1MFcmCTpUaQ
         jLfjHzUtpp+tqXwNl5EFHCeGaqDPatQQTrjznxbfdj4YVlPcGIaKECIrFODx0TYbADUI
         3t4qaI1M9/VSWt1f6GIL4Wh/Z8vcUcNpws5jvQ+KyHv28RomAs5T0WuuL+XO6ihAJcHD
         4IrPUbaTTelU5YHHbE9uGUFY4/cf1f/61/wn907XgNRBYBUu6XZBTo2wh4yIS0Uq5Iim
         fj+t1x+QrpM2+dBuIVtWHuWho+3uvDVSqiM413+PUPVMHfJWsJlfyIB0Hf8KqPx36euq
         BxCw==
X-Gm-Message-State: AOAM533+bRIF6XX45w5AiiNDHJD0XLhBpuK0Q1tP/Cuu7Y+GQyErp+Ag
        FC9zDlpOKhJdKDhe+4BpxIIecg==
X-Google-Smtp-Source: ABdhPJwMdPwHdIYBYupYN7Bf5LE9lgc7SeB7rYsb5W5+ba9lt360naitGnb46WrGtsEIwf7f7NItow==
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr15351559otr.186.1626908112143;
        Wed, 21 Jul 2021 15:55:12 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w24sm4960010otp.28.2021.07.21.15.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:55:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gpucc-sm8150: Add SC8180x support
Date:   Wed, 21 Jul 2021 15:53:29 -0700
Message-Id: <20210721225329.3035779-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU clock controller found in SC8180x is a variant of the same block
found in SM8150, but with one additional clock frequency for the
gmu_clk_src clock.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml        |  1 +
 drivers/clk/qcom/gpucc-sm8150.c                      | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index ecfe21284073..46dff46d5760 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -26,6 +26,7 @@ properties:
       - qcom,sdm845-gpucc
       - qcom,sc7180-gpucc
       - qcom,sc7280-gpucc
+      - qcom,sc8180x-gpucc
       - qcom,sm8150-gpucc
       - qcom,sm8250-gpucc
 
diff --git a/drivers/clk/qcom/gpucc-sm8150.c b/drivers/clk/qcom/gpucc-sm8150.c
index 80fb6f73601d..8422fd047493 100644
--- a/drivers/clk/qcom/gpucc-sm8150.c
+++ b/drivers/clk/qcom/gpucc-sm8150.c
@@ -82,6 +82,14 @@ static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src_sc8180x[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN_DIV, 1.5, 0, 0),
+	F(400000000, P_GPLL0_OUT_MAIN, 1.5, 0, 0),
+	F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 	.cmd_rcgr = 0x1120,
 	.mnd_width = 0,
@@ -277,6 +285,7 @@ static const struct qcom_cc_desc gpu_cc_sm8150_desc = {
 };
 
 static const struct of_device_id gpu_cc_sm8150_match_table[] = {
+	{ .compatible = "qcom,sc8180x-gpucc" },
 	{ .compatible = "qcom,sm8150-gpucc" },
 	{ }
 };
@@ -290,6 +299,9 @@ static int gpu_cc_sm8150_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8180x-gpucc"))
+		gpu_cc_gmu_clk_src.freq_tbl = ftbl_gpu_cc_gmu_clk_src_sc8180x;
+
 	clk_trion_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sm8150_desc, regmap);
-- 
2.29.2

