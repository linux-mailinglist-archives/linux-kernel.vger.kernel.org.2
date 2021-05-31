Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3AB3957FB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhEaJWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:22:21 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:39493
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230480AbhEaJWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:22:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwq5qolgo6Rs669hD/aaRsg8ziETd6jaRBBWitcJVOXN+f9trAD0xo9270YqzAmyf9YPZbpslPuJsJiSGv21dcq9kFH8syLLTRIpVk/5o0850ofCjFFAFwC10gZeSboA7acp5S/X35nooFAr8Lc5YwEYx17xuRfQZCRsLy6/Mw1au9NIFCpHd6HOm6gmCZH3+1uFNIs6xxGCxfiNmfvpluk/wWNbC/ZLl8kO1fHjQymZllhDvPklBRPuVuf3kgLoysy6JksTIPgK2rfwrLJUBFWmcJi+mfDGl2XolyMzWWpmHymxqr+HzfDko4iPgCzHaH4oih7alYnabwsz8a2hPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzqbEHzPjK7dfrE2gE4IKWUL0rcv0nAlaZc7bM7SbVA=;
 b=E+2ksJ9z35McNfalpu8a4KwXKpRnMJ8/iBRqSbSJXSF4OJ6shLC9oZJQ9d6Ea8cQQlV0o0MFkjXTfdsGjy/Ih3RLRylStKoPVgtPc2NYkAWNT03Ks20OqLq5GJm68PgKUIe+SqfNS9B1R6zvLtV7GPnWZ86eJQtfIr879+w3jZ/al9bn26ckXQaLZhwc4i9eMh2AohCp7DsgVwyxDuZ49rxdHtqjcmr1OmQKVftHVyxzBrlfMCBwvlvdVpFga7awlJwReLp2oH38kQAyH0gV5kxxxsbnYbyCw+sHJTLEIW7JXnAXeDzIJheAeff/PU6epe++Tetu5R/syjksInmvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzqbEHzPjK7dfrE2gE4IKWUL0rcv0nAlaZc7bM7SbVA=;
 b=ZgdcGCo+o6EaNS3Rjqb8+u/UiIg8MG6tmitCSJVNP5tLtBkTy7dnI2oUeT/Un+r7OBblPI0YHUgBZLrCr92paH2lJA08oeRRI3I0d638IuRZw2KqzO4DeWkB2wVOUCNcuDnskBgmMTCZZG+RfCspBDqnai0H2tr1ntX2cV6/Ooo=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 09:20:17 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:20:17 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH V2 3/6] mm/sparse: move mem_sections allocation out of memory_present()
Date:   Mon, 31 May 2021 17:19:05 +0800
Message-Id: <20210531091908.1738465-4-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531091908.1738465-1-aisheng.dong@nxp.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7229b3-996e-446e-a4c3-08d924154e10
X-MS-TrafficTypeDiagnostic: DU2PR04MB8998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB89985B4343733428EFD2522C803F9@DU2PR04MB8998.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWZrFq0QnPmlIo1kln6rHgNxV80WpPat92SrZsNYSUnY2hUxlDmcXggXpUonzOonD7ZCR966EkzH9/0BntjpdCv7I4XZYqwA5uzWMdCw2MbtNfl2LmL7g+fm5bhFi2VeJfJbV8QcWBdqwgPVyln61sCbfuwalYwSyE73ptt0hHKUdQ8uR9JpsDNJMuQh5jQgyylAMDWCTb/QYHFB2grejLujysWUC8r2d62bQTvTKPjhnXKwl5Rb5f4UBb9lkngkWKpQKgLKgyJ//LZYb6lxqEKHPrEUfZENxi7jKuwE46NV5s3EPwss7o6KHnFFSzAtQFn2Beb0wjqYzIbHHzm+sDlCM2F0SZjkn00D3vnJs4Rdee4i3sc+9H7lCSdjGGKVKicrTUv+mjvD1WmPbV4ibbp587pHO6b+4sK1AZbk1+TKmi9HmfIHt1/orw9QGxc4T5YuGHxYdHOzmT9GJLqyolPkSOQKh6E8sNDitvaAgBftqtrWvc82Zpfd+VnGL9THd/VierN5lVN0z4WM3QMuyr4VFZjfzLzwWZ7uPoHHOHJoe1B3oBwpfI9zpGtDB0TcnRz/ViASxso5TKANV5eOh3Vmk8cdkOtviZ3p94M6Ws6syVwg36QewIFhpwhXDzTsy2CZ0eTweQGmMyIEvYtJ0Xyb3soJ2GPsGQotVeLaiOBv0evDJbt0j65bWDnZRYjP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6666004)(38100700002)(38350700002)(956004)(6916009)(83380400001)(6486002)(86362001)(16526019)(8936002)(2616005)(186003)(8676002)(478600001)(6512007)(316002)(5660300002)(52116002)(4326008)(26005)(6506007)(36756003)(2906002)(1076003)(66476007)(66946007)(66556008)(54906003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BmV5wBq9VkH0Gq/6UCgpogX686pVEi7CmSXOa6w1Sh9lPlDI6KYVELRQLKQK?=
 =?us-ascii?Q?mPWvjq6nRQyf1Udpr7R6D2xBxW/S4VnTfbOsbLgSE8ZjRzJc94Rg7TsbMwg4?=
 =?us-ascii?Q?YjNp+eUsyOD21SX9jGkOaqN727iT2TDnjtayeEx2ALpcVhFdE/+P4ndQv+Me?=
 =?us-ascii?Q?kHfonMkFV9mueUIgR4wuPTb4AdiPqIYxvQftCikXubsc15KiKkwdi7y7y8r6?=
 =?us-ascii?Q?85nNwCRMruZm9qrZNL3eXouGVkaUaZp+YBs9mA24Lv36kfFPTNGGzoLCuSeQ?=
 =?us-ascii?Q?NvOb6kmcIdjgVls8j+VmGui1g7saJskm/IfoMRV5D6KIhgyzhGwzreSdRn+e?=
 =?us-ascii?Q?0nt2+z5lxLpUEn71Ru6S5vjDGc94qmCXMyVXkWKqQBgDmdQT6KVGur8ZQ9v7?=
 =?us-ascii?Q?suV72f/X8JbUe3G7flFezS4MeaY9uCy9q+G/6b5kK9nGlmksTI1C7YX6Pc0D?=
 =?us-ascii?Q?eM2DxaN2jK8C/c1wMPpyjscCTYFrBL+mUvnTaPrRnG8IQKEu6AitD039Xv/6?=
 =?us-ascii?Q?OVNK+x69cFFFHzM3Q6vo8sr2BnHoYAhk3fpoD5caIZhhNSeUkeX9ZGyigijZ?=
 =?us-ascii?Q?ivwjWi3tLHWgOsS6wMzMwdYme2PEoAtLJb/TOlpXQb0rrxNnGzbGr2p+iWkf?=
 =?us-ascii?Q?1o48EfJoEyfwYLBG5Oj7w6Rbb3sB1EvxBQbfdI1Y3boZqXAtI6aIZIOCfUbV?=
 =?us-ascii?Q?wRh1hQWXV85BO5NbWxgRyNfIu7veL3vZcMdvT01nfZ2AJeShBJS5qVN4mi4q?=
 =?us-ascii?Q?atA+etl7spNA09qwD/HM+81gyLxTgF21cV2iR/paWhLD67eKdLz/gtV8/MWI?=
 =?us-ascii?Q?xg6iNGsbtH+46Ty1zkO2a6fqJx/QZ7QsGknfcediZXsg+xkzkMhgVBTkkc+C?=
 =?us-ascii?Q?4luWn5dVWLks6xHDKxMjscXPKJZE24y6WmX/v38uesjRUCdC4bKH0LF6sOi/?=
 =?us-ascii?Q?oUrGfOIgTqYEcT6uZDWCyH/UfyTUUKVZjK2WYwxMzjGCk63t64J30lVYP9Kq?=
 =?us-ascii?Q?Sg09wawXTIhpin9Egd+Ta17OYNbFiC9PzP8dWdP0wfhNwrYF9p/LiMX5iJMk?=
 =?us-ascii?Q?6ziUKYHhmuL2Zu6a2QFHC/7GSz1UaIYsK0ySD84bc2rKwKG/qrkydHtcXQlH?=
 =?us-ascii?Q?CrhoQf2B2Rp5X1PM9GJ5RtzSc2gZ2WcroVHUQVZ3u8u823OfzLhaRxVJExa/?=
 =?us-ascii?Q?JP0EJ8zz3cc0iiSTguJx45I326FMBUV69shajVSab5dt6EWOxTvMRs+Wiv/1?=
 =?us-ascii?Q?vRHddrdlszod9IwcaOP1SNiP1dWxn05S9t0Kv3agDYQjNnk+lSrZX2p7tZoA?=
 =?us-ascii?Q?W3+1T4c4B7rWxkF281xj/pDM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7229b3-996e-446e-a4c3-08d924154e10
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:20:17.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0pdVWXatpuTf0sI5oehT2Jlt0GinLS0vCvp87cTe4kQW29syLwVQpTK5hOLgdFSNBC7+bu2ni8naKU+283uzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only path to call memory_present() is from memblocks_present().
The struct mem_section **mem_section only needs to be initialized once,
so no need put the initialization/allocation code in memory_present()
which will be called multiple times for each section.

After moving, the 'unlikely' condition statement becomes to be
meaningless as it's only initialized one time, so dropped as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * split into a helper function and called directly from sparse_init
---
 mm/sparse.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 408b737e168e..d02ee6bb7cbc 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -60,6 +60,18 @@ static inline void set_section_nid(unsigned long section_nr, int nid)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
+static void __init sparse_alloc_section_roots(void)
+{
+	unsigned long size, align;
+
+	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
+	align = 1 << (INTERNODE_CACHE_SHIFT);
+	mem_section = memblock_alloc(size, align);
+	if (!mem_section)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, size, align);
+}
+
 static noinline struct mem_section __ref *sparse_index_alloc(int nid)
 {
 	struct mem_section *section = NULL;
@@ -107,6 +119,8 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
 {
 	return 0;
 }
+
+static inline void sparse_alloc_section_roots(void) {}
 #endif
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
@@ -254,19 +268,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
 {
 	unsigned long pfn;
 
-#ifdef CONFIG_SPARSEMEM_EXTREME
-	if (unlikely(!mem_section)) {
-		unsigned long size, align;
-
-		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
-		align = 1 << (INTERNODE_CACHE_SHIFT);
-		mem_section = memblock_alloc(size, align);
-		if (!mem_section)
-			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-			      __func__, size, align);
-	}
-#endif
-
 	start &= PAGE_SECTION_MASK;
 	mminit_validate_memmodel_limits(&start, &end);
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
@@ -582,6 +583,8 @@ void __init sparse_init(void)
 	unsigned long pnum_end, pnum_begin, map_count = 1;
 	int nid_begin;
 
+	sparse_alloc_section_roots();
+
 	memblocks_present();
 
 	pnum_begin = first_present_section_nr();
-- 
2.25.1

