Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD5453647
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhKPPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:49:43 -0500
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:23136
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238526AbhKPPta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:49:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwW4UXoQzx1QxxMnlCpWI6DuriYWxuI7WM1WmpVOWRfPBhardsH7iK9FOXf/RBppt8nE1bFwc9sTvJzgGBaHCZ2pPrsPtSIDLeni+0v2c0q6fsBbV06WA17vrTtPlAA5oTR5nA9Iop5YfjKUrr+O8yemNx4UgRkoOxVgrTVG6fPbCoKntzlYB943vyUzmiRkYzm1D8eNrWhdZFenS24gh4MQetJEc46XFRATEqzPvvhMkxXEEL+bLo/rJoOwkpB9x5uzz2Z2u56sQUhNbx7U0kRtJQ9s/ZgHunEwlmwbilmi4YWdkvKzHv9EP35CAl/TiEeRBr9VVP/z7/EUGavBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjKIfc5/5vN+31wK5RAZmqD/ijtWeiOVdwDtbEtuhVo=;
 b=IPHfRiHUhMqQXtfn1t9XvsDnQsaCz/mGWDeOKsv7EScbyxPvr1iLrOHouEKcYOAWDAosYGw0mwiT9SLcWAGQJPHZ+NiFno4gaNJHZ94fk4hrrn3D54CLX8qNjJZeV3g9ob9Umce0esEFN7jFqQOKc+H+V5qV3+v+dLbwsUQTudYy9EezKl/d+F55qnYWKqQrqxG/OhvYTYfovmejx7+0ri6K5OIyes36Rgev3cwoLTTZ+pX3i5DUq0xRbiMPZaIMM8Nh5rX6alZzHYhGycfZGIEHkhkcY8ln2SV/cVVFjVY9QLz5hIhRZBtQbGA9fj00Zy0cuvtIpS5pkh7g9OWTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjKIfc5/5vN+31wK5RAZmqD/ijtWeiOVdwDtbEtuhVo=;
 b=GjDjUzXcmMRy6GiWYPWLzIvVvN9MCntYGK/kweV+Yu2F8L8zP02RgP6sNZkcscTNe4q9rA6amflQI0VUzbZB8ikMQUQXrKjUZ2GTmyMEhgkW20rxyE9lKwiE1VTGPpE5iWRJsVTNjMZ6HOgLcQff+ybIcVvPh8D2yN+tjRncA78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR0402MB3824.eurprd04.prod.outlook.com (2603:10a6:803:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 15:46:29 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 15:46:29 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@gmail.com, linux-imx@nxp.com,
        peter.ujfalusi@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/5] ASoC: SOF: Add PM support for i.MX8/i.MX8X/i.MX8M
Date:   Tue, 16 Nov 2021 17:46:08 +0200
Message-Id: <20211116154613.57122-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0076.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::17) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:1e69:ee6:2dad:c9e7) by AM0PR06CA0076.eurprd06.prod.outlook.com (2603:10a6:208:fa::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend Transport; Tue, 16 Nov 2021 15:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce5b5424-7cd8-48d2-dba8-08d9a918415d
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3824:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3824FBFD0D1F8EBC91AD0832B8999@VI1PR0402MB3824.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rIP7kmx5DREwVjE/r77gJcsqFVx/gy5VRqzM2kip+mEu5qlB3VAI0VRxefwDXE/BLxzP/Nwxyr4WJ+4IxyDFJw1Z/4GHQR/g3NZCyF+WkYkxcL9Uby2byKSE1DPDK3XmY9Td1zJIiD4dWH1AxD0nR+j/9Tj2jEVBkbHCJ77JvNGRNA1gyAzYN4uTPpmw/slLBc1zhsFAF98WkhLFhMdKIfscTPbLwwEiIE7QWnMoAsSCGpIZRh5tDKIL1UkbRfB7Vkx3bYQ/uWAFscDeBmS5Px16eHyypNNvlhpqm5SD69EEL3ZbzPbtRg+5Mr7EwVgfznRquTJERHp9H74Dp/urj9ggYQuOYQx+otu/r7x38j7TwHkptbhz+k2MR3Rn9+Lm92uzDjJSsktWk1RSce8XzAiRQHHNzPjOVHdxLCqlAJ9S9oBPqYyybYF+D7vIQnfZeSpaSQzm1r38BWhmmTuBVMTtkv+ocQ1GVCi8IwrVkTM7jdTvt3E1mPqqZSwEdVj2Q7iipBCyvsk/KGn4iRg3Wvb/C8aWB/2hWAG1rDmTO6bD6O19oPfBQMC+Ea1Vhxzby4M+7HjbSJCvCl0HsibiqHCOKjSrZKwT2nQiyfEvRVN0OKDgxJpreeqD19WwreZlMENVCLYOdtDKAs6Tg6GJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(186003)(5660300002)(1076003)(8936002)(38100700002)(66946007)(66556008)(66476007)(7416002)(86362001)(44832011)(6506007)(316002)(4744005)(2906002)(83380400001)(6512007)(6666004)(4326008)(508600001)(8676002)(2616005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0cOEXAZD4xBbdW8bbCS47Pzqxx/lRpv+YssBBEET/svxr6ArXcGBGiAiBrG?=
 =?us-ascii?Q?chmpgVQrxamQ4kUQt0UYYFKU8rseLopsKGu6WZhP+4xyU5EZYACQpmCJiBJd?=
 =?us-ascii?Q?pqrl3B9Sq75pg4xbsjcVu5/PsSMTbx0Nhh/4x53bykfRX2+Mtp1tZU1JmDA1?=
 =?us-ascii?Q?0l0FfyzTBv7Py7KDjloi4fw1nZHhKmZAvQAwBd3sjUvWGnE7/n75YzTrSqbs?=
 =?us-ascii?Q?8aUbkXXMG+QJg8+rH42XrlJQHLghTkS7CwmfxZXcRNaGeOygIMGeQjCkwJye?=
 =?us-ascii?Q?QCjMfq0KTYrJicI0CiP/QGogLgRhgVwq0P2dWXjIonVDO4eLOTEvRnMKRCTP?=
 =?us-ascii?Q?cn0GI1SMOddYIlIPYEjWeJreUlJqRJSScn/N7wZgGwpxn70K56BO+aZdQtHI?=
 =?us-ascii?Q?AkLhrRNuElEJPvdRatpWD9dtSw9ZyavvsptBhEXjKSS+qu/I0fWq9Hs9QDZ0?=
 =?us-ascii?Q?mftZ7000aCMFHP7IPw/wrdHCAcLMWtSicSq68PljZDVUdnHrrAcf4aHgMRtI?=
 =?us-ascii?Q?K8xMzZbjTrKG2Ao9IVMQM1EoHjy5ab8wLEru/lX0/LkU8Cr3xjBGZnQCuQPa?=
 =?us-ascii?Q?m35oYxCxh7k7CZlGAE674xDwbpNE60Z0+nEgTDMp3QbkZi2rnwMxPaKc56l9?=
 =?us-ascii?Q?uOVLjWT1vwIP9T/2tFqnFUrtR9yrzCK1k04s4Xx+fzfk9lGi08QaDlPxi3F0?=
 =?us-ascii?Q?u8WO0LSl6zR1KhFeUbaMtsE7F1UbBkvjRK/n/ZSA8vbagbNyhxA4qszPCOWT?=
 =?us-ascii?Q?zjAp7RZ/9OmQqTwh7asaMmx8dUviyXztFSE/SB4d16xQXeQw1ng+XhQriKcL?=
 =?us-ascii?Q?kVmXq+ARtG8tHMK8KEhlKVBt7fb28yaDhe+vGrgx9mQgh349s8dC9DcEO6xA?=
 =?us-ascii?Q?Vj+tQ5r2vkvjzuUknAmrB+1VDck+EIzEMHveEIzPbFiDSqWVvrZMbfB6YyLT?=
 =?us-ascii?Q?rtONdwJfj/+vIgMbcTim+QchUP4JvzDiZpnDG2zjaDtviLE9AdusDaVMCd2N?=
 =?us-ascii?Q?mkpKihDfaMdKa9PCJRfcxZ5HrM9s3dIfHoEuQpo1wFSIQUWJNXBlv2/DCVAU?=
 =?us-ascii?Q?lwgpe/Y5Vm82FlBj3O/AdeQ+ij6pjkKXprhHrcjwSHjQKaPFjgMaQNO+9uiU?=
 =?us-ascii?Q?IRDM9yKjBr7QHpdWh/rD4DqruO8DUC/zD0uU+c9JWY+7aSrsY417DeNLKxS7?=
 =?us-ascii?Q?uNr2F2N4vEdZp3d3uFjqib+1MxgJEZ967sGoRC80VxJB/KcTB6VUmJMEjm3i?=
 =?us-ascii?Q?DJKmgawQTIyRXfgKikdoGwc47w5YCAph6HJYelf5j+fHjslb2nQKi98CFJaf?=
 =?us-ascii?Q?55EqnsDKq5gp5NeJv7Qrjr9r2UsS/OW241wpoQpeJMNa71fjHbgvOJo2S6Jv?=
 =?us-ascii?Q?2MZa443Ssy/wLNgSxxMrOfVbK7QKeKvlfbbCNMqB1c4J2DtYmnOIvnLi93ci?=
 =?us-ascii?Q?4qdqhh9ql4uCjZYuBg+Gan9VEEum9r81OIc7os1NCFCwfui5QbydS6W5IL5a?=
 =?us-ascii?Q?dcPmhOcIkON14rI++wMcO55I/s1raQJRJFeTMP2gHJGIPVTQJprXOY7sngPG?=
 =?us-ascii?Q?IfNeaTFEYrH0TfkrLiwoJHFqas8OT+QSyX1R168CF/CLDoQT0ItPmxlojgfi?=
 =?us-ascii?Q?E671apqdDtEddo5nInDjndM1oZp0glN/3ZfpY6kDpcxpC9cfSeTfml0+nGVV?=
 =?us-ascii?Q?9zmLzJgte/jKuRGc82tcZQr0IipBc4SxpdPFlP6To9qkQ+d/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5b5424-7cd8-48d2-dba8-08d9a918415d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:46:29.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5xS2iVdu5lPxoU1R1zfMokPWxiCKbpBkVo7ZSfEqCZyB/i3gTmMhBtGptJmA1GFDpd6ZeIhl+JWrIep79q0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3824
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series adds support for System PM and Runtime PM with SOF for
i.MX8 platforms.

First patch adds common code to manage clocks, patch 2/3 adds the actual
PM support, patch 4/5 implement the DSP start / reset callbacks for
i.mx8m.

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

