Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C04155B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhIWDC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbhIWDCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:02:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 20:01:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l6so3060203plh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 20:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqGGjHmGOBtmUQ1UqxL4gpZoIXgNmbQ5YBOzXhSwaO4=;
        b=k0k1+T3G6p6TwOcIDiYXyaySnuYcRzNbZGG966R3K0AC5Xn4VS0eFyuJ4K2l9X/oMf
         /NMyYUXremhn0PT1ZjJXTIS0VXVynXH+Z8ZS7ZaUByWZSw/ciyXyQYLfEXxCJ5V22wwl
         ildjTUxciaAx05jLVzQZiO49Mcn/OK1zuaFTT2k4kFI+nIFHO3YCkyV9MMl4lVIHLkvc
         +rOhlEY3Iczsf8YN/g/kdDgld163189Ti5E1+NqzsID9d0GK922ymQ/sSA9yWNIv1lWh
         JuwTAfIaTr8679zzoyzjXF79NbAUYJrpUlzkVpgEJ83ApqUqa2VrPx5UMuwDC2WCOlje
         rufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqGGjHmGOBtmUQ1UqxL4gpZoIXgNmbQ5YBOzXhSwaO4=;
        b=NhWMxXBd8QAZoZMLvFWkL2P/em3LnjV8/fmuvoUyYN8hAzbQKMzYDdsFV0ANByWZa2
         4Wa5o7u5hZnq+TZYnkdA5UGCDOeX0yhDSx+ciUJfll9MO+44LGW9yu3GSK0q/nQnotaO
         cvsRlpZK4jR6HK2KtQdVJbulT+ecavPNMSgpnmwHGlmZfbGDG0Dq1dtCaAhBea1MGrjG
         lI8qk79cO3WyJ1lMnD8oOwOjjQzVzGhk+8Fe7U7G6o4ekqkp7l8EIIdtoUTEBuAI3j+a
         2dCkoOfkPAoB76wj6wEjlv5W1boFuy2+EXsERu8QEcV+uRgU6k3Cy7mrg3zc5aDk8Akb
         7c2A==
X-Gm-Message-State: AOAM531NKguPOzRXfy1iFOAdJhJfezhX/wMumidcMu5KoQJ9XjMterGH
        ++RlJIAHnnwuC2Ds4XSUQuqIuw==
X-Google-Smtp-Source: ABdhPJxs5wJOxDdaYuWd1erp1z5xbDV2pAM2nTmG4+H7Kf47BULaQvfb0JEpAwFkIIIFbu6YmXwGeg==
X-Received: by 2002:a17:90b:1488:: with SMTP id js8mr2696003pjb.41.1632366082211;
        Wed, 22 Sep 2021 20:01:22 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i7sm4226869pgp.39.2021.09.22.20.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:01:21 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add QCM2290 pinctrl bindings
Date:   Thu, 23 Sep 2021 11:01:01 +0800
Message-Id: <20210923030102.29148-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923030102.29148-1-shawn.guo@linaro.org>
References: <20210923030102.29148-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for QCM2290 pinctrl.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 186 ++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
new file mode 100644
index 000000000000..714ec245aa7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,qcm2290-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QCM2290 TLMM block
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description:
+  This binding describes the Top Level Mode Multiplexer block found in the
+  QCM2290 platform.
+
+properties:
+  compatible:
+    const: qcom,qcm2290-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Specifies the TLMM summary IRQ
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description:
+      Specifies the PIN numbers and Flags, as defined in defined in
+      include/dt-bindings/interrupt-controller/irq.h
+    const: 2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+  wakeup-parent:
+    maxItems: 1
+
+#PIN CONFIGURATION NODES
+patternProperties:
+  '-state$':
+    oneOf:
+      - $ref: "#/$defs/qcom-qcm2290-tlmm-state"
+      - patternProperties:
+          ".*":
+            $ref: "#/$defs/qcom-qcm2290-tlmm-state"
+
+'$defs':
+  qcom-qcm2290-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-6])$"
+            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data,
+                      sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ qup0, gpio, ddr_bist, phase_flag0, qdss_gpio8, atest_tsens,
+                mpm_pwr, m_voc, phase_flag1, qdss_gpio9, atest_tsens2,
+                phase_flag2, qdss_gpio10, dac_calib0, atest_usb10, phase_flag3,
+                qdss_gpio11, dac_calib1, atest_usb11, qup1, CRI_TRNG0,
+                phase_flag4, dac_calib2, atest_usb12, CRI_TRNG1, phase_flag5,
+                dac_calib3, atest_usb13, qup2, phase_flag6, dac_calib4,
+                atest_usb1, qup3, pbs_out, PLL_BIST, qdss_gpio, tsense_pwm,
+                AGERA_PLL, pbs0, qdss_gpio0, pbs1, qdss_gpio1, qup4, tgu_ch0,
+                tgu_ch1, qup5, tgu_ch2, phase_flag7, qdss_gpio4, dac_calib5,
+                tgu_ch3, phase_flag8, qdss_gpio5, dac_calib6, phase_flag9,
+                qdss_gpio6, dac_calib7, phase_flag10, qdss_gpio7, dac_calib8,
+                SDC2_TB, CRI_TRNG, pbs2, qdss_gpio2, pwm_0, SDC1_TB, pbs3,
+                qdss_gpio3, cam_mclk, pbs4, adsp_ext, pbs5, cci_i2c, prng_rosc,
+                pbs6, phase_flag11, dac_calib9, atest_usb20, pbs7, phase_flag12,
+                dac_calib10, atest_usb21, CCI_TIMER1, GCC_GP1, pbs8,
+                phase_flag13, dac_calib11, atest_usb22, cci_async, CCI_TIMER0,
+                pbs9, phase_flag14, dac_calib12, atest_usb23, pbs10,
+                phase_flag15, dac_calib13, atest_usb2, vsense_trigger, qdss_cti,
+                CCI_TIMER2, pwm_1, phase_flag16, dac_calib14, atest_char,
+                phase_flag17, dac_calib15, atest_char0, GP_PDM0, phase_flag18,
+                dac_calib16, atest_char1, CCI_TIMER3, GP_PDM1, phase_flag19,
+                dac_calib17, atest_char2, GP_PDM2, phase_flag20, dac_calib18,
+                atest_char3, phase_flag21, phase_flag22, char_exec, NAV_GPIO,
+                phase_flag23, phase_flag24, phase_flag25, pbs14, qdss_gpio14,
+                vfr_1, pbs15, qdss_gpio15, PA_INDICATOR, pwm_2, gsm1_tx,
+                SSBI_WTR1, pll_bypassnl, pll_reset, phase_flag26, ddr_pxi0,
+                gsm0_tx, phase_flag27, GCC_GP2, qdss_gpio12, ddr_pxi1, GCC_GP3,
+                qdss_gpio13, dbg_out, uim2_data, pwm_3, uim2_clk, uim2_reset,
+                pwm_4, uim2_present, pwm_5, uim1_data, uim1_clk, uim1_reset,
+                uim1_present, dac_calib19, mdp_vsync, mdp_vsync_out_0,
+                mdp_vsync_out_1, dac_calib20, dac_calib21, pwm_6, atest_bbrx1,
+                pbs11, usb_phy, atest_bbrx0, pwm_7, mss_lte, pbs12, pbs13,
+                wlan1_adc0, wlan1_adc1, sd_write, JITTER_BIST,
+                atest_gpsadc_dtest0_native, atest_gpsadc_dtest1_native,
+                phase_flag28, dac_calib22, ddr_pxi2, phase_flag29, dac_calib23,
+                phase_flag30, dac_calib24, ddr_pxi3, pwm_8, phase_flag31,
+                dac_calib25, pwm_9 ]
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      bias-pull-down: true
+
+      bias-pull-up: true
+
+      bias-disable: true
+
+      output-high: true
+
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@500000 {
+        compatible = "qcom,qcm2290-tlmm";
+        reg = <0x500000 0x300000>;
+        interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 127>;
+
+        sdc2_on_state: sdc2-on-state {
+            clk {
+                pins = "sdc2_clk";
+                bias-disable;
+                drive-strength = <16>;
+            };
+
+            cmd {
+                pins = "sdc2_cmd";
+                bias-pull-up;
+                drive-strength = <10>;
+            };
+
+            data {
+                pins = "sdc2_data";
+                bias-pull-up;
+                drive-strength = <10>;
+            };
+        };
+    };
-- 
2.17.1

