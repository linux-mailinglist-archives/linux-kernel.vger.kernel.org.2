Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498B348A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCYHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:51:30 -0400
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:50868 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhCYHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616658671; bh=hKG5T7bYHrQPsBqbs4Xy12N7hh0sIGFRHUGlhYKBAKY=;
        h=From:To:Subject:Date:Message-Id;
        b=QabYvOCAE6dEVW1kqM4hUiYmDXH3b7JLRP0E2fJVKNfqXatsJZzz/LLa4+cIU8cZW
         /k0OkJtWiRD/yMR1F2hacBfCQkKcVFq2ZFrQijo8A7l4mbakjYFP/ZKcYPBl1+DeLU
         gXUDzVJTLjGzy13ovbPcAp/c2vYfzIEaL/hUDVU7NFml5rxmW5k+ldZyDRmI1lLIdz
         7Hb3VQIO4rHZXljI/gzIJLHzVNTk/4+bPGsbuqjoCH7P0olN2Z8mTX82wH1KP2tGi9
         9WIVFZXxKbLZbdAUqZ37FBh3NfjgRw0nWZSY9r/TXk6m0EsERUzQxsmoDOc1xZjFCZ
         Jz+EpWugSNX/Q==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id 68809700217;
        Thu, 25 Mar 2021 07:51:10 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 02/16] clk: st: flexgen: embed soc clock outputs within compatible data
Date:   Thu, 25 Mar 2021 08:50:04 +0100
Message-Id: <20210325075018.6598-3-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325075018.6598-1-avolmat@me.com>
References: <20210325075018.6598-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-25=5F01:2021-03-24=5F01,2021-03-25=5F01,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
v2: add some missing clock as CLK_IS_CRITICAL

 drivers/clk/st/clk-flexgen.c | 344 +++++++++++++++++++++++++++++++++--
 1 file changed, 330 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 55873d4b7603..24dd0c7dc6c3 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -16,9 +16,16 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+struct clkgen_clk_out {
+	const char *name;
+	unsigned long flags;
+};
+
 struct clkgen_data {
 	unsigned long flags;
 	bool mode;
+	const struct clkgen_clk_out *outputs;
+	const unsigned int outputs_nb;
 };
 
 struct flexgen {
@@ -295,6 +302,267 @@ static const struct clkgen_data clkgen_video = {
 	.mode = 1,
 };
 
+static const struct clkgen_clk_out clkgen_stih407_a0_clk_out[] = {
+	{ .name = "clk-ic-lmi0", .flags = CLK_IS_CRITICAL },
+};
+
+static const struct clkgen_data clkgen_stih407_a0 = {
+	.outputs = clkgen_stih407_a0_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih407_a0_clk_out),
+};
+
+static const struct clkgen_clk_out clkgen_stih410_a0_clk_out[] = {
+	{ .name = "clk-ic-lmi0", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-ic-lmi1", .flags = CLK_IS_CRITICAL },
+};
+
+static const struct clkgen_data clkgen_stih410_a0 = {
+	.outputs = clkgen_stih410_a0_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih410_a0_clk_out),
+};
+
+static const struct clkgen_clk_out clkgen_stih407_c0_clk_out[] = {
+	{ .name = "clk-icn-gpu", },
+	{ .name = "clk-fdma", },
+	{ .name = "clk-nand", },
+	{ .name = "clk-hva", },
+	{ .name = "clk-proc-stfe", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-proc-tp", },
+	{ .name = "clk-rx-icn-dmu", },
+	{ .name = "clk-rx-icn-hva", },
+	{ .name = "clk-icn-cpu", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-tx-icn-dmu", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-mmc-0", },
+	{ .name = "clk-mmc-1", },
+	{ .name = "clk-jpegdec", },
+	{ .name = "clk-ext2fa9", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-ic-bdisp-0", },
+	{ .name = "clk-ic-bdisp-1", },
+	{ .name = "clk-pp-dmu", },
+	{ .name = "clk-vid-dmu", },
+	{ .name = "clk-dss-lpc", },
+	{ .name = "clk-st231-aud-0", },
+	{ .name = "clk-st231-gp-1", },
+	{ .name = "clk-st231-dmu", },
+	{ .name = "clk-icn-lmi", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-tx-icn-disp-1", },
+	{ .name = "clk-icn-sbc", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-stfe-frc2", },
+	{ .name = "clk-eth-phy", },
+	{ .name = "clk-eth-ref-phyclk", },
+	{ .name = "clk-flash-promip", },
+	{ .name = "clk-main-disp", },
+	{ .name = "clk-aux-disp", },
+	{ .name = "clk-compo-dvp", },
+};
+
+static const struct clkgen_data clkgen_stih407_c0 = {
+	.outputs = clkgen_stih407_c0_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih407_c0_clk_out),
+};
+
+static const struct clkgen_clk_out clkgen_stih410_c0_clk_out[] = {
+	{ .name = "clk-icn-gpu", },
+	{ .name = "clk-fdma", },
+	{ .name = "clk-nand", },
+	{ .name = "clk-hva", },
+	{ .name = "clk-proc-stfe", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-proc-tp", },
+	{ .name = "clk-rx-icn-dmu", },
+	{ .name = "clk-rx-icn-hva", },
+	{ .name = "clk-icn-cpu", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-tx-icn-dmu", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-mmc-0", },
+	{ .name = "clk-mmc-1", },
+	{ .name = "clk-jpegdec", },
+	{ .name = "clk-ext2fa9", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-ic-bdisp-0", },
+	{ .name = "clk-ic-bdisp-1", },
+	{ .name = "clk-pp-dmu", },
+	{ .name = "clk-vid-dmu", },
+	{ .name = "clk-dss-lpc", },
+	{ .name = "clk-st231-aud-0", },
+	{ .name = "clk-st231-gp-1", },
+	{ .name = "clk-st231-dmu", },
+	{ .name = "clk-icn-lmi", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-tx-icn-disp-1", },
+	{ .name = "clk-icn-sbc", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-stfe-frc2", },
+	{ .name = "clk-eth-phy", },
+	{ .name = "clk-eth-ref-phyclk", },
+	{ .name = "clk-flash-promip", },
+	{ .name = "clk-main-disp", },
+	{ .name = "clk-aux-disp", },
+	{ .name = "clk-compo-dvp", },
+	{ .name = "clk-tx-icn-hades", },
+	{ .name = "clk-rx-icn-hades", },
+	{ .name = "clk-icn-reg-16", },
+	{ .name = "clk-pp-hades", },
+	{ .name = "clk-clust-hades", },
+	{ .name = "clk-hwpe-hades", },
+	{ .name = "clk-fc-hades", },
+};
+
+static const struct clkgen_data clkgen_stih410_c0 = {
+	.outputs = clkgen_stih410_c0_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih410_c0_clk_out),
+};
+
+static const struct clkgen_clk_out clkgen_stih418_c0_clk_out[] = {
+	{ .name = "clk-icn-gpu", },
+	{ .name = "clk-fdma", },
+	{ .name = "clk-nand", },
+	{ .name = "clk-hva", },
+	{ .name = "clk-proc-stfe", },
+	{ .name = "clk-tp", },
+	{ .name = "clk-rx-icn-dmu", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-rx-icn-hva", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-icn-cpu", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-tx-icn-dmu", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-mmc-0", },
+	{ .name = "clk-mmc-1", },
+	{ .name = "clk-jpegdec", },
+	{ .name = "clk-icn-reg", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-proc-bdisp-0", },
+	{ .name = "clk-proc-bdisp-1", },
+	{ .name = "clk-pp-dmu", },
+	{ .name = "clk-vid-dmu", },
+	{ .name = "clk-dss-lpc", },
+	{ .name = "clk-st231-aud-0", },
+	{ .name = "clk-st231-gp-1", },
+	{ .name = "clk-st231-dmu", },
+	{ .name = "clk-icn-lmi", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-tx-icn-1", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-icn-sbc", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-stfe-frc2", },
+	{ .name = "clk-eth-phyref", },
+	{ .name = "clk-eth-ref-phyclk", },
+	{ .name = "clk-flash-promip", },
+	{ .name = "clk-main-disp", },
+	{ .name = "clk-aux-disp", },
+	{ .name = "clk-compo-dvp", },
+	{ .name = "clk-tx-icn-hades", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-rx-icn-hades", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-icn-reg-16", .flags = CLK_IS_CRITICAL },
+	{ .name = "clk-pp-hevc", },
+	{ .name = "clk-clust-hevc", },
+	{ .name = "clk-hwpe-hevc", },
+	{ .name = "clk-fc-hevc", },
+	{ .name = "clk-proc-mixer", },
+	{ .name = "clk-proc-sc", },
+	{ .name = "clk-avsp-hevc", },
+};
+
+static const struct clkgen_data clkgen_stih418_c0 = {
+	.outputs = clkgen_stih418_c0_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih418_c0_clk_out),
+};
+
+static const struct clkgen_clk_out clkgen_stih407_d0_clk_out[] = {
+	{ .name = "clk-pcm-0", },
+	{ .name = "clk-pcm-1", },
+	{ .name = "clk-pcm-2", },
+	{ .name = "clk-spdiff", },
+};
+
+static const struct clkgen_data clkgen_stih407_d0 = {
+	.flags = CLK_SET_RATE_PARENT,
+	.outputs = clkgen_stih407_d0_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih407_d0_clk_out),
+};
+
+static const struct clkgen_clk_out clkgen_stih410_d0_clk_out[] = {
+	{ .name = "clk-pcm-0", },
+	{ .name = "clk-pcm-1", },
+	{ .name = "clk-pcm-2", },
+	{ .name = "clk-spdiff", },
+	{ .name = "clk-pcmr10-master", },
+	{ .name = "clk-usb2-phy", },
+};
+
+static const struct clkgen_data clkgen_stih410_d0 = {
+	.flags = CLK_SET_RATE_PARENT,
+	.outputs = clkgen_stih410_d0_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih410_d0_clk_out),
+};
+
+static const struct clkgen_clk_out clkgen_stih407_d2_clk_out[] = {
+	{ .name = "clk-pix-main-disp", },
+	{ .name = "clk-pix-pip", },
+	{ .name = "clk-pix-gdp1", },
+	{ .name = "clk-pix-gdp2", },
+	{ .name = "clk-pix-gdp3", },
+	{ .name = "clk-pix-gdp4", },
+	{ .name = "clk-pix-aux-disp", },
+	{ .name = "clk-denc", },
+	{ .name = "clk-pix-hddac", },
+	{ .name = "clk-hddac", },
+	{ .name = "clk-sddac", },
+	{ .name = "clk-pix-dvo", },
+	{ .name = "clk-dvo", },
+	{ .name = "clk-pix-hdmi", },
+	{ .name = "clk-tmds-hdmi", },
+	{ .name = "clk-ref-hdmiphy", },
+};
+
+static const struct clkgen_data clkgen_stih407_d2 = {
+	.outputs = clkgen_stih407_d2_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih407_d2_clk_out),
+	.flags = CLK_SET_RATE_PARENT,
+	.mode = 1,
+};
+
+static const struct clkgen_clk_out clkgen_stih418_d2_clk_out[] = {
+	{ .name = "clk-pix-main-disp", },
+	{ .name = "", },
+	{ .name = "", },
+	{ .name = "", },
+	{ .name = "", },
+	{ .name = "clk-tmds-hdmi-div2", },
+	{ .name = "clk-pix-aux-disp", },
+	{ .name = "clk-denc", },
+	{ .name = "clk-pix-hddac", },
+	{ .name = "clk-hddac", },
+	{ .name = "clk-sddac", },
+	{ .name = "clk-pix-dvo", },
+	{ .name = "clk-dvo", },
+	{ .name = "clk-pix-hdmi", },
+	{ .name = "clk-tmds-hdmi", },
+	{ .name = "clk-ref-hdmiphy", },
+	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "", }, { .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "", }, { .name = "", }, { .name = "", },
+	{ .name = "clk-vp9", },
+};
+
+static const struct clkgen_data clkgen_stih418_d2 = {
+	.outputs = clkgen_stih418_d2_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih418_d2_clk_out),
+	.flags = CLK_SET_RATE_PARENT,
+	.mode = 1,
+};
+
+static const struct clkgen_clk_out clkgen_stih407_d3_clk_out[] = {
+	{ .name = "clk-stfe-frc1", },
+	{ .name = "clk-tsout-0", },
+	{ .name = "clk-tsout-1", },
+	{ .name = "clk-mchi", },
+	{ .name = "clk-vsens-compo", },
+	{ .name = "clk-frc1-remote", },
+	{ .name = "clk-lpc-0", },
+	{ .name = "clk-lpc-1", },
+};
+
+static const struct clkgen_data clkgen_stih407_d3 = {
+	.outputs = clkgen_stih407_d3_clk_out,
+	.outputs_nb = ARRAY_SIZE(clkgen_stih407_d3_clk_out),
+};
+
 static const struct of_device_id flexgen_of_match[] = {
 	{
 		.compatible = "st,flexgen-audio",
@@ -304,6 +572,46 @@ static const struct of_device_id flexgen_of_match[] = {
 		.compatible = "st,flexgen-video",
 		.data = &clkgen_video,
 	},
+	{
+		.compatible = "st,flexgen-stih407-a0",
+		.data = &clkgen_stih407_a0,
+	},
+	{
+		.compatible = "st,flexgen-stih410-a0",
+		.data = &clkgen_stih410_a0,
+	},
+	{
+		.compatible = "st,flexgen-stih407-c0",
+		.data = &clkgen_stih407_c0,
+	},
+	{
+		.compatible = "st,flexgen-stih410-c0",
+		.data = &clkgen_stih410_c0,
+	},
+	{
+		.compatible = "st,flexgen-stih418-c0",
+		.data = &clkgen_stih418_c0,
+	},
+	{
+		.compatible = "st,flexgen-stih407-d0",
+		.data = &clkgen_stih407_d0,
+	},
+	{
+		.compatible = "st,flexgen-stih410-d0",
+		.data = &clkgen_stih410_d0,
+	},
+	{
+		.compatible = "st,flexgen-stih407-d2",
+		.data = &clkgen_stih407_d2,
+	},
+	{
+		.compatible = "st,flexgen-stih418-d2",
+		.data = &clkgen_stih418_d2,
+	},
+	{
+		.compatible = "st,flexgen-stih407-d3",
+		.data = &clkgen_stih407_d3,
+	},
 	{}
 };
 
@@ -320,6 +628,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	unsigned long flex_flags = 0;
 	int ret;
 	bool clk_mode = 0;
+	const char *clk_name;
 
 	pnode = of_get_parent(np);
 	if (!pnode)
@@ -347,13 +656,17 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	if (!clk_data)
 		goto err;
 
-	ret = of_property_count_strings(np, "clock-output-names");
-	if (ret <= 0) {
-		pr_err("%s: Failed to get number of output clocks (%d)",
-				__func__, clk_data->clk_num);
-		goto err;
-	}
-	clk_data->clk_num = ret;
+	/* First try to get output information from the compatible data */
+	if (!data || !data->outputs_nb || !data->outputs) {
+		ret = of_property_count_strings(np, "clock-output-names");
+		if (ret <= 0) {
+			pr_err("%s: Failed to get number of output clocks (%d)",
+					__func__, clk_data->clk_num);
+			goto err;
+		}
+		clk_data->clk_num = ret;
+	} else
+		clk_data->clk_num = data->outputs_nb;
 
 	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
 			GFP_KERNEL);
@@ -368,16 +681,19 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 
 	for (i = 0; i < clk_data->clk_num; i++) {
 		struct clk *clk;
-		const char *clk_name;
 
-		if (of_property_read_string_index(np, "clock-output-names",
-						  i, &clk_name)) {
-			break;
+		if (!data || !data->outputs_nb || !data->outputs) {
+			if (of_property_read_string_index(np,
+							  "clock-output-names",
+							  i, &clk_name))
+				break;
+			flex_flags &= ~CLK_IS_CRITICAL;
+			of_clk_detect_critical(np, i, &flex_flags);
+		} else {
+			clk_name = data->outputs[i].name;
+			flex_flags = data->flags | data->outputs[i].flags;
 		}
 
-		flex_flags &= ~CLK_IS_CRITICAL;
-		of_clk_detect_critical(np, i, &flex_flags);
-
 		/*
 		 * If we read an empty clock name then the output is unused
 		 */
-- 
2.17.1

