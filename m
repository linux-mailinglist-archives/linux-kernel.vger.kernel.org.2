Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D753A4EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhFLNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhFLNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:00:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CEC061574;
        Sat, 12 Jun 2021 05:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Efo3/enhUv+yANpdNGGiDAsQwsGyIeMHqYSt2AJUx92wN5dqnfZ224KxG5n42tAVJPnFr4hmJuTySJWRAMDUOQDRX6vK/lsGf3+qPT64tW75yGSxwUx6uNiAnXuUVcVgyISEIaAg/Pax18N6gSe95X/SKP9X5tRyZBP+IaDz9e/xebJC7hGQFj5XFnmuc3m/+jr3LdLmqAywtwA81uxq2X09FUlfgNWnKn3Dxi8CSRYT/Kt7tEaUiII2nueSd39zRO2ExbpCp/YlpFI7o2h01etOraRsHecopU2i4iweRQZx6/mvNJ/yGewBoDMvMb8n3l1MEbFUmZWzIiFLiZfSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=Xqe3WmHRR9dOq7ioilOY4v/CVvZpDxQF5l/chHNwtK1PrZujeMYdeDSOU34H9Ewy2vYo9FteafAchKyhFUkwoUy3hL/FofjEYHstC4PryxFNEG7zac8E7+LOjvBU0Xn7eCgY0asPwxp9yElRdwPzIfTU/9ODIWtmksC+QDmPy6cYeiA1xUm/aCKMbdaq3y+16FRNRAjr3MKW3W3XYPo1AEwgAtALITBmcyWxQxwbMbCaWODEMA4K4WrycdsxJGT0x9y7k+le65mTh6RsluyjmIV0+vmISANTSX1V6LAEp/vc/1e4zbsj6R4bKDoguBygLIsEb2P54YmLiJAovmefpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=LnFyifj5rdidrzeSm8/F4QqS/y1nKQBoy8W0ngtYaZtAlrEtoCM/n9CLDSKY52hPoB2zRWd3ClLsqYWgZqsVJuaEHBKpVppwcaT77kkHuPkcgGG0PPiEqiMvFicEWffyqtAm+uPNbvyBDzuHaiT0aeJ4r6v6KuSlfsxZMiUmduQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Sat, 12 Jun
 2021 12:58:38 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Sat, 12 Jun 2021
 12:58:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V7 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Sat, 12 Jun 2021 21:31:31 +0800
Message-Id: <20210612133134.2738-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210612133134.2738-1-peng.fan@oss.nxp.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0174.apcprd06.prod.outlook.com
 (2603:1096:1:1e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0174.apcprd06.prod.outlook.com (2603:1096:1:1e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 12:58:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da71948f-21da-4c5a-1c31-08d92da1cb82
X-MS-TrafficTypeDiagnostic: DBAPR04MB7285:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7285D3B0088A403E2DE17DC3C9339@DBAPR04MB7285.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FQre84eeUINz8MhWS2EreZ2fUHcmRf96iP9oD3RI2+aqk7YWJZsLEKn4AuG6b+eNbJKmI7VA6YdE8yuIWrcRwSFy5pOOs6QRGBv7/iIquLFQROmQvbzJAtkmTe7g+dMuXyvViOsAmpvhkH1DlRtZa4zAjZ47EuYpjNumOwJsVVws9KBN0DTm9Y0JTz9ACHOrhsglCnTos9LTlXpxAwgJD+UtAz+ernKilEtktjVWacZk9+MPztkbJO8yP9YDbILqQia1KkLeWcuDKN9YVHaIFodj5A9MCNuFW/f7BaB+rSMsguqmKHfSdWxgnvmNdyCBGp8AQzWw8mq7FBpToqAJ8Rt/E764e+TdJCCS5rCHqjS1w1M7Ih6+ET1ZXN4gPI/AY0YV4E3lW57KpyN55rkJgZ82upfJd/dmO3FKmo1DX90FtSEF7t1NBdmDIiFR4KvYj4xH+hLyfhC2sHN8O3lB8YIwHc5l4jmO+ercwYamgP78vnqtOX25d90K4X8TYBRUY4pRayycTHsxG2UUEnlKGKSc4vTEDG/r3GUNNB9lUj+YwNfz9G8Ig5RFm8iEZLgUcg25CdOclgS0Z0L+AP/bSxIYsZG6SJ9hAP+9iHi8eb3vm7KOxQqgNqhS51nZS0PJQXYxTB50MhIlUCZb84itQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(6486002)(8676002)(52116002)(2906002)(186003)(1076003)(16526019)(8936002)(26005)(4326008)(6506007)(66556008)(66476007)(66946007)(6512007)(54906003)(316002)(38350700002)(38100700002)(478600001)(2616005)(956004)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t01pM5HdGR4bPemuTBRb8/4JIHDRYyiZMmdgw7/w6jBef1fsk3XEcWM4RASZ?=
 =?us-ascii?Q?/e64lVKSklFG7O9PMNI1sfp42G9q7bGai9GOLP1NS0snnXwAnNo9Wtwm9Itw?=
 =?us-ascii?Q?t1zP9IyGBME7Nf/DYVMdjit6nZf2H5iRn46T30SJbaQPS8CJ6xCZYx9dlSkV?=
 =?us-ascii?Q?2NooEWV+2vBVUGL2p4ytRR9gOHJ9oRMHFvAkYjFfnPoBPv7jRCwgnFiand5o?=
 =?us-ascii?Q?iBLO59FRg3AF2K+CAoo2YtNT7PcSfVQvjQTCQpy1hfWMHdEbbFXAMhkdcyi1?=
 =?us-ascii?Q?bJEXTvti/vO8vzS/XHgdZ/zSCKOPakuisrultMr1qOmItkBeM114PN7KX+Dy?=
 =?us-ascii?Q?MpqCRa/f39exhgzcM/AZlUceYZjNtOkxlACmCAsT2veHS1b/A5kQ//vm1TOg?=
 =?us-ascii?Q?nVcJRRpdWZhUNmvd+RX+U84JT++4JADqsb1IixcXh+49qCFO66juESOvKuWs?=
 =?us-ascii?Q?bQiB9fVElKBXxhWDmmd+siTkzqUvjLekZHxaGKLQXvtKQMAe8w4zKJP9RpBD?=
 =?us-ascii?Q?AI+esmwRvyjm+VbI9zjNjfLH5PBB2VtJKrBwNZ2MZrnWZW3nGZnjgXXtMigP?=
 =?us-ascii?Q?vpjTwwGPTkUNN4MYgAru8BHxk8sCwB0xZyxwK1lu8NoubEGwPztIw3tJgmIm?=
 =?us-ascii?Q?DUY5FL/mFGMh7I6ktyRqlceQhb7RAFdvcXDBsaA8DDa6xK4ZC9bR++JtahTU?=
 =?us-ascii?Q?cKikiqD+Nmg5tV1NbvsdJghj7lRnyK3QB5p2Um1GZEDE2XbfhDgCAttRH6DR?=
 =?us-ascii?Q?LLJQY0b+inmuXK9tyLoybQsetsm7tzj3it5ufHafvc6zf2JUo33roqElaQjx?=
 =?us-ascii?Q?Zei+EW8F3rMAClwKEKScNYbmn96zpGrlO+zzWW/b79f1YFfpJ/24BVhIN9B9?=
 =?us-ascii?Q?WrJvVeZt0N0TErQzjhYGMluEymCREvdV2f5f46bOFjuiRTktjzu3DopRQoiW?=
 =?us-ascii?Q?gqEKUImcTefbMwSJWUt+yfjPNlE8jGYvFw0HSACmymYjWHAHx2ut/SJnqDl1?=
 =?us-ascii?Q?uZ4kUgR6OzrkiEsQQZMPjprwv8ApPYIiBD44VPLcZiEACBiL89oczGGkizrM?=
 =?us-ascii?Q?mj523sgeE79AmSm4eHXy43xH2lJlGCgr5KlnHaQWTH6UeuuGItUVXKDOrzHf?=
 =?us-ascii?Q?srjM2rwg5pgy92q1lE5ljNmqIeEUp7vdYEVWRRtcxO0r2b0xhmhTiZkdd37/?=
 =?us-ascii?Q?Jw1gZVVo/S/Nsb1LJpkoUBcTqA1t9OD+PhHf4HsCLtz47N466/fAnx06G3Zw?=
 =?us-ascii?Q?mI0YBEMrNIDLSvVgcttpH6biIzrBRG/5s222ScOWIw3bUb/9DlXaIAXMG6Cm?=
 =?us-ascii?Q?lZ+Ioejc9BEvD/Be9pAo2DRr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da71948f-21da-4c5a-1c31-08d92da1cb82
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 12:58:38.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXDrdOzfjdghayIKr3/1aruTjLrw/b34kNheLH+uVJe+x/MnZvX2B87ia5R1QKtyjqkOl6eGjfDyhbkhjW8ryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Adding the defines for i.MX8MM BLK-CTL power domains.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/power/imx8mm-power.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
index fc9c2e16aadc..982ca2939cdc 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -19,4 +19,17 @@
 #define IMX8MM_POWER_DOMAIN_DISPMIX	10
 #define IMX8MM_POWER_DOMAIN_MIPI	11
 
+#define IMX8MM_BLK_CTL_PD_VPU_G2		0
+#define IMX8MM_BLK_CTL_PD_VPU_G1		1
+#define IMX8MM_BLK_CTL_PD_VPU_H1		2
+#define IMX8MM_BLK_CTL_PD_VPU_BUS		3
+#define IMX8MM_BLK_CTL_PD_VPU_MAX		4
+
+#define IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE	0
+#define IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF		1
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI	2
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	3
+#define IMX8MM_BLK_CTL_PD_DISPMIX_BUS		4
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		5
+
 #endif
-- 
2.30.0

