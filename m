Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE042A0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhJLJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:27:25 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:4327
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235547AbhJLJ1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:27:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdeOwL3nM2izw/JX7kra/fiYUeKJf5jMSQOy9nmUC1vHshgjg8pHrGzpfvrPHjI1xqa8GK0lTqVmg6nfGnL/OCLF7Jr4pne8bAUnhs27c0i9UwmoMp6EPFzlpU9Cod+Rb52FFsGBFSJA0Ir+VSpVclY/54I9hdfOXmkB9Cel+otQcqkRAKDH2pDG0fJ0bbEkNi0G0H4dTI+6rarHYEKORV+H59MzZk9Ib0uF7wKUsi1LpBGIHFNN6KJuXB7Ud4O4DQe9mVMt6uixd0kLGS91O4riym1MmpPc2gEpHWpha//ce12jrM9ZwXHGkxWtcxYP4zacnW44BKHQHqpXq6hUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9h5isO3Gyd+lKDZWj915Q77YXPEcj0RDQNoI8zrzBE=;
 b=O3sbr+q95N241xyPPsK89XvxX3FwSm9k7OR1TveDflFEdY/xoL6Fbg9DiCqGlRvb0rxqoIxuqaa+YZe41eK5GpdzagmtbpDFXrvONyOqCqa2EkufPLXCZMGmHRJH8qnzmwjJg3wVWA3W16M2fQ9jRSeuVbG1g8yXdlLCUPQkEEU4haMFOe2JCzajmWR5SVafhR5A7HBOEIfqYRyKf0An4zMoIfCF1KujOKlPNdBSqBshv7B22w4GdBbNUvSyf8jS/+LvWNdMmkW26LKiobwRgV6aImatnLRhGFBdrSY7M90lM9wcmWY5/0Dod3e0qHofbwvJ/EagZUcsxyzA4SNpgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9h5isO3Gyd+lKDZWj915Q77YXPEcj0RDQNoI8zrzBE=;
 b=DQuZsUKew+BUKWphC3/TUpZYyKujXkDJFx6VpabRMiHwh2WSPgIK307i/gv/RF0di1mJThQebOIXwaX6cXBsiaE+csK+f1ngoG0w+1TFsyLjMXTSMBnVbV2T3cxbA+/IHW/mquPgqQSKzRJuDZzU7ePx0V/BkSwRS+uzuTaYia4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 09:25:20 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:25:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com, abel.vesa@nxp.com,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8ulp: set suppress_bind_attrs to true
Date:   Tue, 12 Oct 2021 18:01:32 +0800
Message-Id: <20211012100132.17829-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend Transport; Tue, 12 Oct 2021 09:25:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 076133fb-830d-4f58-9c8b-08d98d6235b7
X-MS-TrafficTypeDiagnostic: DU2PR04MB8981:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8981F87744887DA0C613F166C9B69@DU2PR04MB8981.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSFVsB9ETuDCLhcmgcUgMPCtGJiGfuq3sX79XXBM7whGpg0SHSqk/EcBsZJQ1qHUA7NDOHNsqFCureezgrAJPsE0NX5Q6dlXhGC2hgDDp5CQK+NVql8lo248YPoL49Qk1JQpwvogXp/kkrI4fLJDms/I69zioPw83XW0N7/2faal3lqjZyoSJ6fI1PDlQy+hqFBefxzhHfFHKmnFERoA+6T7eILI6lnUTA90zlcXnAJFurrg1l+NhWyCsmdJNFfidVpYhDSsOHr17jwfl3KkT20rXIoObhhwdqKE0s/gjlDiob7xHw5/Gw7ONMuYzd/K6pEOfmbk2ofbZkkyyUKoQutRMRIW/uDTTGm1r5EZu5juMZFbKZ8w/K7WH79sD94kCSqOnAspeYHKy7GmgwRMK31od7xKaJs9jhuC8vczCSxFinqfrD3PvHTJ2pjnPhH15T8ZjZu2kUcjjfnUI1sxX77uvFDzOCP8BYyRh8Lhzp4RgsURMNRkqz7zhjtScJh4j3lE4Y4h7Ahiwub+u2nkFKT+T5QfFjIyO2VUlehAI/mD33YiWRCML76BCyWtLvrJrj2iDxEee6u4SMbAHy1hF+cryE4mR+vKM+mXY+c9WIGrNxEtoyqGsUzgnfe57eLY5PTOKJZEBNhahhQ2spfJDm0ZZWBbmwp+kTH3PSR8/UPOEbQ1ioC9NnYmFt+ucpNRAbK21B4s2FwyQ3U5s4s/1QjUYyreo+6pSbtxyleJAnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4326008)(1076003)(6512007)(6486002)(26005)(5660300002)(8936002)(186003)(38350700002)(38100700002)(508600001)(4744005)(66556008)(316002)(66946007)(8676002)(2616005)(2906002)(956004)(83380400001)(52116002)(6506007)(86362001)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9afmrjJVtlieCS+d+eM8xoqS1nTvQraiUT4aj03ILCFIuwfhiUxLOs6+Hni?=
 =?us-ascii?Q?+bT3RH2cFlC3xTm+L+tzEexGE48dQjJtNGBY1EiG2ji4aia6ob1Etly5BTAt?=
 =?us-ascii?Q?L2b3WjpNO4FDVFo29jWGE88s9MwzX+VoHcTlwcXNc9v4ZGpZFNQzxHUVU92m?=
 =?us-ascii?Q?WT91gcL2bSZUJUuzwwghBefdEDNZvJwCjXcnvuRNSF0zImX0pEjqf3uE0esi?=
 =?us-ascii?Q?U8oBmkzjb5dkV3WmycUKDckN4PxoqVQoGbMx7/28ruv9urKj3jeQ8CGzhzmw?=
 =?us-ascii?Q?3+5MJtr1ShGMHlnjVFUrMAWmLKKAm+kDacX+Q2jL7BtbDMUK9Tp9HwzerBvo?=
 =?us-ascii?Q?D+1qjGERAXHC44OzUU4rZBXmcX0I7pl3k3LwVmAXhLf8bQP1Up9ANGzg00/+?=
 =?us-ascii?Q?y+wh5dzhG0BkAchqoFF4OM7zHyGxCmohQ2uT4o+Lsiq3YPelW9GZgbtV2cDS?=
 =?us-ascii?Q?284hAsY0mAgzDR7FrMRPELmMi+pGjc0QIFduEtpeArEa1YFKxrYtNr13iHKy?=
 =?us-ascii?Q?nPR9nuKFcigf1v9fdU3aAPpE4RLjw3Cu/Z2WR/DnXWq7TVyIH6e9Fx0DqDRY?=
 =?us-ascii?Q?QP2CN/g6SfctYSXYvEEtIYUiS2r6jo2QdqNR4LKD2+j9a/SoWJqJnDKiPduY?=
 =?us-ascii?Q?+ZKYhAXbUQcoxU9O+377ZMZmdE7IkwT5mFQedLUkxmUZB4cCh+Mv8c52IqyL?=
 =?us-ascii?Q?+AUUEJI5FMOgkLLu5Jy4cps28ZVCEXfVYtx7E0QZ5lBwxbEkgkG6e3uhPzI8?=
 =?us-ascii?Q?3Lc6nxrmkaJAEs3o6zOZgUsXd/R/dgbG//4RGexFAahdIsYQVaF7wzN2MkfV?=
 =?us-ascii?Q?EQ8RftPwoA6XkQwy6K8nwXZJLBzg+3dT1Qt80uRv8HMswKgkHS3j6rIVCWOw?=
 =?us-ascii?Q?jVNdDYE5XnC3g2tBsDjBbfe7Rko2/BnoFvg7yhNd5ArSgJBPGBWIJRtUHV1k?=
 =?us-ascii?Q?PFGDpa/pqHoeL5Ve6L5OnBnpaFhXWfyfXpyyiUImL6h1pA4VNSDjYcRG6aKN?=
 =?us-ascii?Q?U7sjIQaJxO3R0uXV8f4D5cBj2bMmCOrZe3RCz5hVEuuDK5rf7viILfBy6Q8B?=
 =?us-ascii?Q?Rp5RVjYnA12hcrlgiqIkiLYptMgnQyqU16UXak1pUIbU+ca5+dH1dd7cEVqC?=
 =?us-ascii?Q?dbJ3SZhYc8bg+kndeqGUoU0gwrs9NMEtx4p3lZuGLlIFwO+iO4CJFi4uqJOJ?=
 =?us-ascii?Q?FgT0YXz5Mh0EgG14cxVeCmd6UF5Kgl1zu6TaUoGgnwMFYSmKWZ5UE/w+INIC?=
 =?us-ascii?Q?SYp28CnTemU5YBrJRqPC02GS7Z99mzuSS162ZI/76ljbS1SQPsmbjvgvKcVF?=
 =?us-ascii?Q?OoKkIvkCjbtQ3J0UFZkchXhK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076133fb-830d-4f58-9c8b-08d98d6235b7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:25:20.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yiAsNa+rA7eEtoW9PYuKSwIX5f/ZV7EE+D1qB/LiANYwL6kVVYKRNxZp/u/pFe+xPI4Cpowwf6u/4sS/0MSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Disable bind attributes, the clocks will not removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8ulp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 6699437e17b8..8eb1af2d6429 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -559,6 +559,7 @@ static struct platform_driver imx8ulp_clk_driver = {
 	.probe	= imx8ulp_clk_probe,
 	.driver = {
 		.name		= KBUILD_MODNAME,
+		.suppress_bind_attrs = true,
 		.of_match_table	= imx8ulp_clk_dt_ids,
 	},
 };
-- 
2.30.0

