Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF936F533
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhD3E4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:56:31 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:10063
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229482AbhD3E43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:56:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAuesX/zTAGd648iAjhzTOUHx12kv10DMPp9swq4JyNf0cDmLV5Nka/SnKlTpcTpyUL/fyMslluuug9CWCritQWAvlSCX37F3pu9CGf4ZjVlbJnAI2IDAaBnQ5ztUrQCNsJP7WMgZfZhW4J0Vtl3PDeOlydZgqEV2Du+oH7hv1iRxv+GEp/AlDdmF7Gq/oij/1psClkXjOJphNI9i/njGG5+KTHO7DjHM1J6lhc7dPpCeQrdyRqdruDQhh3xsgPCCWGvXtpxXN+0alUfszn1pmzFbJfVnsML5DsIH/Rl8vyn61L7lYGYe9smicLl9zUen8X8XYM+1P8Qoc0LRNPOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQnfpMrzwvIKO4TJ/RAgL9TQeUeLoCmQ+M9HY0qHkOo=;
 b=bZBifxhea9lstOyQCxVFU5qp2/Za/nqqI/CivDYOmkxGIU4cNKcJFpzCeXJ5acU1k/0FveWc33IxH42GPy4itBTEORUQYCO557fLwL2AP/Q9j4x3z04b0Q2SV/b6P0x//kOfnzwXGSNt1Tu2cZV3QgB88GzFOG8oKQH6j0clQQA/2lXEUBJ9S1citXa2vOX3L53jH6O0uBMD3bmdSsjntThJXF7RqYhMSWJMH2oSqAzYqOlSwfC5m+i15mBFog8LmQV9jrzHmJgk788E/JxBP1raeW2iQQnbpYFnl/QsS0hoWVwEgVN/L7kvbjXyAucSm8yCkpRt+p0GgQTAaEb/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQnfpMrzwvIKO4TJ/RAgL9TQeUeLoCmQ+M9HY0qHkOo=;
 b=cuq6iCir+UVX+Rpsh1ZwAcTbKJ7aMNXsaMaH9WMfi+OJgSNZU+YRvINQomMFDpbc3gg2M3B2fKqZ2v2kbiCdFZ/w6IVInGWH7EfcipN+DxrLxw0WRuGjYscccn365p86LWCvNA0yIM9K8+DGHxzil4UyfuTyIy0bf+Wxf0cPgYs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:55:37 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:55:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Fri, 30 Apr 2021 13:27:42 +0800
Message-Id: <20210430052746.10815-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 04:55:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33fb144-3b29-41af-5ffb-08d90b943239
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916ED98ACB6AC1063210706C95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtzrupJrEV55WMCsCvIUHVxEc7qW4OFbVBeatvVy8otjLYWnrvNnTYRdmc6x8cRPzmf3Nvy1zG/LdNy4EJ1kg1I2apQCcXO0kvdUQuNby3eRlp9E+kcjcyqaCSIFOqq4mepZfvJel7n49d0p2OliSE7cjJe9a79K5yapftouTabcfunDiNGBlWZOCyuq4cYerKeZUyHP+Gads2fsL089dZ/KdR6Q9AwhibxTv5yTjzKHJByTVfdVt/zcrSeMZpzA5J8W1AHdeYlEsDOfKojHLqRUp4w7yy4T22Bk273C5L5Zlh3BdgXqKd1yfYBuHSHSe1yb9voYUiblswx+jpPX8xtf9fLPh84wtvd1HeKhu2cEP3iuq/tx64SQOmlJgEBSff385AKO526SgiX4z289XqjrA2J80ACfSIa0/Ee9E4HAOmTA0PMxcdDLsq95Md1ylyub/3UzevX9v2lFDUcVDJ6TO64UkKofo3NbSR21wc90LNkoudXS9cY6AMxgwQjDV1beHLURkrcFuOqwleEzvitkSotZ8y+WmmdIsCm+dCiAM1gWEl8wnpTBhmQ1EEDoTBERVEA0ZTQLC3jbaeKNi/tZF1JKYb6l1FijZplVuOMiFFH4G4f/9QWbeEGJkxhtljzA9byU1iGVbaDjQCPHGda4sifjzHQsyKvAHv2rRi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(316002)(8936002)(5660300002)(83380400001)(66476007)(66946007)(7416002)(66556008)(4326008)(6512007)(6486002)(6666004)(16526019)(956004)(186003)(86362001)(2616005)(6506007)(1076003)(2906002)(38100700002)(38350700002)(8676002)(478600001)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xYV8zATQ3qPbhB3UemQn5W6+6yItwN0zvtsl7fx76REpE5gp1S8YSDoKDwKQ?=
 =?us-ascii?Q?It74s9sKBYZbK7eKywStOCYg97DK8K3lHKsbkmgKd0L+zrVWvuur75rygQnC?=
 =?us-ascii?Q?pMBaH2rj37Q/YmgX9Uw+BPz2HUBDnaqvYkfZwLHym6rh9yrQPWTrNNiwQlRl?=
 =?us-ascii?Q?p0nsuol4QqKegWJqFaTzO3TULEweIh/coTgmW3OKAwck7Rw/qXCcR8W5+ECD?=
 =?us-ascii?Q?0/fTiLn2ckNgDkSRoNmlVYr9BwO7SFOolbRBJK+qsGWgkjHS+Rgt5w3EYRhD?=
 =?us-ascii?Q?bcj45cRug9Yz65gCPaJ9v9z/PypaRvuDYdLjkJ4D/5nMbZ+Q3mpDXffa03Si?=
 =?us-ascii?Q?Ps5qZCGQcyJ93kIFqOXIGGN80WBQllLvErpIrOvNT0rohfjfJ6pyxmRjNgf4?=
 =?us-ascii?Q?hdDGWapTW2F0Fn7PaBCzLCVUTZw4lvUEDzdtpXs8dZSZB1FNL7vLooHdX8Ua?=
 =?us-ascii?Q?IKcyvJ9oCddcivapoWplLfol8etQ2UAMV8osolqVgDFJihnQmmIxrWAvE/NC?=
 =?us-ascii?Q?t6Jn0SqkuH/m6bDUe/rIRieQXY68dAymDuOGbiVnXxuhlwaaoS6n+eb63pl7?=
 =?us-ascii?Q?jnzl9RCsXql4f1s8w/e4wp5Q+vBjdjYpCEB/hvo6bXFi4S6JwvNqY9+tx1YA?=
 =?us-ascii?Q?sCsqygncOFqjAxxvfEA3oi13vzATv/p+95Vxzz5jBdX+1j3uSGs/lgSoedlj?=
 =?us-ascii?Q?QxUxCtdGhOCJQwCZBFMOFoKymAQd99KkxuApLTvrDkigsJGuNRSPSldMiTfD?=
 =?us-ascii?Q?lerWjqAqnChbXoNMQbWbjFGVVUDV/Juyq3QjEx2adedMlBJ1VPlrKoDSQbQ2?=
 =?us-ascii?Q?CpGpzZ5OlCK8+AZPAzYrifJ5HLiLvHrzj+5K9tL++ZnhmMHf1m1eFgilAWwD?=
 =?us-ascii?Q?zH1reTIWB25VlcTYXYNOW/f9dDIXw+g2YFYUolenvN/5dyw3lFtG3Q1pyV3J?=
 =?us-ascii?Q?SLSjGDo73+voiargBUEG0wkwqMe4BZAcd7oGcJ8Ns+hEu2KSnkSEuhJNnGZQ?=
 =?us-ascii?Q?8geruvJ3QT1DJVFpQ+znV766uATBKD8lUCIqBeYu+gCZXH3UBeHhvU0pVHSF?=
 =?us-ascii?Q?50yMpHrSGRgKTMjy5e0w//HExAoJjp88b/Gv0V7I2D57p0DHEyChIhqj9vDU?=
 =?us-ascii?Q?R7IcWUNkgzjo6rTIshe/joRnDuhSUvZvgq1x+sZqiwcYOQrV8fBuYiW7xu6P?=
 =?us-ascii?Q?kGnEKZI+KT+X+LVtygjtTdvkBfxoj60E6vAV+Ia8V+h8rzJYCITGqG5iC9py?=
 =?us-ascii?Q?gqSIPBKp64CulilJFIw5P9oTaSaqFnlmJG7zn9iL74/POpFvzlZf0F/PvCOv?=
 =?us-ascii?Q?dmwrG3VnaCSDVPrNftl/hWC+n5993cv9YygHbcS1z9SjYg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33fb144-3b29-41af-5ffb-08d90b943239
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:55:37.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUzcqbPX4HTLNVPeIxTSnjc+h0TTi0QF2ErrKHCU3J6EKrz9rBCvjObnKdz/f5AMJRWB2USEZ12O1DRHEBn2Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Fix yaml check failure

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

 .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  73 +++++
 drivers/soc/imx/Makefile                      |   2 +-
 drivers/soc/imx/blk-ctl-imx8mm.c              | 138 ++++++++
 drivers/soc/imx/blk-ctl.c                     | 303 ++++++++++++++++++
 drivers/soc/imx/blk-ctl.h                     |  76 +++++
 include/dt-bindings/power/imx8mm-power.h      |  11 +
 6 files changed, 602 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
 create mode 100644 drivers/soc/imx/blk-ctl.c
 create mode 100644 drivers/soc/imx/blk-ctl.h

-- 
2.30.0

