Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC10A3A4EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhFLNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:00:48 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:54498
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbhFLNAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPaO/jcJyB9IHhiwnWgojd5ObbJe78BRW83EkH3wtUhvUXovimqHtFhTNgM6xaYUzpVR8ccUbrWQnBp/ffX/99BmenRJCD7DNXKSCAO2J8hhUbRCEgBPdQI6j3/mSs6WGx5yrilO3cdNZKAGd6NPez04l28DoPm/c4vWkr9iBRG71j1RRigAmvUin2AaNeZ77LXKnkxjlNXT52x9efog5dClnwLWfvjEV55233QG9+dV/Dt8Z04LOKABCuo/Isks/5kQ2hXaZShc/KD4mnB+cbfYgJUjfydwi+aJl6iDpOB9vnpTMY8o23No4pR96jR1hO3q/5ey7sW/xWTyFJwKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=JhGTRXyRM6T1+QrMyaAyHarstIN45bZr8/0ID0N2/Rhy0KSijRqBG+05bqROpmRTbhjGip5tNy4kp9AwywZE+yIHF/Zf55+b/Njh3csrnx+aFBID85qAYKPoJ+bSggEtTrlEhJDVSH+oQC8WrrngyezMjIhajtFZ+xaenwmwlKWsj5XRC+Lr7QCZny5y5emX0VAxnvrFCQ16ffoRLbxt47nz26KU4v8823/O3cTBOYscLXqgf+G18PSHtGG8auG+r61+kLwfMIcD0GJFfrZzPAS1ckLspK/D92iFGG4/ERKMfBQcunUvAyPPJEGXdeVp9sPyZx/gxYy2wZov5SJR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=ZzqDAsXkrrCXZsjqa7XcOtofI3+djUdLgwh9E9LBGgm2Q/HDfY7lCuON403QrYUh9ayy4nvNorAHNzSZQB3ePbpSpJIUvZoTzg3LGii1cbjOTA8IReyEx/RsfTsKtvIbJIIlTrPC96YowcDyuycvbzvJtQRXV9CQz/EjkTlbT24=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Sat, 12 Jun
 2021 12:58:44 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Sat, 12 Jun 2021
 12:58:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V7 2/4] dt-bindings: soc: imx: Add bindings for i.MX BLK_CTL
Date:   Sat, 12 Jun 2021 21:31:32 +0800
Message-Id: <20210612133134.2738-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210612133134.2738-1-peng.fan@oss.nxp.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0174.apcprd06.prod.outlook.com
 (2603:1096:1:1e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0174.apcprd06.prod.outlook.com (2603:1096:1:1e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 12:58:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 065199db-d650-4a4c-3a1b-08d92da1cf5b
X-MS-TrafficTypeDiagnostic: DBAPR04MB7285:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB728520969D025C8EA4244457C9339@DBAPR04MB7285.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoubFlf58UoiXIHqWBp1w0guIRf6/RcpqDKrS4nxuENnJ55993Mar3j1QBTdESub+wFH8koyMzidHTbgO0onwqdKJr8TMPEwgyhfOXpRh6TIoVNq31uWTdeAYdLAvZy474Tpg4igo4d1AR/0faVUl17Mm2SW+QUjKGSYsDmvee1Qhb0iaUMz1GxOyLKtYnQh7cFybVFyKB6LRgR89OBNoRH6ptw803ouJeeFLz97zKHIa/+rO6OlM4ELyAIbmfDVILgAW6uxIfBjq2jKzcjVb9no47IVxJgH6vfy8qQ4Oja6ndvQhg+81wQ+MF/l03G8RAokISirV6ht56eRzg+gornkJw8+X8shWcDsrXsSC8swG6IhEPsegmI4j7VOfEBQ1NcINftLFj1db23DVcgTurvJQ+e6SPrn2bAyi6I2WDxuJISbqNv0AqOACwvbqZ13PUQCNNUvymG0lzHBZaJKMdJ8iJj/w48k13D3Fjfszf+saNm5q+c6jVNaw4JvGCRVBcdg4B/u0EEeYdZR0qxE+WZtEglqepSs5ML4jLyREBPOMzbo0gqb2qUcJz/TZNdOOwPb4njaZYrPH2aG7sYmToPRVLV1QBOhoFmldOlxQVRe65ExzeQhcN94A1Y7jA3vJoHLfdlpsJ4LyFfajisLxWlL79I1Gc4vim0brppx3xeuvwjPsOGugCHrZuMbBbvF6I0B6yqWOj3VCwhnCgS/3IdibAugHTqAAE88qBMs6Sgee8+JNbXZHV/WDlLzL3ujhQTrustuZb5dl0JspqrkLZ6oz+EZLMLhYWdCmsKY1OkdO0Q4GrW/AEdbh9NwFOdd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(6486002)(6666004)(8676002)(52116002)(2906002)(186003)(1076003)(16526019)(8936002)(26005)(4326008)(6506007)(66556008)(66476007)(66946007)(6512007)(54906003)(316002)(38350700002)(38100700002)(478600001)(2616005)(956004)(966005)(83380400001)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nsMAzQv2EjYzpPllqN7ztQWJRCUBo4jxdqRb3rD11cp6w3mNvMAPKKNuMsTl?=
 =?us-ascii?Q?oQnsNYQ/WAzgwxQode0xC3QioeMW12AuYLHHBTCVT0gSrT03jZpSvQJqOmV6?=
 =?us-ascii?Q?LXcPOtz8AZ8Nnb9wtn42+vn+RyI02Wk1wtmDbYAXz+ru2ycUWlAbgdyWfL+r?=
 =?us-ascii?Q?SbLLLMXCr3//8Y/UMwm02tXXbcYCCPZ+OX63T8ajB/f7BZAKNsiIeR1ahAbI?=
 =?us-ascii?Q?NhpLmGXpgS7G6Q1v0lSpx4ObuMZr3UaqoOpTXwIrp6PX9INsHwwEJkTrCMbt?=
 =?us-ascii?Q?3pHhzUvnX3MN3+9bAsE1E3IMoMC0jGn9WDTUhr7eJzYnOdaxaakTd9UOpXbP?=
 =?us-ascii?Q?yYVipxc00q6GojtZgTbvjKihqzk2f78WG/DtQahUhgltjz7fLCqAZjHyZgfI?=
 =?us-ascii?Q?6f/j9Hz0it85M8UTV9sl7wHaQKwT2EHiPdYZ3VtZqzLducIwyb/3jmHA0DpQ?=
 =?us-ascii?Q?9RjIRXMib2WdsOZunbCQP9XA5wMZkqoV8U0SsBa4iW+JIk4tdq+Lf7nOll6r?=
 =?us-ascii?Q?cVeS3GEx9Yd29lSPRAsidXhO89CBYo+BWpeqmZQDgD1f1NP//kAuEFZW+lyM?=
 =?us-ascii?Q?JJZJ44n3+KcxSNjSxN3Ax+uE5AQGD05JdrQJPLPii+9lARVEVOaFjdFqsMnc?=
 =?us-ascii?Q?SmA9uwPW8Btsi1VAU/xMp4IvT6cWU6U1+eXXoOI7LnSITXaIvwkOe3fxZFtW?=
 =?us-ascii?Q?Rl7cj5MTuUg62nAagWkNqQlKlxnv5z7FPUzuNhtm69owtwHatjUrbWG8KwQq?=
 =?us-ascii?Q?c4Z5j3QpdiC3ZpcQvpaxPXvk4iucTK4SwAWh3zgUaA/DeLtT7Gtna5pbysy6?=
 =?us-ascii?Q?SdI9fM8hiIvxEcYcNpI1PX9Qt9UfLwOrQn6dG9Ker+0qq8VhHbeMQFoXnXKu?=
 =?us-ascii?Q?fNHFPkmpZcBnNHhAx9gYTB6eXf5xfQ3gEDKo0aPJiD7WygYO728TGIR8mljl?=
 =?us-ascii?Q?e95vHsViWwryBLQ6XjY4iaIgqPRRsMqieYFIZ95A3YAY9FZNJRDomKtzqIj0?=
 =?us-ascii?Q?1z2gBWWSkFjndaCnQJJ+cTkSvjjy3b2x2BJayBL7ZSvmCaZxQMQ46ZhlaSDt?=
 =?us-ascii?Q?hjkv30My02l2a0mQWLf+KiOQFgfKQBMg+zDt4S/ZA3I5++xA9R7ehi07mkpc?=
 =?us-ascii?Q?p6wi49U+mSVSRGiC9qNa5I4JBmHLdBS0MdJsFF9KfWdschtmnG3Agzlrg8rb?=
 =?us-ascii?Q?aDU3BKXt8ctdKgJqveI2yKaACovwrFk3rIRpjTqzEYKf9MTRPJvpceSf2/7k?=
 =?us-ascii?Q?R1nQZRr19ZzQ2b/XWmaJ+lLhnLaBz/jpRRBkLKEpyLZGrj6kFxsRzp0hb1bp?=
 =?us-ascii?Q?3voUW3oUQVIt5+BFqHopMLRI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065199db-d650-4a4c-3a1b-08d92da1cf5b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 12:58:44.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQIe8MaOSjAvInRQOZz4P+t0Nfd+o0R0r9D0POL/UJvzEt6kjr0HCNomVaEDQbvWFj4UU12U/yAuwQI4S43rrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Document the i.MX BLK_CTL with its devicetree properties.

Each BLK CTL have different power domain inputs and they have different
names, so we are not able to list all the power domain names for each
BLK CTL here.

For example:
i.MX8MM dispmix BLK CTL, it has
	power-domains = <&pgc_dispmix>, <&pgc_mipi>;
	power-domain-names = "dispmix", "mipi";

vpumix BLK CTL, it has
	power-domains = <&vpumix_pd>, <&vpu_g1_pd>, <&vpu_g2_pd>,
			<&vpu_h1_pd>;
	power-domain-names = "vpumix", "g1", "g2", "h1";

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
new file mode 100644
index 000000000000..a66f11acc6b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx-blk-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX BLK_CTL
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description:
+  i.MX BLK_CTL is a conglomerate of different GPRs that are
+  dedicated to a specific subsystem. It usually contains
+  clocks and resets amongst other things. Here we take the clocks
+  and resets as virtual PDs, the reason we could not take it as
+  clock provider is there is A/B lock issue between power domain
+  and clock.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8mm-dispmix-blk-ctl
+          - fsl,imx8mm-vpumix-blk-ctl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 1
+
+  power-domains:
+    minItems: 1
+    maxItems: 32
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 32
+
+  clocks:
+    minItems: 1
+    maxItems: 32
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - power-domain-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+
+    dispmix_blk_ctl: blk-ctl@32e28000 {
+      compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
+      reg = <0x32e28000 0x100>;
+      #power-domain-cells = <1>;
+      power-domains = <&pgc_dispmix>, <&pgc_mipi>;
+      power-domain-names = "dispmix", "mipi";
+      clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
+               <&clk IMX8MM_CLK_DISP_APB_ROOT>;
+    };
-- 
2.30.0

