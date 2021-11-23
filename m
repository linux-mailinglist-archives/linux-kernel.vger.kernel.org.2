Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D78459D72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhKWIIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:45 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:23110
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234630AbhKWIIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWCrl3AT6nLrv339EIhvwBn+G/6KAKAiPnlyFcm8gQT+LlHqzBwZojjR7xQSQlnW/MQ0gv7LpXOE3fOT+JveJbfiHplwenOlwRdQw6V2uC8rv6YKnsANVMzpb2A7tu6Bq68Z/ry9VTGaJJbHBDFA1jmESyfpiAuBk6u2sg/d5zgXGIJhG5XbaOigZ0GmPRdwRGpDBammqqdTL2X4wLdBBPWbi5f5cBq4+U/1PxQ1eOJU8DXgQVZ3KyEpSnq5/OGqltLW7RuZgQx1rzFGeN0WoGhe9SHqnr2luScV7F6Lr/hsEd/HCD7YX8DAI6+UxkZjyFZx0YbmdWJnCFXwPEoMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWkB4aZj6/Qz6CbUAqJen2VRfDEUOQ2EgDt0V72inWA=;
 b=jinuVc51MW008ow7PmuMWi2O0QNJo+BklASMXOO7Kdm7s0ztwTt/6aFOYpyN48UDzNSLPgyXnSHLGZZybUUMAFYBKDXvZL3NSLINmOAX0f51HpEYUD1KRAU5rcvKLjQF/81IS1XZ6GKPv1ZHzYPLgkNWA2Z5y3Ar2NuD46JH9Abndvt9YuqCdUZjmKzgvupCybTrZmueuvkXciLvdaTM40EuvUwpA+JD3aaywVRz9LnGg/PtwRM5St2TB21uDLZsYKRXJe1txLxSlQF/dDTPakGoyOC2yuPQdA7loi41pIcxQxBT2R38ENaWaWR9wDrLEBfHQZxsI2ca8oKGtBH39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWkB4aZj6/Qz6CbUAqJen2VRfDEUOQ2EgDt0V72inWA=;
 b=Q8DhxM0V6tJTN0nQbegaj+Nb47Ar4FF6spqhAG7FjpufmrRztJ/tocASVGqNqZhqU5cIsvzJFK9M1AOPMZlLUBWVRYny+QudeThvkE1gtPUOeAgCeUKZaDEduOI8giY38lNj3Ip3MjIDlj/Is44E2z6oUy9QzDZi4hpvMQ4LOb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 08:05:26 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:26 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: imx8mp: add mac address for EQOS
Date:   Tue, 23 Nov 2021 16:05:06 +0800
Message-Id: <20211123080506.21424-8-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cba6ce2b-ea6f-4191-9fbf-08d9ae5801e4
X-MS-TrafficTypeDiagnostic: DB8PR04MB6971:
X-Microsoft-Antispam-PRVS: <DB8PR04MB6971D5187CC478E97053D68DE6609@DB8PR04MB6971.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngOhGOqD6j6hUMk+qcD7Uw+iDto8Xg9cK7C3R+ZOL63Be+vEDggNBfdlxQN5Lrxb5dtY0FmIfzOOEOnYWVd1QdSxTFDKRXJZpjXCztmencNVSs7wVu8lypmbbTJclewYHCgRpu0/vXpW9cZCmuyTjdjtR91xyODLIh7p3npbz97b/HTg6hQIr0Nksk9T6XLgJujQAizQFsS9I/GxdvmsKdHXnnbTeCWje/zGYur8uq1eJH5DJ80MJFvyDo9Xhk40DhEv6W56zChUTIi9nQGtir3LgkDP91F8FiO7fS2ovky4oBDneJf2AaUzW/BSHofUuJZETn6MneeFXE4P4wxIJEnCam80By+mbyNn57E2bayM2iRsqRbDuuqBzljv1Zaa+pprb8RqYS/o7yShyeEjx9GAeufotY4JX8WKfoepSnKhnArllf/1SB35Ml4Fq2Nu8VkkZkMGU6Qje5kSXMR4nLz4NZyGTwp5iIo9TnQxToNfvPUCJgj5ouT4WKrsIHK/zVl1UGp6lZXRROGarq9oYrdy2gd47DQXe1dHqMgHlRTx+PuvK73xsohSduFdKafT6iNMCh/rBvCrRRjPKAWVtTIsiW3vcf6zNMbeAZf0qQyTtrvfrUURgIohd4CIiudd5WtBjquhdgCWcyOnnuDx92qzS3+ftlHZr2QcOjYtQ5jBS7D6LjsZPpauk0gdvdNCADEwtSgJDjRjmDlnN0HdIxlHdvDj4YtbBxC51SkvNNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(508600001)(2906002)(316002)(1076003)(66476007)(4744005)(6666004)(36756003)(66556008)(6512007)(956004)(2616005)(6486002)(66946007)(38100700002)(186003)(26005)(86362001)(83380400001)(38350700002)(6506007)(4326008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?or31Y/JntqyOEtlrkb9Y4B8RPPB02FYopkqWuQzYQ2xWItymWkjdO6zj/WTP?=
 =?us-ascii?Q?14uItm4ZHSBPVlk7rjBESTBMvCdKzJeKvzTCDYAlr6wKimdpldZK20zxdp1y?=
 =?us-ascii?Q?RnpYcWjceQN5Oki8gST5x0cy2gJ/6RDpvpxkB/MzJVLWeh2YrVKdT3PaT3WB?=
 =?us-ascii?Q?4jPrFJ4GEWHcqiB7r/0EsQTqkVX2Elj4WMTxaFmFkalxL6Rj6h3g4EC5yFKk?=
 =?us-ascii?Q?EXOyemGiycLT5KgfRq7BYg2Zwt4pEyS6Cg+pdMekcfS9mfJVcxED/AulK4AW?=
 =?us-ascii?Q?BQJ/JxTtCFhJC/XRk44Y/h1yEIteHqwM1mM1+OjKr8e6/iURrDxyHcQkI85Q?=
 =?us-ascii?Q?kvi1BsHq5TmFt4ElYOKMletpmrir/BpZ6Wwp2eYnucobKUvmaxSfCOgO6Q6B?=
 =?us-ascii?Q?Ra9wpablxe05BkI2CdptRVn48ty+uG2qjc0YwTqTn2Llt0Nku45y2l558CC1?=
 =?us-ascii?Q?vyaphOZ7ahMulTUaIsTUBusVDvWG4yOXBRJIZbnEbmSreLOCfxcBrcT5a2gF?=
 =?us-ascii?Q?TtXg4gh/O30CqvA4E2stSmWViatlrke/s6aHBtrmAwVu9Jd75wH/5mnhHIqr?=
 =?us-ascii?Q?wcmlW5FBlWyk/F9y8pzDPvPLP/uTcEBkvFOwlcb5f6/xLSVt0I3m0m0Ez8J2?=
 =?us-ascii?Q?dUD86yDPpM3EqML6SU7KXkvlbZ7SxFyZiKc0VdoAkNInMdce1DvaADwgAotH?=
 =?us-ascii?Q?8NEaxMLrIDER8U8MiGQD8lV9OxeemM5G1srOsGa2duwDwZKuv+dDL6c1qEJE?=
 =?us-ascii?Q?/82q0Hu+23mVfH04wSGzrqtwZGrB1/lvXxPHIhqlnTyJCvu/Oc4qp2tE4Vcs?=
 =?us-ascii?Q?W3hFbZgg7VhoR2wFTGEBQ3cjR0S0JSKcgtRra969NnorlEEBSIsydigSl8PJ?=
 =?us-ascii?Q?6YVRzTAcwU5NpN0zWLOQKIMw7lZeX5SnXC5S0HK1Af3IgcZoOkXlO72MV3iq?=
 =?us-ascii?Q?/Fse7MwbHJn3V0ZVyFvSNRtkZH9aFrK6Mm5w0G2MA4TySo2/+SAFXo6qXxfs?=
 =?us-ascii?Q?GtihWeyv4FrSgXtQYUiiI5L6V2m4VMvKxdKmPH4PNaxMEBtY5dys+Bo3OLfj?=
 =?us-ascii?Q?OXHegIQ+XorJGsjdKfcRcuy4brDnCxsb3uoYW/VLv/o1iAqDRBTbUIhxxbE7?=
 =?us-ascii?Q?wcw18VjUrBCkoRkWnMfWFYsVmONcuVOTDK54ULiFPruZKEVu3EDT+OecPP8y?=
 =?us-ascii?Q?m9v2opHvS5cKQN5lZ5Xo7Ay6u7vmM1gWgvWY5reH8JCc4+46CxvnN4klose2?=
 =?us-ascii?Q?Qm5HXfTJZgUcnR3dhDYkISOLWhFNDAqyoXvozV6wKr0Qwub2lD8UiY/f9Kjc?=
 =?us-ascii?Q?RtDUyxVbyFTk3uWmuadIk14yVUcGYIYUygLnLidhY7Iye0cX77NhCWAoGqr8?=
 =?us-ascii?Q?y7efP8zmXOyx+5K7GqUPcbwfnKsmSdNCPbrbJmxD9yMtZKjdei+MkXjTmSDQ?=
 =?us-ascii?Q?mWo4RQ8EKh08rxl1z8j+ZKv1zrGEH4b+MLdOeTcP7I1tOIwjhYi0ar7qJci0?=
 =?us-ascii?Q?OtSh2jY4ll0ym8mZOC4AqAxSrS444JaRzg1mztZLG0Gvbv22WZJzthS8otUr?=
 =?us-ascii?Q?+0P/yS94sTSbYfGEzZ16AY0VJ5YWiCKfehNGtstBrnfaVQDVj1xnzbLGNg0z?=
 =?us-ascii?Q?sEOBo4brFvNIvQn9zwiQ+8Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba6ce2b-ea6f-4191-9fbf-08d9ae5801e4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:26.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mXPRphxEw0xFRGn2HK1LVNo5JeysyqL/vqdZHZ4GWEuP1DS6BUI4C2uM/xcNQTa1XCuXiHqmAqUKjWamoHZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mac address in efuse, so that EQOS driver can parse it from nvmem
cell.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ec178c5fa99c..cc8a063d856d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -369,6 +369,10 @@
 				eth_mac1: mac-address@90 {
 					reg = <0x90 6>;
 				};
+
+				eth_mac2: mac-address@96 {
+					reg = <0x96 6>;
+				};
 			};
 
 			anatop: anatop@30360000 {
@@ -853,6 +857,8 @@
 							 <&clk IMX8MP_SYS_PLL2_100M>,
 							 <&clk IMX8MP_SYS_PLL2_125M>;
 				assigned-clock-rates = <0>, <100000000>, <125000000>;
+				nvmem-cells = <&eth_mac2>;
+				nvmem-cell-names = "mac-address";
 				intf_mode = <&gpr 0x4>;
 				status = "disabled";
 			};
-- 
2.17.1

