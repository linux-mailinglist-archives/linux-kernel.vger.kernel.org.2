Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3B9400CA6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhIDScK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhIDSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:31:59 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01508C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 11:30:56 -0700 (PDT)
Received: from localhost.localdomain (83.6.166.194.neoplus.adsl.tpnet.pl [83.6.166.194])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 332713EE34;
        Sat,  4 Sep 2021 20:30:54 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] clk: qcom: gcc-msm8994: Remove the inexistent GDSC_PCIE
Date:   Sat,  4 Sep 2021 20:30:10 +0200
Message-Id: <20210904183014.43528-6-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904183014.43528-1-konrad.dybcio@somainline.org>
References: <20210904183014.43528-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GDSC is not present on msm8994.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
[no changes since v2]

 drivers/clk/qcom/gcc-msm8994.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 98b2fd429629..2ed206ecb60d 100644
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
2.33.0

