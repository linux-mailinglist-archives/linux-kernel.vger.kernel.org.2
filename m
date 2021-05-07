Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA037630C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhEGJsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:48:31 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:28032
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236425AbhEGJsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:48:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Panv9+GAN0aDVcQkSTFLWq28lBeoIFOAwfUaGaJES6T2OgP9lSbCXPInMBl0En1H9pHndsxpdUwEcDaOaCSLlw0xWC+mYD3nU0Xk6P9YHmgJvFViBV2IHnhQ6Dl3jFvOLy+olBuD0Eyo6JPeAofZpPPGKh9/di6y4Ett3vfGyfsJV4HAnBsgE1Xq+thmIgq0OiFyrgI9DlmKsAMT6xz2PjKCUmi5mi0+2e2mtfBkiJBLLGX6nATcMbk8CVBsuJROowGrY6bbIj1LFZYpmlzm8TIMY8R/kTR6vuuDbn9JzvrbbzEnVdCPla5d3RYLbQbBPPKrXWSyigx3XFtRxolWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxJWoeA1QBwlgP5tTvq/OWoGzQFaJUM4xbGPuxue39I=;
 b=jfAEz2vDLQTJv99zyqtdxX0xaKkldyK1u/lWF5YHQN0tyjMN/v23DodfZOz/eEcsipkXUhw7owNPm3Vr4sp1QO7Swa/a9dmcSVOl9MwUqIMzqQlZ7pP80J3ryprTLC+QfQI3k1EReQh7Wng2GCMwBwRjZV/nHovS9pQFUtphWr8NyiPOYaCENyQa+asN6kE3fPSV8dRNoWeeFlQwcUDRafCSKa3/nSDfpOpwaHx6LXL1/Ibu5DwN7moV7/S4xqgXl0DWn1D1b383u7YYgczymlZsAGqGfJdmYV2gasY/ljhCMtdDXgpGGdP7ljHAeka1vE1eJQcRHAln8A0faatAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxJWoeA1QBwlgP5tTvq/OWoGzQFaJUM4xbGPuxue39I=;
 b=WHjMGfUWDKdwLKSqoCJaoEnrLJNETCFyRSh+oSa/G9dmpt8Ugz1DH72L7THtsctPGKGHnjFAi6DzWkdUMvzfHCEDM8PkhiiGEb1K0KlIBNT1GEQBdg/YLWuxx3hx7X3KtL0mLzckJ3Z6j9OE4xMRFK7WiOa3fSmwicQ/UmzelcI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 09:47:21 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 09:47:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
Date:   Fri,  7 May 2021 18:19:23 +0800
Message-Id: <20210507101926.25631-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210507101926.25631-1-peng.fan@oss.nxp.com>
References: <20210507101926.25631-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 09:47:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc99f4a3-8681-439e-55a6-08d9113d1b99
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6857B76AB26A2A0D57476F65C9579@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTZUANbbNVKhIZtJ1jAErW3KWJzf/2J7gzP2VCIDlZ9Z5sa/MpyjWkuz1e6BC9zEx5ipEEbr7E00sxtOEtxtmn4CW2HYhhR9s907UFB6gGOl8xTlqL56TqFnzA1C/MaVkqi8bLzUxDsMt+eQqmmRdXcJn/igOkAWT8gwdwTX4dX8LOu0GKYCT/vJb3svRcmbdFES3gSGuUGSN1fMDD4qAsMdkRAz5dQTB8V+JzzaJLSMPAKMnWbmpuxduSFOkfIn3C3dAeSN3Xj9UjVIW8kC2jsDbQySam5V34OTAMRmuMk9PvhmEKLixu+uYqiholBiCtOv2jZUfSyxfACAWGj/mv/lBXYWPGsCqVNgZWx/tYCutpHh2Kzd7Wi5AkQOFG6q3mVvmqhL356VG1Sp3KVv8h06dz97CgWf5niouM8+deZ50HFUzfE9UATXZ4pMVeIATAYQuvBX38QElakY6HcGB/WbwQ4mSD9QsUUP1FECRAACYTVoz5LcJKc9aiBm35PuKijduAjhQRsvlHmL8XkFJBttZ2KZtZ/GhDLx+Tc2BI8LRpDUsv/BSZP6T0ERAfHR8lOVZijebv/nDxwfg+Lil9nsskwqp+aDY4fkELd9inIa529lTERV/JEBDawXnMhy+NnBJKFHqeDwb/qdIuzM2yNx7lRD4Hz6RmmO8ePzgEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(86362001)(4326008)(478600001)(4744005)(26005)(7416002)(6486002)(83380400001)(6666004)(8936002)(316002)(38100700002)(5660300002)(66946007)(2616005)(956004)(1076003)(8676002)(2906002)(15650500001)(6512007)(16526019)(66556008)(66476007)(52116002)(6506007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FbYNs/5ANcsdn69ImEgdJkPdoKWJSrjsJNngSKql7hwqsTGraB+apvBWZggS?=
 =?us-ascii?Q?JNSGlOY2SQcNa7qxVlrgbh0mrU/9x3LArXyxgjyiUxhdaYWX+d/BOZmS8L3Y?=
 =?us-ascii?Q?u90prKFtkBVn6dsjqul2ViJ+tAfHczU9Cb1NshBU/6Lbe7Pf7jJ+EjJaSLsx?=
 =?us-ascii?Q?xYvbdUeijmfDIU5RJiw31T7TLG5dzPhnANl+rFXjn5mPtvXic00Dd/JNjo8U?=
 =?us-ascii?Q?DuSCTZ2D5QNkOn3i891xkZk4tIg1gNY2nTLJp9JkA1E+LNxrxuhczOCSc/7Y?=
 =?us-ascii?Q?iLqSJnozYb9YpstSxxhEZDCw5vq8OZalVgt05m2pHWFfQai+DedXiAucm9KT?=
 =?us-ascii?Q?f7IsjFfTg76f3QbxGNAX/BZYe8vU96JOz1x7FscFSfuREOgVHFT0RlRPDJqb?=
 =?us-ascii?Q?Db5MnPQ29uMosZQIVAX4yBaBTg0F0NZqRxt/DZxmYDsI4vbLODH9KKrwbo7H?=
 =?us-ascii?Q?rwqHgJxRzBXqIU2GOWeFdgxLva2Tw/aEY7C/RhIeQE7diWq9+uKbWfXAnk6N?=
 =?us-ascii?Q?n7bcItpy9FmBrUrWFkBwccQn/+r9yLO/W+DR0amwQl+RHUa2FAyXe/47PZZx?=
 =?us-ascii?Q?AnWLNs4Z7Su8SN2lUxybQD2Jxgoqk1sHxXFT20bo3Q1XRJeAJsl3rGVW39mk?=
 =?us-ascii?Q?0XWZZHEDoF11Qra0e2awKboPxrFMcQL4JmfB8gGAi0KrLisjBRYMw1SlGX2T?=
 =?us-ascii?Q?W5fo310vofp0Xl2ty45OqFKgpP4c4S78c6SF4j8UcdUX+foZZIZS1w+V8wgf?=
 =?us-ascii?Q?OQdqTAGVAaWtJhM8Y+QJrXbCzT4e/HkX/SCOltyG+buCmkQRmVrjgGiex0/R?=
 =?us-ascii?Q?jGG23d3ed30DLs34QTQFCPJdbvvUMd2llNiGDXngJXxek0W8F6tmpgh25hBu?=
 =?us-ascii?Q?23/xCUXmmV1pqikVIblL9GRn+kc7ZsShiEsiM7KvvLflGZOWkOWnK/4Jf7O0?=
 =?us-ascii?Q?OA/xPYiSxxqvGyTeTx5Cv0/ayvFDRGPQeD4el4BwbRzMoehkaSbal19Zlj2s?=
 =?us-ascii?Q?yrqhQ0XsbCY/s+1BNDNBNmzE5qJOPWQB3IFVIlG9rfCeKBYH5oZbrPXLBECu?=
 =?us-ascii?Q?u915aD1RuGrju+lMQ4LTBhycaPXv+fBwwX8+6vxo61JJEioolZMz47eSCRg0?=
 =?us-ascii?Q?iJODH/UVHosik7xR6L1DlHFnyX9fhOmL51vWrlCdk7Zb4fQ5TKpfYmKobQP7?=
 =?us-ascii?Q?wG+eL+uogeolkhc+I3stJoX6ApxjYpSeI5VK0jhrhEV6uoXEzcpczMVzVwAz?=
 =?us-ascii?Q?CtISpbQ90o+RZq8Za16swKa12MyDa+X7vVlIcrH5dne3I2NX4LMOkcMwSdDz?=
 =?us-ascii?Q?EQn8upw5RyZUJzThDxw+wR1O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc99f4a3-8681-439e-55a6-08d9113d1b99
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 09:47:20.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tKZ4WLIMSqJ6jbHSawS02usrq6gr8T3ROcPDERU0WCf6Rd1I5M83VAoSotJi7o0TYYT42OmmOXW3yg1aaCkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The register layout and bits definition of i.MX8ULP MU is different
compared with others, let's add the compatible for the new MU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 1a3dff277e2b..675ad9de15bb 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -26,6 +26,7 @@ properties:
     oneOf:
       - const: fsl,imx6sx-mu
       - const: fsl,imx7ulp-mu
+      - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - items:
           - enum:
-- 
2.30.0

