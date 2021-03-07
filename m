Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB0330025
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhCGKnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:43:14 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:39745
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230155AbhCGKm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:42:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RExXKFyfT7Sg0teGspNW+a3UaSOrxo7JxMRpSs0YI7/fRJtF5OmF+j/keURyq1LmFrDkg5YWfYQ/SV/ZzfQSf9ahIQP+0YeKRA8e+K+ebcdjpIeC0IclGnPiqJl0vEzomco/1J9czr1koIynMmu/qCszU21ATvFnXPXgpy6WW5Fy65W9UT4h26yVwGWeEqIVehkkNzGf509nkoJxUD18TqH1KYE94L93+WiS61TTdDQvS3orDAQ+l/4Jb/tCpL3FkMxiqYAxkZLw7jM08vbHyTfID/S76Z9qvxmHPxeBWrSoiNvornQLVzLe2zJPT+91tvUIZR65AXbV78O2rzfTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgqKGvYNzTHFj7PF4eQeer3sW34Nog5sURb30AXuNMM=;
 b=Ktmuv0Xhwr5zLXsg/d4PMqZjIjBEgOGPkBaqJObOHmGvNT6Wjwsu8bLNUuolGT286wH2f2XVtw2nyf6FzN5Dj+FwmxxdDHg3/Cv+T6O/kbT+8Far+r8sQmXIaLjb8oMY/oWG27Xe361RhhJSc3i9cW9h9ksT9dVAO2/rtUmdB/6xtYjOeW9lGTEx4Y/B9703d5pxSEw7L35uTR2d7QTCimsQStzS88JWdH6MOaHj7G15GMEN0+6iHkcUBTN70Axv45tCuK+2iq33yY3yImOosv7fQYG5LELFH7T4sx/BRXh037HAre3HVBp57crgNZ94fNlLMhMBUWjm6ajCVNbt+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgqKGvYNzTHFj7PF4eQeer3sW34Nog5sURb30AXuNMM=;
 b=ZDZv8sDvj3Yy+Wd06KPdbqXcsTPJV/f7INrZl2AjfTu2UoDvLz5t6TAhJxuxtUBIPMgP7s5eplbJc18KubZuCIqmkyV3hFC8lKcqmzm41YZNirUElMVWaBeF2XGBoGaBwY4VHFtELNNu0tvXzYnslJTgJSHND3ljslb1cItFbxU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Sun, 7 Mar
 2021 10:42:52 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.054; Sun, 7 Mar 2021
 10:42:52 +0000
From:   peng.fan@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] arm64: dts: imx8mp: add wdog2/3 nodes
Date:   Sun,  7 Mar 2021 18:30:03 +0800
Message-Id: <1615113003-24612-1-git-send-email-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:202:2::30) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR0401CA0020.apcprd04.prod.outlook.com (2603:1096:202:2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3912.17 via Frontend Transport; Sun, 7 Mar 2021 10:42:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e4fd6d3-4abf-4e4d-092f-08d8e155c1f6
X-MS-TrafficTypeDiagnostic: DBAPR04MB7285:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB72856AF8D2587341FB7E6178C9949@DBAPR04MB7285.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKg5Cqy6qoD9V5Q2okjua/Z96kt/tQiW6EY89qbg4YHBsCBpveUS57s0hS5b3Z+wyePvzi6WxDAmifKAbhAbeL5ShEqb5qdoqZy4P2LZPF65UfgrhiGBzcH7nqV6nOgqDIb/MJET0ahrD8ikr+jg7m7X3xbxaDYNJb+7S2srFkPU8Wb4j+RRKDZNQpewDnvCAzFqtSlvulINHykR7YhTIKxsiYh7+oC79Vuc2uTWNk8OUhE2tqGpKzwsLLmJyB6Xr2DkLKJ72kxZY3j4aCG7FncadTgrSGPRIO1iMDPgYj2ij7mtNh/25gEE5XDdNwEWkYJIoeROLtAGp2gmCK5HQw/JMMm+tPtu33OYW7Y55vVUP5Xq7b00tdNrPNht2Er9YEhyo6mkjcROgNRcQHdywInhrFRmjyw3bsA1rD0ncvgA1aMriE6xSfZSYXFt1klZySiIFOkinOlpJ+dXpqkKuVps9psA0wo9lkRs+en5/mvA9/aJkynfjjmxC6hh+cTrHHQxcCuSznm2K57gnIILWJlU8D/083k2E4mix+8OVPlK1gjOm5Zi90i5tXbAigeNOHz1+sTcEtv1LaT7tkKpmxiH5cG65Zrrcc6DM10yPxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(6666004)(66556008)(66946007)(9686003)(69590400012)(66476007)(8936002)(8676002)(5660300002)(6512007)(52116002)(6506007)(2906002)(86362001)(26005)(2616005)(186003)(16526019)(956004)(316002)(83380400001)(478600001)(6486002)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XWiTN8/kKJ7CpfKhk3+uxgmIn1YWeLD3lJm2+/sc5Qq+tNRt6JwHw825iiJm?=
 =?us-ascii?Q?jlnUjSLz09ANj8rwuD1i4IX8yG0GEtLyqfsNkfrg++DXKGb10OBe3azr6eNa?=
 =?us-ascii?Q?z6sIx0QaHMXsis0Ee8jQihqMFLGaYjmfCm3JCIthl5mui4036S/bKpraOoDq?=
 =?us-ascii?Q?hniF6QMub0wITr4X6pVzjleu0gQdSVQTYWebcevelSrA3UkbGOtxhzbJkfMr?=
 =?us-ascii?Q?PtNxL1VKsvnsg3H72Xl7aEYbXZH7XtDQGKya9kM1Gp9t8z76szSOJ/bJUIBL?=
 =?us-ascii?Q?XdsQM9s91bgvtWSOX5wm7QDNH0WTKb+M0El7ke4GSRBlxn33UkSdOnqKtDDO?=
 =?us-ascii?Q?QbKgehQRaeioRRV/7eFsAGF0RUyFgF1dXn5m5dQXIyeX/HnuyflRC+5PHRgu?=
 =?us-ascii?Q?fupEGp4cL283RotvHqYQl98yCPBBn7ZZkvbP4oPIU4kYlynv1Vr6OlGO7Z4g?=
 =?us-ascii?Q?JogsSxuMv+ZJEsrqc0dcDxPZ6JtiE0HL7ypPFhifsutA2fkSH6p3KIihwZLh?=
 =?us-ascii?Q?V8mFX4vf8kMu0zaqWHEhvyNiBJLGxlykQTcFg0igk0NLNovPzUUamOpN/oEx?=
 =?us-ascii?Q?/r5AFZGYgfE8z/EoXRbEDWM2HFCX1aWyjogsZt5aTuGTWbg9RTWk64kaTzlS?=
 =?us-ascii?Q?OXPxzmNsxjLuj67fnJz0VRrRtVA8QyEYrc7ytOwCqIwitbKAsbeQMwB7csnJ?=
 =?us-ascii?Q?SvQIqFCBH/te7aj7+uaYtpvJpxeB+1zB3OksodTA+1fM795/tJGhOIsFzQ17?=
 =?us-ascii?Q?hGuBLeBDgo423xsNSIRl13oRMd02DMmlkLOnOa2gIxLOa1qcHIeOhSNcfc/Z?=
 =?us-ascii?Q?eJF3/mtOPTZSnTCVHNjXCNbZqZ2Q60gA8Wxi+107VPqg7E2SHP8lCqEdFxfY?=
 =?us-ascii?Q?xI7oCvP941kB0NLOicumVMsL6GsgK73CM24+UZdDqBDFkf2izKW8a3dxrqZW?=
 =?us-ascii?Q?rneyZHIQnCWcC7A5YSGOAqIwk3N3arHvo4H86+LR+4PXf9yHOoVBCcpHmP/T?=
 =?us-ascii?Q?BcqNNoDMKEyJAN+uPgRQZQL0bEADRcbOvajScymm72QmwLtcxF/B6i2QlYPT?=
 =?us-ascii?Q?9XjJBXlMNbn6PU8P7coeaaKyTUyNyj3SWDCLsY+9eN7WC4Z3yAIfLAbH8N8y?=
 =?us-ascii?Q?nOjmtMnT2/+kse6VDBIeaQ8rRAfdil8UWMgrhh6v7XZSfIqojefcihlLkDZu?=
 =?us-ascii?Q?PvvrBA1Dft2EabFFt8YAp/+f0FiH+SrVkMrogRTHCAR3yH1adpljIsUHh4aj?=
 =?us-ascii?Q?Rv36V7ZHq+FnElo9LuEkAz5G3uyt4IFhLI6wT07H0AEiFEOes7m/lD3wkyGm?=
 =?us-ascii?Q?zQ6xTkb9NQ7YZ+7uRf5Gz4+0TifIwJoDP/GUoT6KTH4DUg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fd6d3-4abf-4e4d-092f-08d8e155c1f6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 10:42:52.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NO6g92Z69HPDHaA/gAzjY7KZBUgL7XByAsDcG3jeUqlRjBN5ZtwhcxLpSlKZQwQr1VBYshNGpsxNh8fIdRkjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is wdog[2,3] in i.MX8MP, so add them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c7523fd4eae9..05dd04116f2e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -312,6 +312,22 @@ wdog1: watchdog@30280000 {
 				status = "disabled";
 			};
 
+			wdog2: watchdog@30290000 {
+				compatible = "fsl,imx8mp-wdt", "fsl,imx21-wdt";
+				reg = <0x30290000 0x10000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_WDOG2_ROOT>;
+				status = "disabled";
+			};
+
+			wdog3: watchdog@302a0000 {
+				compatible = "fsl,imx8mp-wdt", "fsl,imx21-wdt";
+				reg = <0x302a0000 0x10000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_WDOG3_ROOT>;
+				status = "disabled";
+			};
+
 			iomuxc: pinctrl@30330000 {
 				compatible = "fsl,imx8mp-iomuxc";
 				reg = <0x30330000 0x10000>;
-- 
2.30.0

