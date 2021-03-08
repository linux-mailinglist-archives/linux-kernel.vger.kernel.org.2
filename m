Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C263306CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 05:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhCHEGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 23:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhCHEGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 23:06:18 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBDDC06174A;
        Sun,  7 Mar 2021 20:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1qNoYLWSrmxjvZkvspkj52/giTsYCr0KBz8Hc37gMawvKdA/ZkT5zSIGU0rG/TKJMdWFOH5ZKzVj4D0H4vyjXMjqIPbnrTdz8s94mG2ICxJpS2Krco7VpkcTPZgdTSrBND0nB9nuNBKv7suURZQGnNWS4BSRu8GNwTS/yu4awE2q9NzW2AOtjSCHgWQwzf2Chtmbo9mGGWOeMGJ9Vk6z93/QLhPswpVW+iWlNCeWFfFm3tK+jy41Nfo2eZvqXr1VcrBq6i5CZ82XDh8euv0PsNxlkvSZ+oL5moFDC1irxF5GYYcdyVKvgEgrwPT58Xyi7LhhSfWlAWFSGxzC8LR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmm40p51s6caJ6CzKnCIXNbh+ZLkxm0me6fSvaEnsTE=;
 b=UmE7vU47tls5gmUZpv9JDBfYKoTbpT1kG5gKXEjOUTsyHysLfeDKLQTw1zGC1TkBsXdJuOQ41JSfe+OURWtHslNJXLg/W9nzoFO3KcEiVwVnjS+PU2fpTpJ2dsnVG3DV1PZ4/zwjvH3vbHhYvDkCrtrl0TcsK+kkIsq3IE/cWBaWICy4XyHEnhS2nVKbOc1aHY+tPWCoMfKTiDAyhMQo0uT3+uHJo1TARVaKZ8J6vtdUx18hQxjmIOVzH+1tfZtSxwGHpMJxNS48R2A583jP9ufw5IztjGxI4m4g4wTnWuVQlpe0QFtvlAgTvhc7flr5Eo4U9IOKviksW9sBGJFkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmm40p51s6caJ6CzKnCIXNbh+ZLkxm0me6fSvaEnsTE=;
 b=Iuf9m75L5gcq+FEj0KE5nbtd3zhCWM2/BbHTuB4UmoyZKwGSXOkteiciobUisKWGnAr5Nef4qO/xULwx+Zxv7fMsB6KxudnOH8YwEhbwrcHWeoTQfcYiOQZonE1gQeqCGT2fRDCeuphRdXN1/Aj4hcPXBEsFY9i9I9aJbJIoL9Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB3310.eurprd04.prod.outlook.com (2603:10a6:802:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Mon, 8 Mar
 2021 04:06:02 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 04:06:02 +0000
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
Subject: [PATCH v4 3/5] dt-bindings: phy: Convert mixel,mipi-dsi-phy to json-schema
Date:   Mon,  8 Mar 2021 11:52:19 +0800
Message-Id: <1615175541-29009-4-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
References: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0088.apcprd04.prod.outlook.com (2603:1096:202:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 04:05:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e58561e-8edf-4de5-07af-08d8e1e77cbc
X-MS-TrafficTypeDiagnostic: VI1PR04MB3310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB331071C299D7A850FF615F8498939@VI1PR04MB3310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8Wk3SQyrEx3LqZcphdxHCbeTx0/svDOa4x+m4qoHw/09T8wyRXGP5kyTUQAJx6g/FM6zy7YSsT+INJwB+m5971NgSWwfeOceUTgUS9i4N46uwwEIXIo+KPlPyHWdML1imUBaHPMC039+NXB8FEfPrGhjJ/U5HH9u26dbYliCluXegrUXg6VyP851mQtodmUpynkfH9sUM1CELEFGZbbBLJyfO7+cMY/OJpcei3d6gdBUlfJrWKehHCODaOw+ZBfHaYiKqH20fALvmgAnwBsIAWzjS6cn/ydfYvuDhtXYSzglRqUoeIYSFyDrBHeDpuvGWRNhSpVaE/ZPj/ECJT9QZWezytzlC1i4k0en7BYtCvydm+tW2h02irJOCKDeFw+P5lMHkNUuiJDJkT+pI3Oajs3KcFuKykN/7GQCLNFryxeAokInetdMgL4b/lr7cIfAbth6N3NvVeUKXOKDVLyVpRkQXgMSUllBm/izFIOGx2wHJphOKmAkvzcEnKzuYGT6/n6kYZoDswOYs4p9PEVyzQQ0PTQ42zS8RSNrSo6tdK3ObPrkKCtRum+RnTSz6Gciu+iqIed2iiC6c/mdXvVKRoPi/HjzI5PYswlSYRt6Fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66556008)(186003)(16526019)(478600001)(66946007)(2906002)(316002)(966005)(66476007)(26005)(5660300002)(52116002)(8936002)(6666004)(6486002)(36756003)(8676002)(6512007)(7416002)(4326008)(956004)(6506007)(83380400001)(2616005)(66574015)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmZQK1dLYW1RT0FVak1WV2V2ZklXUUhCSmsrY2NwL21yQ2RRZ0NHTHRrTmZT?=
 =?utf-8?B?N2pGbEhjMVFuZnlFTi9senU5bDA2KzN2R0NKY3UzOXdVdnBQalJ5VmJIV1Y0?=
 =?utf-8?B?cDdRaFhQNTVHVzFOTnkvYW1udlRWbThUcVJDV3hwWUNielFxZmljRnloR1hP?=
 =?utf-8?B?NS9sZ1A2SkFBQVJzcjN2WUNvMXpZVFB2ZEhBVnRpMU9IZ3VpV3R1WGh0dWg4?=
 =?utf-8?B?UitCT1NpOWZoMGVJRTFMV0g1RDZZOFRKUjA0eng1cDZiVFhSS2NEcm9ERnVt?=
 =?utf-8?B?cGlhV2xaQzNZbVhpb2VSVEVDMTdmU2o2SG9VaU9jaU5XQ0lGOHMrdXhacWRE?=
 =?utf-8?B?TlhZU1FGTkF4ckVZT0oxWndFWG85dGhzc21NVktiY2wzMVBIRE9LUnBUcWdn?=
 =?utf-8?B?aGw2VittbUVpQmZsMTl6QWNQQVY4emxuRGFWVlh1QnJjVXh4R0pYQTlNN0Z0?=
 =?utf-8?B?UXhnQWlhKzJYMjRvbXhNZ1o2VzE5cWJhbWxyOVdydy9Lc2I3a1Fqamx3NWpv?=
 =?utf-8?B?azhjWE1ZRTRCTkYyeWt0ajdTWVFqak5QQ1VGa3ZpbThYN0F5SXBQbE12NC9K?=
 =?utf-8?B?RHk4Mktpblg5TTMyQlEvQWJaaVBMMXI4cU83a01pMHk3ai9xUjFzOHJablYw?=
 =?utf-8?B?RGVZTldGY2haTnpwVVZrOGlWTjFUWlZLaTNxYmtGNHdWZ2lmN0Q5aUdLcTdm?=
 =?utf-8?B?V1JwZXYrQmFRRXR3dzdRRld4WDBqSGpyQW9ZYTBnY3hWaC9NdWo0bEhqcEtm?=
 =?utf-8?B?THFjR0ttY0ltUUJPYjBscnJqYkxXNWV1aGtCMllwTmhVeWpkV1ZmNGhUY2Zw?=
 =?utf-8?B?dzA4dW1OcVpmczZwV2I1VUlhV01TTW41cTJkTmllc25zb25qbU5EcVRxbkRH?=
 =?utf-8?B?VUNCbUpMTytoNW1KRnd1THg4MHNnWjRzVS9zR2hSTWY1d2cyMTg1Z0pzRmU1?=
 =?utf-8?B?bzRQc2QyVHBmK3JoQlZ2OEpyMGxNaW1RRUNOdHV1MU1yRTl5SmpGVWduZWpt?=
 =?utf-8?B?SUFFZWQ2T0lnd28vMGVTYUd2SnNweG5JYVpYQkxRLzlEMHljemVFRHVRK0NL?=
 =?utf-8?B?anhzTmpOejhQZnNUM1FQZmdnak1BR3pWaHluNHlyL1pLdC9icFJMcTFHaWJ1?=
 =?utf-8?B?ZnVwb0IrUXA4SUVHcFFNa3NjcVVKUFVEdW9OTzdiaUk1VmxhRGJPb1Y4SjBJ?=
 =?utf-8?B?dkZRQmZPZTluYjAzaXJlclNCenU5bldDbit2QjVMRjc1U3pLU0JEdHhaOVpp?=
 =?utf-8?B?M3BtcmY2VVNSWWk5THJNb1A0TlU0aXNsZlhCdngwQ3haR3N6TWNGWVlOUWNN?=
 =?utf-8?B?d3lFNFI2VXdwYkdEa2k1Y2grUUtOY25ZczN5RmRGMDZWa0VLN3Zacnp3R2Qz?=
 =?utf-8?B?MUR4NjVydHduLzJQSGM5WFFkQ0I4V3hueHhUVTNHbW5jWjBFeXFCUmhmZUtz?=
 =?utf-8?B?dWV0K21WVUlOQUV3ekFjRFJibmQxbXRTMUtsSWppRjZ3L0tiSUNXUFpoeUE2?=
 =?utf-8?B?WjNiYlkrS2pxbmFSWWlvK0V5ZmtxUjFacEFoT29QdG1JK0Ewb2prWUhEcUh6?=
 =?utf-8?B?S1dPTGVZOUJRa0RWNEZDS0hLUExnRU4zMjY5dnhDT29xKzhFcEJSU1h4S2Q0?=
 =?utf-8?B?T1Z6RDRYS2h2UFdvUnRyMG9WMHhPOVNJSHNaTnVaSldYdGJ6NWF1NDVSTjJ6?=
 =?utf-8?B?ODFvU0l0UEhPM2JpZmJUYk9oL0dqZmhXdjFhdVRDdTdsaERKZ3dhRDBqMnRP?=
 =?utf-8?Q?od2TzcDptamPTCtpHK4WGyC2uPKjPKXPNhACzM8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e58561e-8edf-4de5-07af-08d8e1e77cbc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 04:06:02.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vR0QbPlmKaOzLcz2YT3FEr8S1EWHLbPUOtUTlqgdw/37DvjfBOgRZ3/CzKjEiuzRz5ZhM65wJ/eEWUY3t2AKMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3310
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

