Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8141D14B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbhI3CKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:10:35 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:48865
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347626AbhI3CKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:10:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJtOOv03mV699xB3WnA/6itLlCkYNqKjIZh6FPpOmrUKFtcAsRaOB9sQ96fowAVRuLbFUV9xqmXfIYU1POAHQKiAyCWicD3Kh413fqywEZT0dRlgjtqfjcQr3tEPSJYwD1cj/EAIM+5zpV5gXpM7xOj2RvK1uh1pcDlGG6zevLrXogOezeyNG2Bm6H+OMqhcQG4A4OQFz4FAUVw7xsQBvpL+/TE6w5ML9a3DV69eWMUoeToxIFfLdKthWqC6MSvf22EA7iU2ChsvuIo5L5cU25N/a2IyoY1Xs3JFgqhuZm97LDivzvGxC9dv3UVhm82MFHZIU9fa9plkmBE7QETqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=69ToK+pWXJSZfHbEiqG9XMfDb5yOnruEoX67gaMMDww=;
 b=N7WdDr4waS8Emiv0T0lX/yL+ANvtPpc8E0PVOI0wUjFwnPSwcxyptAicna8fCoJCP+Gbt5uMaRPt8TifPjTI4fTFaBWvlK6ce8aFwaxwZmed9GVjOLhrQgcqQ8HvEe5lgzmtZ4Al9/5EL98KmrxHUxcWtCG8eNcr//cs4s5MMc9AIgzmtgCdnG58BXiYy6M/DSzzlmsFPNWYqEkSkQrRTLy/+o74WZZCNrR5fgO6EqKnbKHgDwn3Kn09PoUHTSZpVyZfjVrfndiEoMNgI5vaJ3+0X4UFAB1HYkae1bigzckADJM2j5q6tek6Mm7T81PGKMf2yWTk2sq4AXr0cpcCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69ToK+pWXJSZfHbEiqG9XMfDb5yOnruEoX67gaMMDww=;
 b=JsMcBFZMAAmcOV/DJBDnf0gT8L/UiWCxgWndhC7rl13DcEUeaZCNM1HG+zYRg+NZPvbqEVMcxRqzj3WTalfUawRkdoTyrY39shu5vWvKPKGOH1o1pSRuVyGsxfLtIIiHb/BjphIlyIlIAO7a5jPQlubkrDWx+huzsDdFgQL6+Lc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 02:08:50 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 02:08:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        geert+renesas@glider.be
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] memblock: check memory total_size
Date:   Thu, 30 Sep 2021 10:44:37 +0800
Message-Id: <20210930024437.32598-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To DU2PR04MB9020.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 02:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 024cce6b-83c1-403a-25d8-08d983b73e50
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB88223FE47D0E51DA8934EE29C9AA9@DU2PR04MB8822.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGlvI5JuGVAR1REj/z4kaO3XRB7DGXEoDyDtzdYGs0oC1Czzf9+ZGqcC2nrK9Ix46XJRoGgN23rtri285oxssddGqD0PEDvn93hohU+IzLWhxNa7hbSpn2sfFol6Mg715LrjtFyhDiF3p5wk6GFUSiey98/TvyCuR0jPO9gFoAu1tCbWxP/Mwq2psqTh9cPainj+2n00Atwk+6acZcVNd017lINDYwuESPY1hgnLwnNACkqOBlSYxclsofTvaTXQpVGfbg2xWvJicDH4wSTug+RDq2K+VgO2XuaR6TZTjwfWG9sOJw8Vm1QRrKdVDFtkv9XvxxmueSDqKVoVJfFEAhX37zV6McttTop7F4wL12pZP+C6qbU8rpUTfwEuYeAqO7FVekuAdi06t4eI1wQQeNn/UuLk05mPF1VLjw2fiwNHtSBOuK3X//1p3dqfuKbVoP6eKSXenRlb2anDjX+udIeJNzf57iW1X6N8dPc/Ko5QdTNaotRWXY120zwjYWadgGgyoZc+Tkvx5eKHIeU0XBcN64a3EFl6uMktHNKAA83my9aWxo+OAxC9LI18SrNhOZwHoBL94/L3QmGieuM99KZhBfVuR4nnNFRfK80XJXMsqynuFhnjC+I8kd84O8okCsh8oKqpSvA3L4TU25/hm3NdLrnjgVRQmfDstB/tvXRePJz8/5Tl2vsczrDLABe4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(316002)(52116002)(4326008)(38100700002)(38350700002)(2906002)(6506007)(66946007)(66556008)(83380400001)(66476007)(86362001)(8676002)(26005)(6512007)(1076003)(508600001)(956004)(2616005)(8936002)(6666004)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FFbSNyQ4YDttnV3xEXuoo8nQTdX8TF4fCxjCzLRMO1dR3qZSptaPtT7du0zl?=
 =?us-ascii?Q?W4VcZYf7/hn2KEzCHKyGb3++aT6/jqbWhYwrnA1eKvVOpqO2y+r/3mMFlghT?=
 =?us-ascii?Q?gq2eig6MI/1FZCTKL51SnzZGgILwsLGBSyZx2nCgI6QRYg32JACGTrOUmdpr?=
 =?us-ascii?Q?8mZXpJrs1xL+l9MW/tGOCDeHMgkY1Zf+j5D0IUDLcOVCbwqK2aFPB8p/Psmr?=
 =?us-ascii?Q?z1Ig3Ulct1LPj2zhcdG35/ySfZDK+7deCccoQm4b7ww09dM6yvFtq4/8+GD5?=
 =?us-ascii?Q?NUFJt4tGN4n4Eqv7l3yh/2nHPgXeEWF1vh9wJY4tvgAfNLL7rQslw46wklni?=
 =?us-ascii?Q?JsQUGX988N6mgcnb2vJ1aCHvQ8qDhjJ05pyYEaKU3OcdXvrWqXlm5ivc8txn?=
 =?us-ascii?Q?3KiZJ1P3WI/G7/nAMrsJPevITR1Qv4f+bmesRui0+6+DQXhgSu9U7uemX3Wj?=
 =?us-ascii?Q?z4k9TxXnvG7rKgr4EGugkNFvuhlz4SYOw10Adhgp+3blNyz6Laugn19z/FJ4?=
 =?us-ascii?Q?sDpVXq0e9+LSrGzsyqEqNPSoUNP7kXbK8/+RgJY8yE3jGGOh34mskGRqL7Mi?=
 =?us-ascii?Q?bDvBRorcWxOF2YSKn8G2COxDxu8WjE1nckbgGL0pW8sILe5WxrtTmroRgQqT?=
 =?us-ascii?Q?3e3v1CHlJB67ypMGdwlt1kcAEuNYo+VR/IzttjbboT8algAXf6gubRJQ07f7?=
 =?us-ascii?Q?GabFIA57CGbJjq2a9oZA3IV61Y3HnE6y0pMJHQ+Xvp2D0decVCHTISt6weHD?=
 =?us-ascii?Q?bDuYxXtc3WT4eeVbVkRpBVMT5vsnCQTOErSZCL+yRGRJmOqVWjdWBfrI0AWJ?=
 =?us-ascii?Q?yuOVuleEnkyhjaZtyiHm7iesvObSrhX1woocueffgTN/pdw8m+MYHIS7XWJK?=
 =?us-ascii?Q?YxezbSpwqaWzVPXj+iruBqOWWitLouNcekQ600C9bxZlRK7/b7wBaYb6Mqlj?=
 =?us-ascii?Q?r1l3XPrlv5pWQ7jEDW3pRQo1WoPihz376g45OqC3dSRQsw4MLZvZkccY7csd?=
 =?us-ascii?Q?smTkx5BSDDOjJwjX6PmzwcLK6FjQrRsNbX/Y7U7C2U456siMNV3mNtTSzfCg?=
 =?us-ascii?Q?MrYinroRy/NMVtgolfr170sjbmrs3jQMuw1kIB4gbGUARohnAYN9AwcPWUDW?=
 =?us-ascii?Q?uZXxsBsSCWDpYtMPcL9H4eixPjycgeVcJZlc+TYM5zABlAucADfTpjvvCfaT?=
 =?us-ascii?Q?RJgrN8emlcJdK399Q9Ncrr3U5xn00lPEPTWykzMnikoB7zk59vZzAeU8USIz?=
 =?us-ascii?Q?qpFfxcsnadecqDSYX6m1MGEdi2yu1O1PcH7ru/zFd6xcReb0RCORRvV8hSX6?=
 =?us-ascii?Q?syQmjYsOhuGJWbvR46MxxbC/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024cce6b-83c1-403a-25d8-08d983b73e50
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 02:08:50.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+XRUiv/nZJT/8aO4ZFSK+8wn8ktIWYYSXmhzY/7QlP6+q4fIn0qWy7uEmgSV5v4Nreoyn4V+aouDz44PzQn2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8822
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

mem=[X][G|M] is broken on ARM64 platform, there are cases that
even type.cnt is 1, but total_size is not 0 because regions are merged
into 1. So only check 'cnt' is not enough, total_size should be used,
othersize bootargs 'mem=[X][G|B]' not work anymore.

Fixes: e888fa7bb882 ("memblock: Check memory add/cap ordering")
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log
 Only check total_size, no need check cnt

 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..103b052c016e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1687,7 +1687,7 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
 	if (!size)
 		return;
 
-	if (memblock.memory.cnt <= 1) {
+	if (!memblock_memory->total_size) {
 		pr_warn("%s: No memory registered yet\n", __func__);
 		return;
 	}
-- 
2.30.0

