Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B42453EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhKQDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:33:15 -0500
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:20785
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232876AbhKQDbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:31:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA/wBOKcyHhxlraMQMxBWDerQpj1s9eBP3x364qxVHqNvBwse+h0gZrBV+/KVQEBxqHLCNdcdAj9XWQqrzIpe0cxOu+S8jgTQYt+buZTYhDRUf6/rHv8odumh0gZOPiddaAK0t0QVlS6PFdVVMByXKx33EvCA6/o7/JMYTxasVEJ/Q6lYOnJbEewen/A7FAJwUWE0vmniGiterCafZRdpQY+tMIlbRyVf5PJkdyx+VxDl6qyZGYl1laIKcstBAvqwtsTsEhbX4MQcfnnyaQqRmb93wwnEWu923YrL+S1gfGhMc47DC9uIwbGfEhP2SKW/62mgT+uClRR0Drr+Gextw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VrA4SmFq6Ve+9+jaBC1ik6Ju0REURKAQY9k+I2f9lE=;
 b=ZEMaNtZarsYQkcTTJOnLWmGkNqmKKLSk+2ceFd7wqJzJiN50mxe3ZKMH/QXrezHL9fd0stff4JK5TlzW9GIcSo9cSbEKxs4gGe0f28N0yx+ijLeRg5Dw6Vk1vH5nynFoExD9Zt4iEHBDwuwCMKDcDM7TNoC6JNtAvW71BQ12WFvesBYtS+DhkEmQm0+v0q63Acj1sUKM04cxu8O/mooGaAx3sAWOOhlMN8xEBbcmTujv90admKpFMW0hIWL2YJMWKLUjrVAqRpNtPYDXpRv+wFZANDv6KxpgaLWXGyTTTsUppxqEEl9VUn99u+T6qhx5zdWwuPO0IjpXQiU3LFGXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VrA4SmFq6Ve+9+jaBC1ik6Ju0REURKAQY9k+I2f9lE=;
 b=fHQvHIxuVOxp3WcTiDRmfS7IPj+ZOv7gTfgPRF6FGShaoR2yowTsreI+DHIVnL1Er08bMw+Xr6lE8uTsEKm2N2RcGa+XthU6nGNkdCcXDxgpkHViQortLHUAeuKFhtinYs/AxyfGGtaWJqACXpiSyxZ26NHPuW9mdHyPjRjvmM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8518.eurprd04.prod.outlook.com (2603:10a6:10:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 03:28:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Wed, 17 Nov 2021
 03:28:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] arm64: dts: imx8ulp: add scmi firmware node
Date:   Wed, 17 Nov 2021 11:27:39 +0800
Message-Id: <20211117032740.2518926-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 03:28:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb71de1b-6976-4549-9515-08d9a97a59fb
X-MS-TrafficTypeDiagnostic: DU2PR04MB8518:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8518556961FFC6228304DA57C99A9@DU2PR04MB8518.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCJCjeOHFYmoSe/CFjtN0BihzNssMbDMLulbKorr3GyXv9C0rFenX184Mn9R66UPxeT8eX64Y4BvjmEUtavxmbmxk4XINjUcojTMb1Q1nt4G95xVa+i4nq1KY/sH4UVcSa+7CcHBWv1qKN76sdbvzWNVuE/JQKnX8JJs5Plp4IvT8i+eTpg52BKxFEuiQ3+zoLLfgL41w0QoBDb1nkX5NSYMat0k6Cs2KSp22CE1U8pA5apABrRhtNBbO28DvxFF1WZWicL/aQCA7fATqjYk4bv1wk+L4irzKzPZamC7c8jujX4WeRfm4ibH/ZDzyWQeHMOY/G8hvghYmwF9GYVZd+Vf42pP12h7GK/JHvnhNryGzC2/hw1wj8iXD3adnACQpYYXZ0Kfbk85f9L5YeUOp4wuK6UE26AVeVnazyoARxCiZcPdDFGvbmm6pPH0v0SVMk4zKn283ee/68cyFdmUHwWq/cZctIUN1+/hRuiEZkjmy8TE53gNhikxjoAGX17xLmkrd7JGtiErZ6sEbwGXwlKUeDWZDF5YP2yWaPRl78YTgPp0e+hKo2gnn/jrmvxukfJhJb44GIm9fXkSUMcKtBimjEAubRKgIejlaWVE5/ecEWY6ykyb05nRp/E6o2NlqUm5vyrxx0gDlxtzYjL8r7rgkHUWskdygaOb+ovljKEf2i2iiTPzfmLI9BMTvEqueXeTII1/95oiO5/zC7DcF/BiOgdXskBMsmV5PBTtnDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66556008)(66946007)(6486002)(26005)(66476007)(38350700002)(508600001)(956004)(2906002)(316002)(38100700002)(6512007)(83380400001)(8676002)(1076003)(186003)(4326008)(52116002)(8936002)(86362001)(5660300002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fAONvZhBnziQnk20HXdtc3z6CFLez1dpH8pQz5+rY28md8eISSdNKIYa/sRF?=
 =?us-ascii?Q?H+JNfRlGWTbdzoqs7u1ZQTN5r+CeSVKWAWwJi2K3wpP4Lpwe78LciPodKUKq?=
 =?us-ascii?Q?ptvgotX6vZcKX27nVDDXJjaDAK8HfTtzVfVSjrst4xIBdahyX6ob7TX9tpX9?=
 =?us-ascii?Q?fxwtC+VxEBYiIQ2Njsc9hL/WbUkXYp67h7ar5jpFmypQxQzX5dwRsxDvqA76?=
 =?us-ascii?Q?K7f7NHuNkzcJLQOJIPisyRR0H0q/0Sion743tVKxyhI43aKIe8xPr99grHaU?=
 =?us-ascii?Q?AiKvd8vHunPCE1ycvxH4p9oXvUGSO+wXnf383X9KWgdd8hQFrT9OFJXYtcw0?=
 =?us-ascii?Q?nXB1Msg8V726i9yc2MDKNGTPyhfzT/krxeR4SJx6ssBjga+ImY3wJ60gZfw+?=
 =?us-ascii?Q?SnDF9huLl/2a70fKL9uF9VgIUzEteT3/EQUaxpsjyccN2uVjjz0164bpTnPO?=
 =?us-ascii?Q?g+FfU8V2X8+l+JMDtC3mD1rjr/5+vKTYXCDYPXQD1daSE7gzD1KxGltIBsHw?=
 =?us-ascii?Q?OJTt8zk8BrzeO4ikcOhsUE9gF08yQXDJVUr6qKRcSZR/zHgXUWvFkoPyfCkp?=
 =?us-ascii?Q?TriIRI9OqfA4SzAg03zdUzFjEDw7C6u5uFm6wbWqkcScfq+LV76UFAs9LTs/?=
 =?us-ascii?Q?ETkLDdYhx4sslCWSAqaQ3JB/3+HHbh73jAI47jNrL6zpKDmxvAE1AbUQblCJ?=
 =?us-ascii?Q?dfc+7OvzjMfHOsLJcE2zAsKSUAu3UP1FoL+CgjQpGjcofKoVclpUOYL3DCs6?=
 =?us-ascii?Q?rmIs/tBSK64kwVfNmtdnLZfeoYpoYZ9LPf6IzG4MkurbnwvZ89VZZmbn8voo?=
 =?us-ascii?Q?E0L1+TuKvwaMmkeWqYCZsM6alM/WJHuDbzPqIo8MWal1f2vBD3vplJ6FOofL?=
 =?us-ascii?Q?G/Uxi11nDd9QMWtS2SNwRYLlvWdzqyeicGUSdlGzW5k4aM6gY1sfDIiH8iv1?=
 =?us-ascii?Q?l024T0NeIRhOypvZ5HiSrPEV8v8aL9L4K5Fb8MbEXeUbFidx9MAWViMaK1zo?=
 =?us-ascii?Q?suPq9pY60cwwfzGMpcqzlUElz4FYelFveIub0/y3+zQR1U4IA7wNB1RWoYky?=
 =?us-ascii?Q?MIsg/mn2kc2JlljCGquzKu9dHhUYpthueZ3cXBJvKNL9CAboMe0kP7Hul/Mk?=
 =?us-ascii?Q?x/FB/zuqoyjdnZK9gxSzK0UPhSBOUfpdcEBn3wuyk7B4IM3lfrv78gY0ujJI?=
 =?us-ascii?Q?AAiOjBOh/w2dT/SzVygDthU4vbgIVIxdpH9NBzJ/r3HtupX3w2jxDmVKxeLp?=
 =?us-ascii?Q?F8ZI6Xh7dn7q/mMJiG0BJaagZIeA1G+wMnHrKQ90aR15iZNiyKIhKvvaOs3h?=
 =?us-ascii?Q?gMl2vJ8Cttef3tRlounMAg0gWh6bLI4FAGCGIYlmxhanhxKCWSXLs0DRV7lw?=
 =?us-ascii?Q?Jlm5bGKdSIy3PztSRdHwdELVbCWYVGRTy9GPLdJNAHfn417x2vbsYdDOni9c?=
 =?us-ascii?Q?+mqn08iOBgGbPUkWUTMXGquPVa8hB3i4L5SvjgDTINAdmiQOWAyH8pm2q18R?=
 =?us-ascii?Q?cyBE0fEdTqTpwqnJoFOJQh0gcr6gQuPguxc6rFVWYbWEv7KaSKFpZRLf57p+?=
 =?us-ascii?Q?hEDptKLk6QpJexeUdNkKENL5Oy5T/IBeVJByPfA13Q1myjWGpbRAgsczt8eQ?=
 =?us-ascii?Q?CJcQHQJ5Lh7F8f/GVu7SZYE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb71de1b-6976-4549-9515-08d9a97a59fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:28:41.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwfZIycRVaf5rwZQg7gMqUJngZWCXh1+rpMq/a1rgSipXs3M7+dhejSnoTnZm7F5nTisQVDZFUtrrEQMCg6p2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8518
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP use scmi firmware based power domain and sensor support.
So add the firmware node and the sram it uses.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index fb8714379026..d567ef93f8d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/imx8ulp-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/imx8ulp-power.h>
 
 #include "imx8ulp-pinfunc.h"
 
@@ -102,6 +103,40 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
+	sram@2201f000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x2201f000 0x0 0x1000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x2201f000 0x1000>;
+
+		scmi_buf: scmi_buf@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x400>;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi-smc";
+			arm,smc-id = <0xc20000fe>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			shmem = <&scmi_buf>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_sensor: protocol@15 {
+				reg = <0x15>;
+				#thermal-sensor-cells = <0>;
+			};
+		};
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.25.1

