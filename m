Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64055377A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhEJDgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:36:01 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:4674
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230245AbhEJDf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:35:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8yMEjHiDq7uuRb3Prgfuv3Me6FUMb8DOz1qgTdlbpKJKov0hl+w+bfI28IMhQjrcxg8bHhNtsR2eKLOen9Fxz7dgInyR7LuqMkJkO8+wsT1Isfz0rokTWT+IIVPef0uiYhqX9tZ47SF8IcWkyC6Emsn4gz8o/VqlFSlnEZk/GnyjKbzWXvASNO8Im5i2W2sBrFKIGQ9EKFEijccunnwo4XCr2XftUrZUwrfPsfHVOceGBE/5UfgULnLW052Fx3DIOTXxpdOv9tlEO4ZKxCQQYe4dNn38pvw+9citVUK76EocMnSKC7miQz9T1JF2QS4yiEKKCMMXtH8G4qIwruBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=L9i69r14l/pGxueIBTsDLS4nms3KXD8a++C8IEs4op9ukp5BgzfOU7nbWPFromi65466MFrCAVcKP7r/wMtDJbVoUGig9r7tch9QzFY82kR6jd3HHY5Zeax2mUsDV0NvKCvodPgYgYt08VK7Np+dmIEyBDL4lDgmZHSdn5mjyT0dBcknANs6aGNAASCzPwepJz3mKeDpqLfWeeG2zAZph02ULR5avHilw1JoLKa6h9CGaPVRAbAgAkhHERRmjyinIwdyudXuHXQOZdq41OVvcm+PDjkmmdj8+X02LPCL4J/QbqujL9wdSoQQGaYHQRC6RY50r8tqa3cM7f/+3vw68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=NL5FGrRZcksl9smhhgymctlxJW0KXplYVgcyBjVm+3Kwo2Obd4sbjX1WhnGKrhHBiX4hBqCfzmDdx+ITJWJKfga1riDywQJmssG0fysZLeTpmzLJClKgWEh3wgdgcU5ddi5vrya5jO7GWrT1xku2TqowuZs/P7yD1g1sAHxud7M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 03:34:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:34:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V4 2/4] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
Date:   Mon, 10 May 2021 12:07:02 +0800
Message-Id: <20210510040704.14997-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040704.14997-1-peng.fan@oss.nxp.com>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0159.apcprd03.prod.outlook.com
 (2603:1096:4:c9::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0159.apcprd03.prod.outlook.com (2603:1096:4:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Mon, 10 May 2021 03:34:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 221265b7-6ee6-4d94-d403-08d9136492d4
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7930C9B18961A6E2F4E6014CC9549@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOBjtTPJ1MoXHowwmua8OpA5r/SgW3d/oVL2q92GL8RyqP5l0B1sYABz336fFWca4B68Nv3BjO65Lj1wNmnYw0FzaWkK1JHsARlsoQgo1LwBL3PHP+vw444L8hukmeUnH84xsLiL/ipVQUX1CUypGqrjXFbg7CevmIxKxLdgEvkjdbTOUwnjzz9ar/xkVFeLDV/HnTrszj+UqIV/zilR4ejqIv7Cw9rtHyONPFhACdYFgWg1cmXWzeiWxQTe6ALX0ZfrG+fWMWKP/UbhIbRF+JOtiFbX2sxwtWQyJ66odhM9woI5aIv0VxxDxMyZK6GnqHw1NWdM2lfDGrkPWNJ7baV7H8IX9iDtAtHlKgBPYQCTVXKc+UW2WDrFYJAXqjibYkC7CScYWRuQ/5q7RuIr6M5eXE8FZiTTEpge8ZT3tLaToXoauEAuju/acaf4Oolxtdr8lF8x486qYIlZX6SjFDHiQ8ZGyhsCq+Ika2iWtUs0FIByXxlZ66jqFmafQIRZ5kGfsRSVMRWMcYMIQzLKRlIIoKqSYI/UvFVLfoONZdwioL2JJNnVrjJ+07cTP3Z2h6y5I1XN+ew2FRs2w4hhwCz2u9ay988bdW1eXC5FbmWig0QB5zB+MQ0MqQrkityR5Pd9GyqbAlLTVCADyVQ3KOgAE9nsTbP9Met0SQgUGSbU8nYYxg2KaQKkm8iGbGaRGKQvz/rWPwvAXYUZ1+So6am/5sjtiph+qm2ET3I3FRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(38350700002)(38100700002)(54906003)(956004)(2906002)(6486002)(66476007)(4326008)(316002)(66556008)(66946007)(8676002)(2616005)(7416002)(86362001)(52116002)(186003)(83380400001)(1076003)(5660300002)(16526019)(8936002)(6506007)(6666004)(966005)(26005)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dCV2dsCGl4fupwayGbKeE9KTnp8zKL3USYXlDSx66zJWyp3QIeeuTXXdmQmg?=
 =?us-ascii?Q?hBOSG7lNRWu9usQqKe7MuM8U4d9d3X8OKYY0UBp+h8IawOQClPLrGoXcNFON?=
 =?us-ascii?Q?Ad2+5beAAGnsFHtf0oJ9+Nsnmr0tYI7k94HuhOTVieSFtP5+e5tiXLdKN4rd?=
 =?us-ascii?Q?GVsrph5A1FVveuCn8BGKlAj2eTdm+/tF+3fqVCrTDu6XwKFoMsYmKzoNlyHo?=
 =?us-ascii?Q?jbVBwc4FdLIgEXA5cDUfBAxMvwNzQc5Lozv4d9CsKyfn+AkQqL3cpYSLFHaG?=
 =?us-ascii?Q?nkzAgirLL8HZhq3ddAqegMmM84HB0Uy001Ea4T04olUTcLJXuF81FiFA4Goe?=
 =?us-ascii?Q?wJXTM9w6vYpg60HRdkC98oq0HsSOUq7+KdMgYkeNJZ3/Q8JwAUtSPMNH2m1L?=
 =?us-ascii?Q?LlX6PVcz28tFzKc9V829R7sF64ti+0FT688N5hCHicrAZjdluYI0QWvIxlWj?=
 =?us-ascii?Q?uqdr4I/8D5XBHQXQ1BxaqTRH2FImwqKngOXGZfK7LoLro39l5Q8XLHu/cY16?=
 =?us-ascii?Q?28XztCc72PP7vPoUWBnPWD2cs4e0tUwLUBMRBroqlWQZjhw0FNs4oloi9+CN?=
 =?us-ascii?Q?aTLeXjHwi7BMrAzsfpFyZvsHM9wV/hlKEJX4jeHN1LOCLDW2xOE+PmTNGzn7?=
 =?us-ascii?Q?wopDI33VqVhHGpVhlGldBOgQDEZBjxv5mpMqsUGrsvjTGaABXhBBjnD5gMy0?=
 =?us-ascii?Q?TEAWN6KF9ClMVifqYqQ+X0DIl5OwVd0ZEbeL9aICVCV8OzS5ou62NZVFXY2c?=
 =?us-ascii?Q?aQw3xSsRDQdPFWcJFZjCTCBa/Xv09NmUHflfobWb/7Us5MRlNAw49zdg8BNP?=
 =?us-ascii?Q?IFdNAxHCvdOar5GZOqlZy/dnj0KW2dgxOQ0GY+oOgEZqO1ri04OazswUv6le?=
 =?us-ascii?Q?sQXzM2GQkgefRP0xe3yCTiawtucCa8FQxl62unJuG1lSnmBYXlDMzsG2BSVQ?=
 =?us-ascii?Q?UPDiRQLhfhBZHq0j83XRRmSH/DbkIqThi4gd6p/ZNJXUg8nFCyWzEv8IZGhT?=
 =?us-ascii?Q?cqFaCWb38K35KP18+qeGlPIvA84kLpXkcBZjyDRNf3ZL7hM1m5IYUOv5n9pN?=
 =?us-ascii?Q?XHUDIsxkDKRySFg97of6BHykUhG3iHX7tUH2BpVxQNIAR8rvNSMjt6QZ2oiy?=
 =?us-ascii?Q?YDFBAq9BbwsHQafvm69OJkKqeKM31NGigIEsdg5l6leQHl0CyzGHIu77qmgf?=
 =?us-ascii?Q?dzOh6xL5A5aINYUJs/7TVKPENU1Fub4VxE6fP/2bEP8le3dNowpHTTiqLIP0?=
 =?us-ascii?Q?xut/Bt/iKRP3z5+VNGQYQeWIPC9FTN3bhxAfv0N23rXnq8/HmnNqjcXWr7gL?=
 =?us-ascii?Q?Qp2YqZ05MCJQ2akUXkH7ZwZx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221265b7-6ee6-4d94-d403-08d9136492d4
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:34:53.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zI+fGiG6Ye/BFMM1TBXprnw2YowgTk0WYdelyPrQcPmIa5kRtGY3PdH9b1FjU7x7d0tJALvuQa9zWkQY3Sw8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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

