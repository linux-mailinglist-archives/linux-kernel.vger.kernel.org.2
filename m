Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D121836F535
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhD3E4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:56:36 -0400
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]:43908
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230058AbhD3E4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:56:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF8ILkW9r30pdYt4aF9k3SACUwLrfp61Df/10hUWHxvKLnDdL+tydsCl0UXbjCiJw/uGH1efAtdLQ8puV1+JQHzIN+PXHhjwhj3Ml4EwRE0437WPEu2A+qnqY0LTWH5XDZNoz3t55Nyn4HuIWyHnFAN5U4zW9gCDH3n3/ENAWbsOrTAqKEj8Jr6bHHdZL6AL04IItw366eLdQETdVvgJGFoWVVkEinD05lMGP6+feLM+8i1qB0X6VJ0X9DRyquyJf8WkCdl81VTip7wCvBeSP5I38llaS9IBLHqLaUiCjJGKEqJsZyDrjQV701tEvqo+3bqQpexpdvRrXo3yR8LJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F9ydPzZQL7+HYXXydKkW6iHvplYGD6tVCXh+5X5vM=;
 b=dHHiZdsq6FSKNNb6zKxkyMci+7xO91jiMs0Mr7/wunsAcjoyNYywRolMdCy5Jf8yX0zsti9a02ueXkPABCOr/D7dlD2kn1XPnXUgfash4268v4UZR6LRgb4X+LGLBfw0KfvasASI/KBIMDNar1lPebZsiWP4XBeGaBdhzZgwpnhu0Vu+g1nhJGOMkrbba7Qel5DBQ924GmMHkH0Dgvmd/NC4SkyXjZctYzMksQtVF+4w4ENm9AMJWstWMAiMOAkRN/roK63o3/ciyrO0L5TxqmeT/YWvRjDPeDTX6Mbih/Z7yZDgKPXV3Cbd/GtVembQQNhx+K2QJR/uC7bXdgfYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F9ydPzZQL7+HYXXydKkW6iHvplYGD6tVCXh+5X5vM=;
 b=QxFmj1llZa1nPMLTjm1J1xXyYS5TcBdnvmgdrZDUkdEzTw4wfDTaMadxR24t5ShxWko9Knr98ThvcbOPFcvGjXp2Wd19rDlf/+SVnyPGRqKl469zMYwPYIzAL4zqpOMM04trHTFjcB0q5IUYkbFLw1A+I4kYxoAnob5attFOVyY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:55:44 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:55:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Fri, 30 Apr 2021 13:27:43 +0800
Message-Id: <20210430052746.10815-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210430052746.10815-1-peng.fan@oss.nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 04:55:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 716c3e32-9262-4fa5-b577-08d90b9435bb
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB391614401C8083E252414E0DC95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCbqgNr5hhRD62lEUKL3WLN0AhUXg9gzkGufs3OKgfXxUvpPrmf/Cv5KkoBswZUtOFU8//0qfTNY0pzhmxZ8SMfgXe+1XKDBIVOdMm7CAd7r0vr/zPT7Obo3uRj/7VRT9gkAEZENqCV2rUg/01HnrU29j47fs4tHoz1SHxQN1NEhWDXLXiI3m2KAnedXAGxl2K9mphTKEHlH0JPygDVOydRcPI6sSRJKVY/YRglge6tws6xw8ztEvdASdOvttUPP2rEAstWt0tiL80kvo/jzZacuAEM5JdZWiwOdWGWBcak9JjRHugAloyZlds5cZ96zeHyeEzGhewgO5hI5mtGLWf9S7KMFYe1dmdFBq5u8labZPSOFvixD/Sqh40ZpDxDdsNzy7k5VtTHpFNtALcZpnWWGzxalSO25XcMvvafIqmuP8gGsSN8VXbj0O9qV3s8uH945gXM2pc2itufZC4zuV3NzNTQV40iph2ZReaf+4LY0UhB7GKfsY22a4A9HqxJSPpJnkgu5fchre5d2Q0EDuElcpMWXPTGl4SFZOUZ2fnQLxk2yqZf+xMLjripqkJu6BaFmUuEN+RTszRD68t+Hua0bzKyJdlx6Nd8XIrOhy8Gum1HVVgCozB7yfD7wopZ5/5iPa1GJkW5YV19JKY6AFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(316002)(8936002)(5660300002)(66476007)(66946007)(7416002)(66556008)(4326008)(6512007)(6486002)(6666004)(16526019)(956004)(186003)(86362001)(2616005)(6506007)(1076003)(2906002)(38100700002)(38350700002)(8676002)(4744005)(478600001)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wRHH4qy3FNb2oGEn5a+Ysq6x/KJgLzOeU7WkkGE24YjPImzniXUMu5ItsE5D?=
 =?us-ascii?Q?FWVsdcZLjfjnJRfXzSjtQYwkWpftuVOLsh0kTpnHLAVEufT/hbJAPw966NLw?=
 =?us-ascii?Q?KoIICeeC1pugNOIOZaldrF+LBYbNbNS8I98zGwbQSG+ZAIbdeG85B0uFxPNU?=
 =?us-ascii?Q?oZkLca4imGbmoaNCp3z7RWArO4WjlUYO1L9yrLhBYkbbx29dr3ZQESmzASao?=
 =?us-ascii?Q?9D2j7w3rO6iZJj8CUCFWanPjDUv+dfY4yLb8Jimb5P0v6k4uOROahfUbSNpw?=
 =?us-ascii?Q?TJALCHEip6V1tt7nLcCJXM7QhcPot2ERRfjC8KFI/FBDobBRNQsIr8HiSOBq?=
 =?us-ascii?Q?VUPQVoAcpIOR4hBHJRhCU9Z6ddHZuAD3lTiOKf0VzBAcIPo2jYO4Doh7CqY7?=
 =?us-ascii?Q?6OSmC7ngQhu/umCW/gFLjPBsuSO4Ns5uB9lNfXn8xPOshwwTjWyHt+sVpKmd?=
 =?us-ascii?Q?xiKzh1qm9i/ape0cqEFZF7hRYrcEm9AWuolLmo7DreotymACadoXAMeotH5b?=
 =?us-ascii?Q?1p/hXBJovQh2ddpdIzwKRVy3GXB+GrLk0IoPkiA+rs+ExcxCe+DYQhbz5/eW?=
 =?us-ascii?Q?5Yq/bFhKLL+ObxLf1Yx7WuIZtDdfKlioJ2hE+m++6uBxhYIc+Jg3N6uqIddP?=
 =?us-ascii?Q?KK+3A/JbV1R7C7X64pPnWtE30HvpZA9OYF6rM5sBo0JJg4ENP6dbwRXeNxzN?=
 =?us-ascii?Q?Lqtl2z5YamCPmfiEyiW1FEptSNIvG03+mbnGDx56qN/lXeOgyu6KhFH7vwWl?=
 =?us-ascii?Q?WBxJzB5NL2y2rMz4kFa2AHwHi7voUSrr85BvTmSk3TEwgCaAF0B+Twd2rSBF?=
 =?us-ascii?Q?577DuAQUu61e4V6u00Megutf8LiCxZLuaajOGSCeMghnkYXkLwzNanNcIY/B?=
 =?us-ascii?Q?Besr213QEpa1DCOgzDekOGmarKwIMnmhGd2qoGGJwj8Eu33C1ZEASmeWd/To?=
 =?us-ascii?Q?tcCVv8fPfFZQcAGf0knlEdnG+0InUyHZYQSwek/8ckFlfQeMURI6a7fAXuer?=
 =?us-ascii?Q?hOYo0n30SpJdY/pmbB5Tz277RkduyXkW882ESvPK2F0uwYGkE87UJI1TmeoN?=
 =?us-ascii?Q?3xxFZK4MiSO5OzLPms067vN7Pw6uOciX2DwDH/bNr0CAifSeM6xTpJfbcUrn?=
 =?us-ascii?Q?MCYRV+B8AUGMhUwv0ZYeipsg9ltjQGvtvOcyRHvXNzyfH4VHDXbDW3bdCfLB?=
 =?us-ascii?Q?JEPyJ9vMVl2zB0Xo0lCBhLffVPplykXFvQah4tt7uHbnSyIS8LzYlwtZBav7?=
 =?us-ascii?Q?bFOctICx4oR4TF1bfrgPXU+ACGFQfDrH/rWW8j9YzZ1FfcB0vIMWyFrvOwNf?=
 =?us-ascii?Q?zTXBSYsWPXobd1JYcYbkKPjw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716c3e32-9262-4fa5-b577-08d90b9435bb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:55:43.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7zu4bQ+R1eidLKiFxFyCpNQV0bD8+EWEznoPgmDSWvj3Ty0JXxxQq0CSLEr6mF6d4jCAxYPJYBw0dnUbgrdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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
index fc9c2e16aadc..510e383d1953 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -19,4 +19,15 @@
 #define IMX8MM_POWER_DOMAIN_DISPMIX	10
 #define IMX8MM_POWER_DOMAIN_MIPI	11
 
+#define IMX8MM_BLK_CTL_G2_PD		0
+#define IMX8MM_BLK_CTL_G1_PD		1
+#define IMX8MM_BLK_CTL_H1_PD		2
+#define IMX8MM_BLK_CTL_MAX_PD		3
+
+#define IMX8MM_BLK_CTL_DISPMIX_CSI_BRIDGE	0
+#define IMX8MM_BLK_CTL_DISPMIX_LCDIF		1
+#define IMX8MM_BLK_CTL_DISPMIX_MIPI_DSI		2
+#define IMX8MM_BLK_CTL_DISPMIX_MIPI_CSI		3
+#define IMX8MM_BLK_CTL_DISPMIX_MAX_PD		4
+
 #endif
-- 
2.30.0

