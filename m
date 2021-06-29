Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA83B6E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhF2G7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:59:02 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:54081
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232134AbhF2G7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:59:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjldUdVSYFX/pn55hIXX/bR6VaIaJyr/pguP7cG92w/2r8xJtyLCwxKJpBa30fG6SueAFk+zcJKs+rSDteXvjhhHqwj460wcAQKCa0lwfLM9myqqQMBQQvSMgOil1+EyASgpZIfAWX5rXpI200HjdsA8jmSu7dKMBC3EZMiHHuQJPtZ4QsAgcexKgXc1VcrO78ara7cbu1LinnFk+Ns1cQRCCTHYywBtz3TAK2xxodkfu/5t79Ko8C1ob7tG4/bpavXqZmSSmDwxWaO4DvbgNoZeXwMOqcxyRiEcoM2/2OGD2xSCN7mxJa65WVpvwzTdkmTrFRmupmQU42mXErRVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5FbmMxwHkI5T1f9FWQ9WGMiW0LRMl2Poy/8doVo/WY=;
 b=cxYB6C6+XS4QqeY/Xzw37hqSFQbUo8mT5/KLSr6BB7ExmhhiuKdPuqoVCOOeJ2rmTWOKcu/u6RGafPE8zROSJUelqGbOSOciZZG4LxpsniEewuQs49UFNyz+VFyhBOZqZOTPpnjPDRYblwjxJK3j1kkWWzxvfkoOJ0ji+NNaHiYGdKWWKitFi8FoMDaRZCIsrsSz0d27UtItE0h651SQ2Wgg/zwDcBhE5OsJ+1frlDpFkFQGonKsiuXJQoQgaewZCN3D9+Eh/lQCFEEUNjwHy9j8cfVP57J65XZ96upd5YZV+KKBXvfvnReD7DwD8YAtqWAtEwMku6qeXTGTnrDKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5FbmMxwHkI5T1f9FWQ9WGMiW0LRMl2Poy/8doVo/WY=;
 b=MHJcHHFY+CoLQskTgqQFFUB9RI6S3DDjGLyB/IF4pBVQbmqlQjJei9VarEmLMApLf3aj7X3y1hTVl5Q4pBvOBcnGUV/ADs62s6tIXhArpjK6Kwu1HF6btxubiMQw6Qum4WbN1qNgDO9gySFhzofBPblknPieg8vOovPVEeVCRq8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4762.eurprd04.prod.outlook.com (2603:10a6:10:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 06:56:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 06:56:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        jagan@amarulasolutions.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Tue, 29 Jun 2021 15:29:37 +0800
Message-Id: <20210629072941.7980-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0116.apcprd03.prod.outlook.com (2603:1096:4:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Tue, 29 Jun 2021 06:56:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38687df6-828a-471f-fee6-08d93acb0439
X-MS-TrafficTypeDiagnostic: DB7PR04MB4762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB47623F7774F72AEA3DB24C91C9029@DB7PR04MB4762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFlt9wkd2kgDjqxG3ER2ac7+r0g/lW0nktItg4EHT9cI3lOvaYAO+Xj3Wjx4pqvx/izUiY8mGMZnebduF5yYXRk7zWorQC9s/oThPgPPsWcn6bi201pFoVahyCqEMMNDA+T2gDfWq4wN/lXhicjazBa4+d9H8f6yWJ8IRrUcy8g+zsil4KQRZwuW+QB5yOvG/CpVYxy7ocdyXixL06ziANvvukAMabinEABy84daJRIHRGK1mLTITm47i6JlOcOlTgaB6Jdv6JIJoScPrmCa+LzdRPlwUKT+5dy78qidSv4/8mjstvEwwGPwb/nDT5a0lYtTuD7Zb6Jv+hrwW9i5CuN2iKuuhxkKA1ljzmz+5OezL+31ZBWhslrwrHezy56IxV3M6NWs9oXG4yv18v3N8X5DAtB+IRvdwic6OVHSB3tcYy8igXa7orOnyhL9gafygh8FpOf9y4ZhdGkeeRjDIm0Ah5yUXHJbB9z7ZxuNlmmSevfuFSGmJL07ID1f1FBJf152k5vDvKFj+Jm5UGJnXRWUQ6mEl4GNqORJeRt/GbmHm/R/Abi2fNaBisqs2SNDRGBEr4Z5TJa8SGeApMJG1/Bsv6JW9xl7VIAAE+efqQIdNnqrgO6x0AyFXF6rTwpjvALsL98ExVdP7ypSFUXIjjnEoqjPmnbVYhxUP55HKpPW4RwXnrIwf+d+m9moajxVIqMR2H5ujxJbiPKWt2Dl5BqRciACfkfp638kDGBa6lCZqldIoSwyAxmVW1R0IHz8RTbz6pNZvw6U6gMZA8g7iSt5aUOciNtUJKbKoYli3kJ/qNZDfvHZvsFFHlAkVpiF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(956004)(38100700002)(1076003)(478600001)(316002)(6666004)(2616005)(966005)(5660300002)(66946007)(38350700002)(6506007)(66556008)(6486002)(66476007)(83380400001)(8936002)(52116002)(8676002)(7416002)(86362001)(16526019)(26005)(186003)(2906002)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhbO3nMxJRItKrcIBEZq8c9jo8R5Et/xuqQazkKBqX8qd0vZwr6RzLXfR/Ed?=
 =?us-ascii?Q?ELg+DYBXdfGu3lWu5ov/Vw5ZIxD2TpG62SlsaU2KghzLgUGtTE9YjpzRNEt3?=
 =?us-ascii?Q?XQGp5D2sX6l/QkKx68uJs2y8SoUCv286HVzqtYgOY3PAG//va4DRygGdezRV?=
 =?us-ascii?Q?ot7/Bit9garRT1UgA1GK6IXBX8cQ6eea74ilBwH++CSQX7Hu6FfrTY3QkIWV?=
 =?us-ascii?Q?UD0BJOA9RvrXzRLKLDR4rPR52v2j48J7fuzsvf0asGSTUpzD0Yagkd1FjIDG?=
 =?us-ascii?Q?Md9DLpbqOMFFEJ8OwMYjyf3+idY9zSskov77ULDThvxk+xR5bB4Gdev3oLeE?=
 =?us-ascii?Q?UtoD57Itw60po8cNOKu+fQ+smkgZP2toIMFEYe9lwNk91sBiDQi10JSh6hBk?=
 =?us-ascii?Q?aO5Ynqij9AfvymV3lWhiNASLtZ6Ilg+fsXuK3MgkWdfbal99i6TCkhi28Ekb?=
 =?us-ascii?Q?CtcBMxBb/UWnTgLQEg42KvO0UvF8J4gQrGs66bdQcVgKa5kv/CTHzSzryMef?=
 =?us-ascii?Q?xMV3J8jjzDMQGWhJ3icHO0A9pSZcF+Su2+78ji8QPAHC2fuVJcwtNejUzbhk?=
 =?us-ascii?Q?y8R1KeV1O8SZSiguXrOPJ0RY3Bk6T3leyM6fV7G0dFDk4Hi8OWLGDxQuLykC?=
 =?us-ascii?Q?dsXQWnzaMYakK3R4Fb1qQxeo65tmpm1B4U2FHg+nsOXL+JSUfpHGeI3AsC3W?=
 =?us-ascii?Q?yNaRa2HqmRAsfy0i4ze13Vq6/nXQxMhFZOj1aB8FWMz5AwSlFKWRGQuHstth?=
 =?us-ascii?Q?TMwMxAUydpeV4mWNlJ0ZZI24qJwLmLC4b5JwGtshADfAg1qpAc8SWhka7bv+?=
 =?us-ascii?Q?fUTBLW5GuhGSPNiZtUmJH0kXpIhaKHgws2INTyh4uXJA5SRXv3ZDV15a15q0?=
 =?us-ascii?Q?zNL1tB+ddveqbx+63vkX6EhOrqWkPqgB9TKdYqdeQUr6SKzhnutyJnF0tz7Z?=
 =?us-ascii?Q?YP7RIkXwEJIGbbseaU/MnKoUU5U0241SIDUuANqqxXSCX4GZvx+2Bgs24dku?=
 =?us-ascii?Q?a62iBYq1sSHNmDReFK1ARgmoEKDn4f9hB0weDgAY1knn7HMRgd6wSQPwdf2k?=
 =?us-ascii?Q?tAW+6/zq1k4vVp1Kg9d2JjJTtY9EBV1cuNjRQtUYHH5QHplW8/RBl1m80+YH?=
 =?us-ascii?Q?VDQQnN2gXDfr3jyOYUL6o/ONTqh8HF3+uPxhjpRxnIxJ0BdnnvoazOJRVTtI?=
 =?us-ascii?Q?WMo5N5H+j2qyb0y/gCz1bBlh7sngug8tmsneZ/7Fy7ihuCZ6EdenE1iCH3nx?=
 =?us-ascii?Q?tPtl8d3BhgL4FRBFlsxxUlGFTgpzKWsfj7JGX5Tg7uGBLExu384ECAbSudW4?=
 =?us-ascii?Q?FLoyFAkAH0MJifNf6oNYh3rA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38687df6-828a-471f-fee6-08d93acb0439
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 06:56:27.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJvMnnf0ivBkCHBY6xIdrOa4EJbhR5kmxcFO2/VOCHepWIVqPnRGw+8Lux2nKCQNT557L3yGm6a8covTO/SgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V8:
Revert one change in v7, force goto disable_clk for handshake when power on in patch 3
One minor update to use if{} else {}, not if{}; if{}; in patch 3
Typo Hankshake->Handshake

V7:
 patch 2: update patch title per Shawn 
 Patch 3: Addressed several comments from Shawn

V6:
 Thanks for Adam's report on V5.
 Resolve the error message dump, it is the child device reuse
 the parent device node and matches the parent driver.
 Filled the remove function for child device.
 A diff dts file for upstream:
 https://gist.github.com/MrVan/d73888d8273c43ea4a3b28fa668ca1d0

V5:
 Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
 domain to fix the potential handshake issue.
 I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes
 I only drop R-b tag for Patch 3, since it has big change.
 An example, the pgc_mipi not take pgc_dispmix as parent:

	pgc_dispmix: power-domain@10 {
		#power-domain-cells = <0>;
		reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
		clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
			 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
			 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
	};

	pgc_mipi: power-domain@11 {
		#power-domain-cells = <0>;
		reg = <IMX8MM_POWER_DOMAIN_MIPI>;
		power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
	};

	dispmix_blk_ctl: clock-controller@32e28000 {
		compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
		reg = <0x32e28000 0x100>;
		#power-domain-cells = <1>;
		power-domains = <&pgc_dispmix>, <&pgc_mipi>;
		power-domain-names = "dispmix", "mipi";
		clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
			 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
	};

V4:
 Add R-b tag
 Typo fix
 Update the power domain macro names Per Abel and Frieder

V3:
 Add explaination for not listing items in patch 2 commit log Per Rob.
 Addressed comments from Lucas and Frieder on patch [3,4].
 A few comments from Jacky was ignored, because following gpcv2
 coding style.

V2:
 Fix yaml check failure.

Previously there is an effort from Abel that take BLK-CTL as clock
provider, but it turns out that there is A/B lock issue and we are
not able resolve that.

Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
as a power domain provider and use GPC's domain as parent, the consumer
node take BLK-CTL as power domain input.

This patchset has been tested on i.MX8MM EVK board, but one hack
is not included in the patchset is that the DISPMIX BLK-CTL
MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
DPHY driver, so fine to leave it.

Thanks for Lucas's suggestion, Frieder Schrempf for collecting
all the patches, Abel's previous BLK-CTL work, Jacky Bai on help
debug issues.


Peng Fan (4):
  dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
  dt-bindings: soc: imx: Add bindings for i.MX BLK_CTL
  soc: imx: Add generic blk-ctl driver
  soc: imx: Add blk-ctl driver for i.MX8MM

 .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
 drivers/soc/imx/Makefile                      |   2 +-
 drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
 drivers/soc/imx/blk-ctl.c                     | 324 ++++++++++++++++++
 drivers/soc/imx/blk-ctl.h                     |  85 +++++
 include/dt-bindings/power/imx8mm-power.h      |  13 +
 6 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
 create mode 100644 drivers/soc/imx/blk-ctl.c
 create mode 100644 drivers/soc/imx/blk-ctl.h

-- 
2.30.0

