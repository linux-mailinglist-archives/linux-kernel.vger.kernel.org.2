Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91B3E343B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhHGJLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:11:39 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:2309
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231679AbhHGJLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:11:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdaXuzb1vLkXOJjRB8mD/PpeG1Grl5IqCIRLKPvIWm+iBpivJ+HSASD+UtqrnoScK29hXMLWY31kwiblC4ixz7tKuoidYcJNUPVR9a2M2MVix/hIs0G5KqB5L7JC8VGfl0bF0Cc/00mfql0VDiP11SpV0C7zL8WuNA9SneqzHB7AeTCvugNyo6QFZFnL/eHUJ7o0rju3DvDrJzdh5o+kcsn/gC+FsS3i+8XCCcoclxxHgnlyPbkYKd5EESyfWl+xparZd5zTOkPiEl4og1HxOsunXkJ7CRR8Fb4lTViuTO33SvuwGdsORf1i6KKQY0R8LFaXv66+NFR2q31pEq33Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htRpaPERFok7cHywUvVMv5XS8s++ZT1E6MpcRGOv268=;
 b=ah/DwMU7GUTaU2H98rubPmJMJ9W1oeZNikQ6WOhe/cIChKM2RnMSK77Lejs0verWtZiGg3/ZEJV93SLc5hbvO+HzsGRLXGQUlBL75PyMBwR4bCe4eqEnMZutRqQ+ApLXeHjfYQrGtRDIGIKgngRVl/DI1OlK4gO2Vc6Rn51Gw4ru4l7LrkYB747XZTtdhHOxNcRo97mo/gHVyfiLlk+yzE/3tmyTk8BW2yDMg1y2vttARHfvn8FV/S5YI5/agcGlEVCs/wH8Yd9YsISy9Q3DLf2ngW3Iw8kCwyH2XuV9UmSQmDSq4+DjQjWDdUJWCPPtVwTMuLXFtFCPpuOv4mycrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htRpaPERFok7cHywUvVMv5XS8s++ZT1E6MpcRGOv268=;
 b=XnSVGL3lu9qgQ/z9vgrEdMQylnR2+rB9yj2RYXM68rkfSVI7eNwChVXPPbHA/WBfV3Ss3+Twi2bVfe9a4Cbt8fgJfRMXKGvqcCVZVS8XX9Yu/Wxv7sf+a5MyWDWHyu7lyVIbZ7fagoYvPxIpulvtknjEO7d4cL6/B2St0o1rNWs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Sat, 7 Aug
 2021 09:11:18 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4394.019; Sat, 7 Aug 2021
 09:11:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] arm64: dts: imx8qxp: update pmu compatible
Date:   Sat,  7 Aug 2021 17:45:36 +0800
Message-Id: <20210807094537.20290-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210807094537.20290-1-peng.fan@oss.nxp.com>
References: <20210807094537.20290-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:3:17::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Sat, 7 Aug 2021 09:11:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc5b186a-2c5c-490b-516f-08d9598350fc
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7177E0B5BAEC909FA21A4DE0C9F49@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rubG3pTb8O2aMiqYKgIt/Kkp1DaqlrTcTibZAtigB7af7Ik6zIsqfrESZXvBFOgA36fQEAmhXG+eIBASO/GLphxFXWUYPghsDffx4WI8x7gJGiGy0fIKfG5pEmPNL/BiLCSznbotgraUjemRX7AymkOOBXu/1RwGQ7U+7W/fbFQdmHDDomxOTeCTnCloW7Cxa3YDpy++Xoi5Xvi3NxkT5vJ41NpjBSIaw130xHrdSkyXMZU2rMADcvMhaD7PlSPMyd2f68kJ9/cQpgOr70NwaWZuUTN4SbYs+DDLuH+8R6haUDcaZh1yJNrDh5tJp2CXjCqJQekgQY6O1RUOb3L2R0E6g6ZIcJBUAN0LGqrrJU6DDLIdfPPDw7qAMqL5jsq+TUyA/1PO4eoLz92DbwW5pUM+FWPBjKJXnvdCdy9tdXzsOC9htBJAd6/SclEOVX38Rle2GH0pqY14U4eZ52HHPY/NlaJf4c31OCOeU9HyeNJRhC/sCOE0azWRVPlcxFI+J5gAeq1BwdZ4C66uAcEI+xSSo5UqQxG5Edlf7QDTtEKJuivWy3J0twvs8UuxUT7mviSAWOOo532Tw/eYzjuWgRUEekGB8bmlJw2gxllvAF1WY04UkyTSwuMZi57SBEUbmPCBVaBL/kGUQdw9dfczV+e9CXGxfZ7by1fsGWZbjpBS7WwWhy/nebF0UmUM1pp9B1QnglKguo6UXRq7PnTW7MMVP/oGJlmgA6BUFnWqGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(956004)(508600001)(66556008)(66476007)(5660300002)(2616005)(8676002)(6486002)(86362001)(52116002)(6506007)(83380400001)(1076003)(4326008)(2906002)(6666004)(38100700002)(8936002)(26005)(186003)(6512007)(316002)(7416002)(4744005)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBMSdSK4xOpMP7JsUCqffSMvcTgW9qLtNOpik3s+M0MD6/37qpji4DXtl6bS?=
 =?us-ascii?Q?l4TsRixTQwxNv/iCy22TFueTNPVrQTB/ma4B7EEBC44mW7Z/JFHXEuzTpcsa?=
 =?us-ascii?Q?k6I07+c5dDC9pstplMX66ayqcMYsW2ItrS9bU7stnGQpbUPzCxC1P5tFgb7C?=
 =?us-ascii?Q?Az6rB8dFLzNZrpsPFeauSjLI6lNzLqTWw7c3jE5301ccZ83Ttk/gjHD39MTC?=
 =?us-ascii?Q?/YoaX8j1UurUW1h872pwMOSnlEYPsiiIYlNgF1dAH8wK9u+ROYeIR+Uw3Y/V?=
 =?us-ascii?Q?VZIrk9GgsHjBJzWieiZ2Z/EIsHGOMbYDvUE7eSu6+qkXCPMePRQRJ3cXQRaJ?=
 =?us-ascii?Q?y2gUGm7W3lZT0Nj+IKNwO/d5qwPE/ijjLbd7kMKtmhrMO5aBqWVwC79Pt27n?=
 =?us-ascii?Q?YS0PgeDdq1y/zhaC74JN1KCAlgysElFycR1UOZ6+YRlioM6j5OL9P1jsLt6q?=
 =?us-ascii?Q?Vc1K19X5z71AXk2M5lNifUe1+lX3mMiRwiqnPRtPGuM/eKg8qsWD0TzgWNxo?=
 =?us-ascii?Q?cJHSoxntXxWWmQKCpOTu4+B0gyWyoBT0EiCKOkkkUtYlxOkhD/zQCy0twZW0?=
 =?us-ascii?Q?IiuthHSXvay9Vvg02ZjxKKNqAQ/JmTEsWLQDtpdN2ky6omQ9BezXFX9Gm/KS?=
 =?us-ascii?Q?K6BUjmI1MhVpIpPqQGYT5qv8Dgrs9vOwUj5+IjQ1vanbGEEAjKQQvIGmV45b?=
 =?us-ascii?Q?45LIMPwWdP6bBcPcl2CUrLla47yWao2ZjRAXBXZxmIHLno8zn4WnoB4F0xa2?=
 =?us-ascii?Q?q/H31K9DW3AGZlO+rc0q9mzZU0pnsqAna3+UmC8jYSQPMDmEh11Mf4e9A5FV?=
 =?us-ascii?Q?UDSnPzOidyC4pKxwsLbs/IktWnGZBFKKAD+PpDduPmrKKednEqk0656zyzA/?=
 =?us-ascii?Q?qy5OT0nUseAlD/r3AnkwK5m669H86I6BN15qr3SOzKVe5AKCWCapVCklJIzH?=
 =?us-ascii?Q?fFSfpL0i9QEcKePimBZDtG4e8Oaqt69eJ0HdDkltPj3Ueqnzjzk0InD9nCPX?=
 =?us-ascii?Q?1F669Q+5Fa55N7cohtCwy0RaJjkmmKimZt+mqpzXI/oCsmKlB4vnvdDprsw7?=
 =?us-ascii?Q?70LwFAy3wgvpEoOm3n6croahRBLeYiXfcHXXSWRuxMX0Y045dvxht/hyXt+q?=
 =?us-ascii?Q?fjRSiF46xf/QK5hXZY0oO4lENrDr96z3/Q67d43pSz7WEAeNu2wjNEuakH25?=
 =?us-ascii?Q?SnDwQVRhLW/zx5m4THUzGZA7iopsiWsrZr/gX9NvGTMaO+8PCdaEDWrOGeyb?=
 =?us-ascii?Q?xyAn2Uu/B371+d6GVQEiE1SgOEvLpYiW6lb6Rwr2I/FpRw/SkUKl9E0dtkdX?=
 =?us-ascii?Q?k+Urh97gaDVRlg26mLE0Xhf9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5b186a-2c5c-490b-516f-08d9598350fc
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2021 09:11:18.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbdAhYVqioZNyjdznEYZB/j6w5w2T56tGsN9NXJ7Xw6nuY61k0V8CqpSD/13gZ/5kTWnWpztbzt01CJHqh3xGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QXP features four Cortex-A35 cores, use more accurate
compatible.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index a625fb6bdc62..617618edf77e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -141,7 +141,7 @@ dsp_reserved: dsp@92400000 {
 	};
 
 	pmu {
-		compatible = "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a35-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-- 
2.30.0

