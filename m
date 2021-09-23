Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA05C4162F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbhIWQYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:24:12 -0400
Received: from relay05.th.seeweb.it ([5.144.164.166]:42113 "EHLO
        relay05.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbhIWQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:23:47 -0400
Received: from localhost.localdomain (83.6.166.81.neoplus.adsl.tpnet.pl [83.6.166.81])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id CA20F3F679;
        Thu, 23 Sep 2021 18:22:13 +0200 (CEST)
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
Subject: [PATCH v3 03/17] arm64: dts: qcom: sm6350: Add LLCC node
Date:   Thu, 23 Sep 2021 18:21:49 +0200
Message-Id: <20210923162204.21752-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923162204.21752-1-konrad.dybcio@somainline.org>
References: <20210923162204.21752-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for LLCC with SM6350-specific compatible.

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d718ecf7d74e..5442c088cf37 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -372,6 +372,12 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		system-cache-controller@9200000 {
+			compatible = "qcom,sm6350-llcc";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
+			reg-names = "llcc_base", "llcc_broadcast_base";
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm6350-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x64>;
-- 
2.33.0

