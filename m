Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0FC415C74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbhIWLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:03:04 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:54915
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240536AbhIWLC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:02:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9kzXwpGJUJeDnE2PMWynqku6TtVMJy6G1bcE5JU5alxTb5O7e6ui3GFSwRsgYyPlhw4+hmxMH5HnPBnRvH0crG8QJmH1Cwtex71JprmeMKqKoD5ACbtE7LraW1runu8zIQ1BfycHA4OKaqxk9Ci5TJAHmP5HmheEHaKJrhv2Aw+khMe7hCNsnaCGK0xjqJNMxKhAWnVnzK7Iy8w9nHVgLUJ9fBkwGo7HptwXU864Ro5jhnXFhPxQVp5voDRfPIhv5/FESg0sDZe/26DetZXXFjKhFaCZlyCKrxWEVa6C0LZ7eaXQxrJwy4wR44wfSLdqOUVAfRrcLcnasyd/I5zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7rugxp62cxLYuesHZALvRDqvrqFiTffu2zTyMo0m6v8=;
 b=LHItd50MCbR98C7GSnjXX675FOfcWog6NY/HTd6io7DFDKXhUCL5u2CrC/MX3Aw8I/8U8/F7SV+OU2ZrI7sKgYskGuaLd1jshGsjdb36phjmAWtN5VP8nTWKhJZW8Aw/nB6M8y6Gqkej8XUZiN7nPlHHIe+LFlELIKHwGcTzfqgOfGc6XTco3x4i34Wqm5bGPHqvk8njZbo7GCqGEEqKFosNLD+SLZdcEQxSoHlMsJCI9pCtc255TwnD4eXe1CnuAhc6aW81RTtRKWJPAgyFPnZVzfpQixpElRVWXyWz2ioqVw5PLp3ipKcggzzDB3/b9+8YTpS49TZ8bHD1T1RbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rugxp62cxLYuesHZALvRDqvrqFiTffu2zTyMo0m6v8=;
 b=MUR71pc+RC/s5bQYz6CfkXQ1hQAEMHOldud4RnHdKzg5W/99TcL2Qkk6X/MnqBcT13uK1IJbC5CWUal4P+iV2oofZnYlChPG74Tzyy/PD53iSeaIfiGEUogKJDVxGkKZYQSYRjaFaJca01Wy5DtyesEgG71o77F0JLd9U9sjrFM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:01:24 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 11:01:24 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 6/6] arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC
Date:   Thu, 23 Sep 2021 19:01:09 +0800
Message-Id: <20210923110109.29785-7-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:01:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ed79e9-d1cc-4835-36a8-08d97e817b7c
X-MS-TrafficTypeDiagnostic: DBBPR04MB7836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78365A8A7D00AB812AA7308FE6A39@DBBPR04MB7836.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8U+rULorzHNTLPdChxe6bnvCLlAmYf/RrrokpkbQ0OL3XBJkiptXbkNkJzud8MHGD89rZsM2Jk9p07D9hBw7QO+4OPOpBwTy2fZVdyMO3Em4g8KjtPMMl7e0fw7xXB41nI95jn+GYQdmgKBqsYR5R+u6Lxu/sCXSySbiid419a1iiowASLLrAKq/vSgPQ1l70tSNIfsp4OWyURWreziYEVGdvpvgpKE1Fg9cmqL6takAYzdjeq1m11RBmpvX2pvOva3EVaVo/XNQquDdZ3HKITsqE+C9rRFPnO+B5lU8Lej4Sw4NNjXgVC2labEs6F3PxWCHQbDm2Xf/Bhw6lXf6iICYgTB92c6B1tAMKcWErKFed8BvIsIJVgUadzMg2qhGt9Q8YP866AjA7O7oO20fkvEOWhRiJ71QzecEw3r7yeYY+itgFJzyCs8y/ZQpYSzzLIX4IZELgT5Cfz6myCuMOgNWwOZaiSYzjIMBe7fBPZ/lRqItvftQHkLUxEvvgFn8SE5K1Rm+FcCdb8mqcmzWOiW5vmuDKNTnbIK3y8wsyaYpGCogcTgF+4rXFEc/WbQiSJWNZhv5viePoKSCmIlV79LI6orGgi+mhqxeq4IkvBCCcY9io/whZkNky8RH2aEuMVb4EhSRPxUCPkwoB1QD0oG6jEC0cpLyEr1zLhtBVO/e5ZLl6xgEjDPtWIJEqJ/Fk/qCYjnLD4S0bepVw3vrjy8ufnD5bQIjd/cmYBvRS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(36756003)(8936002)(86362001)(186003)(66946007)(2906002)(6512007)(38100700002)(38350700002)(26005)(8676002)(66476007)(6666004)(6506007)(5660300002)(66556008)(508600001)(2616005)(316002)(83380400001)(956004)(4326008)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pf33PeU9K7OIKw+HzqOjQ8KXEJFDmQ3NATmrKxkiaOU179sxFz8ENCtt6nsb?=
 =?us-ascii?Q?ay4aiVE5X4tZDZNDHvxmNBmgV6abrLYzykRLCPSSeMsd1f/hP9nM+kFe93Sf?=
 =?us-ascii?Q?0ZVBeFOvuaFbRx8sB+BDNtJnHmO5kWhFhgH9rzoC24/CN5RKbHlq3jZuzwuM?=
 =?us-ascii?Q?9J2/VSECVf6MHww2pa1dKTUQXyNMLz/bAbgV+7E877XljEyF3ldjDgXQsa7K?=
 =?us-ascii?Q?Vh9hWViSdQxmfDu87AyvnzEsHUTCXSsPSLmbSKv8ana+8DcBADvGgaID8tuV?=
 =?us-ascii?Q?+PqcjTBvf9YV5OKSrE7MVcRoD/zUl5SxbRIeR0hdhRaeVG83XLhMpLFNL//w?=
 =?us-ascii?Q?sNOBgrowaPEll7oMbHcuQRCV8i83xrHEIGZG/L2tLBNDvnG8X8jNa4C1wHgt?=
 =?us-ascii?Q?LrEqAm+bIwNOxz66Tlm+Wm9BxJk0V3diSXKHDGU+XqytRWe7P/kQ0segkAW2?=
 =?us-ascii?Q?kgbEds3cFqoau8QFlNdiHY7VsBT5lIHh41pwajaKbwhP8vx4PZ2VQSAMy/CH?=
 =?us-ascii?Q?gkCdxYAKE8VJSwwlpOJcuNSC1mNUzKv0DZW/6Adlwssi2XVV/GdGKf0AdW4Z?=
 =?us-ascii?Q?2dUaUzEhUjeXJC9BeG6zXwa0n+JljlYYIz3LxKnGiFAzryKw8KNAStg38z8n?=
 =?us-ascii?Q?iztjyR4pAtRhFola0I2TW+YX66lLcPm5Mgn6qxobD39FRCxl25PkFjkxP5df?=
 =?us-ascii?Q?/HxrwcwLdOmJF/zRf92EOlkVGLpX4uKOqbhuBZwPiLGQlOe8duXxG+FTfmjM?=
 =?us-ascii?Q?N52eNgZ12mmEglJWqXYcKQ88jyPna8mFvrnzokt0Q/Xzz1Y0CB2HzVGSXiZX?=
 =?us-ascii?Q?BKa7MBoMWacRJCf9Kp/Lxz0oW0UwoiN9AGLbUGnFdza+IImIyF5o+NaoBZGO?=
 =?us-ascii?Q?tFyY+dOmeMlYDi7hPljhIyumFMGc1ZU2IyUx/75VWF88HM+cj1VOil2r58tl?=
 =?us-ascii?Q?Gb/Y6TG6WFG1iajMmBkoCE9sYfnL6LAbsUSJWYZ7ZR/hse9kBdlTfUIWSju/?=
 =?us-ascii?Q?U3mJqp6ElNtA+0Qfx4mzrAneaLJo89lzNiAO6LBWh2AfHo4xXv0q1mRb0E8X?=
 =?us-ascii?Q?VDOBxCyPv2tB5GLKEP+lJjB9Q2Erb33cadbWSC2t4Qxl9vuv2VWaBa+YlWZj?=
 =?us-ascii?Q?mWLei2urV9CwTfAP6xjskqy7n2Mhv50j4/LUz0I3Uy+01vlL8UJK+oJ/DhfB?=
 =?us-ascii?Q?qutoUNU5rj+Rt+BAYFZib6tXftThrNXx6n0m5JJTkBfyxUPoEILxSA8jqJxb?=
 =?us-ascii?Q?gQxv7i0hTFodpGCWKI6BupXJqNHzs2wVikXwb6cQDKC8gWOe5NlqhzlLPzCA?=
 =?us-ascii?Q?M+nIB9Y70QdBGigKV+RWHQX1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ed79e9-d1cc-4835-36a8-08d97e817b7c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:01:23.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olpAdHNbNFjqlqzurOUv+RtT4fQMK7K24x+JzwaQkaR3xuohRIoORUpLriGBeBUtukZCZipUaljjbr3Sn6StEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused "nvmem_macaddr_swap" property for FEC, there is no info in both
dt-binding and driver, so it's safe to remove it.

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index fb14be932386..2210cfda4e60 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -948,7 +948,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 0a994e6edc0b..408024426315 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -951,7 +951,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 37188ff07f21..cb7867791d05 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -821,7 +821,6 @@
 				nvmem-cells = <&eth_mac1>;
 				nvmem-cell-names = "mac-address";
 				fsl,stop-mode = <&gpr 0x10 3>;
-				nvmem_macaddr_swap;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 1cb211e470ae..dc4e39ef9d39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1191,7 +1191,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&iomuxc_gpr 0x10 3>;
 				status = "disabled";
 			};
-- 
2.17.1

