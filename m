Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD1348C88
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCYJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:15:54 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:26946
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229812AbhCYJPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA0Fv0NXjf6MxejH9JTkotYx0hvpy7CenG1rg3POfXixPGsk+DZ8+75x4p/avYECrj4DslEzoCbxmovXhFmCbTq4+lbhfgAd8QEA1BEJu2X2xlOhFcVRK1QEdtOg5J+0wIf2hNDa4+JMTca1tjrlvdF5TEi3ZDDc/lGTNfS/fjAqgCUh3rS25RGGvx0uXVuYJd/KZ/VS9My/AirWLDOYqb3Jd0Lo3v/7WJ2VOw0MSZktiQ3pdllnpC/K+o4ne31IcYg4S6M88bSKgPixslNuF4TEzV+OLhMe05Ae+7wzYZZR7Lg1bWaxoY3Ok18xa5yoTfHHC7YhlSywj7JOeRgXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47Id5AaZFapkL4ou76e5Dq9DA/qR0fEfwUZDX8cHhus=;
 b=Z3J3k2EW6KuFbk5jXhfXtU+njPbOxpzhSDv49aR7MdqP+e/MI+cAYjm1nSLYfyhLlBw4nVBHhNXWLJrrGXcDhmwQ/euxbPGzq8tlgGCx0E/muBoR4pw0WnGUyMrBomf+uy++WayNzOEi1QwdTk4BdsK7vTB0ysbjbGO14NlT2bgPhEis69jTCwUcM7VH79IYDU+i8ul/hZZOcQB0dYRdlee15SZswoWM+XuMUh2q5Znz01SzQtvc0I7/M2z2K4BAZz7eYeue578KlC9Mob4CZ+fjdxQMa0sNKd+dR8e5L5xtfyN3EgVhQ74c6JWwQQw+fjjJF7GFGORQrXiv4lSU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47Id5AaZFapkL4ou76e5Dq9DA/qR0fEfwUZDX8cHhus=;
 b=ShbwuGIPLQI4wPbjdBfRT36oCUXzfzKL2iTp5qwhxDOmyecgM1957/ERlc8YjDiS42ukXuSuqiRYcepoN9NVehDdvP/vnXtomsNlxjj06wlaatHnx0ncQUP7qpKU0y53k7QmXv3WezhVZ8o6NV4qwsIML3uOXHSljTHG+dFgaOo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB2975.eurprd04.prod.outlook.com (2603:10a6:802:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 09:15:17 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c%5]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 09:15:17 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm,
        robert.foss@linaro.org
Subject: [PATCH v5 5/5] phy: freescale: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY mode support
Date:   Thu, 25 Mar 2021 17:00:32 +0800
Message-Id: <1616662832-27048-6-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616662832-27048-1-git-send-email-victor.liu@nxp.com>
References: <1616662832-27048-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0164.apcprd02.prod.outlook.com (2603:1096:201:1f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 09:15:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c39f07a3-1e05-4f33-3b27-08d8ef6e8157
X-MS-TrafficTypeDiagnostic: VI1PR04MB2975:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB29754A6073F70A817FF16B2798629@VI1PR04MB2975.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQBNzquU5vMwJlyugSGO4cqXtdzmw/WqjsH+dhJIbUKFcWkocPWnrZBnVFjf8zb+yzk2B/sSwA8ePGxQ4n+Zgp4J5VOBbRnMdxlnzXw1ZWLhHaKWDno7QVZAqt/l7hQlzjwIMGOtQ3nDjQnrEYoPQozWd39PUQurJSIFEaloLOKcRKgKH1WIYTbQnyyW9XJ1wHNBlF4bwLk8BsWC3w6GnixMM2ppXS0nHD1JX7tAtfbLhA3njFito3xxYmheW2HT2n/JXSuc+ZIudtKd3zEnF7O+XH+dLFRcroD6ZP9eZIioXgJOus956jqcuPM9hs4reX6JW5sqEgH1YfgJ2P1t6Pik9yfBhqCacLfQyZ92zCitjrhOqPA4llsgk20dJNgdU3e1Fq25pKKuUBBtbT4Bg4OnaP/iQwm8BvGC90Z75UG4tWzoc6L5W2ozNpvcVUjjUTf/E/PaADiCdg6vvZjID9ESUiSFOA6K/LTfI0YuRIUf3nUQpmwZRV1Hjp6GLpOSzfzxdF/FvTNOUoj3pOTlRWL5IghCCLD2y6/HGCJ35+qGbLzMtDMcdPk+GjQ4TH0z4eQ+0Tmv4yV4jJgvAJPJ/1nqSBC5dJq/dTieiB1KWhd4b0X+oTdy6+x/uP/N9xK0vIqzK7/e4AzWCAUwHPRb8BgJMG4yuIrbrbFYXntC+EvqyTtz0gLE1I3LE8TVi/VW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(26005)(66574015)(4326008)(38100700001)(186003)(66946007)(52116002)(7416002)(83380400001)(36756003)(6506007)(2906002)(6486002)(86362001)(8936002)(66556008)(8676002)(316002)(6512007)(6666004)(66476007)(5660300002)(30864003)(956004)(2616005)(478600001)(16526019)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1hpNFBoVHVvY3VHWWlENUpBcElwd2YvM1BKYlFhdnZzanhnQklLaDdzYUNz?=
 =?utf-8?B?c0hTR0o3MnI4UlFyNkVOa093bWdDLzN5dVN2TmMvQTFNdkU2S1ozQ2l1MG4z?=
 =?utf-8?B?a01rMFJlcitYdmovSmVUd2tXbEJNNEZsTU5LKzFKcTYvV1l1Q2QzcmVydDg2?=
 =?utf-8?B?MUJMaEJNdzVrU3NXempHaEsrNzdPQndpMllJYVM2VzF0M05kdWVubEI1WDQx?=
 =?utf-8?B?eTNKbys0b0daQXluOXVTTU5aU1BOcEdlMGVUeTNzV2F3UU9VYUc3RXZDTlZY?=
 =?utf-8?B?YjA2TVlVcFVwSkdmamtHSHlvZEZnY3UxMGlmdng3cE9XVEZDUGlaN1JiOXFu?=
 =?utf-8?B?QjFFek8wM0EwRzBDV0ZwM3kzbjZlSHJOQXhaUzdic2lRRmJKeHQrWk1ETjFt?=
 =?utf-8?B?TUE2L1ZFTWpxWDZ2UnNCVTNPNzM1RFFSR29mdG1JL1RXaC9ycytQWGtUSDhV?=
 =?utf-8?B?MVU5aHNsOWNFVjlXRjZmdEFzaEhST25iQWVSVWxwMmlxKzIwRDRvaUFXdmdu?=
 =?utf-8?B?Ni8rTkpxRFE2ZTAyZGNXVXdqdXpxZ2NZNDVCTTJ0bkJEemxRRGhLSFZKNTIy?=
 =?utf-8?B?S2xKaGIzckV4MzcyRkhmaXpYdEwrdE5KOWxUdW1vVTJyaHhIZ252MkQybzlM?=
 =?utf-8?B?Q3FlVytreFRxVzJEMWd4YVh2blE0SVp1dUNwSFo2VFJ1bXJIT2FHWktsalBH?=
 =?utf-8?B?R2Z5YjN0VVJ1bFg4R0xqeEV6cnBpMWhMZjAvKzcyY1FhMTVtbWRJRFJ1b2s5?=
 =?utf-8?B?MlBzZ1RBVUNCTlJ4Z25ueTlZZEliSCs5amJ3SmtBUjhqV0xlWXVkNkFYcEV3?=
 =?utf-8?B?bFROSTdYM1VkZ2pOY3UraGhscnR0eWgwNVZjRmVqanB0MEZoOWl3bzRMaFk2?=
 =?utf-8?B?ak5ZVlVRVEpaYmw4WktTMDJoTEZSS1NtN2xuMk5QMXRBUzZWbW9QN0lPbjd4?=
 =?utf-8?B?Q29RSHVpRThOaHg4clUydTNyN1UranF6aFdwYXBFcGl0ekFSRERZb3V3UWUx?=
 =?utf-8?B?bFN3ZUJEZkZpWVY5eld0a1I5TStLUllQTGVLNURKZm9iS2crcFhnWDFsQjN1?=
 =?utf-8?B?TzI4aWJYbEZ0RTFSYzU2MlBGUThYYXpOQXg4N1pmdlkyYSsydUlsMzkrRnRU?=
 =?utf-8?B?ajNwMVNWVmFjN2dIME1vNThTTzZGYkltVTV3c1hhUlJsU0QybDFvSXBSYm5N?=
 =?utf-8?B?Y1NiM3J5L0JTaUVEeU9ROEU5WXZwSFlkL1lUaHNTL1FhR0hTbnplemJBWDQx?=
 =?utf-8?B?NkFNSENKNmhQQVV5Q2JxZ2U1TGxBbjVMbjljU0JiRkEvWUNHNnZtc0t3NkNx?=
 =?utf-8?B?V0hhdGMwZWcvcWZnWUFJd2R2aVRyeXdGeC9mVm5TbmZhdjRvQzdSYzFGdW9H?=
 =?utf-8?B?S0QweHdGU3I1SEw5ZVpvb1p6RnNib2xDeE9SWVZRTWdZc3NnekswQWlhL1dh?=
 =?utf-8?B?TENRS1hpMmY3bU9WWEpLMHorTStKZ3Q5clVBaU5GN0hYQllhU2x4bnNMOUVv?=
 =?utf-8?B?VDlzczZCTFVBRm40UG9VWlRnL3liUi81b2xTMGJaTEdkN3ROM2lsaDBJNU55?=
 =?utf-8?B?NUhOV1JzR3NObDd4MHMxWDkwMW9ZRTZHZjVIMXlJVGl6L2F3VzZqSnhOeWxz?=
 =?utf-8?B?aWRvazNqOG85UFNvbEtOOTAxRnE1WHJqRzQ1SFFTdkNsVGZGekJmbTlwaUZi?=
 =?utf-8?B?ZFhvck5uVGRVaFA1bTVBSmJKTTNZR0c3SnBHYXVXekxOdUZXT0xFM0lvSVRP?=
 =?utf-8?Q?kCsmwg2+Z9n4oLVNtZF0iUAxobZ2/Rhh56xJK6X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39f07a3-1e05-4f33-3b27-08d8ef6e8157
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 09:15:17.2771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdUhv26AUPOOFuIqvTWPMAN2rWe8PW8xQ6qhEFxgUQCz0s0ZlwlWDydLTqAt6BhpVutPON2oEy1PZbtYn9uZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2975
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8qxp SoC embeds a Mixel MIPI DPHY + LVDS PHY combo which supports
either a MIPI DSI display or a LVDS display.  The PHY mode is controlled
by SCU firmware and the driver would call a SCU firmware function to
configure the PHY mode.  The single LVDS PHY has 4 data lanes to support
a LVDS display.  Also, with a master LVDS PHY and a slave LVDS PHY, they
may work together to support a LVDS display with 8 data lanes(usually, dual
LVDS link display).  Note that this patch supports the LVDS PHY mode only
for the i.MX8qxp Mixel combo PHY, i.e., the MIPI DPHY mode is yet to be
supported, so for now error would be returned from ->set_mode() if MIPI
DPHY mode is passed over to it for the combo PHY.

Cc: Guido Günther <agx@sigxcpu.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4->v5:
* No change.

v3->v4:
* Add Guido's R-b tag.

v2->v3:
* Improve readability of mixel_dphy_set_mode(). (Guido)

v1->v2:
* Print invalid PHY mode in dmesg. (Guido)

 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 269 ++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index a95572b..af1ecda 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -4,17 +4,31 @@
  * Copyright 2019 Purism SPC
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/svc/misc.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+/* Control and Status Registers(CSR) */
+#define PHY_CTRL			0x00
+#define  CCM_MASK			GENMASK(7, 5)
+#define  CCM(n)				FIELD_PREP(CCM_MASK, (n))
+#define  CA_MASK			GENMASK(4, 2)
+#define  CA(n)				FIELD_PREP(CA_MASK, (n))
+#define  RFB				BIT(1)
+#define  LVDS_EN			BIT(0)
 
 /* DPHY registers */
 #define DPHY_PD_DPHY			0x00
@@ -55,8 +69,15 @@
 #define PWR_ON	0
 #define PWR_OFF	1
 
+#define MIN_VCO_FREQ 640000000
+#define MAX_VCO_FREQ 1500000000
+
+#define MIN_LVDS_REFCLK_FREQ 24000000
+#define MAX_LVDS_REFCLK_FREQ 150000000
+
 enum mixel_dphy_devtype {
 	MIXEL_IMX8MQ,
+	MIXEL_IMX8QXP,
 };
 
 struct mixel_dphy_devdata {
@@ -65,6 +86,7 @@ struct mixel_dphy_devdata {
 	u8 reg_rxlprp;
 	u8 reg_rxcdrp;
 	u8 reg_rxhs_settle;
+	bool is_combo;	/* MIPI DPHY and LVDS PHY combo */
 };
 
 static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
@@ -74,6 +96,10 @@ static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
 		.reg_rxlprp = 0x40,
 		.reg_rxcdrp = 0x44,
 		.reg_rxhs_settle = 0x48,
+		.is_combo = false,
+	},
+	[MIXEL_IMX8QXP] = {
+		.is_combo = true,
 	},
 };
 
@@ -95,8 +121,12 @@ struct mixel_dphy_cfg {
 struct mixel_dphy_priv {
 	struct mixel_dphy_cfg cfg;
 	struct regmap *regmap;
+	struct regmap *lvds_regmap;
 	struct clk *phy_ref_clk;
 	const struct mixel_dphy_devdata *devdata;
+	struct imx_sc_ipc *ipc_handle;
+	bool is_slave;
+	int id;
 };
 
 static const struct regmap_config mixel_dphy_regmap_config = {
@@ -317,7 +347,8 @@ static int mixel_dphy_set_pll_params(struct phy *phy)
 	return 0;
 }
 
-static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+static int
+mixel_dphy_configure_mipi_dphy(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
 	struct mixel_dphy_cfg cfg = { 0 };
@@ -345,15 +376,121 @@ static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
+static int
+mixel_dphy_configure_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	struct phy_configure_opts_lvds *lvds_opts = &opts->lvds;
+	unsigned long data_rate;
+	unsigned long fvco;
+	u32 rsc;
+	u32 co;
+	int ret;
+
+	priv->is_slave = lvds_opts->is_slave;
+
+	/* LVDS interface pins */
+	regmap_write(priv->lvds_regmap, PHY_CTRL, CCM(0x5) | CA(0x4) | RFB);
+
+	/* enable MODE8 only for slave LVDS PHY */
+	rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
+	ret = imx_sc_misc_set_control(priv->ipc_handle, rsc, IMX_SC_C_DUAL_MODE,
+				      lvds_opts->is_slave);
+	if (ret) {
+		dev_err(&phy->dev, "Failed to configure MODE8: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Choose an appropriate divider ratio to meet the requirement of
+	 * PLL VCO frequency range.
+	 *
+	 *  -----  640MHz ~ 1500MHz   ------------      ---------------
+	 * | VCO | ----------------> | CO divider | -> | LVDS data rate|
+	 *  -----       FVCO          ------------      ---------------
+	 *                            1/2/4/8 div     7 * differential_clk_rate
+	 */
+	data_rate = 7 * lvds_opts->differential_clk_rate;
+	for (co = 1; co <= 8; co *= 2) {
+		fvco = data_rate * co;
+
+		if (fvco >= MIN_VCO_FREQ)
+			break;
+	}
+
+	if (fvco < MIN_VCO_FREQ || fvco > MAX_VCO_FREQ) {
+		dev_err(&phy->dev, "VCO frequency %lu is out of range\n", fvco);
+		return -ERANGE;
+	}
+
+	/*
+	 * CO is configurable, while CN and CM are not,
+	 * as fixed ratios 1 and 7 are applied respectively.
+	 */
+	phy_write(phy, __ffs(co), DPHY_CO);
+
+	/* set reference clock rate */
+	clk_set_rate(priv->phy_ref_clk, lvds_opts->differential_clk_rate);
+
+	return ret;
+}
+
+static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY)
+		return mixel_dphy_configure_mipi_dphy(phy, opts);
+	else if (phy->attrs.mode == PHY_MODE_LVDS)
+		return mixel_dphy_configure_lvds_phy(phy, opts);
+
+	dev_err(&phy->dev,
+		"Failed to configure PHY with invalid PHY mode: %d\n",
+							phy->attrs.mode);
+	return -EINVAL;
+}
+
+static int
+mixel_dphy_validate_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct phy_configure_opts_lvds *lvds_cfg = &opts->lvds;
+
+	if (lvds_cfg->bits_per_lane_and_dclk_cycle != 7) {
+		dev_err(&phy->dev, "Invalid bits per LVDS data lane: %u\n",
+					lvds_cfg->bits_per_lane_and_dclk_cycle);
+		return -EINVAL;
+	}
+
+	if (lvds_cfg->lanes != 4) {
+		dev_err(&phy->dev, "Invalid LVDS data lanes: %u\n",
+						lvds_cfg->lanes);
+		return -EINVAL;
+	}
+
+	if (lvds_cfg->differential_clk_rate < MIN_LVDS_REFCLK_FREQ ||
+	    lvds_cfg->differential_clk_rate > MAX_LVDS_REFCLK_FREQ) {
+		dev_err(&phy->dev,
+			"Invalid LVDS differential clock rate: %lu\n",
+					lvds_cfg->differential_clk_rate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mixel_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 			       union phy_configure_opts *opts)
 {
-	struct mixel_dphy_cfg cfg = { 0 };
+	if (mode == PHY_MODE_MIPI_DPHY) {
+		struct mixel_dphy_cfg mipi_dphy_cfg = { 0 };
 
-	if (mode != PHY_MODE_MIPI_DPHY)
-		return -EINVAL;
+		return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy,
+							&mipi_dphy_cfg);
+	} else if (mode == PHY_MODE_LVDS) {
+		return mixel_dphy_validate_lvds_phy(phy, opts);
+	}
 
-	return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
+	dev_err(&phy->dev,
+		"Failed to validate PHY with invalid PHY mode: %d\n", mode);
+	return -EINVAL;
 }
 
 static int mixel_dphy_init(struct phy *phy)
@@ -373,27 +510,75 @@ static int mixel_dphy_exit(struct phy *phy)
 	return 0;
 }
 
-static int mixel_dphy_power_on(struct phy *phy)
+static int mixel_dphy_power_on_mipi_dphy(struct phy *phy)
 {
 	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
 	u32 locked;
 	int ret;
 
-	ret = clk_prepare_enable(priv->phy_ref_clk);
-	if (ret < 0)
-		return ret;
-
 	phy_write(phy, PWR_ON, DPHY_PD_PLL);
 	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
 				       locked, PLL_LOCK_SLEEP,
 				       PLL_LOCK_TIMEOUT);
 	if (ret < 0) {
 		dev_err(&phy->dev, "Could not get DPHY lock (%d)!\n", ret);
-		goto clock_disable;
+		return ret;
 	}
 	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
 
 	return 0;
+}
+
+static int mixel_dphy_power_on_lvds_phy(struct phy *phy)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	u32 locked;
+	int ret;
+
+	regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, LVDS_EN);
+
+	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
+	phy_write(phy, PWR_ON, DPHY_PD_PLL);
+
+	/* do not wait for slave LVDS PHY being locked */
+	if (priv->is_slave)
+		return 0;
+
+	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
+				       locked, PLL_LOCK_SLEEP,
+				       PLL_LOCK_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&phy->dev, "Could not get LVDS PHY lock (%d)!\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mixel_dphy_power_on(struct phy *phy)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare_enable(priv->phy_ref_clk);
+	if (ret < 0)
+		return ret;
+
+	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY) {
+		ret = mixel_dphy_power_on_mipi_dphy(phy);
+	} else if (phy->attrs.mode == PHY_MODE_LVDS) {
+		ret = mixel_dphy_power_on_lvds_phy(phy);
+	} else {
+		dev_err(&phy->dev,
+			"Failed to power on PHY with invalid PHY mode: %d\n",
+							phy->attrs.mode);
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto clock_disable;
+
+	return 0;
 clock_disable:
 	clk_disable_unprepare(priv->phy_ref_clk);
 	return ret;
@@ -406,16 +591,51 @@ static int mixel_dphy_power_off(struct phy *phy)
 	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
 	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
 
+	if (phy->attrs.mode == PHY_MODE_LVDS)
+		regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, 0);
+
 	clk_disable_unprepare(priv->phy_ref_clk);
 
 	return 0;
 }
 
+static int mixel_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	if (priv->devdata->is_combo && mode != PHY_MODE_LVDS) {
+		dev_err(&phy->dev, "Failed to set PHY mode for combo PHY\n");
+		return -EINVAL;
+	}
+
+	if (!priv->devdata->is_combo && mode != PHY_MODE_MIPI_DPHY) {
+		dev_err(&phy->dev, "Failed to set PHY mode to MIPI DPHY\n");
+		return -EINVAL;
+	}
+
+	if (priv->devdata->is_combo) {
+		u32 rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
+
+		ret = imx_sc_misc_set_control(priv->ipc_handle,
+					      rsc, IMX_SC_C_MODE,
+					      mode == PHY_MODE_LVDS);
+		if (ret) {
+			dev_err(&phy->dev,
+				"Failed to set PHY mode via SCU ipc: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static const struct phy_ops mixel_dphy_phy_ops = {
 	.init = mixel_dphy_init,
 	.exit = mixel_dphy_exit,
 	.power_on = mixel_dphy_power_on,
 	.power_off = mixel_dphy_power_off,
+	.set_mode = mixel_dphy_set_mode,
 	.configure = mixel_dphy_configure,
 	.validate = mixel_dphy_validate,
 	.owner = THIS_MODULE,
@@ -424,6 +644,8 @@ static const struct phy_ops mixel_dphy_phy_ops = {
 static const struct of_device_id mixel_dphy_of_match[] = {
 	{ .compatible = "fsl,imx8mq-mipi-dphy",
 	  .data = &mixel_dphy_devdata[MIXEL_IMX8MQ] },
+	{ .compatible = "fsl,imx8qxp-mipi-dphy",
+	  .data = &mixel_dphy_devdata[MIXEL_IMX8QXP] },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mixel_dphy_of_match);
@@ -436,6 +658,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	struct mixel_dphy_priv *priv;
 	struct phy *phy;
 	void __iomem *base;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -467,6 +690,30 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	dev_dbg(dev, "phy_ref clock rate: %lu\n",
 		clk_get_rate(priv->phy_ref_clk));
 
+	if (priv->devdata->is_combo) {
+		priv->lvds_regmap =
+			syscon_regmap_lookup_by_phandle(np, "fsl,syscon");
+		if (IS_ERR(priv->lvds_regmap)) {
+			ret = PTR_ERR(priv->lvds_regmap);
+			dev_err_probe(dev, ret, "Failed to get LVDS regmap\n");
+			return ret;
+		}
+
+		priv->id = of_alias_get_id(np, "mipi_dphy");
+		if (priv->id < 0) {
+			dev_err(dev, "Failed to get phy node alias id: %d\n",
+								 priv->id);
+			return priv->id;
+		}
+
+		ret = imx_scu_get_handle(&priv->ipc_handle);
+		if (ret) {
+			dev_err_probe(dev, ret,
+				      "Failed to get SCU ipc handle\n");
+			return ret;
+		}
+	}
+
 	dev_set_drvdata(dev, priv);
 
 	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
-- 
2.7.4

