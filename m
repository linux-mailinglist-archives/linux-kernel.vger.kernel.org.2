Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6C327268
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 14:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhB1NKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 08:10:42 -0500
Received: from m-r1.th.seeweb.it ([5.144.164.170]:41321 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhB1NKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 08:10:06 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id DC4BC1F570;
        Sun, 28 Feb 2021 14:08:59 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] arm64: dts: qcom: msm8996: Add DSI0 nodes
Date:   Sun, 28 Feb 2021 14:08:27 +0100
Message-Id: <20210228130831.203765-9-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210228130831.203765-1-konrad.dybcio@somainline.org>
References: <20210228130831.203765-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required nodes to support DSI displays connected to the
primary interface.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 78 +++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index d557fd5b9f82..75675fae0334 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -544,6 +544,11 @@ mdp: mdp@901000 {
 
 				iommus = <&mdp_smmu 0>;
 
+				assigned-clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <300000000>,
+					 <19200000>;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -554,9 +559,82 @@ mdp5_intf3_out: endpoint {
 							remote-endpoint = <&hdmi_in>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+						mdp5_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
 				};
 			};
 
+			dsi0: dsi@994000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0x00994000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_BYTE0_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MMSS_MISC_AHB_CLK>,
+					 <&mmcc MDSS_PCLK0_CLK>,
+					 <&mmcc MDSS_ESC0_CLK>;
+				clock-names = "mdp_core",
+					      "byte",
+					      "iface",
+					      "bus",
+					      "core_mmss",
+					      "pixel",
+					      "core";
+
+				phys = <&dsi0_phy>;
+				phy-names = "dsi";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi0_in: endpoint {
+							remote-endpoint = <&mdp5_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi0_phy: dsi-phy@994400 {
+				compatible = "qcom,dsi-phy-14nm";
+				reg = <0x00994400 0x100>,
+				      <0x00994500 0x300>,
+				      <0x00994800 0x188>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>, <&xo_board>;
+				clock-names = "iface", "ref";
+				status = "disabled";
+			};
+
 			hdmi: hdmi-tx@9a0000 {
 				compatible = "qcom,hdmi-tx-8996";
 				reg =	<0x009a0000 0x50c>,
-- 
2.30.1

