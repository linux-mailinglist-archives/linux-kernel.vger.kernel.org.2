Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA6334AE2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhCZR6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCZR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:58:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575C8C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:58:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g8so8879181lfv.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vt2EBjJBXCElMumS8zwBKc0QOehEP6EtoAAqvcQaqEs=;
        b=L5k5ZD1GMn27mDy/vZZPUgLF4ydicHrGp4908/9nbYRzIHWiNrUUXJaD2Kkm4XI/z8
         BpwQdY9oErV/AEhTTJbPJ93scCAQy0p+LHE0UjWaWdI2geHuxs7Jn5+IX/nqYyaPJN9h
         APaQrnxRW8FKuR1plRwLYV3aE9P7FuEtknF/k9ur39MXuIzaRJZdn+QzGJcuHaEDszMc
         vVmRwOjpt/mS/Pj3HAZ9K+qE6jJB/0S8yYUXOmddgqcfHAeLT6gZb/wDPGVLx1wJ1bTP
         Jz7yaG5+Jxh2FjgF/2yp4Y6Np4nQDz3OLYL5czYMyMc0er5xt7SnloXh31onwCIqpqFz
         1LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vt2EBjJBXCElMumS8zwBKc0QOehEP6EtoAAqvcQaqEs=;
        b=tXpa484xnNIkdraRvz/ygFzEPbcGGXHlZ9tcsyzn6G3PyCCmMT23a8naeZxl5MphxX
         kKJ6yderq40xQUGynkfWB/FJNQY+sjYEjCar/i45tRDwjUo/en2eTkXgJQ3n3Ipw+ziW
         CNpOHW4PViVKqOxNEjuLJ2kQEOa1qCRVaqeZunp8FHpkiSMut9j9QcT5DDV0RR6qWRQ5
         pUPymKzBNNwPmvKYU29UxDBFztM6SwzyFMLttbNOwPAWkfMO2A+/VvZkCWBniQceAxCS
         nfTTMpAlvosN2M/kbYM0AMKsbwVv9SwcNE5ES8dpcbZKBCfKmID20+3EJ9AOL/a5ZfjG
         BCQw==
X-Gm-Message-State: AOAM533beXNju8WVJoFoW0TeQOOFootVXIGym2O117uqF+ACZcMqzQIu
        bsaPI+OtHtsW1mCp48xSc+W8Fw==
X-Google-Smtp-Source: ABdhPJw95099vAQh3+X0cRfP0saUVV2RiK31WqVwUcTqvDXBZKKTumCdXI28g7hY2fcl2qsS8e3dXw==
X-Received: by 2002:a19:a409:: with SMTP id q9mr8441701lfc.654.1616781496908;
        Fri, 26 Mar 2021 10:58:16 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f3sm1249554ljm.5.2021.03.26.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:58:16 -0700 (PDT)
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
Subject: [PATCH v4 7/7] arm64: dts: qcom: use dp_phy to provide clocks to dispcc
Date:   Fri, 26 Mar 2021 20:58:09 +0300
Message-Id: <20210326175809.2923789-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326175809.2923789-1-dmitry.baryshkov@linaro.org>
References: <20210326175809.2923789-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plug dp_phy-provided clocks to display clock controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

