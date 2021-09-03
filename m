Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D54004A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350463AbhICSKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350396AbhICSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:10:32 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E21C061796;
        Fri,  3 Sep 2021 11:09:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 776EC1F563;
        Fri,  3 Sep 2021 20:09:26 +0200 (CEST)
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
Subject: [PATCH 3/7] arm64: dts: qcom: msm8998-xperia: Add support for wcn3990 Bluetooth
Date:   Fri,  3 Sep 2021 20:09:20 +0200
Message-Id: <20210903180924.1006044-3-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210903180924.1006044-1-angelogioacchino.delregno@somainline.org>
References: <20210903180924.1006044-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This platform uses the WCN3990 Bluetooth chip, reachable on UART-3.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 2fe53e4675d5..66b009ba72fe 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -179,6 +179,23 @@ &blsp1_i2c5_sleep {
 	bias-disable;
 };
 
+&blsp1_uart3 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+
+		clocks = <&rpmcc RPM_SMD_RF_CLK2_PIN>;
+	};
+};
+
+
 &blsp2_uart1 {
 	status = "okay";
 };
-- 
2.32.0

