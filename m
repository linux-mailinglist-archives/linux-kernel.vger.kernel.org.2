Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7BC442C96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhKBLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:34:37 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12980 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230096AbhKBLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635852721; x=1667388721;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qkK3R1RFtpyMHIukBSnciUcoUu1NvYAxq8CPTPJHfoM=;
  b=N93HhFtxVmWb0MWEnxiWg2DOSlfOaLvwdVEJ2GI2UfnygTPzwtmMf9+M
   T6y891rwj6A4VXtUnYGCK1D8MZpdjSO3Ksud36Rw0kC8TFMFHetIfdZOr
   glbxEF2Mb4O3GjYJm9PMGr9k1vfAgMpp7e6Wbfp7RiPrt5ROD1oiEfo5r
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Nov 2021 04:32:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 04:32:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 2 Nov 2021 04:32:00 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 2 Nov 2021 04:31:55 -0700
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Krishna Manikandan <quic_mkrishn@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>
Subject: [PATCH v3 1/3] arm64: dts: qcom: sc7280: add display dt nodes
Date:   Tue, 2 Nov 2021 17:01:40 +0530
Message-ID: <1635852702-25822-1-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krishna Manikandan <quic_mkrishn@quicinc.com>

Add mdss and mdp DT nodes for sc7280.

Signed-off-by: Krishna Manikandan <quic_mkrishn@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---

Changes in v3:
    None

Changes in v2:
    - Rename display dt nodes (Stephen Boyd)
    - Add clock names one per line for readability (Stephen Boyd)

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 90 ++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 365a2e0..a4536b6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2704,6 +2704,96 @@
 			#power-domain-cells = <1>;
 		};
 
+		mdss: display-subsystem@ae00000 {
+			compatible = "qcom,sc7280-mdss";
+			reg = <0 0x0ae00000 0 0x1000>;
+			reg-names = "mdss";
+
+			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				<&dispcc DISP_CC_MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "ahb",
+				      "core";
+
+			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
+			assigned-clock-rates = <300000000>;
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem";
+
+			iommus = <&apps_smmu 0x900 0x402>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdp: display-controller@ae01000 {
+				compatible = "qcom,sc7280-dpu";
+				reg = <0 0x0ae01000 0 0x8f030>,
+					<0 0x0aeb0000 0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+					<&gcc GCC_DISP_SF_AXI_CLK>,
+					<&dispcc DISP_CC_MDSS_AHB_CLK>,
+					<&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+					<&dispcc DISP_CC_MDSS_MDP_CLK>,
+					<&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "bus",
+					      "nrt_bus",
+					      "iface",
+					      "lut",
+					      "core",
+					      "vsync";
+				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
+						<&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+						<&dispcc DISP_CC_MDSS_AHB_CLK>;
+				assigned-clock-rates = <300000000>,
+							<19200000>,
+							<19200000>;
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd SC7280_CX>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				status = "disabled";
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-200000000 {
+						opp-hz = /bits/ 64 <200000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-380000000 {
+						opp-hz = /bits/ 64 <380000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-506666667 {
+						opp-hz = /bits/ 64 <506666667>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sc7280-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>;
-- 
2.7.4

