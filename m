Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABBD3099CC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhAaBmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:42:05 -0500
Received: from relay04.th.seeweb.it ([5.144.164.165]:40281 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhAaBlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:41:14 -0500
Received: from localhost.localdomain (abaf219.neoplus.adsl.tpnet.pl [83.6.169.219])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 28B761F6C5;
        Sun, 31 Jan 2021 02:40:18 +0100 (CET)
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
Subject: [PATCH 16/18] arm64: dts: qcom: msm8994-octagon: Add sensors on blsp1_i2c5
Date:   Sun, 31 Jan 2021 02:38:47 +0100
Message-Id: <20210131013853.55810-17-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210131013853.55810-1-konrad.dybcio@somainline.org>
References: <20210131013853.55810-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustave Monce <gustave.monce@outlook.com>

Add AK09912 magnetometer, ZPA2326 barometer and MPU6500 accelerometer
nodes.

Signed-off-by: Gustave Monce <gustave.monce@outlook.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/msm8994-msft-lumia-octagon.dtsi  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index e01c9dce187c..4aa33682f975 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -300,6 +300,42 @@ rmi4-f12@12 {
 	};
 };
 
+&blsp1_i2c5 {
+	status = "okay";
+
+	ak09912: magnetometer@c {
+		compatible = "asahi-kasei,ak09912";
+		reg = <0xc>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+
+		vdd-supply = <&vreg_l18a_2p85>;
+		vid-supply = <&vreg_lvs2a_1p8>;
+	};
+
+	zpa2326: barometer@5c {
+		compatible = "murata,zpa2326";
+		reg = <0x5c>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <74 IRQ_TYPE_EDGE_RISING>;
+
+		vdd-supply = <&vreg_lvs2a_1p8>;
+	};
+
+	mpu6050: accelerometer@68 {
+		compatible = "invensense,mpu6500";
+		reg = <0x68>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <64 IRQ_TYPE_EDGE_RISING>;
+		
+		vdd-supply = <&vreg_lvs2a_1p8>;
+		vddio-supply = <&vreg_lvs2a_1p8>;
+	};
+};
+
 &blsp1_i2c6 {
 	status = "okay";
 
-- 
2.30.0

