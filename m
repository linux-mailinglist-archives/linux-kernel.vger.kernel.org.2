Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169A934AE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCZR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhCZR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:58:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F0C0613B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:58:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b4so8907056lfi.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmV5IJWPHSxLmzC9gCnVq4UR+8W3WxG5ODhCcEewhgo=;
        b=jVXSrsSq0OD3XN58B9etBTnhroLvBAvuKyZ9pu0B8WxvNpEp9EYgRsW/5HR0ECgRKP
         dfFfCW/u8i3QkXiKbiJ6m+C1qaa2/vwaSJcEGjkXOdvPbYqt7627RdXMH8TMiT6L9FjF
         f6NbXesFdWtfYjgsmfsBG1lMPpfDSdBpnkUG7PvLuqjvRywYOfTEV1mrNmEnObgakdio
         T4+XDNHSBJH/if8zzUsPt670YpRc7gXgmUX7L7oRDTRBNJoXg9NEIrk2l7eCLM1ydyLt
         WbrzCDbg4cKQ4eHmR1lWxe/hLUFk6pjZbGhrikFR9ozMGMa/dWVmqDgyqkgScaKwrkNw
         ztaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmV5IJWPHSxLmzC9gCnVq4UR+8W3WxG5ODhCcEewhgo=;
        b=PPZMfD+b/QoX4c14W8pcnhYT+rU1vDAkcH2Hi6A58/TqmNaL9wnt/I6WsXDV+9jc5Q
         poMzubCub/9IBR4S8qOkhX1crhheWHvUA+lvOqUtpYjJFdQvvrnEHyqFW6534wI/djFM
         1y/291pQ4J2pNDHQENC427fqIhVKbds6zpWo4l05ZopmXYmIjwhZVbNu1wF+8Q8tBSFh
         sjsFLLtK54ZeSbi15/CuuGpu8hXAUateRrtu/emnTyFYt9rrvrPwb37JtvchKpArI3ur
         +FSNJPjiXLNQMaWz8h5SHz2XVajBc7HUCeZLeC6K57gYSm0Brz4aN3EvFeEPJo0bfXBu
         xb+g==
X-Gm-Message-State: AOAM531ehbJrJiAZ5W2MI7kQ2NUi1T+TkRxPQOgtbi1GJA+LY3oi8P88
        /ikrqptw9oftMg3Y9647yv6bQQ==
X-Google-Smtp-Source: ABdhPJzYvFGucWnT/RRpNjfrI40LoUvlcTs/LOX8D9aP7BJ5dIEYkMAgsG8RrOohetNtr/vNH7d7yw==
X-Received: by 2002:a19:e347:: with SMTP id c7mr8500751lfk.632.1616781496262;
        Fri, 26 Mar 2021 10:58:16 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f3sm1249554ljm.5.2021.03.26.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:58:15 -0700 (PDT)
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
Subject: [PATCH v4 6/7] arm64: dts: qcom: sm8250: switch usb1 qmp phy to USB3+DP mode
Date:   Fri, 26 Mar 2021 20:58:08 +0300
Message-Id: <20210326175809.2923789-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326175809.2923789-1-dmitry.baryshkov@linaro.org>
References: <20210326175809.2923789-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB1 QMP PHY is not just a USB3 PHY, but USB3+DP PHY. Change device tree
nodes accordingly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 947e1accae3a..0f79e6885004 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2097,12 +2097,11 @@ usb_2_hsphy: phy@88e4000 {
 		};
 
 		usb_1_qmpphy: phy@88e9000 {
-			compatible = "qcom,sm8250-qmp-usb3-phy";
+			compatible = "qcom,sm8250-qmp-usb3-dp-phy";
 			reg = <0 0x088e9000 0 0x200>,
-			      <0 0x088e8000 0 0x20>;
-			reg-names = "reg-base", "dp_com";
+			      <0 0x088e8000 0 0x40>,
+			      <0 0x088ea000 0 0x200>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -2116,7 +2115,7 @@ usb_1_qmpphy: phy@88e9000 {
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: lanes@88e9200 {
+			usb_1_ssphy: usb3-phy@88e9200 {
 				reg = <0 0x088e9200 0 0x200>,
 				      <0 0x088e9400 0 0x200>,
 				      <0 0x088e9c00 0 0x400>,
@@ -2128,6 +2127,20 @@ usb_1_ssphy: lanes@88e9200 {
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
 			};
+
+			dp_phy: dp-phy@88ea200 {
+				reg = <0 0x088ea200 0 0x200>,
+				      <0 0x088ea400 0 0x200>,
+				      <0 0x088eac00 0 0x400>,
+				      <0 0x088ea600 0 0x200>,
+				      <0 0x088ea800 0 0x200>,
+				      <0 0x088eaa00 0 0x100>;
+				#phy-cells = <0>;
+				#clock-cells = <1>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
 		};
 
 		usb_2_qmpphy: phy@88eb000 {
-- 
2.30.2

