Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD123329FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574738AbhCBDtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbhCAVho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:37:44 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E2C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u18so4549493plc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTOv9sgY3m/KoKSOcbv0Bygw57sq0LMY7JaKuvUzw1g=;
        b=nYv3VRDNkGZXK5ea9gR23Z5jWgv6Lj/Zlr4fdaSH04Zm0BooAE+awETGxX3X2T9r4j
         M0Joya0HN7cUyYMCOSSZKZO9UefdS48Z0tJC+q7QSjF2CpUYqvV3AnNkcgfX1JWmoO7w
         rj5I3rKfm74eIdafBhMFS9DPH1GL5tu0/XNBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTOv9sgY3m/KoKSOcbv0Bygw57sq0LMY7JaKuvUzw1g=;
        b=icT7bYOBa8xiHmO/cCcXoE20yc9O+1AuTAGy9Fj5UGCx2ayePrKtDNG0CAkO1TNrRe
         f1zaa5bBTqLpiOVvumt/jptW/J0Isb7n0Kw7PUeB88eMX5ZflCn8ciNO54/dcgyn9ppT
         THI6nVSpkXd642MVbLdhoC8xhdWRVkB1tkMKiXNcjAEwy7TaMfREpFRGZS+JhofW9aMf
         VouBcGTh1Zg2dx7avFthJIKY3MUVatToQA0wawntAknJ1Wjx7Hn8GcHGOswuOJcpUPeS
         h+fshTPE7is/fhrwqLo3RcY1QQAtu+IHy8G7ua2+8E9M9xiiakCjPWU5MwHzBOVojQ+h
         +Asg==
X-Gm-Message-State: AOAM5326UsJcRyf6OkQHXswwrrTVQ+w9kGvwkUQrIa2RpngaqyTfsqwv
        rLMwe5etXtQnti6YpxImjlHvrA==
X-Google-Smtp-Source: ABdhPJwpEdlrDXWdSs1Pog6HtyBnejPjZCIjacqPdNTpq7m1VAyri/jlZZk0QGtlC0xYOS2Bs0zdkQ==
X-Received: by 2002:a17:90a:16d6:: with SMTP id y22mr908810pje.55.1614634486738;
        Mon, 01 Mar 2021 13:34:46 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:34:46 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] arm64: dts: qcom: sc7180: Update dts for DP phy inside QMP phy
Date:   Mon,  1 Mar 2021 13:34:25 -0800
Message-Id: <20210301133318.v2.1.Iad06142ceb8426ce5492737bf3d9162ed0dd2b55@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301213437.4165775-1-dianders@chromium.org>
References: <20210301213437.4165775-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Drop the old node and add the new one in its place.

Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Rob Clark <robdclark@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
[dianders: Adjusted due to DP not itself not in upstream dts yet]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 1ea3344ab62c..60248a6757d8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2770,12 +2770,11 @@ usb_1_hsphy: phy@88e3000 {
 		};
 
 		usb_1_qmpphy: phy-wrapper@88e9000 {
-			compatible = "qcom,sc7180-qmp-usb3-phy";
+			compatible = "qcom,sc7180-qmp-usb3-dp-phy";
 			reg = <0 0x088e9000 0 0x18c>,
-			      <0 0x088e8000 0 0x38>;
-			reg-names = "reg-base", "dp_com";
+			      <0 0x088e8000 0 0x38>,
+			      <0 0x088ea000 0 0x40>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -2790,7 +2789,7 @@ usb_1_qmpphy: phy-wrapper@88e9000 {
 				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: phy@88e9200 {
+			usb_1_ssphy: usb3-phy@88e9200 {
 				reg = <0 0x088e9200 0 0x128>,
 				      <0 0x088e9400 0 0x200>,
 				      <0 0x088e9c00 0 0x218>,
@@ -2803,6 +2802,16 @@ usb_1_ssphy: phy@88e9200 {
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
 			};
+
+			dp_phy: dp-phy@88ea200 {
+				reg = <0 0x088ea200 0 0x200>,
+				      <0 0x088ea400 0 0x200>,
+				      <0 0x088eaa00 0 0x200>,
+				      <0 0x088ea600 0 0x200>,
+				      <0 0x088ea800 0 0x200>;
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+			};
 		};
 
 		dc_noc: interconnect@9160000 {
@@ -3166,8 +3175,8 @@ dispcc: clock-controller@af00000 {
 				 <&gcc GCC_DISP_GPLL0_CLK_SRC>,
 				 <&dsi_phy 0>,
 				 <&dsi_phy 1>,
-				 <0>,
-				 <0>;
+				 <&dp_phy 0>,
+				 <&dp_phy 1>;
 			clock-names = "bi_tcxo",
 				      "gcc_disp_gpll0_clk_src",
 				      "dsi0_phy_pll_out_byteclk",
-- 
2.30.1.766.gb4fecdf3b7-goog

