Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A973A5A50
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFMUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhFMUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:20:06 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9CC061766
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:18:04 -0700 (PDT)
Received: from localhost.localdomain (83.6.168.161.neoplus.adsl.tpnet.pl [83.6.168.161])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id D49761F87F;
        Sun, 13 Jun 2021 22:18:01 +0200 (CEST)
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
Subject: [PATCH] arm64: dts: qcom: qrb5165-rb5: Fix up pins
Date:   Sun, 13 Jun 2021 22:17:54 +0200
Message-Id: <20210613201754.346440-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210612192358.62602-2-konrad.dybcio@somainline.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the SDHCI pin commonization commit I overlooked the fact that this
board had the pins defined in its own DT. Revert their settings to the
original values.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 38 ++++++++----------------
 arch/arm64/boot/dts/qcom/sm8250.dtsi     |  4 +--
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index a5b742325261..bf05328f3901 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -858,6 +858,18 @@ dai@2 {
 	};
 };
 
+&sdc2_card_det_n {
+	/delete-property/ drive-strength;
+};
+
+&sdc2_cmd_default {
+	drive-strength = <10>;
+};
+
+&sdc2_data_default {
+	drive-strength = <10>;
+};
+
 &sdhc_2 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -1253,32 +1265,6 @@ wake-n {
 			bias-pull-up;
 		};
 	};
-
-	sdc2_default_state: sdc2-default {
-		clk {
-			pins = "sdc2_clk";
-			bias-disable;
-			drive-strength = <16>;
-		};
-
-		cmd {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-
-		data {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-	};
-
-	sdc2_card_det_n: sd-card-det-n {
-		pins = "gpio77";
-		function = "gpio";
-		bias-pull-up;
-	};
 };
 
 &uart12 {
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fe858abbff5d..fab5d83f4496 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3414,13 +3414,13 @@ clk {
 					bias-disable;
 				};
 
-				cmd {
+				sdc2_cmd_default: cmd {
 					pins = "sdc2_cmd";
 					drive-strength = <16>;
 					bias-pull-up;
 				};
 
-				data {
+				sdc2_data_default: data {
 					pins = "sdc2_data";
 					drive-strength = <16>;
 					bias-pull-up;
-- 
2.32.0

