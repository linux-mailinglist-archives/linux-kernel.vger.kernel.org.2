Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF123099D3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhAaBmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:42:52 -0500
Received: from relay02.th.seeweb.it ([5.144.164.163]:53409 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhAaBlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:41:25 -0500
Received: from localhost.localdomain (abaf219.neoplus.adsl.tpnet.pl [83.6.169.219])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 2D91D1F689;
        Sun, 31 Jan 2021 02:40:09 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustave Monce <gustave.monce@outlook.com>
Subject: [PATCH 14/18] arm64: dts: qcom: msm8994-octagon: Add FM Radio and DDR regulator nodes
Date:   Sun, 31 Jan 2021 02:38:45 +0100
Message-Id: <20210131013853.55810-15-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210131013853.55810-1-konrad.dybcio@somainline.org>
References: <20210131013853.55810-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FAN53526 and SI470X are both connected over blsp2_i2c5. Configure them.

Signed-off-by: Gustave Monce <gustave.monce@outlook.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/msm8994-msft-lumia-octagon.dtsi  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index 097f8f6701e3..80e4ed48a1e3 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -304,6 +304,32 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&blsp2_i2c5 {
+	status = "okay";
+
+	fm_radio: si4705@11 {
+		compatible = "silabs,si470x";
+		reg = <0x11>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 93 GPIO_ACTIVE_HIGH>;
+	};
+
+	vreg_lpddr_1p1: fan53526a@6c {
+		compatible = "fcs,fan53526";
+		reg = <0x6c>;
+
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vph_pwr>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-always-on; /* Turning off DDR power doesn't sound good. */
+	};
+
+	/* ANX7816 HDMI bridge (needs MDSS HDMI) */
+};
+
 &blsp2_spi4 {
 	status = "okay";
 
-- 
2.30.0

