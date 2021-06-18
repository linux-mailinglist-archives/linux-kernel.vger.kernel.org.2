Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828E23AC9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhFRLRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:17:04 -0400
Received: from relay07.th.seeweb.it ([5.144.164.168]:34393 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhFRLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:16:57 -0400
Received: from localhost.localdomain (83.6.168.10.neoplus.adsl.tpnet.pl [83.6.168.10])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 8BA783EE72;
        Fri, 18 Jun 2021 13:14:44 +0200 (CEST)
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
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] clk: qcom: mmcc-msm8994: Add MSM8992 support
Date:   Fri, 18 Jun 2021 13:14:34 +0200
Message-Id: <20210618111435.595689-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618111435.595689-1-konrad.dybcio@somainline.org>
References: <20210618111435.595689-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8992 features less clocks & GDSCS and has different
freq tables for some of them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v2:
- Use NULL instead of 0 for disabled clocks

 drivers/clk/qcom/mmcc-msm8994.c | 126 ++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8994.c b/drivers/clk/qcom/mmcc-msm8994.c
index 7f65c0e61908..89c5f5fa7d9a 100644
--- a/drivers/clk/qcom/mmcc-msm8994.c
+++ b/drivers/clk/qcom/mmcc-msm8994.c
@@ -329,6 +329,14 @@ static const struct freq_tbl ftbl_axi_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_axi_clk_src_8992[] = {
+	F(75000000, P_GPLL0, 8, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(404000000, P_MMPLL1, 2, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 axi_clk_src = {
 	.cmd_rcgr = 0x5040,
 	.hid_width = 5,
@@ -349,6 +357,12 @@ static const struct freq_tbl ftbl_csi0_1_2_3_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_csi0_1_2_3_clk_src_8992[] = {
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(266670000, P_MMPLL0, 3, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 csi0_clk_src = {
 	.cmd_rcgr = 0x3090,
 	.hid_width = 5,
@@ -375,6 +389,16 @@ static const struct freq_tbl ftbl_vcodec0_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_vcodec0_clk_src_8992[] = {
+	F(66670000, P_GPLL0, 9, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(133330000, P_GPLL0, 4.5, 0, 0),
+	F(200000000, P_MMPLL0, 4, 0, 0),
+	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	F(510000000, P_MMPLL3, 2, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 vcodec0_clk_src = {
 	.cmd_rcgr = 0x1000,
 	.mnd_width = 8,
@@ -440,6 +464,16 @@ static const struct freq_tbl ftbl_vfe0_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_vfe0_1_clk_src_8992[] = {
+	F(80000000, P_GPLL0, 7.5, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	F(480000000, P_MMPLL4, 2, 0, 0),
+	F(600000000, P_GPLL0, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 vfe0_clk_src = {
 	.cmd_rcgr = 0x3600,
 	.hid_width = 5,
@@ -486,6 +520,15 @@ static const struct freq_tbl ftbl_cpp_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_cpp_clk_src_8992[] = {
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	F(480000000, P_MMPLL4, 2, 0, 0),
+	F(640000000, P_MMPLL4, 1.5, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 cpp_clk_src = {
 	.cmd_rcgr = 0x3640,
 	.hid_width = 5,
@@ -601,6 +644,17 @@ static const struct freq_tbl ftbl_mdp_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_mdp_clk_src_8992[] = {
+	F(85710000, P_GPLL0, 7, 0, 0),
+	F(171430000, P_GPLL0, 3.5, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(240000000, P_GPLL0, 2.5, 0, 0),
+	F(266670000, P_MMPLL0, 3, 0, 0),
+	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	F(400000000, P_MMPLL0, 2, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 mdp_clk_src = {
 	.cmd_rcgr = 0x2040,
 	.hid_width = 5,
@@ -654,6 +708,16 @@ static const struct freq_tbl ftbl_ocmemnoc_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_ocmemnoc_clk_src_8992[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(75000000, P_GPLL0, 8, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	F(400000000, P_MMPLL0, 2, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 ocmemnoc_clk_src = {
 	.cmd_rcgr = 0x5090,
 	.hid_width = 5,
@@ -767,6 +831,35 @@ static const struct freq_tbl ftbl_mclk0_1_2_3_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_mclk0_clk_src_8992[] = {
+	F(4800000, P_XO, 4, 0, 0),
+	F(6000000, P_MMPLL4, 10, 1, 16),
+	F(8000000, P_MMPLL4, 10, 1, 12),
+	F(9600000, P_XO, 2, 0, 0),
+	F(12000000, P_MMPLL4, 10, 1, 8),
+	F(16000000, P_MMPLL4, 10, 1, 6),
+	F(19200000, P_XO, 1, 0, 0),
+	F(24000000, P_MMPLL4, 10, 1, 4),
+	F(32000000, P_MMPLL4, 10, 1, 3),
+	F(48000000, P_MMPLL4, 10, 1, 2),
+	F(64000000, P_MMPLL4, 15, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_mclk1_2_3_clk_src_8992[] = {
+	F(4800000, P_XO, 4, 0, 0),
+	F(6000000, P_MMPLL4, 10, 1, 16),
+	F(8000000, P_MMPLL4, 10, 1, 12),
+	F(9600000, P_XO, 2, 0, 0),
+	F(16000000, P_MMPLL4, 10, 1, 6),
+	F(19200000, P_XO, 1, 0, 0),
+	F(24000000, P_MMPLL4, 10, 1, 4),
+	F(32000000, P_MMPLL4, 10, 1, 3),
+	F(48000000, P_MMPLL4, 10, 1, 2),
+	F(64000000, P_MMPLL4, 15, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 mclk0_clk_src = {
 	.cmd_rcgr = 0x3360,
 	.mnd_width = 8,
@@ -2468,6 +2561,39 @@ static int mmcc_msm8994_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,mmcc-msm8992")) {
+		/* MSM8992 features less clocks and some have different freq tables */
+		mmcc_msm8994_desc.clks[CAMSS_JPEG_JPEG1_CLK] = NULL;
+		mmcc_msm8994_desc.clks[CAMSS_JPEG_JPEG2_CLK] = NULL;
+		mmcc_msm8994_desc.clks[FD_CORE_CLK_SRC] = NULL;
+		mmcc_msm8994_desc.clks[FD_CORE_CLK] = NULL;
+		mmcc_msm8994_desc.clks[FD_CORE_UAR_CLK] = NULL;
+		mmcc_msm8994_desc.clks[FD_AXI_CLK] = NULL;
+		mmcc_msm8994_desc.clks[FD_AHB_CLK] = NULL;
+		mmcc_msm8994_desc.clks[JPEG1_CLK_SRC] = NULL;
+		mmcc_msm8994_desc.clks[JPEG2_CLK_SRC] = NULL;
+		mmcc_msm8994_desc.clks[VENUS0_CORE2_VCODEC_CLK] = NULL;
+
+		mmcc_msm8994_desc.gdscs[FD_GDSC] = NULL;
+		mmcc_msm8994_desc.gdscs[VENUS_CORE2_GDSC] = NULL;
+
+		axi_clk_src.freq_tbl = ftbl_axi_clk_src_8992;
+		cpp_clk_src.freq_tbl = ftbl_cpp_clk_src_8992;
+		csi0_clk_src.freq_tbl = ftbl_csi0_1_2_3_clk_src_8992;
+		csi1_clk_src.freq_tbl = ftbl_csi0_1_2_3_clk_src_8992;
+		csi2_clk_src.freq_tbl = ftbl_csi0_1_2_3_clk_src_8992;
+		csi3_clk_src.freq_tbl = ftbl_csi0_1_2_3_clk_src_8992;
+		mclk0_clk_src.freq_tbl = ftbl_mclk0_clk_src_8992;
+		mclk1_clk_src.freq_tbl = ftbl_mclk1_2_3_clk_src_8992;
+		mclk2_clk_src.freq_tbl = ftbl_mclk1_2_3_clk_src_8992;
+		mclk3_clk_src.freq_tbl = ftbl_mclk1_2_3_clk_src_8992;
+		mdp_clk_src.freq_tbl = ftbl_mdp_clk_src_8992;
+		ocmemnoc_clk_src.freq_tbl = ftbl_ocmemnoc_clk_src_8992;
+		vcodec0_clk_src.freq_tbl = ftbl_vcodec0_clk_src_8992;
+		vfe0_clk_src.freq_tbl = ftbl_vfe0_1_clk_src_8992;
+		vfe1_clk_src.freq_tbl = ftbl_vfe0_1_clk_src_8992;
+	}
+
 	regmap = qcom_cc_map(pdev, &mmcc_msm8994_desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-- 
2.32.0

