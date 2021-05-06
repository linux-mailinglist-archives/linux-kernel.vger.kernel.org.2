Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195EB374C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEFAda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:33:30 -0400
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:24131
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhEFAd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:33:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAzqBwS/Yoftky7OPsjhpAlRLXug4YnBLU7+Y9fRYUjje4X1CUCpmFH+cCpG0wYZs3erW6wf0WF1rNz+E5YW7bN+UUcWO3pD/aQeqh5INx4RyBBCZNlSZVJgFvaqGYvgi3Y8BcWxc6H0jLNFB0kXAabyzA2FWs7/G64hZWB+tpTd4fVKyN+2Ig+2vSW/3mG7Bp7eDeN4uj2BmSi0Ci34f+9p7U0T6eyG/6Zmv0Z4U73AFCI3zPs6L8oE4njKiguMFiE4N4mk63lYc8TntWvF8072/6BeHGYJXgJeo0kMqAdZWdyZLPvQK3m/q3v9F22MP4FMJx8Id7BJ6aUEZNSupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6k2WIpRRA9ACZEJXANL/tH/+86o7qQa0yJFOXvUNAk=;
 b=h8geCZAs22HOogbh25w+oQyAHZL7QaoU/safBtcyrVwF2fswPTITeuk/hSxLyKy2rItlAu3ns4M6qan3QWLjP6UyikGn4AcH4NwVqxTPh3WxbE5Fif6zMz9XdtfvCi6++Z4Mc7S4ajUbWvjCG5950j/vDKbOY10KjDd/NoghJnNrSN/MV1AmmyVpBJfQ9XtCi7VX0TpRUdURzA//s0pFds6LEhXmL+2TFGqhn960sVMlp6BzY7X+ddokN1FirdISmR8Bbd/QFmmvlJNb7Eh/IHNZLO6YpMS3bMUOA8Y/jbjfRWAJgoJsHXwTcUQhZb+P4ik7TOLutg7jMDgcNmFPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6k2WIpRRA9ACZEJXANL/tH/+86o7qQa0yJFOXvUNAk=;
 b=b9KhdHgsRgKmmrZrmh9Hw2quLQpKbQmtinkbXphZBIvnn2OvQg4FIVt6jPiFa23SBU0gytQ/WzFm47pintf3CcNUGUWd76bVCEKPLTqdnByPFL9As6CLMnCeFQcy9SaGxQ2dBf4m/elpapFSkL1lU4URoH4kTlJVhPGeC5byv7c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:32:26 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:32:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 00/13] soc: imx: gpcv2: support i.MX8MM
Date:   Thu,  6 May 2021 09:04:27 +0800
Message-Id: <20210506010440.7016-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:32:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f75ac8a-520f-4a66-7e17-08d910266bef
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6714494AC304E317FBEF1C6CC9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQvp7HUFYT4G5GsgCylr8touFIwmpGhZy17HE/b422C/Vi6FfIUMyhQTejj+uRVnFte6KLKvLXvsH2uKN6uCn8Y0Kch/lAFwGcgXmTpM8/EAn6or6c0vNhcw29+DWcb/lBhe6AI0WpNnqYwlvwSYkwMgD8o1AEUFMoIooP0vQr3SpOBijOg/7qVgi2S1BdWN2jWRdXOQ9kQlQlpjwOlwzKlBbtfCP7eKnPcPOwj8+cqmJ7ib0M0x8oOEuzugyRaVO6HUrKLAiRmSJCsBs3lo9KGSPnYEzHCv+k9gXhd9LsG7eaSIGxi/wCXP9BiXSQz8GZ8u0jmPCLLO6A6JEM+/5dN7uqC4hNjkeUj1XQlqMOqVS7YBI/a82ZhJcwKnn0+P7LuKdkUgCas7Yc4Z2rfeXNltHK9UgEix4cjbDjbtV1fohC5ibJIYghSXNTpP//dx0WVAFGDRVUlvx5dYvOR2hY1V5N/H/7RYTeuteut/hOfGakaCD+SO+mK0WlY5SZs8BfhvFRUGm40gQ2Pg+ZCOpn7a+vhdaW8zwcK1xPhcvV4U1vQ0NI5x0tqHrnVdbS18xAd/wPH+JY2VYLXBMOmH7O80P0z/ld+jwp2OYE/3OHpPhTriFrdGN5n4CubrCLFetzdm6epE67N5oOvPF/H6OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5A7ncEPSaEocApnTiKVihYvGA+LaJ4dhn5UDU++d3FLUe/NzIpUzCfDAIQD3?=
 =?us-ascii?Q?2zlvgvXf0og0J1T5S8CFkGHHUUUN4YLbJ5sdhaR/yCYQ2SZytnakXA9WHyAm?=
 =?us-ascii?Q?ZOjpw0ph1ghRSHP0o9EtHsnLSbajqEbSG9SWSZpUaFyOyLadqXq45Kh7LtJ3?=
 =?us-ascii?Q?4EQJ+Ie0lxlt+XX27+A+cGZILwVg1R42dLdoY6S2JPhOg5/bjgI7sy7KnDjl?=
 =?us-ascii?Q?xqtaLBr0hvtgc0YIcKqPtQxyT5RIze50S/qak47OLm5utB/Y7KSEHiQ23Y3v?=
 =?us-ascii?Q?tV1+7DNbhG/q85yVK/rMee7rc1Enh+W9vCo1FQ3CuhEmbhhUD93Py0Sx46lA?=
 =?us-ascii?Q?zAsepxPIkbxEdWTsQ5DSg4CHv7D/mKXKD4MwyAZPohCHqsgB0UxPHsiLjXTt?=
 =?us-ascii?Q?rqtoW56aoB3LWB+M8Tvsit1kj3xxits33L7TtetnQMAoF/kUDt49+nuv4vsc?=
 =?us-ascii?Q?OEb/+42ephlxLmtrSc87UjvB+/fde9UlUf1yllk8RODdUEPSgMZyv195EbNn?=
 =?us-ascii?Q?PBNu+RS25aTRtbvuKIxtvyYKD/SVLEv0aLFws9vNMHNrh1QcJod6OWtHJzpl?=
 =?us-ascii?Q?qI3gH3AGcOJHZ31nGQHGgmGiNd54YeSJ6+p3NIEzDa8wvCHuA7X9HV3E1GbV?=
 =?us-ascii?Q?CSur3MnBEVTdmWT2B3Nr0CxfGjn1HT3aK5ddI67Ya23ds6pYfEJ1p7wKVv7G?=
 =?us-ascii?Q?Vc7tWmP2cBzwdQ5gp6gH13xHDEFJvTUBfHhfPLSm86Uu/Tz2uskbMKLJ6q8d?=
 =?us-ascii?Q?yKolsd79kuq26hkw+zDv7hJFex57YaiE/SaDJY1l8NiJjNMiJ2LnjLgEnPET?=
 =?us-ascii?Q?LbbaDdwGifjh2l7KEq1DInh4r21xI1nsG7crSzuVl7D6+9/pNb7/3WXcL7yb?=
 =?us-ascii?Q?ZOUgcM7Z4WPBXRwjh2+ZF6Gpe6sahea9yaRPmw3GWv31TAuVANMcV/U5F5uA?=
 =?us-ascii?Q?+fDgeDR5LVBB0m30XFJQiDf5OIj0NnDxky1SxMm0syMpo9kAzXpeu6724VY5?=
 =?us-ascii?Q?+PX1hM8F/2lJiAIX1Np5K9mH02ouahZsAPQNZBYUpM+vIqwFDqf539aSwSDd?=
 =?us-ascii?Q?VkpPbOu8U5vGvMYWT0jfCeQpMnCk51CHrWX9yk6N8SewCEb3szGNibZ6h8Nu?=
 =?us-ascii?Q?1ILT4gEtN+3riFyDJA/qXRf93eQb5DPuQO0mOyQpCJ9TKrY8z1OM9v+JzFhf?=
 =?us-ascii?Q?FmfcVs206mnYqtVELa3BxZ5sMkVCAjoaodd9YUnJpDDEgnJzxE2IbWI96X3q?=
 =?us-ascii?Q?RaWZ4eDi7qrJweuiqSWrH9uNdS/stCeIVHVP2MGRuIjkQRPuoVaKBz8v2p/r?=
 =?us-ascii?Q?Pw4guhusjAh1LOL56X5ozZF2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f75ac8a-520f-4a66-7e17-08d910266bef
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:32:25.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5G1wIjx19+56EuCibQIyuXEOhsao6KkD6y8xmEWoIet3KnrssIzo5z2uJwIXCIfFoVFv1+TgGzaBJLrDmzv7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


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

 .../bindings/power/fsl,imx-gpcv2.yaml         |   9 +
 drivers/soc/imx/gpcv2.c                       | 542 ++++++++++++++----
 include/dt-bindings/power/imx8mm-power.h      |  22 +
 3 files changed, 458 insertions(+), 115 deletions(-)
 create mode 100644 include/dt-bindings/power/imx8mm-power.h

-- 
2.30.0

