Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21A340EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhCRT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhCRT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:59:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E7C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:59:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z7so6493846lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vt2EBjJBXCElMumS8zwBKc0QOehEP6EtoAAqvcQaqEs=;
        b=qtwSUItzJSssoI284c3i7fLKfuVbD+hjHU6T9UwlOjhdHbCMgGEyM9HhmHjmIdp0m1
         iPJ/zu09jM9ErWvmyt/wazaDNjBQry/XR8TK5zgi1haT0ORQ5ApjISdZhToUzh5GWax4
         IfJ5XF96lX4AEXFW1scJpEJLtvENU54aK02mFApPyrp8CxlLKV2Q7IKSfYnfgFQaiNNI
         VJe1E63uiJj3sToGbOJiHI359Avv/3E8+FS0KMmRZ1zJN73D9FFhusnV/YDhOWQpBy6l
         I3Aqcf17N++r08jWWeeNa0oB7iIvZlAKJLFdbZutemak1BvLeJc03btmKFfXs1i8SawZ
         IQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vt2EBjJBXCElMumS8zwBKc0QOehEP6EtoAAqvcQaqEs=;
        b=GE8Cce2iZqFPyHGYBaG6vu99GUQr5xhvLXKlVprMj7HxJMRjcDnjcAtX6reVLhZLaV
         t1s30Bq8Ayy9uMZco/dZU4zxQG0eJUYFwvkBGSAxprK43wcjxF/gKiMqSZ8CnDWppLxV
         BepOLYJaPvk4iTl8w2PrArameRuD8uR5Oi+vfUo9s4ryp2GuQ8vB0LyFBvcs3YeB7bS7
         QiIznJTjMYxIxkPZ/MYn7n4HDoMQ0fXTpC4PKoBaw+4tIxjNhp/2AQBDYc2hbWlvu0GI
         YiygMyWVr8u8LGC+c8g+x6Coytmve0ALkZ5lW5WW8o4MJ6F/zTiPvb4wky1aU/mM+xM+
         aVqA==
X-Gm-Message-State: AOAM530UFjzIxuyxpBkBiTR/A7rL2qfoP2iu4zqOpAv+vJnY4bUdrHoi
        pkBK1ZPilo/ImQIqIAkinlhBnA==
X-Google-Smtp-Source: ABdhPJygwQfXIdOEcbcENcm4CVZV+MyH0fbuS7DZN8vyFSKM8zw1ewM49fhXoW0bN/gr8/rWOePLsg==
X-Received: by 2002:ac2:414c:: with SMTP id c12mr5388746lfi.538.1616097580016;
        Thu, 18 Mar 2021 12:59:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g6sm344159lfh.232.2021.03.18.12.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:59:39 -0700 (PDT)
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
Subject: [PATCH v3 6/6] arm64: dts: qcom: use dp_phy to provide clocks to dispcc
Date:   Thu, 18 Mar 2021 22:59:30 +0300
Message-Id: <20210318195930.2229546-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318195930.2229546-1-dmitry.baryshkov@linaro.org>
References: <20210318195930.2229546-1-dmitry.baryshkov@linaro.org>
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

