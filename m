Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766134900C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhCYLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:31:52 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:18689
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231245AbhCYL0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbL7hXEs3bb2ouc5OiVXZtY/8pxIMRrD0O/myBZjHrzTaLQyb8Mm7dbwMwsLqbWh2qDZfMpCLBH9itWgT6+geZoJ4oaax3Ylzu+fQFShvHNEOnsc1DI0e4HJAIV/EdBHv7nF2FivGFBwCdAI/4yBfWlSqzXgqnojR2WKJ5YHQWqIul3kOyM42TTgrrn8GYWx57MKPjZBzFDIdzpI9MVCGAQUjxTZFRvh+zxW+jzFGDxNrYb5Urps2/Cj0uL6uXev6ArNEU4pLdICRhO5dGZ7p0AsNUKS5t1zVw07LGeSb+ukHFKeTm01EweXGKS9pd38BLze9rQwFsdAaDGvkoMYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3kAqYUEq4uyGtXIjIk9j0olUm4392hcOUA5iNdKVBQ=;
 b=bKRWFj1hvORYWrZT4h2M03VjR5q7B7cn9Gf+nDufWF6E5SQFfVVsyqttcM00MXha0twT6VydwQe4RB65XCdgmpDEwimCeHx0GgbbTLVlQp290ntsYz15VqRpcuZoivXZUJA8FC80I12g2aNrCo2GVX7R8tkLUtmGZ14Jsqtw3/iTXB/VOih6aNuimEdoWfnCTFKAxNJDv2VxeCW58iBJriJqlI+WjUVmEVjZcfB9vOJzN6VUS6PE3s9CkdpaSkLk1La2nB6E8r8hHW7fsO2oi9YFAULGjDnZkwJpn8+MWrzpkqiZGiER4TmlsCmq75fPs1vFed/nP1tRrscdAx8wbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3kAqYUEq4uyGtXIjIk9j0olUm4392hcOUA5iNdKVBQ=;
 b=LgOWPZcdz09oV/f9XI0FE66GR+PEcnkmEguYzkE7QdqXz0JDGMy1tcrmDbyXFGh9lbgMZTiAKJwKLPczaNEWYl0rDLLoRTBc7k4xWOyn8SslA8VcQxZWmnwcNb0zxrKtdNLXzN5GMQtqOjb/8i2VPMkGHZwvoFK0YEM4DuS3ugA=
Authentication-Results: alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB7232.eurprd04.prod.outlook.com
 (2603:10a6:800:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 11:26:41 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a841:34f0:bc5c:3764]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a841:34f0:bc5c:3764%2]) with mapi id 15.20.3977.025; Thu, 25 Mar 2021
 11:26:41 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     daniel.baluta@gmail.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, shengjiu.wang@nxp.com,
        aisheng.dong@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] ASoC: core: Don't set platform name when of_node is set
Date:   Thu, 25 Mar 2021 13:26:27 +0200
Message-Id: <20210325112627.275632-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [86.127.155.38]
X-ClientProxiedBy: AM4PR0701CA0041.eurprd07.prod.outlook.com
 (2603:10a6:200:42::51) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (86.127.155.38) by AM4PR0701CA0041.eurprd07.prod.outlook.com (2603:10a6:200:42::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.15 via Frontend Transport; Thu, 25 Mar 2021 11:26:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8aaf26b-aae7-465d-e5ba-08d8ef80dc83
X-MS-TrafficTypeDiagnostic: VE1PR04MB7232:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7232052774CD896FCBBDAEA8B8629@VE1PR04MB7232.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5mOh6sfGs+2Y5cWJpsY6JtRKh4sj59ovJMxfrQvUdkbz/THKTUwubpKouxJJ+/wsVNiOyFRxXQwxXCW++2xc0g2cQAw/0EUlIR9jYRWJolDiX9/tGIqK+/mowIEFAuuGM1fahbb5WrqOLKsxqwGD5omdZhkAyNPFWEIkyHTq3+zAz7bhqmMvEP0LNES7k8LpYi8gEklJGQEZLRyKiO/rQoqfwA7cv9EAuAAofjYSQ1DYdYzUSGhMKjKcNp0O+mc85Wb02xR9fjLUkYYY5Uj4oVA5UwxmoGFhTm2a//iJUQUdmNWfoDk+5kb27l+XM7XcUCuGeKz8OchujEZ/L48jVtmlfTsYLGspQutJbeR6fd/GbYjNuIOWugv32DEA3q6ciCr8vf4n78ddcWi91d/klrg9At+Ls8R0IrfarUteonLHy0U3buWSaZHtMfkY7CCjSNlZ+y4ORsVv/r7YtGCivqw3RHFMGAHMKwWFDeMrsTsSm5eSpDpeHquzHF5fJMNHE5BO52DXtOP6zmrAdngFJJ2RyZmNgL3LTohoHoiIRpxjE3V1P0ZukjM7c+bZmx2Wi8/emoqFnWIH0Y2SocjdSn+RY3kY++EOGXp2JfLHeL42p4J5/IQ0UEKC1G8GE1unv2GWxw2wMjQmbwvldTvQ3hxlE6iJTng3zF9ZC/MW5jDj6MIpq8nWAomDPfn1496
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(6512007)(8676002)(38100700001)(478600001)(66946007)(2906002)(66556008)(4326008)(66476007)(8936002)(69590400012)(83380400001)(5660300002)(6486002)(956004)(86362001)(6506007)(16526019)(2616005)(26005)(186003)(44832011)(52116002)(316002)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ru3f9t1pZplDgvYfQUDYitA+PTcII/Xv5xcz7Uf3QO5xvbwiWCyOO2kvWE1V?=
 =?us-ascii?Q?aUUI79W7d13Kov2/j4UgVASJU68Do9R2QZWygExUtj3wobqNyxbPgy3cKLJk?=
 =?us-ascii?Q?vYF6BDzIlDOcRYTGoW5Zt5wMXSBCHkRaZGdGj1YwbHCMZfaVlnCR8Mvyg10R?=
 =?us-ascii?Q?70bKCdC5DzRC4krkvUFlC06fct3TKgSVy+JvfhSu2yXrAOMYarqEFf0lM0Kz?=
 =?us-ascii?Q?QIzv4ud336VMk06NOnX+NUfpcP8YMFstdH61P2O68kp8Nw/Ox/JtHJ9bXW4N?=
 =?us-ascii?Q?9btDniXGwU7OdTMHAF22M2VBiBar+WyuBB9LrwJocswOwHrftqE9Fyr4dLOv?=
 =?us-ascii?Q?hgtvEw+QpIk2p+FwIpWn+5PEjcxHDiCkLmj0r8B5QJ11nWKvLjgBeu0zE00K?=
 =?us-ascii?Q?2Mwo1Mee3nOv2hSAUkQRJSkZX7IA2MO3h6m60Xn/oCAADz8t5I97myxG9ZFb?=
 =?us-ascii?Q?V2dB0U8hS09LiM8MonMSwex1V5Qc+Rjcpmd4rDeSZlXOyRUVJe9IK4oAQXEM?=
 =?us-ascii?Q?33FYgto0qT9MtMvRxEBVn74lg7P9NlG0AyVk/7LEnNbKjvlshfJl0nPG8ns3?=
 =?us-ascii?Q?Z9pbKJWIgj1dM0KuxL3OJxIQ7UC5qo/WqDk0A74ETohHISaOE4CWYyPN28M7?=
 =?us-ascii?Q?4deUxRni7XRSb+hYtv4N4Hca/QXQ/jJQ04w8tofXsH/p2X0BFlcXDuxm6j1J?=
 =?us-ascii?Q?dDoTKIx6HtCExsSRrPQOwhKZA5cijEz/JR8Tu8J1JNIoF3QvXduNPk80Ebt5?=
 =?us-ascii?Q?V9sWKRrYMEYnaFYx2R1jJ52JChOgrI3fTMo3CMSUZgxWiD+mMJXHvgs4IANe?=
 =?us-ascii?Q?562Ccznd8xVre0uR1wzvEm076GBGp26wTunuoqxZDUvfrkdStbgycGO+oYwq?=
 =?us-ascii?Q?YQQQOiVrWARMc/CQOWaGIhkNzNejS+TTGZa1qiDKR/qCU7olPMxhzK8o7AaX?=
 =?us-ascii?Q?r1/qsNhqkpbwPyjpH1fVLSNJW5POY916e1bBnhOz4+NvxPpbuByf6sgWmU4i?=
 =?us-ascii?Q?RMTNdiagDbF/fqrQJ8cir5a/ziZ9xDtB6/Uz6uZJ12U/O+Xlwl4PpcVIG0tt?=
 =?us-ascii?Q?jm9YCFcvSWjre1zbyLy7FMz9p2UGOXFdOYwhRi6f2ERKZVWyBUEIAHRijg2A?=
 =?us-ascii?Q?0Kvr8gkGdizVjHREWuW5x291mxyEMwe9BIPFni0zJjwlEmiukwNWdaCL873V?=
 =?us-ascii?Q?jWqKRes8jB9ibzlvxIXS9YRzepBuldB9YPu+XXMVQrcS+juocxmT5LVMGz+D?=
 =?us-ascii?Q?Sehc6vGJqZbhk2NsWiI0I7HBO+fkkGndreTnuZ4cyZAJU7kZSfz1bvbRj4lK?=
 =?us-ascii?Q?FNWumS/Q89H3wF5+xeDVbOIy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aaf26b-aae7-465d-e5ba-08d8ef80dc83
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 11:26:41.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEsu2GFGHvnKmLxgfhCppRrlMw3DC3/8OUkOCDl53K5o0QgH+iNsk4eVynrofMryQyPBCqBd0GBiSa3RGjcPdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7232
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

A DAI link has 3 components:
	* CPU
	* platform
	* codec(s)

A component is specified via:
	* name
	* of_node
	* dai_name

In order to avoid confusion when building a sound card we disallow
matching by both name and of_node (1).

soc_check_tplg_fes allows overriding certain BE links by overriding
BE link name. This doesn't work well if BE link was specified via DT,
because we end up with a link with both name and of_node specified
which is conflicting with (1).

In order to fix this we need to:
	* override of_node if component was specified via DT
	* override name, otherwise.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/soc-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 522bae73640a..7a1c011a7fe0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1648,7 +1648,11 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 				dev_err(card->dev, "init platform error");
 				continue;
 			}
-			dai_link->platforms->name = component->name;
+
+			if (component->dev->of_node)
+				dai_link->platforms->of_node = component->dev->of_node;
+			else
+				dai_link->platforms->name = component->name;
 
 			/* convert non BE into BE */
 			if (!dai_link->no_pcm) {
-- 
2.27.0

