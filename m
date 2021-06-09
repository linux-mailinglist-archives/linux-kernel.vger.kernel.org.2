Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE0F3A182E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhFIO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:57:48 -0400
Received: from relay07.th.seeweb.it ([5.144.164.168]:60501 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbhFIO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:57:42 -0400
Received: from localhost.localdomain (83.6.168.161.neoplus.adsl.tpnet.pl [83.6.168.161])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id BE3153F5D6;
        Wed,  9 Jun 2021 16:55:44 +0200 (CEST)
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
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] clk: qcom: gcc-msm8994: Remove the inexistent GDSC_PCIE
Date:   Wed,  9 Jun 2021 16:55:18 +0200
Message-Id: <20210609145523.467090-6-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609145523.467090-1-konrad.dybcio@somainline.org>
References: <20210609145523.467090-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GDSC is not present on msm8994.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v1:
- Change 0 to NULL

 drivers/clk/qcom/gcc-msm8994.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 98b2fd429629..784073c06b4f 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -2485,14 +2485,6 @@ static struct clk_branch gcc_prng_ahb_clk = {
 	},
 };
 
-static struct gdsc pcie_gdsc = {
-		.gdscr = 0x1e18,
-		.pd = {
-			.name = "pcie",
-		},
-		.pwrsts = PWRSTS_OFF_ON,
-};
-
 static struct gdsc pcie_0_gdsc = {
 		.gdscr = 0x1ac4,
 		.pd = {
@@ -2682,7 +2674,8 @@ static struct clk_regmap *gcc_msm8994_clocks[] = {
 };
 
 static struct gdsc *gcc_msm8994_gdscs[] = {
-	[PCIE_GDSC] = &pcie_gdsc,
+	/* This GDSC does not exist, but ABI has to remain intact */
+	[PCIE_GDSC] = NULL,
 	[PCIE_0_GDSC] = &pcie_0_gdsc,
 	[PCIE_1_GDSC] = &pcie_1_gdsc,
 	[USB30_GDSC] = &usb30_gdsc,
-- 
2.31.1

