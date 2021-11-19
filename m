Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C935456C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhKSJqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:46:04 -0500
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:48992
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232120AbhKSJqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:46:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jItR7J/fOnYw5lNbWWJdmUFvgzpczq3ilx1VOHj3U1fSad/fMqZv9OuSFZ86C+5pQuAB8YoWVcjocih4uPjupvyQZVuYigBIYGh5jo7gylHiJ2lsHSG07Ok9KaoUGlunP6/Ibn3OO4PzNqAUmgRZS2FM6ARxWwROIilDmw1+2HTIN+6uN2w097yHJxCSi/0qvR0Ewq+ZogiM3QL3u1D90M1KjxDJJVbSwFgRN5Onsw1oBeKQAMAmljnmiZh9/ynzEe2kStmF1U6R6PkzE2Tc1yarKGYoq1583f7J7EEUugVT6V8P5MgEflPnRD2K+sS3CIail9qOYk99AoWTMfqBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96JrG3b0LQCc+b5OLJPsbpgGylfNYa5FuYnEGb25CZQ=;
 b=aUSO+4lEC9zCZgrhgJgwm471FflUWU4TLdFjbXocdyY9Yuf1kbdsVKWYnQaZWSp4Zo1BDCjGsYecOFlsF7rELLjB03c+H9WsjX/mBRV7KLJ/ech7GhuHh/Vte9KE/JsHkkWuUxOMNicPjbWck9ItbANX+qHwdpBbi1WjLrzNJLgqW31ssbn2c2hXDpCl3wwH6/6W9zGTlqDgm9v/gfNbIjGDjulfywZg/vwslbar3YhNVwgp92aMfMhk47+eacQbsQAYpClSbwiClQ8AFRO4jsOOhQzXul7dKMhvfDcJZhDBw84r2FXmHj5a5j6XooTVyALls5rnntO9K37V6qlU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96JrG3b0LQCc+b5OLJPsbpgGylfNYa5FuYnEGb25CZQ=;
 b=F8HYCMU3AEa4OKX4HRA3WxNCRM9oFwRu5eSCPsJSFnHejX+wzMou0Gc5Gp2sPHs6m4yT/ybBBZuHEUXqiU+WKFmSmKZdahQXaRsMU6Hz/BPuIQJDPpqL/sw5SDSjjyVXg1NJkDDYjlkU7D5T3l3rcmBds+md2KZ/sQyDVaW/Adg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 19 Nov
 2021 09:42:59 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.029; Fri, 19 Nov 2021
 09:42:59 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, linux-imx@nxpc.com
Subject: [PATCH v2 0/5]  ASoC: SOF: Add PM support for i.MX8/i.MX8X/i.MX8M
Date:   Fri, 19 Nov 2021 11:42:32 +0200
Message-Id: <20211119094237.81576-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:207:8::32) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:187d:3f5e:91e7:280d) by AM3PR07CA0146.eurprd07.prod.outlook.com (2603:10a6:207:8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17 via Frontend Transport; Fri, 19 Nov 2021 09:42:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 449d1a4b-c06e-4a91-a7e9-08d9ab40f8b4
X-MS-TrafficTypeDiagnostic: VE1PR04MB7358:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7358C473457E2B1F71380AE5B89C9@VE1PR04MB7358.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoltFsfZ4k6/juQhXuZW5X/Dt0GenCewAqmd+aaUHWMVseeuEPzS8/9f7NgXcf5zw5E6Jvrui3jpi/wJPo0wu0g15uDsOPf26nJz1iPqkFmOIutQKV50SeE79Py8+oO0IM6snD/003SMbUPTJkPqltsnSYmq2p2jn/w5eGRdgvxSw4ISMoObWSN+HgkmVJ8L59UnqcPR8SISyNbSiJYpbStSOa9cBnc32bYl0QbTodCa+z+CsLnCJUWymMuWax3htRfyayAclQBJtAtwsKbPN0kpHIvQv1jv3UYEJ71CDoXOHdA9NOG3ImSQMj7v3ipWxqDu097z8jjgj8f0LMOP4VtfTT/iXIqpzogo1fF2DuW/k9mFQcGqNJ+Uw1Vq5no4kuEeQzk9L6w2KFQmJbgaHEi5wzb89NPVnp2desCz7reChGeAsoEBYUsUyrJtjzbH6AJMaSaNCSDKMbgva6Pg3m4lCgoVGO2/F3e371IscoBzeR9uxXorFKTO1ElrpDnziI8DSxSkzFlzTNXrq57MKlTDnHozSjDHlrPmOIJlorjH+ee8p4KqNMVf/zyllJOG/rIMSSbKM2VRwbPsA6okAwt2Y7wHUK+5UDegKJd56d2UZWE7FQKwJDNyOeJ2vGklvJFrgMjWek2ysL+tN5ZLTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66556008)(52116002)(186003)(6506007)(6512007)(44832011)(2616005)(8936002)(508600001)(66476007)(66946007)(1076003)(5660300002)(83380400001)(38100700002)(6666004)(4744005)(4326008)(6486002)(316002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9MGoL+XC6KRVxZ5G91q5uBT5dm08yBZu6SlkL4Tj4WHiowIm8IZcu5vIJ99?=
 =?us-ascii?Q?KIB1cPR5ir3+avtI2qSZ7Tph2LieJv8HcjXnfaBiRQv3ajwhIQzZES+JQaNC?=
 =?us-ascii?Q?NXRr0kOeX15R1gVzKy4OUeq7isHdM4bmQ56mDsSWHaLS+12Ek4NXAQ8573hE?=
 =?us-ascii?Q?Q6sPhFL25XWw2IGECMRhO5NMn833v6QiJ7YOnyJC/DTX4UQbo5yHCK0vL70T?=
 =?us-ascii?Q?RbGCTuJPs0OU6qXBwe42W9pKCLP4hbB+f84p51KJXWZMTeEafq44yQFeSL8w?=
 =?us-ascii?Q?zJmPYeVDQz+n5CpwROpeHAvNfFr0vaEQIgMZNqNR98SC5mEjvj5s6rKy3W/q?=
 =?us-ascii?Q?loXjaEjqYJwB6dV7Pk8HoH4+mgF6rhtTvQ2DzoCIRGW9x+ge42hybdMDU4Fx?=
 =?us-ascii?Q?G/YYI6l6z5nINsWoSjb5GDtpPzdsTg9aMQIXJ+PxXYJ4M0KDGY/jQPWrWa4L?=
 =?us-ascii?Q?Gfot8Rt7GtuGF1dEmXbQkLLC+wnJxM5U+xwYDYjoEA8B1zgjvpyBuo6Bidt3?=
 =?us-ascii?Q?r0xjdCnMsPFqHr2xBU3FtOjCxbXAJ8lh8NRfJHwBvejP46bKLx7pn/OV5E8k?=
 =?us-ascii?Q?MuB1mkMUxLEDV8CoIb6SzvYXrxtg+490p6FTO5jpsmvxVZLwLbiXzxzd4Jbz?=
 =?us-ascii?Q?2BeILQfuG1mBPHmXvP55ddps0gNpMAHjHxFqyy9GsSGbhW+u9EFEi28+gKc9?=
 =?us-ascii?Q?8fwA57zM/4CWTnBUovnxuGGZWwYaonQTqbi8x5UvTq9T2LZs5Jpf3dODjDLj?=
 =?us-ascii?Q?2NDaFG6hYlBidh8pj+mhkw1Xq1f9avPPpt0hEiK8JLCUhTe6EHP8TlNZvql9?=
 =?us-ascii?Q?8Jk+uztErw/toQmHUHQmkbeijFI/6NHG9DDf62RfKBt9lJxqwGLcxQVxY1q6?=
 =?us-ascii?Q?g+YG2XNl2yNuOK+qVpFPc3kYTPk4DmF3ZeHpZzicYJ6s9S49TbbOPDMNdJTK?=
 =?us-ascii?Q?qeslPlFL/dgwiqsGOthmL4TW+8281a1nejj1KTccK7LBZlcWksfRXIgbKMGW?=
 =?us-ascii?Q?3k2kIY8KAF4xzxazJl0BU+B7W9i9x+vo1VkGHxDVjiIae6eTeP0ecUBNTJsi?=
 =?us-ascii?Q?41thrEfE68fprnQOUf1cffOnoplprBttfmPK6V+NL6eJUzQlEmIAJhguZiJY?=
 =?us-ascii?Q?9dXONKrxW/7vHtx8qKCTVRVTWVayaz5vqDsuWnuXewfzD2X/25yfpSUVVQrf?=
 =?us-ascii?Q?FXZrVRFX9459XM2+IY7//m5dWCRlFMmbBltvnFa7FsD3BWB1o4qOYawkjv8f?=
 =?us-ascii?Q?Ihd2P2hXmUmyblmME8qAlxNeNaI0nA+6auRZtqlunGoAdhpmd3b23Hs/x2ID?=
 =?us-ascii?Q?+RNKjw4OHWXe2zKTGeZ2KFX5sg7uLAsFcrOW+k//44BWHwCNOqN4KCnsJQjx?=
 =?us-ascii?Q?lqSQZOecCmBlsRJnv+Uffl223DA13TcIuT3Fwqcvdw3IMtYd8wRAbYA1/IAK?=
 =?us-ascii?Q?4SQyKvjTwpu9pPZ3b7p4y6SJGAQ/UxS6oNLEdlyQAGkIKdPqy8eGJ1oNRXZN?=
 =?us-ascii?Q?fjVk6bDovGhKCSnnCZYa0+UgQIhDyzkTtUYhKwg7fL68oSGvyvk57J8Ea7ks?=
 =?us-ascii?Q?kmdFTv0G9tpOKnS3arcyvnzQM72+aAXC+Nu9T0wSBb/n/MY9RaeE9v6SYn2x?=
 =?us-ascii?Q?LQTS6gnLxHlyMciSEk+MqZiPwzbd67A+uHr+tVKpVKDgal6IbnMaOO1vqOUZ?=
 =?us-ascii?Q?xbeg1pG1+kOVsIDX6Yvtwg3crEI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449d1a4b-c06e-4a91-a7e9-08d9ab40f8b4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 09:42:59.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4H3TzATYkmFq2axwvBuMLtdzihqUakHWSiCShBIOwPSFCPLlygTFcP/XWCRMsi57Wf3TpzSqTvloHoqvhS0GOQ==
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

