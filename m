Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3037339A57B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFCQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:13:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31662 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFCQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:13:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622736699; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YPt57uRHkIKCAc3k7uJNjdS1IBPwSdXWYI60IXWNva4=; b=ZLbhcvQyOxUVnF4/Bdqn1bO6+ebbDt0IDZvh1iQVen450OVwhF9GDw9jEPRLIA2hJNB/BT95
 KXJ5BOAjjaymW4cOoq9rKzJqysUuHj7YYnCIlgBOF7E3nbZ1HeOH6+JjEiTO7aRPpo2n95e/
 23Y2NZq9inYw5G1GqPwXP7Mp5Ek=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60b8feb7ed59bf69cca96c20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 16:09:27
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31783C43148; Thu,  3 Jun 2021 16:09:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F054AC4360C;
        Thu,  3 Jun 2021 16:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F054AC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        khsieh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
Date:   Thu,  3 Jun 2021 09:09:15 -0700
Message-Id: <1622736555-15775-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DP device node on sc7180.

Changes in v2:
-- replace msm_dp with dp
-- replace dp_opp_table with opp_table

Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi |  9 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 78 ++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 24d293e..40367a2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -786,6 +786,15 @@ hp_i2c: &i2c9 {
 	status = "okay";
 };
 
+&dp {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&dp_hot_plug_det>;
+        data-lanes = <0 1>;
+        vdda-1p2-supply = <&vdda_usb_ss_dp_1p2>;
+        vdda-0p9-supply = <&vdda_usb_ss_dp_core>;
+};
+
 &pm6150_adc {
 	charger-thermistor@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6228ba2..05a4133 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3032,6 +3032,13 @@
 							remote-endpoint = <&dsi0_in>;
 						};
 					};
+
+					port@2 {
+						reg = <2>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&dp_in>;
+						};
+					};
 				};
 
 				mdp_opp_table: mdp-opp-table {
@@ -3148,6 +3155,77 @@
 
 				status = "disabled";
 			};
+
+			dp: displayport-controller@ae90000 {
+				compatible = "qcom,sc7180-dp";
+				status = "disabled";
+
+				reg = <0 0x0ae90000 0 0x1400>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <12>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+				clock-names = "core_iface", "core_aux", "ctrl_link",
+					      "ctrl_link_iface", "stream_pixel";
+				#clock-cells = <1>;
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+				assigned-clock-parents = <&dp_phy 0>, <&dp_phy 1>;
+				phys = <&dp_phy>;
+				phy-names = "dp";
+
+				operating-points-v2 = <&opp_table>;
+				power-domains = <&rpmhpd SC7180_CX>;
+
+				#sound-dai-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					port@0 {
+						reg = <0>;
+						dp_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dp_out: endpoint { };
+					};
+				};
+
+				opp_table: dp-opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+
 		};
 
 		dispcc: clock-controller@af00000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

