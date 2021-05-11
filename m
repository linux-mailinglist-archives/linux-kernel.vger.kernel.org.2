Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEEA379E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhEKESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKESa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:18:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9DCC061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:17:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n184so17835831oia.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvC5nf7k+zrK5xWC4RDKTwoK+EY80CWdjHtrEnmOMoE=;
        b=q0tsCRjFghXORwNbjdqUGRBvoO1woiRrfKvI4/Ex5IY3XtemQkhdq1cpeNwWTwstpd
         00aUKnOGwv7hqL+3gphyC6GOCvBtHwrj5+EqQqWfd6FXkjc/4luFzX7AQ9X0mxOwDarP
         FynZp5vkMRK/EJ3PNtXuAqco/Hu/aXdpWtBB+MmfmseXv1cX2RXCN/DPYSykv9GYaT6e
         REw8tsQ5XoaS1DAqxx13m06kE01EKKxdM3pKa0+6TiZqxZD9hgAT5I6Uv7tEtcmetsCE
         yyiyaqz9XPaMOQNVHZXvaVb407CjWE4FYRcRrlR/8iPdQVrnOaJYcY5jFVqo5qgI0JPo
         Chng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YvC5nf7k+zrK5xWC4RDKTwoK+EY80CWdjHtrEnmOMoE=;
        b=FUUV1W//UJ1aIVoXXZXeK2mSmximeR0+Ow8WKToBswXx3ytmRRRGefE2tdfyMrImWt
         e1e0JzpAlsnYhRMYktIgefVgyDevNxJ4sfPsGkDrHzwNxQXrpouO6y8wu5wxFo1AUtJI
         LrG+9ct8zgnKqm1BHFR50T7XAWhu4UU2I4RnmkybtO3IDRpKegugiyBu4UZdE0GLOiXL
         jF+K0oyiKlrEcDV6PimEe6objOlAqB7EsvOpRQf8Eu2XSlRvuzpl4nVt2Vw2iXY4aUtY
         6oGlse2UQcQ1YU61JSDpuX41GaFMpGWk3tXY7ZGzjK0pI2lXZTT9okUokiGWllcL4QtJ
         C2eQ==
X-Gm-Message-State: AOAM532anKkKyKy3VsfDC7lsQcgpqALaazqlMTyezUBioRhFHl9XBkj8
        KOVBIw9j6xQAMrFHzDGaJexj4A==
X-Google-Smtp-Source: ABdhPJx6KSP5d9a5oHmEKCqxtRP1plW7IDaQtDhXQyrc537PKVx8NrelBd+Suas4TNYEuITlIshdUA==
X-Received: by 2002:aca:da04:: with SMTP id r4mr1974968oig.123.1620706642271;
        Mon, 10 May 2021 21:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:e623:42c1:10df:adff:fec2:f1d])
        by smtp.gmail.com with ESMTPSA id v79sm1367168oia.14.2021.05.10.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:17:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: qcom: dispcc-sm8250: Add sc8180x support
Date:   Mon, 10 May 2021 23:17:18 -0500
Message-Id: <20210511041719.591969-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display clock controller in SC8180x is reused from SM8150, so add
the necessary compatible and wire up the driver to enable this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml         | 1 +
 drivers/clk/qcom/dispcc-sm8250.c                              | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 0cdf53f41f84..6667261dc665 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -20,6 +20,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,sc8180x-dispcc
       - qcom,sm8150-dispcc
       - qcom,sm8250-dispcc
 
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index de09cd5c209f..12ef6f1d5c62 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1037,6 +1037,7 @@ static const struct qcom_cc_desc disp_cc_sm8250_desc = {
 };
 
 static const struct of_device_id disp_cc_sm8250_match_table[] = {
+	{ .compatible = "qcom,sc8180x-dispcc" },
 	{ .compatible = "qcom,sm8150-dispcc" },
 	{ .compatible = "qcom,sm8250-dispcc" },
 	{ }
@@ -1053,7 +1054,8 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 
 	/* note: trion == lucid, except for the prepare() op */
 	BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8150-dispcc")) {
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8180x-dispcc") ||
+	    of_device_is_compatible(pdev->dev.of_node, "qcom,sm8150-dispcc")) {
 		disp_cc_pll0_config.config_ctl_hi_val = 0x00002267;
 		disp_cc_pll0_config.config_ctl_hi1_val = 0x00000024;
 		disp_cc_pll0_config.user_ctl_hi1_val = 0x000000D0;
-- 
2.29.2

