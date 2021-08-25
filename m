Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D22D3F7D58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbhHYUvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:51:48 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:32960
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239932AbhHYUvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpl9LOQqiid5seA8CnSDs2v6GYxlKdXrxodRDsx4OTI5LP3TsnVOpwJ75cmUHy4QFq9ejDK4YPRGgjMkMOnLrldTnwpgyh0G/LDBOzoqeJaCO3QIMzrenqhnQvMLtcFZQzj7zvo1q1FL4TlVwk1+HsoNXszKqi6nclM/6JGRyzu+Etp2AH7yOY4TO4HeadhtME9F4Yc2XZCEG/GLvSpmJzKrt4/xyqyUlgPM0prjBVF6IG5yW7b+N3mLh7k9GVBMMKTWpcp5BPVaS4aUKcwBMCPrQTdF54iXrUqmjwL/Mdg93krpBPfGHgE6Gg/9Cv7Cgiv/57eUeUcSN1ijBorm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2l08GfdhWp1rvxyYr4NES/UJUYjYVxJCjOtiXZ3ggw=;
 b=Xfbb2ebZTj4ox+48tbLN0izp3gNKLmcRN/hR5tcHDoZMVXVUMfi64LltSCIMwm0v+RLBQclcw5+FYYdyqlo4X7AauQrAjl8KDZoxYzJyFayvVCmlovPeddQxdk5LtIjxeE18Vf/mPxqr+GPjQdK1bqf0wPM4IKDhxqW8nnFcg00jTtv5AsLoM/3+G/4Wb7JueNmfIa8HGgq0CVOMEAQuWJCJbFam+4ZNwL5rdVIF3Qxy+AStraqyWak93ybEuBpAggFbtTdgcDt8t+zla1+41QJey/+4JuIV9/2n0kUteh7iGXE/mxjn5fbRpK4A2FGzr7adz02JkzVdY9hOjC05eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2l08GfdhWp1rvxyYr4NES/UJUYjYVxJCjOtiXZ3ggw=;
 b=oB/QCJXzYs8Bq94IbIhTB9frglon9jPHvyJgH1dCUPd3XF331/nsEd6gZHewD4bhAGzssQpbfTm2JSm9aRjkbRe0hCrUdpYh/oPfZBNQrHQK8NQY0vYaW4uZ4/X+9SbHgN903A+u0HTtjdplX9UAJUTy6rTLUjoUx8Bpv8Ikxds=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 20:50:59 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 20:50:59 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Use raw spinlocks in the ls-extirq driver
Date:   Wed, 25 Aug 2021 23:50:39 +0300
Message-Id: <20210825205041.927788-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::31) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (82.78.148.104) by PR0P264CA0187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Wed, 25 Aug 2021 20:50:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d192d2f9-0b93-46f4-6072-08d9680a0aa2
X-MS-TrafficTypeDiagnostic: VI1PR04MB5853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB58537A622EC7F83AE6E89913E0C69@VI1PR04MB5853.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnuXeWuM0gGHA8reRULgUNrpiDMcUoqCGs3jr2QAXgjfO4RDb1Jr6+tqVyxUAVybgoVAJ5jO3z/RjDfqcLA1eqt+2HlkXRR+3QH7i0Tufttg+fxYwy/UxWnqd9NXqkfI1OaUdVRJ4w7JWu9ja4APEqZC25NTKP0wTTrAtyWBQb7h9EGyFQIVWoJhrvSwrYVkJOFzNdrIldoYt4R9QMs8dnhaxshlRIjl+ONxmcsNhSsI6h65Am+x7NKHzgQhhxf5NpzyK3u6a7RxVWCzaClzkfScB+Pc5+NfrXObc31sav1izXzvaFlaSjGTjUPsrwHoyGA38pTG1rlrfTqmXqkJ0Bq4F1iEe9NrbMtFaWtxBKTlByzO5C+WNXSK9H0ej4oL9FhQltuxQQz0tQUPmrjgVAPwsRAG5TIxdgShgKGmqxyfNHHm+xTDIe+jq5R9htgAp+kARQ3F9+i2dr69iadagsEy+J/nsb9w0sWpl50Z1AHOZ3Lx9PMuWYzB1lJOw+puILSlnDR6ol5LzjfHnLKz5ngbc7zi8PKA3uCI5WoAOIm3fdlCuqRy33fGQp7SwNiX5mMi+e/x7fM4JgpGtYz/+BOPvBLivvlsc5xhfQAK3HdXleF6rPfSJAyCDMpIRBi/ojD/7uO3VTuZIm1K/pxmjas8Hq8mEQDxv0O/BArcRclStnhQcLhMsQXTC1GPWR2NMZVxfbZyXn0UWUyjy4PpI3vo0pllkJqVCRzSQ3lHSgMX3J7kiiFGRC31jpkj47MwkhLHwN4H1vFjjbOBg0+ccQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(316002)(6666004)(36756003)(54906003)(966005)(8936002)(44832011)(83380400001)(5660300002)(4744005)(86362001)(478600001)(8676002)(6916009)(6506007)(6486002)(52116002)(2616005)(66556008)(26005)(66476007)(38100700002)(38350700002)(4326008)(1076003)(956004)(2906002)(186003)(66946007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2SCzIZvBooRapYs/hc7dAre9hyK4q321yjCljzA7gAZCB+ZMvQm0eWAcKtv?=
 =?us-ascii?Q?24sAwcOF9nnAAfWSQLEXok+6ydHlQ3jEUivZTBphreFpocXNZwUVZBvzZj9Y?=
 =?us-ascii?Q?tXToPepkxYzpWtf+8XgYfRo3Ok1BpKrsYOIt6Pvj+qDp8uJEHRO+xTQd/Xl4?=
 =?us-ascii?Q?HuvzYnnACx92XO/bhU1hCcUyoUTe59VAbmBdVbU/Mel0S4EV7WlzQm6p25V5?=
 =?us-ascii?Q?BJMtlDKMR1ixqVdGZqfiegrUqHIVlPZCzo3OAy3+oiYmUoDdSgsafdKMalX+?=
 =?us-ascii?Q?K1Z8V7ClTc7AV6k142mBmLOQGyIMLTgJex6p4n325CSbSkhSgzOBBBFKNrWw?=
 =?us-ascii?Q?5x5trwHu2Ye6jPLACjBsbJ406L2lozSP95K5Fus7nXKKXxnXp6JaMT4YR8c+?=
 =?us-ascii?Q?WXDtp432FkpdHakPn0h2CucsLwazBH+8Dy1axZxdTBlzrk1D6WaQs+eo0YgL?=
 =?us-ascii?Q?XXxxxai7d0PTU+EnUBPtkvMBrWUwcS01yKkUyaDFkOIeyZIrTf82gHqI3ay8?=
 =?us-ascii?Q?5BgPp4QKT8aCVAH3WVhz9LVRbOufLrPTX7NiGa1dXEjvBj5dEyE2p0CTrGW8?=
 =?us-ascii?Q?wPP9fqP614fggIrwYAyDQzIcNRhVYrghO+p15F/PX1hZfoDN1kmHwGX585A5?=
 =?us-ascii?Q?a60zrJ4NfdJ0hJS5vhmPET2Lz5j2BjxpbAD05qdYOO76tUoK56UWUZmbjGTD?=
 =?us-ascii?Q?C0u9LzqQJbowrUpJIY8NvE2gvGBmqUZkxc+q4Z35Sf/VhtMbOsPUJE8/iMpM?=
 =?us-ascii?Q?epdkumwJQu+QWJriEC02j8Q3JR4Ie7KCweupZhiPQxynhQZeq8AbeBQzqezz?=
 =?us-ascii?Q?nZgqLKLJt4eyZl1aEqFRVXPg1gO+4uUVruklGuBLGrC8IGTYY4eWyUKwgJ0b?=
 =?us-ascii?Q?rWkkRY7guY3X/cu/g9kH0ONiZ5nsOEvvvOOuJGbkBPxgJXc4fL4vWdAqSh8g?=
 =?us-ascii?Q?fePEeU8y/IiKTfzdTFsOLpC1HHs9B0PMNDNX3LWiiCp32YaiyDT7VEGM3aDp?=
 =?us-ascii?Q?JUPtCkuCnJ7+lmygay2XTWF1rEpNk0Rp8hG5JvS5SmAkuTLGKDti8LPEGyYx?=
 =?us-ascii?Q?aKORWmV/eaJREj38G2DkSFX4SJyb+OJcs6bIspwnTTBUxlhmejNhQAZM9fmE?=
 =?us-ascii?Q?i05GAO+TjHo4CixY2QgfhT4sOi1Rf9+r50sbt+vStuCn9N4pzYRf4q6Rs+xN?=
 =?us-ascii?Q?seFo9pNp6qnCZw6wxTcc7s/retw/nZnb2WIPg3v8XtqVleRqhWTFFUTPANk7?=
 =?us-ascii?Q?Yf5X2aTyU+rcghHgbEs7luzHoo/Z3pYJC2GD/9VEzQFjZvAbpp0OqiPO4qop?=
 =?us-ascii?Q?2H8K+I83co2sQ6X3m8mQuRrG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d192d2f9-0b93-46f4-6072-08d9680a0aa2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 20:50:58.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uT1lmYCA7t3/DHDtJ1qHk9M72FnYZ2UU9wdvnW3kmXssMnGX0RmfwVjRjfTjQDR8isLJ5O6gUMPIawDkWg0C1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ls-extirq irqchip driver accesses regmap inside its implementation
of the struct irq_chip :: irq_set_type method, and currently regmap
only knows to lock using normal spinlocks. But the method above wants
raw spinlock context, so this isn't going to work and triggers a
"[ BUG: Invalid wait context ]" splat.

The best we can do given the arrangement of the code is to patch regmap
and the syscon driver: regmap to support raw spinlocks, and syscon to
request them on behalf of its ls-extirq consumer.

Link: https://lore.kernel.org/lkml/20210825135438.ubcuxm5vctt6ne2q@skbuf/T/#u

Vladimir Oltean (2):
  regmap: teach regmap to use raw spinlocks if requested in the config
  mfd: syscon: request a regmap with raw spinlocks for some devices

 drivers/base/regmap/internal.h |  4 ++++
 drivers/base/regmap/regmap.c   | 35 +++++++++++++++++++++++++++++-----
 drivers/mfd/syscon.c           | 16 ++++++++++++++++
 include/linux/regmap.h         |  2 ++
 4 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.25.1

