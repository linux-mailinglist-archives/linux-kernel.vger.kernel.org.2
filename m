Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7793453EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhKQDbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:31:40 -0500
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:16734
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232818AbhKQDbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:31:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ8tI/6Rd+41wqM6q2HI3KQ3kz2yd2AdShE3V5pPibmKgYt6ig8EnOpNGVrYBPH+znSlPwcMpvBEpl6cTh/CMDzkWZ6foBg9GDlSydU1szxScHF02+hiZx+16kO9t4zgsLkpskeyh7Od1mAzch0glWHtPLEpXiHKh2nc/o6XiO16erqJTF2SVjXhb741d7C0DrtItHEqsesqGMbsSgPwEVrzNViXkCQYk9sj338c6MapBjvDZggrD4JFyHfk8vWRlcXjk8OmkxLse2D9QRJ/K/taKVPPLNVAd65Qalzxopoiz80rAXdofmEV485/yd8LcRkcqP927YMalkuGRzNdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4aYaE0Vj6hm7tKn9sq6Z7tfBpPvzRVMZjUloE9IhKA=;
 b=D8mAofPHmYC4x32Kh6ZXRkxIbIm10+f70c/AWyTmmg5+qTHHUyjvjjv2eDwA2HEfQl7wLPGhr0sOmA101PKbLMUjJsdFdb8dbttPU8KT2pY+GIIxR9/HfRXP9d0/eK3Hj368X+0fEia5LBeWoV5ObfTYf2dFJXyuW+zOB5Ii32v+zAiYSqUlO0fDXeXYFvbWlLm4yFoh4M32F/a2BuzfbFckpoJvyuQLZprv1kl/DCgjtvmnSR082qnXrXwPGM1SPq+l/OwM5LKprY+aCdmNTGzcWgCXbxHu7N3jk69A84aGP/ymNxoo3cltB7G1PyRXQx06Xq09kNlsXsfm/YgkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4aYaE0Vj6hm7tKn9sq6Z7tfBpPvzRVMZjUloE9IhKA=;
 b=cBqGtcs0ulIQvWlrJN0V7KI3KCBLgFDNjsByUl0dgm4OpATuDD1w0t1YEj+GxvuR+MLDnaJPhltRk6rl+8Q7zeh7DPpk7e0M3s9XpOVREAsHOa11hlAKTiO9O2nVlZzH0ONKd/jSi8eo0asu0SHVuZqeBeTbb3vXASbOGgn+a74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8518.eurprd04.prod.outlook.com (2603:10a6:10:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 03:28:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Wed, 17 Nov 2021
 03:28:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] dt-bindings: power: imx8ulp: add power domain header file
Date:   Wed, 17 Nov 2021 11:27:38 +0800
Message-Id: <20211117032740.2518926-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 03:28:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 196ed16c-6a89-4352-35e4-08d9a97a57a8
X-MS-TrafficTypeDiagnostic: DU2PR04MB8518:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8518B2D268D93CDC5BA83C62C99A9@DU2PR04MB8518.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfQQNuf38KJg3vMs7CO/AB1258coWKEtycNy+7f/F1lj5vCgBJ9u1OnFeBjqGSbi1rA9iCYpVUKj41IAvTPkhN0oMNNei9d1WN/EdVDeXOQcoa9XVm6xefZcE1r0xF9ahfG7vVtwXqF6U22+RRCbP8yEvWIM+NdOkIi2LGOX9CuTNeyyDTcs3Rd9xeBAOQj1xcBI4UxjBQQlhQ4OW3SOYgRkBkZNNDc+GgC4qu7/haYDMSIcdE66sH+ios8whv3vfoexwH9/TTTUG4tJID6dKC7O+i0scFdveLF6CpPctsbWUhZavOqHukMJnQ6dAZewR5nrv2DOj6lvduZUQn59X5DWbs3tJHehZlhHDaFX4oURDDvXonLMQAf+hqrE5vr+LTa9psViXwtr0KcjnA46IaLebzQ5QsQVnZKE45oHrW8UNY/C0BPs7GIcq89lOJlr5FUQoZwwqibZVksmQhjWDad39snFQls0azH2XkgFg0fszLWOb7kezzJpReM3w2cy/iJh7/ZW3okduUdZOOoSdFN2dt250HIoKEnSOrEwcbdlzMmLIRlo1HANM0Hya2127Zx22t9ZZGmBB+J6FR3tiwPJ0jnD4uH5nQVBZ4XQujJFKQ1q2s02V2vvt/P1Gr4pcj3bBN2s5mbN1NwQ2jTp41FXnAEHx3KK9ffAEd+FLGP4hHhgfcQ66fE6P9b+Bn91lQZU7la+3Uy7s7ZKRAH3lG1cHE53BhWylQZFjTPzgWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66556008)(66946007)(6486002)(26005)(66476007)(38350700002)(508600001)(956004)(2906002)(316002)(38100700002)(6512007)(8676002)(1076003)(186003)(4326008)(52116002)(8936002)(86362001)(5660300002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRJQRYemMTRH6syXeQYMCAypCAk371/1r/DBxYek7/EbQJ7SgcAcFJgL9F1E?=
 =?us-ascii?Q?QWS36p9m2wrzqaawqoVHL/Rf/DOzRpSNdB0PVsuaUHWphQTe+6zIJHZfvYC6?=
 =?us-ascii?Q?U7N/Kdq7Xygrjy1vSLZLU0vNrWrMr1WxyYLPOmjTQl3jbfpLvYl+YxK4MXnt?=
 =?us-ascii?Q?5BpbrpZoTUBBAV9dlqYPTLrh5edC0qnKSJrTImaP2q820K4reKxvkezwj5tH?=
 =?us-ascii?Q?ez1pdvCZnHFqEr3NSjf+veaJwtbawisNv9aDo6N4UJP+b3jqchSY+i0hDP90?=
 =?us-ascii?Q?29//ML1/Jsy/sCV0sCvG8T2sgE4KKPQTyDMRPk3hR5LmHKEFm4Z+oBnmnAyC?=
 =?us-ascii?Q?CMDs1WKiZp214h7eDTlo3+ipqs/YIbEkB/NQLGUkuYu40wU5h/LKlP57ClHG?=
 =?us-ascii?Q?qsQXXseJhoq2LRdTYeJWu/RuqTtINAhUhjkhHVjPxyEw79IATc8/fu8ryKPD?=
 =?us-ascii?Q?x8h6Wp0snHcGvUP2d0G+5Px57HnUf4bRAI3JPLkQ3TKtyX1Me7SycD6VJppm?=
 =?us-ascii?Q?RnPYdYvMprC5SrndcsIF/cILbmPc1e4pdOmJCJstkqt9zb8PrjTJpYI+JAjo?=
 =?us-ascii?Q?SzrN4DtoYVLrG+6NlT/Qk4T75RvuWmbNlCdVlNzJ6VxX96//EIQaktPDEj7m?=
 =?us-ascii?Q?cAGMcjks0dR2Bc2kN8zGVeSArULPNAgkdgMWAOLzLMLybOl8QijBrJ0ilYEU?=
 =?us-ascii?Q?WK9e4ejnj8ZTc85HmVP4UJol86HeZCM3A2rBUlHsdU/+PqpK/xYhQr1Fq+FV?=
 =?us-ascii?Q?Jf1JjYqlBOMhMYeMS2SB3bBSLXxbwQUTcVdnDGt70mcfsBdUUUd8zfj0nu6z?=
 =?us-ascii?Q?/wk0HXs0wAjCJV/rkTpSFdxJAKzX/jcA0UF9mihdN13fsjFkvFEYPgbTkGw+?=
 =?us-ascii?Q?6vhDIycC8OgSD6f9foyABWtJsNlMmc0QzKIxl7DDOAZI/b8s82HGoBP1cS3r?=
 =?us-ascii?Q?XiW5ODsFmn1AD8k9EIbIk55PQh5lwufv6Mv+pWqrbHM8DmGNByhWfly8aeKi?=
 =?us-ascii?Q?T0vClEb8w9WajuUPs2Od4RS9TsfhFiZWl/ntyzuIvSlTqrKrxG0UslesMc/Q?=
 =?us-ascii?Q?ZBdpQHyrIZcjx1av3n/p+ESquBX+moA0W2uWmX0A22jdpIiGGttcwGAzeUmz?=
 =?us-ascii?Q?I58EcaCKY1Xa00tYU0IvoyAbClF7s0Ka91wjpkDZ3WERGkHuDTAFKK4zXuXN?=
 =?us-ascii?Q?DKEIxz6Q/9205gk9Ffp62tfREALalK4nwdMGZhOWnNRqhdmL1fPgqLQPEhxj?=
 =?us-ascii?Q?YbBIqvgST0gyUOvDai5stquWiog6Q/qiCgmwt47d+q74WwVnWB1aGDVKRqaG?=
 =?us-ascii?Q?CH3evUp3DZdvKDji1Yr2ovYGAL3NmZMkBQMdVYIdohjVzM0IrPZZnZ6lU8dJ?=
 =?us-ascii?Q?KrHnIgveWlqvvMWuH/apdwMAsHJCPdnNTAOmvBAMl0+ndF+RsVbpA3lnQmbX?=
 =?us-ascii?Q?kynRKRKjIYLlfmenuizgUYqmBv2vowmU0eYnV4TdBIPenB9zVwn+JKvebFJ+?=
 =?us-ascii?Q?JN/FRReFqA8Qk/ZkAgt3BVcUn+DnbhAEiC+2XqfKMo4SFw4UUTGEqr4lGQol?=
 =?us-ascii?Q?odqkDDNdJEYRH99Zld7R2v923FTHUBQVBCu5Riw4SMH4NkOFNfElbJjn+F6g?=
 =?us-ascii?Q?A6STBwibLILfxw1JQh41QS4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196ed16c-6a89-4352-35e4-08d9a97a57a8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:28:37.4557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P5DKqz/wwz0u5vOzCap2Y89B4g63dVbNAqDoRHJFWONW5x8t/SjYS19d5bNiKziOf4fY9WcmSgjLsbDu3A1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8518
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8ULP power domain header file

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/power/imx8ulp-power.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8ulp-power.h

diff --git a/include/dt-bindings/power/imx8ulp-power.h b/include/dt-bindings/power/imx8ulp-power.h
new file mode 100644
index 000000000000..a556b2e96df1
--- /dev/null
+++ b/include/dt-bindings/power/imx8ulp-power.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2021 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX8ULP_POWER_H__
+#define __DT_BINDINGS_IMX8ULP_POWER_H__
+
+#define IMX8ULP_PD_DMA1		0
+#define IMX8ULP_PD_FLEXSPI2	1
+#define IMX8ULP_PD_USB0		2
+#define IMX8ULP_PD_USDHC0	3
+#define IMX8ULP_PD_USDHC1	4
+#define IMX8ULP_PD_USDHC2_USB1	5
+#define IMX8ULP_PD_DCNANO	6
+#define IMX8ULP_PD_EPDC		7
+#define IMX8ULP_PD_DMA2		8
+#define IMX8ULP_PD_GPU2D	9
+#define IMX8ULP_PD_GPU3D	10
+#define IMX8ULP_PD_HIFI4	11
+#define IMX8ULP_PD_ISI		12
+#define IMX8ULP_PD_MIPI_CSI	13
+#define IMX8ULP_PD_MIPI_DSI	14
+#define IMX8ULP_PD_PXP		15
+
+#endif
-- 
2.25.1

