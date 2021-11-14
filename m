Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07C44F605
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 02:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhKNBbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 20:31:10 -0500
Received: from relay07.th.seeweb.it ([5.144.164.168]:44165 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhKNBbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 20:31:01 -0500
Received: from localhost.localdomain (83.6.165.118.neoplus.adsl.tpnet.pl [83.6.165.118])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id E61583EE65;
        Sun, 14 Nov 2021 02:28:06 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] arm64: dts: qcom: sm[68]350: Use interrupts-extended with pdc interrupts
Date:   Sun, 14 Nov 2021 02:27:44 +0100
Message-Id: <20211114012755.112226-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114012755.112226-1-konrad.dybcio@somainline.org>
References: <20211114012755.112226-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using interrupts = <&pdc X Y> makes the interrupt framework interpret this as
the &pdc-nth range of the main interrupt controller (GIC). Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 43c8ecb85d17..8fcf04edbf30 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -842,7 +842,7 @@ tsens0: thermal-sensor@c263000 {
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 			      <0 0x0c222000 0 0x8>; /* SROT */
 			#qcom,sensors = <16>;
-			interrupts = <&pdc 26 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 26 IRQ_TYPE_LEVEL_HIGH>,
 				     <&pdc 28 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
@@ -853,7 +853,7 @@ tsens1: thermal-sensor@c265000 {
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 			      <0 0x0c223000 0 0x8>; /* SROT */
 			#qcom,sensors = <16>;
-			interrupts = <&pdc 27 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 27 IRQ_TYPE_LEVEL_HIGH>,
 				     <&pdc 29 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 60866a20a55c..f3e8549c6572 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -923,7 +923,7 @@ tsens0: thermal-sensor@c263000 {
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 			      <0 0x0c222000 0 0x8>; /* SROT */
 			#qcom,sensors = <15>;
-			interrupts = <&pdc 26 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 26 IRQ_TYPE_LEVEL_HIGH>,
 				     <&pdc 28 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
@@ -934,7 +934,7 @@ tsens1: thermal-sensor@c265000 {
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 			      <0 0x0c223000 0 0x8>; /* SROT */
 			#qcom,sensors = <14>;
-			interrupts = <&pdc 27 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 27 IRQ_TYPE_LEVEL_HIGH>,
 				     <&pdc 29 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
-- 
2.33.1

