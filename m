Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF493FAE25
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhH2Thn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:37:43 -0400
Received: from relay07.th.seeweb.it ([5.144.164.168]:39315 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbhH2Th0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:37:26 -0400
Received: from localhost.localdomain (83.6.166.149.neoplus.adsl.tpnet.pl [83.6.166.149])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id EDD553E850;
        Sun, 29 Aug 2021 21:36:31 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH RESEND v2 7/9] clk: qcom: gcc-msm8994: Add modem reset
Date:   Sun, 29 Aug 2021 21:36:14 +0200
Message-Id: <20210829193617.4105-7-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829193617.4105-1-konrad.dybcio@somainline.org>
References: <20210829193617.4105-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be required to support the modem.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/gcc-msm8994.c               | 1 +
 include/dt-bindings/clock/qcom,gcc-msm8994.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 2ed206ecb60d..7545e973fd0d 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -2685,6 +2685,7 @@ static struct gdsc *gcc_msm8994_gdscs[] = {
 static const struct qcom_reset_map gcc_msm8994_resets[] = {
 	[USB3_PHY_RESET] = { 0x1400 },
 	[USB3PHY_PHY_RESET] = { 0x1404 },
+	[MSS_RESET] = { 0x1680 },
 	[PCIE_PHY_0_RESET] = { 0x1b18 },
 	[PCIE_PHY_1_RESET] = { 0x1b98 },
 	[QUSB2_PHY_RESET] = { 0x04b8 },
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
index dcb49817dcec..f6836f430bb5 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
@@ -174,5 +174,6 @@
 #define PCIE_PHY_0_RESET		2
 #define PCIE_PHY_1_RESET		3
 #define QUSB2_PHY_RESET			4
+#define MSS_RESET				5
 
 #endif
-- 
2.33.0

