Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA01D3C8450
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhGNMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:15:23 -0400
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:48353
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231210AbhGNMPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:15:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQmwMKbxY4jcdFcRUnODurivO8Lz1PQBSQMcT1h/n9WVBpEBHL7Yu0NOwbTBNtJ4fb+YU49MifVC/eRchvkqnVwvCDfXQurDrEy3ERjR/8wbzcQc2HECmYjKgLNbqIvT7jlEf26aHhmY6SMHH3sJXNqupKIKwoM01D5FxO79vxDaKugq7m6nYIWVYS7cpJ+FTlQtclzZJkMOhoR7Z+RtDw1+i/l7j4tRNllOpU6flVeKs9vkzS1NrbYO9XR13d96wK4m/WMYZf2Wx0OgjC6K89j1X10Ug/qe46e8GDver4K6UDFEjhKSeXUGMm+arE13r7D4j/5qL2IM5cbKV2IZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPOk32ZSVc4edfCUhdRksh5+xB0A/0xD9QyGg/1xyNs=;
 b=L+D0Dn5KQAvQOl38UCDBlg4gLd+h8TwXSzSY4SDeXSwdQZSSklHHztoIGwUKKegtpQSu9aoahaVBgRwD3gyYhrKelScxlAbyGBYA7RGO57eeqwpS2HsibMIPBQ4TInDXX7uLHRqKQRM6cveDmmFPMmwfhZLdIc+t/ByM52CP29+AnawELEwE9ohmU95IgeYs/UR+MwVHrxM+a4IUDPE0sV/zbXI6rC9FwYWiy7VxiA1xMiN5JS0Rt4p5iuGJfwA1mLSL9iDOaiuK9dQkMrh2PtoJ+VBB0MOC5PMyRwplDoRNyIV3MoGjEm7K7Fcjec+J01RF6BMQkYHj9TeGXYtjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPOk32ZSVc4edfCUhdRksh5+xB0A/0xD9QyGg/1xyNs=;
 b=KS1Vsz65eKja29PIcfhhKtDPy2/lN+Efm8nqWezLdPVEyMOkHEGCHnMThWt3xMHV1GUR1IGbM9tp4EuAgiWr9So/dPi+1wfBxpbFZs/X/QL9+M1b4VTMTW7gFPuwt04ekQGtYjHWYsnnPQPg82JhDJ0R6ACUGuvw0iTwb5gU9cI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM4PR0902MB1748.eurprd09.prod.outlook.com (2603:10a6:200:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 12:12:29 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 12:12:29 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8qm: enabled watchdog
Date:   Wed, 14 Jul 2021 14:09:17 +0200
Message-Id: <20210714120925.23571-2-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714120925.23571-1-oliver.graute@kococonnector.com>
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::39) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM0PR01CA0098.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 12:12:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd477f0-adc2-4377-2943-08d946c0a657
X-MS-TrafficTypeDiagnostic: AM4PR0902MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0902MB17480370793884476FFC4288EB139@AM4PR0902MB1748.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkdiOe4EjB5T+K/ARLLbe1b5EqPJ295lJ/FEzJJ8uKuAJzRy6LUQF3LVCSbdPOqwMr2dFORYN0lom5JZtyjKQEEjiRe/fVbDT4/DhoEc3eiUKhPl9fIF8ZIuwbyoag3hqLlSVJDS8zcWFPkAKZdLiBdStPAkpv4PyIOnl3eG9RFaeLmLf/TCfQQFANji9euGYNSgJIjkncvu4ROku1G+AyZ74UiY85t86pCstIgE5Gf7sCiM+4hKSLmkgorfZZajww/vyash7sQIBvJOKbQp6MmCiuGCOjLV/fH1Ou/SsgI2yF+h9mCZgyiP/vpysQbIW83FTn3AmQnzYWzZ3eMWe7wH+E11i1XXSPiGEYPMNaiRZHDkkt1FSOUVV68Dm6PfIXt0w/8SgzB3Hs1EnZaC/v48Gy3nNbRJBwkJ3RZVAWO+8Pvy/DEDYSmCYz4kZB1/mcFYnI5zd2IVWajrl9W9EJ5+2jTgfVVIjsKCDkOKHebc7lsIasIdNHvLPNxw5OE+JOvJE8GYpkYvle2d4A33WBItlnSr1vAB7rdIJ4SUoeZOmmOsZ1UG37c5wM8WZCAYcquxV5FTjlO3wyoigFg59o4CThJCVUo8tGG1ADKOrCddkSo1/GHJhcYNL7m4JSN4f0Vb3bO5u1kysZ/DNPh65zUo5osWVkrlvGqUkJfQxLNUzKGFPUaEa8aUFGtOSm83lXWqfbLM7bt20U5o3Fr4aBe3/1sEtulul18PgK9897s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(7416002)(1076003)(316002)(4744005)(6486002)(8676002)(54906003)(86362001)(38100700002)(478600001)(6666004)(956004)(6916009)(36756003)(38350700002)(6496006)(26005)(52116002)(4326008)(8936002)(66476007)(186003)(5660300002)(66556008)(44832011)(66946007)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QH4dhSaLe0Sk2Kk74HEKCWr6F7Qdx7nWZb6mlqisIv1X3XuXIMWcLidGDo/n?=
 =?us-ascii?Q?wZTWNTvIvmCXL/g1JKISHeqbbvurzFpWBaonDwLGJfNVQnCCB09zmf/7Gh3+?=
 =?us-ascii?Q?HK7yuD1vjIMibgJV2iOVy/BvuHcDxjo/FlLMjoM/DyyaZ+cV7jrNar/lZz9D?=
 =?us-ascii?Q?RPbUSIIh19VRqzP3Enq+ixDaNlk9eWj5KneKxU2ONOhGbPx+snBOrGqToTkx?=
 =?us-ascii?Q?Xy6FEKzt0Kz/5TAnaZmQ2FtNRWvQp+mXMALqOYhd85FqSY0fpTjLbyQoJUMH?=
 =?us-ascii?Q?Fu27FHnevmMLyokT2FaNkc1vMKZaSNi9RexmmgdxxpLoHD+BJUjST/hmo62P?=
 =?us-ascii?Q?Iz5ZWzs5Auqf7R893pylYU3Fjvb8SARFcAlpJiL82+fMKIg4N7HBLTV+LOcx?=
 =?us-ascii?Q?hXGm4B0ebaiwpedO+tiPqt3RjdIBOSxaOpq0NzkmcywlZHYAnIpzKo8Wai0Y?=
 =?us-ascii?Q?qRdTHpvJf8ZoPRB/qZt4Oj6nBxA/uxf3v+vRmhpdt0paHpHENxC1zVM+1ENX?=
 =?us-ascii?Q?9hopPebAgQ3jIRkV4sLVurg7ZK8RgrlgDclZXIP/CYL5/klmBp277zCORuSX?=
 =?us-ascii?Q?kx4BodtbUYdIRL3MMfPjSKyLRhIpXKXqzJrBsm2HDvgk4zoHpaviiQU9ZTym?=
 =?us-ascii?Q?STQktFegIdEN6l5firxkVydTxClTuN7Vjjl5Yg3l68Omzf67aj215wVezYlC?=
 =?us-ascii?Q?c7qsQnOjDu7DN6iJoNNU04m964psA0WWgq2mj82uHPvXGnJfnsW2h9nfLgGI?=
 =?us-ascii?Q?AaArzGvSj9ai023CFLS5dRBxXkeGIBX1mVQLQh9BLACXQThl22NKjC0mSr7a?=
 =?us-ascii?Q?mWT/Cz9BXMgkySMq04dPm56/PBiSCnVPz6/2SIp3ljqvIgIF5uX9K/KEbhST?=
 =?us-ascii?Q?/myHLH69gU7UDZUhtvNtQjWF4gyuFa70DT9z9itpSFfVCTdnVuZoAABQX1TR?=
 =?us-ascii?Q?aXpaxTJ6nQVvf2s3ZpO2O6YJmlQd05ycCiW73QjUoAoyydBdXKhs/Fa5kfj+?=
 =?us-ascii?Q?vtNSnoQSGpnDTbA4knz5C1Rl/4CEI7TGb8K+M8lhz40smtokdhuOq+jVdufw?=
 =?us-ascii?Q?8etY5u/+IftCvVLGMEIND+6X6iyGSfMmvAOnvFJcHINggCoZ/vlonMv1T3gp?=
 =?us-ascii?Q?t9c3RhzWdQnayuLXCbWVIN8b3alwkV3J/4aoGmbmV2oF4qIcdqy6ASIg20In?=
 =?us-ascii?Q?RocfdSiz9k/Wv5VZY2BDxocAb7mO4RLn4INOXsAQvZF6xblRSgf62Cn6Ir4P?=
 =?us-ascii?Q?pjEDSoHESdmbZbwX5gHBPzP/a/fx/v88yamgOC9SlpW0HSwzf2mCe9AHVOHt?=
 =?us-ascii?Q?PFRXYUUKMFf5ErzNQa6jchcx?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd477f0-adc2-4377-2943-08d946c0a657
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:12:28.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jExeA/vh0SxRe2Lgl3+mfMkLDNze4+cbuvQX/j0pecprPj9n6OwrvRVU5bt3PepBbvhxzfjLuJoeuF8mUVJ9vWY7hqocao+PfM8NuiPNYec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable the watchdog

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
need to enable CONFIG_IMX_SC_WDT

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 87a4c3ec8861..b822f95f9baf 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -169,6 +169,11 @@
 
 	};
 
+	watchdog {
+		compatible = "fsl,imx8qm-sc-wdt", "fsl,imx-sc-wdt";
+		timeout-sec = <60>;
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
-- 
2.17.1

