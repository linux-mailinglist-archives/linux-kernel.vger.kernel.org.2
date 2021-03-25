Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997D3348C87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCYJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:15:51 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:47950
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229798AbhCYJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:15:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX7N4C5gY5Tf7PYRT/22+HfxomOCjCJrJsyfaKqCMc3RqPdxr7UglHQKzQZhw3O8POYjoIlDiBD1xpfJCUNqxngQkKdCtR091vdrFMrdODTCTgInqcAqcAbUuOQakdujWo36FpAINNb9yp4HqeWLQc7zpvajlLJ6ps0AdV3eTwBHG6AbxzaOUD4uiXsASLwvhUnWkpeQrB2SivRO9fi7zdVd1ysFtWiVXgM3UIarzeD76ea+La4ZTI7Uf1QrtuXWbXdle63dyEYUlG0u/0JBOPSRtSVHfmYSO9X3TnRyANpWozGq9aOOTwtEXsjs/mXozKd6AYqO0QLZqBBjKTqiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr/uF2iXS9aWp/jFdyDIBNhVXMclWcQdbe77/wctmHY=;
 b=XFRCE702jDFI9BBhufQUg6ubl72LG2MIKuE86nYdFB2R/v6Kj7cKdq7RVxtwJFkgEqANSKistg0c+5Lp8yklFnl926ta/iC35z6JfNtN0RTrxzWjMZScLBfmuK1I40HJi6nRYzCrxdovrmQvOMyGRupI4P9Og4EgMCvkl+yKVG3RwKHZBEp+Zb8++1lJSti4QeYHQKmKMElb7S1LWwDyxLaGCAwi6R1UpMoFDb5tbBeNIRRVqDFHLdmvo5lOSJBd2IKn4TxLNIF+NkOCShcu0BKsVSL0yyiCJ0/16hCB1zjxcmmCOhZZvSASE1zfO56ngU+XHSrU51TarzhOglB9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr/uF2iXS9aWp/jFdyDIBNhVXMclWcQdbe77/wctmHY=;
 b=YB8Sxyhu8Oz22Wd1VD3IDNhNRK0i0SuQQAI7RlfXHeRcogaTD6sn071FP4/HtT12i603zxKKev2QHs2AHozw9zu2qx9F73KWQLpgE888IHnLF+z/Co82gjfdD7++6zab14wsOuv/9R69FtBnRn2GrI95w2w1wMsgLx1k0wLoG1I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0401MB2319.eurprd04.prod.outlook.com (2603:10a6:800:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 09:15:10 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::3ce1:4759:5c33:514c%5]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 09:15:10 +0000
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
Subject: [PATCH v5 4/5] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel combo PHY support for i.MX8qxp
Date:   Thu, 25 Mar 2021 17:00:31 +0800
Message-Id: <1616662832-27048-5-git-send-email-victor.liu@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0164.apcprd02.prod.outlook.com (2603:1096:201:1f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 09:15:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eebb464a-f4d7-4c57-a5b7-08d8ef6e7d60
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB231914729A909E9F1DC729C998629@VI1PR0401MB2319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfR5pgo/JrmjgmcihzYlgx3x3iukDXlo6HZKEtaibw+W3gTiK8LRnEWrDPlooNVbxVurcu8k54HkvCzzNiIlFfzBkc15C3zE36DjJu4GgTyfQnrPvQBGSCXzxwJzbg/iEw5ZT55CH78t5ZmCj9S6WoDBaT5kJRGTIfoQWFEhKwQSvgA3m/rf8BuYMliThDNf1JcKhVplctQxo4Zd2ohRc2uqiGq3XkNJ0pGAPn+ZdLUbK6D6YQbGnFAsoSMEykxeIqwF0P46D7eBAszKNMtvJYxv1+8TOyK2BPCDjqVWcJlPXZbtexu8uINzfu7mw4c7F+FR/4QjfkNrPESNA1Xv1ooh7o+cm3b9M42nNfjqXdvVzZ8kRe1TpFgJxdL2fJXf94WowOt2Tup1vtggjY/B74o037e/Cj4t5G2EWXaI5ehJAJUuOfvuSoPhW/30lsGhkKwXbPMRT7YwyB3vWlNH6CVzwUdFJuz4ZXtN9/VvEK6xOYhftL3T3Xgod01DK1oIpuT/gNqCaS/1yHUSV0lm6/SJLNXrSilSFZBCRjjJ5lcpic4k4KRIC55xbsATbXwMSwQajcqumxcKWAzQNjdAs4j8jy/UZK29p2Pn6SS2rK00FjT9kWfIsHs3Uo+pA4xgiNqJn5nJvIffvFedl/5Yrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6512007)(2906002)(7416002)(6666004)(5660300002)(6506007)(8936002)(6486002)(8676002)(66556008)(66476007)(4326008)(66946007)(2616005)(956004)(316002)(38100700001)(16526019)(186003)(52116002)(83380400001)(478600001)(86362001)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGtxS2w0L3B2cDdWK0JBYXhycTA3UlVwSE1GSktKM0tNY3FBMGZjQXByRGFZ?=
 =?utf-8?B?NXlOTFh0ck9xb1A5eW9aSWptSm5tUzhZRmVxQnc5TWZYaTdUR3ZZdVAzNTJ1?=
 =?utf-8?B?QzR5byt5WHFvdVR6QnpXY3FnWVloUEMyWXRmUGRwdHZZNGRtMHRMOHNQWTNk?=
 =?utf-8?B?ZGc3ZEU2Y0Q5MjFsUFJtQ25qSWxVc295VmZ5aDB3cEpYMXRvcEJnTnhiWmJa?=
 =?utf-8?B?bUgrZnpycGlINm90R205MkI4eU9zZktuays4Vk42M3FmYjBKcmtZd3JFRXdi?=
 =?utf-8?B?aVJ3alc5TzhORW1PY2pLUU81QVJtdWRZTzU4KzlaOWk4UWR4R21CSTBaQUZ2?=
 =?utf-8?B?UG9IUWRVVGd4RENNTE5Ja2UzbmFtZ3hwWDJORWVsZ0RXajNTZ0JXRDR5RG9Q?=
 =?utf-8?B?WHQydWdTU1RHZGxqN1VtQ0JPa3pYcUxSWm5OdkpTTHZ5OXVhUnZNT1ovcXdC?=
 =?utf-8?B?V21RS1hPUS84c216bnVOMnl5TWdQbTRPeW03MGdzQnI1TnZKejRDdTJScGp6?=
 =?utf-8?B?eFBUbUVDUjRudEc4c1dwUVBMQldWNnhtWGl0Y0VYbVhEVjlZMk4wSHZ4UE01?=
 =?utf-8?B?VDRxVDVpejE2U2tqREwrNmtCY0lDV000T2lLL2h1T2ZMNG9DS3lCMUhJdkhk?=
 =?utf-8?B?d0ZmTmIxa1FMYnFTR1lLMXkycCtHVDF1dGVpVklzclRiTEFScFk1UEFvemdw?=
 =?utf-8?B?UHRNZDJEUzN0TG4vTWUrZFFtbldoeFhWdHcyUWUxYk16dm5uMGRNM3l6Vk55?=
 =?utf-8?B?Z2cveEpFRHExcTRsMzlmbjludG9qbnJjbkJTTFhCQXMxc0loK3k3VEl5anN6?=
 =?utf-8?B?MTZvYXI4MkJKMHphdnZpTWdIQ3I5L0xzMm5WUWhpOHEycFRpMDVOVk5vbmNQ?=
 =?utf-8?B?cm1ZWEVEaHdqQ0swaUhxdDl5SlU4d2l1UmlVVWlJa2UrU1FVU0JpZThRd240?=
 =?utf-8?B?Ui9lR3IxR0hEeDVCc0dmZWVUajFOVUhZaXVzMmNKSituR0hwdVE1VFkrc0Nn?=
 =?utf-8?B?UVhscFZhZ05RMjN4UEV5eHhXRE0rdTlvS0ZpTUFyNVpCYWx3MmhNbkVqL0R1?=
 =?utf-8?B?OUVReWR6MEMrdnJGbWVwNEFxc0pIdmtxODJQVFgvZC8vVXRtUktmeHk3Nmxk?=
 =?utf-8?B?V2ErS1l1a2xVYzRzZ1F4R05nTXdIZ09FWVlLOXBpY0IyK2RGS0xoSTErN1hV?=
 =?utf-8?B?RDVnc0JiNnp1eVlIcWVXOWg3eUhiWndZWVNHcDRsQXBINHlvejJOZzBPczQy?=
 =?utf-8?B?d0lsakVXcmk4Qi9VMWVlbnZjWFUzV0o0VWpoK0RHSWpERUJ5S0NkQ0t4bjR2?=
 =?utf-8?B?cUFXR0p0L3BPYlNZUnlaTlZRRUMwSmdvMkJ5MU9ad3hTcWRGRVdIUm9xcVIy?=
 =?utf-8?B?SnlTbzljSTZWTC90YmRLbkZjOXZrL3JGaEMzNjVkV1ZnVk9EUGsrWFZWWU5X?=
 =?utf-8?B?eFRSU0pBbS9WaDdHUXpJMnIxVU9TRm9tNGFPejRCRlYzVjJObU5yVjBiVmxl?=
 =?utf-8?B?Ty9PY2NxMEh0ZlRzVTQzd0thSXUvVDhWb056Q0YyWEpGRFp4ZEZsK2x3Umk1?=
 =?utf-8?B?KzVxQTVnQlVLcUtqcjZCSFIxamIreFUvaTlEMHR0MmtiRS9OOG9sbnhCcE1I?=
 =?utf-8?B?TmcwSVh5TkdESmdDWVpvVGRSRnB1Y21XYlFMc04zb2NDcXkrbEVJbDN0bE5s?=
 =?utf-8?B?VDNjdWt1L2V0bWhoaGduSkdCRy9VNlVGV0tvVWo2ODMwSklkRnZxYm4vRUhB?=
 =?utf-8?Q?5tm/HVOB5Ehcw3Od3ZMyu2FSKpJDTwQRH6nnF87?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebb464a-f4d7-4c57-a5b7-08d8ef6e7d60
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 09:15:10.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MlvpWQKsqhSCFLeAF8X7nfM3Ml/fQWhN0/8sPL7kBN8JUvub0Up3YCnazfOwdkW+/1V5KsZbZ2paSiZ5l62sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Mixel MIPI DPHY + LVDS PHY combo IP
as found on Freescale i.MX8qxp SoC.

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
* No change.

v1->v2:
* Add the binding for i.MX8qxp Mixel combo PHY based on the converted binding.
  (Guido)

 .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 41 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
index c34f2e6..786cfd7 100644
--- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
@@ -14,10 +14,14 @@ description: |
   MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
   electrical signals for DSI.
 
+  The Mixel PHY IP block found on i.MX8qxp is a combo PHY that can work
+  in either MIPI-DSI PHY mode or LVDS PHY mode.
+
 properties:
   compatible:
     enum:
       - fsl,imx8mq-mipi-dphy
+      - fsl,imx8qxp-mipi-dphy
 
   reg:
     maxItems: 1
@@ -40,6 +44,11 @@ properties:
   "#phy-cells":
     const: 0
 
+  fsl,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      A phandle which points to Control and Status Registers(CSR) module.
+
   power-domains:
     maxItems: 1
 
@@ -48,12 +57,38 @@ required:
   - reg
   - clocks
   - clock-names
-  - assigned-clocks
-  - assigned-clock-parents
-  - assigned-clock-rates
   - "#phy-cells"
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mq-mipi-dphy
+    then:
+      properties:
+        fsl,syscon: false
+
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
+        - assigned-clock-rates
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-mipi-dphy
+    then:
+      properties:
+        assigned-clocks: false
+        assigned-clock-parents: false
+        assigned-clock-rates: false
+
+      required:
+        - fsl,syscon
+
 additionalProperties: false
 
 examples:
-- 
2.7.4

