Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84EE38D5F1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhEVNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 09:11:56 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:11590
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231191AbhEVNLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 09:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWj+8J7L+Mi9Tsz+OJmNl4m5BAhKCz5WJl1ARdbzTHyyvGRAAybswtic+2nT4Pu1IHFXQFPMQ+WrEt8GSxZPd+hOliQC2dB9KCwsrDnO0mbKk1PurbLw/Q+V05FVCXEXENcII6nhFRt02OFIa5ZERQ59HOOr2toXOQxDHN5xKIdRlE0JyfMHQdP1+hHNGK28dKWk9q9KynVLExi1aY6N1oKb1kXHhnUix0/TG00pRhKfONbIttaHyDJFcW3HPfHai9G2h/OTq30YCD/AmPnatOtKGg3og9rTc2dDf5iVXQQ86wYq0Fxp0l0+u0szWiBswtxl0cAVASHdRDABwEyyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=coDMGa46dVpkH1NclrBIt8sOAU8pyGelISIlyE+tI1W3WwtznLWpXR5Odp4WeL3nP7c9KWCjxe1qpGmDzV/cJ+CeO5uVQLFy4z87gox2T133ZjSX7aY/6TMxJacg8rh0ODGz48/uMcdFj9SGHpd+BFEO5aYny8nDJSBLpo3NqdL+I6MJWdSDBrHZyLesz/oAK1MSI5P5D4Wn5bLT4OZEMQNxMJnB5WvPcwteu46sjLgdh5Bjp7NzsGQqDjlWS34NKx24+33o5fdPkfPELHSXuALr4lRdxLIxvil589RmXpSQg0lSU6ADprUsx8rpbUNwCJ6BEoO92u1tlU+lAKhpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=ZD8x7nSCRXVK+tHXeKiHE2ncIIzZFsdfTnsomqO5ShMzV+acY72jBcMBtLvh+oRpx8FlegDCYa5exCuNdigdxxW29cfRbnVCaJ5PCmxN0KnO7f5BDHlUNex4eOXCTfAAOKIjNo8Grfcx5TIBLZ14a57b6ClWaqmAmKfFopMRDpU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5658.eurprd04.prod.outlook.com (2603:10a6:10:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Sat, 22 May
 2021 13:10:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Sat, 22 May 2021
 13:10:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 2/4] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
Date:   Sat, 22 May 2021 21:42:47 +0800
Message-Id: <20210522134249.15322-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210522134249.15322-1-peng.fan@oss.nxp.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Sat, 22 May 2021 13:10:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 510ea44f-1763-4375-7326-08d91d22f5e1
X-MS-TrafficTypeDiagnostic: DB8PR04MB5658:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5658769D4A391187E44A159BC9289@DB8PR04MB5658.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzAZgGVLPayoLYqsh6uInoPWT1aR2UGKn67azRjqtftfVk4csrvL6Y895MbSWFp1uSjmTYW+HY+y+RJdrn8BNufa2urZSAxx+XJTAaL1HbVKkoDDo3pCVMx/FMvVhHQufO2L2ggIbufmV4YtL1zbyDtEK97mw4q15PdCaAMuKo9Yj5SFBtBm9MtIzK5T3vRduA76hglAcSb2hY2VjecuayqFHAaqqNvblBrPHscm55Ol0yiwrXdhLSDPHRHHCvZ9ug/xIRb+JxCtjWz44wRal/lYVw5LjM/IGZq5kNiHoVtSfUVrkeZG6Ng4PMIzcAmkOkS5+OqsJpCfmwhEBn01zaHgi4znwZvmbgKfY/qAenFHiEJKtQ/h7BZ5Pz67HyX7x43EeG8Ib26VP1gvucTMClYHtdcB8jk/lVDZ8pRayzOLp4YnHq7EH1d7iJkkC083Np3jNn5I1VSxhkOQ9ylw3zlQVsOuI5f5w1Kis7ZdXEa7tZRuxkFxR87TB+rAMVoJKqHhdhTre0FNNbl847C91eXhhPilMvQxQAGmuZfYadcyFPn/iFyvL4wC2s/PpHpIA23W1MQOiVBikk+EJbJkDULYmlyH5lM7xXYrFNVXKa31k8rn3OQ1u2rapBy09N3L78NhEVZpN29yCQL1S8VnGXvHdXHE6EVORgN3SgE2V00DzAVk2sTcGcwxPY1IEJ7sKwS2ONiJRXEV7knP4K6EZ0A0QqNBivH7IQh4vNccdyrC6Ew1Av2cVrvDfeGm5tMhbeiak7LbmWes6IOzzPG8Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6506007)(66946007)(16526019)(66476007)(66556008)(186003)(4326008)(8936002)(26005)(52116002)(966005)(6512007)(38350700002)(38100700002)(83380400001)(5660300002)(478600001)(1076003)(8676002)(956004)(2616005)(54906003)(316002)(86362001)(2906002)(6486002)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oQhoahm4MXLxDJiyzIXojcMpvOQe9HcsocPonkNJSDDyMmwewP4Y8DbiPV2t?=
 =?us-ascii?Q?YT9Ra7ucPLpi1k+YcsATC2vK8f+WnqcZIytHHbMPWU4VTpUeVr4cEM+f+x53?=
 =?us-ascii?Q?qGBL2DC2ddYTGyIYC3pYWAQFx0O5sQjWRRweHkiRprnM16/pJVUIPw2WLuaA?=
 =?us-ascii?Q?iIOF9q1MGS2CpR4OTY14T2W75wzpbtqi3OIbBzv5l3c2KAsd/GWXpJbqWrjg?=
 =?us-ascii?Q?Igf2slBADaof0WXDNeHO9QO15GGWtcqi66oUZdKQySvB6+KVTBo6DKrVobxR?=
 =?us-ascii?Q?N+e06ygPGTrfdfs+EzU4THFjZ5kJzGkx2A5RB51dpN/G0+BXNl+1W1GMrVwM?=
 =?us-ascii?Q?GyjlbvKELpRkcnMovo6alIdzeceCVNY+7tnmumoxHf4w/kcdZKjvAC5sFm5n?=
 =?us-ascii?Q?KHInIYcsCShCDxicfrtaaTV/JRzEWey6Z+zGMHIXKrxVV54b7bQayPPTOTCd?=
 =?us-ascii?Q?sQJZrhY+FbqR5TSVEdKvg8NassaazYRtxAme74ssMFEmtzj0xA2Bhsi/6VyH?=
 =?us-ascii?Q?ZRc1KBYCvODVntIjqNjLM6A0KaPkvH7HWYn+zwYG6LOh28jpMoOZK4y3mZAI?=
 =?us-ascii?Q?lCTne/FlM/6s1Ba/VoOyiJFZkr3Wo1k41yOTIGBd8LXdL2y4r7ayZxB//xC8?=
 =?us-ascii?Q?jXYpk+f9P8CpuWDR3LXjtDbFRXSV+S99GrmjdFF5NandHKE+PSSsSHh6QtZm?=
 =?us-ascii?Q?muMhCuR2SqceKqvTeUu2utfRFnthb3SlgcMhcK5Iu3UQ5Cb0NKiheIRyhL4I?=
 =?us-ascii?Q?DvEOxideBFxp4Wr8liQkiP36Ad+QUYmRJtzxCY6/wHyY9zKMHOkScxHEDxcF?=
 =?us-ascii?Q?25v7LHZYgdSt4q/j84Xuy3ZiShiJeR1B508h2Jia6p/+iD2tsZD1aR+zm4OX?=
 =?us-ascii?Q?iSiwK0wmCnmHOltQA24dZx48vYP7IKfm7OKIwUp+mn9RvQyKIQzU2ZjbtZuz?=
 =?us-ascii?Q?n8rpBS6VWSnjRfTE5HF8toUhLv9CUhXi48R7RfdZUC/lcXnD3GTMBz/elYxQ?=
 =?us-ascii?Q?vZ6OWUOvTfVxki466OoZQh2uteTs0t6SE2FE5htKXr5cBrC7xjLeqmOwdwCa?=
 =?us-ascii?Q?4/kIhA++YwaVlYEn8lzKu0eAn4DxaB0aBTrA2Y7+2gEmz24hcp3OdVhIZGmw?=
 =?us-ascii?Q?SLurXnliM+SfA3IVBP0L7q/bGTHF7BU10fVTaN3Cprnw/33sHD8KhgMFei1X?=
 =?us-ascii?Q?u/4uHCR16+rhOk0Yv+oDil7V07VluCuCYK2775qrb9ZMijywRMV5aB6N07w3?=
 =?us-ascii?Q?7ereF9W6imvEGLiV0SK3VGE+h5HHqKTFW+HyUoBbUvJrvz2jEKXJg4NoEOoo?=
 =?us-ascii?Q?JR8v3nQjIcoOEDtGryuPBDZN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ea44f-1763-4375-7326-08d91d22f5e1
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 13:10:24.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERzITLCYegPXKmt5qodDyKaoOuAirqA8RaEr+E6wH1ZeBTtz2z/ZHlU4L4Uigkm9hy191CcT0v78lmSENqMSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5658
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

