Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA6377A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhEJDaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:55 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:35489
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230370AbhEJDav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2QHMSd5zPTnMyFN/14SoADfP3p4JE6v1SA/P1G7uyCXuzUvlqd36e4jAyKvKCL+cWtR6GJ+cl11o8kikzbQACSkX2z2akgZV3hILmG+ajMd+lJ6glixLWxw9liav71FrfoCv5l6/B+DhutsFUCQNh5RJNCLUhHmR9v2IlndRy50iwOX7ChHi/qgGLYUBeYmOOg9IYb9l4UQK41NtsLobTQ6jFYj18mFwTntDQNIhbwwrUBCbogIPmXuP5bM+Jj+LmN/obiAOjaMNlwEcaffAQjXKnHC02ADTPSYD/RurVa9DeeJHO8OqstfRbHmfPMNs8oLL2drDvnAClta3kmbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AImgcs7ms0qAmSvPDKY1UQmEuy3v9Gj65WikmMKaK8=;
 b=drY3gfDkXN/2HehhZNPmhjGXlUxQdHAcLHaqar18AsDFPZV+/ZPvp9bWOe46iJJcY0Zw04r1vn+dFi9CjoL0yAt8Ah5Caq/JVLZiO22/k1qk8UJehkxAMvcFAlskknly2Z5cBXbmzyIaNnTXJcna1RYi1IdOEiWM0hQQX8H4t4qg+ovyNc63SRZmTdn7L2B8P8JL1y6ZPPvEaof+dSF/tiGr2CHVsohqI7bvjeDO/jUSAaMOwf1h4irS2n/nPbPbmE7mh7qlIIESBjlE6GfseQx4GuhBTcfDhuN0+o8zcgT9arjA7ohwTU75wmTvuuhvbCQ1j5G9q5RpJ4s4Hpm5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AImgcs7ms0qAmSvPDKY1UQmEuy3v9Gj65WikmMKaK8=;
 b=ab0UHqKSzFFc8gBA0aPNSDlAehG6UQgbuoAvg79phmGpo5ZwwLX+d0R2XH7UguLFgKpDn6plxhyirf2tRKLewCD5hgaHwifA1Oux4kCCB3/rLu2QS0ZqylSg2xx4iX1JW2JgnhDSNQdjXhZ6ITJzK+HugRM8VLKkhg20UEtiIl4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:45 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 08/13] dt-bindings: imx: gpcv2: add support for optional resets
Date:   Mon, 10 May 2021 12:00:40 +0800
Message-Id: <20210510040045.13225-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c84699a5-442c-40a8-2637-08d91363db5f
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091B1F4BF2F6D4A75905C07C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZsMmZYCTSBnCorcQR9ntGHwAtHcmNCQ1G/dA6hmQ8e0Ev2PzxwhYVfZDd2Jogys5+KyX0yVysV5P3t2s8H6EgemTqhZysXEAV8fM6/6dJZ63SzxJhb1iHQOtfNGLMtW/yVTqfk3Y1rJDmeyVz21mZ/J4bQOHxy2oMz7qHj45gFXw/wSUriKUdXJZKchOf10DEdf1/dd2PnzrE4UCEucu2bSK7uKS5nv/yv92sj2xX8lbgitdFh1Ua0A6VBiPu2xMZgsbAMa1tzvrWzBohlM8T/d1p4+NzxRLCohlqAu1oS/ly0uBRP+uo/CXT1dPk4KYB3bfOHVrF3EJnxjjB4RjegDeuq8IwY0S5281iPhS95gSM61+5mJNJfqFz3q0SWAlVHzU0/8h9zFE6sYkZ62TRRD5m+ofUAWtxsbhM12rGmKciFsuu5gQwEV4Fw4qBVTcVD3/JHq+MN+0Jd1L/5u+5FzyC/e6ahH4XKU0Qh98db8zuuIKqkrmRyJs4lwJRvkJ6XdAzx3M8ae091Vs0dAfgPfs72dn4eX13NMdZ18Fu7M4lRxY6DSaLD9j1MPn8dSz8O8cDJvTTsYtO7Gxw9j7jbFwLnXYlq2IyB8ukOe8LMkbpQLYAFiLH2m+UtBswz7+CC/K2/r0or70tlW5l5hjGBMfz9KLmYGNcC/ZMDU3qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QFs3psgAAghdAKnK9qKd4lrOzo7heaBcLNcwF0rN22fHcYUPc9lchSXBgGYO?=
 =?us-ascii?Q?mW1grfFcTrc8rPd9sQT8UfTUaT5ImrMH4SFmiAbSNvNoEOeVRRXtUWioqGj7?=
 =?us-ascii?Q?9svxdip0hUsv3EOWtmnP6vnhnI5czUE5kw7V/TiCaBAuIZKZ0vfS6+q0KPm+?=
 =?us-ascii?Q?mCBhnxjsOCj/Da0+gChuAAmwB9pttg+wlgy2D3GgaA3DGp5B7RFOyvxMxdaw?=
 =?us-ascii?Q?2buUwcqNu3A46ukoqxNdmfZ6N2pe3Z3Q0vvkRDsCyaoVVuSgYvbgAnJ8QvKr?=
 =?us-ascii?Q?1KhkH6uiENeGtvfuU/LWvLYUdzmgyGOdKkq8Uvyyy5mrXEuZfw+SCTeUxCCR?=
 =?us-ascii?Q?zIdUJLvpRyO6S14iyWE2JJBZg3QxgA+wS5Kl6gHYUNYUTKug8etG4qgSRUvO?=
 =?us-ascii?Q?a5yhNWzJ6k2yw6oHLjkM2n+GfzmWodugHxiXVo1pFBpGJSKBw0CxJzwIUISY?=
 =?us-ascii?Q?dHUMT6sLFniGoOxvBhtYhzbGqk0DHzsaWWJotoVk+fgpZDuAFtYmfaRRKDgw?=
 =?us-ascii?Q?lCckEfioIWlcmsFNDiB7oNjNdtk7/mjMh3XgKZWkxJqRTSiUb8gMPJ7HSGrI?=
 =?us-ascii?Q?Z4a6M8bKiCqGyV26rvutVd6+hMkOHprm2HAfxt5CuutkyUzHW82w3FVvoE5r?=
 =?us-ascii?Q?5TjfDriLWcI5j5tNQ7ZaYEmKmwAOdfuYq23KyfjtqFERYS2sffP/UfWvwrEv?=
 =?us-ascii?Q?ucUdIj9GCZveTR/zrhcuUpv/pT54rzew5WJ23c4BCO9xsRGMT/C9Rb4YQVow?=
 =?us-ascii?Q?sfKBUNQe8+jeIT+ORPK5IlEEJGpwB3PU84U4Udq1jOepygHFbHVLkmReBft4?=
 =?us-ascii?Q?eCKYGQwR6YhrovIYIf8cs0pDKjqiP7/Oeou73LyDLahvepWDAKyZbkkv1lP7?=
 =?us-ascii?Q?bDErSm83i+TwQEngxINUgZHanYKdGpJZ4iUC2LBPa7nszYwzZLV091ibaGpE?=
 =?us-ascii?Q?ysb7YzAjK/4nScgNym9GLibjkKQlLb0Pe88etxIQTkfODBtnCF/YxeNW36R6?=
 =?us-ascii?Q?qZJslXvOxHte9cvqZEf+KKcPWHTwkTjdAvoesGMqRP3r3U5dVyuC+tDtYkj8?=
 =?us-ascii?Q?BTsIzxvZ1s8gu6ofVUEmyMgBUIAOWc+Mv8WhuFWTo53k9ICJ4BD7NhS9rgIq?=
 =?us-ascii?Q?woAEZwFHI5Wr4oGw0NYEiTrXl95sDSXxnggMwibPZeyvKaR7Nwt4osK4hB5a?=
 =?us-ascii?Q?6ZCAXG276kkL8d4RB1vNewdTdwLR1kRn3osIYMo/1yEnBGN7uTbBwuT8kd25?=
 =?us-ascii?Q?/AYh3PEMUq2mObr7C0aN7aFk4v2w74Msfg4ZOraQE5XjFC71oq/QPsafeVJo?=
 =?us-ascii?Q?bvAvoBPJqJ+2I4V6y/C3PwnQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84699a5-442c-40a8-2637-08d91363db5f
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:45.5280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkR71VQVeP2tqQPPRqj4r73nY25v0ynwqr9f6rQ6ifIe2YYF3oYMdDrxb8I2YQ0q0mjXABMOpEPN19+OlBr96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

For some domains the resets of the devices in the domain are not
automatically triggered. Add an optional resets property to allow
the GPC driver to trigger those resets explicitly.

The resets belong to devices located inside the power domain,
which need to be held in reset across the power-up sequence. So we
have no means to specify what each reset is in a generic power-domain
binding. Same situation as with the clocks in this binding actually.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/power/fsl,imx-gpcv2.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index a96e6dbf1858..eb248f24dce6 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -66,6 +66,16 @@ properties:
 
           power-supply: true
 
+          resets:
+            description: |
+              A number of phandles to resets that need to be asserted during
+              power-up sequencing of the domain. The resets belong to devices
+              located inside the power domain, which need to be held in reset
+              across the power-up sequence. So no means to specify what each
+              reset is in a generic power-domain binding.
+            minItems: 1
+            maxItems: 4
+
         required:
           - '#power-domain-cells'
           - reg
-- 
2.30.0

