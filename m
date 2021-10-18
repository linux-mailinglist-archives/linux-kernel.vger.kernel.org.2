Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACC432261
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhJRPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:13:09 -0400
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:23649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231966AbhJRPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:13:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1nEyG3Iv87rppVV0AddUMoFWQE8z655bdTWpMA0jTpQ32EzW4H2c1kOdq4izvUjuCp/AiDTVmp53JhUDg7EO2Pk/TfktZAj246YIJp1xtZ2g967fEWTUCXlrcm9jLPatDL8BRjFCuBdem/VdLW+XULxhSUZAsnnKEDzEC86AgsHMoVRv8pbHRM2uW/EQ/Gah3v52wJhp+WB1E/kws0zlNNgO3h0flhJcDjbCKim8y3MkSGw1Mwapd59QU179sIO6358hn7uofY69q7Pg0x4SqCmG13sbFyyVO3lTvb+FK5d2WaIIx3mal2gxjLArhAIBHPnjS5pU3L31w3wRn9bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbGEfbGjKzD2DjPS1loUnLZu2ElmAcK/jOzeSFl4Bic=;
 b=dtLinF6O/cbTPCfgmicIYaejriZhzVrCAg/i8ov73RvEpdns4/kfA1+EuQShtZPE1E9KmVzxAS+30Pm15UlELMyY1lBq4RPBHZbMbgtomIR0w0i21NGDg/dkSVoaAYJtiKMMrPUU8ubRC5PHGDi81+ZIVmxW69w4FdTdHhqMc6CO+fOpMjomejXGAoSK2dB0Ud9SQt0iXWn+IGryyRM1A7Ob44ysxlSuXOcQxW7PYrBbtRa/+F9AFQ5kXGllzraPJ9roRpNrbWngK9v0C+A4NUK0aFrKQ7qwPR2vgxopNNlkL+zRhcUqFvHPVxrYX3YPJvamUGssoZKClvZCZCGYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbGEfbGjKzD2DjPS1loUnLZu2ElmAcK/jOzeSFl4Bic=;
 b=fy6ZjHA15pb+F4WN2id806BZ/E34bc+K9NTvgWN6/WGxWKUUdhFUI66dRAcifDYgbLp83TAXS4X8PGPV8/MVg1kAgYbjFiRAXp9rBPX8RgSU867L+tcY4GBx8cPmb5YIGl82BW2FiycVeEfqRUVmXQotbKS2C7C7/GsaM0W1VxY=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13) by AM8PR04MB7268.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 15:10:55 +0000
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726]) by AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:10:54 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     youri.querry_1@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/5] soc: fsl: various fixes
Date:   Mon, 18 Oct 2021 18:10:29 +0300
Message-Id: <20211018151034.137918-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13)
MIME-Version: 1.0
Received: from yoga-910.localhost (188.26.184.231) by AM8P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 15:10:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec1b0be0-0dab-496a-6d7f-08d992497ae9
X-MS-TrafficTypeDiagnostic: AM8PR04MB7268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7268514607B2524EEBCFD704E0BC9@AM8PR04MB7268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2a6pMBjvrjit3prFI2R7sPSRTpfZfrR/AHImMZqsezpbmQ8ZZdgSgCPb5BJZBvoydJKFivcwkJL4H51+jaORIhuemB0div4EBYufB6CaghZI3/NRGZDcLhCBYI6TgjXV/RZHEftV8TBZtnAUAmTl/NVaOydGyVmw/C55Op0IjtYJmfw2ywp8Lii79L7JLrnRbbNU3MeOKToopoRt7FBfGgAqtG6b3QoQ1rVBz0R+XDVeGyKgrDaq4zKi293I+KJCNTOMB9izM3Q1YyzuysRfbQ5H2YjS5HLIvYkRVOw4/iIyVTGstMm99klnis7Fqbk2Uo9CcGYJDhbfHw4o9XEmypR07zhauEYkqWRk567uF42LGNP6A0/XE8uPSQ8tMwzZvf3q+cmsQAPGNAlenovniriYHoEobtqpgmuZOYVyk8fDo7PD1oGYxU1yNuugx+O4up07B81K+qJWcYWv0cc10VPv2Tek9J7VpR9Y3CIGBGTvuXnY+Ufo83U5+3+pQI8yRcq8AqKtxVer/xhBYvv27iUQ9XOEXNiWl1AavsmzkC3bfRWPxbJB/a8lRYKLmCvdR8XkoWLcLDrkPCCLS+anjtswWV7OYdpqxdmkQBG7SjCYgC0iakjFqXCbufB5nNhUmOuKXoMhnI1YxhQ2GO769vlmZPepjcAhLW8hbBqgcJX4X7JAQk+sbGyfVnAtUhE/XffotgRV4HCuKlfAw3Pr9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(1076003)(83380400001)(66946007)(66476007)(2616005)(956004)(86362001)(6512007)(508600001)(4744005)(44832011)(6636002)(38100700002)(8936002)(186003)(4326008)(37006003)(8676002)(5660300002)(52116002)(2906002)(26005)(6506007)(38350700002)(6666004)(316002)(34206002)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TL2DC03W1M9dIEHOXmwqY9ICAAqx8XTOGzX5AUiLkfJaW74eg/mCSX03HdAP?=
 =?us-ascii?Q?gGiw0SYWqV/yRW3IQsXeGxOuuo6nRXyIgK9Dub3Q2BHI6mvyQQJUf8wY3rMv?=
 =?us-ascii?Q?PB/nhZgKJDM8RRLQ+TZxRqbyTpo2mOTdVlJRtGkWD5+1e2eVGp+wV03o3uYw?=
 =?us-ascii?Q?VPgKpoeNrUUxGopGIlPtRILusFiVwMQyNN82FQbJf/SNkEIkxgqzA9TGU8L/?=
 =?us-ascii?Q?vBhXWCp1hzxjwMxT96/YioZMRbBD7wMMzV/lnwYpIIb5GD51r+GWMCgiDqdf?=
 =?us-ascii?Q?UiHtCbBeeNq2AnFhPDrGgCb9fDJkHASsXwLS8a1N1wjRDUSE3P37PxTAfuLH?=
 =?us-ascii?Q?EiZpcXmRO6TdBrEhQS4X5Id+lS79CwjR7wEEcVAZ/91KfdT7/RObj3yjrSSF?=
 =?us-ascii?Q?iXt+vamcrD0M7RUK4OyfIRbV8Gk/rcKh3De6SjO/C5pnIxpJAfIlriuF2S5+?=
 =?us-ascii?Q?yRCtj/YszB0wUnax8an9rK6jGM43tlkqB4GkhBh07rPwahQKUfg6OvyYwFlb?=
 =?us-ascii?Q?xLfYyFRISGyxguxfM5mqqXZ6Ts7akBRW2lIW+g0EWX8AdHpZ1xdFEycJIVch?=
 =?us-ascii?Q?jhqTnRmluD10JHRiAUO3mee3SpA7JOMsdiyVkJHBChRevT0ybAwuzjS8T9Sz?=
 =?us-ascii?Q?kVJSZk/yTEU98dGDep9H0BK+k4hu02faR/9f3jmSD/o70cY9OSpD4wPxoP3M?=
 =?us-ascii?Q?DXa9L3PGXZ4Zkr4Qg5Vu8eI0Wiohi+RUd4yEOE+6NCOE+ycs1bzXThwhM1SJ?=
 =?us-ascii?Q?OI6dcMNF79MidRL6f0cQY5nR/Hi8ZyK4i9DCsHLtWIvkCzrfabF/qCT+H2pi?=
 =?us-ascii?Q?vqrJwJ+LJn11abFIH+EB6l9xoTUMSGr2k39iw4EhyiwmwFiRGvuYmHGaKm5g?=
 =?us-ascii?Q?tG2hUduwTdgU4uLzEKVJSmMUlvJdEoOvB0L+zg5NGpMdcIoES9HkEdsYyWWK?=
 =?us-ascii?Q?jYHtZWUf91rPci8J0GzGh1ob3/1ehg5AnmCLK9ZRsePFq9CXr9XIhKxNt+0o?=
 =?us-ascii?Q?yRjLExehlCZQUnO7Fan5fjqi4HchUigEryVW2SEJ+zv1slvVZMeBtz3tCDuJ?=
 =?us-ascii?Q?sdjQR5ct7aKaHFim5IRvjuuP2SJQsKeXDGzjQXotZa9bCO51eq103PrLS20C?=
 =?us-ascii?Q?ZRo4meNQP2r3hwQLdQwhEMOQfLmWrf+n/t97tiTpOaIBMSIz8ZtvmOM6klgB?=
 =?us-ascii?Q?C5brTYuvc27j2pY2q/UK+JLkxWHtpqLZ85tL/Ux6LVDBLKr19EAcOmd9lspz?=
 =?us-ascii?Q?ZTMO0LGPbn5kE3nzVsn4IdcE1dlZtz5QwER4nlnc3l5GK9Qx7rX54PLAsQX+?=
 =?us-ascii?Q?IUrERmjdxujKq94INrKbRI1m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1b0be0-0dab-496a-6d7f-08d992497ae9
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 15:10:54.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nm7i7if8dFs4WaDbSNRXFuQ9vqaR0JoqVVxXyDP8vIB0jqOl1ujFG2GIlGW3iVKeLBmQj8C53I3qxOgQa26sLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set has various unrelated fixes in the dpio driver and the
dpaa2-console one.
Patches were applied on latest linux-next and formatted from there.

Diana Craciun (1):
  soc: fsl: dpio: fix qbman alignment error in the virtualization
    context

Ioana Ciornei (2):
  soc: fsl: dpio: use an explicit NULL instead of 0
  soc: fsl: dpio: fix kernel-doc warnings

Robert-Ionut Alexa (1):
  soc: fsl: dpaa2-console: free buffer before returning from
    dpaa2_console_read

Youri Querry (1):
  soc: fsl: dpio: rename the enqueue descriptor variable

 drivers/soc/fsl/dpaa2-console.c     |  1 +
 drivers/soc/fsl/dpio/dpio-service.c | 42 ++++++++--------
 drivers/soc/fsl/dpio/qbman-portal.c | 76 ++++++++++++++---------------
 drivers/soc/fsl/dpio/qbman-portal.h | 39 +++++++++------
 4 files changed, 85 insertions(+), 73 deletions(-)

-- 
2.33.1

