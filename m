Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763043304B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhCGUyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:54:07 -0500
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:51808
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232830AbhCGUxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:53:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8gexRNIkUVninAn114oEC8w5vKgLhBWPd3qCdy9/sskemL2EGlQGn62nsiO0R68eiREuxD5bo4H84qPTW7De9EGdbZhtl+5QUv+B4z+UMs2cKfACOmi16YS+muvCRrAzVs72PeiEEwpZ1GTTLKSC29o4Fw6eXAH0yglYQ0EJqCc68yB+MvM+EMI2R7s4+t4ZvFdvNzhc32nDwRRLNEXpQIRuk0shxKuvXI/Wapyd6+ViRc1kcERHKiPhc1OXLVtxwFvKOQXUSjOjo5DyzwVKh2rQMTAbAp/k/IXCMjPZ+w6rbNF1AAMTj9ycp3CqAHshJaTjSfprIloJw4dk2W+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq7hNhPiCxhyEBrA2QV4hSkLxLx747FyrWVOOnTGIa4=;
 b=HHMX0LPby1m9KVIoIUpzy09D0yGzEcIsP7tlxM4l0Fsxf0Q4BfkXL+hrhpku81uQu6oidNNLb72Q2UxxfMcCvh1km3j7c0WvMDsCzT0rr8qkXYlbCPI0J1GwFPZPy+UI0IrHilf/pg5oEox/hp7tcW+iKqVFdTZiEreVUe1JtVupm6PY3xmRe9mpHt4qMFygNGh1jrOjzeamyjRmr8gifCGfuemGFmPFVqumREXIUCuyyQPMg1R8Ga6o82Fj/1YSWbieh4IdjeRAbyjFPmESPg5ietDFdC/bLxhTeRhdQWyi2/z4z7NpGh1rvLzy0CTo3dUS45n5A9PfJDBqgY5QVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq7hNhPiCxhyEBrA2QV4hSkLxLx747FyrWVOOnTGIa4=;
 b=Cs5ExsdZn0FeWaevH4D2X9/mjdtCaWFjgYhm1pnEHPdoqm6k8GQ2JNoY0xAjWSQjCXMQITZvKuWZ1O/hObrrof/u+adyiJcjhCULoL51xuyooGAzj1H4URUQjKi2reJzfBiM+KH/+lX2MvlKdypjtiqJ1Mol2MD0T3ORD4JpEM8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 7 Mar
 2021 20:53:38 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.026; Sun, 7 Mar 2021
 20:53:38 +0000
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Ungerer <gerg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: ls1012a: mark crypto engine dma coherent
Date:   Sun,  7 Mar 2021 22:47:37 +0200
Message-Id: <20210307204737.12063-4-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307204737.12063-1-horia.geanta@nxp.com>
References: <20210307204737.12063-1-horia.geanta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv15138.swis.ro-buh01.nxp.com (83.217.231.2) by FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Sun, 7 Mar 2021 20:53:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbcab94f-6b86-4fcd-2ab8-08d8e1ab154b
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3792F4BDAEB56AC718D6FFAC98949@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLeGuU4Q4AeuGDb74UU1xrtKFK8+5uYB1GNaKzspxoOKyGxN3e83gyqiiPvykHPyYlP5OkowJH0DxmGKM3p8qZzT/yLMhwDLaZT21hYHFQB284WEO2eBKzf5qvLkZgOJUcGVOO7tUsA8vzIqOe0HAhYOy0x64JQZ6SgJ81k/EfxAE1z6HAi0+EimxwqLB/T7u545GUCZYX+hm2kp3Y1pbpyEs2z+dOQ8FFfpIucYZXv0/c3ygq5LNbBod7Wt0ml7NE4KUpCyGmJtp1oWG8pRrYSMM32dIXtDZ2PyTpAGDzSTZqfYp8wHT5u9ZcwyZ47v9MsKqSU2t82DlGkbJ0H7dlmAiHCFOYoL22aAYNltPsNCfNHn4FxcPaD/OWkuhvVdLILrLc8M6jTEDMDyR3Z8EqYDgnyu7GYCOqC80Oi5nDeuy+Xw1SHpVRXr5oNWrgAMqa7V+Q9Dfgm0LFE160x7ouPZcQOPTM0AhduoHejPQGL/3Q6zNvES6TWcQslOtWHkmtkd762HSspS/0/jAu6eJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(4744005)(2906002)(8676002)(5660300002)(66556008)(956004)(54906003)(16526019)(66946007)(86362001)(1076003)(110136005)(2616005)(26005)(36756003)(66476007)(316002)(8936002)(186003)(7696005)(478600001)(6486002)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OFE4MHhXMU95YWJPL0EzVFk1dU9XQlZjaTN5SFRURTV5M2ZlUlViMFZPaWFq?=
 =?utf-8?B?ZFlwL0J1OXFBSFZpajdDbUpKUE1vMFdMVE5lU2E4NUEzYVJjK1JkVFYwUmsv?=
 =?utf-8?B?R1JIZ1hkQWFCdFlvZmNNcW9tdmVWS0lNenJlam9VVWhKc2dYd2ZBZmpEZVFv?=
 =?utf-8?B?MkRVdmRsdFNKZVNuRjlPNEwzejFGcFVaMHdYaS9oNXBaNTVKTkpWU2pTRGNK?=
 =?utf-8?B?WC80RW5UTmtBUUNLazM0YSsyVHIyMDVLLzBnekFMY1NvU3pCbll4UWd4dlo3?=
 =?utf-8?B?Tzg4ZVQ2QzgrMFlkMHl0ODluZ0NhTUZ4UUlseFM4MFRneHE1QlhEWC9HYmEx?=
 =?utf-8?B?SEY3aUtYbkY3ZlVEWG5KZE1NVytTVHdiT1ZpZ3ZIYjFyZ01IamQ2amYzdmNh?=
 =?utf-8?B?V2pHZjFFQjdQNUp6SEpLRjM2SFZWdVdVenZDcmZOL2x0QVZiS3N0VGRLNGFy?=
 =?utf-8?B?TkU0MWxrZmdoY0NIeXdQQjlXa0tXVVh5SDB5WXJWcUZVV2EzRU0ydzk0WHJm?=
 =?utf-8?B?WU92SVZSUWlYNFljN0dRUDhYV1ducmZvRkk4bUlZbGpPSER6Y0lWaGlXU0hk?=
 =?utf-8?B?eTJUSUF6YU5CU214OVFGSmtEVllSUzJoMmYwbVA0OWQ3a1Y3dmNMVkFEcFlX?=
 =?utf-8?B?L3hVczZ2SS80cDN0R2Jlc2RSdWVFWTN0K2dGRlp4aTIwMXJOR3NIalJYMHoy?=
 =?utf-8?B?Q0ZrOUcxQjgwN0FYWVFrWnhaVE5CcEpjbmJXak9CekRkaHppb3phR2U1QStV?=
 =?utf-8?B?RkVLWDIrSEVreGd6UUxCdDdIQnczNWdJVGVIT0pEWGtIbWlOMVNVK3lTV1BX?=
 =?utf-8?B?SDE2a2ZPNStyNmxMVkJ1V1A4RGJDWlJPVEcrT0dqUnZCSTZVcWFMR2lHQzhD?=
 =?utf-8?B?NlRST3c3TVdMV21yUStSSGM1bXpoSFluRkt1VlBLUC9BSWgwaVArM2lNM3l2?=
 =?utf-8?B?SXdBNHRDL012UEhOcEt5c2J0Y1pESlY3YUxHZUdHY2twdjR0SkpXT0Nsa2pF?=
 =?utf-8?B?MEZqQjJwbWdoSGUrelBhby9IMDVhYXFTWUhvREVna2JWS0xpeGlBbGIyZTB5?=
 =?utf-8?B?KzlXYnBjYjA0ajdJd1Jrc1lTWklBY2hmVVdLTmFvV1Z0dUdzaUtmcEpUTnZ1?=
 =?utf-8?B?R250V0NOSDRLK3pXVkF5d3pZaDN3TlEya2RMTFB6NUN1TGdhYkZXVWZqVTNW?=
 =?utf-8?B?S0h5bmY1TFpQdTFIV1lKL2JKYUhvUmpIdk93REtFL3NsS21raHl5VnI0RjJX?=
 =?utf-8?B?N3N6UXpOL0sxZzlCT2tyUEgvd0hUMkJ2bUl4VTljQ0xITHdOUkg4dndJY056?=
 =?utf-8?B?bGhJK3cxdUgyQ25OMmdDMktlRmkvT0x0Zk5UNUhnU1dhM1Z5YmJ0Wmo3VTMw?=
 =?utf-8?B?K0VNNk9Nc0E1V3g4TU43cjc3a21QWllwalkvaDA5OFluYzlHRHdwdksxaXhL?=
 =?utf-8?B?M2F6eStNWkQ4RTVydk14SGRVOWczdlVTa3pFbnVaWmM3NlUyZTFtQitNU3h0?=
 =?utf-8?B?U3BCUnZPSE9uRHU3RmtCL0R2R2ZUVENIdXprWGhsai9hZEVEYlhhVUN3S3lT?=
 =?utf-8?B?ZlQzWGZ4aHFJUnBteCswcDQzN1RTOXhuUlM5N3RUcmhxUjl2eWRycHV6b2tX?=
 =?utf-8?B?Sk9sLzhPOU5QRngvT25qRk5hQXRENE5IS05TUGV1eVU0M09QNEFBczIwSGt5?=
 =?utf-8?B?enVrMGVBVVVienJyaDlYaWR5TlRVVCtGNlRhTWdSVHN0S0dQa3lXOXlwajh2?=
 =?utf-8?Q?wm5gmL6G2AkBHu64NIgteREbYKFz75q5lmmoh/G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcab94f-6b86-4fcd-2ab8-08d8e1ab154b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 20:53:38.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPCuz98rppOSRyOl0pe0UdTG+g+1O0I+1U5zTHMDMbUcHbDva11ls/m4wudXU2XDoHdIw89iWxLUl+MU+m4IIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto engine (CAAM) on LS1012A platform is configured HW-coherent,
mark accordingly the DT node.

Lack of "dma-coherent" property for an IP that is configured HW-coherent
can lead to problems, similar to what has been reported for LS1046A.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 85b85c569507 ("arm64: dts: ls1012a: add crypto node")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 7de6b376d792..9058cfa4980f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -198,6 +198,7 @@
 			ranges = <0x0 0x00 0x1700000 0x100000>;
 			reg = <0x00 0x1700000 0x0 0x100000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
-- 
2.17.1

