Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF7435031D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhCaPRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbhCaPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:16:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D77C0613DA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:16:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 15so24359220ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JEZ/zA3xATlZDMJU12dOWvOdzYQeAKq+WFclP2SIzc=;
        b=qbYcdm4xTGvnx8vSR5cEEzlX4QPevzbSUUiaybTSD6iZl2QMnyZPs9MgWqr/JOgHx/
         Y89Pa5oGp9XxJOiPih1dMOgzyyBsMmyDRZUraap75b5n/2Eoxu9GsMoXiGPV8nANqw/7
         B1m81EjGhxdhaWsbJnTyfUBFR7ZBEXXuavPmrfaQPioRwPv8THNg2ac2KavXcxE1KxI5
         wzzXhdsQSq64lW+0ISVjzrO/F0xNye0qvqN75wYdL2JxjvKa4ooVm3inkx8VkvRoZ6WO
         5wmzy7kYMlvY+B9N4q/5F2vEZGRufL0EFE1aV0fYuKmImfU9lYi5EeW1kn9SJn9l2W45
         91Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JEZ/zA3xATlZDMJU12dOWvOdzYQeAKq+WFclP2SIzc=;
        b=SSud/XpaoanoOYl6UaSLmCkI/IL+hNyhQwnKEWzSV9K+EVs5YOqtk/SBY7aZM4dkpn
         x04Fhbik2Tdtm2S4oU6PJtjcqXEkEpbN1XSudRoqrxPfItHkd2pDz8eJyx7dtDEgRzqE
         GpDKs7RLihHr+Gi25FEfUE2FM7pHmOIXvv2Gw4pQQCICKk6BKbsolBQwTCuEPdzNoT7U
         Xfyy8TuJbdjR+BNJK4LecvZE4zyG9eUTgzRAKGV90LfCxY6ILz1xu1k2RKWBnT/91rNF
         BvJlnXLI20kNx3cwJR7Sak6Y/l8JiNUA4xlTDcp/XQdEbjSYfgIsA3tlTIYkCWoYbjDQ
         ahHg==
X-Gm-Message-State: AOAM533zCTLFDEvjVaweoB97TMMPwW5UQEU0I0jVOCPo7O+8D3kyrUM/
        DQpErLEXTxNVy7VSmRl9MZhkSw==
X-Google-Smtp-Source: ABdhPJxGjbzLHTGBc9+lfcvVF/MyEPH9b4JssJA1P5iYqZlQ1q+9A9sPvh3G6D8K0BOGXOCwwCG7nA==
X-Received: by 2002:a2e:9b14:: with SMTP id u20mr2384835lji.463.1617203791003;
        Wed, 31 Mar 2021 08:16:31 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t201sm266738lff.70.2021.03.31.08.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:16:30 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 7/7] arm64: dts: qcom: use dp_phy to provide clocks to dispcc
Date:   Wed, 31 Mar 2021 18:16:14 +0300
Message-Id: <20210331151614.3810197-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331151614.3810197-1-dmitry.baryshkov@linaro.org>
References: <20210331151614.3810197-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plug dp_phy-provided clocks to display clock controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 0f79e6885004..a2478bd3590a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2600,8 +2600,8 @@ dispcc: clock-controller@af00000 {
 				 <&dsi0_phy 1>,
 				 <&dsi1_phy 0>,
 				 <&dsi1_phy 1>,
-				 <0>,
-				 <0>,
+				 <&dp_phy 0>,
+				 <&dp_phy 1>,
 				 <0>,
 				 <0>,
 				 <0>,
@@ -2614,8 +2614,8 @@ dispcc: clock-controller@af00000 {
 				      "dsi0_phy_pll_out_dsiclk",
 				      "dsi1_phy_pll_out_byteclk",
 				      "dsi1_phy_pll_out_dsiclk",
-				      "dp_link_clk_divsel_ten",
-				      "dp_vco_divided_clk_src_mux",
+				      "dp_phy_pll_link_clk",
+				      "dp_phy_pll_vco_div_clk",
 				      "dptx1_phy_pll_link_clk",
 				      "dptx1_phy_pll_vco_div_clk",
 				      "dptx2_phy_pll_link_clk",
-- 
2.30.2

