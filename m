Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2093E3437
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhHGJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:11:28 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:4942
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229765AbhHGJL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:11:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1CcOXzVMnqNMp7uyft/RTMP+5hDv2g4nvD7aXU39Fhhc1fgz5zOnSsjlQy6XLJT9TWCR2wRyBIf1lpl/nNuBkkWp/y6RTaZi/4Y3WlbqdqeOYbqXmxrFJjZO/mC8hE54V5uzto2JfIjdiDxr2lxb8frhlzz7zO42C9/QoFB3ZO6xTV3bFikJVDhbhj5jMX0LZ/oIZiFdj+WFBxwNOkgoZVx1udDDqWXKjrVp2fIQ/OF/w1zZvQWhL0daaN4mYY2kGLU2yRm+C6BFu7GqJn6OGEMf7RKve0lkPxEG0nFxJGd2VbhhryEkJaq2p/nULwFtV5aX6LG3QW9t6chpP3yxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68rtu5lUUbEAjrNbjQ06/lfmzYFw87qCr9otkydWr0w=;
 b=gaDY5zzuJAYmbHL7CHnSBmW80nTsJwW094k06lNdeuE6rqvB2KyvWabvPvBR/9leoFNWSw2Au6z0MrA+ZKOHuMG4Cca+PVIRbtTkiW5NNs85pFmaIas9Xq8DnPMQMArYJQ3ia/6x0rRjI3gMJM/nQA9MEBDJbweKbo2dNiVjHUuZ1kcvYuDNJH9MMkCuorC3cj7gMN7TyUL/BGuywKhHTx0A5PLTl9DN4HJt9jR2akoXNst5Iu8uG3tPcA9gUfaP4uw8GGjLmF8PEBau+VN4oEgrRePLFgomtWnPGnnlzY6aAuISkPGf5Qux3ZboNoWX7bo8byrQ9kbXD3SBt/JCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68rtu5lUUbEAjrNbjQ06/lfmzYFw87qCr9otkydWr0w=;
 b=Zpau9ZCSGMG5jBLs3GVKRvc7OoZBV0julKU2X/mfjBYaxHfztNIvSoQ2RISY5VBJW2dtqh64zI9HIBu9ExpUaEioWpgz2XgynKXAzOTwOBS8ulKY7eED0hHV19b0q4lQrD57YA9Ptqo2qtvQFWBiEIYXSndvWj7czmYuR4cdrvY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Sat, 7 Aug
 2021 09:11:07 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4394.019; Sat, 7 Aug 2021
 09:11:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] arm64: dts: imx: pmu update 
Date:   Sat,  7 Aug 2021 17:45:34 +0800
Message-Id: <20210807094537.20290-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:3:17::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Sat, 7 Aug 2021 09:11:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac6cf49-35ac-466c-66af-08d959834a03
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7177B3CF1BD7FEF027C1CDEDC9F49@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lHHmFuhRJiCVXyExW/GARtKR5XBafi1DrcKIDPN9b586YPYQi6WA1n6q20Jv2HZN715LBqZbeUKTG1GXgkJBZ8QzEsp97P0Z8gWCuyJ7bF6c456CtWJocwwZwyE9yE6RX1jayL/wCdBVvwPnloVbRlOa1Md5J/I2GHrIFDd6E8c9IEPS3nr/0xqPfyD68jHi6HyoNORyFWKh8Y9wMmx7aPyQzuEs4kjvk8jMRdRFLlj7QfW4xTDzjOjW2BLw+QTqgHOh+Kb+0ejo0D7sAnmmIxq+DZMer8EBVl7XsTtLqrK3vOLC9XSMGGzuBryw96sQrtsZ17KCmDz7Z4/SJa9bqg2aiYHGMO9o2jlp3M1SzJvNsez4v0UQ/YhRz6PRmBPpGC1fHr2/qfuICLHNKg+dUNBSKYioWj+XKxDwQJ2WhNyuhUkeU2m4bbCmv9so8B86YVnqIhkrSwNMrBKG8APgaRkYDGmsakc7G+8C8s3Wymup9X7KN4I8mMqPucOrBEQQk+7Vo86OceimGx2gFjSLuZXKVqaaSKlxrCmeeecXaj3i/bJQkrrJBbRFg/OMz6dz93pPdW6XZy3Plvmjb+wbys8WFkDgcmHJoF9ueAZB8l3vWyarMFlSRIODZUcd7TN4rrH5Ef4x2G6aLJbJPnciQw0dLp9dv27vgzQRyL0tXUlMbBmT2rzGGMI1Axg1Vsh4hA7oyMnEEpmnsMUtbxSUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(956004)(508600001)(66556008)(66476007)(5660300002)(4743002)(2616005)(8676002)(6486002)(86362001)(52116002)(6506007)(83380400001)(1076003)(4326008)(2906002)(6666004)(38100700002)(8936002)(26005)(15650500001)(186003)(6512007)(316002)(7416002)(4744005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z6AvrYS7PE+bXgdmzd+Lan1eGzsjIK9Atg3VPpWXIZhnfj+/svMnWt668xwy?=
 =?us-ascii?Q?JLyCnKOlaqbkMIAN2LXKLHM8pDCKANqPQEHMsj+jqtZ4TujOfMBWK6HNkQHQ?=
 =?us-ascii?Q?wMIfsXvXAxqtddtEOJKWovSxO91Lbcn0FGNEu4pQKB6znTRbqEXG2jlZemLt?=
 =?us-ascii?Q?/yAT69BvFuO1xtwmSkfsT0I1aV6ojjT2uSssZRlmjOFN5N0lZntUN/y4gSsS?=
 =?us-ascii?Q?UlRLo5pi3ZVjRHNdo8a/q/FVXCAg906wvQAb0fiqARa/13U0DK5My12CzFdZ?=
 =?us-ascii?Q?OC0qKybnQG8Ebnylw1RpmPgwfLzJP7z3crsEb1+lYLXZtHQuQbg+Senv5gp1?=
 =?us-ascii?Q?T4uerGawEMBcqOr/39oB6lgJjwUhSjwmqTlBmp7xLMW2zZMZj55eYsXk3jQj?=
 =?us-ascii?Q?tS6KOBBY9EGYHr7D57swv2aRQd74HQgTzA9L8Urss6XgOjl/+EYPVf36iHsd?=
 =?us-ascii?Q?WH6vTLzhuuqd2zIiTk/EJDhrGUxSIYnTTeIPgGY2m+L5DdQ4EaNonnHKrKgm?=
 =?us-ascii?Q?d3zjrkic5hOkmFVheAm+Mz3CGkniggk9gBK5eO2umO1HhL81eaa6aw6ypE77?=
 =?us-ascii?Q?J7D3H0U51G0HvcS3RtqZKADD6ME1Ee2M5LRM80iQIbiTp0+844ja6aLCE78R?=
 =?us-ascii?Q?UshoJv6M/mIHOYn1fVZGf9TYDmwAJ5KXlXIQfMTqljPFk25AT8GNqsuOB2JR?=
 =?us-ascii?Q?jLEefWHgZ91faArWy2tKYtOBllEHiy8pkw1HEmTuoZuyrHnpwHeIb9FwNmUv?=
 =?us-ascii?Q?kAyVL9Tb0Kd4VLnyxmfzx2YeAK2W+3umfE14/eBw6jP5oOXNh8YGdPiH2pjg?=
 =?us-ascii?Q?CPZ75U0Xj99kLK5kXXXO/eSkLgii1B9MPfP99emxPLaE+Wq4RvdEhbZNhP6G?=
 =?us-ascii?Q?p4J+MThm9XHMeyCKqV70uVROkOa8PVe12QHTNgLnqxfiRsfVfc00jwCquWf1?=
 =?us-ascii?Q?WDv1Xwy0jZYUheLi4C0Xdig49b2RX1mNpjjfwEgD+tZSFmcnW+taxXxUfqdO?=
 =?us-ascii?Q?cWfQfmVRvRoNAbGKu8sEfZU5cIfOYBRbMzjCkA8Z0K3jGkfgulqVwhUW9ett?=
 =?us-ascii?Q?EsyrPO/Z0TwxbWQv9Kt9MvtNi+ibrAIWFf6PJtxVVCHwO8mMFp8R31tNIGC6?=
 =?us-ascii?Q?MxvLxpyl+LguxLzT41wy1Ymh/NymmVSBZYPcXQyBdCWlDJOVnzfpWZY47Dh7?=
 =?us-ascii?Q?JMELfOlZtfMaxxqOb0g3AgSH4RHzn32ocRzraTuitycGT+4DWDrBL3mJTYiG?=
 =?us-ascii?Q?A1HCETkuwfAbJ9wY3nLZpN0AyJf3uuRepdOGqkRJ3m3Q2uOLYdbUxPlyI1L1?=
 =?us-ascii?Q?WB17J8D0BJaAg0r5jwSGmkTcsWi1/7TUC4FlUTBUcBAx7w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac6cf49-35ac-466c-66af-08d959834a03
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2021 09:11:07.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roMl4JpptQTx2vR76639ajC7e4l8BTRRrKvNmBIJr+k6ZZa30i6GrvyMcJ+QVUs0937Ur6TtOQf2HADZlO5THA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update pmu compatible
Drop interrupt affinity

Peng Fan (3):
  arm64: dts: imx8mm: update pmu compatible
  arm64: dts: imx8qxp: update pmu compatible
  arm64: dts: imx8m: drop interrupt-affinity for pmu

 arch/arm64/boot/dts/freescale/imx8mm.dtsi  | 3 +--
 arch/arm64/boot/dts/freescale/imx8mn.dtsi  | 1 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi  | 1 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi  | 1 -
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 5 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.30.0

