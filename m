Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAE3CA044
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhGOOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:37 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:8580
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238400AbhGOOK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhlq3d3cH+eCjHbGEBe8h+io4dNapRlejzdce4f2WSlMJIFpS4QilpdPaGaPNQ2aWPdggudLHQsJIn+PYOLvv6qlL9RG9xjp/Mp7vdzYOBwvh5fYFSqTU67AyrMSNopcs1+LdErMYsiPEmchKj1AXlauVbsWfH8c0r/Q2+csna27LJxy21NtgMzCODMn5CDcNAVnlUv73r9/sNvbbdzzLG6pOaQTKSFnOpzDw0sox2f7S1x1JSgLhY7WfPG/XQSO0WoxiulwiS07q9PxuJvo1Y5OQp/CgGPKDvAMNvDZBdAX3lRzUG+9LcZ0uvY0N84k4d1U4reu9Q9uNd3CK0GTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RX52r19OhB52KJTPgtl/o7s4LV0HoTeSLFT2haRpe8=;
 b=NfTTOR6UQuoFnn5QC2/KEBCzARObcw3TNqQb2am6+KIY66aI9h1NvWB7mNtU43xVKdnCyVCy8hmBdsjDOJn/G5Gc38Gb5UQpIQLzHnr+4vaDu7fQjiaJEyfwJ/sbkaShF9GVDJLER3Aix+asLy68fXWap2Em7vd2rJBpZiElRemQOctFDie1fzHlwByqaOZueUv8QireCDXum+U4DLn3sC4e/tEtPvdoJ8PuRkwxgquUx+ffr1rnGze94i55qtQyHKxO2foyZ12vz66sW0K9Pm18yLQvG3x56VppksYyMCcS9RDDhTSxC8YhXgGbpo8OlFJOOF9M4Yrss3Dc1+4ptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RX52r19OhB52KJTPgtl/o7s4LV0HoTeSLFT2haRpe8=;
 b=WBJ+PAKKN9R6nxhMlQ5cFG8ltIlzCu/OsouD4+vsGnAHEkOWGwuefsW3CrKK650JBu4f83lcWsxRkp49LlUW8s06Gus2jQ7x9NQxbzg31pStV+KVGezl3eiArcyUfIzjUdpMcc91/lbJEzoGr68lJDHxGLwy+l8skaMN8cHwIjI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 14:07:29 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:29 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 3/8] bus: fsl-mc: fully resume the firmware
Date:   Thu, 15 Jul 2021 17:07:13 +0300
Message-Id: <20210715140718.8513-3-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 591ec482-acfd-464b-9e0a-08d94799e176
X-MS-TrafficTypeDiagnostic: VI1PR04MB6813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6813FFFC376604F9ECDCCBCBEC129@VI1PR04MB6813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjMLBY0OIu13cPfVfXrPaLg2qhieKs4ebklSY5SDnCbxxdZSuz6k+lSGSSnJKrD3B9I1DQN4qAZIBaqpMvevRRuJ7ppM8OnRiHiYTeRt466R/x+x2XKbzn1ikrA6J/fk7nMinHTST0kc+601X+y20IXslQbwSLUnwszuh+T0a4sNclvwPuRXTzdiVmB6yFTKIIxWnK3SVqTOb8gHyKV8WcMuF+HBqiVd1ECVy9LByPYILqLBeiOdLHT4K7Rnvys6reWV4GqaRz1oDzLHW9hUapmfBdgM2XpFB0z7kG15AsHOmMAbOtm15l64IQjSEpcPclmcQQufScSS2pEWVdE3ur3uMYxmN6fn5xE3Wf55zQvn0zbGDKatL/QQeBdvxCs9JAXp22/xLvjXXcrwneeDuLFlZQM0hKUOctKx6oE/32K8jkNaz4agsv1ZieL1AEKChhibOj1eUPZuavlH+kcjgvYDnXvj/0kc1R7jF+CYwnGSl1OqaRQqATYmXynTTP9wF1O3k3AEXXOdr/RHVc5ShKfwg73iE8XtI/QWy0kGbLkQoGg7C/wy2pMP/fS9fIyxR/av+Tdshsy+Hwz21XvoY1DZSoynRJQ3cWFcfFVGWXSCIIQ8Pgl3wH3ST/4WkYOkr78OF/G4DKySd6H4IF4v1GYKwhHEPEKB1DdMw9t6hWEtIM4Xuz34hTb8y+1du0qYpt3TlScNIJdAsQ098FX+fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(8676002)(6512007)(6486002)(478600001)(36756003)(2616005)(316002)(38350700002)(4326008)(38100700002)(956004)(8936002)(52116002)(9686003)(1076003)(5660300002)(6666004)(26005)(86362001)(2906002)(66556008)(66946007)(83380400001)(66476007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8fBRxQxs2n2A+UnkQXFfk3D0lx4zvP+3FDF2g2sli7wvGWkBhAWnr1jgsc5?=
 =?us-ascii?Q?24cVoAoNI0upX5DrngWD02sbbv28VrX3F0ASEm8QY3lC3vCaXt5sWghVjBpg?=
 =?us-ascii?Q?yRjVOVxIo/5gjBycQ9iHjew8P4YhWqV6qDMjEU21PXFe9ZoThRcLowRoQn3I?=
 =?us-ascii?Q?JG6T904aosQ7vnnv8RBZ6ifbgAHmmv4uXFpwBpLw1/gD5VNRvGpOSPlp1R3U?=
 =?us-ascii?Q?uWZbVHf/ZNJszdSxAItXI7t96ClngNES2G8FHISHjubXYrfBwwph+MkysaOR?=
 =?us-ascii?Q?9UL29KNHUmnxrOhq2VbCaIm7ctrxP0GKwQvOQE0bSNx+quK9EW6W1KLptt21?=
 =?us-ascii?Q?ux3Kl3cBEkUJR2hbBleKgPNDBMcuFqsZRbwhuGQhyIm8FymEktVFqdGZO1nN?=
 =?us-ascii?Q?fN7NEIHgxxE+VXwr4JV5IqFp2PSbME0apISbvGBjG2WYZSz8uKR0IdlJsLTn?=
 =?us-ascii?Q?DFAWvsA93HornpnT9bkq+6PTK9AP1JoJG+MhkXLxgrQ/cHU9AYLe0RFJy/bx?=
 =?us-ascii?Q?sN2RnztKif5NQX8DssfnsHoNn9wU379v2D8W3sveohfRvgB336IzlB6BS8/y?=
 =?us-ascii?Q?ap6QVRfw/oxCVo5UJeu1P+mi4pJM5TQdQ7xB6X3VBWs/ZJfQ7XmLyDPzn9oN?=
 =?us-ascii?Q?Y8EF5zlvhQRXM3hshBN+frTOj+T4gOCaHHjl3Cvt+OJGrnmOkY1eFm9NP82c?=
 =?us-ascii?Q?RsUwiJeIalrORbfTvIWTsuAYIx5GhJwbS/i2XUdoMILwTrKbzgfmGrwmYEzx?=
 =?us-ascii?Q?QuIPa6u58L6BOw/PurByDodlemSVyeG9t17AxFmmy5jZmAnZh0H3QGopv9mK?=
 =?us-ascii?Q?3g8A2BlTOKdYHNPDz/KspY3wrlb3k4JG4IP5IIjDGGVwLRyLOQxH1rEHqsLM?=
 =?us-ascii?Q?y9gLUjTn6iF5zcj0t3G3DFAWkhVdRdiRTfPubPfZcVnZ566AzrCcUd5n51in?=
 =?us-ascii?Q?mhVDiWuRbwv7uYeBa0Mq0Nkq6yjmdQiSMcCD32Yq1Yk7aoVS0DaVeOAupeRi?=
 =?us-ascii?Q?I6NuENBg3lwq/92RPrvQ6D1QaDLGw5oseys+G0RjE2E5Op2oBTpaQOQMP+87?=
 =?us-ascii?Q?JT5nqK2bycze81y8xh5bAqXNkLDCpbfj0JU2lNY0zrr2UudEFz1ApWt8OEv3?=
 =?us-ascii?Q?Reo0Eg6XslG4eo4+5SzL1oUsMHb6GOCU5L0SdDcuC+qlVLN3dfpcH6Ll+4YN?=
 =?us-ascii?Q?Nccy7fI8YpKGUDhKpSO72/YH4D1QRogCVm9pufl17ZHzpFVHEWdlSKag1Wf/?=
 =?us-ascii?Q?17Un89go1TMNftMqtCRtmWqcxGQqfonRb6BXn5WTF16xRj0KkRGWAzkKe5ft?=
 =?us-ascii?Q?U9N7553c89tWaZd1pdw76kca?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591ec482-acfd-464b-9e0a-08d94799e176
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:28.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKAeWHROlJ3Ak9Wf/R9Ly+xwA6Z28fl/hw9Mk+LKVximVeP99rH2Mb7Br4zUu0squYvLkGy25sgvtodIDn2HUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The MC firmware has two execution units. Resume them both, as on some
Layerscape SoCs not doing so breaks the firmware.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index ffd7a1ff957a..2341de6bce67 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -63,6 +63,7 @@ struct fsl_mc_addr_translation_range {
 
 #define FSL_MC_GCR1	0x0
 #define GCR1_P1_STOP	BIT(31)
+#define GCR1_P2_STOP	BIT(30)
 
 #define FSL_MC_FAPR	0x28
 #define MC_FAPR_PL	BIT(18)
@@ -1118,7 +1119,8 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 		 * At this point MC should have all its SMMU setup done so make
 		 * sure it is resumed.
 		 */
-		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) & (~GCR1_P1_STOP),
+		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) &
+			     (~(GCR1_P1_STOP | GCR1_P2_STOP)),
 		       mc->fsl_mc_regs + FSL_MC_GCR1);
 	}
 
-- 
2.17.1

