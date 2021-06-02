Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7093983E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFBINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:13:41 -0400
Received: from mail-eopbgr30098.outbound.protection.outlook.com ([40.107.3.98]:21569
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229583AbhFBINk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:13:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBSxLeG5E1FSMEWRvsAvlc+1d/eAeA9ih71dLA01oQTgEncFlYqNQZKODEEVUE5fHAO4TOZQ0OdjbYKxQ810CbKb5/ryPA9XZKWdnftmcD9T4GVJGz8MofPc/zjnvMLmSm/Vpovs2ev3n6t3xVkiAYmRvdW7LEm469ACR0CFJ1pB3pae9HpLSJjFkn25JHBx4qq+tgadYA4AZaPAtPv6zXuQsoM8Xb4SLslvTcOXDzqTysWwWVu4244FwVBu1Z37V2DgshRei6yOl/eyZQLSYXE6lDlcpsCtSk3w0kz3EbfDHH/yoRZCuSeV+xU08VbOFnVbCT2CAN3KkyN8qAX+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMlQF/mf0deuWHxz1o/7O29iDVkKC4Fvem4kGUfgXeY=;
 b=iqhYJ7KK0VeZXKiUIwqrSf42o5olbyEytFij0A3FRVLTAGl4VeMnKVIqOsUCErcgwAf4jMJw1XHNb/PNL4rpb/uWWoYiSQ1lJRQig9mD4C79bRbvJGx/uqt8YaU68ZS8+7dYmlCIC4Xufx8L2d5wW2mlkUtja4p5tgUoNED/1vEcoxbnNql4EKGdIMRUATnkl+qOFp94qKbxoE9MyM/AWVdCTroaDDJXGG7DMgr5RmTZlZoLikvjg8cU2nN3FzO/dnmK+rkqZqCTRC7njuVHnmJS1sllxpD4Hs4CpUnzBDmrQ79YrIi2Zh2O7qojLK++SgRljh9C46pLZ8S6Q6udNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=televic.com; dmarc=pass action=none header.from=televic.com;
 dkim=pass header.d=televic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMlQF/mf0deuWHxz1o/7O29iDVkKC4Fvem4kGUfgXeY=;
 b=aNTFc/Htf5e3JIZou8mUuJT8IT9e1306bwHavedpbo3jG3MTVvaA8RKQQBP/ekqQx81/MAgxT1IaArsG9CHWGLFvjqTmXh46UBXJONBRUdnOTOX0+Zpbog46dUKO67mctBZ6pLSv281omDZ6eZkUALdOtj0fIGsBIYJohq+A4TI=
Authentication-Results: televic.com; dkim=none (message not signed)
 header.d=none;televic.com; dmarc=none action=none header.from=televic.com;
Received: from PR3PR07MB8049.eurprd07.prod.outlook.com (2603:10a6:102:14c::21)
 by PAXPR07MB7854.eurprd07.prod.outlook.com (2603:10a6:102:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.11; Wed, 2 Jun
 2021 08:11:56 +0000
Received: from PR3PR07MB8049.eurprd07.prod.outlook.com
 ([fe80::395a:cb81:11c7:f958]) by PR3PR07MB8049.eurprd07.prod.outlook.com
 ([fe80::395a:cb81:11c7:f958%4]) with mapi id 15.20.4195.015; Wed, 2 Jun 2021
 08:11:56 +0000
From:   Pieter Cardoen <p.cardoen@televic.com>
Cc:     Pieter Cardoen <p.cardoen@televic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: mach-imx6ul: added gpr enet<x>-tx-clock config
Date:   Wed,  2 Jun 2021 10:11:07 +0200
Message-Id: <1622621468-17013-1-git-send-email-p.cardoen@televic.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [2a02:1811:b71a:2e00:dd9:9421:9245:2349]
X-ClientProxiedBy: AM4PR0701CA0010.eurprd07.prod.outlook.com
 (2603:10a6:200:42::20) To PR3PR07MB8049.eurprd07.prod.outlook.com
 (2603:10a6:102:14c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:1811:b71a:2e00:dd9:9421:9245:2349) by AM4PR0701CA0010.eurprd07.prod.outlook.com (2603:10a6:200:42::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4195.12 via Frontend Transport; Wed, 2 Jun 2021 08:11:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31dab72b-1f46-4450-ce60-08d9259e1638
X-MS-TrafficTypeDiagnostic: PAXPR07MB7854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR07MB785472215BEB5D52286A3DE5FF3D9@PAXPR07MB7854.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zU/ODNxbiUQRd3FElQiHJKXXHY8bHUTLStha+LdBgUYLmWVbb9k2eT6zerAJ4kMcihU+zYGEzeq1v1+rphNphwpGrXaTTkpZRWk+Wc8hBq/2oICEJBGvK4803QzjhxWYm9xEBems1E5aU+CTaAIUIX9xJqfZsRXMTJYgR1Y9Mui6BYS3NJG1ntpknKPOI8kWpoKY151icctZzUapgJ2VfH7enX4WcTNvGl7/x6FQsVAEM8mIzOHwK+nZor6yVJHohMPspppOFK+Tn0F5meUBVs8IcZcZk3SA5vN3v2mKl6TjlSnwsxZPGZheZQ4qW/BNwllewDniFE7yGAlofxBUg36CLv2K/WgicR9VwovOA3s3lx6ESHhfhjiQuJNlQOTan8vaY7CL2X401NWSiUALv1VHFYk2KildlT/fRCPRWGVgHEW534p3v1cnpNZ92EwvpIV2gJFDiXAI9ondWCeM3veu0G8AgiKje6v3EntcRT9qq+WL+f42QkijVfF1HxUtCvLqB3NPvQNv47czaSAEMiBZFxqKUUpgMKzhYnlI6GyonVbFnuxmUZ2Gut6rkFpKEWOMno+xLzVE56jre1Asz891bacBivEztvWIR7u08afjqrFYP3jqTVL7yRG95B3Z5mruTEJgli5sUAsPAyJLY8NJAcXWQ/arBe8mDDYllU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR07MB8049.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(109986005)(4326008)(2906002)(52116002)(66556008)(478600001)(66476007)(66946007)(2616005)(54906003)(36756003)(8676002)(83380400001)(5660300002)(86362001)(316002)(38100700002)(186003)(6486002)(6506007)(8936002)(6666004)(7416002)(6512007)(16526019)(69590400013)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qQ/LUBGjJjXkrxXqbhzAI+bzSa3HN/XJPa4mH6cf909v5eqIRiyQPsk+F+ue?=
 =?us-ascii?Q?Tx6KJwYGgIuN+BNzARATPvlLhdawqwiZoP3gtZUymYFIo4kYPc0OBf5DCA1y?=
 =?us-ascii?Q?HgTMIhN0sCw20oA5jcM9cjuhpxtZP5qiXDU9ln8PovvC2+6wrdkfnSZYLzQ9?=
 =?us-ascii?Q?jggITRWyM+2SaruwXqusVh2y9ZaIIkd9BJQf/A3F70/0iPui/cp94PWAmdMr?=
 =?us-ascii?Q?ZUpiPVlVAbyJdoKpQXLkMM63a8HjsTx5cpvt2+DoMlLqDNUbGwHCEo3Uuuii?=
 =?us-ascii?Q?VwV/UCkwWK/RFbUXP4xAJ2SmqI9plValBS/eBJerFTNWTKMM//NH+E0YFbzP?=
 =?us-ascii?Q?dEvHwGYkY0Bmk0qP+YKWaDJBnRfUHLhhSLYmrT9igjPyANQiTbR/pZw50P8P?=
 =?us-ascii?Q?ld7AUPvEVplLISbXxgdW+/FiF8XhjN4npAPiofOj472og/lqmsJg8zFUryPi?=
 =?us-ascii?Q?FjF9Rl5Kpw6plLK4eh+FRfOL9xRau+37rtI5ZNq4WpEePiQ9refYs66xqG8+?=
 =?us-ascii?Q?GiGTj8Yv33//KNHCZfTeSHEsn4LnEBnYoxEiuHIlwTdK4jDwK8IFHu73R8Ns?=
 =?us-ascii?Q?c71zW8Irh77t7ARM87HbLN4jTuFiv3sBFYL/hcwolr6efQFuF96MrDkWpQQR?=
 =?us-ascii?Q?kx/4F8bl8aBYI7UJnngvNJzNZvvG5gdPiDBx7RQstt29+gx5YTOIgh+DXeoF?=
 =?us-ascii?Q?kw1scxKe+fUg6I5ilHChRSvyyMUnbF3SBjNVtzKZdJIe47mtnHdxWcpRdQ0N?=
 =?us-ascii?Q?Kb/JKBfzkfLCy3EPV9aBVvqrdVGYfk/Ea/59w7HXTnX3Y6H0obeSA3sxL5dU?=
 =?us-ascii?Q?/l6LhChbrXmZqdtDOIE8rQzcg/cjHHL46QZfOGwn3U5e+v/6Ng78M0pdWAKB?=
 =?us-ascii?Q?H6MfZ5FyHtGTWqhw+GffHI4cMXyDLSn77++RTGjTVI5LJPZj2OXigo58WxhK?=
 =?us-ascii?Q?H+yrCdqmEqhSoiPsW/rGfJqTY7gxIFAkRNvE815FWTskUI3QfXA1XqAlWiuk?=
 =?us-ascii?Q?CrpPUuN/8GjRny9T0dKPCv0h2/QWTzc7f58KprS+hgMr229ZwpT+Ohjs4fXH?=
 =?us-ascii?Q?I1XWfO4eCDm1uHiwIjfz6YDqdrTYSa5oNLjEC2img8Ft82xn72ca00+YwL4b?=
 =?us-ascii?Q?05ogTFfN4HThjNgClklG3O/xP3wk2fxcJI8vxhRWmS3+/Ou6umGNETPIudbw?=
 =?us-ascii?Q?iT6nhs90MjrT8LTv1hM1jUSfWaTNC/41d838FnNFSX99KRcSiVwcNDgdDwMd?=
 =?us-ascii?Q?1eazAsU3Vf9gBoumEZBvDSxOAUIiUoz2ZJYNvSuTaORVATYNAfBRzO3oDJ/w?=
 =?us-ascii?Q?snzs7uQ1q4mkDrke5pLP+oiUeJ50TFfTj2/EN5bjJfqu+Zi/SYyPmg6+I1zE?=
 =?us-ascii?Q?S4A31YR6sd8Ld+WxGS0cPRuv2ysY?=
X-OriginatorOrg: televic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dab72b-1f46-4450-ce60-08d9259e1638
X-MS-Exchange-CrossTenant-AuthSource: PR3PR07MB8049.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:11:55.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 68a8593e-d1fc-4a6a-b782-1bdcb0633231
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxBRK4Hb/erFnX7WZhqiYOuWfkk59UvLwSJKm0p3pLm99ApYb3Tbc+9LnCANlnMujImOpx+tMSM89oir73xRgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7854
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow enable/disable of IMX6UL_GPR1_ENET1_CLK_OUTPUT and
IMX6UL_GPR2_ENET_CLK_OUTPUT as it may not be enabled when
using a phy in RMII mode. Enabling this clock output in
RMII mode results in multiple drivers on a single line.

Configuration can be done using gpr device-tree handle by
including string options enet1-tx-clock and enet2-tx-clock.

Signed-off-by: Pieter Cardoen <p.cardoen@televic.com>
---
 arch/arm/boot/dts/imx6ul.dtsi   |  1 +
 arch/arm/mach-imx/mach-imx6ul.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 7901494..f4dbde8 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -737,6 +737,7 @@
 				compatible = "fsl,imx6ul-iomuxc-gpr",
 					     "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x020e4000 0x4000>;
+				enet1-tx-clock = "enable";
 			};
 
 			gpt2: timer@20e8000 {
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 35e8120..ea2fae8 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -19,11 +19,24 @@
 static void __init imx6ul_enet_clk_init(void)
 {
 	struct regmap *gpr;
+	unsigned int enet_clk_output = 0;
+	struct device_node *node = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-iomuxc-gpr");
+	const char *enable;
+
+	if (node) {
+		if (!of_property_read_string(node, "enet1-tx-clock", &enable))
+			if (strcmp(enable, "enable") == 0)
+				enet_clk_output |= IMX6UL_GPR1_ENET_CLK_OUTPUT;
+
+		if (!of_property_read_string(node, "enet2-tx-clock", &enable))
+			if (strcmp(enable, "enable") == 0)
+				enet_clk_output |= IMX6UL_GPR1_ENET2_CLK_OUTPUT;
+	}
 
 	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 	if (!IS_ERR(gpr))
 		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6UL_GPR1_ENET_CLK_DIR,
-				   IMX6UL_GPR1_ENET_CLK_OUTPUT);
+				   enet_clk_output);
 	else
 		pr_err("failed to find fsl,imx6ul-iomux-gpr regmap\n");
 }
-- 
2.7.4

