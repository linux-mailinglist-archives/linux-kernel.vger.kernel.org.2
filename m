Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527C7377A93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEJDbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:31:06 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:13030
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230370AbhEJDbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:31:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpbP5GrOmNg1TB0alAoydq1MQbr0zuCBTw9th+eOU/s2/o++t2KGhleBWWCGDiQkF5qMV/vjo2nHrgsb9HLJ+rvb27ZFiVO+xbeN1b0B23dsQpiB7+lxKdxk71tq1BJfMl+pWGBSm/t0rRf+0nK0dbsB3XT5ZBs8medm2gtS+IUhNJXOKxMJZ3DKjUODejk3Scpt22sHKN2IbTn/Jcnfjc6HF/86uhRTBfEfHFcZy3LiLhzgFN2S8ebUXhRnd+Wt01sCCyO//SyL3srt6nAAex8AjNaOyUIsqtXckWOKGK3gm712D+cj4vwPMhN17W/TYkZ359ETh4V6A4SMndo9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjHmCh7i6Cgd6Gv49NPv0qXRM3dK+6grNipLLqomDtw=;
 b=jbr8qMd4wYXS2+C7/1lCANgtkCsUhQsBsCkRO7+/O8kLw3QysoCiHWmboI1nMGCR6ZIGgmvfpAc8dpJGMR8YU/AUk6qWFHJOzqa6P23pQa/WEkO4x+d3VemwwcTlNYARLZ9DJWZDzrAYmuY/mdTqV+Xdnrqgj73yhOzet9moqP9xwUxZU3nlVWKGlTiNJlQ/79BS1zC27+PnI4z3ygaVrLs4wHjEi/0WHdQwJZAqqesHD03rcIu7ZoCTEzuMhI0HSLVsATg8JBDLGKfCeaLe4G18MDftAyDctRZn30MxaXnZVeqwhME92nsW5B/tMSuvzEgOo796twOV63d/Ufgm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjHmCh7i6Cgd6Gv49NPv0qXRM3dK+6grNipLLqomDtw=;
 b=B/LPKfw9IWxOoGSn3REyNSsa3XURuHdakDA98pwE7ZZ94653o4RqcQ8t0n9wLdZa+smiSKPqX9V8FKQEgsSY3xTVijkWjdxwIApB0bF3cptWOvx2YHCGLQ10GEOFp6BmFiYoaHcx0kHpLyPh+Zkea79Xz/3/iYYSVu4yXRERHyI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:57 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Rob Herring <robh@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 10/13] dt-bindings: power: add defines for i.MX8MM power domains
Date:   Mon, 10 May 2021 12:00:42 +0800
Message-Id: <20210510040045.13225-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56523bc6-92ff-47c9-7775-08d91363e2b8
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40915A4872FD28FC7A95E3AAC9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9PRsXDnDWwXx6DxVjS1Uv+nwtpI8LHIYC+PQAC4z6FVgHaPvWTQ91qMjtgf3SoUu4VpuhPcQR9JxxYo5AkUp1UgVXmJilFbAz78qmZXZ3C0at5BZZ4LePJeUdNtvD3vV4pFx7wh0w9WPydxZlQRMVbvtQ2ptWq3VJoWt1PxVdBoYoUGCvTRqhPZb7uittaVBcRPpFpDIdIbrh0sjAXuVdiiY/5K9w1WftWsoPyjpdsUdamOKH9pXfGJoaxWxRTW7dovVfPqmI9uq5K8YuoxtDAnQSdCr7CyttT8ZAXhixmqfLu10+E8ix1NY33LP97ek3qJEfvSVjsQWXOPZLETZozewqFd72H2fE4HU4+25Qugo0qFN8TU75l6oiKSqFmnr1P6owSZNB0tX8TQfTzWaie2cd/KpkX5XTIXxUpLoeLAUJrOXuD65+HyiaEIgbsK2zr8X0Bg3tGR7RTaEvmYT1OFbmWI2V0dQNUAX3zfXiKwFThK7GddTgMXD1L3YogxE6gZhkCBZyRGjlWmaaZaWariaHhi9EcgU4995Q1yOezo9tyvcm5xQPsez0WS2dXJu38TLU+uyqBouweIbMUdUiuAX3a7hBXIjlEbYa62SevfltODaPOGP5ZM5nABYFGIRHPQsYy7K0Tt1ChYKf5Nltgi0I8BfIv6KEtyzBD/Su4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(54906003)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EjMK8CkV5yIQOluki+B34CMaSYYKbutk2Y6V/CC+90eGgjwa56MlrQsOToXN?=
 =?us-ascii?Q?ePcUkqW2eEX07yvXo4XaDVWQVpEn6hMICoHNE5DETnpz87JoUYkiMt9xJS4Q?=
 =?us-ascii?Q?fDOascN9f108ExknQSmem3pZ7r9S1G1K1HzsvwvS3BUxVuhwvxeRj8I1GvHB?=
 =?us-ascii?Q?f6w4mebvmzB3o1rKtXkmuT+x5VcwzSho0O5zjHT5JFQrl+xh/hP/T6rCNqUg?=
 =?us-ascii?Q?RpjSoHzcO9buWA/DSO7nNrMXBvqTzdu5Wn23026ezsT6U4PMumBTmkJj+Bk8?=
 =?us-ascii?Q?/eOUKkPsdBRFNVsIw0sFLdFpc5Y2E7Cmr96fLl7o1u9PFFZlCKGLx5pUn1ov?=
 =?us-ascii?Q?CvtabJRCgmw/y2PQDPlJElzbCwZpwZAnMm/RlFjQ31iNBztAO1hA1YbsfwwI?=
 =?us-ascii?Q?cVYYqjtS39KnKlKeENTzXrLjxXKSOfvLP6XROt6bUnDhA6tOCG1vdsxJoJzd?=
 =?us-ascii?Q?QferV3GrAmUW4jplY2NyMsFO7g5XvsEBeAkCEnaCKMUQFSsKu4ErE2e4mbWl?=
 =?us-ascii?Q?mrqqVY88Q/9JWsrU3nX0OlWoHKMMU/c/t7o/V+aE0RILyd9yJWh15/z3oLvL?=
 =?us-ascii?Q?iQv3/O0xQBcsN4vR39Bkfavm2on9y16/XBgOi6S1+zPYf2l2lMknWCE9vg/h?=
 =?us-ascii?Q?EFS5KSZT4i4ZzJMDGzmWvwRv1s/RtYViF31Qf4gY7T1R9F7YVKhWQubypX4j?=
 =?us-ascii?Q?fW3/mTqkEGoHnVtTMoOZwO1is2pmB6Ag0SW7fa0p9f3mIbRZ23EPHPrU8ogQ?=
 =?us-ascii?Q?Iyg8ywiy2jdkbmZlviRCLWTBtVTfIqdmP6BGwsu1yPS9yya7xj6Cgutplvv5?=
 =?us-ascii?Q?ftKVQAzyZCOTg5Y65nxt6uMFQv9GVLoSbGU61zVu+XFgMJlWrkOzuyD0jhMF?=
 =?us-ascii?Q?cfdiQINqCGtpoJ67gHBIbfrf09+WdsrT1bJpnoUwO+ws4FSL5q00C1IA5inj?=
 =?us-ascii?Q?wXxLvocUfhwRQZosRdIICSHw2kz8fhPOXlLbaIpMoSTkYdV/fceuYEY0DIrv?=
 =?us-ascii?Q?8pH2DWnLF/Y/WFMQR/4GPxPRPhuDgapQhKE3pNsRPHVCBtopvI92CDdY4Xtc?=
 =?us-ascii?Q?HjfJ8exdOwLFqHWjgNgVqhLh6iXKnxDoZTqdhoSqeKboGusU7IlZWUtuhYLD?=
 =?us-ascii?Q?61Xbktn+mXHELlwHOpMhp4xorluprPVBGxD4APDT1zt2wHio/RxdAiU2KrbA?=
 =?us-ascii?Q?0RO0itHHVC5kr97SAEzTwOymlSGTFLEXFvzyeUA74N/KaR+DteqHjwETTUdC?=
 =?us-ascii?Q?+q6YNIwpcK5vV0AoOSR1g6uJOQH9EP1Tj7Gmz5dTA+InJSqWhPWSe133AZYK?=
 =?us-ascii?Q?7aB95FlVoR3WMnnOwHXEklJ7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56523bc6-92ff-47c9-7775-08d91363e2b8
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:57.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdG9BHMw9EZs7sp3tZ9W+lRNy4STp2OTndJldjpfnyAtvyqXBDeGoU43qLJrdyzuV6y6P5P0NWOSdLDtDNCADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Adding defines for i.MX8MM GPC power domains.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/power/fsl,imx-gpcv2.yaml         |  2 ++
 include/dt-bindings/power/imx8mm-power.h      | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8mm-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index eb248f24dce6..87b6318bf2b9 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - fsl,imx7d-gpc
       - fsl,imx8mq-gpc
+      - fsl,imx8mm-gpc
 
   reg:
     maxItems: 1
@@ -54,6 +55,7 @@ properties:
               Power domain index. Valid values are defined in
               include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
               include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
+              include/dt-bindings/power/imx8mm-power.h for fsl,imx8mm-gpc
             maxItems: 1
 
           clocks:
diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
new file mode 100644
index 000000000000..fc9c2e16aadc
--- /dev/null
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2020 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ */
+
+#ifndef __DT_BINDINGS_IMX8MM_POWER_H__
+#define __DT_BINDINGS_IMX8MM_POWER_H__
+
+#define IMX8MM_POWER_DOMAIN_HSIOMIX	0
+#define IMX8MM_POWER_DOMAIN_PCIE	1
+#define IMX8MM_POWER_DOMAIN_OTG1	2
+#define IMX8MM_POWER_DOMAIN_OTG2	3
+#define IMX8MM_POWER_DOMAIN_GPUMIX	4
+#define IMX8MM_POWER_DOMAIN_GPU		5
+#define IMX8MM_POWER_DOMAIN_VPUMIX	6
+#define IMX8MM_POWER_DOMAIN_VPUG1	7
+#define IMX8MM_POWER_DOMAIN_VPUG2	8
+#define IMX8MM_POWER_DOMAIN_VPUH1	9
+#define IMX8MM_POWER_DOMAIN_DISPMIX	10
+#define IMX8MM_POWER_DOMAIN_MIPI	11
+
+#endif
-- 
2.30.0

