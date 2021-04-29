Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993BB36E557
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhD2HBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:01:22 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:60161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239310AbhD2HA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9MUwi8GezCFMDtNXk8hQ8T477jioKnMclLC4YqMiy66OdJ5d3YdKL3N3Lsiu2qLqczJoSpHKAB7k6laPSRaP/WR2BvNMSNmP3wlwkOeNiBQTcCkBt4j17APOkagpS5YjltFKqhKNEQ8mT/kYRdQin+UgQOSS3A51XFbLe50nIQCnJllo/2YWsp1QVpf0EHpNhUZd/KQG4Yk6W8jeFagz0MTYwqx+SO9T9jNiKsWOQweg0Rji3Xlp8glj6kEQGHapGArL6kyo3UNbIMD0lTRCxpxDX91+IkaegImuPf5u7ruJQT3+ODprD1iY/XZTWke3/YNQ+5bo5kR9g0zyZDIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPyLPXB4J/0iwbPB7EI8D9Gb070Bi8quD3SL8DPcIdA=;
 b=lXOAYuFNYTcNbEibageCxy3JIrq8ogglM+RFYeqKIOi0M2I+KjYekihNJDjhUdmDs5kvAdOmuid5MJKjIr4MnYs3Lw5yl6p/6CQPNLLLQ/fXdVE5EqbR++qUW+MpBpfcM92NbNyhUCDj9j8dMY/F4lp94noYeHIV0Lm3HiBjsKalHzR4UZh7IiFpvJaC9WJ+MsnuY/ewQAw3k7oq+kY2ErOYzegYr/vliHLF0CApW8UG17+h/kzZLSC840xD+U/CJkY8RHfBPddZYFOmEbZ3wvd1+bXR2p8znJFH2AtDsohg82Ufh2uq7/N4sbmYeDyi9yrmVMwcyVuyre063zmytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPyLPXB4J/0iwbPB7EI8D9Gb070Bi8quD3SL8DPcIdA=;
 b=WgBl+y7y8P6L18RwPxVzcdcaliXGvMjQ5wlzBKLmU7KZ0c1TQbdb5sRB+BEkqgAcwKrUHWHugumHVqgK4ZmhL/j0mvPe80RWmuW9mQkGXiQVFuBFxS7C2tDopntnTxqLodyg6OO8+EHcRPhXWD/vXdF/3TCKtAszfDHUSKNxvyQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 07:00:02 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:00:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 10/16] dt-bindings: power: add defines for i.MX8MM power domains
Date:   Thu, 29 Apr 2021 15:30:44 +0800
Message-Id: <20210429073050.21039-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35fb29b5-5462-4474-2afa-08d90adc6902
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB546804D51733D749A29284DDC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1+SUJUKbUnpA+GDS1rJV2wIiqKwrhjEHSo2xeUm8DyqpVqqjgEW3DePjNGgRi1025nq8d2Syw0u0JBd4IJjHLFGPalyT3PuO/mBZ5kck7fZEp12Rhmkqj+Y/iQ/HbdksrQ0sQog9wfYhAPupVyQFlPwZR+JQNG2plcr5nA2aJJzRZkuBLXxbpPbRV2H4rh1Bo9rcWhIP1dja2TynuOhtesFgm/mBwRJhTV2+4bpUY9/sXjt3gxXKWgXm9pV+yKGq2DadfMRI/OQtiSbxnk51MZ2iih1PRaCugAmGxuDYrMPo8bFnVNcYcMnHQ8IDYicicCCuZ7g2eGkKBTdPItIVnil1hIaZ89asEYsujYXPC3J81Efarqv/2g5GIqDuuVC5Tlt8Rbi5ECulmGHata3z1Zxx9Bd5fvQlQjf02CBpqQ0H93aGleh9sOnJ2HskmeJATnIvEr9c60lTuoqGeaE3kEHtHoPVadiDUKTwQbW2mLonCUK2rfG7ClwsCCoG4Of0XQ60qhR1o2sovfjFsu0lRR7fLvMWjnPQRnT/mrTASIffiYddvF7m1WiuYvh4hUhpxbI8XWN5qRrTqwvEeDTgkJzgIMBeawEwIOn6DTRnMfbawSdTeibld+OzRgoB+fbllbWTJMEmpKOXDMSD4+IBAFVI9EhU2RDuR9sB55+Q1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZjEvEvWZcDmDCYGp1qHKpysp4Cd+RZp5wK+kQV7F1nGn2xKabLNCCAZIfXZq?=
 =?us-ascii?Q?X2r1draB0DVC7GaZ/nnpc9A3kINKn0RVIN62Gj3HLDExABE209uvX0D4QWWH?=
 =?us-ascii?Q?ljxeg+6B+IyApUb9H3B4hqw/yo6zbHMpd+t737Owt6hK+S/YtQ9U+jft1viE?=
 =?us-ascii?Q?6zIxNuHm4qEnlltko3S9G9uHHhBUTT+dUvUBPs/uaKoJ5l4mZZx8+Xq13YM6?=
 =?us-ascii?Q?cp2fdfkKHsWVArjRh5Tuxs6kZbgAEuVriRpoXfxKaRQsENz2Z2ht2SQRs4xC?=
 =?us-ascii?Q?w3B8f/mM1C5x0o9gAhsp1Nl9EWVcaycYPoBqr4kElGKNgFZ0/S2JazAyaESq?=
 =?us-ascii?Q?3Dns0lvnxWfz/YRnDyWeK0I8oT03Ho6ZIHc40+XNGACXVsLqoIIsCbLrT4NG?=
 =?us-ascii?Q?8nCvglP+oC+Yk+spOCG4eq8vsKhlBd+bRPkX8YBOTnDKMfjKhrrAprHYmZ4i?=
 =?us-ascii?Q?cdxvfdTZ/vYfDnf36kAm2RbaN/5DRVOQ39N5LIHuK8zC6fOaJNaxIqV+LXyO?=
 =?us-ascii?Q?kxAxxHM4zFVtypBjv9SF34XKPyTWpqKupTvB3L0xHsolWxQ4trZL3bTw20ut?=
 =?us-ascii?Q?Z3b5NIWRq2SUulDmvia+vZYdh344U/mQNCj+cQ0GIcNORpgpfyq1htBcceJZ?=
 =?us-ascii?Q?JuDHEZtEDkvgA3rW4+Et5Q+y7wIlJUU/yj81ejb06WPZm97YDId45+/MBCrP?=
 =?us-ascii?Q?7GQ9lis1HmoZWjPMFxMKMvRKvIXFTFl9oTaUmXN1R50sq9v6T9mUxYdZdMOO?=
 =?us-ascii?Q?zzJKRGcpjsK3eebfr4uLZ+p6hObYhALeNobthojT1vZlN9FV2reGZxJ7bju0?=
 =?us-ascii?Q?N5B4m/wIwpNHqnw6HTwE3YHDzGvdpUNMjAxUtEc6kv3CMeli0bFy6AIsKq5w?=
 =?us-ascii?Q?9aKI5AFqV9q4y6MVSmmaseFaIddlmetAXw2TxGhfDZk/GPpb5Pt9xljpizYZ?=
 =?us-ascii?Q?VACzHiq6n+KuGoiebegpqmMCFJX5TW6DFsZMgz/XH9BFKBWbq9vlzO3uiTZW?=
 =?us-ascii?Q?4B4bIhTWNg8rcy4mCczimkbnNupQ+8fvPBfIX+lQOBYr+JGnFMmSJgPqfjEb?=
 =?us-ascii?Q?kRZdiZ0v0Q2zZH3BJo3Bw4aj8/alnyAWSGZvxk+8/REgtc9VpzGgnf4Remnz?=
 =?us-ascii?Q?CkXCAfsb8NMR2+askiUQ2mTvQzC0F1bcZozFtWhDPvdf50GZYF+HcEC6GOVn?=
 =?us-ascii?Q?dwxj0K/gxSZVuv8fPLQg23cw08O/k4Pvwz+oinpHURHq7Zmyad7wKkp5W3Dm?=
 =?us-ascii?Q?658lN73fSUIIcUWle49BdxrCv/0KSJMhWR+ayr9IpK8do7yp01nTDer7pnd7?=
 =?us-ascii?Q?HxZYrkm850mgf9xCgmycx+qxQKZ1try5SrM3wQdPt8xLsQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fb29b5-5462-4474-2afa-08d90adc6902
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:00:02.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLCNnjNVT/f4nb4x1KouMziQbTsbCb8+s986BKA7MJ0NkPxu+p7OeHQtb0QG7I71BbLL8wRIUoiKOEU5h/PX6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Adding defines for i.MX8MM GPC power domains.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../bindings/power/fsl,imx-gpcv2.yaml         |  2 ++
 include/dt-bindings/power/imx8mm-power.h      | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8mm-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index 4330c73a2c30..d3539569d45f 100644
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

