Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8298374C6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhEFAed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:33 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:12455
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230291AbhEFAeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTzrwxLBs4DA4zt+K9kND2WD8634Yj2yKhWCun70WJwxLWdrtQjAWOP1i1X/haVPL5EaNL1fyuzsqAM2BvcSEz+EueCaDQJbOW40NwF1+acnLi6ESfVo00id7vTwqTayXN7QKLFV17Dik9oWTTCHAvXRnuBfL0COxwrFl8i0Sp/7IMU8TsX39sGKu5eRHVns//NxhpPdvxkjtXEffn3dSGs3e8Hw5cGutJb+fmsKSGWp0VQMyTafRaxYxdOX7lLkLCcXH6Tt0RhYETxHs3OZKC8ZONEWRW3Jd9Q0iI2BPFDraAWAEUbrnLTLicNJU4fDuV1aOw5L2cCOzA50e0bh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyP6g3OPDClmOeD3tHdWsdhbk0hjNCDKpZrmsGGZj88=;
 b=oAVdyTsx/ZNrBlhTKJEbE1q/GfoQwwivA9Bxh9ZobXew3tJojOHNU7i8g5v8U7+1yHWVRVEK9QIuXk0s8q5CrDN86SYJdYlmGCRuXXI3ml7WrOUTiBbL3vfixv8rUj2KIpcxk5dlXU4+BGE6Tbv/Vd9+arD44SuDonGF1UtRCFg9a2fjb3oNtYUoXmGppLGVrQnxOS0A7v8knhyOnHZ017otNq7eNbasOR4ltlVT61ERoHV6RNcKhQClyuBTmIUmkYQbj6uJdYM4ggs6OiJ27dUz5uXZ/xVraA72OEVni/IrvF0m/hryIcMafP5/Ndcko56r6QtQOYUpfHYzuYyYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyP6g3OPDClmOeD3tHdWsdhbk0hjNCDKpZrmsGGZj88=;
 b=Bv/sFq8iFbC93UnPXOeAtDI0tZmEpQu8GBM4ijScJ4tGJl1tR6UtJq3akdQlyE5ijSTjH4QNlg0CFJXVIOSo0mEcMGXLIFW/JgqbQUqUwAr3KaVWL3uexnlZXTrbjVgBcNx/gaDpaofe1CtOd7S+OhyU6HBEDCMuOxzcl4BxX5o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 00:33:25 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Rob Herring <robh@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 10/13] dt-bindings: power: add defines for i.MX8MM power domains
Date:   Thu,  6 May 2021 09:04:37 +0800
Message-Id: <20210506010440.7016-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506010440.7016-1-peng.fan@oss.nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:33:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f1e58be-a93a-4883-ae85-08d910268f79
X-MS-TrafficTypeDiagnostic: DBBPR04MB7884:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78849DF689B1EF6510E28F30C9589@DBBPR04MB7884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjl6X7ji3zTDieMCNiRm2PZZdmv+RPF075MshrL26arFCNJK8R/yKY9zdC6J+1O05i7zXL4CzAAaG8JS4HJZNqIzAfMEQLT62EwiUnphoewYvj1E6Yz/fo/UT9doKSMQFtuYlcfg+N1juh+KBHT1VjNAX2nFCVbZK5NDaYSMlj57Yb478NQvspxZ40ExFuNTkCnSDQDjnc79BtW1Rm6r+BWWyAQK1XfNwGzKFnhhkt1/dV/MotXd27X0+z1n0FR4YCYfx3KcgOVrBj/NrjIiofnQD3cLg5Lqj7HNgsL3M8vVILuyeXKKVMysSP8QKhADaqGP8gB1Mp8uCJee3IWfE7TTwbl0909fIPAX13APkA6UprjsMgv9qsoiSt+fZ1EMPJXPTS6Xoava29yuKAgc0r369Vj37tDCVhclCthwTJxQOg6xPXBKW6C1qJGWcX0K3gTPsLvMzZVfYb31411PqWWDRTQtHDLWI2/5EgmhZ1ihCkNxi0oxKeuCMuYcwMEnAcCyCwRU7Rf+yI2jxaVez+INfD/RIsCVnMa6AepBopJVrPIkm0v+RBeg0yPkuZYN5eOw+dkFCtGTuXEDnpLKFl6ImzPqSKf6QLMIbXqR0ntYAHgw9WukefUfqTu65DeSSmlvBbdmYh8vDPwKMfS7fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(52116002)(186003)(54906003)(6666004)(5660300002)(6512007)(478600001)(2906002)(1076003)(26005)(6506007)(16526019)(6486002)(83380400001)(956004)(8936002)(86362001)(8676002)(38350700002)(316002)(38100700002)(66946007)(66476007)(2616005)(66556008)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1n0qLdXBhYXJaKaTps9NWHfgeed1um7IcOT6OohzxDMNVF/ntoBwHAVzbU9x?=
 =?us-ascii?Q?CxxXcWqMW+E5Bj7QyJ/6d/UVDfoQra5xze90NrOhZozy7OQJCCgDRMBzFFqa?=
 =?us-ascii?Q?JIajPB0lGKfpZb/gOezOJjB8+g5/FAOJRKeKfK2+N9Abqg6FJBwEXmGDLpxt?=
 =?us-ascii?Q?/ZfZyFIDbjC6zH0T+SjIxnkQRy4JMZ2iNYqFhsTlqB5GwqMMRB3jlTRTUO/C?=
 =?us-ascii?Q?7bTcMxLoPYuyUjyXPlVVMLJK0QVWoWyW8/zjpoUcU7CaQl62iVv/ix7RNGyy?=
 =?us-ascii?Q?GdWLFQJcezXkyjmAs32y73uupIB6+xnKSTJci7DYjaple94PEhSVyp86gu46?=
 =?us-ascii?Q?R4lcFxXep02z6JitvVLkJQBUMMSSEJArmLrb98ZX4jmkRuMbi3vyjfRHJw/E?=
 =?us-ascii?Q?grev70C7TssiT+Kucuv2Gc1IbR+HsrLF0znhI05go3NYsxfIQ3syyWirCjnm?=
 =?us-ascii?Q?VeRES5KQxLvgmqBttAkmSMkS92ab4DOnu/eLOt2El6VjZZDOwxbyhpwiKc2u?=
 =?us-ascii?Q?I+blk6xBmRiW9KteSgPWRTRu8qz/2GU1H9abzIx+vZqGeUSvNNcGJiyUlsF0?=
 =?us-ascii?Q?/KgV49CcUAtW4Ju12oJQX8dpTjbLZjom98qTUdto7DyvAu5dSNwUfXCXd3n+?=
 =?us-ascii?Q?RUMlnStNlR/k0jvTBv7yFdwvdric78YtBgEU/o33c+opqunhfUeuHb7tbMVW?=
 =?us-ascii?Q?Ae6ZPGltpA6vtWTAwjTIGMY6a3I4VrbrtvdgPOv+w4zOkGnCyPqqU4aTCIMu?=
 =?us-ascii?Q?GoXPa01U8b7VyiexCq2KJcwDSNi13ceviSoasV6FzCsHWc/QrxK0IBrjyB8d?=
 =?us-ascii?Q?+qvpasaUWSFiYAg94ykMC1EnMzymtn7lCdqAbqhlPTvxbvr6qjiGtnEz2Rfa?=
 =?us-ascii?Q?lbJkw1zeUA6HeslAHLEYvA5n8sTijZKPefyxugoYoxKH7ZzIz2PFMJN1wire?=
 =?us-ascii?Q?mb1I8epBObOUdGDAt+0KKmgEjUqsOiaei3QKQ/irrV5QP1h88vS3CXGsfvIH?=
 =?us-ascii?Q?GsVmI8bqTLVHEsHIDMtm352BPjQxmD9DGlfGXqwdT5gP88fne9Apt8PukNJO?=
 =?us-ascii?Q?aqP90tGn65VejFpA5cMIi1oRlaSDgm/RnZOY1Sm05g9GKqQJBX6mauqEuwfB?=
 =?us-ascii?Q?mvHvz3R76dJ+wKDH9Xy7PcUs+KHf332VCeD/8maa3IcJVOnH/R/aSUq/vL/C?=
 =?us-ascii?Q?7P43V8Pm6p9AriC31LpQh2jQIck8nC5PEHghDGtzv6PAYRUFZGIt8N+ljG0S?=
 =?us-ascii?Q?ygl2bZ57/d0C8SqQw9tEH9FFz9rxRQ0Ud/zVNSOg2czp8n8w5ZVq5RCExwO1?=
 =?us-ascii?Q?M30AhaSW2SNJQQC/daJLhPH1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1e58be-a93a-4883-ae85-08d910268f79
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:25.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE/jafwHPmezqnJ4V3GqDTcUErJXxkqBSGhIx/us6GeR99RvUQ35VjKgxpb2SCBRQmtk0/lnE8Lgpavf8VlwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Adding defines for i.MX8MM GPC power domains.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
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

