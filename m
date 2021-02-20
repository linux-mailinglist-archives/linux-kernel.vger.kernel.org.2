Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14B0320602
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 16:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBTP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 10:57:18 -0500
Received: from relay04.th.seeweb.it ([5.144.164.165]:44539 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBTP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 10:57:16 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id C05381F5FA;
        Sat, 20 Feb 2021 16:56:31 +0100 (CET)
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
Subject: [PATCH 1/6] clk: qcom: gcc-sdm660: Fix hmss_gpll0_clk_src parent_map
Date:   Sat, 20 Feb 2021 16:56:12 +0100
Message-Id: <20210220155618.176559-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct one is gcc_parent_map_xo_gpll0.

Fixes: f2a76a2955c0 ("clk: qcom: Add Global Clock controller (GCC) driver for SDM660")
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/gcc-sdm660.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index 6394257ca8c0..597800ce1bdf 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -626,12 +626,12 @@ static struct clk_rcg2 hmss_gpll0_clk_src = {
 	.cmd_rcgr = 0x4805c,
 	.mnd_width = 0,
 	.hid_width = 5,
-	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.parent_map = gcc_parent_map_xo_gpll0,
 	.freq_tbl = ftbl_hmss_gpll0_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "hmss_gpll0_clk_src",
-		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
-		.num_parents = 3,
+		.parent_names = gcc_parent_names_xo_gpll0,
+		.num_parents = 2,
 		.ops = &clk_rcg2_ops,
 	},
 };
-- 
2.30.1

