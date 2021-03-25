Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D579348A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhCYHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:52:06 -0400
Received: from st43p00im-zteg10063401.me.com ([17.58.63.175]:44237 "EHLO
        st43p00im-zteg10063401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230046AbhCYHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616658691; bh=ye/Yow2uMjJ8Ying0ux4B6YZilHhDS6s68d+MR8JALc=;
        h=From:To:Subject:Date:Message-Id;
        b=bh9P2LB0HtQi47HygNddclQe9DH0h9J9+87yYKKamNWEIdOr76iDwIALZkxONp/MY
         acfVENZrIqfkMQHY+6WplUO/UiYwF08FrzaxFWOUQQxYfyaefgyLdrvu7/a0T6VptR
         DVR5479QBHzP9+KOTj1nQ+m93Vvveajga+eJDCF4QegJ7rgelw5Uo2w3kKGZBApzED
         kov0gTWNZaUOGemH0uGWd3VEft7H93FIkEiZkTVz/mWqK6aeNe9+S6B4VU6e57+03S
         D5NqwtiTZp8GvvHGUn6P0MpKmHOi6ezHtBr/J4WMffLaO21yL5aGyY3p5trkAOYXDs
         rw2H1C2i/MWkQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10063401.me.com (Postfix) with ESMTPSA id 114B84A05BE;
        Thu, 25 Mar 2021 07:51:30 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 06/16] clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
Date:   Thu, 25 Mar 2021 08:50:08 +0100
Message-Id: <20210325075018.6598-7-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325075018.6598-1-avolmat@me.com>
References: <20210325075018.6598-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-24=5F14:2021-03-24=5F02,2021-03-24=5F14,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250059
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
v2: clk-s-c0-fs0-ch0 do not need to be CLK_IS_CRITICAL

 drivers/clk/st/clkgen-fsyn.c | 113 +++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index dd6062e043e0..164285d6be97 100644
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
+	{ .name = "clk-s-c0-fs0-ch0",	},
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

