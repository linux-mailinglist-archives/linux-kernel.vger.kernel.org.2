Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15473434AC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCUUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:19 -0400
Received: from st43p00im-zteg10073501.me.com ([17.58.63.180]:36642 "EHLO
        st43p00im-zteg10073501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230140AbhCUUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359301; bh=X4MeOL+kLIMJdimcnCQWkF4wzY1RID7Sv0B1gSmDAp4=;
        h=From:To:Subject:Date:Message-Id;
        b=kw4QM485mMBk7ca8gDGFPRojzDhlRXuoziJSSGxmH/FGeyzbHn0COanCDN9dGMDde
         sCuU2JIliGdXxh2zlGkHkIxHzTzDkhJX3VMDbev6SRw6/Ed3qwfWD8LlF45ejj3gCd
         HNFSkl8OlqLRJENmM5zb29y136vndUUR7FLg9M8BOdmQieFwGXmYsyUEHwSXLgj2mS
         YD1coHDzCqHdveg62sNujGRGcffhzpkAZcQDgwKI/n5aPC42qbmusfHqU8Oj7XReBN
         mw2JlW/eZE48xQUImnx1UvpX+rjZzUPQ/vdbwgOh0BYAVhiIVzIOhuvgoNTYWW7I8G
         EHoLgmFKaddbQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10073501.me.com (Postfix) with ESMTPSA id 38633AE04B6;
        Sun, 21 Mar 2021 20:41:40 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 06/16] clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
Date:   Sun, 21 Mar 2021 21:40:28 +0100
Message-Id: <20210321204038.14417-7-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F02:2021-03-19=5F02,2021-03-21=5F02,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/clk/st/clkgen-fsyn.c | 113 +++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index dd6062e043e0..c44a59ba4d85 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -66,6 +66,16 @@ struct clkgen_quadfs_data {
 			unsigned long *);
 };
 
+struct clkgen_clk_out {
+	const char *name;
+	unsigned long flags;
+};
+
+struct clkgen_quadfs_data_clks {
+	struct clkgen_quadfs_data *data;
+	const struct clkgen_clk_out *outputs;
+};
+
 static const struct clk_ops st_quadfs_pll_c32_ops;
 
 static int clk_fs660c32_dig_get_params(unsigned long input,
@@ -115,6 +125,18 @@ static const struct clkgen_quadfs_data st_fs660c32_C = {
 	.get_rate	= clk_fs660c32_dig_get_rate,
 };
 
+static const struct clkgen_clk_out st_fs660c32_C_clks[] = {
+	{ .name = "clk-s-c0-fs0-ch0",	.flags = CLK_IS_CRITICAL,	},
+	{ .name = "clk-s-c0-fs0-ch1",	},
+	{ .name = "clk-s-c0-fs0-ch2",	},
+	{ .name = "clk-s-c0-fs0-ch3",	},
+};
+
+static const struct clkgen_quadfs_data_clks st_fs660c32_C_data = {
+	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_C,
+	.outputs	= st_fs660c32_C_clks,
+};
+
 static const struct clkgen_quadfs_data st_fs660c32_D = {
 	.nrst_present = true,
 	.nrst	= { CLKGEN_FIELD(0x2a0, 0x1, 0),
@@ -156,6 +178,46 @@ static const struct clkgen_quadfs_data st_fs660c32_D = {
 	.get_params	= clk_fs660c32_dig_get_params,
 	.get_rate	= clk_fs660c32_dig_get_rate,};
 
+static const struct clkgen_quadfs_data_clks st_fs660c32_D_data = {
+	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
+};
+
+static const struct clkgen_clk_out st_fs660c32_D0_clks[] = {
+	{ .name = "clk-s-d0-fs0-ch0",	},
+	{ .name = "clk-s-d0-fs0-ch1",	},
+	{ .name = "clk-s-d0-fs0-ch2",	},
+	{ .name = "clk-s-d0-fs0-ch3",	},
+};
+
+static const struct clkgen_quadfs_data_clks st_fs660c32_D0_data = {
+	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
+	.outputs	= st_fs660c32_D0_clks,
+};
+
+static const struct clkgen_clk_out st_fs660c32_D2_clks[] = {
+	{ .name = "clk-s-d2-fs0-ch0",	},
+	{ .name = "clk-s-d2-fs0-ch1",	},
+	{ .name = "clk-s-d2-fs0-ch2",	},
+	{ .name = "clk-s-d2-fs0-ch3",	},
+};
+
+static const struct clkgen_quadfs_data_clks st_fs660c32_D2_data = {
+	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
+	.outputs	= st_fs660c32_D2_clks,
+};
+
+static const struct clkgen_clk_out st_fs660c32_D3_clks[] = {
+	{ .name = "clk-s-d3-fs0-ch0",	},
+	{ .name = "clk-s-d3-fs0-ch1",	},
+	{ .name = "clk-s-d3-fs0-ch2",	},
+	{ .name = "clk-s-d3-fs0-ch3",	},
+};
+
+static const struct clkgen_quadfs_data_clks st_fs660c32_D3_data = {
+	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
+	.outputs	= st_fs660c32_D3_clks,
+};
+
 /**
  * DOC: A Frequency Synthesizer that multiples its input clock by a fixed factor
  *
@@ -857,7 +919,7 @@ static struct clk * __init st_clk_register_quadfs_fsynth(
 
 static void __init st_of_create_quadfs_fsynths(
 		struct device_node *np, const char *pll_name,
-		struct clkgen_quadfs_data *quadfs, void __iomem *reg,
+		struct clkgen_quadfs_data_clks *quadfs, void __iomem *reg,
 		spinlock_t *lock)
 {
 	struct clk_onecell_data *clk_data;
@@ -881,9 +943,15 @@ static void __init st_of_create_quadfs_fsynths(
 		const char *clk_name;
 		unsigned long flags = 0;
 
-		if (of_property_read_string_index(np, "clock-output-names",
-						  fschan, &clk_name)) {
-			break;
+		if (quadfs->outputs) {
+			clk_name = quadfs->outputs[fschan].name;
+			flags = quadfs->outputs[fschan].flags;
+		} else {
+			if (of_property_read_string_index(np,
+							"clock-output-names",
+							fschan, &clk_name))
+				break;
+			of_clk_detect_critical(np, fschan, &flags);
 		}
 
 		/*
@@ -892,10 +960,8 @@ static void __init st_of_create_quadfs_fsynths(
 		if (*clk_name == '\0')
 			continue;
 
-		of_clk_detect_critical(np, fschan, &flags);
-
 		clk = st_clk_register_quadfs_fsynth(clk_name, pll_name,
-						    quadfs, reg, fschan,
+						    quadfs->data, reg, fschan,
 						    flags, lock);
 
 		/*
@@ -915,7 +981,7 @@ static void __init st_of_create_quadfs_fsynths(
 }
 
 static void __init st_of_quadfs_setup(struct device_node *np,
-		struct clkgen_quadfs_data *data)
+		struct clkgen_quadfs_data_clks *datac)
 {
 	struct clk *clk;
 	const char *pll_name, *clk_parent_name;
@@ -940,7 +1006,7 @@ static void __init st_of_quadfs_setup(struct device_node *np,
 
 	spin_lock_init(lock);
 
-	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name, data,
+	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name, datac->data,
 			reg, lock);
 	if (IS_ERR(clk))
 		goto err_exit;
@@ -950,7 +1016,7 @@ static void __init st_of_quadfs_setup(struct device_node *np,
 			__clk_get_name(clk_get_parent(clk)),
 			(unsigned int)clk_get_rate(clk));
 
-	st_of_create_quadfs_fsynths(np, pll_name, data, reg, lock);
+	st_of_create_quadfs_fsynths(np, pll_name, datac, reg, lock);
 
 err_exit:
 	kfree(pll_name); /* No longer need local copy of the PLL name */
@@ -958,12 +1024,35 @@ static void __init st_of_quadfs_setup(struct device_node *np,
 
 static void __init st_of_quadfs660C_setup(struct device_node *np)
 {
-	st_of_quadfs_setup(np, (struct clkgen_quadfs_data *) &st_fs660c32_C);
+	st_of_quadfs_setup(np,
+		(struct clkgen_quadfs_data_clks *) &st_fs660c32_C_data);
 }
 CLK_OF_DECLARE(quadfs660C, "st,quadfs-pll", st_of_quadfs660C_setup);
 
 static void __init st_of_quadfs660D_setup(struct device_node *np)
 {
-	st_of_quadfs_setup(np, (struct clkgen_quadfs_data *) &st_fs660c32_D);
+	st_of_quadfs_setup(np,
+		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D_data);
 }
 CLK_OF_DECLARE(quadfs660D, "st,quadfs", st_of_quadfs660D_setup);
+
+static void __init st_of_quadfs660D0_setup(struct device_node *np)
+{
+	st_of_quadfs_setup(np,
+		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D0_data);
+}
+CLK_OF_DECLARE(quadfs660D0, "st,quadfs-d0", st_of_quadfs660D0_setup);
+
+static void __init st_of_quadfs660D2_setup(struct device_node *np)
+{
+	st_of_quadfs_setup(np,
+		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D2_data);
+}
+CLK_OF_DECLARE(quadfs660D2, "st,quadfs-d2", st_of_quadfs660D2_setup);
+
+static void __init st_of_quadfs660D3_setup(struct device_node *np)
+{
+	st_of_quadfs_setup(np,
+		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D3_data);
+}
+CLK_OF_DECLARE(quadfs660D3, "st,quadfs-d3", st_of_quadfs660D3_setup);
-- 
2.17.1

