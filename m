Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E408348C86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhCYJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:15:45 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:18217
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229781AbhCYJPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qety/2IcvDS32Gb48e0RqQQP6aE7o/5NfW1uVnOMjdiFqAbGneCBJgwWAjFoe5FujPFg5c11hWQtSgJhCbr7pwzLX7i9ZP0twlzb7pTtVJDuEWmSIHKr1d45fpmy+e12UiP+9fuN1NpzCRcgVEToxJi1jaOd0BfL6DNOCwlmYAYEon3F7UlLwp0+Sl44v/xwidFzwqCqrLLLHSmKgzRpTuTgygxxobqltbt7NTe17wWGDjEEMIBVHsorvsFfIQLBU/dRtNyD/TnXQtrntOgtyN/o5H4IC0md9wU4qMrc6qb6QM8jninNk2oOa7v/k3C6B7aG2FmcQkBaUs2+PwBu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcOOD7pxrOjYuc+M/RUhfoMzYz3J2kuDp7WDQUE2p+k=;
 b=nBEzveQzqJIwPPn7EZbfnCCB5ZSU0T/ebwcrFq3lAXOKFV8muNpRjRWXr5AyXYo5a8Tee5wF17EJwnZ193UV3CSBbeM216hpobOKpsA8HugkRAud/zH2T2kZdFvbIJH8uj3fL3L6XCTkPbNVo0gCFI41hO36xSNzMSSgcLTVSMpVqlNLRT1edUA0thRUoXMRUUtGFCslTW67iiun0VAb7CJulwTDdG9araHK562pprUjgRYlTPBblc1mMGO9nJMsgyuD1PGjPquRLnZflWua+4M8eELOSjhPISJ2RUbqsXX0VXrli+U6koeQpNPCBusQMwE079Pzy7ZjDP/H0pxN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcOOD7pxrOjYuc+M/RUhfoMzYz3J2kuDp7WDQUE2p+k=;
 b=bjS+F7xsjwKeVhep9RBhdJ4Q+GwqWk4RUorbmx5LpHIoyR0YJe/o2maaHshRAAWrEriZlC4nG8jl8lEWqGsNDA2ym0UyD97HoDAsLp3NNyO/ipCU/AJxBt5RF1OUItHlr22Ug8QraLiqKimzRoP+uUT0w+PRCc2Wn76cpnK93qQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0401MB2319.eurprd04.prod.outlook.com (2603:10a6:800:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 09:15:03 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c%5]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 09:15:03 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm,
        robert.foss@linaro.org
Subject: [PATCH v5 3/5] dt-bindings: phy: Convert mixel,mipi-dsi-phy to json-schema
Date:   Thu, 25 Mar 2021 17:00:30 +0800
Message-Id: <1616662832-27048-4-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616662832-27048-1-git-send-email-victor.liu@nxp.com>
References: <1616662832-27048-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0164.apcprd02.prod.outlook.com (2603:1096:201:1f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 09:14:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 782185a1-bae8-4df3-84cd-08d8ef6e7936
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23193AE163F047DD3CEEB58098629@VI1PR0401MB2319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFKe3xcwBqCqmufdmQqck9Rm5vL6GrJal41WgW/5h4lCC+VNpUh9dZYSjm+kXYI0DTd6akZHyIL35vNhXo4GQNDAWLbysmQkkYPHxLrskTOBrjkwlnU1f8GQZUJ6hxPl79tgRuSgNhkxolMhM4CTcLuhSQEjW2CiTtQ1FPic7KG+rmSehvKo775ZzhtUP+DF/icGTcUdLjPXdcVAAZwsdTLXABBRuUFvn7gSn2d75t2e2c24eOTb6Y5ZSEUin+SZ0Xv3F7WvTSo2Zl3tbzjPnItuRx/BYfnm/djqA46T+3XPHxoQBbYrjaCC7atSU75w/S71+ri2qZGvnFC4MEEhBLuRb8fNOI54KBV4WhNpbOJr+KYTn7v2poYwCFg+PFOCaEWLOeFk8kTR/5TsyS9ecWFiPBznGcKwP0f9xT5dNv8wdeAHXKri2oN6uE0Asf2hxFT8aC0Ciq1CbIRGoMZb6hzs+dLXqbapuT0nZyV4s0Nii1gI6y5xFWhrcr7J4Qe0xcEEuGjZCyjktshC+wB2m6cSj3/00i4kVvzTVdIsseC6hQWnONpbs7dqVbPHonx1oyUewBFW0C78LRbG71z7nFjM85fk8PQPYx/b+uUxeKKjom6PXUkfSMh69+SliqFYP0JMAQ0SykT/p0IpPMjrQ6OiWdWljV+SjiIm4BosSHtrfC8a3DVvucu/TqqSIw+voI+6UK+ZR8bnetIhet0d1XIWGUFzeZ77DPzNvAijgbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6512007)(2906002)(7416002)(6666004)(5660300002)(6506007)(8936002)(6486002)(8676002)(966005)(66556008)(66476007)(4326008)(66946007)(2616005)(956004)(316002)(66574015)(38100700001)(16526019)(186003)(52116002)(83380400001)(478600001)(86362001)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUNpWjMvQnAxQ3c0NTI1MGhaKzAwaGpLcFRaS2xwRWNKV01YWGQ5cWU3L2Va?=
 =?utf-8?B?RjZqRnlZWkxWb0NQUkQzKy9iWEZsU3czcWpCa1pUdlRYMmZOTmtKWERtc05D?=
 =?utf-8?B?ZGpPVGVCNUJIMmxUblVwNG0zYTY4bTlXMDdnN1hvVVBkRXRuRTJqZ0JLQWZI?=
 =?utf-8?B?M0FrbHV2dkE2Z2I2SUxEMmtsTEhqZXdFMjdnRlowc2dROVZ4VE5kdk5QN1Zo?=
 =?utf-8?B?NHZydHVTd3ljMkNuNlZxcExSZ0JtM1c3dHV6SDhCNU4xN3VMKzMrQUpkQ0w2?=
 =?utf-8?B?RTBUWVc2YWd0Y1ZiNzV5TVluejV3NzlyYUwyb1g0cWlxak44MTRsWUlIZ0ZI?=
 =?utf-8?B?RllONkx3NzdBeG9xaUN2dHl3ai9MdDRLZmlIK3BBRUVXeFAxaSs2SVRSeDQw?=
 =?utf-8?B?UXZ1alQ0aGllZDhsTVVIRkN2MkM5TlBLckpNNkk3SXBrcHBnbEJxdkF0VWtO?=
 =?utf-8?B?QytVZkxoeUVFMDB2RVMrWXljQWZ2cTNHR2JLWkErcnpoSkRma2JBVG1RWlNh?=
 =?utf-8?B?ZnZ5Ri9meHlXWndCdTdHdWhseDRMZjBLM3pablFaV1VVTFFBZ2NsU1BQUU1Q?=
 =?utf-8?B?RUhqSjdmQW5zbG9JNFY0V3pQL3pEQmJEWjNYNC82T281MjdoMjdyR2FIa3ZD?=
 =?utf-8?B?NGR1cTdZbHRDZVdFMFFvSUgxeGdMbEdpaGhLS2xwWndWTDJMbm0wdEFLb1Z2?=
 =?utf-8?B?bXFUNTMwcFFyS092QklraGVUTlBndHlGV0ozNzhFOXBZTk83TG4xaDVWdTFa?=
 =?utf-8?B?eFRlWlJvRkIraE1IY0s1TzVxYkJKWUtqMmJoUXNsWGhEZC9KRkZ6SmtmSWts?=
 =?utf-8?B?Z3loK0RjSzZLUW9IamJJa1hIR1pCVnFVUFRIeFRxZzdUYW1GUXB4NG9PLzB3?=
 =?utf-8?B?YnZMWmRjQyt2V3hYZndtZDY1OEgrTW1zaTE0eDUwbGYxdDNYTVdoWVB2dDJp?=
 =?utf-8?B?elhmZTcrS2RWQ3djeHNLa2drV1ZDRWRPZ0xqSHJMcmJtekhBWXlrY0ZhakJ5?=
 =?utf-8?B?MlNKUmd5QTk3Y1pqbzNvcllBOC8rMXkyNUFxWTdkNnFraVlVUFNUemppYWxG?=
 =?utf-8?B?ci91akVUZzk1WnVFVXhROUhUQUw1cFpLemdhdlM1clkxdzB6UXZNUlRWajJP?=
 =?utf-8?B?V1pTTmNveUNrdTFYaEM1MFpFcEIxMFlDMWFvc29CMUdMSjlsUllDS1VsRW1a?=
 =?utf-8?B?WHpKUFFqajFCL1kxeXJSVHZYOFNVekxaKytqQk5uSFVFc29MY2JMZnZ1YVNE?=
 =?utf-8?B?OW9DdUUzdFlwRnNSRC9IUzdETVVWMys3NVJHTEgxWGNrdGs4UkxrN1UzRkt5?=
 =?utf-8?B?bXVFMW9OdXJDQ25yd0Z3ZXJaRVRlUkY0emJwc1haWGpuVWphaVNmaXd6VmZq?=
 =?utf-8?B?eTQ0NEk2VU14cGxJbEVrcHBMRmhETHZlVzZrTG1uYldkNzlqdkZOZkQwcTFY?=
 =?utf-8?B?ak1TOU9yM3ltSkVpSHZLTis0S0pJY1o5QmN5ZHVNUENDc3hXa2pleXc1cTVh?=
 =?utf-8?B?NnNIaGgvNm5rSzdrTEdDMWxRWDY0NEh3QVNVeGFLTVRONjF1MXpJNUxJcDVM?=
 =?utf-8?B?cEZMdWV1RGthbWxKZDUvVnE3UU1QL2w0MDNwZjNOVERDWXlxYS9PRmtGTjNy?=
 =?utf-8?B?NkRRSEp5NnpaWERvaHpFTGNySXJXZnBmcGxhVVNXS2dxdjIva3JvbTVlamxw?=
 =?utf-8?B?Qlh0UFEraVYwSHk1alpyVjhUenZGeGVIMjRkdHJwb1pMeG9BMVNqbzgzdnFE?=
 =?utf-8?Q?2EkzozXAPIazIggqPUH3UlmkyJ3P8vka6ed5nok?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782185a1-bae8-4df3-84cd-08d8ef6e7936
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 09:15:03.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3F0S9PuVgODFc5NcTMn3FYds8WC8VTDZaxGcQfGeMik++NAwuhfLi38CUawRokyHiytaVyPBXUJjrj0Cdv5O8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the mixel,mipi-dsi-phy binding to
DT schema format using json-schema.

Comparing to the plain text version, the new binding adds
the 'assigned-clocks', 'assigned-clock-parents' and
'assigned-clock-rates' properites, otherwise 'make dtbs_check'
would complain that there are mis-matches.  Also, the new
binding requires the 'power-domains' property since all potential
SoCs that embed this PHY would provide a power domain for it.
The example of the new binding takes reference to the latest
dphy node in imx8mq.dtsi.

Cc: Guido Günther <agx@sigxcpu.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4->v5:
* No change.

v3->v4:
* Add Rob's and Guido's R-b tags.

v2->v3:
* Improve the 'clock-names' property by dropping 'items:'.

v1->v2:
* Newly introduced in v2.  (Guido)

 .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 29 ---------
 .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 72 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
deleted file mode 100644
index 9b23407..00000000
--- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Mixel DSI PHY for i.MX8
-
-The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
-MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
-electrical signals for DSI.
-
-Required properties:
-- compatible: Must be:
-  - "fsl,imx8mq-mipi-dphy"
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names: Must contain the following entries:
-  - "phy_ref": phandle and specifier referring to the DPHY ref clock
-- reg: the register range of the PHY controller
-- #phy-cells: number of cells in PHY, as defined in
-  Documentation/devicetree/bindings/phy/phy-bindings.txt
-  this must be <0>
-
-Optional properties:
-- power-domains: phandle to power domain
-
-Example:
-	dphy: dphy@30a0030 {
-		compatible = "fsl,imx8mq-mipi-dphy";
-		clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
-		clock-names = "phy_ref";
-		reg = <0x30a00300 0x100>;
-		power-domains = <&pd_mipi0>;
-		#phy-cells = <0>;
-        };
diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
new file mode 100644
index 00000000..c34f2e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mixel,mipi-dsi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mixel DSI PHY for i.MX8
+
+maintainers:
+  - Guido Günther <agx@sigxcpu.org>
+
+description: |
+  The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
+  MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
+  electrical signals for DSI.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mq-mipi-dphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: phy_ref
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-parents
+  - assigned-clock-rates
+  - "#phy-cells"
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mq-clock.h>
+    dphy: dphy@30a0030 {
+        compatible = "fsl,imx8mq-mipi-dphy";
+        reg = <0x30a00300 0x100>;
+        clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+        clock-names = "phy_ref";
+        assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+        assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
+        assigned-clock-rates = <24000000>;
+        #phy-cells = <0>;
+        power-domains = <&pgc_mipi>;
+    };
-- 
2.7.4

