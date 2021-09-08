Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3A40377E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351362AbhIHKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:05:15 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:14657
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348742AbhIHKEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:04:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYP1teBm+m1j8LMvPsVTwUTdjQNyB6gtu3vIwhSvh7FdtsLuZPaCR4ChvV1F5yZh97pTZmmNdye25tJ+i+gdQs2HXX1nxszO4Umzv2TULyHhw209aDsE37fNOndgiZFIW73AxauNMwl9AEd6TnoUSuimW40dFcFDyPwLy0pWU9PpcIkFyM+62moEu1s1kL3t0KDr7eNDZcSFqWeNZPfV6RZiki2xGpMHo522M1WRTqZ71MTDuTakqS5L6j8BHK/E9rzx9SjhUaMAze9CYg8MBXtfJfQsvFCXrq+c6Pqb9A2Uuc/xB3vmdfg/3WnPJyn7ofdyEyHzTSQo3rjLdKrYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=juLkD8D17EkE5aTqndTUEZM1AQBvMSX7Bb8Bx6rJorw=;
 b=FVeDgfQ0lKzYpmMWlyM1BJaplxiFcmavnW4TltFgUxvfrOYBl7q/fRR2fnH3LRyqmwnoVO6BsobkrmxJ4Dxywnz88uOwSgAszAZ+bxZRxiFujXUt1WOItIXqJNLXVehaNCDY/TiPz5lgFsFoxhDd14C7loSM3R/gUe4L3eoOnYEWR+45ifvMXh9a8jTtAmnCaROpPoEQ6JC3wzQVxcZVylZYNMmvsvHOb9LXo1xX/zRBlA3dxtmgWjQokRcKQTe+KAihTgpDAQFo8/b0RjDMi2Es4a8dbSzRKZhAlNLJgA4mqW2oUQ/w21BtxI+qxdtAB3Lo5hqtMEwNVyV1InjEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juLkD8D17EkE5aTqndTUEZM1AQBvMSX7Bb8Bx6rJorw=;
 b=L4VZm5WuFhsl3xMFuf3FHhor7Gv22Gp7SRlFf+AvCG5AOExtk8B/B44F5VtpFkfcq2J/vWPRHs2oPMK9yG0WzKhghKMNfdj7wbOynMqG5bj4axBQHrIn5dOAt6jOQsMU26x7fvk15EXWWEfmLtrjOv0uEqL/UbreUiEO8O+PeS4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5786.eurprd04.prod.outlook.com (2603:10a6:10:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 10:03:20 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 10:03:20 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: imx8mm: add "cell-type" property for mac-address
Date:   Wed,  8 Sep 2021 18:02:56 +0800
Message-Id: <20210908100257.17833-6-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:03:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caba9514-d124-4051-9cfe-08d972afe305
X-MS-TrafficTypeDiagnostic: DB8PR04MB5786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5786BDD6C5E78EB1E91422E0E6D49@DB8PR04MB5786.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVLNkNljb62mWDv5kz0fPYilF9BvQC/y0eEsnuZ7ZpkJ70Fo+fUyxoPAs6ujD1lED8mWPOq3rngtzczBfSF6LfeWRLW9pKxu/sIUSnG+s/2YNybNSty4/56J7n+OwGkD6/5SOZe7Yl03mt3IHQDgbdWjEJFDHTPekvmXEL37xG7vVCpzGa9yp60mME/fk0zcb3yg4YTPoApkYUTQGsx0WtXshxih0K9jyJT51NSWB2EpwgIfOUpSVnCzEZpl606DMcZm/pJrDPTaqoujieRTqLqZkYRay0XZURLi/shuUHU+s5JhgEHUcYOBrZFs82V637oiYTmRulwQPrTi9u1FSMNGWPD+frto4GaiL2V1UOZB10hL31ATnMnB1GgM2sAEIkEto3f4T0oqZYBMieyvLYPZ2OGxzH/e/mVuksDD59D/RVFJ8PITsVcoSraXVteMml2Fb0ucfmpPS37cmtQg5qFg/JhFvs1xNA6XB1jzh6xhH60kqxThUnGOjMyK2fAzdN9KAdFbDPUTQEar/R4aRNGm+hnOmPIHSFVIH0LTUmwi0jG0Q8VLFvHWmLD1f7WiUIj0sDuUXbGK+ZQgH4fdu5pKdLOpuxdG0gZEdbvynsPj0bBGTUlSXZgyrNSRW+V3i25f/nAtTDdEI+J/xQV+erprj2jD7ngIZUjI9Ihbkk7iZI785VamicHeMGKDgbLq0OHUszpX2XngWhxLB3fv/hy7RVRSxiwrdZGkpDAHLAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(86362001)(8936002)(66556008)(6486002)(8676002)(38100700002)(2616005)(66476007)(956004)(478600001)(38350700002)(66946007)(6506007)(316002)(36756003)(52116002)(26005)(5660300002)(83380400001)(1076003)(6512007)(4326008)(6666004)(2906002)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cd2OdqUzHJd1cHgv1TGIvEpXAS40be/2rAObiy/hdE2POjLcE3xTtnRRDSbh?=
 =?us-ascii?Q?HEwWOpJuUyy/IhpqZy1r8TYHkb0H6mv671biItiIyNzetRrwAi0ycM/hkO85?=
 =?us-ascii?Q?RearrSG0JsSrMq+fDxAR184RobrZYnOlaxav5wjFwWi+NAqCwen75IRZ5PeP?=
 =?us-ascii?Q?AckQctcLHb8422fh66kpXGK7YNpjBVJStqFJyRtXL1JOtZp6hGjS2pr0miA5?=
 =?us-ascii?Q?2y2s8Fiy6DDkHwcznQiaX6gplCefyKmeSl8SG3gvQlzP8TRoJwgR3eWFjbg9?=
 =?us-ascii?Q?97Dp8iZ/Nax84vdCbfgEkUXQk52DCeJ7awCJSW1TYutvfBg8F2W+4sxDIK7m?=
 =?us-ascii?Q?I1GLs3F8ATMgN01OUuvZi10P8Fx4ZFzqWnLtXmFV+vfIXFAe5JfNNkqhWHdv?=
 =?us-ascii?Q?REjamnD0+KIa9yPjC/4QuwhBb0ruR53agKMh5lpeuH4XJEc8HqtN/PVsngWj?=
 =?us-ascii?Q?Qm4hCFioWg8ln945wPWr/czvO4crQy7MiAsLVMfAt3alIdrZD/zH2culM7zy?=
 =?us-ascii?Q?u9f3xFZ+PJr2x/Qqu8ssABMYEHtkU+Vu7q7RjHLPJormx/upqDY1+8DfZa0f?=
 =?us-ascii?Q?zkL4OLyzRBukzAKbIlQwjijP+/Yc6MBH0EF5inWsXQxu+z6xDXJB5jCkfvex?=
 =?us-ascii?Q?XJr7r2az5M6WawPt2zUt3h4hpBTSJW5kDF0YUCof22J+hO3Xh/oKxPEz1RdV?=
 =?us-ascii?Q?TN0K3sx2zFfj/mtKXIH0soO+kC0WNe2LVtAe9jJaif/8qDxSDaLzfWpRr/1F?=
 =?us-ascii?Q?OE5M24ErDObW3IFZasa3RNI6nd0EDe+y9SUIJboe2YoIKY8dK9ZRTuCjGEaA?=
 =?us-ascii?Q?K0ZB9UmCFsUoupKefm+pEhSN4DEndLnJZIbDecq37bcgvH4vLbzV3JBn0MQ4?=
 =?us-ascii?Q?j+I3WZEwYYfyZO/UCR+HnuSZ5gaJdF2qGdtFeZwIoxbo7QcmhgN4t+1q91uB?=
 =?us-ascii?Q?pMGulKaLTG8taj8bDoIrltYhCUb55vIm8gGqKhZLiXsYZbrXlGbd3LVuJEFM?=
 =?us-ascii?Q?papCuMjprKjs+wZvg3otiA+Lsc9sXEsURYYqXZDqQjfMXP6swxA4eltkRlOe?=
 =?us-ascii?Q?Zx8dQdCrjICP4Iw50hkFOYQDavX7Zx6s6Z9aVLwtWqBdiqLOUjrFgOtL0Oi9?=
 =?us-ascii?Q?1lPqE4KOSwz2rMZ0ytlYp3LokjGGsX2qN0JQjj2XhX086oaDYPmwBJx6i/+W?=
 =?us-ascii?Q?Ut89Lp3ftYQAXqITkM9IJ7wDXuAbMJrj/ED1NNKMZ4anEVjF/D+JV1JKYQmp?=
 =?us-ascii?Q?Okny2pTcG8SkB4v4e2EtqJFWVKA6P4Q0n5OAV57V2QnZiiepxvxbldiglQj4?=
 =?us-ascii?Q?l5ptMbjtm+m4Z7AZIwXo/GMY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caba9514-d124-4051-9cfe-08d972afe305
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:03:20.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVuKB8pwWNqaupFvTJsUnmwUl0zOYKiCXGvQtXU1fIdhoGB/AlRf+Gu/lG9VktXxDk9fbiiCt9uB72b3hYDpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5786
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "cell-type" property for mac-address nvmem cell to supporting mac
address reverse byte.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index e7648c3b8390..fb14be932386 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mm-pinfunc.h"
@@ -539,6 +540,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index d4231e061403..0a994e6edc0b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mn-pinfunc.h"
@@ -544,6 +545,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9f7c7f587d38..37188ff07f21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mp-pinfunc.h"
@@ -358,6 +359,12 @@
 
 				eth_mac1: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
+				};
+
+				eth_mac2: mac-address@96 {
+					reg = <0x96 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
@@ -836,6 +843,8 @@
 							 <&clk IMX8MP_SYS_PLL2_100M>,
 							 <&clk IMX8MP_SYS_PLL2_125M>;
 				assigned-clock-rates = <0>, <100000000>, <125000000>;
+				nvmem-cells = <&eth_mac2>;
+				nvmem-cell-names = "mac-address";
 				intf_mode = <&gpr 0x4>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 91df9c5350ae..1cb211e470ae 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/interconnect/imx8mq.h>
 #include "imx8mq-pinfunc.h"
@@ -570,6 +571,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
-- 
2.17.1

