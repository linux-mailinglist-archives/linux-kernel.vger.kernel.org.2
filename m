Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3AA390A41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhEYUFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 16:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhEYUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 16:04:58 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C2C06138D
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:03:22 -0700 (PDT)
Received: from localhost.localdomain (83.6.168.54.neoplus.adsl.tpnet.pl [83.6.168.54])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 5B82920377;
        Tue, 25 May 2021 22:03:20 +0200 (CEST)
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
Subject: [PATCH 6/7] arm64: dts: qcom: msm8996: Fix BLSP2_I2C6 IRQ
Date:   Tue, 25 May 2021 22:02:44 +0200
Message-Id: <20210525200246.118323-6-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525200246.118323-1-konrad.dybcio@somainline.org>
References: <20210525200246.118323-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a wrong IRQ in BLSP2_I2C6 node.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cc12de5a9d6b..57f32e0aa4a3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2577,7 +2577,7 @@ blsp2_i2c5: i2c@75b9000 {
 		blsp2_i2c6: i2c@75ba000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x75ba000 0x1000>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
 				<&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
-- 
2.31.1

