Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648F3374E01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 05:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhEFDon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:44:43 -0400
Received: from mail-db8eur05on2055.outbound.protection.outlook.com ([40.107.20.55]:10592
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231336AbhEFDom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:44:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpwsSxTwGuGbI9LpiC7GTPT8Z4FyiYLpWyy2khMHFP6BvrrSHAP3dr8eRqKNe3Cp2sOnjtLLWYETwos5Mt22zty5EtFGKmbwDkANqiD1v/8hOSwNVEcsRNyCI/wblkJzMMVvbZY+sXXY+63w5aOJPtHNJ0yZ87coeqezBi7S08AtD5zZvz6Ixk0DUKaiVDFfHfgIov+ylHLpPLRILQaDXqvxkQQWla8UXKLF2srNjAYAFzSNjmBV5O8uhrHQC+RXUTrw0Y00VaDBy3vuWoRTKtqh5HuhU0chQuVBqpIsqIJdGeBGm4Swg3qyABVuTm9ngDJ1nASE2J5D33c22yX6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGT1d37vH9P00gdUSvKDgoUFCDtvLKUsGhmlrfwOwxo=;
 b=gv/LOq2hPtGZQOES0H1gm2hTwWt7a4H+hrQGris/5t014eb+rBeyl3ZdTedTX3UBA1lE70lqwYqPXZZdI76/nmtSVhFvYsTvfEqqY8TJKOfg8sC1YXaV2tPfQ/VlOhny51IWwOlxS0pXLXSw56QrerJCrriArn/IqIvswAz9zrn/asfI4+oY/hIh03Y4IZuer6o77jmE2wAl1n1hoLtKpjoTIV1/8ilaEPNX64k5vquqgUa+0YW4OWVmyqI3BIW/2azUqydNe4rAI/SFAaASWQb8mdthDJYz09bEMvw0bNlpkJL9eRXAm++Um2cpl0jF3ZIOzgDmaZ6mt135IKy4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGT1d37vH9P00gdUSvKDgoUFCDtvLKUsGhmlrfwOwxo=;
 b=cUuwZbSxQEuGOfennJ78NUdgjecdBvubLsKHBukRmL/Dk+JuGf755Enoss3Z8w8I7BfJgO+NMwJFAE9ph4ZAtI4FHD3dQv279BMDjsgPiayt44PJl4CQwmZcwP7Ojv5MvYyxMZ0s6CN1s46I/D0YWDs1ICZzVQiIEVK+YIUf2JM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DBBPR04MB7979.eurprd04.prod.outlook.com (20.182.191.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Thu, 6 May 2021 03:43:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 03:43:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Thu,  6 May 2021 12:15:51 +0800
Message-Id: <20210506041555.10719-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0115.apcprd06.prod.outlook.com
 (2603:1096:1:1d::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0115.apcprd06.prod.outlook.com (2603:1096:1:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 03:43:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891079c4-e4aa-4b93-eb15-08d910412393
X-MS-TrafficTypeDiagnostic: DBBPR04MB7979:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB79790E39F6D1D4261D9DCE65C9589@DBBPR04MB7979.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hog21FsAWMUNDHcvHiRg3zp2BUmQQAZYchZS+apSekUYprqgFCYayUL49Y8uiRd1MudjrZCSwQrFrMGatoATMttWkMASgSgIMG02SeSnTCcdTK791XE2H/mtiasLb+cHHXQlDqPTsxXtMWznFhZOD6DpZm45AOQE/ycI0KiS2M4lJZjkBeo9j0t/u6V3acQOoj53GqatOkBc0IHrwLvEgdUwycorezYjkggn9eVsmOWbTjjaxKfywjzvB1Kacc8It1wUGCFJA3MI64hEPiofqtUoIeviaj+OTtuqbG3ElvwmCouuRCH4I22MeVPg8S3ShDe1CMoj+PmezpP47U0FTfS/mVuWjxR7Xp1xHV3vIYfACtjxTPaMqWx1yJVQpOkYxK53TI8C7TgE42oQ6sxvj7tVO0lmt7Bt02Ihgg14AxHcrgitZn3XugScMeYkU32XN3fPsissUgpA9D1kcAwjFl0sccsKh8nAimO1lw9YdJtkIqUZO0PlR0Hq1FBBapoM761hW0Vet1KOMQ2ORQ8sFxQl7E66aq1tiTPNzMBPfYRUJoTdYvOjBOrhzrASeMz4M8qc+XCoQZA4crG8HOWSCWWKvkKTnU1cr/I8mcEQMw0dyPLwJCeJ7+LNnaiKvO5PkO1kDF1i1hWu1TjlAHyqAo1FoDwAMkq9QnjhbJZWhJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(4326008)(2906002)(316002)(8676002)(6512007)(956004)(2616005)(5660300002)(6506007)(6666004)(66946007)(8936002)(66476007)(66556008)(83380400001)(52116002)(7416002)(478600001)(26005)(186003)(16526019)(1076003)(6486002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Hr+TaWpAoW6Ib6CSh7KvjggrxPo+1bEtOAGSILRtp1aFRunkxErujDwxaZs/?=
 =?us-ascii?Q?bjL7Yor05lZXkEhpNAOQ3D4lskmMC+4aN/ziCs/SSesQajnr6JMQIWPuOsAh?=
 =?us-ascii?Q?tz/L4hCGK3JmE5aL/Kc3X4YbGELr9CCdUyArE/rd9em3mKBZ9A7rlGndk7fo?=
 =?us-ascii?Q?WbyJ0+3urCfHr2/Wa7HvMIjrJezZ1I2aANRdou1e59owlHQpB0c8L1Dbqdnx?=
 =?us-ascii?Q?gKAIPUMYEdOH5QOrvxuTjUXLBtNtDXewNrrLEaEODjxbmqSd5/XrcVnuAybj?=
 =?us-ascii?Q?GNBuv1dvCZhReMoBdTkWMgqLW3h1AQv8pCgkXvSnLAf27z58rkvddwzc7xHH?=
 =?us-ascii?Q?b5xPjg0jVj1dm9bCEnb2/xIrrKKmpPwehriKacFA4cM73cEZ8EEzFVMf51jI?=
 =?us-ascii?Q?DmMqWG6BsYKe17N6sLg1rJCbv/HBDD+OQVRzifj5A14LpzQO4/Rn6yUwbeJg?=
 =?us-ascii?Q?edyufnJ+hape+QYZ4otaTZlH5vSQ/uiKJJYovepIxPHtFSzNL4Q0N42sZIvr?=
 =?us-ascii?Q?Pllj5tfe8NkiPtIlvTE8+VhVqCFJv763a7Fb6522M2QlRtpNBUbNT/djlZIB?=
 =?us-ascii?Q?PS3v4CzmBTB3ZrV3bWfYU66tjv+zhvEDDlV2xDU8XOHWVyJmhp0tSIio6Efw?=
 =?us-ascii?Q?Us64JH4Mie9M/K0X2Qo6iZu7MFsnENFCyKqhwhLx1/BMi+thWPLmVHXB2/Yv?=
 =?us-ascii?Q?/gbCtjCtzUI5I50CpiyhGcDwyBy1exUtn5NEyiZB8jQYbo1ekHYBtFm54t+z?=
 =?us-ascii?Q?xSYRIai64h23CxUepUQWz/CdnRkA7QnKNxrxufK6SyOq5SP3mC0AXdW9ovmc?=
 =?us-ascii?Q?g8sRmkV9l5ziLj0ImgbscQszkyJfQSDA+InhozEwMolljugO/wQBPhMx3iVt?=
 =?us-ascii?Q?+TQm3KTPePNEwJ8Q1xYZnVqobcyYefwhPYxiV6XMMyW50aMSet6vOcKMg92G?=
 =?us-ascii?Q?HKgoFN0vovHKyXXJaDaFmDBuoeKQRTfj4jr1uEb8uuaRGZW2dvOv8Cj4+7l/?=
 =?us-ascii?Q?EL1xJBwwGHukJDyn4uR/Hr4TmbrNbKuSGyfJD+LJYSal/XleWluRw3W3p1nl?=
 =?us-ascii?Q?wCqnvpgvAEqRgzsH2lCmdD8PqUsdDtD0tdc+YqxqaaBcp7GSN2LOLo0pbPvX?=
 =?us-ascii?Q?+WlkuKldagXy7qk/gbHp2ZW0q1kswLXJ2w7iYWk7/dRGUYu6m/by/MS4WraY?=
 =?us-ascii?Q?OoKPEU34ODEDkDXMdWVJ+SoblnkEUHY7Z89DXl2CtdbxkOXiE4Qx/rlcAUle?=
 =?us-ascii?Q?CQJyQ6mzY9qjcdII8hijxmPvqzEUAbe08Zj9PHfc4bp6zmx/Osww+gHtliKl?=
 =?us-ascii?Q?oMPZTtkJhOzgJ2rKbRnxHxkbrh70ZIpnvGptVrswszyUQA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891079c4-e4aa-4b93-eb15-08d910412393
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 03:43:41.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwryIjPw2sdhcO2eB+CC9hvlSOsCVQMGu12itAYZbwE0nlxpae5viXVB0VU6/j9Zhf6db5zXgT7cWSCAAJ/asQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
is not included in the patchset is that the DISPMIX BLK-CTL MIPI_M/S_RESET
not implemented. Per Lucas, we will finally have a MIPI DPHY driver,
so fine to leave it.

Thanks for Lucas's suggestion, Frieder Schrempf for collecting
all the patches, Abel's previous BLK-CTL work, Jacky Bai on help
debug issues.

Peng Fan (4):
  dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
  Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
  soc: imx: Add generic blk-ctl driver
  soc: imx: Add blk-ctl driver for i.MX8MM

 .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
 drivers/soc/imx/Makefile                      |   2 +-
 drivers/soc/imx/blk-ctl-imx8mm.c              | 138 ++++++++
 drivers/soc/imx/blk-ctl.c                     | 307 ++++++++++++++++++
 drivers/soc/imx/blk-ctl.h                     |  77 +++++
 include/dt-bindings/power/imx8mm-power.h      |  11 +
 6 files changed, 600 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
 create mode 100644 drivers/soc/imx/blk-ctl.c
 create mode 100644 drivers/soc/imx/blk-ctl.h

-- 
2.30.0

