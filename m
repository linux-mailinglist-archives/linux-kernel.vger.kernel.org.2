Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE297377A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhEJDfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:35:54 -0400
Received: from mail-db8eur05on2049.outbound.protection.outlook.com ([40.107.20.49]:4672
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhEJDfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9XTSbDpl7SbUKhea7E/3cBM2+gclT8sBmbT4LiDv1O9qAMiNphhzWGkAHjSduyy0m4oYh6E+hcuucNQwc9pAe90lV1vU77MOo/bGhGh1vFwOxwAzewFabtx90O2k2Yk37ECPOXRINy+7bUj2njgDSH+VuB0bh9W/qMFWj0bGLILJIIqUTlawcevxHuYMIRgJEGs1307Qj0FhcelbX8qxjDxTVdjDMSt1GacFKWKNGnmGhhW9e3wtLNuY3M1MiDM5tcGVoCGOwfq9BQvBHDsdomhoo5L8Vo5wVPntgJlOPk6f7KZQsr9jQasNuhw+1s68ZzK/PiA2FfmbuvaD+tpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCyktjh9zjDdgPYjv9Mf00CvrZlIxv0CpoINt1eRg0Q=;
 b=cVAaN25/i0pyYQSYQBWQdBn264jv3zc0hkSm7pJExrWjreSfa1ET26GUM7Els9yTBOy138tK4My1bHTPuD2f/2HwrUDov60qaigg32k0hA4XXuv3FOE0puP5AOAxTmkFXN/wIOJmnMzboSfoBAw8o9FrQB0r3Rr7+0eRlvfZtxeHTrucfPp9IJpMtyp2tvGtdMsym+6BcA1Ud1ZYiLk8957XnKPpap2QSd6c78W6uzv4ekIlJgzWpGFICeTN8X953XVf6i53N5ztwChOqGOpJoVewREpd23+fDmntgpuaHESwlb88akn9VIPr1WxRKR9OVkYrty+codfi39prFYlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCyktjh9zjDdgPYjv9Mf00CvrZlIxv0CpoINt1eRg0Q=;
 b=Iiy4RCOSYe0CHRYf8+bnTizmAPadiMeyyMmSGg2PhxDjrxG6ggXEc5NdEWs74QvHflC3Q3txFRX/8OYGyAd186uJNn1gU4epbkegA2zSWvQqeNXB0I2xKPruwulXyATjvsCwu7WmgDR9Gyj8YW/65ZkuSBGoeB1J9uy9FYs0idE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 03:34:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:34:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Mon, 10 May 2021 12:07:01 +0800
Message-Id: <20210510040704.14997-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040704.14997-1-peng.fan@oss.nxp.com>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0159.apcprd03.prod.outlook.com
 (2603:1096:4:c9::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0159.apcprd03.prod.outlook.com (2603:1096:4:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Mon, 10 May 2021 03:34:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd85b3e0-e810-4082-c2bd-08d913648efe
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7930F3F909C3D7FAEC10DAE0C9549@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAJ6UyKXlAT7OrK/rlcTnPxZtWcTyE+i+I/r2rH4ZJJoo+7+jngdQTKwGclKo+hZkTDsb4XDCkUVmhwRDRMdld/mzU+LpmROxCv/0WpMMNHe0Tznkrpy9GXZFzPDDd6HVyh7yd/NWBCYIu3LEwohtGsxLIe65iEXF/wWc9ny81GxNwKNjQO5zQmEmGqbfP/X1ZWcB5ZGVYr6EKb9KnHbaIBb/lTm4ZWvU6/Tk8C9mjrAPJ6ZQcPITJDZFHajq3mj3hUw+Lkg3ZKmNihIsgHsXLCYJITj5i2PW/wFARQPCN0q5IaZRmMt/Rjb3mKKHFBSIaAm7LINAlFmfnWx73pnQtK4SMDTnZESdmEDyD0bllq5CB/0IgHmC1Ys792Px+B3Wr9u3/Ph09lj2MVJk/2J9jvPIgNGpGoqpzfZnqSiYTHtjbViK0RrwCl/OciiwgY7PpnpVh0D+FYH1lp05h/IfGGtfJmM2Mw4SngK6vxDt88YrD2YUtN0ty0/Qw/mYu/uE4wUNIjUa+ZeJabTYc74OqeRpE1SBeKWNn/57HkYHCH0MjdjThHOIc5Fdjko/oawWNt+Ho5HKt3W/hlfx70Y27d73S+75ZyganBYbI9xIl9iawVS1uBxXUDuVQCmMB2CqEg9LoK7v1JgkfYBXkfC3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(38350700002)(38100700002)(956004)(2906002)(6486002)(66476007)(4326008)(316002)(66556008)(66946007)(8676002)(2616005)(7416002)(86362001)(52116002)(186003)(1076003)(5660300002)(16526019)(8936002)(6506007)(6666004)(4744005)(26005)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GCtVkAhGtRs70Qjkr27j6wuukOVsKrpOzE/gEhB/aC7Lz5tUVYjbvkYkzFh5?=
 =?us-ascii?Q?Z7Un9zZpjX6v4XHRxsP7ChN/E3Mm+eusQScZDt+ZuhfhDIzqq1H2XM9wjF60?=
 =?us-ascii?Q?bHxysqUoCX+bLZGMjJyTjvi7uQtyjSbjbtw1rSDY7fFt73ZE8b/eoYARNT8d?=
 =?us-ascii?Q?ALURuQW8AMv5FH3FyShWtlPr3ZELm6cfEvnmdpFV3GQ4hZMdLh09JMDWaA3i?=
 =?us-ascii?Q?jN6WCaypCGDXVwjNiHfW7VskksETWWdDuwXBegDv1DwY3owyZ/YkWXuGv1pq?=
 =?us-ascii?Q?CcEDUdIZCOZJ+6lJb8ClwnK/2DOdm7dAAcSNe5TkIloYP1Amom0IjXXQwgRz?=
 =?us-ascii?Q?9xHQ/Dn/m4BSRepq8QBegVTIfTp+Cp2Y+JtBETypw4N3gyc5pel265rKZV3w?=
 =?us-ascii?Q?jmDfQc2yNu1rNMjjBi+nxcG3e8ZAjdpxLK4Gkd3O5LGgpBe4OJ05L27uQTtP?=
 =?us-ascii?Q?iaacXMH/sYTFBEwLU1Ec/7NixpLkyquwA5phPIDcVwMuDs41smQN9QTUTTN7?=
 =?us-ascii?Q?Z9eBJIdDjBA3lNc+2ntmU7kYtdUbP8M+oK1orlfYz1PULZpnq5tsG7phOMRP?=
 =?us-ascii?Q?GPbODDkwdznRTCRYtoBji3TgOWJRhdqzT1ruy49BVOJ3urPwIZoh2JKeRhE+?=
 =?us-ascii?Q?DkJrVhhjmgydSfhpcckmxaks0S59h9Bt/PypuwQ0vKKkeVNq9p60Ffx+8Kjn?=
 =?us-ascii?Q?8s3jlVMWw/iM0WrPApKuOAZ/OiKzx9+HNCJXZEqt7gJCNzyCpRuzEwOaV/KZ?=
 =?us-ascii?Q?W7H2DfWqEUPD0pFWZ4ENKHBo9GhIVM5S7gapeO4Gi4YHRaygiBaURDjC1hSY?=
 =?us-ascii?Q?vV7cQ3PLLnOPk+A3IoA6fGHMeWzkDcGl2624BPgSzRF+OwwuegS/aV4un70x?=
 =?us-ascii?Q?luyCtnapeDtSP1id1pp/tftkEx0NTtY4w8avFu3iFmE3I639YCtrK6Oc/hXp?=
 =?us-ascii?Q?r/VllKMKhV25SI2dWFKKLLslgt9ODJS5wBxt88D1VmpqUJWimk1InXwnXEBN?=
 =?us-ascii?Q?WHFxEhsw2P3JP9eDnKBxwE+WjvyB1ghwntb3uHgJXstaFdE2+MzTTJK16J8u?=
 =?us-ascii?Q?8WDhOf+O7ETWjZo+0EqELUQEMa6aYS8+HeCEmIcMyTdZfKpW03fx4V3zWn2G?=
 =?us-ascii?Q?v2cpGn6ARq0SbBaOh8vdpq/C1dCulTH6v48uElIvtImZtrTo0DQGjettzQHk?=
 =?us-ascii?Q?hHmqte0z23m22g+8zN0CVVzIaGsp1sdjq1GyCPrDmVcAyqq9PGNmreL2IQ0F?=
 =?us-ascii?Q?9zJJNKrniI5e+DyXZWc54qjNyAme4wR9MvinPOPAmeXudjpGQkTPdHNCobwB?=
 =?us-ascii?Q?KsYd/jD8VFr/tunPtgfiuYJM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd85b3e0-e810-4082-c2bd-08d913648efe
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:34:46.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APyGTtwNWrMAPmhDQJeXbENFszyxahQYmu12pQYwGDoKH3MZYPnj4EHYZXXMqFPLvYN4AVHcrhY+rGgFx0d/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Adding the defines for i.MX8MM BLK-CTL power domains.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/power/imx8mm-power.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
index fc9c2e16aadc..a10266befa9c 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -19,4 +19,15 @@
 #define IMX8MM_POWER_DOMAIN_DISPMIX	10
 #define IMX8MM_POWER_DOMAIN_MIPI	11
 
+#define IMX8MM_BLK_CTL_PD_VPU_G2		0
+#define IMX8MM_BLK_CTL_PD_VPU_G1		1
+#define IMX8MM_BLK_CTL_PD_VPU_H1		2
+#define IMX8MM_BLK_CTL_PD_VPU_MAX		3
+
+#define IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE	0
+#define IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF		1
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI	2
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	3
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		4
+
 #endif
-- 
2.30.0

