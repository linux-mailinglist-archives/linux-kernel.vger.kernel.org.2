Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D1F394199
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhE1LCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:02:53 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:38510
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236450AbhE1LCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4IKnbxplPrK5zXSn6T3tVeU0rergC0usdz0mScuPAuUd965JOxOis7TTQI22Vg+isN4VUhKmTOZZ7zsrHC/i4d0G3H3wzWUB8dthwV5d5/kxYXEUbfzitjWd6bGFBQ0k0Xf5GzPcIndkhn1morPdqTqLKzjZCJXEGqwePJuo6ftAKZK1DhBU+j0SCiuPEM31pA8oNcHd79BMnUYg7qPDHrxO23wgjCjxV5NvmxS9xh46YLpcdEXENPd2UeEaxKtrShSb6wc2fIifangYqlFn5tWyGMkQss5wijsKmwsizi1cJXCAkepx5C8K7///GMFiWgTD5f9Ab7Hpi+TTL2sWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBKIz7uuv+JaoWYEwybxRq91UfUKZQZSJzlwYsk50vI=;
 b=NgfokGHwZHoBX8FCivGf96+O6VIYL/uDhBo05LWi0Uaxta0IkMZsk/cgUrX7CxXHbGsUBvZtfS90CLQARGKvCjKEPJJ7Qk4FXIlFeCzBZgmQqZPxDxX/PceR/J/38KnZDczVwAbd1Gg5LGSfiJ0ORGEnCAoIOlZW4S2BRmEAwiQoldxdumYGIXeutuNhnjsI9gPTxqmjq8cjv/GpcGWWHy7utS73XEBwEb5mXcmKEFH+CutOBnA7ufJrChvyA4e0Hi7WnN8lhikTIZ9SmvA6cBe8kxosz4e1e9n/cZ14PLRyPtp23nsTz3CT9E2C8XHcRYrHfm3XTF+cOwvx+Z9V6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBKIz7uuv+JaoWYEwybxRq91UfUKZQZSJzlwYsk50vI=;
 b=kDqsnlqgjTdgST6woI28dMhu7kikSbsvRZHbhqM4+hEqwNvgWMQoEnt+EIGWaZ9O2NC1hn9BKWb86CIwxS2W90C3+kNNI/AkwG0HrZlmOQKgAdRZhoIspaRtKjIyxNOdQ+46s1M4V1kacbne4swj2W0PInDKTQJZOi2hjvuG0Uo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 11:01:09 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 11:01:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] clk: support regmap
Date:   Fri, 28 May 2021 19:34:00 +0800
Message-Id: <20210528113403.5374-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0158.apcprd06.prod.outlook.com
 (2603:1096:1:1e::12) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0158.apcprd06.prod.outlook.com (2603:1096:1:1e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 11:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ac2ecb8-5c0d-4dc7-a546-08d921c7e5ee
X-MS-TrafficTypeDiagnostic: DBBPR04MB7515:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB751507921B3969B123781B99C9229@DBBPR04MB7515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxzOFYaikBNrU8CJBD212hsXGhUyaUJB1DdPiRjYCV5TNDvo4TCjJVV/aVDfmuFe+rH7YKz+ZMNIH27TOoQcCOagbFQMF+g57DZtBqlnP3nVRecieyk9aXWM0zwE7dv+KRpx78X64j3qeHYVHTY+PRYXcQ8syFnk7tnMvxOjMyKgL705mvwM0PcnIMM5g2qxynApo86xJyIScJ3iHNZWlu/rTN2U9Wqu4FFkhyhwVVvaJqq3W9v5MXQVBiI5Wv8KUFWjDh2BQk1vZFTIUIVW8TgMeuBezmM6I5UBFv/5c8AclE4AMTXBQ3FIfKiV8OITFwEnw/wB40GJGn7cy8Jwxo36WW4mD84k6dcl6fsR2nQ5UEtbY3p468QLKekz/hgHAk57pIFM9z4t7vcvroVyiUtG8VwoqMjQSG1pbhDYET869DHNNly1+hTdD0ovxOWdo8IGFZkws2GXTARBLXee/nv1J1zBtpLhX1DW3O6hDE4uocRMuUgxqAyUF8EgpjriDYHFAlB6jiKfjNERAWx1TEf2BFhsUAADRHUqogtIUIP374uRvdi0x8M85PUqCvDb0BuKm1AvV18o97d7uZmx/Cn8e9BJngwIJQpwugTawu+paj6+eToaunUVdj/ngwllZwobBniFH/bATSSyYmjMNNZ9VrrsGdotIrYjX36zG8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(366004)(52116002)(6506007)(38100700002)(38350700002)(26005)(86362001)(83380400001)(2906002)(1076003)(8936002)(66476007)(2616005)(956004)(16526019)(186003)(4326008)(6666004)(66556008)(66946007)(6486002)(8676002)(4744005)(5660300002)(316002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bP1vfSnCZI6jTVUJlVVi1o8wjX2ackpxX48/95KmM+EDXbyFt6I0hji2b9qa?=
 =?us-ascii?Q?/vIF6GtR44zxNXnXZ3jyzilCswUvIBxW98+NiMlKxuGNktDUq7U+HOJalx0N?=
 =?us-ascii?Q?8WS+qMdeP0V5AQmDW1d7hlIo1jNPrscbelq3mgmnV5TTJeWwNwtgjWW9glhB?=
 =?us-ascii?Q?G9DFLsQ01vTT6BjLbYRGCUp+A2Qw4Apnd098U86/jDbVJSM812hgXMQb5mi6?=
 =?us-ascii?Q?vWOEKWOwFm31yUYgRTOrSV1xW+P7wjwgl8p/SFsNLm4UeK82IDRUNJqRWb2I?=
 =?us-ascii?Q?9uut389aLNXrPrPWqQXDfqSeekYK7pSHOWfZBE+Yp6tTbXc+pclM51W94CUG?=
 =?us-ascii?Q?nPiHI/1WzYzGsaUh9fsIDyyIJZUZ3k+rYXoznEFz53Y70sDuH54d372uwZBG?=
 =?us-ascii?Q?5avGj4HrBjAiZqcZEiqQnXHC6Roa2Gfz7mRM6Nm3Lq7vfDZaBnVjjbx5ND4l?=
 =?us-ascii?Q?+yfNt8o/cm89mhpeC38/8Uqn/32NkZIkv/PRblwx3E1jw3s4O++uUvooQWh4?=
 =?us-ascii?Q?g5E3RCCao0Z7G7lZLL5Rkx36Xebc6RP20/AY+35CAgdGmttcvO9TFw9AwAca?=
 =?us-ascii?Q?P2iGbPfT/WZqdKOSJhs14NlJpMZDyI33ladY+g/1GkyVovXkMyGRV6TxTltZ?=
 =?us-ascii?Q?KBxm282/uOpXBnl3urCaWibW6wNngR3R0CfIPsdhRk80OezKZVrN53NteWGd?=
 =?us-ascii?Q?WgOIbfAOtzcit+BWFFzOA9DyxNbDBWZhJkDBP20zg/VPP84BYDFT7oPpTlWx?=
 =?us-ascii?Q?xkqBfs4gxZdVDkWz/F3pc1Yn6tFKsrdy9fu13mcZYwIcNgtPiQu6rc9oC9oQ?=
 =?us-ascii?Q?kM+jhzFhXHkPv0rH+L+ei0ryMrdJ/pGFo3kQ3KtRGfvhaAmrT0/eEfJ6t60v?=
 =?us-ascii?Q?zs+E1wS2LEm16SZVXuoccG9jb3xGcaWS0xvnx+Br/7q7zY9s6SnKUVFiIZ9/?=
 =?us-ascii?Q?T9ujnPgHkpbnksxFtuyxuCdsRyrUjPMJRLC3XiIdqKLHOzGcO18QnMnOOAPm?=
 =?us-ascii?Q?UiJ6S4koLnQSwhDWkbx3ML79LWATkmRsmyTdNehD+yMgseaLR20E55pcWexj?=
 =?us-ascii?Q?0hH0u3yylHZqgtHpLaiHr8GvzLSdkYbqE0GpIc2c3i7pfMN5CurUXSyn+Ko2?=
 =?us-ascii?Q?XBekPwLOIzGtqxZbvIduqVdH4VRZ3gCb39t0Xlwpf5nhpXRrTSOBCeWVd8Ly?=
 =?us-ascii?Q?aKP/abBtM0b10Rt92ICDXOmVA0VxJnhLdlcktp791KA4E0qzdFpOUi+GNV+S?=
 =?us-ascii?Q?JCUeSsaMkRCKoWA83QDM9yXBXhUyG/C5L+MDxoZnaxuxX67OVTNxUjd/4nXj?=
 =?us-ascii?Q?R9XGSQLb25AC15GKdQ6cEBsgBTVeeR3gy4/SYztgpmfasA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac2ecb8-5c0d-4dc7-a546-08d921c7e5ee
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 11:01:09.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IikaXJ/zul17+zCsj+nJsUZUm0rj79i+CSLkLxVL9ustBMZKgVqxCT5wA2BeJhV5e+S4JIDYM6ZcCmz+RdQCUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To i.MX8ULP, a PCC register provides clk(mux, gate, divider) and peripheral
reset functionality, so we need make sure the access to the PCC register
be protected to avoid concurrent access from clk and reset subsystem.

So let's use regmap here.

The i.MX specific code will be posted if this patchset is ok for you.

Peng Fan (3):
  clk: mux: support regmap
  clk: fractional-divider: support regmap
  clk: gate: support regmap

 drivers/clk/clk-fractional-divider.c | 26 +++++++++++++++++++++++---
 drivers/clk/clk-gate.c               | 26 +++++++++++++++++++++++---
 drivers/clk/clk-mux.c                | 26 +++++++++++++++++++++++---
 include/linux/clk-provider.h         | 14 ++++++++++++++
 4 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.30.0

