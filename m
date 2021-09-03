Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703AA4004A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350452AbhICSKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350397AbhICSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:10:32 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74481C0617AD;
        Fri,  3 Sep 2021 11:09:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 905421F8E5;
        Fri,  3 Sep 2021 20:09:27 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 7/7] arm64: dts: qcom: msm8998-xperia: Add audio clock and its pin
Date:   Fri,  3 Sep 2021 20:09:24 +0200
Message-Id: <20210903180924.1006044-7-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210903180924.1006044-1-angelogioacchino.delregno@somainline.org>
References: <20210903180924.1006044-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All smartphones of this platform are equipped with a WCD9335 audio
codec, getting its MCLK from PM8998 gpio13: add this clock to DT.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 5fbe5abf4133..7aeebd3b2e9e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -20,6 +20,19 @@ / {
 	qcom,msm-id = <0x124 0x20000>, <0x124 0x20001>; /* 8998v2, v2.1 */
 	qcom,board-id = <8 0>;
 
+	clocks {
+		compatible = "simple-bus";
+
+		div1_mclk: divclk1 {
+			compatible = "gpio-gate-clock";
+			pinctrl-0 = <&audio_mclk_pin>;
+			pinctrl-names = "default";
+			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+			#clock-cells = <0>;
+			enable-gpios = <&pm8998_gpio 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	board_vbat: vbat-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VBAT";
@@ -313,6 +326,12 @@ cam_snapshot_pin_a: cam-snapshot-btn-active {
 		input-enable;
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
+
+	audio_mclk_pin: audio-mclk-pin-active {
+		pins = "gpio13";
+		function = "func2";
+		power-source = <0>;
+	};
 };
 
 &pmi8998_gpio {
-- 
2.32.0

