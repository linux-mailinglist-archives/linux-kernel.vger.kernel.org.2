Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC6C32CFB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbhCDJcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:32:47 -0500
Received: from mail-eopbgr50128.outbound.protection.outlook.com ([40.107.5.128]:8167
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237553AbhCDJcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:32:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuV4y3hPj90w29K/HkVBAE0yJnc3gSyiRjbMeYoT5WoSJBOLBqC7AQNFFA5olZQjPe7rndaAvuYn6MtdPMeHEIc7nTmS/px6ANv5Wio9bS78i8tuYIFp/MCc2d+VFpFpdkSj1Cju1K4sGyJJd6mVUPVznkqH0NJGiIA3B3NiNAFRADSTRye5wbkttBlN7RVHlug2LGxZrHwDxPpvzqilRv4izl7OCuC0uJwpiyQpkvFXdBCvh31yHwNUlObaE45wwEyGJ/YFcJKL/ioHv3OqTO+gmcQGyn7abQ3BX9iaZBo6NNwgHHR9EDNqVW6TiOWoN5WiLE0oAoDs5ja73IIgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqS77A2dHDe83w1A3MJTheshfaV2NzW4DHjD6nnvEXU=;
 b=OL2Rj4w7yLJLVKwiPhiw9MA7oLE+SAR2x/qcx5/rk2HOarsOhj9Si9Sbm0g3k1DdzPYhi7q0UZgjh3Gw8dwffkdvnzmZRC1j14cfMfTlqkrSrsTI9y+fw0e6FNsKOS2KWHbYC7r4dDOg+CD7nUIoVCCVOktMTXKpIeZOQs5PLo7PJf+ViHnM+5+kxWn/0cnA8yqi70x11Vk/CytKYucmH9SHHdwjafj7l8+dEzDATFE+b7st6rq3rkQefMPfETdHg9uC+5v12dc/Oky75KCPddHEgoRs0dg9LFnMzTfFaqomNCEvSJ4OhWF6QcXeIyz+TOJgrv1UxaNYaTjHQmu6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqS77A2dHDe83w1A3MJTheshfaV2NzW4DHjD6nnvEXU=;
 b=k9CGI1lsNgFuHKLsBW7NPo2u/TGte0k4J8bkESUswNVnzOmhoR1IEPgfxH+SU02HDK40Z4aPAFH/Aryao41RwOzMQ4PCM8G4reaf44X4oVYsDVTmu2ZVCTiPsUbB9rfij1t+A0FBw2hwYpTBmoCyeBhelmoSwBLvjuM95Rq3+B0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from VE1PR05MB7278.eurprd05.prod.outlook.com (2603:10a6:800:1a5::23)
 by VI1PR0501MB2272.eurprd05.prod.outlook.com (2603:10a6:800:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 09:31:53 +0000
Received: from VE1PR05MB7278.eurprd05.prod.outlook.com
 ([fe80::1c9e:879c:9944:1032]) by VE1PR05MB7278.eurprd05.prod.outlook.com
 ([fe80::1c9e:879c:9944:1032%5]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 09:31:53 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: colibri-imx6ull: Change drive strength for usdhc2
Date:   Thu,  4 Mar 2021 10:31:39 +0100
Message-Id: <20210304093139.471554-1-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.30.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [51.154.7.61]
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To VE1PR05MB7278.eurprd05.prod.outlook.com
 (2603:10a6:800:1a5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.cardiotech.int (51.154.7.61) by ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Thu, 4 Mar 2021 09:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c5310a-dd39-45c1-dd8d-08d8def058a8
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2272B0254F5ABD4999FCCC15F4979@VI1PR0501MB2272.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWuzrXz3lAin/5yXK0tFAo9yI93R4hECkzdOhjB0jJaLZL4xJLkyGaR5hRGho72F6XeDWZW0sGG0XOG9moKMgapt/KpPNHQghNOI0h24g/PNNTLZqgMbKlbPntHEzg4Wd8ySufpQdKssIHg1ibiQ/L8+PJW0ntQ3k+NuEZOlHuXhIdRJaGtUGC/KS5eH6zYnOxp+O0wO89E1OAG2Q7RHM4S7kn3hSUfkbRQSo9yKs4M365CGkHRmwGbgkUvCiH2HqEx+4uhoDe/OzQneUl4g1lFJQjSaQp5D7zb1bkPW7WyPEG8CeRs1V5W6ggPz4TiLOa7NkewCMMp4k2V007Hy7iohCuKP/qRRme2uDkc6BI8Bt3dGBJE3XFizA9+NWMK2cWe14jNkaX8FTOSDIzkfbynnWjBXstxjCiUpjs0PpjNK+/3iDqtWgXhz+wMW41mMJEli5oEn7qm8vT9ObKkIHmCx8OxtOgDEN9SJ12IKTIOC92QKtgwMHjBw2NCM7afnH2vzToTSl3DQCIpYVQJop1alV9PpA+w0osciMgWMhyaey/Ab/LF0RaWo4cvwoDQefe1fZF9lhwOhLLPOrGG2bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR05MB7278.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39840400004)(2906002)(6506007)(52116002)(478600001)(66476007)(316002)(66556008)(8936002)(66946007)(4326008)(36756003)(86362001)(6512007)(54906003)(8676002)(26005)(1076003)(6486002)(44832011)(16526019)(2616005)(956004)(186003)(5660300002)(83380400001)(6916009)(6666004)(16060500005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mKePfIQ0zrR21ZI5QpEENKtgIhvvpzUTGb0yinHalFRSUjKWkjLzHTGPqgwF?=
 =?us-ascii?Q?co44nWfOGvuDlw7hRiV4cXwn5OnSLjTYOLm8L0n/vHSYDBa61z9e4WrqZn6d?=
 =?us-ascii?Q?lT8k4TtHGuxKKde1DK73Q1g1vFMxg1YnqaT5Pt5jRWtojrgxkydJtKi/TlTc?=
 =?us-ascii?Q?O8rVGy6mtFTkqEGAi+xIiZGReVmTX/wzUk2N+3czm7on99koV34n9GTcxDUE?=
 =?us-ascii?Q?5T9Pz+sbibQi2grw+AI5c0Cu+m8heORSGaLw4Kr3s13ljfH6SQTQlPEPo0pc?=
 =?us-ascii?Q?9h/1+n8pHu829vZGjEoH5ql9eSBYXnuD7bWjA6q4rJhAVyVBBj4w9oBkhr9x?=
 =?us-ascii?Q?P81SqfwS55gOFRC9n/eNj1Vc1tmX247pzPIXh6G5q6Cz64BGrp2qg/yOpMMH?=
 =?us-ascii?Q?wsr1sDjs4d4EqCVW0IHMnmlXWaBndMRnYE28SRgScQg53Z1tMFP2MK8OqH1Z?=
 =?us-ascii?Q?OiHdbs6K0Zq9tBtv5F/hR5vaXiC7/NWMOxqMAAV0NnPZGOiiDDWWWI7CHPlM?=
 =?us-ascii?Q?cQIISgBixnlZjbhAfS0mxq9JgwjA9OAD9Y+Bcer01JXveMFGWnhXkPGFmWQP?=
 =?us-ascii?Q?yIYoXW/ASAN0mAArOOtIgTaiHEiDnDe5dyFg4X56iUA5muXpwK1W1HnM8IBP?=
 =?us-ascii?Q?C0F1BI1wzhDUd8U+JcsMa+kxySW3/LPOJtlFmEyTCUOOXgIVXDWe80/133dn?=
 =?us-ascii?Q?xZmQ9KV8700vEbvIwR66GllWYWHvFHNJk5R8zE65dWjaO0EdyRaq29VK1fE0?=
 =?us-ascii?Q?DJ++H5g1MjaKNA64ZCDW69+CMdSOa4iA4nVL+r3ofYJ27LUsobOHgbmfSz66?=
 =?us-ascii?Q?nXTMFkQJ50QpZ17i0ilXHraotskF1H9QRBu+Nn1mnqCse5ib53wff7WpQjuD?=
 =?us-ascii?Q?Ntl/HBG8ImjEZsAjLCPhq73AhMk8QpexBXDffUZwXOSrsPsa8lHdIZiTzpIl?=
 =?us-ascii?Q?j4jkpt4bcuF30SLhVMUS/qjlbC9A1piIRxf24nmscKKHSeVZGfXKuka8X6oz?=
 =?us-ascii?Q?LYysa7d9HJKFShuhcs5X3dwm/E4IR+i/Y9dGBCJO9hDyi56zr8k9haeJoivs?=
 =?us-ascii?Q?OhEig5H1XiXQbu+Egv23VqCDYk1ADvO7Mti4XMd80r6CYcAMtag1aiR62UEk?=
 =?us-ascii?Q?TuAxU0H+J5rfMNfAV4NqxI15ehNdmQwiG2tN5XIIQL6NvCIJcN8rALbZD6mG?=
 =?us-ascii?Q?vdfv3LK2GNbtfLNVKU2dLju6MtSVaWhjWc/2BEgnyXG8McYfKG0Z85VOIRWT?=
 =?us-ascii?Q?gP7/ZV5U76NvOzd+CxvGhYox0YDdrceKRjX55qY1q4xASQTmrgpREbYqWBk6?=
 =?us-ascii?Q?AFW3mdeFaJV69uXTqnrusRPf?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c5310a-dd39-45c1-dd8d-08d8def058a8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR05MB7278.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 09:31:53.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SW4UwtZY9n1Fa203YVG9M1JF3hJCEszc8LngNhPlGlBpQsOa5zpAN7D4pen/pge45L+/O9ZiETCNc+ZvCgGjhPgxqw4aqR04HWTcrNRF0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current setting reflects about 86 Ohms of source-impedance
on the SDIO signals where the WiFi board is hooked up. PCB traces are
routed with 50 Ohms impedance and there are no serial resistors on
those traces.

This commit changes the source-impedance to 52 Ohms to better match our
hardware design.

The impedances given in this commit message refer to 3.3V operation.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 4436556624d6..0cdbf7b6e728 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -522,12 +522,12 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
 
 	pinctrl_usdhc2: usdhc2-grp {
 		fsl,pins = <
-			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17059
-			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17059
-			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17059
-			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17059
-			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17059
-			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x17059
+			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17069
+			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17069
+			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17069
+			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17069
+			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17069
+			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x17069
 
 			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x10
 		>;
-- 
2.30.1

