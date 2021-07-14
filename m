Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF43C845B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbhGNMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:16:14 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:63744
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239209AbhGNMQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N46p6Y3O81a3uun/BKL06Ts3b5Ap9RwvmsBuROChF3Teh5zWkDeNq6lzxzbhwyJB2Om3+T8L03unB90xc6e/9eH8MVUCP2D+RAs5MJgeOVhfKajhh+luEQ91RsrbXceUHiKinGni+ekhNlu7LmwqJyGYypEdGFGsenA0Ylrxs8xSNjNkk+HKJELmp5juTz8hpi8RDTkYbOczsBMxpFl1jzjRktqOtJdRm/6Cl4TiyazNm9H2AEsdw/HohWXq/7AxKUEFitKMrzk3kAOBm6tNUFNZibwuT5YLAgvAHOViX8tUpXWR5hJZmKotfZ9CY8EiNQmPWdfd8+ZLoeEw2TRYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBUEJjRXFpSFJW2IfOGlSnSas6tDRDLNmuQQq08h/jU=;
 b=hoT0gqBkw0cnRA0gMfT9PohJ3hPnFgi4/0y4vM6hitoTpzm2NqPSKKDVa7b71Pt8WBaFmKQK6ap5LbsTsaSYnkwbFIDb04dBkN8CvB69zpAr5DhI5q2rtFhawwe6Y/52KsD76RU1khgfBVaLw37wJ3wkgGEL+1WvklA15DVV80dI9Rj4uPbaiiFfL/+BRv9HDEERNJ2ZsbNU9JmdtqME1QKR+KSRl2Vi2+EbLKUq0WvbzN93JFUuAZBY4N30wkK5sNCA5ei2UqdbsdH1BXgSom610fLoGvVCvznQr3gt/GDFdmJqQBU7hi7VAQZgV5FJ2y9ARYzOTaAyDgZfnd9D9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBUEJjRXFpSFJW2IfOGlSnSas6tDRDLNmuQQq08h/jU=;
 b=OcUuqszGqNeaVUJL7SeC2C1f0Q+sMqYBZr6L2/8OUXVKZRPmhBMDSl4EfHx0h6+phYfuq0few5UF0IaxpsjqwcB984wEOnr7Au+Yy0dvRUgVEGkKNJ48HADrP4TRf70pNMa4L34T1TQVR6gaksZkkU/qhwruMPkwcLmy0YSs3b8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM9PR09MB4691.eurprd09.prod.outlook.com (2603:10a6:20b:2d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 12:13:19 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 12:13:19 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8qm: added usb nodes to imx8qm.dtsi
Date:   Wed, 14 Jul 2021 14:09:22 +0200
Message-Id: <20210714120925.23571-7-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714120925.23571-1-oliver.graute@kococonnector.com>
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 12:13:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cba636f2-5dd6-4fa6-e922-08d946c0c43d
X-MS-TrafficTypeDiagnostic: AM9PR09MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR09MB4691532A6874FE32E7856EAAEB139@AM9PR09MB4691.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qm6e6HG7rK5oA8nuh46dmjh5d8Zve1beUPYiAQUkiX94JiUk1UTdFUdE09s0GVNqonH34Bk6YvATAg9pal5xfH2h/E1eeZ/gTZCv0S0AaUwC7/iahX99BXIm+1afX7ogHMnZ1Otzjv2Ui+fnLc5DumsxxuBEWMxa+tynvDoaC/otkyp/tUeIcoRBzoVa6ZAyUAHunSffHFegrCgBv0LheguNNDzLYgX1ZsDIeOFIkIeufeWjM7leEzO/wTWsY6Z2FZ0TrTBLyvLgizbhd49K4JvOz+PKwNGXdCi7xAS+vgaR3Tc5q8aRaSfRaFUf3CeUcXmt+gm+B1iJi+AAIvO5zE2wtOYdCYDYJLy3jtrZIz1FthNlkNe/75dfmUT7+iPX4YdF+ibwUxt0Dj92T1CukE4IiBtyaQCUdDGyNO1hC8XN1Alp5SvU80Bfsi6yEYAwukyGwVChj4Rh1oHq9zPWC6Ajw/NNHOUpe8YfifgR0Y5PbLTMwxKgU8sDxT/smwIoak4CLABaTp6AJAY90IVuHP9gyh0udsc6I/AqxXzdECXOMoLjJDvEGQCoGfsifV6GdGbGSfcB1utKUmnqOm/TYyvsQejAH3qSMRg8bn2uGcjRfPXSuGiCXBwvu97wS601903SBOqbpWqTBP0xczT9uuPdMHdA4B8LFxzGqTiIBG5oECMpS2YrR2C7BleIszX6pSu/9W1Q/nAxgm3qEVRzuWi4oAhtTWKAwiG+f2mzMh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39830400003)(376002)(346002)(396003)(66946007)(66476007)(66556008)(8676002)(2616005)(186003)(7416002)(54906003)(8936002)(83380400001)(316002)(38350700002)(52116002)(6496006)(38100700002)(956004)(5660300002)(44832011)(478600001)(2906002)(36756003)(4326008)(6666004)(6486002)(86362001)(6916009)(1076003)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wNvH/qhZlttkqbEgtnR1i1iDcRf6VOQqYxHyLWTuTGkJwmAf5bfEpJyeiyYe?=
 =?us-ascii?Q?yLmHZEDpHzivOKKSLDpfjyYTkVkM0saiIXVn6KHhQrEKmo9f7NGjOKEtoO+Z?=
 =?us-ascii?Q?14xE8r+v/ElDWj2uPrFmPeyhb7WPnBtEF6bvWJX3U9tD8sMwcbE+ciJdSX2X?=
 =?us-ascii?Q?BiHBoXQMDj5oeFLiujieDkzVmqbzK+tDjPnH9yabXK7T7sd3X5WTHpQZFUCH?=
 =?us-ascii?Q?ppmRveByPPdu3+YukECcfbNl0AXNu1ds3gGlJwdXe+XF6mr2WjxW+XsJ9KdY?=
 =?us-ascii?Q?DMjWmihdCnqcBXdTzsriDx9Jf/Kv/19dpUrYj0TCPcKq/9GZYK7YuCMUuvaX?=
 =?us-ascii?Q?/uBLCjcG0kLbX0Uc16vqe7zk8oq3bujXUKa6YhpZx77LXjrrQdn/mqeY5Ia0?=
 =?us-ascii?Q?1jh0Ze3IcPQ8EiuZs3chPFYCw/kmttOwqHkATr/F/JBsmCIzRMFjr4wmEDSw?=
 =?us-ascii?Q?+F3UlINAEkC0giZGuEEMOFlOoaSrk560brYDKBCEhY82pnGi8ItXwPacQwFi?=
 =?us-ascii?Q?xBed564Lb/AYAYCjnEJzlwfEEvy/5bUywRFSWZpxk/qG0x+dtIuPlKexNytt?=
 =?us-ascii?Q?nbYNTJKdLogIjnb0MWx5xlYwp107LCTCknguwFdYRWSvqYi8XhulbGRDajE6?=
 =?us-ascii?Q?ZdZJCvDnwB1AQCTM2wIRHvGs+zcNQySIhMhNadW//nQdyPeDzXmdiAWFs/go?=
 =?us-ascii?Q?uVkTSjoyqBr167gHqkhl1M1iUs8XKDn4YTI2SvmlLMocWW2dzqF0Sfg39WlG?=
 =?us-ascii?Q?3+jYj8PqvhaFX3+3aPatwVQREXYSlEf9P5gCctFVtM63EMHQtf3ZrDQuaFYR?=
 =?us-ascii?Q?AVsNcSl+ce5EJ4C5SXqhsPkvviZpe12C1EAgWi0dak5GR0Hj7zPjycXORqoh?=
 =?us-ascii?Q?D1zq0ZWmi6Y04Rws9/o9rqklyl5jV4qplRVQTDtbq8yHQRxD//iHowuI1VAC?=
 =?us-ascii?Q?nl0zjY18FmYuLNnpOnBXRKKKJQZOMvMDNGxQU2t1Df2ilfRwFDMOYQJcZVZ2?=
 =?us-ascii?Q?MFOzT1nDRx4md2PKS1UzhXraokmU5ggpEWVu7KO+K5M7v0pexOnr7GEOPvaU?=
 =?us-ascii?Q?UOewZ0lEwd1TvSncu6ScgDQVJUSOzP+cS+n2lfUO8kKTTwoRWKXx2UpUzFUG?=
 =?us-ascii?Q?Xvi/PJUfTApKeGMZjVhClrItz+BxJne9RyjpD/KWoYysIaZtHPSLv7GZSx6I?=
 =?us-ascii?Q?xGhgGGPIVZm5U+aYwzTQpOuyK5Qs0Gc/eVoK4CqmciDM8pDTc2jo/eRLCj9s?=
 =?us-ascii?Q?oRxubUedFfUzCZsOsCtlfyqHG9Vs46hdrF/V+73OyZHXTWIeWWswSxb4JlJB?=
 =?us-ascii?Q?6lax1hB8TShVGM9vbCqD7/xI?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba636f2-5dd6-4fa6-e922-08d946c0c43d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:13:19.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5etvs8GjwYt+ZD45MojtmziFBJwXxcjzFxAdCyE1Du4M7Mn60SmYbG299gSIK08Nj6ys+sFDCcdbbnoieNlqleJL7WiQLt8a3zaCTZEpt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added usb nodes to imx8qm.dtsi

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index fd0e706ea011..acaaa1748fd5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -226,6 +226,43 @@
 
 	};
 
+	usbmisc1: usbmisc@5b0d0200 {
+		#index-cells = <1>;
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0 0x5b0d0200 0 0x200>;
+	};
+
+	usbmisc2: usbmisc@5b0e0200 {
+		#index-cells = <1>;
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x0 0x5b0e0200 0x0 0x200>;
+	};
+
+	usbphy1: usbphy@5b100000 {
+		compatible = "fsl,imx8qm-usbphy", "fsl,imx7ulp-usbphy",
+			"fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
+		reg = <0 0x5b100000 0 0x1000>;
+		clocks = <&usb2_lpcg 1>;
+		power-domains = <&pd IMX_SC_R_USB_0_PHY>;
+		status = "disabled";
+	};
+
+	usbotg1: usb@5b0d0000 {
+		compatible = "fsl,imx8qm-usb", "fsl,imx7ulp-usb",
+			"fsl,imx27-usb";
+		reg = <0 0x5b0d0000 0 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,usbphy = <&usbphy1>;
+		fsl,usbmisc = <&usbmisc1 0>;
+		clocks = <&usb2_lpcg 0>;
+		ahb-burst-config = <0x0>;
+		tx-burst-size-dword = <0x10>;
+		rx-burst-size-dword = <0x10>;
+		power-domains = <&pd IMX_SC_R_USB_0>;
+		status = "disabled";
+	};
+
 	watchdog {
 		compatible = "fsl,imx8qm-sc-wdt", "fsl,imx-sc-wdt";
 		timeout-sec = <60>;
-- 
2.17.1

