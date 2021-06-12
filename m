Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081D13A4EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhFLNAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:00:35 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:7974
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230191AbhFLNAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IspSFMlKI5vX1lIXVoZ2mEVidyzSoNOa4YsWVJaej3hov2X4j2sGhS426OKPsaKBfpOJxha9aWBpHUhXoKEW5mbd/kpYvIZX86gjUV9+8GczAJIQkqml56grUf1ZM3NwbiOnryNB5P+FBc8Mf5SOupGZiLS4Qxrwq8rez2MU7sxKKH0OCF1lxL2dg/c/GwG9aZ3tuunTrCTiszRFIJXpev2XXBcetfGF4NBPnrO8WRMJ4gn3CIjiVfETROzka0dMqz9wK5xwu1sja89B8GG0INKN7OcwvQSyI4SCEIee9U3LVHJpPU+iL4W5p8G/zMEHX8cgWWUTWinMVHmMkmnD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfsT/VsvG1Jkgn3IelnwYsr0ibtYM3V4g+QCleJ25ts=;
 b=KHNezXzdhhwvUCBW7NSVIyxZuYIwSp3w1Sa1sJD4UXLVeeWhaEVPp1zSBA28Gb+R5JA6d5iIua79fDLPSYP+0Xo6JX56EVRNG/4wnjOC7/3OviDJp6PqJcsVURRXN1lz7NPE4jqsfophxG/+S8qKzTsGBbywX9utVo02HA7wNmnrW0csFS67Pj1YgLknF4H36w5g1TZC3nE6ygGOtj8q0G29TENmdQvtWajzg8M+MTKUjGFHeWgD4+4bG2PC9IFlUFZy/Qp7yqw+W3uAZNNtR/SWfp3+lelBSghEhSd2EuShdxbhVee7iZ84xu+UzS5T7E+gOKOv17Qo00j447kkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfsT/VsvG1Jkgn3IelnwYsr0ibtYM3V4g+QCleJ25ts=;
 b=YNv39Hz2siD3N/q8avQ4Oa/rz6F/rcKqsiNCZC02nuyoOfQ7Uc/qjbXud2EevZLELMsNjJDniR3lnYA8GdfkW4gFU3TqsV4TyQWKGc7/PIhguu7JAu8fxINpYkn5hhljoJC8hdCjomnhrlVvMfW8yOEVacYfqzc7b2mIApJ+eSE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Sat, 12 Jun
 2021 12:58:31 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Sat, 12 Jun 2021
 12:58:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Sat, 12 Jun 2021 21:31:30 +0800
Message-Id: <20210612133134.2738-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0174.apcprd06.prod.outlook.com
 (2603:1096:1:1e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0174.apcprd06.prod.outlook.com (2603:1096:1:1e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 12:58:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d3d7b6b-a9f8-4bea-a6e4-08d92da1c74b
X-MS-TrafficTypeDiagnostic: DBAPR04MB7285:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB72859DCDC428C62D6A45F183C9339@DBAPR04MB7285.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0n8Rg5k/3hDu8e64je3ef5QQlKwecuPK5rrcT1gXejWqPts2rjktm3Ym4iWn888uMnJ106zd+qBs8TN5c9QQ/a43PGA0qVN2Siuszfs0erzZzC6SibK5Iq1YqsLb5XGAcM+LF6vVFc5dhGYZsb/k/NTArCyEewCIJR77u7sBuOLRDw4USHFywF4ITrUErvFs0l/zHUoqUy3nrFgzARIDNP+dZI2q5qqC/QZSXkEm8Q9wlXrHipUv2o9ZqyGlcc8Wdrc4WmMybE5NQDyESWUUWNW7vY2FE0iW/PTh5sy033Q99UW7GW37sVacnBBy3rdJfiMOT491I5/mqYDWvvribm/nagJmpo0xAHPfCy1x6VAuvqKjdwKwYbJk8PF8A9B0LB76ULwcXs0vlUW20jvOUBjMfdoN4wJLB4GNnqowctKS0amfrpyp1+eQ2ImdYFOPdgAOVH2+Filf/B+Dxn+nRS+4WAO8WQBYryp/YNVDhag8PEfx7EElC9nudPptNRk/kWkg7VNgROiVsRkXUwpQM9+d1+o12CJ/3Y0LTdIt3BKolsM89TgwCDy+X3F7IJELbbnh16rV6e6a8Tua3FOd4lf5veqKI1pAHQu3aYoUqP5sUgBaNxmhuvxrRzqlUljnlgKjHhgY5g3pnSYrirTnZsHOlTnvAWg9074mKT5z5ZITVCpqYQWfIfhUMiMql454Q0tBCtJY6IIXld36C0fseOPpU2KDUJq5yzPvfRfas2JXpdJH0KdyKInRoJAO/bi6uoW0XjtYwOiNvwelDRnXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(6486002)(6666004)(8676002)(52116002)(2906002)(186003)(1076003)(16526019)(8936002)(26005)(4326008)(6506007)(66556008)(66476007)(66946007)(6512007)(316002)(38350700002)(38100700002)(478600001)(2616005)(956004)(966005)(83380400001)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZax11Whw4pLnvZtZ8kJxnLamPTcUTwj4VJghez+Mp6UtV6yMa7zuJ0ZXPg3?=
 =?us-ascii?Q?U9/FwkS9gn1qYboq3H5dIreZiI9Dzb9SWAXKrbyyw5w/e7DPBuYqIB46Q/h1?=
 =?us-ascii?Q?chx6ZU4TnvpSOkdICrQ8jV9xhFsj8RSFulv4RpaUy/D0av5yYVnbkscaPxKf?=
 =?us-ascii?Q?nlW4lNrGy/wrw+ykumTmIBBi7GjYUGZiJzSvSiR6MgRLE2mkcIz0uWL5UQT/?=
 =?us-ascii?Q?RCOAOi99r730+MlgFzmfD8tkMw9dwbC6FUeB/xPAiqaC7YK+K2Au0pLEWvG2?=
 =?us-ascii?Q?WW/H51a+8E6sJRg8jyGH83HDV9LRDQHn1+L/hd7VH0OoQlBDkJ9yhqNbC48W?=
 =?us-ascii?Q?BQBu/t/Fuvh3PNz1qpCf8aMc3+xUKQqHBGI3GInk98fPcKrgYggsMeX+aFIl?=
 =?us-ascii?Q?YFAYqmp3TU7WA10iINIVv0QiNGLutMSRZ4lta+xht3tanbe0wj5SW117AqWF?=
 =?us-ascii?Q?XDUP4tf3RJ/62xPxX8y5dcaqBU23inbu/tZ2RnUbUKk4x3QAnN4cxxYgZuJP?=
 =?us-ascii?Q?Dee/gY3U4AFEyGxgrmPXvKXxN9k27H4rpQ4alupdFx7dr7VSv/LyhF9OCYU2?=
 =?us-ascii?Q?9yNm23AlQt6fSMlaDn3DPmxv+n+ix5QsjZ7DVLPIIsj/xIfLpwWJxW3ABXaU?=
 =?us-ascii?Q?JuOKJyZv4I77MWJGInTjRDPFALR1TLlPwvfgx71wKF4pAA2bHIXlR1rJwDB9?=
 =?us-ascii?Q?0JCraNZJzdgOYGhUPqZkCReV6yrSgnw7WlkpXCxp1GTPsAF45IIk9ZmkjTw1?=
 =?us-ascii?Q?wkL0IcQfDKzNmhb68+/2eru4kF5tD9APyoQiZShTk98uoXsfOt4tfBdmX7/L?=
 =?us-ascii?Q?QC/XyyOvl7WYpy7NiQ3WVZGycYWW/hlFsYW+MnHulgHSgQIMRbn8cjPTfvPx?=
 =?us-ascii?Q?8oDjOVN/FupmnaOhIVWygwZjS3tyXxczd7toGxuTpQpYUyeMwH73uakhMQ/y?=
 =?us-ascii?Q?XYCjBefV/HCydQAKKAb0WtYHxw5D6ALYDvjDAc180Ee/uoYjDt0/Ki9smyKR?=
 =?us-ascii?Q?XHAEpIqv8btELEOWeizN4HmtWKtPPulogsnIE+eatJahTSdmdju8SvQ2UJgP?=
 =?us-ascii?Q?lpu28JnNaSVNmSymOrlDd/0D/xFTQaQUlPEh68F3b+0txiRxynO8RUvuljil?=
 =?us-ascii?Q?oMWtQEz6M6Ok7wHdue0F1GkvOL9Us7quBEhi87LGLgeCu7HFD60DVrJhSanU?=
 =?us-ascii?Q?HNLOs86OomTAwTdVjouJ6QGgXv41DW+sVkKfxmf5yn3QBRq9rYOxUeJfWC8A?=
 =?us-ascii?Q?DE1UOYc0Y4oA8fGl+bNRSvs5tk2g/9hY2OLOg3cdfOoCnrWL++d7+IZSuPLd?=
 =?us-ascii?Q?0TaSJg6cPRJhQuBTPRBgXoUl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3d7b6b-a9f8-4bea-a6e4-08d92da1c74b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 12:58:30.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RJbhXU99wdrekka+MPUpIl3TqT4eENQu9OU8xz6a5CGmUrCCDDKkID/2Lg/ZwOTilJm3hqHekn/0LGsNcE5kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
 drivers/soc/imx/blk-ctl.c                     | 325 ++++++++++++++++++
 drivers/soc/imx/blk-ctl.h                     |  85 +++++
 include/dt-bindings/power/imx8mm-power.h      |  13 +
 6 files changed, 629 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
 create mode 100644 drivers/soc/imx/blk-ctl.c
 create mode 100644 drivers/soc/imx/blk-ctl.h

-- 
2.30.0

