Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE93A3961
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFKBuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:50:23 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:47465
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhFKBuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:50:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX4wzzYKU9bBWPvlhFpINRli4DoU2wNyGmbOFzudReKQC+zRjy7zF1tM6zy2Pg3+n7Iv8ggf6JhochcGkVjv8GCEh9X6smv6S8E5qqxvCHgNSHTZg80NhTFxzDdZ1BcAu1L1+qYJYqNpC657Oq200APDv1BLz9IYUyE+6Jl6GBNWvb7FgBNBIJCnt6h10/75X57fcN1AMpdnV/mAZrK8BjiorPyOpe83x7Ll/78zlm74xw4kK5nT1WqPrm0uNaj8isyRvCZsaoC3sp1FrDnHj3SkBY1zoKOLFPMTdqhxauBi4QIeN6wXXK9d2jrKzig+c1IHReoqZasPA279yLpbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmV0+lDH9jaGfmIwJyw9LvH3Ndz9HgkRkIAyLjBvXLI=;
 b=QccEBblho03MFGiuUUKAIkF8sKXSjNXHL+ty6aff4X5yf052JGgeM1Db4r/mVddvbqhoEMmjQCcrdSm60P659H+8OteHZUiM0Z7s8IgR8ceSbP3FFrgwX6ghDdXHkxo0R9qD8zgidTrGbE3BCn+eSkeF+HRMhOR7ahggSUTAx/mEc9lnFzvPMderbmxYb3vIP6Woyn092yKPAoTCe7tixXVDQAndSX7+MDEZhgtpEJ/mC6nnHRobOm3F5UTpLsUahauOT3IvrHFRuRhSwoRZ7nPEq9odgC6fs6uabk5pnDweWCzyAWJQKtG60Q/wV1O777cubOKTxsZWBmOkheQt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmV0+lDH9jaGfmIwJyw9LvH3Ndz9HgkRkIAyLjBvXLI=;
 b=HfjtnyNKMDN/vEsI9g89UQA010cKgJqo+rdc7sBY6PvtIWoI9XXcqp0EQY6JwZcIMh4SysgnY3Pj6nvNFli03whuC7GmkBdL9CZlItRTi4f/90UFKcEe8/pCazMC2HfpZQEWQAqudK8c/E1xISEP6JNcyTg0okYQI6F/8sDU29Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 01:48:22 +0000
Received: from AM9PR04MB8972.eurprd04.prod.outlook.com
 ([fe80::9c0e:ba4f:90df:e8a2]) by AM9PR04MB8972.eurprd04.prod.outlook.com
 ([fe80::9c0e:ba4f:90df:e8a2%6]) with mapi id 15.20.4195.030; Fri, 11 Jun 2021
 01:48:22 +0000
From:   Breno Lima <breno.lima@nxp.com>
To:     peter.chen@kernel.org
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brenomatheus@gmail.com, jun.li@nxp.com,
        Breno Lima <breno.lima@nxp.com>
Subject: [PATCH] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP detection
Date:   Thu, 10 Jun 2021 21:47:55 -0400
Message-Id: <20210611014755.124483-1-breno.lima@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2601:18d:4b00:3350:8833:e134:ea08:dd5d]
X-ClientProxiedBy: BYAPR01CA0064.prod.exchangelabs.com (2603:10b6:a03:94::41)
 To AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from breno-Precision-7510.hsd1.ma.comcast.net (2601:18d:4b00:3350:8833:e134:ea08:dd5d) by BYAPR01CA0064.prod.exchangelabs.com (2603:10b6:a03:94::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 01:48:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab071ea5-1b3b-4ac0-7e00-08d92c7afed3
X-MS-TrafficTypeDiagnostic: AM9PR04MB8438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB8438770D851864E56346359080349@AM9PR04MB8438.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfSUkRkZMYwdciNcgL7ejWTJKSJfXX+ofeF30R0HQ39sNAa+wILg6HtcbTl6tBPsX3/7Ail11oz2t2zgfQ6KaI/XXglkJ7c+2SkMLdKbBe/+/3mg+tr7c1ZW43T3njwE6lLWXovC/rq2AShx37d4pJehi5qnlkxzT6rKL2KBKLk7boh/PyoFctMFZ93TMdEOWK7ruB7FbH0AXvfPLbT/ViqgvmFuXBOqL+G9Z8wdJoZcKktl1/rhYapNT7s9aF+FZekm4rtOPuLvvWz/b4qLlkMy32OPSwGABVDEQuxpO22ab1vSliGH4mJuC34BwwgGyO1Dr5Ly4rZnUVIOIlZt0mFtFuUvNaiwTD9ggNFyEKKUbr4nFegU586OIFdlhAJiTsot+s1X5R/z2TjuFF6VbgfpeJsBTwsFmRuvhsr4Qkyl3dq+cbYXDc4UNyHKqcginw8t6Wjn+Bu58V0nEgBfe7rbl52R7HU+Lt7w35zLhnCqM/HWoa+hcZi8SzsY4htrfBynf+JEiy//qwhuaGfy9T9qudP2JuSoVbcUPXguBx5oab0LE1kxA03LqVfexhXFA4Fs96KVLivWJDDRBo1GsHoziPXp97x70QETyd5i1FXCU29AOu64xRBglJl4pi0ccw6Fo4H0W1cwUu2SzLCoNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8972.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(83380400001)(16526019)(52116002)(6512007)(186003)(36756003)(6666004)(8936002)(1076003)(478600001)(2906002)(6486002)(8676002)(44832011)(66556008)(4326008)(7416002)(86362001)(6506007)(66946007)(2616005)(5660300002)(316002)(66476007)(6916009)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mpHUIn6FKkTCbvosAK+xSpJnzJhyi2tWZnoG/ATPHMcDhjqQrfYIPXe2f/ah?=
 =?us-ascii?Q?b5zfYMLnFRwYsYkL/6tvjUF4+1XVmJDoVZww9jBfiE16ElwkxZ2f7HWLzSaW?=
 =?us-ascii?Q?jII8iDWRqxJ5VyNKwsd5a/S4G0R7mqwlkh93DMFY8QyBAEdxt1aQAQjjcK/c?=
 =?us-ascii?Q?FPfHqrunvHxTd9qFubsg5ZQ1IhBF6XxlNFxEZBVrZovT1pp/ypla+eRL9lx0?=
 =?us-ascii?Q?RzF7riPRovTMK2iUJV1zQhYOaOG1LoIsSe1++Cxp31QPi0Eplz2rQH/5rXk2?=
 =?us-ascii?Q?YJwZuRLWCyCKkbEE1eWZ/rICRfQTJZjYEmhKOj8AcZGsgioyy7na9N2EfCzz?=
 =?us-ascii?Q?kQ3JpXisBUfOstyI86FDLnIgDKtwY7FVgRQX7LS2i83AcB9f+Y8AD85vTuCi?=
 =?us-ascii?Q?X00tzggapKDRGzrAXlC6KAEpukAndP62FCKCrca3Sf6HSEG5mE3HS7j8zhiu?=
 =?us-ascii?Q?pAXvJIArVvOV1P1ZqD3NPPceGWAxdI9JSp2xdrfOD6zhFFe2H5A0Cf2luQrv?=
 =?us-ascii?Q?hRtC3Yi6negAmNuWqc6V41zR89h1wisNSWoZJLpP647anjW/rYfGuE7U9TVU?=
 =?us-ascii?Q?0nLiQy5vyfNJ/tTFfFk6vtGV5es1JaY3p+FyTcptcnyL3kOAfGMm/7nw4xRt?=
 =?us-ascii?Q?kRkwFaUK2bUu7wQkENQj5GBwG2ti1wIHbfhlX+xb5P01SbT71U0UyNwm5oKr?=
 =?us-ascii?Q?l+0/v88Lw+IODeGGjhtp6mLdDWBZdk7T26DknT0Z5DDgdMBbvqCXvRD0mQD+?=
 =?us-ascii?Q?7pe7ymqs/ubbXfkEjLqoj9rh5WV2FoC3aekJUtK4D9RMpZpqOADLADktklPL?=
 =?us-ascii?Q?5Iaq9OPYVaJsGSF0YYwqQEooJ0Bw+nrRKyShKolqKhiLexGTp6iJHABwR2JT?=
 =?us-ascii?Q?LiO+UEr3nffBKjwdT9y7OvRn4SILjLgWKwAzohuy2lAspxBkI0TD7b7UoKxE?=
 =?us-ascii?Q?0S861lOXzQ0pvOPq6aEz4wVyaSA5qE6Ky7d6fet4o3PgwB9cYaiaA4U7C+jA?=
 =?us-ascii?Q?CLwbGZDGmOZ3a2y+Vu7+9wbgwGPPAelSuIiWt1l6TLlW7Rb2YKNCQF5euXWd?=
 =?us-ascii?Q?6rpliqDe1+JDHGRHfzpDzpuK8T2oyF0Z083t0I4lXx7U5nD2Umgs5LJd4yug?=
 =?us-ascii?Q?oa82Pg6q4/erCAJ/TYBuqqDOaqppTHhes+CWOHYp7M6FVyRt4J4twt3wmtEY?=
 =?us-ascii?Q?SFYz12P3JA0XbdpE4tEWweEWUd5Lz0FxrkTroH7Rc8r6pZoPjk4q3JMEJBa9?=
 =?us-ascii?Q?CmIdzUW70h00ThQxeeiu3fySfs2VCgtIAJfJlZXEcYWivYMBilOKgWP94H6C?=
 =?us-ascii?Q?R4Bo+tN0YP8eDLDS01AhNT0DBH1BSvWvL1CEjPMadlbyO2OT4H9ff6i9b06r?=
 =?us-ascii?Q?06MOon2OYohmA60E8WhcfgwTsGzn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab071ea5-1b3b-4ac0-7e00-08d92c7afed3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8972.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 01:48:22.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO1w8auqOmmpfa4vkPQ68eGf7KQmepzqiVCk/UF+BL/pb2AaTG86JVunYBaEpVR0ynqdc0Qm0Po8WxEyZG373g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
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

Signed-off-by: Breno Lima <breno.lima@nxp.com>
Signed-off-by: Jun Li <jun.li@nxp.com>
---
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

