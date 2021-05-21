Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF32738C4D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhEUKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:30:18 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:14390
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234217AbhEUK3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:29:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C08rfvxuEB/Hre3EJm5ptOW8zkWqfN3D8Plr9hyHKG6MBpzbd/kI0LtKa0XwugqWiXY3tTyq+HWE7fpTZ3T8xv1sE0UXuodrDE7M91hLJeiDB1M+MsTfXtmPRrwz+iL0+E+xM91uTUao9EJupKpPJ0uXfEnc8f+Aics34ZHVDCuB7w0N+ElZc7SISit7KPVokvttuLVqEeaUxXUm+4li03o97L8oeEZlsbjz7EWdDwINhl/gPlOB9nPLbuvP7GwqPIKj6CH0jYS09ToXae5u+NjT+EtUV2BA6kqc85K52N2uineBeNLhPFAbYPhFpLyhTYzcLkwRBLI3z+90933H1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=eWzhzAZRRRoNgoQWdOfbqgY69uE2aIO+xoWTkDS4JYfBub2FEY5swbMEcQodwgZJ3d7YJH8pgXgqtg14amTWat1lVPcorl0BMZ/HhzPcoVuhB1b51Ojp6HV+x1dUZSK0BWpibLRa05cR6JiKxsnpykKMNZdGVt25MTbMg/L+CRnhDO4McR/VJimvV3LhvmzWrp3fjWCMgGPpUs+uzcN3qIldeMNBIfA5yOwtqQuJOwf08HZ3dT0nWYIqHrQ9GL8KRELwvocJxORr/3mOK3Rcw1klzhSRpmLW/fXGLmcFRRFSthYvlykVFk5dyp/D3c/mgyJ7USUHRBwaBL6Sy13Dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=E99e+TERSDcfENQa0KCeiFociWyeNgqwtLp1DlA4RQ+dNYZf3S+jcThaMNFtOWCes8YDpcQOaHytbgvGHf0lbagroDKMiHzL8AmhZjAvVtru31XAk/pyCkka4f+nEe3EaTOPw3EeRyrx/q28rLaVB6kyQI+3I5Pedn3z+UI1q/A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4636.eurprd04.prod.outlook.com (2603:10a6:5:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 21 May
 2021 10:27:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 10:27:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V5 2/4] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
Date:   Fri, 21 May 2021 18:59:17 +0800
Message-Id: <20210521105919.20167-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210521105919.20167-1-peng.fan@oss.nxp.com>
References: <20210521105919.20167-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0163.apcprd06.prod.outlook.com
 (2603:1096:1:1e::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0163.apcprd06.prod.outlook.com (2603:1096:1:1e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 10:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aafc414c-42a6-4ac7-180d-08d91c43037f
X-MS-TrafficTypeDiagnostic: DB7PR04MB4636:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB46365C3EA405832BA4E470FEC9299@DB7PR04MB4636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrRA2g/RzkBi12ZwrzWKEBxEn8lUSG107kIBHwwFZiQ4za8Ywa9dhHojAUA5SgjyXzUAdIIGRynv+OsuXRK13o3jZg8DE5q1FzYH4Xm0AT5qdIWOat+wC5K4of+t26lPsb6CGXzr/nxYGLXV+S78IFOkDsVBuwuEST2tZnRVbrwPyMxJn4uyBotA8okvGTT8mSxyqI3BK34vNaDA729OHdCJ1fP0KQJY/Ig+VK+a1XmMELu797PGXOKizc+b9G62pvykfMvHub3KpCzgWM/KSlQbZZAOdwiKYjJO8uYdNnJ04xhLowkX0ANGrUXgM26bQDF19vQZX04vgx53YI2/CFicAIdx4L4FjqwOBOogPdypSxKzgvcv6SQK8ts2YwW0K1PSgSFqRt7p0OAuKvYIagyTiOd3PI73XjKXpjsS1CBOt/b5e2Y94hXTMyANgiWVvs8XV09y0y6YRhnnqkZNiYm2Pmlvu+SO6D7n2QqfQa1LGSxvFIzCFIvGIX5tJ9BcMhSI7EY4LpE2xVCMdTs8od01kz6pT449AOhgvSXTd4rB9j3AHwt1aKOXWICQgDYY/BvpJIDVedXDknEMcbu+rMz/VbeeOe9A7BfdVnZnFAiUyuJikXB0/2u00UbCLdzWwexP8V6YfmZcIDMrN+ryipNDoOzggOEtxL/Y2TDiEyjS4BcQ0MZhFAAtm3jNY8Ourr+VDByTmATKe9fs4aNrnlL4WKR4h74BA4YMJT0N4sJRikewthAFonQpsbaaVAqeWpm/qc186j8i6AKk7mqiIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(16526019)(1076003)(6486002)(4326008)(956004)(6506007)(478600001)(186003)(966005)(6512007)(5660300002)(2616005)(52116002)(8676002)(8936002)(86362001)(7416002)(66556008)(26005)(38100700002)(66476007)(83380400001)(2906002)(54906003)(316002)(66946007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bwdjm18NnCK9xT5E2Nu5ITA4w51hvuHIQadzUHmKc0R7i438oveQRDHH4hCW?=
 =?us-ascii?Q?GpnNTYnBfngN+B2NaPPw/52ww2T8AsjWjquo4gwxqGJT2M5NAnD7rgNbLvIt?=
 =?us-ascii?Q?/U8P5hw7PRza6lLPyZGV1UPOgRXkArpcqzRKcO9yCyf5TSWOquggSmb4wrsU?=
 =?us-ascii?Q?L1aJ8sUm69J18Su1D90u9JexMw027xAaOcin+wcAmW33I0+uKZEJaRhLSE+0?=
 =?us-ascii?Q?yfZ+l5lKWmbATxiGP+DzVPHsbUE2qJJJE1udTTxDsFDRRl5dYwkXuDfDIjT2?=
 =?us-ascii?Q?ZJdJUixEp/o2HV6MjXRYpiUycGmRzPLUmuxcvQCshEJuwxTe0hgNau7sasXo?=
 =?us-ascii?Q?y0aRqXQ//lqFLx2u2teG+uvhkY81loS0hcd1gDUYN1JhWUvrSvBJDGfSHe0u?=
 =?us-ascii?Q?OodrKbFFafSZ5llQVMT/DZrCrsj113+DpteO57obcZTupzWUSLVWq3L/PScd?=
 =?us-ascii?Q?Y0jOVoYVttbV+fuU+kPeATFBkRVxRm8vNpHFDwpyrcqNblT7nasOM8LpIi3b?=
 =?us-ascii?Q?1Vs9kzVgmFGESH3euCnpgLbTTz52vaL6yPqSKVdURtID0naS97N2z0Fk/HSZ?=
 =?us-ascii?Q?qCKHywTEQJdwn8Ig8XUbTgB26Y663T3Qjt3ZtmsR6c0ncMKPh80SKJdECUbO?=
 =?us-ascii?Q?ZaH7gaCC8RLwmzOfsCFQJHkpAgQPAsRwJvG3VGCzRwXQ8XFe3pQrKNVsyIkO?=
 =?us-ascii?Q?x1GYerkqzcCJqhUCtPbxGj+QRmb7C/MgFRzZkK5zA6aNVFlFzsw7Umnchrm1?=
 =?us-ascii?Q?0ITgtGWQvcZiVDDOrptx7L1R4d47oH0hYC4JzAkyivHX3PzHLyfDd+j1lWVu?=
 =?us-ascii?Q?IIgwpKEC+SkkbC3uQcCe03U/aukvAW3DjTt9oXCcvtZfJQo/sJg4X1RVZEx5?=
 =?us-ascii?Q?diRBe4y1g4SF972mqsHGkuvggxoi0oDDM6b1/gZ6HKeI5R5wmnT4yQLHqdAj?=
 =?us-ascii?Q?Mm9egAgrgOLIEr4dlrfapE5zqAwA53E3uAfNnBiCmTOfaTDOP+Sy4Z7yjoOk?=
 =?us-ascii?Q?0kYobRV6tMzRTwkN8TfsT4iIBVGjpdBoB+nx+MITKImBUEu53Upu0m0YNQJQ?=
 =?us-ascii?Q?+w9UCS9Sk3FINdKyLPbDdArWSKnKL4O7F5mxnjpTm7QpakXsqbJ+yarPVbKz?=
 =?us-ascii?Q?hgrGhlgGA35EhGAQavyWb/HVBhVi22lx3l2FhI5WbmN0xxP7pXiD89a8bR0h?=
 =?us-ascii?Q?ZP/4aw3wcMsgMh16J7aPA2wZrdjZ/DXwcZKOglEW5If0FjZj1Ak0heNyW/k8?=
 =?us-ascii?Q?Rjs/R3VDzR4YWd9lqqt1O37lbeJQggbauqVgbrpXiDQb1vf3cJWNbRviYw87?=
 =?us-ascii?Q?OG8QKkhuQcOKK+qST2wMw5GX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafc414c-42a6-4ac7-180d-08d91c43037f
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 10:27:20.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9c9tLvH8SkvbGpMojHt7kFHoBFVhOAac1GfCAf0FlbEOKf7zqMQtvi9Uf2r8j3/b9Ev2fwJYe3+Yh7f8iFv6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4636
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

