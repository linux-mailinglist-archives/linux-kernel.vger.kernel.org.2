Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC332D1F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbhCDLlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:41:04 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:21486
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239595AbhCDLkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:40:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgwiTwe093N75q4U1uz6Ue6MCj8K0cZiaRTTmdz3eZdiE5S13MEWFwsFFZ1JJhbHa0erTyhCeWnv9tIMbZc85ashMzg3Fi/SqK5528bseiw60YG6Oa3y+x8zhVvm2ZBCM3Q0d2syxHiEvQoJUdNoguwWLIUBPk3S5WE9XNSwUUeBjzCcs1YqepsjCJ++ZTA3PgWpOa+zTiTgeU2uxV8OheIDUhWeuF11DZ5KWTSZN54yf7/qpm8c9CmEwUrmWHZyLxBNmNfvFdQ91yN+E0gEexjvb4MsUYCTKymm3FXp1WYR3zHM9x/6PI5x+bFO7D9Du3s093vtWO16CxBf+JcliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOZrsSKj6M+AfuMmiebhOtH3GWmgQjd056uaTG9EMLI=;
 b=PUdagiWswPl1ABASKVay9BPMWmZ8WTZ5FiYtdrNT+ZUG2IFGCylHQec112MRVTriul+X7epUvuP391ou4cvUAhkCAPOyQtNoElh37rlYwqpeMpM3pJulEMWkLszJuhnC9i945IMslgIxljRrp4w1Dl7eJdPfGT/gwAGYCLCddHXwFKGzQUAirEOE7EvBYhy7vweU3UHDFmZlSFHP4CdKDPcuka6PoGLgEnjuovpvATJsrNQygpdRwppYMIYyZ6YkSWDNQw00wBgrXYBMbsG8xnRBaG+m6UJ8CoWUA84R8R6L5VLzhWAWsWQNE1xNBFd03fl3kvAlcgOINLAAmnGQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOZrsSKj6M+AfuMmiebhOtH3GWmgQjd056uaTG9EMLI=;
 b=oIAQIgdRBLuDJsf6276oSGQIftTcnzWkTnrqbZgQ1dwMfM0B1nLGe5y75Q1hndPiFjxmtHejthGIOb+ySW0GfcTwyslIpYIMpeI1UKwUFRldTcHnznYuY/+4/bc3zLmodxUT7RC1rX8zbfcrgl4FRQpYKhIgY6ptkt00ttPwgL8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB6249.eurprd04.prod.outlook.com (2603:10a6:10:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 11:40:06 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 11:40:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V1] arm64: dts: imx8mp: fix FEC can't work when attached to generic phy driver
Date:   Thu,  4 Mar 2021 19:40:13 +0800
Message-Id: <20210304114013.18494-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HK2PR02CA0143.apcprd02.prod.outlook.com (2603:1096:202:16::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 11:40:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 351d0d29-cad9-4af8-1f9e-08d8df024222
X-MS-TrafficTypeDiagnostic: DBBPR04MB6249:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB6249371F1F86CCBCCF6104F2E6979@DBBPR04MB6249.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsMqW+Vrq60CVbSylEAM9yPmNt5hluEk09RcydEjQJ9fI2cPfnhxT6iPUQv/4InnoKjV7Kh719aaKRmKJ/ILSmg53pMffnO80HUzBWxb0cgzEFPr6QeZmJlu7gyaAqHqi5W3/f5vgA3xEQC9+7NfYBkp/s6CXN9GTsMEE+FTzk0NpUqcMAIeo1ePhTxVxMQVOL0eXagzkrCDEJVSVmezWB5MkvfSy6l4+Ywtoszj1ZTr5cQV6V3mBg3N7R4PvqTQTXu81vuiMDaF81SODxDfIeMxpItPp6ZnepAO1cTZxKcjNv2IX0NxMgQgaOjLNFXk3j7TOz9xtjE70O+r7BnM3Wh01o/54Yw/8lezMiLscsyP5EfqHAk9XfGJYEg4bmAv3ztRj6PtiFlbqTXXTnTVNhWYOxAt5mrCULiGf9+Kp4fE9gRyPVVCAjcuYBpE76Gpff4IR53Gw376id3VYYbeRUysBeGDWXAQaLUjGlnMejRg6331DIJDhBjKsSchjfD5l0olYBAlf2e8AC0yWOHSBipsJLgNRQOStUOFL6cwTTG4V7zYxCnPNdSxnK/DddmIw5RGz3Z8Ccn5Y+AKmPYtgzmE88DYihY/w6a/cZFZ3i95XSbqyeeEskIoPU12YdkA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(186003)(2616005)(956004)(66476007)(16526019)(8676002)(66556008)(8936002)(6666004)(2906002)(26005)(6486002)(66946007)(4326008)(83380400001)(52116002)(5660300002)(1076003)(36756003)(6506007)(478600001)(316002)(69590400012)(6512007)(86362001)(41533002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w3DZWfivA5KAwwZk7DvdrJCa0nmJEadrt4C+Wx8wDC7nQ7zAQvuDfQSrzaUS?=
 =?us-ascii?Q?mQogvZfbX9Am8bXhR5n1e1vUWxSzgzAPueYUKhtU9vx8Z//JVziAkLw5xXuM?=
 =?us-ascii?Q?Oxpsl/CpYdxI/UqoIg5TyMt4mTVfxMvr/N+fqG5F/iihJsO0npTPfMAaLsYY?=
 =?us-ascii?Q?c+bLOi2EUN+xVpJjzw1Q/mn4QCs6BDx2m0Sx+Rwh1AJI7kx02xCUt0nvdbah?=
 =?us-ascii?Q?GXDi7LlICZkq//N6sS08ZJiqrH2c3pnim4QPvFWyDvy6QNjMH7vNbM8AOCYM?=
 =?us-ascii?Q?wMVN+WHgrya6odHkUgMOfV2C+KCaKmIzrBj7qJ+gbVbOQlB4FMXY2r8PhW0R?=
 =?us-ascii?Q?cAvqHgB222RtgIB/oSIUkPa9cJdbZtnjT6gHWMoG3LEX9XN1/ADlDucdRnBT?=
 =?us-ascii?Q?SSt5GetattjK+pL+QikLoTbtYfTpS4zxVUgGRzNQRZOaz2CJRjhMOUp8LU8U?=
 =?us-ascii?Q?zMR8FBjQSrAZX9y9equXj91JgDzhm9B/zg9rBkpeeKtiGydPWgWK0jdYk+v1?=
 =?us-ascii?Q?Vj+ygM1uLCri/BzYbq/0bQXAjvS37Z/FN3TrJTMviMdFVTfft6Wv6U/MzxKi?=
 =?us-ascii?Q?Yvp3dXEadx1fsHpCBDNKnk12bA7Ewqs3f0vvXp4WvCDH3y1MfZO0gmjByMkZ?=
 =?us-ascii?Q?4msHFLWDnOpf2BfGIJqAfvKId8OdLxf+1SCsuQYpPCe2eESJYrETajcBW8xF?=
 =?us-ascii?Q?Ez2WxBHsYPd3YQs1Da5tggIAdIzfY0Cy2nl3SBPPMofXgfBhZtJO2LS6npgi?=
 =?us-ascii?Q?Q13+eXm1QA5oVWSBGtJCsAS72VsbQ6oSPuuDe766Jq40TkJwaAKiGd5W3VCW?=
 =?us-ascii?Q?wI+s0LfDRLX+KWD5dW39WKxfYP1bPble7TV2x8ZI650XdP80gmK7qu6LDQk8?=
 =?us-ascii?Q?7Cyv0ADzfideUnE3sPMPnVhjGwzOPqxFTRt3kslFJNHECeu36qW34PZyx99P?=
 =?us-ascii?Q?3dObkxmPZ51OYR447wxEI+nrIOH8ZzdiI86kov9zLozavZ3ItDPJLtra1rjA?=
 =?us-ascii?Q?YDgMYTacrwsrr0gGfFYQQYYlO3yqgLVc92Q333dojxq4G+2G7HYsw2x4zbcg?=
 =?us-ascii?Q?sm4oJZMryiM3B8tC8K+S14NlR2kl0o0pAQ4iEyuoTj5tfVz/MMFaqV8IT1N0?=
 =?us-ascii?Q?0daK65ks5Aj+agQUkRMNaF4riNhm4Mq6TTwomcac84Uu8+NDrAlt4rnbXtjL?=
 =?us-ascii?Q?DsRFhPJx/KVy2KMfbXSdJoBR4Mfd6BLM+YkwBfxccF1gmc7wg5ggUS8lJ1r2?=
 =?us-ascii?Q?Fe+kJt5KE6Jj3tyLzSy8e4Bw5T+S06QpUMkVobAfVT5r5SAKSyhId7jQkhUc?=
 =?us-ascii?Q?Zi0k7g8nczPZHi/JVjLha2V1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351d0d29-cad9-4af8-1f9e-08d8df024222
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 11:40:06.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INMNMRqBgXlzlFrFL+uG2e6NUxP8dXY3oeoBwDApm8Yxaa7y8Ciq06Hx7b47LP1vf5y1PHIXahB0iq8QRR09GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6249
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users report that FEC can't work on i.MX8MP EVK board, it brings
inconvenience. The root cause should be FEC controller attached to
generic phy driver, as Realtek phy driver is built as module in the
defconfig file (CONFIG_REALTEK_PHY=m), so it is unavailable. If provide
"reset-gpios" property, it will reset phy when probed, and no way to
re-config phy since we use the generic phy dirver, which leads FEC can't
work.

There are two ways to let FEC work:

1. If you want to use generic phy dirver, please delete "reset-gpios"
property, keep power-on strapping pins configurations.

2. If you want to use Realtek phy driver, please buildin driver
(CONFIG_REALTEK_PHY=y), and had better add another two reset
properties:
	reset-assert-us = <20000>;
	reset-deassert-us = <150000>;
According to  RTL8211 serials PHY datasheet, for a complete PHY reset,
reset pin must be asserted low for at least 10ms for internal regulator.
Wait for at least 72ms (for internal circuits settling time) before
accessing the PHY register.

This patch selects method 1, since users may waste time to find out FEC
failure, in most cases, they just want to use networking to debug other
modules.

Fixs: commit 9e847693c6f34 ("arm64: dts: freescale: Add i.MX8MP EVK board support")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 7db4273cc88b..4f5c2fb33eda 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -97,7 +97,6 @@
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 			eee-broken-1000t;
-			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.17.1

