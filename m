Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1A36E567
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbhD2HCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:02:21 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:35717
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237128AbhD2HCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:02:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l70le47jTnWRTq5jLT/3TXBM73in61Hmi06cFrYp9pKr9qaCMcDo2LMhCcmImaf6tlIz4B234NFvn3wz+Uu88AYKE4R4xLsb4nhmaR2Mmh3P2NnYWk6X1ktAeSu2o0fS/lJfRFJtWLfML4JKPHqcIJ9JIHF34p+ad9Z4pZETKU+x1ShAvqoTMEToU6XR5182oLNpxxQR26V3nGJ6wA8StnVdWGVDY0+AE/toK/k/e4HxScE8Jsp4XvfJprhxju3mysyu2wlYXpQzA29XigRjeghMfhfX9JbzVtN+HKGncEigWDSf8mj1+FrXJH588BClc7pX4Ulg8bkgmYbRwI4KhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+tiqFrWKwgni2c0dQe3LGv9q8dvM7y4EOZoxOmAvhA=;
 b=VnzIdiwE7orhijKpDIcZfMFkjptGq4p0ZU06eO6JeLOrrXbtU8MdbMoyoQhHoQ6+748FKEK579ChWlXr6EwoJheLqbY/SJZvWmoBDYfW8c52UtOo1tOhGm0+J5q6NdZSws6IEN5krjOq5kCbeTAFNDJlDD9umMeXSqFgMXRdnqSYlwqmwKOS0N36lAHKllhVFCdOfkggVrWbD22STfJ/4yFBzN7Yk+Vqb5MlZKKjlq8Wlt7JldEmSYo4LVdITwlJ/YL7UdXBjTCoGSC9BNIKSgNsH+27zbfkBtqTtYMBPKu6ejEoct8w2QfvgGBnBQFEWtCfDJM9pGBfLreb65Ro3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+tiqFrWKwgni2c0dQe3LGv9q8dvM7y4EOZoxOmAvhA=;
 b=jxoOp2qV7lGiB9VelpT9M5S/yQCxTCKm9z2XnfaZhXCT5RfB2mOR/3g1OUzuzt51g1+crd0pBx/2nCtEhTly7Uca5odABGnuw+ezhYhTPj6jp5HwmuFbgl7QKBtbB8e2wWNb6hgRTrINzxNvglYPnoGbhafnTcNPYD9zFfRLwYc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 07:01:27 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 07:01:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Thu, 29 Apr 2021 15:33:27 +0800
Message-Id: <20210429073331.21204-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Thu, 29 Apr 2021 07:01:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168fb24b-e387-4327-a579-08d90adc9bdb
X-MS-TrafficTypeDiagnostic: DBBPR04MB7930:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7930FBE7A87AA368B2BA988DC95F9@DBBPR04MB7930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgVP9cIWuGr+oL8WGDe+FF+lyNWXuYeUjl0v7Qf9WHCJobH+zEdJlgjgejTS7Ap323FWfGq/q8Cn6HhcSPJFNW9aVlhnMM4C4O/qrltaC2ivrFMDIrKmWFeBo1LXljokRUeo8yX+C5qpb5DzuRqq5gyedxOA5DWhj2QqqLzx5qaDKzpZVHAGy6m+INcsmHBw/Fr+xm0TrxumKBIsnawI1Ys4nNUHnZZ6AMV+SBhytdC1d/8qHVCsqz9KosDnJ9uueoPHw0Rx1btTBYW8RUc+DfFFdwRff+kbxuJ2c3HaGb92bDQJOSB259bGA9yfECTvbNj5nDupjPujRNbLFuMuWH1eSFdTQlkSIhJmenAt878VXPEfzxXehkGNdhFizYdXT30uZDlwFMdJ/3rCUmn2fzbnA++bOhDi5NXfFIe/wO5H0u7LWlRwKo4jP5mBIyA4cYE5jntQUrQXvg+Td9xB7sSQyxKqSYUk4EsqpPelwaXUDzyKanGj+tZ/qjLyWuK248BeyBwrRdwOOGypLEqLBb+WG8jzGPr01gm+WJD9S5OBByk3qi67LZ+0o2v2YvCr2R2838oCYqkiiF/PQ52w/9PovLNR7txm8uEQgO5+MVY5QZnNqrc3Wuf2LY2a005TPc+EP3wE9+EXD/w2eKqCbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(2906002)(7416002)(26005)(52116002)(5660300002)(8676002)(66556008)(478600001)(66476007)(16526019)(186003)(316002)(6486002)(38350700002)(6506007)(2616005)(38100700002)(1076003)(83380400001)(86362001)(4326008)(956004)(66946007)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o6grs/LsLL5E1Q3OaCt/wx6Y0DG5CZrjJ+v4Gvczqrvss/LAdx1NdyXQkj1W?=
 =?us-ascii?Q?LSUAm27UwttGlR0Dz11ps3thlDmAWpf+5I0ZN0u5Rp7bSOg6Dp60G7ftCV7C?=
 =?us-ascii?Q?ad8fnhEY++2tM4eIpNvRSiJaVFlm4IxhJ+nyW3ytkz/ul/nX1gPbCZs0cSuH?=
 =?us-ascii?Q?Tp2kqRUiUzklpU7V7ASbiNBt77wEP9kyn1pC/MP2sKfWLuGGW1Bz4lPmAlyi?=
 =?us-ascii?Q?PgfnbUnsG4TzW7a0rC3aa9kAssU1DdR0rQvC4BFw0zFqqcCObH9ifMmZnDBK?=
 =?us-ascii?Q?4tptuIAXdKKipZ4xqIBibEI3EMdexG4xtg57VEEU+nzbBCEgPRtO2PmzJeWX?=
 =?us-ascii?Q?oDErBCapVIYZw1/IV9stKDFPDDaduOdqI4WTEVvnJQGmXUB8wcKWICVS65ay?=
 =?us-ascii?Q?ePiLT+ea4oQbQHCTPmNVQieMD3ZeJaJeWTzkzoHN9A8fkh4mTcRybYWy3VAN?=
 =?us-ascii?Q?SCeQbZeVq72g+BaR2dvJ8yyJv3GlrauR5aiFbh702nkfAImFK0+XhpSBnLZd?=
 =?us-ascii?Q?ThLwPtMDQq+wX+TTpQBkcOg/uk2gqPPlicd9jq9u8Z1Phc2MayXysvZa86zA?=
 =?us-ascii?Q?HlOk5t7BaQOHfimhMDe1Zi9Xx4YC3bLWtz9WWTDTQFaAL16sbDWcCmnHJjyo?=
 =?us-ascii?Q?+7jiebjJnfDiL9EF5tm1sqVPb7l532t6D8ssUpRuHx3X+J86EWxi/t0xJem0?=
 =?us-ascii?Q?AaJm/Zz3/kawBD38jCOzYDtNha3maPY5CmQvRHkar5pTnXKJg6DH2eAd8IPR?=
 =?us-ascii?Q?zMDgu6LjqTHGyEF3WwEPneMIpmtO8S/EorZL8Zi9dEpt1AZhL10GLwujW2IX?=
 =?us-ascii?Q?F0XFr+XNoVhG93ul1iChnxXazoEESG34+yg4hV5R/40RXIV1CimbbA2Cj6SN?=
 =?us-ascii?Q?Oxi+1NF5rNox6AvlwPuLwVw4QBD+lPOuWRNAnQcskntfzB20LipvpKd6Td8g?=
 =?us-ascii?Q?GSRFzoYH4DNSQfceCIBvh75Y61KERVW58GtbKwJVcIJjDPpskri1rIib/bK/?=
 =?us-ascii?Q?bcE6PK7udw/WUqY1ayzW6/yU2K0ZOnHZV/HpdG6BD9UaJ84mVoo2XQccB73R?=
 =?us-ascii?Q?eHai1brOv+GPJ1J1srb2QINmvC573mKo+84DHM2jfNwwEjqKgMxVSmwbsSZl?=
 =?us-ascii?Q?XACxjH53NG6a4wg1ve1vRo1+2uk67Mlyq47vkxsvOp5PZPlVU7/8C8nS8Ub3?=
 =?us-ascii?Q?3MLyRAS+jXnxQifhdvckiuhGLQU4dM4H1ADpE1iuSwR0YNPzXLsZ0nbAiULp?=
 =?us-ascii?Q?v/tKYHztHw+udvGsxaoNu3SU9NvmNaXVHvrAIKYFsyHP3oFnXw/paRpjFQ11?=
 =?us-ascii?Q?cXUuuho4fCc43iclM6BY1qM7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168fb24b-e387-4327-a579-08d90adc9bdb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:01:27.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM5KTYNEGf0IaCIXO1vndhHC3qZ8JuH/e4m0QNhOwBt4hV340WzR5qzwqWputgddEHvtCig+MBW5AUoYPLiR+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

