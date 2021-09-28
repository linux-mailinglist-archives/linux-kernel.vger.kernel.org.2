Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE341ACBB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhI1KQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:16:50 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:12486
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240055AbhI1KQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:16:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz85/mZqKWl/go4M+Lxq0+UnluOH5UEI9dSTYb/3kEB8rlkkLZ9HtQloKtiwt9h2tVhlZktvMOsBJDMiigHHutZTwVJmDx+5yjI9ntB+OYE1O+IZhedQhMwZHwwSvQvolvCooIcX9P1lfq9G132/uq4hvXEVwzTczRPnS8RiPvZhafsYVlScIU7kWz1llFIzMeqqa6bYJvZy89J9u23uUoEmXGx5kUOkeGK1dGx7pefDg7/2Rg+tTaS7+6vM623amtQtNaLNrGRKgf832/sf9zqnXoNvLV/35OMmgcn7KYJTLZQgh1hd+eVQ2wSNzbxzPyeWyKwMxlL2uHJUBXFSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Y+Q5md7kCkvOJj5LShtTrjBP1nvf86UH8IQQDl07gzM=;
 b=duNejHLw/aDiERafzdm7KqNTHHwVGgmGRRFvDDggiUf0rUHKkKAhzOZ0MUCSoRBQuxCUJ7fn+Iago8jSdK8vOBb6xO362Nu9lTuEZsQBDceOnwp5YpfhvhH4zkbhtVbXLP27w5JAje9n+ErUSr86PheLCyOh+nDXSXPFEh1LRx4qHZFx64JAK/VN51doRQKukxpUhlcAM3dAbEJDOi+wot6rvIr+lU+dp66wqmttxZJvLhxrGlNrega/HtRwiNrTnurrZPgvW4vm1OMa69ygFAVRRQNI9Gag7nBSxBqnph96vo8dKiVY9uxTWbqz/jkavFYd3VT5VQ7+TmaF0o/t8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+Q5md7kCkvOJj5LShtTrjBP1nvf86UH8IQQDl07gzM=;
 b=YHJc7AhE+56kRiDcfrcUkDNPW4rD4+gtAuewc63GcDDeYHHAC5LEKX+ySn52pcJdw2YKGJX2uO+aGqJTabVk5YlTHnzR5gf7tItSxzjbHRgzp9PEL+w7m7pzEbuw6cN/+wMH1o8CyKduF2TcnCqQ974TzRgQ7Hbkb9lHPjBab+E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8807.eurprd04.prod.outlook.com (2603:10a6:10:2e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 10:15:08 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 10:15:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        geert+renesas@glider.be
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] memblock: check memory total_size
Date:   Tue, 28 Sep 2021 18:50:57 +0800
Message-Id: <20210928105057.3406-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 10:15:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ce8cc3-27b0-4266-5af8-08d98268d8e1
X-MS-TrafficTypeDiagnostic: DU2PR04MB8807:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB88073A75FBE8FB6293C49B68C9A89@DU2PR04MB8807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5fxvaPbyB+FDKAxk+iGn0R80CVB0dbEJgISODiurbAoe+DN+8lCF+gFzJNNmJJTOs5u8DLRyKO+AqzIFb3e0r2Yay/SsJ2sgjvbYvwxaM/ZKjr3hrmaVIDf59ObzrQke8/M5xh2j6sc5oNgduDGB5dWYhqoiqfjdFrlFJuUShdIuNz0xSbhMKx72s8rdZHF+LWlSKVFNxicfjCbDKyYwJSHJaTbjwdYzqH0OotWIOMeeWrDvxx7RCSRwOf8CWM8PaeoxnKkbStOX/BwHSQkJa46v1vp3vqejdYuUdDZj2/5DgxnWgXf9ahQW4fvJfzq8bqVQv0iVotgaFOD5S6XJiEGdb9m0QnHEYXDpDDvkT5cKjsmniVOj4YbuoZ7r648R0oWMkS3Glys4iBD4Bmntt4gD9pFebIZZyfmc+lhuh5PpQ7/YfOkbiCDyxmhF/EVFfxnejhyvpmNfIn3bVowBS6nmJHRzTpDo7wr2smx5FxUWkjVhyfoG2JSJgknQFa7KYxYQp7U9UaxL/TNDxzjeUWUdk3x4L/yfi7muzpXGTvYh6SQCPTOfTQY14vRpUeqpab+tF9y0LoiFhmom5nZPe3mEqS6LxK6XZ3RctQoLhYazPZSi/1jarVFSt9neNegJ0/yeCGyl6B6gGO1dzsUCWILhnd6Zou0oc2EBDOZZCBZNVOUllSAgzfJk/qTIsG/5r+m5zoy5l3kAr4FtGKveA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(38100700002)(8936002)(6512007)(6486002)(83380400001)(38350700002)(8676002)(508600001)(316002)(86362001)(52116002)(2616005)(5660300002)(2906002)(6666004)(186003)(26005)(66946007)(956004)(66556008)(66476007)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M06GjwV0WvJPA1nM5Hm7TEMb9AqvxEPScnMbuhnOFxFsTBoHi42of6FrBk6T?=
 =?us-ascii?Q?i0xGvHqwoNroQU/tBN5wMEOx2jlBYeNaGaBsLB0GdFjnXFlL3Nrlufj3c5Hf?=
 =?us-ascii?Q?Dw/TilHyImEKgJ12HPdm5qzWAzp3J5DsI/Rh7I80ad4UHyLYjKcckHM3vZt0?=
 =?us-ascii?Q?2sL0s2b3fDThxgxMjqH1wzY650MjNBCTCC8OIn7GpRUgyFIh+A+aKzyPMTfP?=
 =?us-ascii?Q?9EGothLeg0BYe7krruMb5SGT/arHtvhiLXvzlGJdWNZnmXilYjqOmGM1cLwN?=
 =?us-ascii?Q?3sVa9WlgIpBQtnxAGs9dEIyCrTjHlf5FcEX2FYyTl3cRTfmHt8Chcxv0F9wS?=
 =?us-ascii?Q?jk7pAdTCDTSbb1dKJIQyg+2SqHxp2ZXJRTvUysHoINfPMOJTYEz5J6c4KrjU?=
 =?us-ascii?Q?Xl5aONIoveBUKhqCqNMZOzolj3ysyZh0bUUVjL3BiQT6DsqkDDAnJwnH78HM?=
 =?us-ascii?Q?E2BpGB36wL7VMgbe9V3kYDQc2FoAvFUev04nGKWYY7egcR0gaIZul2ognY1H?=
 =?us-ascii?Q?VMrj+P2PFIslI6SP6CytP0Zl0GvZsKkI6yY2rPw8Qad4Krn9U2Ypj7cV4WeH?=
 =?us-ascii?Q?6l00FO0XD+v00Gs7Uf5zRtx5qPzjufETjgpedD3iwCse/sY4b8KCfXzPP196?=
 =?us-ascii?Q?eVhbuk0778M/bZfgZchWjegK03RP417mKiLDm0C6QuMowhFeAsn3Fj1f3M4G?=
 =?us-ascii?Q?3F6pwggfVpGyCEatW3+p8XWpa0VMG6u7L/oUX3jPcSQPcpdQD9kYKDlmsBux?=
 =?us-ascii?Q?gec0saKfdGi5vzvM+POWhilKfAcbURLp+eWf4ZUumAuVCugOGiMRJq/yznPE?=
 =?us-ascii?Q?b/zBZa29yUA2+lb3FUH+/QsspO1HuQ0Ebg8sJRFOd/gZEDivnlMxLVCY52+T?=
 =?us-ascii?Q?o4KRycGn+6n5vThqYq1BdDnSOXHriABoV1B9BYRLqkgeOP/HDR5yJa54u2/4?=
 =?us-ascii?Q?iuwCa9FjHtwAC4HA9eE7armck+GfaPacvusAz5YPpgVOCCWvwTdl0DrDnvr0?=
 =?us-ascii?Q?piFRyMBacyVrpz+/zG+53pAjZVSfslFKM4AOU9NFrF/95bnYgAVPFsyRk6uo?=
 =?us-ascii?Q?oRrku4sRIm+aa5ecTphJwO1gtwpsk/PYHxhbGvl8HhPnwHpVUSR2JZXcehkZ?=
 =?us-ascii?Q?IeP01m5C2n18INnzWySvtxhAHTtcaJsqethBrgTC4Cn6m+eCFCOcbapdALA6?=
 =?us-ascii?Q?jiz0I3IJRdSe9smsMO/mE+n9oKB8q7yBuLredPyq3EeOg2zTpmK6qgsiirm4?=
 =?us-ascii?Q?SKn1oxNofW1VWVrF3RnoUImA1TGgYBilVBJvvwngGLdXeXcKtRcbNSwu9H4w?=
 =?us-ascii?Q?9guUAb+K3M33yuNwMz8ycyd9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ce8cc3-27b0-4266-5af8-08d98268d8e1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 10:15:08.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1B/8ktsjXmC9RlqyPIZehEMlunGfXdSOPyIdI61WuwyM2giNMSofIHWaZWNDJrnrRWOQJff41QyKskGHIniwBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

mem=[X][G|M] is broken on NXP i.MX ARM64 platform, there is cases that
even type.cnt is 1, but total_size is not 0 because regions are merged
into 1. So only check 'cnt' is not enough, total_size also needs to be
taked into consideration, othersize bootargs 'mem=[X][G|B]' not work
anymore.

Fixes: e888fa7bb882 ("memblock: Check memory add/cap ordering")
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..ab67b82a9cce 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1687,7 +1687,7 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
 	if (!size)
 		return;
 
-	if (memblock.memory.cnt <= 1) {
+	if (memblock_memory->cnt <= 1 && !memblock_memory->total_size) {
 		pr_warn("%s: No memory registered yet\n", __func__);
 		return;
 	}
-- 
2.30.0

