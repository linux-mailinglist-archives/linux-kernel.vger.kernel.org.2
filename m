Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CEF32060A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBTP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 10:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBTP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 10:57:33 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34395C061786;
        Sat, 20 Feb 2021 07:56:38 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id A10AD1F4A3;
        Sat, 20 Feb 2021 16:56:33 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/6] clk: qcom: gcc-sdm660: Set HWCG bit to 1 on some clocks
Date:   Sat, 20 Feb 2021 16:56:13 +0100
Message-Id: <20210220155618.176559-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210220155618.176559-1-konrad.dybcio@somainline.org>
References: <20210220155618.176559-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the downstream kernel, some clocks need to have
HWCG disabled. Fix it.

Fixes: f2a76a2955c0 ("clk: qcom: Add Global Clock controller (GCC) driver for SDM660")
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/gcc-sdm660.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index 597800ce1bdf..2bf4e29462e8 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -980,6 +980,8 @@ static struct clk_rcg2 usb3_phy_aux_clk_src = {
 static struct clk_branch gcc_aggre2_ufs_axi_clk = {
 	.halt_reg = 0x75034,
 	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x75034,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x75034,
 		.enable_mask = BIT(0),
@@ -1027,6 +1029,8 @@ static struct clk_branch gcc_bimc_gfx_clk = {
 static struct clk_branch gcc_bimc_hmss_axi_clk = {
 	.halt_reg = 0x48004,
 	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x48004,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(22),
@@ -1698,6 +1702,8 @@ static struct clk_branch gcc_mmss_noc_cfg_ahb_clk = {
 static struct clk_branch gcc_mmss_sys_noc_axi_clk = {
 	.halt_reg = 0x9000,
 	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x9000,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x9000,
 		.enable_mask = BIT(0),
@@ -1956,6 +1962,8 @@ static struct clk_branch gcc_ufs_ahb_clk = {
 static struct clk_branch gcc_ufs_axi_clk = {
 	.halt_reg = 0x75008,
 	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x75008,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x75008,
 		.enable_mask = BIT(0),
-- 
2.30.1

