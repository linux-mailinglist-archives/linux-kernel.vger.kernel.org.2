Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE33377A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEJDaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:06 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:57262
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhEJDaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO/Y/FTlweZiPZzM7m8pbyDX8nfmoJzCzZ618nzCsaVY5mzBY23s2BQll90ZNNpp07ZZxTEV5nAkbTz5o7+FEOCvQ+vTjPd1OH0PgJnA+bylVT7UULfVNx+e/jzCQYI6Q9qTuD4nONrQDAGvgswbq0oYF6VogkVwzzmIB1RZIYLs48DAv/VMFuH0KyK7uU7YojeCikHigWnDK4m75GsrsAdTS5mMMKJMe1MsOEIQZnZPi4088PIjy7I9Hu0viZX3VArA50a4ZwIzjHxeA7nZ+wf1oK4c1dtH/PGaZtulyhvz8xOPkxrslj2oVxOAebmUey2H4m+RTlSY2FQTSSeFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJlZE1e7XLisH/R+FyZOt8FOVUCtRSZ5TPOyu14SYyI=;
 b=ZN8QMNnkfLo/zFQedLGpcWFyU3aFcKyFnPR4zOOzmQpfEq0sjUEnkEz8v3flwnexpyDeFj9j/rkYbhh1Oz38nbGU1rzLGeuZ/NJELa+UEkdVj6ex7z1Jxz8JbQMcvNKvsD6NMy6twaJvbaBBJRGg5Z93laspXix5DpUUxPyI+VJXIkkC8hp8BOXmE9JljFXlGsQig1mTdUQIM8M/D9fJwmf0YUJcibO8BpxZmdgvbscWYQV9i/CFKHETdMIsdwFV/+DsoLZQLA3YuHNHfhiwMBBJ81YanEqrt9wsJtVLq6aleSMhBQoths3OVvSmjmnQGFFpNf1Yc6ASYXzVTx2tMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJlZE1e7XLisH/R+FyZOt8FOVUCtRSZ5TPOyu14SYyI=;
 b=dM7gzHHejJ096x+KshhHsDF5v5Hssc8VqPgG8665O8y87yAixxqBHBYopnNCOyRCKJcw9YQ0bpYh65QzC1qOR6PEfQ5atJSjkCXqDXFo4P5vFAYOuZgi1Z4DdHD5lE8YPV8a97rQSajg7MqafY0kyDvfOxZ8BenEeUUFWWdmXeM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:28:57 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:28:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 00/13] soc: imx: gpcv2: support i.MX8MM
Date:   Mon, 10 May 2021 12:00:32 +0800
Message-Id: <20210510040045.13225-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ee1e31-7415-45d5-176d-08d91363be9b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091FE4C4A52B6A720C2835DC9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m16xxbTuJoTHQQy+ecqPibWg+BsQP0+hVMKiD2/A3yC+u+2hJuhQ2hNhTHBtpg4FyrhwobNwEwzHoiaYLTfg0bHKHxBHx9nmU2AFshq/G3qGQq3pcoC+wj8LsZgqySQtFnquKHiyZkuplqvfXxSJk0SpGaeY/8FZB21Hfpk38a0xL3xUgj9RnUdcmH+gZZY2bLl5CbbyHRuVzo9jFoKObih8K9CbA/gDeenzrhWiug9VhYFD6kk9KiVdUG8ZxMZ2TECe0Sx69+kNksNHjpth0OBsKKhn5Z8/hSFQB7NiyPmddCVr07rdNk6ZFxcnqrThYnIiuavkaKQyVs4wvQxvosfJDjgoseFvbTmTvDNF9qcpF9UkxBwi0+1NucTTGxbkCTacqHXQ5ByIrXqystac5Lbj/GSLcfdUCwqU5Qu0s1xBOemzxz3iY6Y28wBxQzb7l8pwmbDaPGGAIUb/d3Rrv9Le1fKyOOSQkI5ILYnZvDl6sZeoIPAjNYZkK8JerDIryaY0n938/EBRMendNqBQIE1lmE2EfaUtHWWRd3yLGxL5k1S0zp2sBECuc5asg9mxcMxq43SsYy40qvLiEIbdmSDUtgNpKNYvKJz5lYg83XEJT//nZpoxkf7Tm0QSB9jpoeb7WSMIfNxubElarL5IfMXtiiHjiivbUH0GAHWRKys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cQ4ayC56xurkR1AkUplAc5+AG+BQuHGyKDq+dzZuxht9ZNoo1VDbl9mKdLAA?=
 =?us-ascii?Q?Jwy8CcxSKiN+ge+vHwaUeexdo4mHtteFDwJgaVw5+GoT2GiVP2GHIMHPloLA?=
 =?us-ascii?Q?4mffpUOrfhIeUYXzoaAEMVUHEPVAE+bbHjYFentkqGYD3aZAJ3J/fA4sQO29?=
 =?us-ascii?Q?qGKmO41g5wctx+MwUMIvZhOfYICHJOvYhKi6a6Tq67ETh51Jv5EXk5QuFkr8?=
 =?us-ascii?Q?z0PWGvurFxTCPb2O/ujFDPo3/KRYiTqqM0RtGGQnWJ4uCUzSFk7Zmk5S05tv?=
 =?us-ascii?Q?nlIT0scx14iV8Ua0cyyetND1SyH0TnpE4wFlwJV4llR+MWTv37jJMvtnnpB1?=
 =?us-ascii?Q?9RRH+mRGIL5Ed2/OpK3/L372w6nigTiZWHb1ingYma+1E1KpeOwbm0TnU0Yu?=
 =?us-ascii?Q?VFNCdgTFGfzArTn7tIvAu7VkBakYgQ/xfJOKPzdwRORRyntOnKyreEFbANSS?=
 =?us-ascii?Q?4P6DS5mYs5IW+paYlvHQ/p9XrRMMmuJDCfDgtQeMG4ybRpZzoHT8MAId12a0?=
 =?us-ascii?Q?qQDsaHujJuc6scrRVIfuAU1e/uRSngqL+KGu9ghVIj6StLWo48x8JJp7j+Cs?=
 =?us-ascii?Q?SyAJ5j9meQBJ1fsKbejgSWkWT6ZVNLAsSpth8sLLPLQvKgC7ibi+nb6hzNDi?=
 =?us-ascii?Q?10Zbg9GoPVekxBT+5bXZrRabtpTxcMTbd6WUdrQn6vNphmVOKpOv0KzQi4AB?=
 =?us-ascii?Q?4MayFHMiTrcQf0fZOrpAOM4mxkXKGDqhRNXauSmyTpQlZt4fYEOVYpt66UTZ?=
 =?us-ascii?Q?qCkS/Pd+vkD71Gqg5UGpRkN86kJuxPCfpLr0oL6I+MvMuer2Pc0FudbzTeFT?=
 =?us-ascii?Q?TBwdlcM6dD1szng1P2Wd+xknVEmDHdJOE2WIBInb2nWUDYGAKAxXhaHGkiC7?=
 =?us-ascii?Q?TTuizVdCw38BTFk1tj3Ck5fG1eWE+zypb9CxXNDC9nqUJEoBtWhYJ5GpldW9?=
 =?us-ascii?Q?4RZ63EekPthZxLlqHtNRdliQH+jK5scovLxePUiEek/N6a+Z3IaCnuV2o06g?=
 =?us-ascii?Q?C/TV9bwAaygHGTpdLYb6EY4ir4edfofzAwrPDOCh7zGo9TaKR9V2pBDFqPYY?=
 =?us-ascii?Q?/e8WhoF71BgxPysV3dEjzed0u2QbODpUV/Mfu36tLTBfubMto2tYdWOR0Dgm?=
 =?us-ascii?Q?eRjRyMBZbENKQbTuYigFMaQU34jVudHgmHCWavkwNviGnij52Lk3+DmFH1UW?=
 =?us-ascii?Q?O95pu5ob1xKkldj8NkvnJKxy648HtaI7om//gadcAOcNlpt7I3v/sRmqPCeW?=
 =?us-ascii?Q?V/j7JB5IM2U9opFY8C4QSA3tdaqg1LqLNMppmq3jGHsTsuDdcFxVAzq3JbR6?=
 =?us-ascii?Q?hI5wyOUDAUxyzOjThTjNnfP/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ee1e31-7415-45d5-176d-08d91363be9b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:28:57.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rw7TcTmxAaW39R23fFuXg0VX6L3Hv8vLzquzWC+SCMv4eOVlDmrApO7RyfF6A/fNEFL6HLaELPbWltZ1moPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Add R-b/T-b tag from Frieder
 For Patch 8, add the explaination in yaml file per Rob and Frieder

V2:
 - Add R-b/A-b tag
 - Merge V1 patch 13 to V2 patch 6
 - Drop V1 patch 15
 - Merge V1 patch 16 to V2 patch 5 and add comments in patch 5 to explain
 details
 - Add explaination in patch 8 for "why the resets are not defined"

This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and several
minor changes from me to make it could work with i.MX BLK-CTL driver.

Thanks for Lucas's work and suggestion, Frieder Schrempf for collecting
all the patches, Jacky Bai on help debug issues.


Lucas Stach (12):
  soc: imx: gpcv2: move to more ideomatic error handling in probe
  soc: imx: gpcv2: move domain mapping to domain driver probe
  soc: imx: gpcv2: switch to clk_bulk_* API
  soc: imx: gpcv2: split power up and power down sequence control
  soc: imx: gpcv2: wait for ADB400 handshake
  soc: imx: gpcv2: add runtime PM support for power-domains
  soc: imx: gpcv2: allow domains without power-sequence control
  dt-bindings: imx: gpcv2: add support for optional resets
  soc: imx: gpcv2: add support for optional resets
  dt-bindings: power: add defines for i.MX8MM power domains
  soc: imx: gpcv2: add support for i.MX8MM power domains
  soc: imx: gpcv2: Add support for missing i.MX8MM VPU/DISPMIX power
    domains

Peng Fan (1):
  soc: imx: gpcv2: move reset assert after requesting domain power up

 .../bindings/power/fsl,imx-gpcv2.yaml         |  12 +
 drivers/soc/imx/gpcv2.c                       | 542 ++++++++++++++----
 include/dt-bindings/power/imx8mm-power.h      |  22 +
 3 files changed, 461 insertions(+), 115 deletions(-)
 create mode 100644 include/dt-bindings/power/imx8mm-power.h

-- 
2.30.0

