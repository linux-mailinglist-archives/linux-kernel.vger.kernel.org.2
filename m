Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330983434AA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCUUmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:12 -0400
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:57418 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230294AbhCUUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359294; bh=3u1XTWIcjXB2IcOSsqeQa0Y4q6YJMKkdn2vbQCLll40=;
        h=From:To:Subject:Date:Message-Id;
        b=X1Y9R8yFHlnQNUIePDtxqHfYr3KKvmAcsNzCYL7Y5t1lySjw1trmqIdFGrK1SXZb9
         PtJ/rYoYDcwxAfty8sa5Jfj/sp+Kyz8ni+P2Xrn1EmN0gomhK5Px1XpZ3w5ae2NVJO
         iAxuljO1L/PlA78WcZdpT5DnnlXGVUofGFUYSYsHoeLL9t69rHxJM30ul3EVYwbuVs
         JfVqmDIkTQ8zdZFIn4dyTwisYwMdVI84gRrClvwmSMRMFdszUbozzztbXDr3p9l9Nw
         gASHTE+t6sFqmkwTn2OCoH430HPkU9Mae97CH2g+3enC5L/Z+KqB4ndBK7RT2eRNnN
         gnpBlouYfy39Q==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id 7BCE19A050F;
        Sun, 21 Mar 2021 20:41:33 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 04/16] clk: st: clkgen-pll: embed soc clock outputs within compatible data
Date:   Sun, 21 Mar 2021 21:40:26 +0100
Message-Id: <20210321204038.14417-5-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F05:2021-03-19=5F01,2021-03-21=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid relying on the old style description via the DT
clock-output-names, add compatible data describing the flexgen
outputs clocks for all STiH407/STiH410 and STiH418 SOCs.

In order to ease transition between the two methods, this commit
introduce the new compatible without removing the old method.
Once DTs will be fixed, the method relying on DT clock-output-names
will be removed from this driver as well as old compatibles.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/clk/st/clkgen-pll.c | 120 +++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index f6c56ca90c7d..68863f79e1b5 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -57,6 +57,17 @@ struct clkgen_pll_data {
 	const struct clk_ops *ops;
 };
 
+struct clkgen_clk_out {
+	const char *name;
+	unsigned long flags;
+};
+
+struct clkgen_pll_data_clks {
+	struct clkgen_pll_data *data;
+	const struct clkgen_clk_out *outputs;
+};
+
+
 static const struct clk_ops stm_pll3200c32_ops;
 static const struct clk_ops stm_pll3200c32_a9_ops;
 static const struct clk_ops stm_pll4600c28_ops;
@@ -74,6 +85,28 @@ static const struct clkgen_pll_data st_pll3200c32_cx_0 = {
 	.ops		= &stm_pll3200c32_ops,
 };
 
+static const struct clkgen_pll_data_clks st_pll3200c32_cx_0_legacy_data = {
+	.data	= (struct clkgen_pll_data *)&st_pll3200c32_cx_0,
+};
+
+static const struct clkgen_clk_out st_pll3200c32_ax_0_clks[] = {
+	{ .name = "clk-s-a0-pll-odf-0",	.flags = CLK_IS_CRITICAL },
+};
+
+static const struct clkgen_pll_data_clks st_pll3200c32_a0_data = {
+	.data		= (struct clkgen_pll_data *)&st_pll3200c32_cx_0,
+	.outputs	= st_pll3200c32_ax_0_clks,
+};
+
+static const struct clkgen_clk_out st_pll3200c32_cx_0_clks[] = {
+	{ .name = "clk-s-c0-pll0-odf-0",	.flags = CLK_IS_CRITICAL },
+};
+
+static const struct clkgen_pll_data_clks st_pll3200c32_c0_data = {
+	.data		= (struct clkgen_pll_data *)&st_pll3200c32_cx_0,
+	.outputs	= st_pll3200c32_cx_0_clks,
+};
+
 static const struct clkgen_pll_data st_pll3200c32_cx_1 = {
 	/* 407 C0 PLL1 */
 	.pdn_status	= CLKGEN_FIELD(0x2c8,	0x1,			8),
@@ -87,6 +120,19 @@ static const struct clkgen_pll_data st_pll3200c32_cx_1 = {
 	.ops		= &stm_pll3200c32_ops,
 };
 
+static const struct clkgen_pll_data_clks st_pll3200c32_cx_1_legacy_data = {
+	.data	= (struct clkgen_pll_data *)&st_pll3200c32_cx_1,
+};
+
+static const struct clkgen_clk_out st_pll3200c32_cx_1_clks[] = {
+	{ .name = "clk-s-c0-pll1-odf-0",	},
+};
+
+static const struct clkgen_pll_data_clks st_pll3200c32_c1_data = {
+	.data		= (struct clkgen_pll_data *)&st_pll3200c32_cx_1,
+	.outputs	= st_pll3200c32_cx_1_clks,
+};
+
 static const struct clkgen_pll_data st_pll3200c32_407_a9 = {
 	/* 407 A9 */
 	.pdn_status	= CLKGEN_FIELD(0x1a8,	0x1,			0),
@@ -104,6 +150,15 @@ static const struct clkgen_pll_data st_pll3200c32_407_a9 = {
 	.ops		= &stm_pll3200c32_a9_ops,
 };
 
+static const struct clkgen_clk_out st_pll3200c32_407_a9_clks[] = {
+	{ .name = "clockgen-a9-pll-odf", },
+};
+
+static const struct clkgen_pll_data_clks st_pll3200c32_407_a9_data = {
+	.data		= (struct clkgen_pll_data *)&st_pll3200c32_407_a9,
+	.outputs	= st_pll3200c32_407_a9_clks,
+};
+
 static struct clkgen_pll_data st_pll4600c28_418_a9 = {
 	/* 418 A9 */
 	.pdn_status	= CLKGEN_FIELD(0x1a8,	0x1,			0),
@@ -120,6 +175,15 @@ static struct clkgen_pll_data st_pll4600c28_418_a9 = {
 	.ops		= &stm_pll4600c28_ops,
 };
 
+static const struct clkgen_clk_out st_pll4600c28_418_a9_clks[] = {
+	{ .name = "clockgen-a9-pll-odf", },
+};
+
+static const struct clkgen_pll_data_clks st_pll4600c28_418_a9_data = {
+	.data		= (struct clkgen_pll_data *)&st_pll4600c28_418_a9,
+	.outputs	= st_pll4600c28_418_a9_clks,
+};
+
 /**
  * DOC: Clock Generated by PLL, rate set and enabled by bootloader
  *
@@ -684,7 +748,7 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
 
 
 static void __init clkgen_c32_pll_setup(struct device_node *np,
-		struct clkgen_pll_data *data)
+		struct clkgen_pll_data_clks *datac)
 {
 	struct clk *clk;
 	const char *parent_name, *pll_name;
@@ -704,14 +768,14 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 
 	of_clk_detect_critical(np, 0, &pll_flags);
 
-	clk = clkgen_pll_register(parent_name, data, pll_base, pll_flags,
-				  np->name, data->lock);
+	clk = clkgen_pll_register(parent_name, datac->data, pll_base, pll_flags,
+				  np->name, datac->data->lock);
 	if (IS_ERR(clk))
 		return;
 
 	pll_name = __clk_get_name(clk);
 
-	num_odfs = data->num_odfs;
+	num_odfs = datac->data->num_odfs;
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
@@ -729,14 +793,21 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 		const char *clk_name;
 		unsigned long odf_flags = 0;
 
-		if (of_property_read_string_index(np, "clock-output-names",
-						  odf, &clk_name))
-			return;
+		if (datac->outputs) {
+			clk_name = datac->outputs[odf].name;
+			odf_flags = datac->outputs[odf].flags;
+		} else {
+			if (of_property_read_string_index(np,
+							  "clock-output-names",
+							  odf, &clk_name))
+				return;
 
-		of_clk_detect_critical(np, odf, &odf_flags);
+			of_clk_detect_critical(np, odf, &odf_flags);
+		}
 
-		clk = clkgen_odf_register(pll_name, pll_base, data, odf_flags,
-				odf, &clkgena_c32_odf_lock, clk_name);
+		clk = clkgen_odf_register(pll_name, pll_base, datac->data,
+				odf_flags, odf, &clkgena_c32_odf_lock,
+				clk_name);
 		if (IS_ERR(clk))
 			goto err;
 
@@ -754,27 +825,48 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 static void __init clkgen_c32_pll0_setup(struct device_node *np)
 {
 	clkgen_c32_pll_setup(np,
-			(struct clkgen_pll_data *) &st_pll3200c32_cx_0);
+		(struct clkgen_pll_data_clks *) &st_pll3200c32_cx_0_legacy_data);
 }
 CLK_OF_DECLARE(c32_pll0, "st,clkgen-pll0", clkgen_c32_pll0_setup);
 
+static void __init clkgen_c32_pll0_a0_setup(struct device_node *np)
+{
+	clkgen_c32_pll_setup(np,
+		(struct clkgen_pll_data_clks *) &st_pll3200c32_a0_data);
+}
+CLK_OF_DECLARE(c32_pll0_a0, "st,clkgen-pll0-a0", clkgen_c32_pll0_a0_setup);
+
+static void __init clkgen_c32_pll0_c0_setup(struct device_node *np)
+{
+	clkgen_c32_pll_setup(np,
+		(struct clkgen_pll_data_clks *) &st_pll3200c32_c0_data);
+}
+CLK_OF_DECLARE(c32_pll0_c0, "st,clkgen-pll0-c0", clkgen_c32_pll0_c0_setup);
+
 static void __init clkgen_c32_pll1_setup(struct device_node *np)
 {
 	clkgen_c32_pll_setup(np,
-			(struct clkgen_pll_data *) &st_pll3200c32_cx_1);
+		(struct clkgen_pll_data_clks *) &st_pll3200c32_cx_1_legacy_data);
 }
 CLK_OF_DECLARE(c32_pll1, "st,clkgen-pll1", clkgen_c32_pll1_setup);
 
+static void __init clkgen_c32_pll1_c0_setup(struct device_node *np)
+{
+	clkgen_c32_pll_setup(np,
+		(struct clkgen_pll_data_clks *) &st_pll3200c32_c1_data);
+}
+CLK_OF_DECLARE(c32_pll1_c0, "st,clkgen-pll1-c0", clkgen_c32_pll1_c0_setup);
+
 static void __init clkgen_c32_plla9_setup(struct device_node *np)
 {
 	clkgen_c32_pll_setup(np,
-			(struct clkgen_pll_data *) &st_pll3200c32_407_a9);
+		(struct clkgen_pll_data_clks *) &st_pll3200c32_407_a9_data);
 }
 CLK_OF_DECLARE(c32_plla9, "st,stih407-clkgen-plla9", clkgen_c32_plla9_setup);
 
 static void __init clkgen_c28_plla9_setup(struct device_node *np)
 {
 	clkgen_c32_pll_setup(np,
-			(struct clkgen_pll_data *) &st_pll4600c28_418_a9);
+		(struct clkgen_pll_data_clks *) &st_pll4600c28_418_a9_data);
 }
 CLK_OF_DECLARE(c28_plla9, "st,stih418-clkgen-plla9", clkgen_c28_plla9_setup);
-- 
2.17.1

