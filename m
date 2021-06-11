Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5603A4480
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhFKO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:58:52 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:33960
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231318AbhFKO6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:58:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPY5PLN/ABJbNHPFvsHsvyex/CAYxqH4lfZc+IRLs8skIvsUOGUumEXLPGVMUdH84ZCEa8l0DsWq/MMdMbYfuTwq50Q4O/DYtenWG1LysfGkSVvRJlKzivT+RHKHV2sFcF5iPak54pxJRgK2QJoqPv35F7AAOTWJ4nAo0VOGwwvrZDgMV2hjQ05GnbIaIf7WL93IGwn3DKYzWko6DD1Irzig2iTARgR3zaQ9rkCbsRYES+zFnbVUs09MyGUt7Tl7At28GKp+t044n3lnCUJZFJgvLIN06qa7M+Bqhz+eA/1ttgbw6yNDTwy95M0KlnvOiZ2SxCFwGz1Ct28ASfwCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EQUIo933u0Qhj9SIR0LFisBEVAToJDTsij5NuLvc/U=;
 b=Ee+jwnk3n3hhCvrkw36d5xl+0buJY86iTNuWLIUNkCSzSFb1n/iXtpc5GhNq2iOZiIdV1qR9I4Xe722ikBmrn8PVAvTdnR6Zls2Nbt/gy+KB2w9MhqLTrZXXZWykLRejy4agD10SQNSZamO3ckYvhAyAVt0F1J/OtD0h8EjfiqZqDUkmDU6Oz1FMI25DN9q63kaVfDDiD6Y4vZM9eWs+/gS35h7KyKymKq36Z1xd3d+zrwmoTPdr3JuL/wehRiDCMUwG7PsfKktkI4joel2D1PLoSctk5OYT9YiztQLNU1lN7j+0as/50cc5H0faqyMwEISVFlO7qjRxnm10L0Dszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EQUIo933u0Qhj9SIR0LFisBEVAToJDTsij5NuLvc/U=;
 b=JxUVBmj5E3cX5nF2MYL0710F2kUk5mKK8dxozEoboXwQN7FasU/++YK92rUGh869iZGW4LaX2CMccQflgalw7gPEgvge55rZmn5dkz+YiV4utV6SbUZtA4/Pi2UfBf/xOR/2Zb75IckCMjthQzFkOkQCbrT+J6rgpTN2MciYWC8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 14:56:34 +0000
Received: from AM9PR04MB8972.eurprd04.prod.outlook.com
 ([fe80::9c0e:ba4f:90df:e8a2]) by AM9PR04MB8972.eurprd04.prod.outlook.com
 ([fe80::9c0e:ba4f:90df:e8a2%6]) with mapi id 15.20.4195.030; Fri, 11 Jun 2021
 14:56:34 +0000
From:   Breno Lima <breno.lima@nxp.com>
To:     peter.chen@kernel.org
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brenomatheus@gmail.com, jun.li@nxp.com,
        Breno Lima <breno.lima@nxp.com>
Subject: [PATCH v2] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP detection
Date:   Fri, 11 Jun 2021 10:56:07 -0400
Message-Id: <20210611145607.147207-1-breno.lima@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2601:18d:4b00:3350:8833:e134:ea08:dd5d]
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To AM9PR04MB8972.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from breno-Precision-7510.hsd1.ma.comcast.net (2601:18d:4b00:3350:8833:e134:ea08:dd5d) by BYAPR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:e0::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Fri, 11 Jun 2021 14:56:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a70bcea-ef75-4d26-1ff8-08d92ce91ab8
X-MS-TrafficTypeDiagnostic: AM9PR04MB9014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB9014345703DF3AA44EAF64F980349@AM9PR04MB9014.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cq1NTAXJhrq8xDb5x1HwJD6hQYTgRHT3ChdK0XxAjLYO4iL4NyVGjxAwL3UnyWOhvBEJQXlcXxkKFIyoA/Zbwokti/U3UlTYf7A2eA9KlSxI6eaIYXLp8qRAJl60zmfc0QE3P6AK6A/yy5smPlSulW0C9edWmDFeSjbPdzGuaHf/lqboBS0+XUWElzZ79bZY9jfkF0eTJRcv6z4AJmwvAysZo/1Cas59qncK2vTMej+oCQKxR9lbOcHmd16jn43Kcf1AO9f5VM2FRDvYVjWF82OhgzZqgdpFF/vcF7zkZUHqj67NkndUgR7/orP4mWcn7QLDayCZLJy2gRBYTYR096F3gZmmFN95iIyjT46FC9UL92ZbaHi56DPbvaupgUGgzw5iZ7+Y5uhJygzDkpUblFOhI9JTqKZY7dOgvY+4nTfm4PUBUK9TIaEM3EJyvXe71sm+ZoLsVpvfQ7/6Aslra5looNZzQHrPLgKkdUSSrg84lsakv+Y1Xh83XlX+Jsghd2yLUBZbLUur8FEQ6BdvvbhOnAOeYG8rgadMOFO7geI5njxUB2qCYocpoxE1wti3P0itXEsbK6CeChCEyk1f8XSgVNnDV2UXmAGbuct09X7VDe4er+/z/k95SxqYJDknnL1nzMTsxb+VpwbO3Hrv1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8972.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(66556008)(66476007)(66946007)(6506007)(44832011)(186003)(36756003)(16526019)(52116002)(6512007)(6666004)(86362001)(83380400001)(1076003)(6486002)(4326008)(6916009)(38100700002)(316002)(8676002)(7416002)(2906002)(5660300002)(2616005)(8936002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4PowUDsZOGS3UiX4/tVdurKIFfiS9c254QwC2nNxOabj1VW9P2EwvC2dHwt8?=
 =?us-ascii?Q?8/K95bmlFyEBFO5lmQrgvF0VGv3io6/hAqrYRluryxvh/xDuq0KzuXzEH3sk?=
 =?us-ascii?Q?QvGwxUnJS19zVF/UwALFwlp0INlsQ7q4dQ5WLyNHpiosQnWiqluOhdbLSzPk?=
 =?us-ascii?Q?FcPD4LSDvgwxziLJZyETiPlJnMly2kWMO2TPD3vRGMzJ7mFls0Ms+/SEN8hC?=
 =?us-ascii?Q?T4n5hjkjQQMN/ST0UezOKCteeyi8bVZgrnHKDkI3rEFkwPXF5jqJKEPe3HD3?=
 =?us-ascii?Q?0dCsFAK7rOHoNeHVERUtKWSDDUGkyatJvgQ/M7Th5BvqEH8yJxdliQTiCll0?=
 =?us-ascii?Q?Zedgo+riWWsNKBjhmrZav54y5kvZVmtQl+OVvHJ+xp9Cf9M2QXdRQJnaA9Sn?=
 =?us-ascii?Q?uCE48XEJk9s9yTH5eCrpISPUvAyrrXrHpRxJD7p5GNh9vVWEDegeeN/kSDe9?=
 =?us-ascii?Q?Unz5X1eq+0zrAQKZGOA0Xgb82lijpx2kLC8QxEGuKO1ngtEzZorqfTJkYUGg?=
 =?us-ascii?Q?ePcydKUL2pLNhGcK6CHtyuLsmURNy2WrOHmPSryW87uZXtySzx61R19Zdxw7?=
 =?us-ascii?Q?EZ3WhUYCEaApK5up7WMStviCGdtH/cA9+ETSIIWcr6UyibRc9fEPjYuMDGVP?=
 =?us-ascii?Q?co00eX35cGsYI5L8c9bOXWndedF94O4JoX+cItSXJEnBZXPB4g4ktgm+32fN?=
 =?us-ascii?Q?cDNSTERwNQrknJkr+ugNAPtkHK7JSXwopoToLQFgvosur2fUJt+77vWyhzFu?=
 =?us-ascii?Q?VH9yf1wdolBV67XanhGylI2UBunjnHH4PkanTvR06L+xcFIVNnONlxkn+tf6?=
 =?us-ascii?Q?xSDeaSKXSEpVCmzJf3iNO163q61SBo50LlKEfmBOFOTEzq/890vqUDcCgCuF?=
 =?us-ascii?Q?qRxCBd+91hKI91bpfUMIwUnYjZDlxIHyK1w3H9quG/kJ7PrCtQ2sTOTRNUPI?=
 =?us-ascii?Q?uiga+1jVClw1busPLu4og7+mWt3eEd6zgSw8I9tVbYuh56qrw6UHguaQLp0l?=
 =?us-ascii?Q?CFIw2KuzHxbO2chlC+2mM9UL6S6GqIBrfzpzP4dDEeMoH0qHUcGNzoqn0xQ8?=
 =?us-ascii?Q?LTcFIneVKf6vw5UIUjRM1tpfZqjEd83N8f3p6NM/jRL/cux45tsq+xWAlG70?=
 =?us-ascii?Q?0+s/qEzT0DKsB0qbz99GUFcEztGagKd7ZieS7AJGVaX/hc0Rcny1+DGBSdZt?=
 =?us-ascii?Q?mFdY7lG26pcTzo254gzZc8CUhucLKyLL/w6z4IjPElgvUl/UXeL9YG0Qhv4x?=
 =?us-ascii?Q?qg+5rYFxNswZ8sgrcFp3KQTbm7uLRa/rUTNRTSnixweJepHojKLCs2GYb9zE?=
 =?us-ascii?Q?uTy9EB8BQuhoMeAn9jhN6ZPnAts52XLgnOx7MmeCqoN4qYds50j6wBKplTeo?=
 =?us-ascii?Q?AsV2BDyadMejWpe07hNXsB2Qy09y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a70bcea-ef75-4d26-1ff8-08d92ce91ab8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8972.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 14:56:33.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMTkqGVT7VzKrJkC3OacyR7LX7NrbKrN1bxX8o2XxgFwdcyto2bq/6IQS8LaSk89ghjPWFAqUF2WDleLzkU5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM cannot detect certain CDP USB HUBs. usbmisc_imx.c driver is not
following CDP timing requirements defined by USB BC 1.2 specification
and section 3.2.4 Detection Timing CDP.

During Primary Detection the i.MX device should turn on VDP_SRC and
IDM_SINK for a minimum of 40ms (TVDPSRC_ON). After a time of TVDPSRC_ON,
the PD is allowed to check the status of the D- line. Current
implementation is waiting between 1ms and 2ms, and certain BC 1.2
complaint USB HUBs cannot be detected. Increase delay to 40ms allowing
enough time for primary detection.

During secondary detection the PD is required to disable VDP_SRC and
IDM_SNK, and enable VDM_SRC and IDP_SINK for at least 40ms (TVDMSRC_ON).

Current implementation is not disabling VDP_SRC and IDM_SNK, introduce
disable sequence in imx7d_charger_secondary_detection() function.

VDM_SRC and IDP_SINK should be enabled for at least 40ms (TVDMSRC_ON).
Increase delay allowing enough time for detection.

Fixes: 746f316b753a ("usb: chipidea: introduce imx7d USB charger detection")

Signed-off-by: Breno Lima <breno.lima@nxp.com>
Signed-off-by: Jun Li <jun.li@nxp.com>
---
Changes since V1:
- Updated commit log to include commit ID fix
 drivers/usb/chipidea/usbmisc_imx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 4545b23bda3f..bac0f5458cab 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -686,6 +686,16 @@ static int imx7d_charger_secondary_detection(struct imx_usbmisc_data *data)
 	int val;
 	unsigned long flags;
 
+	/* Clear VDATSRCENB0 to disable VDP_SRC and IDM_SNK required by BC 1.2 spec */
+	spin_lock_irqsave(&usbmisc->lock, flags);
+	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
+	val &= ~MX7D_USB_OTG_PHY_CFG2_CHRG_VDATSRCENB0;
+	writel(val, usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
+	spin_unlock_irqrestore(&usbmisc->lock, flags);
+
+	/* TVDMSRC_DIS */
+	msleep(20);
+
 	/* VDM_SRC is connected to D- and IDP_SINK is connected to D+ */
 	spin_lock_irqsave(&usbmisc->lock, flags);
 	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
@@ -695,7 +705,8 @@ static int imx7d_charger_secondary_detection(struct imx_usbmisc_data *data)
 				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
 	spin_unlock_irqrestore(&usbmisc->lock, flags);
 
-	usleep_range(1000, 2000);
+	/* TVDMSRC_ON */
+	msleep(40);
 
 	/*
 	 * Per BC 1.2, check voltage of D+:
@@ -798,7 +809,8 @@ static int imx7d_charger_primary_detection(struct imx_usbmisc_data *data)
 				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
 	spin_unlock_irqrestore(&usbmisc->lock, flags);
 
-	usleep_range(1000, 2000);
+	/* TVDPSRC_ON */
+	msleep(40);
 
 	/* Check if D- is less than VDAT_REF to determine an SDP per BC 1.2 */
 	val = readl(usbmisc->base + MX7D_USB_OTG_PHY_STATUS);
-- 
2.25.1

