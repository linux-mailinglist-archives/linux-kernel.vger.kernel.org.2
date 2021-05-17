Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4324382AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhEQLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:23:16 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:4657
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236702AbhEQLXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUjeY3S0PKM2n3PmUA6AnGE15lra0VO/JJ5rWO4MjYwjLaCk5593NcimvzNlG/nysNIKvYLQh0Ln/mQTz2jm+p/eOt2ZAtJENDcyDU8QOHy/g3hd71JBNeBjumJ1/MkYpMtvA7MyW1NSiBr+H3tMGKd629pNGB38nngRIlksdoV5erj+wst71viPeZ4Typm8kusk0LLv3C2uX9d0HIJe0I5jUH3o9qkoDbJZtzyxUAXcOC0t8BFZXfy79eh6O5WZuqySfeUc348Ok96O0LT6F9eY5/fsyXVVdxKxpJ8YRWYNqBHEouYsAAutrXVpEesYsKTxIw4EbYlQ5zVW73YThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlYcp0Xygv4qpBBJemid501wet146ZqvF1270Bb7/zI=;
 b=N/WTSPJkvHLKWto6oQaVlTpxaPjd2+KZP/282hgh1/uTAThoWl2OEqTUpkxBw++W45nVFKse8Fi29uTeAWFayZX8gbvrmGYw2fTPtu0Pzi6GZ8xaETGnPy1ipdCTKKqRQFkl4J9FOfftd9ttASP1NP97htS/IWNcaH59TZ4aLpaFG6W6rxHZAzdyvGJR+uVqllFAz8Cv6/RMohH4s6BQXcfJu52ZWZ6dT/YRjxAejw0qplbQ3lLwPssoFb2FhlUb/KDoMFLk7RzaMVAILKMBYs46aA0uQUbBZWkuDBax7diWDpAfDoHTaF0Zks4T97H30/0bJ5gzlyphRmLV17Y9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlYcp0Xygv4qpBBJemid501wet146ZqvF1270Bb7/zI=;
 b=S2frfLpsYn6d4RfQbsyNHfjsZnYuFznyrwy59Cpjmez+pPV1C1gNaecu+J7wUAa60XAeDY65BJj2udlNqSf5W42rhy+FZLFVookhBOmPGIrjQlgsg6FchevOTuxIU/ZT/nBiQ47TY0cV2jtCXTLl4mb2oWAzEt/CSakKzP2KJcA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:21:51 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 11:21:51 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] mm/sparse: move mem_sections allocation out of memory_present()
Date:   Mon, 17 May 2021 19:20:42 +0800
Message-Id: <20210517112044.233138-4-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517112044.233138-1-aisheng.dong@nxp.com>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0132.apcprd01.prod.exchangelabs.com (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 11:21:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97fbd5dc-284c-4009-264c-08d91925f7ec
X-MS-TrafficTypeDiagnostic: AM7PR04MB6776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6776B35E039710C52E76FA41802D9@AM7PR04MB6776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0F0WlVQ3z5o7aMzYWQM5gV5VBSszuy9w8OQdPpzLU+5zBsedBaAC0VAReDEjQr24FhSiXoPSkehbrUoTPnR1lclTk0icWX+DnYxiZ35EByv8W9Rwj75tpQ/Bys132M+nsE2L041O1nquOux6IUYqNPWxLhbxCDWWPnJFVf+Ouv9GnWU2B8Vzre3UYTdymS6TF/d4sVRA2pgueCJ4iH/G8ssaH8bE5d52UFsW23CaLK9Elcd+Qaa823A1iFVFqNrwx54P4am7xyiPxpHcweBsrCW5lwt25BnOct995UAqqW9t4jyqOKIVOxJ4Y9Kdcw7d6wUsAE9e1JWLlLTPDw3XsGJoIOhvWMzPeuc5Tzi1MhvgFnlAz/xjP4v7RPOzh+cIS0SPWUdRzDjEY4rLyRikuO88jtV87mngtQyWZ2xwtCiFUPW1/BU5UaiiUp3AqJ7k4jrgJ1kHeyjHLolU7YkUEVV/UKkVtSQMcXYzGV4Q4obyooTfG5y/HClOvGL8NnN/lf984JuUED2FnQFZcsbBTRGJl5DNYu9l6D9+QGiEhqra11MKD8OVKlCzrIXJKbI3s08IUD2TOe5D3nUkypAdpLf67e3q/DQoNx5IzTY1w+HbtAfByg6LwGQwdfFoZzBgWDBOIy0JxBegvxfA7aOqzmKhqLf+KWNAK6khumdyWhE8qTzQaJiOlUy3w5EqerYf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(6486002)(52116002)(54906003)(16526019)(66556008)(66476007)(2616005)(956004)(36756003)(8676002)(2906002)(5660300002)(186003)(6916009)(478600001)(8936002)(4326008)(26005)(1076003)(6506007)(83380400001)(38100700002)(38350700002)(66946007)(6512007)(6666004)(316002)(86362001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L1bCWrm2J5Xzk3z+1FXLQX111w1xPNRgvxbednKoa/vjM2Amk+TG7lWT8Tbw?=
 =?us-ascii?Q?+ZYpW3U2w/lMaYJ+K/6fd6LOS/J3tHUJbS57Sl8mqWYFQdBH+8fhwzl6HtkP?=
 =?us-ascii?Q?AjEWnXHxfqczp5QZdrn5X/0o/6AwwIIzK2nqrz8ND5jYlDKuD/CeJ0pasZC0?=
 =?us-ascii?Q?qFFUV2gjqOf28RXyBa/Gx73HIEkjBbxsqFwmw1hmaJouqCb8rnPsFcrgnYEl?=
 =?us-ascii?Q?/gjnpF9PjNLFC1znNnMG8PHYjVVnvRB04UaSyd1FpaPnBEk2QCLfcw75SJ4D?=
 =?us-ascii?Q?tvoXVfpObp+fTvYq9eTTX3RGCMNOH0ASrF5kWtt56Ihoh1qPmk1WKrpIlD6i?=
 =?us-ascii?Q?fIWckvoU4IMBnkVAadRu9zrcwOhuXyrF4UHTLfzFIkyB+u+srECrQ1LxHo+g?=
 =?us-ascii?Q?FC5OQTFPnYY+Pt82LVuYEuuQkLl1uNnv4UBPt0GwfqZr2l5t9aBkVRMS4nU4?=
 =?us-ascii?Q?WxvUqCQMdfZK8mKAuoJBRWCDE874aC9VJR3LUVBHiiGSwLy16lkTOmnJmx4B?=
 =?us-ascii?Q?thOwjrwSSo2Zz0ALxp36x8kmAnp+zBkpHQMaEOmJhGctueeYZ1fDT0/6q2Rt?=
 =?us-ascii?Q?v6/GN/kfdSN7vg+5yi2L5cN0vtoQ/DgaUJxSVsU/P7kExtchSaVWKIDXQw21?=
 =?us-ascii?Q?mM/ZiY2I7WTlMPJ+2XGwPPDXvnwFDsWAK32sr+Wvn+tBV6spjQHD6BWJ49Lw?=
 =?us-ascii?Q?jtXPhq/odASVphPnb0eH5lpBRmRUnCgIgiyRUW3awl7s8G/Ykug0cJWkcFV+?=
 =?us-ascii?Q?bcH/CUsLqofaajL9epk6lhhBA2CmqaUQP8H282Rz0qyO0VgC8wwnKLzKFeQK?=
 =?us-ascii?Q?ZuuKx3BAwcoEPEcFf9/gaFW243Pnfv2vI1a40jkKQEkvYOnU0MZx5nCiSYxl?=
 =?us-ascii?Q?7wMP5MyZznnjmfNtR2BWJrl/CpJWr09wr16QinrpqQdIha+akS/KM6zAvZAR?=
 =?us-ascii?Q?l/YbLyRx9zC/hHnlnOKZB3GM4KSb7GGayjyVJ9nk6vQ0gj9fygB2JJ1jedvf?=
 =?us-ascii?Q?Es6T8pwfUWp/VJ0R8/Vuiu9u53l6ItzWjKQyM9bQ/o1zcT/W2MSWJ3UKRI53?=
 =?us-ascii?Q?Eb/zbQrqBH6PAq8MCvw2ps5ihbm5eVBI7Pn8ExMpmchl24Qx/PsVVuuYnTrT?=
 =?us-ascii?Q?T63Agr1S5Mqsn1csuE7JXAc1EWF44k/rF65hHvbpzbW9of84awr6Hd8wF5jj?=
 =?us-ascii?Q?DT4m6WCYZM2qtWZqjerqOAZnpnodFN1qBNkXhKXVLEmwEYzAOQoaspNDQn/6?=
 =?us-ascii?Q?cYUOft0Bk7yRtM0dgL3IHmDZ28NA9j7xA9S4Zvh+39k4xREbZhI7P5J0b4fj?=
 =?us-ascii?Q?sWwo5hIhSKqE6mzZPewAYpZO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fbd5dc-284c-4009-264c-08d91925f7ec
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 11:21:51.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S72XU62DYXiYo2czs4+zfWfiimBycxcY9XROW/7pNKUleQ3A/QXztpAvnSTacOBV0fWvYO47zzJhwbKrsEU/qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
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
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 mm/sparse.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 98bfacc763da..df4418c12f04 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -254,19 +254,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
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
@@ -292,9 +279,19 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
  */
 static void __init memblocks_present(void)
 {
+	unsigned long __maybe_unused size, align;
 	unsigned long start, end;
 	int i, nid;
 
+#ifdef CONFIG_SPARSEMEM_EXTREME
+	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
+	align = 1 << (INTERNODE_CACHE_SHIFT);
+	mem_section = memblock_alloc(size, align);
+	if (!mem_section)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, size, align);
+#endif
+
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
 		memory_present(nid, start, end);
 }
-- 
2.25.1

