Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3B40348A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbhIHGxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:53:11 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:21422
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237239AbhIHGxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3fn+0vv48zgvqZxmn7K7R8phH70VVrvNe6l3oJYfq5Ko8BdC+ILU+JmRUOY+aQg48hTNWWUzqtMlK+7mwaubXo4EI/O7EyUS+ameNOznk/d3etrPwQsQewpZMDrtiprAkFOlrl4lWYCfD1lhB8Ohx8HKSo0BTsZxuX/oCsWoQiX0K+quNUQ2ke4ZUqRd02r3lJW+KKVSFMVOW9l0HHAAHgHm5mngKAaLYb60gpcicAqUYVHrCBn9c1b+EiP6mlwH/hV656U+rzbtuI2Ohzhf6HMyHhQ0XZyc57BMv3AhJtUxBTSuz9FtXII9amoqA5BJiUBYeBLi8VlHCYoh7MBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=g68JwiSYF4K9d24nG0unRxPH6by9RdR6SZxW32XjGs8=;
 b=WGzrV9NGzNui/vzQRctfWJQv+BjWY7Nhqkn0Hocw7Wp0ywOXCSssedngj7hkP3AZJWCMQpatPImjDV2CvJc98CIshCWkkUYbTyYGK3LA09e2Wy7iw6khlOsAy0oskK0pORXRh3rSQK57uP/T8oeGo3TqIwwGQXEfpF7ruOxxg8Dsx3ns8DfksrRHJFDiu3TqbqT6GEIKSEGRh09gfY4+ELlqugto3Clu7sWV9Zo+PBYNUwM+4NFj7dNOKstmvmjKEj7YDUxz0AU8G7azM8UnRhe3UKlQYJIMqnDligjqbYK8DFANRNpfwat/DkLkeTyGDU2oFB4b08pqqGM95yuM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g68JwiSYF4K9d24nG0unRxPH6by9RdR6SZxW32XjGs8=;
 b=GaKbv9KX7rj/x9jn7nnpE7OOD2QUxvDh8kiBD4h7RGvKOjPE1yZlXLMStzPnGlCmuBmSqGXF+mxqA96TJa2xt+yevPvw6pjdNZnKMY2BCskxct4qWungLWe68BW1AqFdVcfDhduhB802NlMShBnkKgOmwFYpOhhE2STxuu8EChY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 06:52:00 +0000
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::414f:6546:f3d9:2651]) by AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::414f:6546:f3d9:2651%5]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:52:00 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp: Reorder flexspi clock-names entry
Date:   Wed,  8 Sep 2021 12:21:26 +0530
Message-Id: <20210908065126.1273140-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:51:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7a841f5-270d-4074-6b8d-08d972952802
X-MS-TrafficTypeDiagnostic: AS8PR04MB8513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB851335BAD22A8AC674EE153EE0D49@AS8PR04MB8513.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwBlOimsVQv2MNPnvo1xDsDIud9ovgEgMkxWhH0wAj8Hou4OG0O95R6a5Yl3ZBsF3t82IuISNYJ4eCN4yaGLBNbKfn7LpsA6XFHBbBF/wkHGxQe7o/uJ3K2mShKezv3vFspjIrMSO5dCZbbvSG0IbDN//NB7byveCK4mdxPNEzNDMaLxgBYLoevcZmdIlhVi9LHXz3uFBQF+wTu+lvPAU2wtFnBUMh2/R1v+fLCs9TTF86G3D+cP/86WtYk10+bCn4RkcVRRdjQEQhm0X23DofkNlC2hU5Rx/lovEc0FYg9BKEWtUy/8V7zFEC5pujEfMDFX3wxQPrOSVF4kR4eBlUQlfdbCstKNnIXJ6VBhViMAOmBLHaTdeOIm0wRSp9i5p+GxvR2UzvjRkkTBfaFTk2ALT78aNEVm0ZD0i7TH5ucHt+m3N+v6SkLQ9f2FuaMLWwJ9MxtsxZF8i9n9GqG97uEIqknPAsDqsZqAZwPRe+ffwpfQfntd17Kurav9fan1v4OAZfjesgloDpfDwzuQtJFX6qchzs1kLINDXACZz8xi1KCSiD3HRboZKkcQsTRLd1ZPyQA7pNwDHl02AilUpcg9YgUEnzOr/LUVbhL7P4aoD83+Bvtj/ewR99cjogEBM15cvj09sMDat95GhUas8IfJC9FknGLwjSFIB25ZtsON7b6cAtVJAdk3Ank4jo+S3MUZSYWAV/BmEzDvWjFYjvFuV9j53zWncGSyYsHaz0BMzIu8QOVXZAa0wszLOLqu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(8676002)(1076003)(66556008)(66476007)(66946007)(6666004)(36756003)(1006002)(83380400001)(8936002)(2906002)(316002)(4326008)(54906003)(52116002)(7696005)(5660300002)(478600001)(186003)(26005)(6486002)(4744005)(55236004)(956004)(2616005)(44832011)(86362001)(38350700002)(38100700002)(110426009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9lO47m2u/oPhcWbUXTCVaYMyTvO7PwW8GvdY5aIlxH81m5x83B/SP0B9MS+h?=
 =?us-ascii?Q?1Ptc+UfIByxyP+u8+vOq+0sX3+NH0rIOHlx3TmFudjPWx7Sub66RdeSo6R3I?=
 =?us-ascii?Q?vgNTiVFTIiAyGRJOe5zR6OPYyax8fNE3gteCOwVIg7OgT/zQqZIkxPGnX3BK?=
 =?us-ascii?Q?lbriLz6dx5ni55MUBKemMgqroBWScItD1vy6rr+0OIkiA//iHTvgOTrz15UD?=
 =?us-ascii?Q?sPCuHWRkiJZ/MN9Mm/5kw0iNPjdfRFAWkpbN1DGtJVF9RILDWbjo0g10GXQl?=
 =?us-ascii?Q?S2no0v3s6rcDpfJUIX4PkfsiZMFbqcStRP4W8eTwNhz5FEQx8mg8VTirm7Is?=
 =?us-ascii?Q?Ye3lArOwyFfMnFEUVa8JLB3w/Lmj7E+F7OkXvpNXuSGOeAKAIpGI+jRBb8ao?=
 =?us-ascii?Q?zjjjteQL+GsInSYkgH4HILPvzmAyScR88XpD1Xrr1ny7W/dAM0tp+aafvsPp?=
 =?us-ascii?Q?qJvhgJSK5w2/v8UjljsXjNILHAUOtHF4PkNNuDQE8cOoYAL88z68nbzxKpA8?=
 =?us-ascii?Q?YVl11pTtuJb+Lc43HslpTEhyOIkB9lXFEFCWtdqjUID+RcyJ4W3LZT8wbdM/?=
 =?us-ascii?Q?HPg7CL8c2jREF97HR3ij6B9eWQFo+92dEHdGXpNd5GQ57hcDerjUuZF7RCaX?=
 =?us-ascii?Q?rpourh85GyGNIIjHu6394oRQwOAwnk5cJd7yg8BtBV0QY2f67cpe+UgfN6Xp?=
 =?us-ascii?Q?k+lrgWKkZQ9O5zIpasL9+4JAKJCCIZ9EOSOaOU0xV0QUBf3bp+V6NHdV+em8?=
 =?us-ascii?Q?xBlkCB/zUpQb9uVGIV61r78SxG1ueGv+5hTXYHGneMTPmgEvN3zDHYP/sG2j?=
 =?us-ascii?Q?ajLC34Y6y5j1Rqe4e8cMx8S2HouVq6L/8MrOPy7WApdBIyi7NyETiBH2QHDa?=
 =?us-ascii?Q?EIQxIlRY+F1UdLYSlHfKihBvjpqCnc+9PGHS4/lE+9TdzR9VD7U7U9inBKel?=
 =?us-ascii?Q?V/YNevaeaAhx6/36UCcyui25F3xGFrxMfGqqY7504+bi4adqS67lmuTC49OP?=
 =?us-ascii?Q?1KR0RBOISTBGvX3P9rl1WuCFLGT7PL7JhA4vsp1N0Lu9+IgFZLL300LLM/xD?=
 =?us-ascii?Q?BXNzxmV4kQFPr7STnyXKNetM4Chx4/c8QP54+sbk/cpNSyoKYLy4DgnOGh6J?=
 =?us-ascii?Q?uDBY5a2ON1WpbN7SyQLXdY6yWWxd9UoaI9lIYS7/tUJSd8FVoR/rax/B3Eu8?=
 =?us-ascii?Q?siGZk24yql3IyatVvqqo+nPIsvQ2DiMTEaI+CGlLBk4xMkkJoRIi07ZcpW+L?=
 =?us-ascii?Q?pKkA7gtvFrpFXKwHX64NQSuqoGX3iS0u2TF/U+hJeK/YdzB7AYAoYdzVC9aw?=
 =?us-ascii?Q?LPypJjjPY1TUPN6fO2N+HAqq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a841f5-270d-4074-6b8d-08d972952802
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:51:59.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zft2IFS/lGzle/5sUtB6EB2Z6VYZHjNsb/3eSVfevgYWBNfm2qTXsuZvlFkiQY0QyNLKUP3Qkg7bnoVnsbj32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder flexspi clock-names entry to make it compliant with bindings.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3096acf63437..278c48ca03c2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -785,7 +785,7 @@ flexspi: spi@30bb0000 {
 				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_QSPI_ROOT>,
 					 <&clk IMX8MP_CLK_QSPI_ROOT>;
-				clock-names = "fspi", "fspi_en";
+				clock-names = "fspi_en", "fspi";
 				assigned-clock-rates = <80000000>;
 				assigned-clocks = <&clk IMX8MP_CLK_QSPI>;
 				#address-cells = <1>;
-- 
2.25.1

