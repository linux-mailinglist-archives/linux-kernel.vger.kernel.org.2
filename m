Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DDD3306CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 05:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhCHEGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 23:06:52 -0500
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:52275
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234104AbhCHEGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 23:06:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajUkJ6fkidbpQo+tD/BP5R9Y5LG8HwzmQ+vObKLdQ1z6OsjKp4ZAD369lT06O0bQvveDWHuWL1mJ9/gLYX5IMzx8kKW0W5EvWhZeJj7/a8oOQGILyJGFaEn/rxuuK7a/2xnDC+XkeIQlaFOngYFWAocAzs+KwLW/HcWhvG29WrEFXAuePhU5zVjJC5sq65BwwLrLeTuXLhYShNaA2S7ILhRL/Pb95WUz2vj1fu44LIcJxyrLw9u9NkquD7KsOfuctY3d0E37mgPMYmXIqJqh4FE4+0CENDUSgbuEVy2xXnNvfCgVtoIIfbycIgj8TuhWP0DLHH4jcT1CVDoLd0o2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrHiiLhQQdwrv7COH8QzBaRdj3T0UckZxTgVCPoh/pk=;
 b=jUuTD83x2VvhfDuH9EMrDyMjY/0mdMiQvw1kyrNjqAljI9gaoy6+gdFE+XpwvEID9lX8T5vk4nkqsmPW9nnxhqGm3IErcGIQBzsD9Bp7Yxxqk8Ur1OX0ASjWpsdVmnyOa4qFZz11CE0Kz3PancRBOsrLfR1mviwA2F0mijl5TtFPrw6amsPcXkhD/ULh1CAUQFZs8QQQLK/bXC4LEfsFJzCC9XdFQu0VxyE+Zcu61mUkhTc+1KeEKxIBWgpTNOkYXsT6W/EsmALTu0HIiF5qBQTLrobIBAYP29n4Aq56tGIlXtLZbM6tqixwQa7LgrV5t3iTaQ9kGtpzFj4sF8Q5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrHiiLhQQdwrv7COH8QzBaRdj3T0UckZxTgVCPoh/pk=;
 b=YAYNyJvU77x4yemb4lH+5i8srybLlrd1A5yU3yBpiXVFJn04hJ0BvLnNEGvnkMIvFKI1hepuL8BB6O/J3uSBhYwdyo63jhapriV746dNTImrlZTsFhNSaU+1ueq0O27pP7P0BSE8eqYTlsolO6i5BclujwWn8FbI5nAmvFnilNY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5184.eurprd04.prod.outlook.com (2603:10a6:803:5d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Mon, 8 Mar
 2021 04:06:15 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 04:06:15 +0000
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
Subject: [PATCH v4 5/5] phy: freescale: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY mode support
Date:   Mon,  8 Mar 2021 11:52:21 +0800
Message-Id: <1615175541-29009-6-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
References: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0088.apcprd04.prod.outlook.com (2603:1096:202:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 04:06:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bde5f48-a903-4b03-6fbd-08d8e1e78462
X-MS-TrafficTypeDiagnostic: VI1PR04MB5184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB51847367BDCEED25662F50F298939@VI1PR04MB5184.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJkQvlHHz61XIi6lges9KLH/4Wk4kWsEAwQxkxpWPSv6Gdn9NQaVmddt78vVOUJIPGPDCdZMDOFo67UnqdZAN72hFCphhi+Ot01xmiN+YyRHS+/2sbD3cJCBFsTucwszbaPXqoT2na77jDk4wfFvhH3Y3XynsxJGgDJfnQPeZh6dnqDT1QJSW4MpWdui0Jl2L0N0fenfQvygWoGbFiI5rdTejNmRFG9KX6bHTHR1zA0ymkNSQfgVzq1yef7403Ebwi4bJ5MBD7MpL+g9/MNB+H5+t4Vf+W0XbPMH1aiAtImKhbpn0fzKksRdyl9u9PgX7BPMxoWFj4o27P19mWV01WeX4s2GGogxQt1fFFQR6e89wFx0GmixwDL4VXJbFnChcoEIGMfPrleGg7OnCsMSxrUsIWj0UQhHi0HEWWM6CveFYw08Lrezs6EKmSd4IpaAVlLwb8+Gbs+7br3rogBJGpT9tnmlWg2DaMhL+KMPiZ9YPa30HOJAYFtHMluw2eiafr1q6cwZVs1P86hXW6+/SNawoEuojBBBZa9KSbPa7STnTzp5kbfUAx0vXXBJ0QN/lOIOFKHCAt0t1wc4oBzX3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(956004)(66946007)(478600001)(26005)(2616005)(4326008)(2906002)(6666004)(86362001)(36756003)(83380400001)(66476007)(186003)(30864003)(8676002)(52116002)(16526019)(5660300002)(316002)(6486002)(6512007)(8936002)(66574015)(6506007)(7416002)(66556008)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RVRwTjBFa09OZWRJcUhqRk5lcEZVMFl6T01zZ0VaL0NDSTFrREoxSHBJSFYy?=
 =?utf-8?B?U0QyL20wOWJPdXR1ekowVDNKRTc4NFdaNUJxaXIwbW04ZWpHVjN6MFVYMGc2?=
 =?utf-8?B?S3FwdVhoRmFXRVhSN1dCU1JzU0hmTkptNHlaaTRVZFJpVTVCU2NPUUdjTjB2?=
 =?utf-8?B?U1FGTWtVQ055TWdqOTVvcmZkNEQwd09ybnhLUmxUOWZYOFh5cXlsSE9OOEFF?=
 =?utf-8?B?ZnNCeWpmOW92QkhYNUd5LzFZTWgrVzRJdWt5MDZqVFpsbXJzVTlLdGM1Z0c5?=
 =?utf-8?B?OWtuSmVwbzlLaXNOQ2VIRUZoQkVMdDZTOCtScFhKMDhhL25Dd1ZYNlFCNktY?=
 =?utf-8?B?bDVycnRzcTRrb2NvRGVXYzcyejhIRFJublRXQzVGMFVKUHpBc2l0MXB3STNu?=
 =?utf-8?B?LzhwdUx1TGFMWEkvYnREek1Cd0d3ajdtWWorcEJDRHFrdHhuRXY5RS9abWR6?=
 =?utf-8?B?dGgxZFh3Y0tNZEFoYWtIS2NHTDFEeC9FN1ZsVWRlSGVSYktWUTFsTmxEK0ND?=
 =?utf-8?B?d2dHZ1ZvV0d1amE3dWZwOXdrZTRnbGsrT1V2YXZPL05kblpzQWZ4eDArSUpr?=
 =?utf-8?B?RFB3c3lZZmkzOEU4bGxZcFAzUG1EM0JmcC9uRHhMK1dZeE9QNEIxUjd5SEFE?=
 =?utf-8?B?N1liLzNlTnhKRG52ZEYyS3lJM1cxMHM3bDB5VXRsd3I2UHU2MUZHOG1JVDdB?=
 =?utf-8?B?ZFc4WEVNdk5BNEh3cGE3MUVOQjl6d2IraFY0Q28rb3hrK1NOa1p0QkVSZWoz?=
 =?utf-8?B?SWNTUGJmUUZjSUZSejEzWkprNXdjSFB6N3JvdWdyUnI2dmtKd2pFMEFKZnBa?=
 =?utf-8?B?S1podWtsbnBjZVpPbTJ0SmRFWlZnbko4bGZVVzBta2hyejMxKy9kTXBtN25F?=
 =?utf-8?B?RkYzS0w0SWFxQjNkOGwwOEJDWmZXeFMrRkVUZW0xekV0eDYvSHIzVzFYUGFh?=
 =?utf-8?B?TlpSYTNaWlhjcHZ6dEpvTTMwai9vOUNtWlRENFpEN0s3WmpTYVFYMVNxRGVE?=
 =?utf-8?B?Z2I0N2J5NVBKRXNVRU1JZzZTNTZTaS9tZXo3MXRYbXRqY21JeVU5anJjdW1s?=
 =?utf-8?B?YkFlZFBtMzNQdVlUK2lKL1FpODVTejBsUlVCTmdFRXUrb3ZIeHpabmJWdmdV?=
 =?utf-8?B?aWV2Z3REcmdNY0UwcnBQZnZXZHdvenVjb25FMUVUcWpBVTlpeWxTY29ib0RG?=
 =?utf-8?B?ZkdHSmZHZGl0VVVYbTRvS2VhVFU1clBlL2RUVUtRalFPSVBmSUQyQndWRVNs?=
 =?utf-8?B?cWNzQlRZdU1IOXpkYmt4d2JkcVQ1U1ppckRVR0dFTkMybjEvcmRleXA4UXl6?=
 =?utf-8?B?UGt4TCs0b21xQXU4Rkh2djlmM20yaktiWEYyUkREcnlLcjJFTUlQN2RnSkpk?=
 =?utf-8?B?M0tBaURYTXc3UXpNUlhnRkxITUFNc0hlaWRiU3Z3SWtVcWRYb2ZzQ3NuelRG?=
 =?utf-8?B?VzYwcDFtbTVYeFRKTTR3RU9sSmpnMmp5bUZzeE1SUFlsb2tad01FRERtMTdJ?=
 =?utf-8?B?OW5YUGxGaERkZG5DdzQvZDR6bEZmc1g1Qm8yY3lpVHRRSE44RXpuMkE1VDMz?=
 =?utf-8?B?MVNySGl1UkZnUzkxNDZvdW1jeUdMekwyblEwN0RxeUpQVlZLM1hyd0w2MStY?=
 =?utf-8?B?VHB2T21sbTVsWldUenhvQWJIOE8wRi95SURIZTdBdk1nQllvRWRhYjBqclhr?=
 =?utf-8?B?bWJpNi9VWU1pYXV3QUtqR1phbkcwZzE3dVhYWi8wR1lkNE93YVZScTBSMnVY?=
 =?utf-8?Q?bJg26LRzT14itq5ZlqFJxnpNmDY5Bcyqk5lz+q7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bde5f48-a903-4b03-6fbd-08d8e1e78462
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 04:06:15.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9Odd+8OUjaw4ylpq9b4eP0L3oU8lgeH2WhVTA1PCQf8saSW8l7R130YCJBtllTBDfPS3Csc0lO4mKYA0taIAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5184
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

