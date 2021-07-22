Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150493D1C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 05:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGVC2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhGVC2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:28:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF5C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 20:09:22 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id h9so5151373oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRxzdd2cU7TP9bQqkyvQP8mNDhcOMiq0kQRkrXwpMGA=;
        b=TXmr/lgi204QkWG+FfHEX0vyriVt1FZRxWyDpqRqBBz79fVsD+ov/vOCkb/OM0ew7x
         BqnljLROkw9X90VtrP8cJbTNGzvsWpEVRQtgBZacB7j+le0LPXH3fE88KzL+zBBwehmc
         /Mf8lQvkMowAe25kBVoC4Bs9K4sJFz9vVE+/xFROPVezM1wbfe5LJUtasHo5hENZ9yGd
         ezvp8GoVaQGx8Syd+SDHjJ2VG0gZcjCSlYRMg47S+ksVp7rcTpfmzd8FSX4gnRSdHOum
         iA+6wf/ELim3n81a7+yry7F2YhqIFTPpiZTJ2FWKINrA1YcDuk3MaWElmu9nBb+GepWu
         eFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRxzdd2cU7TP9bQqkyvQP8mNDhcOMiq0kQRkrXwpMGA=;
        b=k3Kd3WN0h5cwTSmN9QW1pWg1xVlkdHmoTCTzyYO9ih/vcHC72f2FzvNJyDKmNKDkZC
         5YembMS4kUPY7KKTabNCX4irxThQM2XKUbRfDwAyIYlQPNgE0yFiiBNmmbBovRlzHhDd
         Xt0IDlyx1fTAiSkEl4d8zF29xEzkRsX2kcKJJE6l9W56+5sRAFYdWh04oWn9vSXEC2qK
         uDv/DfdSB8d8wvgBfm8/gZEbm/+PEIfF0osk1XS6wtERP13Px7ngVRH6kWWUvLKe4GEi
         //ZR0+CZnBt0FPql+5c9MStYln70DgKr3x6L9kX9wAKyFPT7sn7T4KkzNoJnve/zjCTX
         aI2A==
X-Gm-Message-State: AOAM5312wUsqhUiaaLtNNAMSy+9vixkeXIU98K5MbLpZy4gqfffcrYRq
        7U93BpuQyVwwHeve1kb7zyxqbA==
X-Google-Smtp-Source: ABdhPJyiHR6tqUP1L+4umx32f2vdjjcDm0+i3iT+RDo7C7N7HBVCkOR23PEO5rdRPJO+jJ8+eGy4+Q==
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr4346676oib.15.1626923361903;
        Wed, 21 Jul 2021 20:09:21 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v11sm2488909ott.68.2021.07.21.20.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 20:09:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: qmp: Provide unique clock names for DP clocks
Date:   Wed, 21 Jul 2021 20:07:38 -0700
Message-Id: <20210722030738.3385821-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB/DP combo PHY exposes the "qmp_dp_phy_pll_link_clk" and
"qmp_dp_phy_pll_vco_div_clk" clocks, that are consumed by the display
clock controller. But for boards with multiple enabled QMP USB/DP combo
instances the hard coded names collides - and hence only the first
probed device is allowed to register.

Given that clocks are no longer reference globally by name and it's
possible to replace the hard coded names by something unique, but still
user friendly.

The two new clock names are based on dev_name() and results in names
such as "88ee000.phy::link_clk" and "88ee000.phy::vco_div_clk".

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index b7f2e36d7960..61707d99a9eb 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -5213,6 +5213,7 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 {
 	struct clk_init_data init = { };
 	struct qmp_phy_dp_clks *dp_clks;
+	char name[64];
 	int ret;
 
 	dp_clks = devm_kzalloc(qmp->dev, sizeof(*dp_clks), GFP_KERNEL);
@@ -5222,15 +5223,17 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 	dp_clks->qphy = qphy;
 	qphy->dp_clks = dp_clks;
 
+	snprintf(name, sizeof(name), "%s::link_clk", dev_name(qmp->dev));
 	init.ops = &qcom_qmp_dp_link_clk_ops;
-	init.name = "qmp_dp_phy_pll_link_clk";
+	init.name = name;
 	dp_clks->dp_link_hw.init = &init;
 	ret = devm_clk_hw_register(qmp->dev, &dp_clks->dp_link_hw);
 	if (ret)
 		return ret;
 
+	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(qmp->dev));
 	init.ops = &qcom_qmp_dp_pixel_clk_ops;
-	init.name = "qmp_dp_phy_pll_vco_div_clk";
+	init.name = name;
 	dp_clks->dp_pixel_hw.init = &init;
 	ret = devm_clk_hw_register(qmp->dev, &dp_clks->dp_pixel_hw);
 	if (ret)
-- 
2.29.2

