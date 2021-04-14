Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1835F204
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348888AbhDNLOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:14:11 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3948 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbhDNLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:13:56 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Apr 2021 04:13:35 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Apr 2021 04:13:33 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg02-blr.qualcomm.com with ESMTP; 14 Apr 2021 16:43:08 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 2C36847ED; Wed, 14 Apr 2021 16:43:07 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, satya priya <skakit@codeaurora.org>
Subject: [RESEND PATCH V3 1/5] arm64: dts: qcom: pm7325: Add pm7325 base dts file
Date:   Wed, 14 Apr 2021 16:42:59 +0530
Message-Id: <1618398783-7834-2-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618398783-7834-1-git-send-email-skakit@codeaurora.org>
References: <1618398783-7834-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base DTS file for pm7325 along with GPIOs and temp-alarm nodes.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/pm7325.dtsi | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm7325.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm7325.dtsi b/arch/arm64/boot/dts/qcom/pm7325.dtsi
new file mode 100644
index 0000000..e7f64a9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm7325.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2021, The Linux Foundation. All rights reserved.
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pm7325: pmic@1 {
+		compatible = "qcom,pm7325", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm7325_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm7325_gpios: gpios@8800 {
+			compatible = "qcom,pm7325-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm7325_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
+
+&thermal_zones {
+	pm7325_thermal: pm7325-thermal {
+		polling-delay-passive = <100>;
+		polling-delay = <0>;
+		thermal-sensors = <&pm7325_temp_alarm>;
+
+		trips {
+			pm7325_trip0: trip0 {
+				temperature = <95000>;
+				hysteresis = <0>;
+				type = "passive";
+			};
+
+			pm7325_crit: pm7325-crit {
+				temperature = <115000>;
+				hysteresis = <0>;
+				type = "critical";
+			};
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

