Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3123F34EB13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhC3Ovk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:51:40 -0400
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:8547
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232088AbhC3Ov2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:51:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7fHRpyPqAAN0QeaZHoYKI4vWIydp1KWpGUx3/0nKPdU1uJUBSHK19WmapB54d0V5oF+DptY4ZYBc22REEGgG1KcyS+JGT6+TEtvbMBkP+Tk2yh5SXXUxxpDCvR/AUZBwwrmLv2xcGxxp5h0dZs1yDjdfdlpEYaPti1sUejxM+OTvLhwniucMRVR/0wWV2YDrHpJmAY724csyR8TSmQd9rrdL5kogTK85IKDDuUaikpKAzwaJNWG9pIXz9Cjovrf+bZ4Ty8hoRCMJxInUvPyLtzByJrzXOe8rh7ItjarbhorHg9evgdFgT8QcAhIQOh2767P9pIk892JSZrT33RaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7B52tnKJ7I/AxRkqNJuQX27Yo3GQU4JQug31blx7Ds=;
 b=dgSQuKghVwwJNa/HhCTjdjc7iwu5g8N8zz5QGZ5MscsZzowA97OyjKFveK4inp+QA0/7XDwBUu3wuBkpCQH7nqT6I26178QuHwIy78w2dqU/DTjD1SRueBAm+6jGvIq2qaH3oRtGHd4VKehhZNRMlni6CxyduY6feGOdM0pPa3y4VqAE7HlZ1UsxJcmRsF38XZgafxJ6/n/ebghNr02ZSJODX+XTe22uHX945grUdFXUvHAjwGQOHRHSRmaQury45i9FoT+GN0RdyfO4ptN14uTw6pl/klIi7OV1eKSlH2QsrZ2XlyTw64IZeCQB7Hr6vp6Zfd8/ALyG/gZ4PTXy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7B52tnKJ7I/AxRkqNJuQX27Yo3GQU4JQug31blx7Ds=;
 b=iiGs4CYQP3WpQQKihwxbUCVteZvOM3rwSKla/HqzTFb4WYLfO4Wr+u+V4eALfal6yLtjdc8TH8bstXLcVaLrJHmTa63NVH6DYmHmPg/LH1cmlU+euPAendTWhKgfrKUKhEMlIMk67OJXez7ZrqaXM5XqFv0sYj6n3rGRL6hz5Sw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com (2603:10a6:10:1f::15)
 by DB7PR04MB4585.eurprd04.prod.outlook.com (2603:10a6:5:36::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 14:51:23 +0000
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34]) by DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 14:51:23 +0000
From:   Sahil Malhotra <sahil.malhotra@oss.nxp.com>
To:     shawnguo@kernel.org
Cc:     sahil.malhotra@oss.nxp.com,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE
        LAYERSCAPE ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: ls1028a-rdb: enable optee node
Date:   Tue, 30 Mar 2021 20:20:27 +0530
Message-Id: <20210330145027.16897-1-sahil.malhotra@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To DB7PR04MB5322.eurprd04.prod.outlook.com
 (2603:10a6:10:1f::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03303.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR06CA0012.apcprd06.prod.outlook.com (2603:1096:202:2e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Tue, 30 Mar 2021 14:51:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf087e7f-b1f6-4c2a-6608-08d8f38b4970
X-MS-TrafficTypeDiagnostic: DB7PR04MB4585:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB458578B5E32FF9705829BAEFC37D9@DB7PR04MB4585.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJ1brTRaMjgHfk+yjkkqVHSO9x9zWmTPHQzAahll/aP5Y1ZiM+Wwx6CHYm4RUr16mLMH4xyha+V8lfat2LTV8OksA9ZgHB3bx264yX51tpO/JP0EAaW4M5FqRFyCdi1LjmIWP9G1OWvjhfrwTA6ucxx346XBKuzw3BGUGGDsQ9XyOdLKlXZL35hafbzNI7FzMWAXb4bV3YfqMBuKC9vdTZn3JPfRsM+uZTwVzNR9DE3wux/PToUsEVn2lYSkR7I5sTr6U0Pq1KsidjflM77N0bje4jR5Evtiw6EHftwqhAmZYURubY148potxjRjz63v9yhsTh6nzuUdGaSzHtBg8/VbwKqfjp4QyjgCNVvIGtlyq2n/qkZVAQASIGkAr3ukgWyuKgH1o+6UtntT6nMrrN4pzn172lMFLgYUiCrCnpDnz/fWYD9N7I2OarSArowkBENjHb1XDJMTudY/nKgyHPElqGwkLnGy1T+tiI6IbdN+GkEXg1jS0KwIrYU+XSgl0RvWLw50TGpRTsf9Obu7TejvSPK+W1F9HpAjphOi9mcUT1rrQBkpCXh3USPuiQao9O0Lg1ztBlAPtREPTKtkKXy/oEgotzT0fjYagBzt7+HxcImXCtQ23sMBTgzzYEorZFS3ng2ezSfYpQ+ZxIA1gTL/DfybsaI6Nk62+gfSTpldIDml0s1nlzuuG4/yiNe2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5322.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(6512007)(38100700001)(4326008)(316002)(1076003)(6486002)(44832011)(6916009)(2906002)(26005)(478600001)(16526019)(186003)(83380400001)(55236004)(5660300002)(66946007)(8936002)(956004)(52116002)(86362001)(6506007)(66476007)(66556008)(1006002)(2616005)(8676002)(54906003)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qc9vpDmN/Io1qogjS2Vmq7/qNmMSMDCpqRGN4igUuQ4sgf5fT+rDkzGLEPGE?=
 =?us-ascii?Q?mRLaORQnHhMg/K/Xr1UyprMUaHuEa6ONwn8BKDCXdLMjCH/jGGGoAe5nZNJV?=
 =?us-ascii?Q?2TeQEkyt7e0V7QfVq003Evz8DHhqMZNgF7Ggzbh+NmdECOpQxeuKjUBhXUOW?=
 =?us-ascii?Q?0c+POerplk6cbRX9RO52VtsMDwuHX/RRz1aDwZzRiuYojuxSRjTKyVsC2ko/?=
 =?us-ascii?Q?hx3TrrPvX4WSx6n+9ZUjUrfvS/+3nh2YGCPlev48KJQTOxo1tkpP/6rnB0Kb?=
 =?us-ascii?Q?RXB8W6FeSNqQXxcUwBKOSl5NHt3ApRjVfdXSbzWU07B1Aw1QEs7Z1OxYl2w+?=
 =?us-ascii?Q?RGVjJJVqwS8MmyOehgEea00MbRaCEY6GJ9df+nRKPFh+3zy6isQfJUlavD7C?=
 =?us-ascii?Q?xaTqife8ukEESUl8o19Y1BItVqOS/JcZWtXnLcYByxV8v5kmT5IAO8ORmQEX?=
 =?us-ascii?Q?k9/4mF3pFi4y44OykdCBznCoRMKCx4f9VtwJPvJYlGbQZjBYeqlPbfYYWdbN?=
 =?us-ascii?Q?LNpJ+ik1GqDYezMNGQwD+ymb5iDzrO7fPbqSodPii+ACvWG73MyQOg3//QOI?=
 =?us-ascii?Q?p29GUtQV+B65/3rNvB/wLibqIK0X1oLT0DJXtzrcOGgxkpaYV9abxU651KnE?=
 =?us-ascii?Q?lDMqnL1UU2DWmU99HNtD7A4rcvbltEiz5gCD4A7YgIR3yNPemKGZKxxO/ukm?=
 =?us-ascii?Q?r48uwVLYnzbGy2rTmdDCdfrzfyaIYSZ8uermAGATRnam683H47osDK3roAnk?=
 =?us-ascii?Q?QHP9FqYnj1qwfn8V+Y/5gOg5qF5yBCwHrEMXPUt6qKQxnzZh/4Ohnipv2fXV?=
 =?us-ascii?Q?z4HVd0raZb+AimdODHPEMxALzpXx/6r/pBL897RNPnG7MKnwzZ9Fwlupf0q0?=
 =?us-ascii?Q?yWde9aAM5P+ZdDKf1ETC0uFwJ637R1i3weJFltmPRNEZnhgvR+rTujEbKmyY?=
 =?us-ascii?Q?8pCfHQ7/C6IFK9gMkIKSw0ahZCGz4aul2Tcza8glm4gdY3SNJNXZq0EZrQZB?=
 =?us-ascii?Q?RLFL1vFyjCr/noORJfyyow2l8O5vfpXaDilXetVg6B441WcmBRZr1MXxmT4n?=
 =?us-ascii?Q?SyaBE26BztvSafwQCIOCR1eEUa/gRA0f+AKV4cmfRXF0TSd53ClTeimi/a8Z?=
 =?us-ascii?Q?JXPvxR2Kr2wuX7Z7uUNJjmMLtGRqP53KBKFvzh/TufuGK746Iozct/E6qvuh?=
 =?us-ascii?Q?p3pWw4g4uJrIubyGjgvtHPPQmc6srNPEEKMHT7u4L3HIlZWezhHvUeMaUc3v?=
 =?us-ascii?Q?rWOXL7Zeqhmzby75P2RnlwLhRSj34Ysab+Xf1iHuRf0Yj03g8c3HrHOc9har?=
 =?us-ascii?Q?SRIBJIDUa4Hnvgxg436ysobO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf087e7f-b1f6-4c2a-6608-08d8f38b4970
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5322.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 14:51:23.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUmPDbns8GOQu/ANFYywopQ0IVgLg5HnxorNkoTx64/hVuSrvdPBKNv4Vi6P4tOD0nqVTj0gRZPACdh+wfFv9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahil Malhotra <sahil.malhotra@nxp.com>

optee node was disabled by default, enabling it for ls1028a-rdb.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 41ae6e7675ba..1bdf0104d492 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -274,6 +274,10 @@
 	status = "okay";
 };
 
+&optee {
+	status = "okay";
+};
+
 &sai4 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 262fbad8f0ec..fb155ac192b1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -92,7 +92,7 @@
 	};
 
 	firmware {
-		optee {
+		optee: optee  {
 			compatible = "linaro,optee-tz";
 			method = "smc";
 			status = "disabled";
-- 
2.17.1

