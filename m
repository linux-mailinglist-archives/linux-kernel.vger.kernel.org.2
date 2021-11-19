Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7F456CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhKSJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:46:37 -0500
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:32192
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234676AbhKSJqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:46:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEZY5zVlMSKQnkr9YLfJPMlFk8dTFiCCzVTRRfE8VegkyPXi2HX/vRUhH3YcCd6KRDgdMuqEdgdG8AB+sMxVFySq4Exh54zq+OSjJApHkTR+yUtj+/ThU4t5Sc1ouT/e1N9DgpER38dcS6rhv4iE+f15CRhuuj4UIN9hAi5I/UJCqgGJ7sVSiAnFkMmidV8Bs77bSUBHHVi2imgcCDk+j+lTMBGR5sItHC9lX8KS5OvckJq6oaVDCcKk6zuqSnDfpKONsBAPDuhArh3nPwLnBAEk47CPmi+B6/wUTe6ibB5XUEiRFs3t21SgflOU5iBPsTcGNfudytOjZxecpHpDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96JrG3b0LQCc+b5OLJPsbpgGylfNYa5FuYnEGb25CZQ=;
 b=RZGVDCWhTujxH6Q++eKEVtEQqhCJG6VfRFbr8qMv6SzuqekRGcKD7wkINZ4DEoIvotHArSiho2wAe/KNBr/9II0JCx83b1JHWCB4yrnDnDnLkNqAzxqIgAKuUpyk1cax8dzfcMZr/VXC1YYN8G2D4oHzY/Bn4Q+WvciICfIeZcQG/d/IUGIqKi9i252e2QTXIXUQWFyYKc8v5miWxjhSorfZSAbnF66YSGjM6n2JyUbwwh+7XUDAzcntfOCP123LfkaFRvovzFEgspSTxBnvZeWAJFmWRFK1r/6wztr4hfBmU0EMIrs6iRrHasqGzmuKaGolK+Hf2gGxbxqol6c05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96JrG3b0LQCc+b5OLJPsbpgGylfNYa5FuYnEGb25CZQ=;
 b=VBsudH4b+QYcrGv79HY3E4skAy34tk4dqXbc64S0Qp1RgFE4N4SIqsZKIcCDY+xpPTKek5HcwVt1Gus864vsKo4ZG1u8aOqQCy/ZVzxZZsBE3W+G3IuGoBPNONze21VWjKbZGwJWZDfuqYE7ExX6H1canjE6nK91O/nc85m/a4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 19 Nov
 2021 09:43:31 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.029; Fri, 19 Nov 2021
 09:43:31 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v2 0/5]  ASoC: SOF: Add PM support for i.MX8/i.MX8X/i.MX8M
Date:   Fri, 19 Nov 2021 11:43:14 +0200
Message-Id: <20211119094319.81674-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0099.eurprd02.prod.outlook.com
 (2603:10a6:208:154::40) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:187d:3f5e:91e7:280d) by AM0PR02CA0099.eurprd02.prod.outlook.com (2603:10a6:208:154::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 09:43:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bed823f-ae43-4fc0-c6d9-08d9ab410bdc
X-MS-TrafficTypeDiagnostic: VE1PR04MB7358:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7358F9B00F956E9CD199E9ACB89C9@VE1PR04MB7358.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ygB0B9d9oYB55MlrMm1bP1gMC+318aXWwBeev+SUgU7/Ij7OtnksPlMHoNsMjyVGBCI4hgOTk6b8FiIIcwnv1ORm/F75+lPkC5F57qxXw8VnjoNHNr/eT1cYaFd5Sr23O2KE0LO1h9wRx3r+4gRIqj4cMPyKEhIUoAqptOXI5atuyyzdbLOzW/xAdSfVz/ZMUzAwxY4RWjFyDQqgi6D0s+Ho7fVMY4XCKCGrRuFHHa+gIHPloO7ZEJpgJgcH+1ilvlttS3Ho7bast2tSs1iF8RZzxvFVdsymhfprDnkhhASQRxBiliwh1mjL21/Ib8zXu9iT2J+FeQhdlvsycmhIJqarW8gQ+3RfTqBp/f9z7dLxw6zFTov4ck28qHHVWiUaHx8tsfnkxqdS5eWRTwW2hCRUcrI9LZt488H7NoRsAB5sreLXrcbe9rP8EsmHw7qx7VbOzdVaCznbG3SVsxxKpRW4y5Jh+8snhYIhNuVEWDahHrPIIV4yINy6LcGt9LXS2MTaruskkTdgy0n3ebhcway1AJbnCTzoVhEUbjHWXW7iFtEf50+9TR9S5EiUuydq55qXIDROxAbdKGqT0M/FOvIx1dEQUPdXPMeUOzCpJ4mbvDZhCBdSnjCSMaSzz5sO++1gfgHboZbDktn0omiQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66556008)(52116002)(186003)(6506007)(6512007)(44832011)(2616005)(8936002)(508600001)(66476007)(66946007)(1076003)(5660300002)(83380400001)(38100700002)(6666004)(4744005)(4326008)(6486002)(316002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hM4w4RvumOEeCOj0kiU0VMyO4ZEV4kULQ7m2r6pbGVLtBh/a/y7+OZBTRNEh?=
 =?us-ascii?Q?ymXGINISVpy7fb+V7uD4IGBeKolUwcvuNNa1rsfkUpJvYTOsgc8ugt6vJ12d?=
 =?us-ascii?Q?Lor/3QLn+QYX2FyIQ5zphe2z6tNkXT5yQvdHutpsF77CSbYneWUI/NMniOYe?=
 =?us-ascii?Q?nXqkoXKYdDBhCkI10qHRgGg76FdjoNI59VPNDdEb7KsDVbpXLmQ+oUjdM9+H?=
 =?us-ascii?Q?RITC5VmJxjJtJeiZCNs5O9QIsgZFuHPnTFLBjkY94Nkt6EuszKL4CYxLHkx5?=
 =?us-ascii?Q?IETOOCpOP1E4rpHvPkMzp8Pj+xtsCPq4tgMuFLygz2Hkva/UIW/g/68oAHds?=
 =?us-ascii?Q?ocaktHbEadDryCwJ16gjbx7JAWB7jT3R5A/08IiAhgpGp4njpZ1PcWtLUJUI?=
 =?us-ascii?Q?/4mHFjE4O4fyfR5itYFKvI1rbNt//e4Rij6Fzy1Eca2jRRQ2dWpgaLgJiDUt?=
 =?us-ascii?Q?MK5JEx3HB1A9R46HoV/Kc0YbkQA1tWYrunVSB5JqAVusXXLLIHrCnj6wAaLa?=
 =?us-ascii?Q?pp141Cqe6JDnmun6QVTn1+1C/KeaC57W45Y/4axsLLkiqb7oMgC1ThWvfTTu?=
 =?us-ascii?Q?ikD0AKFs67IRMvatTXjgAnbO2/G2Cadp7DgPlAlEHbHOA1jejrjHIOQEiKj9?=
 =?us-ascii?Q?qNHmIuwUfhh1NjneZ+tnPvFuetQCPaL/oBGTK5ZEuAJ69lYXNvCqSJ2N/1Om?=
 =?us-ascii?Q?AT+xhB1ueSf5+N/tykcdciVTpCeto3Hz/33UEtwo3fC298JKVepeg3tepXiE?=
 =?us-ascii?Q?MRIl6Lc8lGU6MRpO8jHBjxVEeKn5q95xFCpEWeq96jZTkBVhPAxFXSD5+xkB?=
 =?us-ascii?Q?vvsDYOuHZRgUtzMjmvkmCcHwH8IqbsCKJdqu7uccJoPHNZVLI1aSwhSXuNIZ?=
 =?us-ascii?Q?Xp4T64SWlLbbju/0PMvD09khAi07VOKSPLcNIfXoqUjBSPQ6Mq7q2J6/CZ5Z?=
 =?us-ascii?Q?EsD8Wdoa4xBN72Fkj6YS6waKkyg8pJyBe60X91VLVJMUzzubhjVV0hscbxwY?=
 =?us-ascii?Q?sX8D5QBYqtaAt2uKU6yFe1vzSyGK/58BdUFU4CKkbmmRyxytQhoXEkrWxxSe?=
 =?us-ascii?Q?UOY7kvKer42bdEveVk0aBNxdqslDgbT5HHfcU1DOu56sOoF3i28IOp84LrD2?=
 =?us-ascii?Q?8gP+Xbfzv86fgSYDfq9xlNjHhkRjmzy1a96xJlO5/w3NfyrKkS7NTMk6gQAd?=
 =?us-ascii?Q?ztuzf8TEuGjsPUrxRkZ43yt1/MIV4PjlmwVYmyoTc+OMe7Ce8PefJ30a8DBc?=
 =?us-ascii?Q?1tytO3SHzS5rRQYBJ2IWi5VeyNwKp35J9nlUpf7yeLhuqdyVZyg3y7pA4rRd?=
 =?us-ascii?Q?gpvEJcp/U94KwDb5lvbnfX2pQwBnQlVtFVrp/WPr7Bw+MqvyBdoiSAMae/iF?=
 =?us-ascii?Q?pCobNNkQNTF7oM4shHyMyHsUdoIW2FIsa0Tepjz1WqMYiTIrk7M0zP74q8Cq?=
 =?us-ascii?Q?yfz/cuubMSo3sMfurddwTJbVLVHnkpWkpb43SUjNXbd7WSQazejm3NhOCMWt?=
 =?us-ascii?Q?O+NtoKMwfNmLDgpiNoBRoNEWx8dbERprowcFbvyuKWoRejOWxBB4YbNL/4wl?=
 =?us-ascii?Q?z+ggoVUaPSVmBK30FZuXoTwg1oyKFJpqyXSMVrn4Qcpj0tcj8m3+SvlHG9r5?=
 =?us-ascii?Q?IALW/Z8gBZBZa6DDMiZS5d6mFZf6/Trrh3M1SCZXhjyWtQuW3QKb/iWCMJSk?=
 =?us-ascii?Q?duTSSYY17x3lxlNRUa5HCMn5buRvkuXDiDO3ieTPfSV3gQzD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bed823f-ae43-4fc0-c6d9-08d9ab410bdc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 09:43:31.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgjXn2jSKH80Wuzzz+druE3n0IqgrVCFkoRlxJFZbYlPjTuP7d5358WLJTk7HjOb5479lRyHTcJPbaBO4jI4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7358
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series adds support for System PM and Runtime PM with SOF for
i.MX8 platforms.

First patch adds common code to manage clocks, patch 2/3 adds the actual
PM support, patch 4/5 implement the DSP start / reset callbacks for
i.mx8m.

Changes since v1:
* rebased on top of Mark's for-next branch

Daniel Baluta (5):
  ASoC: SOF: imx: Add code to manage DSP related clocks
  ASoC: SOF: imx8: Add runtime PM / System PM support
  ASoC: SOF: imx8m: Add runtime PM / System PM support
  ASoC: SOF: imx8m: Implement DSP start
  ASoC: SOF: imx8m: Implement reset callback

 sound/soc/sof/imx/imx-common.c |  24 +++++
 sound/soc/sof/imx/imx-common.h |  11 ++
 sound/soc/sof/imx/imx8.c       | 137 +++++++++++++++++++++++
 sound/soc/sof/imx/imx8m.c      | 191 ++++++++++++++++++++++++++++++++-
 4 files changed, 362 insertions(+), 1 deletion(-)

-- 
2.27.0

