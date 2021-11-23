Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D41459D65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhKWIIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:23 -0500
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:62593
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234602AbhKWIIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMaKEpz0SQWDMMsE67IQjJv6VbbS5tmJH2owy1pjUTopY8gh8QqGXsmTG4z3kfSw2e62Yb4uhmC1i9WE7zATB+CSAetr7sP2VIIsuvuXeJe0dQ+bq6g9RlMhavlYDKGNQmmDJl7qCzbo+TjVgZhzC2ovTC4Ox9F2CaJqQ9lGo8SbLpnCalNL6zfCyS7LDz5qrXFOQ/fTmS3O8lIHQTovcCQcO+6SAyUz15BSVNGRbzuK99h/iU4j7QB+s1nE9H5N+Za05bhnBh/KPIznJGDroEIxKzvvGlAfh6q0V5e3b9w+sJcM8Tg5FA7fYz2kuFakR2z0PLhfmblKyCVxqdR2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kizAEH+F/o/GMKLhudo+m+ki4mKs5nFhcyZU/MjVFo=;
 b=UMSQEolsIDvgzPFoRsFU5BhpNLW9mn92Xhn3trHcpzwebCCOkBTN3nw0iOyaCaKSrXVezWkaLqGOCpNUTfX86mO/YtCnzbFZIKqz6+MWk1/iPCfEmCuH8R62LlAfcRf27tv+GMoTISYoN2FyUe4n7ijDIGZhUA5bHUPRlEsuBb1LgDDXm33FNNQY0p/LVa3iHsLNZqcSPIN0GoSMedx9gyVzv2O+dJjid4qLe9tYXx3Xt0kPmQeWJ5mDQwhA86AE3aBDTKQyfnVCKi2NJ3CA65SjJ3bqrX1eN7vQg4WEbYbgII+ctdH6MpA2dldYEo+dQCxlfhcPPWVwjfWZYXc9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kizAEH+F/o/GMKLhudo+m+ki4mKs5nFhcyZU/MjVFo=;
 b=K9A4a13R32grqOJfITF03z9SfbQibilCunRS39z7i4W4RStSqw6VziMH/xRYVuCSwDzGo6jqaAHeb0buUObYTeWwhZuI89+RDFuh8095dpIG3pYvNYD5pNt35nNG8PsNxJjdfJUBsJBIZSEUbQU1TkNN+E4Svj1TSAZ75x3ci9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4106.eurprd04.prod.outlook.com (2603:10a6:5:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 08:05:08 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:08 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] arm64: dts: imx8mn-evk: add hardware reset for FEC PHY
Date:   Tue, 23 Nov 2021 16:05:00 +0800
Message-Id: <20211123080506.21424-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1093b26c-76c9-44d1-5dfd-08d9ae57f72a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4106:
X-Microsoft-Antispam-PRVS: <DB7PR04MB4106F21FB1F6FDC455C614FFE6609@DB7PR04MB4106.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjrcZqffDSEknFNP27gpPOr3qKzPPc7zCF5aPLnr3R/9SLN0ivOGIPO+0Ufb0VR40SmJuZQu7WKMCTaxQCdmAwJIGk3RMMxNeNYgZlMBJwqQa89Racqs6xLOtMYSP/NGKHRQtwDsF/TGk/2fcPvwoth5cfPLLuPzq2+moplqT7blzNTI7INaBTiEZdD1gqCUy6tTHESZsnZp32wm4ARqpEzY90CURuZOSJiqhnBhXvrZriVd43d9TbZgm5MSaTtmCBVuv4bCrQ6Lz/seFrl6vislOZxOD1c9k6960q2wk1evmnZCKoNHbUEohwPTN7Qp0mLbAi9QnFfPY54eFCu9MpNi9AJQ7xKDp5Vzum+smXjrRB4GBVpQ27hP+AVf1yhFK66aXVKXArDRItKXFo65xZ6ADThraC4cRf0M/+Ed0EE6OInIMsN6x+NIELIU0aSoTRnnQDGpPVpRiCgJhwIBKKUrtFY8xE9dZyV3FNaOXugbh3APU1g9/DUiSJbqFTnWbWy1O+j9qksNkcXqCjhcY+lUdY9CnIFcGYOXeOWjJIJ3cR68Z91yr/d4n2fNrk7Yz7cbtLrNV++PW5DkGkWte66jBqknr5Q298cuIxuhD2gXF/w5FhdRZfS84JZrRG2c5y3IHwsKhQI0hn6UvHvW3gi/vBAdVQwlv40Kn/7fYP7jgNaX8cT+i5J1oGbVSWWP4DJJkY0Tn8cS0hcNuLJfu4eEoRhaFxtlooJdajz6mII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6486002)(66476007)(2906002)(6512007)(66946007)(316002)(66556008)(4326008)(52116002)(8936002)(8676002)(6666004)(186003)(26005)(956004)(38100700002)(38350700002)(2616005)(5660300002)(4744005)(36756003)(1076003)(86362001)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7zIdvWQQ6m5xpo4WcMcjFecTsCkgFUJtEH6oLeL/Eiycnai0aDeuTlh6Zoo?=
 =?us-ascii?Q?/ncNyiuoeMS/1kEE3nB30yB0HCO7CBLNMQP6sW0/40ApIc72VkdOV4kJewFD?=
 =?us-ascii?Q?2dHfCxX/JusJqRaOF4aMwF8wFEowPwGF6JBMIxMk21faAAlKGoUtjNj7tNIi?=
 =?us-ascii?Q?1PO9jmRFO675Q96vpRFaCvz1axKmrMY7yIVfeXo68S3NKbaOiVBAZGEzEtAM?=
 =?us-ascii?Q?WGujx9pjlgRFFFzCf3nnKoy6iWlPfrPu50FAJLNzJkRiHkO3PGhz2aalWILU?=
 =?us-ascii?Q?ewIP/Mn5f5oWNk8E7VVAKEGc8wYm/J8vlEPbTX0mcoI3ZtHt0wqxzT6R5J9z?=
 =?us-ascii?Q?CaaB8hvV6285VdLlH/7IXS5blg1I7H0cNljJSAqjJnTH39NXEVCGumzBSer3?=
 =?us-ascii?Q?o0lCGkRB/HvyMGd34Txz1ILwRbhNjq6yRtChF+FEE1A5/KtHBylL4lmMWGiK?=
 =?us-ascii?Q?vf/SqKf7Evvi9nnEI6/wtTkmHkORH/T0oyQl8rEWipPsznFhk5cApyP4L5Yv?=
 =?us-ascii?Q?SLwKyMtFqEpLGH/LAuV+R1zwX/3uq1GBdtngiMhj9sRTUkkFMI/LRdb2urJu?=
 =?us-ascii?Q?IUP/Lj5jcXbRkHbEVvA30Y+uEBI4TMSwnEtIttuhs2qZ7A8huj484tLvWHL6?=
 =?us-ascii?Q?679mSLcNOHjD6cdN4nyQxDiiFq2xZ186ayuljC3Sdihzk7u3KOOKVdUmpsQ4?=
 =?us-ascii?Q?sYYEQOxEXBdXPtmj7vxPMfcPmxwb2V0Il9ItsWOxB4KeAE4qxWbJcEJD+uMx?=
 =?us-ascii?Q?MoSo6CPBIrPwxeILlCSYDoAYaIiEyHZqy2ABz1cqhLt+TeNUq8VDGXsF+N/5?=
 =?us-ascii?Q?nGbEZ88cZDXKxtNu+H8ORafRmSHQ5yA2YnkemsNwFb7phq8hhdfA2vo2hDXm?=
 =?us-ascii?Q?Ee7ZmCbKhJpXY6aroHdJ0lEonwi8QULurDDWd7Qu+BYAXATpPO31M5DYQq2M?=
 =?us-ascii?Q?8E5U1u1auMi3XwQ4eXJihoShuXqvHDon98AkgGuP4j1eUIrFq+PhS1bR2nKx?=
 =?us-ascii?Q?qSpyqkX7tOfvQM+EXxpJ4JZ1yzLHjMa46Mf17D60peIBfouH8x7LpcJKherk?=
 =?us-ascii?Q?cIxHd5np0ZNpgXoYr8zLNrOy/+GY1pgMfq/K4J1CjxslYqfUM7KpV/CA425J?=
 =?us-ascii?Q?TmwvZfZFuneLPPsBP6JLyRDHrjqJrEbTPE6aS3pgJHxNCsBZzWW8E5JzMtZu?=
 =?us-ascii?Q?rz3qEk7wSIda9OXV5p95h8+xBVkhgcKiLc6f9psrQoHEpRq4gVPoAFreA367?=
 =?us-ascii?Q?pwlKva6ysamJb3FofNyWdB0Cy97v/VN1jZig7yWkd+WZawdXihaiO3CynoKN?=
 =?us-ascii?Q?c4Ce/ViCIcdhPE42YqHX0CR2E9jvsjVvG5hpxddSB1Lu/wyStz0bluOZYYPl?=
 =?us-ascii?Q?uWC1+EpF5KELmoIvBNW8I1gA3eegRyUL8BQ9PczGtJ2PaVQT9ZgzyLhGT5kU?=
 =?us-ascii?Q?qzVT605A1JvkqcjOIdDvj/bCw4IqOH4B8hqz9AexQzzlRPOBLF1XD+dGFaVH?=
 =?us-ascii?Q?3H6Vo197Jk3mffm+xF8OwzRIkc1l2T3bRUX3AMoIP4XNGhDXDLJe1Jyp09V+?=
 =?us-ascii?Q?Vqx9yVzVMvFmVw6Jo/WLbM79fIF+xk05ZIoVRRj+12uDLSjJ6jgw7nw4AEPP?=
 =?us-ascii?Q?zzKSp75hEIWR5/5js7RcD40=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1093b26c-76c9-44d1-5dfd-08d9ae57f72a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:08.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eyhdin3QqNNRyAertmGE84pdPrzsJrNrnoKuD2MlK5374CN1fMytoEfuRGTd9w00be2fOIxs/i3BseUAXKVNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware reset for FEC PHY.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 85e65f8719ea..30e7c9d56090 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -97,6 +97,8 @@
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
+			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
 		};
 	};
 };
-- 
2.17.1

