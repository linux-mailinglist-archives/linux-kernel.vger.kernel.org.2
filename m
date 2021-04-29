Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53536E53F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhD2G75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:59:57 -0400
Received: from mail-vi1eur05on2075.outbound.protection.outlook.com ([40.107.21.75]:44565
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229814AbhD2G74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEOvUthZlEWcgCsbKYTg3M7TU1ggQtjeYNSZR2RsBDHms0he1kUeLrHMFQWIAuYMw809t0eiUlWdwV3elOomQuaeFXU9rfnr8E3MeI+lG7uYDetHrqozSta5nM+QzakaNZNL4n79kMpViiX/MaqKDOlsnJARu18L3YaohwLGudGW2Ktsy8g8XN66Z/8cdOvDhLS8W6f6saCeSoKM9nccGQJ93OrN1djXPEF91gXbaF3gOy7vd439nepC0JxQi5SfcViLxBNiMd3KDpI6Sqhqlfbfucrw4Awu5EkEJEYAqvywjRfxT4CgYvfnug3TWOTdE8dunKHPOZ7UHVr2bCWj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WETTiMf1yIrU2ct3rg+lXqrZ1J3WRabXeyFgXWBpiGM=;
 b=SGnZwZVKvXVwrLnhYc38B2hym0SHMwvOz/5y5dBH2lMmORR3+A7UCvUwFOgv65fn50FlfFelP6gRYK74XwIqhGGBtWF2EwlvPE+cKreiigqGq3kM/8Cd5vMnCbzaTVhzNcng3ggkIZeEZ3IsgRXudaoU7lFZkVSHhL5IxsQKSZ5Xdz6JjF9fNZjYO+xRNeXpeSFYEv4520HPmQTE43fPSluERlpxhq3iFy9jAojAyCvzJlBlR0k7956o2Twrs0hrBdsn3D7AVB42JCRog3rCXg9OfxkAOz1MREyrAR1LI9LmGubvnw8mTcXgbO6SUu8qJVssGNO/PKwMpct3EXceZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WETTiMf1yIrU2ct3rg+lXqrZ1J3WRabXeyFgXWBpiGM=;
 b=LsWJPif2EZlY3vGUi87YhU2c5puZHD8kAeWZXuy6YPR2Z6G8rVvUrAy9c/RGWMgXdHZk6NsANzUYdtaSs4i4TgmhFZNBjv3CTnWmiUPCnsnVwSPVExNPzsJibaMyTj2XELfsUEtGGKHvWugyHTTZXJR3tFJKBgdUPqZVQSNf8ts=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:03 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 00/16] soc: imx: gpcv2: support i.MX8MM
Date:   Thu, 29 Apr 2021 15:30:34 +0800
Message-Id: <20210429073050.21039-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:58:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b157e9b-714d-4aac-69df-08d90adc4578
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468D461215301A9F026E348C95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLZjQ85hKOFt+SX9KaAM8LCtm4Erh+XOpJr1Eljc5c8ucRZxB7g4TcOXdgQx9hOS2wZF60cmPdV+MsCGFkX3MclGx1PiBMsvdPNeuNDdNBFokZ/iqWUkAv7dI8RlWceuuBNbpYAv5s8lyuovjTOBCyOJIe3YIHO11rgxkh+mQTqz9JhCrGWRSPjtVPNoiC4tlde1U/uRE+MtICYeptPeCRiNwSY6GYVUd72qErLQG6Lmk923JuPHBzO5XbcEcEonDlGEC9Ra4qIc3zeC5qPXCOMM+Rgo7QhffeqhNKd/zFPDmQeD3EbSQ6qIeqRDRJOwSkGOZbspNEfQN5DR0uNqwjqkK83QglHT5sXEtwAEpIw5W+pRHMXH5A3Jah+mcsmOckGgCwKBugH+ygFrFAmB0j4DAPviab4aJZ1GLKIlJv9DbZvHAe2YfUILnOAoY7jQurLF3tV7tTDw6sDlogEjc5w+Rd03GR6ovJ5CpVZwwPDxZ3b9lRYATKWDU8YSQdvZbzF+A8OaQ0K+dSmO9EQmWi/Sq1rsoXyFMi1st5iKRhBiWmqh+o/uCOc6Fxv4uc8YxuOBmdVVwdMeYAtRbzL2pahHF5EoTL5pk1iki8QgKXBtsD7Q4hqEi1fxIIHezpK9ZvtdxJOyAhhGrCla8YJ/azwYB6sMA+MaQS9BSTZV2XY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?raiO7qP2bGirOf+nSITUfZiFi1AUENdSzQvahh/ZLa/HSdEzQfM9gU5YaNfk?=
 =?us-ascii?Q?J1TVyi7z1xgsP98lY3FSvvYLbrjxyByackEZemutRCUcwim3cIGfSM3AAMm7?=
 =?us-ascii?Q?NQt2jYOaTan8IsDtieZ51KduXtEdMow2WEOENxoqCnvvbec1UkTEM1TLbQvQ?=
 =?us-ascii?Q?iQJNaHKOliQXALnju2cs2yutNRdqadl/0N2NAA43k23au4MBhSVqenBHMBOp?=
 =?us-ascii?Q?Xun5Q0MPHDjfrfMAdzTfWXnY1P81hXIb0h1dMzvkG05fFQXYZC5usqjY82lG?=
 =?us-ascii?Q?Dl1cyLOuiLzL0PdyGMdm5FZwpUU2zQ12lGKUBm+Lg2RcUkbe5RN3Vg7n5gso?=
 =?us-ascii?Q?UnKHzuELyzdKuo4CQk+5AVGZTygtQbVV62ezdUo8eH6SVqW1R68+xhI+4XtS?=
 =?us-ascii?Q?1obR77fuQYlHBkVOt78X0eCS5niloVvhNf8K/jbnY46lyNAahh9XL3tLzKj7?=
 =?us-ascii?Q?HdkNi3dYfcvsVmgZ1N73VxTTB0YE0NHmkYSlOfQHfKihcAqdEyjl1LGYmNUs?=
 =?us-ascii?Q?nHWaicUZittKuqGqpq8YInQTVAYK0zr2wTnePpc9FQSfFTjNKh8qapMCPazG?=
 =?us-ascii?Q?1ZHKaJoq8L15MJ0lXc7IJyYn8uP1I9la9rl9O8qeatIy7w5oHbPNCNNvJwes?=
 =?us-ascii?Q?YLC640WnDvNLc3ZkGSIY1YKhLI2xqguzMb4OdwX+mwRlvDNAOQ3n8yls8y+T?=
 =?us-ascii?Q?W7xGPafXgeu0H2PpaTJzKuY0VOHChK5YdRH4Bx3Un7lNxApqNX7ANQJTmO1X?=
 =?us-ascii?Q?JupuDgHva9D1M7KATwT6aO/xX73YQSFeXqwV3OCOIbJFbj2yRJXBc3VTQSBv?=
 =?us-ascii?Q?fmIP28Lf6z7bOhpjRrWwkbWWgLTEIhqb3+IJwQaWx6vJghv8Lz6cchv8T5So?=
 =?us-ascii?Q?A5hjSO68KI9E+sPYZntIXvf7km4WShGNo177CwPfKDK1fCA+D0CYcds8OkD+?=
 =?us-ascii?Q?aQWaHZOuZXtudIrO/7NDRK/3XBGmKeEIZsvvswoWBI1RA00W1khio6giAxn1?=
 =?us-ascii?Q?RdVIAfNHvAZkPoFNob8fVfZ9kCCHNDr4YtDFiFPBV1Po6A2whgsQ/E4XWp4R?=
 =?us-ascii?Q?hoHwCtfrf4SPDQCnkHUp1r6LB8jHqIZ9KHtdQ189P9oC3WBdRkgHmMmfXZ6v?=
 =?us-ascii?Q?kKmD2Al7n39DER/3ec+ceua0DkuR0MF6IeElVRNRKEC/+TuwDiK1eqxAbhCo?=
 =?us-ascii?Q?xqZwm2XAW2KYRNjyszw9WSXgZZ6Kf1LyX8vp+QHklLuTlAUdNnzMLXPmXnr3?=
 =?us-ascii?Q?+yjPlRRkSIZQ6ZUiQPPUd8bgAQeYhpQCbJYl+Eu5f+XHHLqGfoIxlqczd3/9?=
 =?us-ascii?Q?kDyZ2VvI8cF/soIC9QfPQR0z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b157e9b-714d-4aac-69df-08d90adc4578
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:02.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2b1lHMZ3r6AuQ9R5xbX9J+sUnJ+FYDHEBeBo2QWLNEu//ZyXNSAPKEPLiRW5PdcT3WhX0vz+Xnb9RX35uaUvyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

Peng Fan (4):
  soc: imx: gpcv2: correct pm_runtime_get_sync usage
  soc: imx: gpcv2: move reset assert after requesting domain power up
  soc: imx: gpcv2: support reset defer probe
  soc: imx: gpcv2: remove waiting handshake in power up

 .../bindings/power/fsl,imx-gpcv2.yaml         |   9 +
 drivers/soc/imx/gpcv2.c                       | 534 ++++++++++++++----
 include/dt-bindings/power/imx8mm-power.h      |  22 +
 3 files changed, 450 insertions(+), 115 deletions(-)
 create mode 100644 include/dt-bindings/power/imx8mm-power.h

-- 
2.30.0

