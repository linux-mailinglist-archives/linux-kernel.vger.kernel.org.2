Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C643459D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhKWIIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:32 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:29302
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234660AbhKWII1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obQ4qzoj2R7FrWieNzPYnTeeO9k0xdic8WNsrS2PkvZHk8M92y8sG7gIivutoL9RSoKMBaNRGkdWeMLxEKccl5hWn++dao3VXG/yK4jyBKe1+gmBUBHzYXJG5GiTTLSfvICcyxwbX4+pTPqRgteNPQVkMmcc6EQfiD3gGWnbTUhkev7or+gFAIFxHxLW4EatyZd2uSM4EL+vhr+TdjbuAwTW6Sv582B/GRl/FpPCTL6MUMZdcSRH21uPKCCHJWlR6EXG5VktYQVpyXa3KfNuV4S3nAPM/8PrbW+L5WLBknYBpvaY2tGIF1XUmQqD2UyBqZ5dc6Oi2+IIFX8I5ki9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pd9lMgwUFavPCO0uOdhSFn0pmfo3xO1H9DMZ5AoPv8=;
 b=Ob363vptQkx9tHBhEirkrHRCtAPflqkp6ClGDzSZH2N2G/lHnSwQHU26oR2ADZ0sInG+foVwII1NO5u+48AbY3eW+uy7svQDyaMIWgZJPdUxYJNlr4UXBtyXpzjwHnu6Wd7pDctgRkfLkDOamVXh3B4luFc5G92jAWnJXTJS5WN2FMuipH5stEk52S5xEsEQa4bpKi9Nngnc0zzu1Vyn5csQpR80B8W6Fp4VSZGvvLN82Vl66Bb+Mq9ncoEdawImTgIG5KJLRGiC6IRCXJ1HBsoU1nkBReF4QW4XJCEQJPwVVqpUQdbe2VhdIPSg54lMBfjnQEuehT3Fq71Krs9Beg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pd9lMgwUFavPCO0uOdhSFn0pmfo3xO1H9DMZ5AoPv8=;
 b=kjJBId4VF3v9+GithMn6sJH3Q+hJ1BAe5kaHD8fffYezIKXVoGKDs9ddl7pMdtze/N5Nnth1X55iR5ut1BxtEW56gFViMnebep0Yce62MzP5T6OA57U8sIj46N+nopnZr3VNPaC8tM2BtskncA/JxmeekqL91v0L5eg4LpYRkso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 08:05:17 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:17 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO voltage
Date:   Tue, 23 Nov 2021 16:05:03 +0800
Message-Id: <20211123080506.21424-5-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc459688-300c-4218-2b4c-08d9ae57fc9b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6971:
X-Microsoft-Antispam-PRVS: <DB8PR04MB697183A45C3BE79BE60D708CE6609@DB8PR04MB6971.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6i8FTrjJeowd2qw8cq/pgfjDitgfJIXBPjJW+p3nMv0kzs9vbamyWhhEW6xdr/P06cdAAvEprf1lqsKJAmL5tojv7E1RrbmulmTSuoBjByvVa7yUrSc+lKPjzxSXLZiu9tqvWtq2uZb/jPHfYQ0WoSwJd9PKAo+Ydgn23sCPor1JzxfLngQtweyMXJ0e3Th0NiaqwxowTD8zWa/fEUJaQxp7Z0rMf8+PruGh/0FVblSDuTkOxEkB2l4z8wlNxNiYj0QNAdta9IhQ4TuO+8/F1lzQHS3PBvA1GDEYj0ZMWugpPIjau3YVh+uTD35Vo2CNGx+88sGIxOVvFQTb/H8eOCXPM96gHj9WzPbZBfStEfM+nK2eirZcyfWxk/oO/fGGRIpaKGF1XhkyeaUSGdZcBPcVrkqpSCGWy5YML7TT3n+E4vlhV5fqCxY3kJO/8FAwxQqvpHIsXQZKEYM9mdsegt144+fZRJR4a/Ts8aXFXMvaN4+OQ7ifnwKMOnHmQWkMTlPoKdfr8derLzM0ZQWOh3IE/ftuas98mk5ICggAvgN+QEv/EZ/P4dxacPCQm9jzUOfA3h+s/9BrHjlUxsOinoZl9dqLVXd+oC133+YbEEJy9WpD20UgcDLRmmiGNrh9jQd5ZTbNsbUdO0qRCx/IGgkVk1EMJGw8ToxdxsrypxfBaTB2LPw/14HucCd9pHBoPjJC0CjyNZWBcBC0/8S8iZq8s6LzN2eImKwEi7Z+T4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(508600001)(2906002)(316002)(1076003)(66476007)(6666004)(36756003)(66556008)(6512007)(956004)(2616005)(6486002)(66946007)(38100700002)(186003)(26005)(86362001)(38350700002)(6506007)(4326008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gdoEIdDGUUYfZQdf/IU87TkzgvVP/GozwbxYP8S3lJkuqBMTw1EiGQd5jbU?=
 =?us-ascii?Q?UfbDoowxTxQQATbn394FX2tX8Ac1prcPWG6dEf8uWEoI1WEWP/LpSvTAc5md?=
 =?us-ascii?Q?7qwrYJvXiyGzl3Payv+ZR6lc61MJvD2N+WLV3SHdv5XORfYfHnHLyhp5gOQb?=
 =?us-ascii?Q?RoSSXGJef1Twe1Hs2dPjz6Y4m7NrbDbUIfUxbIEOLLjT7n9I7k5f6f+HbCdS?=
 =?us-ascii?Q?6airOAIgMp3nqjUO9y98+Q76gSBaCjLVQIXNG7+vaPPDIieIPz1kSLy2rOuK?=
 =?us-ascii?Q?T5DEabRLjPuFtgMR939t/CqeYC/pYgTX9ctF1JEFBY9/NPZoHrYZrasilfUL?=
 =?us-ascii?Q?j/poIVba0t9ns0S6YiIGDHGdzz50DeHnJ/N4bx1hUslVjUxOiwGkjVjWpeXB?=
 =?us-ascii?Q?mghDKzmIE8l2jGWFSV7r6RmoN6GDyMEKQoYS+hcTLV6w2aiVy5alAy4OnI94?=
 =?us-ascii?Q?etpywFsbFIb/Auw0+kqnCP9xdT3Z3xnHRC6qIvt6fIakc7PEQAidyXTHcUqc?=
 =?us-ascii?Q?NZEopWybnVUBjYkupIdBO/GBQI6uhkWc8PNM02uvm3TYwHfG6DqZKXw35d14?=
 =?us-ascii?Q?7AkqnBePpcZ72UmkYJyJyiAWX7gCgQR2XuOlVxtH9TbU/t/UuhOkEylJYgdL?=
 =?us-ascii?Q?vWgJU9SdZ17lNpA5WsOjF7W1YGsmG49eigxX2U6+9r0WSJNppxShKA9Tj156?=
 =?us-ascii?Q?feOVdsjWbraFZlDsA7IBJvG7XjtArBu06VqT9xKZNQZJmRC1y3FPlDEkxgIe?=
 =?us-ascii?Q?q4GUK9XytyB2grxdzjkmLZkyvR0DFn7qAySlxzK9rJB7wAK1oYIP1jCwsFTH?=
 =?us-ascii?Q?6fRhaKVbLWXbRRiA+BvmC1QiQRrXQf3PRnzQMFpe/jy81N+FcKI1NHwJl8Uw?=
 =?us-ascii?Q?nM4Z41Bg/OHcVNPKO5zkg/wCpNkQ6imkxmGOZFEiYZK+/9OowpowEDkI5Wqm?=
 =?us-ascii?Q?czGNo7nhWbORED0weBMdDSTpEKc9OMQ53uEQ+ZrN0jlI1AWiEpIdzFn/mPYF?=
 =?us-ascii?Q?Z124LVuiGOLhksHwnlSqVVDisaSoIbxEAP4sdvc61+GBdqfo9GGTy7d5kutc?=
 =?us-ascii?Q?At2k2/k+SspirefKoPPn13Mj1LbnPoKNrRSpygnbpEUuFBLoBqH9Hzqv8ugm?=
 =?us-ascii?Q?VNzSSmok0Cwg5flRUvbS9KBd03rUp9h+KEu3ie4e4m0FrsJtD4jnhNP+18l5?=
 =?us-ascii?Q?9WqgRr2CcijS+ne+Bg8bkcur4jbV+du51wULs/wfoyr1Angw/lDsXqqOLcVD?=
 =?us-ascii?Q?HTMyVdHMOoFBYFVmBBvc12DkLBwEEG7ZFQlDakrV5+GZao9Tj7sNbpEvsX+L?=
 =?us-ascii?Q?asjWVmrFyMimSLYmz3Z9FQgo+CN8+d2jZ0I4x4JJGiVfaVJ+vCxuFk7i9do1?=
 =?us-ascii?Q?bdxUZRX8sJSS2AAEffrTWBeErmnLho/6Vr6wYNb70UQ4gMFNsrBeyVDFdet7?=
 =?us-ascii?Q?CXCcTc1DS3V6Ij+sFUaK7e9tRmncQ5WwQDTSbhxK9DdHua/37zj87Cp8Newq?=
 =?us-ascii?Q?y0TFygZT/F9DIfd4+DoopN+SBHtYYN1HKA4mO8nvLh8Yei1aNXydUqlwRgKm?=
 =?us-ascii?Q?C8CqgrGeiJMVCAUWOBuheiYRB0XZv77HdyOBi0JtLqCjvtJ/mav51GV5UU1Z?=
 =?us-ascii?Q?H2wUXGWrXL94/mfZtMxbong=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc459688-300c-4218-2b4c-08d9ae57fc9b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:17.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZB2s5q4g4IuG2UaTmgsYCGUcWr7qamumZcnndz+R3k1H/Z1TCNQ5WwwLMeGdAtcyvpzm1j1iFvC8TgV4v6xEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 2f664823a470 ("net: phy: at803x: add device tree binding")
described, configure FEC PHY VDDIO voltage according to board design.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 50b3bbb662d5..3bac87b7e142 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -117,6 +117,12 @@
 			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			qca,disable-smarteee;
+			vddio-supply = <&vddio>;
+
+			vddio: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 342f57e8cf61..c3f15192b76c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -100,6 +100,12 @@
 			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			qca,disable-smarteee;
+			vddio-supply = <&vddio>;
+
+			vddio: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index a9e33548a2f3..c96d23fe3010 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -170,6 +170,10 @@
 			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			qca,disable-smarteee;
+			vddio-supply = <&vddh>;
+
+			vddh: vddh-regulator {
+			};
 		};
 	};
 };
-- 
2.17.1

