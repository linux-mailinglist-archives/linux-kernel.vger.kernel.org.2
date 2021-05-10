Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B4377A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEJDfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:35:48 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:48896
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhEJDfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqqlmth5Q411sNGdZeif99wnWpuwmI+pCS6AoTvB6nLe16eNchKdJbBzH88i0+OnekeiRwscXpkRXMzrbpa1YggAoErM+FIIc+T/xsVXQyRcC8Bw54ZQ6hn4yWwCsmsZImKgEeYVBfJk4fNxI03Mobqne9ZzdHDcx6OND8h5Wl0fNZTE+Pmy0TvZJib6zVj9d8F+7h1CzHURH5MYqcgG2WSczLret3Yr8gf3PLId042CyWtfUs03xfH20b+ePP+QclQt0rDq7joXkvEUzAX7APblNFck8LLr2ovOMNcvSZ/eKdulMpSJxTzOlOUQQzeUvtQbN2oveK11aHb2ed013w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiicKOfqUvpU8NM/pzYIHgAp+3Ql+Qxw55dfv4dnKNs=;
 b=CxDblbqLgNAw4pSfvGoAfpBprZoK3XiTSRL5sNnY1mrwXP+ZhgYEwbl7anp+LQwOIscr2cQq2a+tNItJX8bGDiat6AZpOEfuPFkQyCsxnvZ9R++tSTxA4TagwAs1Pt0jTHdWyIowsJhkYS+GzMgXyHEewN2r+xs6Sce+L6VJVFadRxpt8i5o+yKMEZtvuQ9v0o3xdTRQcFJXUs8LIloKl+yyzpdeOliJNMYB2WmvNwJzu9i3NLbataFexLozORbqLTuQHW0r8J3ioynT/W9GtkvjF8ZVe43F3Qi0MJZFt323nZR76Xe6/UwjGwRC9hgsXz5ie/H0Jm/+B+Bv2jpKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiicKOfqUvpU8NM/pzYIHgAp+3Ql+Qxw55dfv4dnKNs=;
 b=blM4Auuz3nmgJZjuLHSrWyK4b0txS1wesOu65elMcdKMlFsWpTD1+FNpu1oXc8iPWoUDITzuzlpK+PPKA9u08XfncYACwnBNUQKPei8PXHDOF+fYL5rC3k4YDYe2jjBCcqfZzvm/MN2/s9wGwWZ1Ezsqde1sfk0zaGYFyy+HBvU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:34:40 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:34:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Mon, 10 May 2021 12:07:00 +0800
Message-Id: <20210510040704.14997-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0159.apcprd03.prod.outlook.com
 (2603:1096:4:c9::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0159.apcprd03.prod.outlook.com (2603:1096:4:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Mon, 10 May 2021 03:34:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171b6dff-e9c3-4949-c2c7-08d913648b29
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091B19D432AF2E0A0BD4C51C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2g6WMUacRxs8GknXXYHG2nBGNR9qWhz58pJ782QSxvzibD4LtYu19V3Z088AwGz8YlTxRt4NWHSY8lIQeBrgu/2c+xkNxsjnSEShSKmxGyloE76iOP9OOdl4ss4V/KM5YSXKjrUdKSQFvVkVMGMdkKrKJDDkV/nQkoh6OFV2H58xC38rpQhWxrpdc71nvYgDDM3MwR5HJNeqLc2ORWaQRQlhGhdcsWxAMa7H3yZVfQf2/IytQp30BP1WsMElmEVUCGsQ5gery3IinKlguJGtc7tr3Zk0KLX81vlC2K4T66HjS5otwCTZkmIpJapgQ/UxnWnJuvmk7xe3JJwN47XqIoo4EVpIlxMAJpHOHyOgGNIISPSXwoxtJTb7cLIfXs0rsKWAwcaOksU6WJuCQmO6JAR3c76H1+aax2bVe+HOFT7UbcD80k+ofFAtuEBHmNa3wy13sXPI/rR+UX9wn8BhQtQ+GmLSY80MRKreGZZs/Koipu//Or9bM3yzacuGmVsPXGLVvyhkW6JXR4iEXFhPLveVJpufkBSIlK1A5uSjP3cpkhUb4YK+YFWoWHoHmesrFUtEQCauio7amAWglf0gLOntNsROJDOmz6ogpb6cgeJ6vQEQu6ia7iRg/6jyoZI9EYLFHCFOEBFFSQRA0JHH+W9HR/TvQzsrCDNvF0tdS+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vYhcAwpCAJuXv/ef3+9QpGHhktyHoJHEBG4XsJzLg7/AmitNutiGWT0vLI96?=
 =?us-ascii?Q?5F1z+HDJLIHYbuG392OxSLkFBqP1eYTNjqQYFdta1I0zwJUbozol024Ecvbf?=
 =?us-ascii?Q?+72COlzMP9WR+JxtAOa3qeKvHtwHT/74ynGgEzUeU3Q3NibkqWoEjQpiLddV?=
 =?us-ascii?Q?XLpxlaB3yKxX6InS6yT2HFenG86OqDdg3Y1qrBxRspyTH1Bx066GZqZVjuKd?=
 =?us-ascii?Q?9IcrqGSJSThIn3TtmFxjVnqe4U31dthEDowGQbwCM7MICybcV5fcbMug2ci6?=
 =?us-ascii?Q?VBDM9o0KSBkXjzK0FH0ITUqJkW6SOOJGVdNDm+6TDO29sKnF0BmGK7iDxZCM?=
 =?us-ascii?Q?NQ3VLo81Z2yN6C3GTKqRlKxRsZZgMME3xEZTLTZ6pX4Lj1Hxk6rrfdNYw/x3?=
 =?us-ascii?Q?xjk5meWaFQ2FNwrMmqjWW4ANwxLGlKeBcQq4GGbbmA+fmDdb++G04t9qR/wh?=
 =?us-ascii?Q?ss9y+gNPoDQsrg0hdtg8rLQGPeIZq/VA89jPYvAiNV/jTraG99+mA87PuNdZ?=
 =?us-ascii?Q?M0ankwTC2z5wt+eN/DfCeDSwrQIImaCQTRLv/HqKnZ4ABe7boVGawI5uqjjm?=
 =?us-ascii?Q?QkTP4dEMTiGyrUYOd+45zFN7irzNAzHDW0jwWXWPtrTJs90xfVco7j94iXdc?=
 =?us-ascii?Q?e1MBjzAhxiGSXeOl2w/OaGbEIqJPiNlC71rXyYzTO8BGcGzfFj50ilkejxCA?=
 =?us-ascii?Q?jDNSSHFYCRLouwrkVpzav9clNAj0YaCKj9KovpyfPGWwbe8VWrfTEHA2fpzY?=
 =?us-ascii?Q?gHKzFNohWf9RPCZPuo9ZYLtcgZY4m3Or5e4+VOubZ4VRcoj8lAaOfiDiRXor?=
 =?us-ascii?Q?6+gZHQKHomlXaKze0q60BQA38Ov7yoVvO7H4/NXv6ce1ENg37HNBdrI9BEpu?=
 =?us-ascii?Q?1K5IfIZ/XArw4hH/kf3RVEQOMCsdaCX2WcWZsIxYkUviAumZMbMFRudu1wkj?=
 =?us-ascii?Q?JqzPn+/ZuA0P2jpweiotRFpcaryYfxbbyYClk8lbhQSsEqu2zH6QjcBs4U6o?=
 =?us-ascii?Q?smUptSdVaxxx3TJOn4AKDY2yq2xFmJzOxaKD5iW+kxxdgbcDszKua1jv2bdo?=
 =?us-ascii?Q?QVGRTinOV8IKm9YHxAZZ90WsQBXAwRt8hcdTXIVESEawwPYsh5sCw2gUR0cB?=
 =?us-ascii?Q?OYoVPMhVede47roCKKVn8lS7ZZX7zT8mwEKJzJtpmiDwW+9ZxhD7fMwxZyhF?=
 =?us-ascii?Q?pjLKgrLVdyDRlhDKz1v0dLhfDqlNKdX5TjI6xsXcWXVRvcoizhw1y3RsNZpy?=
 =?us-ascii?Q?9Zs/tQcsqN4WJmf2IHxs9VP8MONvT3+nkQLy+dudLSDzA5DK+7wcAMt1T9G4?=
 =?us-ascii?Q?EcZEB3nhNIVIzrb2OeKuK5D/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171b6dff-e9c3-4949-c2c7-08d913648b29
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:34:40.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdCqnZETxB7yCFHok8HEtwrOHe3Fafk3roZZbtdTJrJ7UbMz0ip7mc6OxTrSI8sCmSC1v/RWa4d+fEJ98v7l7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

