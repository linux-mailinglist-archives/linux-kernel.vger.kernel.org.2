Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0536F538
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhD3E4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:56:42 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:19013
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230167AbhD3E4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8oivMZ+Ohml8V4Po3EroeO+tMSYobowyfp4jDA2C8J3jImZbIoPKKRb+vv20BVV7LCZLBxxn0sMMGoWRkDhX00rg/y4YvoChgmq51Bm9xCeSWGkmsobXfyqvP80eq9oto3SpUUQJ+B5we9aKyJu8AZfMDZW1aYqHMTDMQad3sD7tNY9iRLMiV0h+mPgkj2Ibdn11G6uOhhTDPB2Ajdp4w63LCRtyM62rsPs/G8ROFKOMALA76gfKZ41iSqXc9+47K2AM8IrHcsbS8RdaV/TDL+UM8etlLpfBn6Syb1iUcg3jWPEkaphO7qra3D+jKPMSZYDmsefiqd4sm3L9lNNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR+u5uF7d7coX0epUL25kqfnOaANKttOKhr++MoUumA=;
 b=Xzqs/IOtd4J8MLoaFVZdPMg8jJhBpziCl7174mCSmQbDSh8TtPhf8/EZKquWODrmOHjNjip9pynH3WQh5hKWRmACnPFqQS7utP5muAuZAqBqvqQ89RK9l8kMm6YugETOO1qFQCBFZUwaK+ejk2PKF04FUIUPlnWFG1dBClm3YC8bB0mmb7W8pxYUJeRZBNwMKdiL122n+FCt+cC0V3OUr0X6/YvYcQ4GgDllZzPDZ8pskv0H/mgBnhwlukqUf0r/adHc/iu0k3Q3W4Uu4zSu8SpKzakr1CUp/PDel8jemUC0tpVDeCQr6/3zjzeozW7VgLFuTEH502l0LoFHS7JtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR+u5uF7d7coX0epUL25kqfnOaANKttOKhr++MoUumA=;
 b=bBMeL2TCleG2ftTk0K70wuw9/5T64gS5W/jx3agd8lz7OOUILgFYWme4vXwaSLoXMf+4ZT/7qUqW5F19LfPSxwzdFicNzZz6Hjrpo4U1b8lVNreZICrepN5DhwMph2jNNzMOWR5OlbAqm6lLRZwL7tR9jZjwCCj4ejzLn/YmOuk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:55:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:55:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
Date:   Fri, 30 Apr 2021 13:27:44 +0800
Message-Id: <20210430052746.10815-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210430052746.10815-1-peng.fan@oss.nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 04:55:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16dd7b17-0232-4ac4-8fa1-08d90b94396c
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916BDF08E4089BF3A433E44C95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q45s5D7yydEKIJlD2bTKicNAtDKfqe5wgkHtUsRijis8s73wDXMIVpxNX5MFawNF028rfaxHrdHNEmefpr+eUK6J3sHxv36XSbuhnrdLs2sSKHtcSJnjYBHo+NbBAHOQGjwTJc27NYJWj+G8slfl88uu7JC3e/izXW9xT5HM+1CaRL7WTiwAiK9prwISm3GJbTLXY3hXlf3CDdg9Rg8yYpBcXtZuwU4FkKuHCbNFkELMTg6jO7ed3rDWhj29ujifB8sE89FoyYJxvWYTJKmZU1SYNRvB787gGqBiLXodnMyaJLiyQ02awrWzxNRL5Sv19/lr+O13NU0XVgIYlV8ER4hL5nDSm1HAnnvBGxxU6uqFxrXRJKWY2kD1UIGABdHbinlvrTX2zxeVXzFc0dZVsAxqtV+O1Q7bwMdg9NBIxiEIYfiBo9H7irNIC4KCjUVu8381MY7uiXTYzRYxRxWaJNqaw17ZUEPdYpfwikQaJcIVmKed2z6If4rxIXg48brXXnxPeAHy8tmHZph6OhkSwto1LVk1H/5Ubsb3GHl9gha7nZsS8xbJNaLdiiZOVitwUbs2AgDCdYGNUp9A+iuXMdv8rbAyYIPzDgFbCcMQfp9Wtd7DL1BebRVQ6B05dMCHcM+JJMcpVxN8AUbQfWsuhoTg+GnVNtb3JY1eTL+8c3qrfXiTXbziskZjvpmEK94k/XB4+ZoXprenMAfl6w+il4H+cppPE2sdteoyuSqmNcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(316002)(8936002)(5660300002)(83380400001)(66476007)(66946007)(7416002)(66556008)(4326008)(6512007)(6486002)(16526019)(956004)(186003)(86362001)(2616005)(966005)(6506007)(1076003)(2906002)(38100700002)(38350700002)(8676002)(478600001)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kp8AFAbHDtYbDyT6ZFPamV/jatY5gQXiX0jGvLhgkh+qtKtMuZEIA+5cbI9g?=
 =?us-ascii?Q?KPAtXfFtZCXP2MdnjLJnc5R9Bqty0rY6kJfABSg+IZLWpggFoa4kmGC8CuwC?=
 =?us-ascii?Q?+VVmgbwdvPXqRQoJBn3Zxk51HDyIvN64OlE7+lIYSYVu2oFaZzuXO+5eZ5Nt?=
 =?us-ascii?Q?0elCm5+tJlOTS85PiHoWt4CHO/j20+SP43pPYM5Og+L3OyqxeM2qPF7R4cdc?=
 =?us-ascii?Q?vWYh6SIt3Z3E5jjXatTrj9ZVjqzWxNDcLaEb+kp3kgt0FoxSh5f2A44jvlV2?=
 =?us-ascii?Q?rDe7udtFDkl49Bi6KEoVBTFjL0eCGXHR9x05BgBpOMCo4vntkctfP14lo/ft?=
 =?us-ascii?Q?zVzFkW2Tm404Q242itsV9sIBJheMFpmjeUsUzPnxVVM7GJoqkU8kWFOuMG7J?=
 =?us-ascii?Q?+AuRpBlYRRl4zTQmpnYWfq5IgSV6Q1EtMIFzDTyoybcYJB+/JyIP6AjWycKF?=
 =?us-ascii?Q?lG1rvTF8cTlDO7aztE7UJMeB9md4Ggd9j1L3Udj71giAToPUormZ7S8p9kPA?=
 =?us-ascii?Q?iQH3vKCw4TOa0YvSPtwTnE6eckTzmPqe/wu/bgsD+f+nxh7NqsIROwzqj6i9?=
 =?us-ascii?Q?pqy3rfRZix8nSjg69/lddMy8LZAzaccxvy4Ouo87Tjfg6S5JSO//HJKZkmyw?=
 =?us-ascii?Q?h7PnK3OoftGPlK3Pvj8UKCSPK8jgGv9XH8oP5ghMrTyUOT91hD3PLkmEu3yj?=
 =?us-ascii?Q?0wn6nr37LJvblIncM1ddzJx9jfxM1bxzOJiGrnYVJQLuAxv6nEofen9ayK8G?=
 =?us-ascii?Q?rP9qvZ295X8xJv7VdKkXSzNuR7zoaDBKSBUDkyFGHE9dXcHx3cfxGEcPvMSk?=
 =?us-ascii?Q?iBVBqM7GCSxYh4xIR7nDFwqpf8z6xI6pRlUhmKiSp/DKYsRn4IRE1qHO0ug8?=
 =?us-ascii?Q?nZjWZwhDd0F3a4wlWGmeDDTuG1LVrlNLNA1ofIRpRye3dauTQpBxkhIhUwSv?=
 =?us-ascii?Q?SuDHMK5Zku297xm8DlM1O+KD9who+CdzQsK5CduslJfk0AutDfSmBA2Sz58U?=
 =?us-ascii?Q?slDZ3olB27Iq/XLvwrvhrp1dIqVJkYkzaEHAxN8fRLNOcrMU4sy1PwACWuq2?=
 =?us-ascii?Q?z0GJi5z/QjroIRtIOrY8gymlUnnoK8zRr4lygefUvh2LTPKiK5icZ75V1Y5b?=
 =?us-ascii?Q?G8bjsso1U6lPv7YI9AG/Z9nDx/svgjxVqVY4XNkalMR06gJ51Q1XLBYr4TK+?=
 =?us-ascii?Q?mEaXkfspxyyxoBF5fC0winUgdsI+Qw4LcjHnSLjgoTD9/Y/ofJxTz3xK1SGg?=
 =?us-ascii?Q?egw+rczFzV0nMaA9fsFIdYF+eD+W+CSNJh8xZxYOdO7DQvi5n/LRS0NDnLQv?=
 =?us-ascii?Q?T/DpEYvQbG3EvE5DWafM4R+r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dd7b17-0232-4ac4-8fa1-08d90b94396c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:55:49.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATCj9rYc/4zdbCu4ym8EERAuR/K01XzNr5EaIeSpgObbzKlnowclrT/GktS9vmH2mJpGYpS23e89j7DJYVmJQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Document the i.MX BLK_CTL with its devicetree properties.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
new file mode 100644
index 000000000000..a491b63de50c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
@@ -0,0 +1,73 @@
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
+  '#reset-cells':
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 32
+
+  clock-names:
+    minItems: 1
+    maxItems: 32
+
+required:
+  - compatible
+  - reg
+  - power-domains
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
+      clock-names = "disp", "axi", "apb";
+    };
-- 
2.30.0

