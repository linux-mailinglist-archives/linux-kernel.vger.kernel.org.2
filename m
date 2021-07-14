Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458223C8455
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbhGNMPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:15:44 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:3072
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230492AbhGNMPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlrURFqV1//FxDd0Ned70vkp1sVCWEJLpBSqIWpcTjvrb1i1Z6eR+hrXUVaeEujcHPkrlcsMWDa2KNKvMvuitHW0LdyHOAokgikaZWvekHsxF9yy73M+143ojGjMGk6Ch0F0ZSfQvZNEvB6ILkBpqoAv+Zm4DelxfNWJ/RKaGNfsIfnW1krJVg23pyFSlP25XmxbCaMYYZttkzfOf8nWqLumqiNUmuRCflgkGMADlTPUJSYRjHpIsOZOKfIiVpbbhQbJfzT5/+eNhXFnRZDY12vvfFeLxcdxZNCxAykkiG8zLjdq9WbijkTaxJOb2WQEWwnOBZwnl4JNRYoo81gtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHY05sJ2JXxPODGuFoNpRL+SuPRUyDgmVYPPbbsgU9k=;
 b=PNzKa7m5657UH5RTxUuAMnmirUbGycx522/jtzV6VJOUfjcCM8sdFzC74AgJgV4JsYAs3/swoIXmJ/lf/nYnS4oD+tXqmhLUtHCbJi1hhZiuUCTqhn7ZbrKY9enljOAo6892oreH/PlH1jyu+lhGfkq79iFEtEJW4Yfo+4r9lxNjR3WAHXwqydAUkyZpEZxQOOLnG0d7kNuhP5dgfuCUY4LtMZYtFcFd9SAojvXVbMxo9ytF8v741breib45ujBEL/vbLqSKjz10uQyOynnMJXpSIAmGEHj7h8tLrd24psWI+EU3o3abuMWqEtykEPRikJNH0HuUPd3MQoEVN/pkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHY05sJ2JXxPODGuFoNpRL+SuPRUyDgmVYPPbbsgU9k=;
 b=I8SKAmu5x83+rljRVmtVJAOScI1VNhhcr/OWuv+PHbZz/paZPzOuCicNT2q98lVrgNyad3/QEdPD5i5nGD91DYm+bRKzz2Edqf7VAospiEMGPSbF2zPKCvkIWTzspJfADc67BCUPhXJsckf2DiL4AY+pMZR0GTh4EOsxTtUm+wI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM4PR0902MB1748.eurprd09.prod.outlook.com (2603:10a6:200:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 12:12:49 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 12:12:49 +0000
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
Subject: [PATCH v1] arm64: dts: imx8qm: added pinctrl for pciea
Date:   Wed, 14 Jul 2021 14:09:19 +0200
Message-Id: <20210714120925.23571-4-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714120925.23571-1-oliver.graute@kococonnector.com>
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0173.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::42) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM0PR01CA0173.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 12:12:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d150b90-f3ad-4c44-b8fa-08d946c0b29a
X-MS-TrafficTypeDiagnostic: AM4PR0902MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0902MB1748985DEBBAAA16B6161903EB139@AM4PR0902MB1748.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uovmAYeFwd8dlIVpPBnJjjrXD3u/qjFfUSr5CbnEHt/8FpSrMH9GLBqzwfbjFslLDkPfKPmx6Lk5C2bSBOWvSpm+4KgiKIuPeC8v7CRl69NctxAQtqEmwwoS4dT0khRxDW2orLAhNLJNkOdw3FwRTLMQTR622bqAGAILXnjsFbjRuGn3Zkak57wmTzm8UqwRVDPMWnaUhkjrMdDhmXSLLcQa9jzGLWKjRt8k1m356lhwdGVbfUrvfXJ1PW+yyQIitLCmuUql0ZYdDEFtfdsStpbJQDMO+qsmivzUtvStZXGx00XE7H9r+cZr9s6YG2h82u9CklXth6UXoHm41m2w2bEMhtru5/8cRQ0IjU+CTqPxCguMJA2hO4e8/2KKDadEDzQ1poiem76C20vEDMj9qwAVANf0F02GeRhgR4LxUUpvj4ONQQLYhZBkItWd2nOgMgfABP0P2q19PPPv+iBnKlCHrF932a7P42/0UVItxXzIWfm+lD7yrSjYpf7a0gYgxPjmHXSzfyCSF3eauLbMZ7ByM8QFiGHwBY3QhucRxPWstI9TjvzujneyeWYVKYueJ0m0OO4FXI5gTmzcMUZGQyGRRpWQJv9IeceLdeiKpHxuWp4O3JKFn5SbeNuGEJ/i4smSCunr/T9FzWcDy2S0fkg+EJ3LutzM17vvkMevuUF9ikYr6B2KpyPP9q0w+uDN3UYZwlRTV+fguULF7no5EYaTmdvODJl/D3d14ixB1g8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(7416002)(1076003)(316002)(4744005)(6486002)(8676002)(54906003)(86362001)(38100700002)(478600001)(6666004)(956004)(6916009)(36756003)(38350700002)(6496006)(26005)(52116002)(4326008)(8936002)(66476007)(186003)(5660300002)(66556008)(44832011)(66946007)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dazn+eFuZQ0bckN6JMMtKbiYEMxE1oc1IQDhtlm5iRRdbaJRGgdI2CEA9ewZ?=
 =?us-ascii?Q?GEGmpb4sSmrOebl7vIRBYpXT5hel0wbWl9IlsIpIVyZPqfmuytzT2smq69RK?=
 =?us-ascii?Q?KsmIeKNcnPWRGHEhKqTiHb8ZbXgK4nIlk4DbLySgvfZSw7YfDguhITn41Neh?=
 =?us-ascii?Q?+PW7hGR5PaFNA6Cwgv+f/W0FLcZkcFRr/BNZKRva/6vYVZLLQMcc/r2NWXoy?=
 =?us-ascii?Q?Xc4ddH8Jzmk4jOsvjgPhCPMu02pRBHZj/PMZ8f1XdLUPXt3DJAemMgj+GMVJ?=
 =?us-ascii?Q?ituXiwwAzUTo0GjfaPsmBe7gkHN5M8HzNkrOp9MG7kTy+bmugGSLGRdaIisw?=
 =?us-ascii?Q?Z/uxb25zZWLVqt4nI10LN+v038wmOPC9u5xkk1TDtid79130UgmJErg6yYQi?=
 =?us-ascii?Q?gbQnCZAQ5MO2vPuw7mA6/PQgAm3RHAZu5t64w+gUi+FlqvzkK2+tT2UWgxBS?=
 =?us-ascii?Q?6zDijB3r8KIpL6/NymuQpEoASg0IjRhArPWNJK6RAEnsOCFUhsAC/guyfwco?=
 =?us-ascii?Q?dMXrUDMSLFfpy2dyFoWKJC+l7GVU1xq6dl0nkQHTwz3sr0aup4f3IS6HjQz5?=
 =?us-ascii?Q?bsK97HWt2GNJyitdXq2Z18kHAiWCkSyMVXJIvz0BGXpAGk32cAbLNBcHRBAV?=
 =?us-ascii?Q?+y2VA9zfzHELYp6eXJmUyOcXL4WB39pVnGJKaSZ1m8DmXo/qJriOx61jwtr+?=
 =?us-ascii?Q?V2+HGD/t9lro3sSjuUKkT3ywhv1f7iji4Hyw46fE4TNxoeFl4q+MyO7lYFpN?=
 =?us-ascii?Q?2cl/fwLHjscjdDHWQuLTALHHxru1INSj6VPdY3crca4xksb59LEaxjeFiFZH?=
 =?us-ascii?Q?RixCDHQQjngk2+Yqb4Vb7vN89Y9iIC9tGre0I7oAQUhQHiT8kDXnYk4DgeYw?=
 =?us-ascii?Q?NH3JqFWYwerZPT/m0q6Ax3oGEP8qkhXY1HXbi+YldLheWDTo4OKmWtsEP52w?=
 =?us-ascii?Q?yHMKgIq3f1lvYbioeljrHc8nZr8ahvQ5PLC+MCfhXV4i0aFtD+vYy6LSwJwZ?=
 =?us-ascii?Q?ArxdAUe+cyankfI3ggd4HccFXjaJ++pYRoB9VQYbA454Xssl0MOFlnw3OH1q?=
 =?us-ascii?Q?L27IDFBgR/9araj2aK8mEtL/nBedpljI8rh/6RWEjzu26m9VWNQ/oTfy3fus?=
 =?us-ascii?Q?isH6lP/DNsMfMsjmoaU/pDuprpfplRapY9pCDcRIAXO2KPSD5IgOkWHsvFSl?=
 =?us-ascii?Q?MBvHAOXmmjUB/nXdSMu9Z4sgBC/rtS7c/i/4OQrLzt4Cfod9XO2hwh2O3plX?=
 =?us-ascii?Q?Cn3iLe3Lh9ZXAPmgT7Jae1ATU4PimUS/XA1kIsCxZBwCXqI79a0/VpvBfoj9?=
 =?us-ascii?Q?pEYnijQoqJG2HrXMoLjX+Kij?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d150b90-f3ad-4c44-b8fa-08d946c0b29a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:12:49.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/mvY12cejMY40O1A9ahgTd37YOtS+OEHS0iwLYWXaK6vcbOPmith++Hg0Z5mZyY2VIH05L6WMz+7vmPj7RunWPweMuoOvIB83waQTkMqR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added pinctrl for PCI Express

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts b/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
index 331eec2dff01..466f8c5c3705 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts
@@ -174,6 +174,14 @@
 		>;
 	};
 
+	pinctrl_pciea: pcieagrp {
+		fsl,pins = <
+			IMX8QM_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO27	0x06000021
+			IMX8QM_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO28	0x04000021
+			IMX8QM_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO29	0x06000021
+		>;
+	};
+
 	pinctrl_rtc_epson_rx8900: rtc_epson_rx8900_grp {
 		fsl,pins = <
 			IMX8QM_SIM0_POWER_EN_DMA_I2C3_SDA	0xc600004c
-- 
2.17.1

