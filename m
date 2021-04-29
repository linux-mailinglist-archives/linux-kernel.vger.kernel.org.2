Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB136E56B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhD2HC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:29 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:22887
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239564AbhD2HC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvdBXaqp9dDv+J3CJzR34GQakeA/WgnUwqv+D8DMEcYnNKk2q+3e3GDCTx1V+RGYffHG3ngxI254QCrOiYP5bR7nSayxNct24uuivWQM4kfdW3Cfn6ntLVBcVSTK5Tulkj/luKjGztw/3R+P4RJByHZWx9/oXLVYxonm2wpYgE+yy9Q7pEVtQzP34yKLQJu/ECZ+9oK9K5BM8oPFaIv4j/krtY6ry+QwwpYcI3DCiIHuFQVpC7eIpRoVz7u86ckhcw+t9qxmfGzmijxkOrbiOMJY7F2bd0kI0IqewDGU6nSvcbgWjCIBH/jOMxg/JM9KSJM5XNBqo6SwMmm9Ftgo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9dCdVio7Wn3zOEXiXm/kW3gmGUiXo2aSwgj2ZLgpLg=;
 b=P8gNj1BF9v6oRmyokiRDd/9SD3l6Blln+3pIPNbdM3HYlOVj9AirZmZ5rkxymRwNaN1JezxwrcOWl6nCMNQUo5AGiiGdbfQrZ4cCzhwkmMouFv+E+Cq5Zy9p4pqWuyjMrMEh5s5PKYQxFbr5C4qbyqO5r6jrFn+4FSWBJtNU8U5c5bQy0ShBTN1u4K5O6VFnBFC3jU40+z6/woFwFeqoRIHgc0ofX2Za/BXWwG7hyP4b9S4ZYE14bKdenxxVYEj09fJhLT7ed9lW2eA6xnGzDrBQWe8e9cpyzoBD7UsMZJE1sEZPm5+0g56FhiM546T0BdBGDNVZgkOJ0eP7okcb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9dCdVio7Wn3zOEXiXm/kW3gmGUiXo2aSwgj2ZLgpLg=;
 b=Ss6H40JLFToAnVOvsCvpKXZMW0hpqShuU27uUsoq3AN5RJ0kxZykZK6J1vIwqNz35FpyXtOFwQDCJB4S7tTWVC9AO5n0AGMMaQJ6dVH3QeBWyNC8YZgp5KRLwI6PREhNjzvkFBGRitKbx9NMYKSjcRH3N5BJjm2Me8Lhk/Vx9mk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 07:01:39 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:01:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
Date:   Thu, 29 Apr 2021 15:33:29 +0800
Message-Id: <20210429073331.21204-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073331.21204-1-peng.fan@oss.nxp.com>
References: <20210429073331.21204-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Thu, 29 Apr 2021 07:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5aac3f2-2cf5-4d8a-47d1-08d90adca328
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB793001F67F5CAAF529665E59C95F9@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmN0EQNaTKJu7nmLn3qhz6W16y3fhv9N2wri1qYbT8qDK6mVV+lBFPDPz7mPY7thfIbuXDme67CwXov76KDPKZbmrj94EtLxh+JESMNtwp2ziyDk0RQ452kudoG4SWZCPaqxY1fDdpC2E64BvSWevt0P8CjMRCPSOx2UDKkQLR5p9QLLel9hRrMcvD7KrZ6G4VMj1+AyUZwNZbEayDU1bfGdJocsyJeN3QLazOC+5muAN65mLHthD/vC1p+JkJ9ByjchHZCr70hjNGwAHW9YmMmVabcResnKmSaJyF6VwvghhvoNtopqKXa5XK+1h707KATBmZ51he6f4l1ZgzoFCN9q5o6fW7D8b5HXI4JjWe6tPRtXCetZDZAbm+WWwIaeJ3zVDRzUp9WpP+nfjKYMet3bISmb0ehjIRrJx40tLwGn+q/YHkCIFdY8+W4Mmr2Y3mTqHeu1pta0FWu5DX3C+VB1TahXLCCZixoKdfJpvmfBpDb1XoqGJbXLX/APIouFcRlHWnb3GVhWxMyz7vqgI1CdMUozlZ98HPmsH8DvYmgmutyQcIMefka2bC0vOzHWVV8ppTHruREj2nX96mhlBMlkUS7QlGONDC3gRCKHbrlSmxm8Z948IdaEc+gMhDzEfZ6HooCBwQx12EejRpY0kmGsQjdSH3Ut3b/jr0kEPcEjCgbYmYF5GRWVYbqL1KYbHBiiOIiulTBYevWRD4sN4uMQggAHwHpQc+QRiZdl3Mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(2906002)(7416002)(26005)(52116002)(5660300002)(8676002)(66556008)(966005)(478600001)(66476007)(16526019)(186003)(316002)(6486002)(38350700002)(6506007)(2616005)(38100700002)(1076003)(83380400001)(86362001)(4326008)(956004)(66946007)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kJLzpNFzuh9bPppR0fgf89RD4bxqxMzOTqGQu3DYFfe72ib8GA8HLFyJz4at?=
 =?us-ascii?Q?TbVKXDhJlwOWQu/mY2WA8Hpyc/2skWW2/Cv1/Wrqwho2JoNxPTiBBMuJrLkA?=
 =?us-ascii?Q?hTjoT/Zm1/C4aG8koyBlgrYq8fBhpiWdx4RQXKBTo38BicF8AzJUf6RWUNl9?=
 =?us-ascii?Q?7W5fl5ac5JWU9G1C+TGp4gYZcjY5lOEV4lSnVP9AlQ+BAVy32RbGRmhR9Z0N?=
 =?us-ascii?Q?hQSHCungSHxgolXrVCDpwIRA66BTOMX7VGjAATNIe/V/yO1fcwh7XyZKZG9d?=
 =?us-ascii?Q?cMqHBWPi6HWOYdHOOCzhsFP06iYgn22vXPMHt7Y+wy60RWT9x0PLyQIW9IeM?=
 =?us-ascii?Q?A0dDyw8gX/affva7AH1wj3RUnb/EYSmeAYKtYoIFFfTYPNwEbZ/BTWDYm9RP?=
 =?us-ascii?Q?1kFmnbP67vVAXyu1FAWFPrOggRyfov2+Ub+cQC8XWvXXorQktEdTM3IDNfbn?=
 =?us-ascii?Q?STXKzv90lgGZzc/HM8iLIC6azaSzJ4owqg3zzGxQovr3OZbA9j00nXDpZdQj?=
 =?us-ascii?Q?S9FUgZRqSncv2/yFkrr9OdpnLPqxCtKQkT8pZZSmSCWhVba8tSfuAc4aq/Ss?=
 =?us-ascii?Q?2zAPNv4/u5YkkU8047PonAxFx20oPvI65NPGIJQGrdE+WRh7ZUOLvwrEbXFk?=
 =?us-ascii?Q?i++4h4wuNMNQEfaAeFJAkzStb80ILbO8WftkwXaBR457gmBXsUMyPca7l3GD?=
 =?us-ascii?Q?Izw5/MG1v+0OnfhZ+IKhCLm1sFhNqE+APw458LIQ2zXjNXi2FN15HaYaXXwL?=
 =?us-ascii?Q?Hzv9SWCGpm7U8a0Yh8u337BDz1EqTL+RaCeaOvYUf3LEzFaVTwi+iz4RnTtL?=
 =?us-ascii?Q?eGNwxyUIoJbH3boqgn2P4HMu+ZlseL5FKUcetrH+H817SgrvzAks5PJOsPjL?=
 =?us-ascii?Q?Q1f27CiHHb65q4MZ+IeOJohVou1RICK1XZH6oNywWrmAoAC9TVbJxkbKxXwR?=
 =?us-ascii?Q?zTvTHq0uc3dHoFGWKW3lsa2obfkwzOgdOs5zyDReqP/92ItISMLcawUWXUa7?=
 =?us-ascii?Q?hpX4/IwP6VWTVnPaIMWVoD1Ir37O0N8fW/Kz4Yxn5wkBjrJmaA6tKL5f7/Wo?=
 =?us-ascii?Q?njAmWNOZaSPzfgyAQDPOVU5I6V1rdQHssS5yaYsNC/aJaT8rvqkiSc8fHUsl?=
 =?us-ascii?Q?UbmfLQQQIb0W2l6r1vGtod4pdEZ5fMDaJrRT3zA52NIBTrxrS1SyHvgDSNaN?=
 =?us-ascii?Q?NROFEl7FcSjFVU1AUiSbIft4kaORU0dvyWvpib6EULjsHtxQFitXTAMV/VIu?=
 =?us-ascii?Q?EdYoCKEjVVB5G7baiF3+dYMTJJgqkT4WqihT31rcdaWzifxX5yJ8ZmHBxGcV?=
 =?us-ascii?Q?Qe2pd73x6u6apwLL7rkEVs5D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aac3f2-2cf5-4d8a-47d1-08d90adca328
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:01:39.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apLQ0l/i/jLKJKCx62fCFg7OlvSL4ShNAVd2VexfadjvMTumR5RP+WlUcWsQh3TmRI2minOpYQwJfezCSh1qCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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
index 000000000000..8160ce51a8fa
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
+          - fsl,imx8mm-vpumix-blk-ctl
+          - fsl,imx8mp-dispmix-blk-ctl
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

