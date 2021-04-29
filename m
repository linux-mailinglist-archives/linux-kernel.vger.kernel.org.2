Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A158836E553
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhD2HA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:56 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:54113
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239295AbhD2HAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex/Kl5E3uv4akU1oEvDo0Nd7l5TmdaCFjTrraphlt5AIh8ybc+qVbYhq/SJybgh+nCcsaVLM8X5ijSfj4vfB+iRxK/k43Yw+1lvnabomQXso9nodczn0ZX6djdUGTKtpVl2W1B/I5l+PuveV+73i7lDK2zwCm5y37641DuBnPTs0aybq/RrBSkl5v2BuyjpzK5bGFkhAN3FAxxnIDtGFErphu5wuyzi8BpIoFsQPJKZTmKfZMzpR4QK+oS7cUzWm01gcb6cprrzytjafXdXqfPn6z024dvC+QVrc8mXz60RXBmqGtX5pZ1NFiMNfEwsv89SOpHZsHEEol5sf5XWygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M55MHAAB3wU+mM8bEEjiU+t4iN966Q9glBMqxKp9qoo=;
 b=hQ64rJSYdAhCoB2ppQWEtq+799N35ZOWtgKppbOi3H5SvtlvV6qFaxVwvIIPWGRSXn5OO0dt1JF/YoFWkNdRomCZPZe0fTESF18qYst1KYzWGUeuwavdPa9zMdl0RZT3RskVmTrzg4nI2QCNR9qskDL4uhoxSRWd41nTg/u7QIbVnlMfteCPFZ3rE5g32PS3uoF6SBMDToclqW+V6pe3cmqswDRCQIbE+9W01bWWDqd883PimR/Cf6V9p7sehL4DTxZ/GWVt1VGogxZ4g7PkSggyIoNQadiAqgp9twDVX5xJki3r5UjVAAcHq3pw4ZQKgLCAmdD4EhPxEYN011G5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M55MHAAB3wU+mM8bEEjiU+t4iN966Q9glBMqxKp9qoo=;
 b=llEKFm225RQpT5vImJaWezBOXyajort/0QivrliMWcNNDdvm/4Ja9ehbqW2yttNfOkStfSmsZPdYmNebdZjw4ga/4KyJauvKPEeProQb5rXD8RMm848g6RlqpFIn45JGH/xYfEKJr0W4y67UUizngk6Rt3JvxWmIimGXnIQJH9g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 08/16] dt-bindings: imx: gpcv2: add support for optional resets
Date:   Thu, 29 Apr 2021 15:30:42 +0800
Message-Id: <20210429073050.21039-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cbafc42-051b-4696-1506-08d90adc6224
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB546832E17A90C027D856A7AEC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsqGZPYwlqAtmLZLvr5afcP+82H+IhvoLSnhbAMTlbZ0mNCD21zIcnLcJ1jXDy9QoXV3jddR86tdCt3Qsd4iOJVms3xavlBlbYcgmsNjvlWy8vP4UaogHrfcIJn6fvwWZE/k0uMecULmrit3r0vUcj0hgBQM+yDNNC586cm+nXyvKjoPaCiag+hYZXBf5syfqIQyXhte2siZ6BRj0AKewAjBtsJyFOB3kedBGTfcfc/5zzPgmfV/MvP0jPPFTLvsiUqbjDMV/BEPVME/jfaWoDvoj8Obm4PjxuweCAGDBQEy9HEj6KRR5NVP46F1ZXKy/W2jTGNElCTswq9Q57HWrDoltF7AMU5wWDImIT1Lgo2/x8BWAXEjf6l+ix+jSOMriQ2uptVCueSfaaa4Oq3BJLJx/hirZaa3kc5R90wxfbJSLRvkg5m9x07kYkv6t6aCR4CkhW+lHpl0ck5KY7GOwQeQvqkFRs/aRtc+djKq1SBtAuMrri/gZzFGBTuiqKjs8YWMVu2aKAXhEJoxn1ufJYIBwX4RGlQBJq1FQpsu2ttcHWCxPawNJGQ1GNdUUdkNs8T0UG1LrCdK/1dCA5cX/41vY2z6Fy3ukOQXT5Bi9qGJxRAEpOk848kd1hwuVfLcFqPk+jtOrTYW0LsfgkAZHZ5QZxCGzW5zRjVw4T7J7T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(4744005)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4lhtFgqRnmgfsCIfOZmaf0tteJna5mNoZ2nKpvDKUQhbSvnn6yfAz7z1ey+m?=
 =?us-ascii?Q?URbnx2bfPaeFLbCWHXEz67wXRsdcfz9fwXsQCdATpF4PTTSM2MISmwuoTxSK?=
 =?us-ascii?Q?HlxTIdFh7ZH00JXNsIWqUjDcDLiT+3HmfXq6fh0AMCpqoFnpuXc+XNiDP/yq?=
 =?us-ascii?Q?uxUaPC3pF5UB4k0SQ7QYQ3vmrKxAHVzj85JBNpOTlze848uTJ2uNUkLtahJR?=
 =?us-ascii?Q?WbyET87bEL6C4lbh/RFO9aYgOK7sbABsz35+8yac4++DK/mPKXndvRIrZmEB?=
 =?us-ascii?Q?snieIcDlNKP7fPhQlxNcTAEMKs1LksXrS9IptqUJcgAfqiuGYYPyPSrWF9Tt?=
 =?us-ascii?Q?3YBkDvEilYIq3rmeQEaceW+kJ35vb8KezAyhYxzYmKP/d7xTAoTn6SzTTzCO?=
 =?us-ascii?Q?qyNH81z4LbR8I9x/5xSL3OZIoxjFJPH9s6OtLeR+9+3FefrIB93grCsCbnzs?=
 =?us-ascii?Q?DDRvQ5KR4D+VuQVg5tV6uVtN0+K2OOu5/jmK7PbHok83HmnHx0q6sZBaBsrB?=
 =?us-ascii?Q?UjXx0KCYb+sm52uQy2LszvGZfAKxmGC8R8TKnxQWJernyPFwGmpGOLLX55Ik?=
 =?us-ascii?Q?ZVL+BIKm6aTQBwcVUYDgjbx1lp5uEuFbi4n3zebrbBXkPKiyVa6IMWUGGa8m?=
 =?us-ascii?Q?rCSgGHrlRAe9IdBO1C1uFiTjII4C0i6oRVplqZwZghblu6c77Hmn3D/u+1Qg?=
 =?us-ascii?Q?UBVhNxz0Y7RybwpjXid/lgrtKHDUOgOZIvLIiVX9pe5AYWrrWjkQRCJPDr2J?=
 =?us-ascii?Q?xVVoiFwjof6xfjuB20oIJ0pdXyRJSRD5tFBhD8ZnlARE8cBn3ZMW2QaIiQgN?=
 =?us-ascii?Q?qy34bsbpip1sHZpd17Jf2ngAIdhSzn+4s8TB/dDulIpZLZrCw+H+mRF6ZpJL?=
 =?us-ascii?Q?64fUt2hChNguxALrDpTm2f0zBHHVGpbFiqSRFJ+rAVqpeKTsM8BqskmHf6CG?=
 =?us-ascii?Q?IqkZDz+G7Tmh19O7VOT77TGSTjI+BUI3RJKRrYIyUXhZcc/F/XKeaIffZcge?=
 =?us-ascii?Q?CT5uCdB5lkD4BMdRv0HXQdQk28myShpwVGYoy0aeaJaFYhxvOe41ZIZGU2tC?=
 =?us-ascii?Q?XEW2lX1W2yAO72eUgt85iYZ2AQKpLJ0A6JFbHzDdht6Olc0lQJPCTXnlDBAu?=
 =?us-ascii?Q?aQghnr61K2plxXzVfr/TdqkNpJ0WV7Hi7aLnRYl6huweXYO1Cllf2JVTJeVB?=
 =?us-ascii?Q?Tw10zChcQDYB6JRlmjWDMJPBdAyP/WwBGxyFMQorQgg/VSM5ALvGSzXgBV2U?=
 =?us-ascii?Q?d3O5R4u8/vSBP2kh6JenIh+spYWH4xp/92ZRisjrC/u6viSrgQRWaWENl9Tz?=
 =?us-ascii?Q?YNuDrBJTwnQV+4D7MgOVDon4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbafc42-051b-4696-1506-08d90adc6224
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:50.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FKkaiIr3xqVXG2RNk8sRiCCQX3DQDX+XRORycsePpyeC64uo2AnSg1ZCrw/w5ZdMjCIuAiuDwz047Lvd5ccow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

For some domains the resets of the devices in the domain are not
automatically triggered. Add an optional resets property to allow
the GPC driver to trigger those resets explicitly.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index a96e6dbf1858..4330c73a2c30 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -66,6 +66,13 @@ properties:
 
           power-supply: true
 
+          resets:
+            description: |
+              A number of phandles to resets that need to be asserted during
+              power-up sequencing of the domain.
+            minItems: 1
+            maxItems: 4
+
         required:
           - '#power-domain-cells'
           - reg
-- 
2.30.0

