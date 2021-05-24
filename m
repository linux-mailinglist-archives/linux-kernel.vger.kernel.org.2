Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769C838E1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhEXHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:40:09 -0400
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:32704
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232266AbhEXHkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:40:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHS896E7PwneaJJZhHUva2IUXFja6lQkplYFhvjLeQh+QJt1B/KFCrXO0C2T5XBIRvQXLrT18pM2YaVSsQpSdXX+ygZdQI/DYePpF1E946PlL39n8Jrz5C0skBez6g/igB+AtHiXdys9She7oDginzBa1820FJ7JwqAm4zxo3GossuziWClC6g5CCDubRZBAIs6cOqcWbkkme+yTP6hqt06Bti25Gd20iLQqhOPiQenzQ+4pmllHpKVqn2EVDmKwEOaYXQUNSOKL+QSY3TfwjcbyIf96l5s1mdqlZvb8nk9wtzhr0743m3YQdHWv38+dGT5ky8gUaQP5Xr/Vq/TXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhvjebfPNXIOqyHNM2pJ78YbP5wPDI8MQw9MT8qppTE=;
 b=TMQerOUyRwlLhmoo15k5fdCCgqmOUz+HhV0SWqbvF9CW2MYwIUeRG+ceCOmyWv6r6zFFhDyBJiOmPLVp5vxoX894l/2kA9MKCrF9DIgzkjs3EVsGeuBuTccyxXF9pD+68l+uTCnbsgx8zGGBSuoEkl9NlJphpj5MpJDTOUT6y5RFvA+TMSN+dFjuQmsmPIF9oR7xKEO1wpur0spTXgLyh7pwrtgqpga4//NiSHDdDmz6DkRiq4h4QC39VHBGpPrCL7pyM3Ecv1imtc6Dpco0trvp70DcENr1V3k2zHlFJmACqjc9GTQ6OIsEGEnDePRC4x592Jo1eIktucnV7KSOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhvjebfPNXIOqyHNM2pJ78YbP5wPDI8MQw9MT8qppTE=;
 b=I5nUaLXinUzpLMdNPmRKTzXllJUsoG3l9+ASdc9Gj84oXER9U8RyhNtt5nv7TR1J5JMjcTpVQg4iJbauaqnQ2b5ZfdlmqbpRXFDSxssfyxhvmRH9mAT4lNqxrQ/ibdx5TB5CLyfVCishLeqGCv+SI0h7XV1KpbEQnmPoj0jZPls=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6089.namprd03.prod.outlook.com (2603:10b6:408:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 07:38:37 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 07:38:37 +0000
Date:   Mon, 24 May 2021 15:36:59 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: don't use CON and BLK mapping if KFENCE is
 enabled
Message-ID: <20210524153659.58a707a9@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Mon, 24 May 2021 07:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aaecae7-790a-4af7-6d69-08d91e86f105
X-MS-TrafficTypeDiagnostic: BN9PR03MB6089:
X-Microsoft-Antispam-PRVS: <BN9PR03MB6089DBD7093B0E99AFE3EB44ED269@BN9PR03MB6089.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPgihMOTnb7yd6Pqu+8YrmeoE/qcfVPV9Ez8U6Tvua2+RilViuDiQu7cOzViBs0h2p622Y3U+jSsz7exOPDrmlSpiz5PvPbBCKj0fDvfP40RJxMFoqYfkA2djz84hTTpk09OysKS/fM1ExhSdnMcjh8OUC4ojH6kjHd71oO1/UQUbivkI0WtS6nQcciNgiTGfGOUHwdGg5TEDRtsTXb5li0BahO3YcCCxWjsLrGesJnUKxBGpdZNk+TF3oaZo4IbBLgwT1iQpaHxVqMuNeo/ATRdswhD/UhnVwJyG8EQ135jDfPBV839T26RpObNhn82qPuI5yBZ5/R4TOVcrLqvF1KZQpm3uRIGy7qFLxiwtkbVQU1F0m9Mg0OIqurbbdM6WEl8KB30GGcFvJgK9U1+UU1c0yNzsZxCEnVrvQhLb14akTVzib8MdpJGbzl4k1REe2M5rZ2GdV3BpRgom+Nd4+8xkyMUv5Gbofxxhrp5+kDKzfLQUfVViVRuDHxojHHuNrjgM4AK1fvjxAANbzlclGISfSZcLnfBCXflOl79/RQnrRzaVjqVKTnnq/UcEwvtaB8o+UMo4nCRJGNEScnyNbU5n24YndSKfvgh7lKWxYg+p3j7KjgyHIkRlEEb/t20wzxwzdRTbNrv2X/rN6Q+kwGl2uHFNyWge8DiIJHCg3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39850400004)(366004)(16526019)(6666004)(186003)(52116002)(86362001)(7696005)(6506007)(956004)(316002)(2906002)(8936002)(26005)(66556008)(38100700002)(66476007)(478600001)(66946007)(8676002)(9686003)(110136005)(83380400001)(55016002)(38350700002)(1076003)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AbcWDO4nD5DdKNzJl5hfNfNT4dJE/P23Y3HLJP/kGj7HMCn5GIL/RNeGnN3j?=
 =?us-ascii?Q?PZWIZg8gwffc2LKkYouwuw3CVbt7csfuAYXnOU5IUX2qdElZlEY3pT0MYsYh?=
 =?us-ascii?Q?24b/DrKxL1kNk1i3ofh46f2hqBND79GSafbwQ02RogFt9Nqj2/Wv+qUkt3ou?=
 =?us-ascii?Q?2u82xCYADaXYAKi2W0eyZaeT9SVJskpMWqCAkrQCrINyoJaZXsxlq43M9MJt?=
 =?us-ascii?Q?eXTX9osOvY6HXnbhHkMVZOGZlmFXkKFrU7qVRNPRDXEZKTCZsVqQX+mbzUyF?=
 =?us-ascii?Q?r9gucEUZBcPAsqvvXRsd7Yxt5QEZEKkgwprdfMLGGKe/PW+26SmCo6Dwb4t+?=
 =?us-ascii?Q?xCOcy7MX8DTZmdatm98/1KpYvSd9Ro6pBs4y7RGlgrN/23Fdd9xwIYVruLDg?=
 =?us-ascii?Q?VyiNzJ4JQeiKj5cxsIpFK9dYQVr1+78X1vTyanVmLW0SQ6o79LR8aok02UGL?=
 =?us-ascii?Q?05D/oOMxAQxR3PyuM7/w8c6PcJw65B4XDBwixA+/GWNf/CkQb+7P3kqfiYkT?=
 =?us-ascii?Q?/IDFsxLWOLKiFXp/KWtnCNg8ODlnWUSogqMROFH5qzqMrY8GZWrFABP+IYs8?=
 =?us-ascii?Q?6XnfaGJB14aedokqEI5bK2J4601Op6NJEnCnlCZuXt3I6PPkiW2UMhDVkFUN?=
 =?us-ascii?Q?WqCyBJN2xDIYMjKzJDryOgEfehEN5J0f+r+7i8ID0PO/1WQHZB1AEAiw2yaU?=
 =?us-ascii?Q?/JWOTVkaiYgSS9VkRO1kuaXFnZiabbSg82L6yX9uag8tEBCBpeZAukIprlIe?=
 =?us-ascii?Q?aVzbUaui2lCaqBlM4GDpSBhAVcX1byN6Yciq5x8eDQJXLFvI47im6h+c2PUm?=
 =?us-ascii?Q?C03K/w18wryM1R5ufFbj0qUl38dpkVsY2uIhpUVo7gPJFp91XImhnDCq9TJ+?=
 =?us-ascii?Q?sMaHi0DG9g1HFflRpukSM6Y59jfLWAIO6yckU7yy0z44mc692Ywd706AAfge?=
 =?us-ascii?Q?W6HRjAZFqFK7Xx9KzQRGIjPi7U6+kz+n1bRePQDemMbXog99AbQo2PvYdX8l?=
 =?us-ascii?Q?ktIMhmH/8xohpVOVyxmx0kjI5xzHvPk1dTwUjXCTi6yANVTQlT/0U2bLoah/?=
 =?us-ascii?Q?hYe93kvRnT+QztBWr8fiPnZf+UK5NEhMmpHuBzL4Qpv+CFtOM5+bXNENnDL4?=
 =?us-ascii?Q?TlCzGeeNc7bthfNEM+B6Uw7XsBuXyW1jJuBur8fA5rwMYtmUR+x9UXurHKnH?=
 =?us-ascii?Q?l8yKH6NzzvD42ChMdFMkaNb1K2Ar+VKAX50Smvmkj0KkZ7vUZSqmnHnN6v4D?=
 =?us-ascii?Q?oFOScWPXeX7Ywc5Nolic4CjDQJV+8GgJ1vqldANcyMjjsAdQkAEJwWZ/NtMX?=
 =?us-ascii?Q?KIToy5FbMucR9LEBxwoNhyjT?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaecae7-790a-4af7-6d69-08d91e86f105
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 07:38:36.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFbkqQcZX+MwMqjlSt+SW9hJcgLOCuVWNbKXsL2bZsKxW+QOcGR8VRCc8olZ/ftlh/cyODm1qcahezjWwR1oHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning if KFENCE=y but RODATA_FULL=n:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/memory.c:2462 apply_to_pmd_range+0xec/0x190
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc1+ #10
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
[    0.000000] pc : apply_to_pmd_range+0xec/0x190
[    0.000000] lr : __apply_to_page_range+0x94/0x170
[    0.000000] sp : ffffffc010573e20
[    0.000000] x29: ffffffc010573e20 x28: ffffff801f400000 x27: ffffff801f401000
[    0.000000] x26: 0000000000000001 x25: ffffff801f400fff x24: ffffffc010573f28
[    0.000000] x23: ffffffc01002b710 x22: ffffffc0105fa450 x21: ffffffc010573ee4
[    0.000000] x20: ffffff801fffb7d0 x19: ffffff801f401000 x18: 00000000fffffffe
[    0.000000] x17: 000000000000003f x16: 000000000000000a x15: ffffffc01060b940
[    0.000000] x14: 0000000000000000 x13: 0098968000000000 x12: 0000000098968000
[    0.000000] x11: 0000000000000000 x10: 0000000098968000 x9 : 0000000000000001
[    0.000000] x8 : 0000000000000000 x7 : ffffffc010573ee4 x6 : 0000000000000001
[    0.000000] x5 : ffffffc010573f28 x4 : ffffffc01002b710 x3 : 0000000040000000
[    0.000000] x2 : ffffff801f5fffff x1 : 0000000000000001 x0 : 007800005f400705
[    0.000000] Call trace:
[    0.000000]  apply_to_pmd_range+0xec/0x190
[    0.000000]  __apply_to_page_range+0x94/0x170
[    0.000000]  apply_to_page_range+0x10/0x20
[    0.000000]  __change_memory_common+0x50/0xdc
[    0.000000]  set_memory_valid+0x30/0x40
[    0.000000]  kfence_init_pool+0x9c/0x16c
[    0.000000]  kfence_init+0x20/0x98
[    0.000000]  start_kernel+0x284/0x3f8

Fixes: 840b23986344 ("arm64, kfence: enable KFENCE for ARM64")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6dd9369e3ea0..89b66ef43a0f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -515,7 +515,8 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
 
-	if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
+	if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
+	    IS_ENABLED(CONFIG_KFENCE))
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
-- 
2.31.0

