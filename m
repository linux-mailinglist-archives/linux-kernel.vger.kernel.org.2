Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9D44D631
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhKKL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:57:34 -0500
Received: from mail-eopbgr1310100.outbound.protection.outlook.com ([40.107.131.100]:37185
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232815AbhKKL52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:57:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7f0ggplGwDgpNggZzYMVO84DEZSZEMAr0KcVIW/dPaqwVDztfkfJXlnusfY7VJ5brA4mX7eoE3KjBhR2O9suHiPTNCikPcTZUQp4P3Ilo3R7+eHjB7/MzRWov3s0cjoDvDWH9NMxg3ZP0aM9sMmfRq/N+hlLGBNAYx5eqmBhJAguMUuZtOVKuP5A+T/INbxj1DLk2A6HQds1DPNee5VfpTWTd1oSZ0l++EZczFJ92odzn5OjD7n36Wgt+iAB/zTw6E89H2YKy3pe7m3hT/UO5wT/K8KO9rXySFpB7xvCoKsGTJz70ADdBOWkZhtLXnHwITUnV/TYcsa/o0Kw/NLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmj9B/vl2rcYhvd0K4Ew1iv7fwtqqmloOoGg/ieAxMQ=;
 b=Oej0DB3oWuyMMbMaw9TVGzFviXI1PN7IAz5XhHKJt4u9Q0IbROxIlfgtJazLX0ZXbsoLwphvienZhYdf/cc2BrrqHNbI/CSyPqVYNMyIn1VlAHCkzfPJKj1zVAkqZmTs41Ul+uCrR+clkS3tBL+phXxxQqFVhX9MZcQD1MucRMNB7BUS3kOJXUVcJTKFyOBmW3lpGsAaOrqzTsrNN1hC9VqQTp4PujmG43O7DtDzxZeCYACfhuELF4Lca2pHWR+GG2O/1K5cuRLo0qOMYllefLhXn/nXUCpNrmUZKVOPtx6LyaYlT0lq3OnfzseR1HoGd6cER1fJVIMRPjgiMRXEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmj9B/vl2rcYhvd0K4Ew1iv7fwtqqmloOoGg/ieAxMQ=;
 b=dardbYk752w7eNa7HXrQd190zMeAarTnvkmYyT0dNEjmmiXfK/15o6hATpriKVPHnUJKz28KoklTsL2JllMarMT8gpPduqS2a1/9HKtaB86penLYZG+eGHCfgfTMhq0NrRMt0TYVlnhf+7e2jbyI0cUeGuGj/oznhPHloBmYgzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYAPR06MB2189.apcprd06.prod.outlook.com (2603:1096:404:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Thu, 11 Nov
 2021 11:54:36 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 11:54:36 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH v3] mm/damon/vaddr: remove swap_ranges() and replace it with swap()
Date:   Thu, 11 Nov 2021 03:53:54 -0800
Message-Id: <20211111115355.2808-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from localhost.localdomain (103.220.76.181) by HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.12 via Frontend Transport; Thu, 11 Nov 2021 11:54:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 641bc28f-78bb-4640-4e1c-08d9a50a08df
X-MS-TrafficTypeDiagnostic: TYAPR06MB2189:
X-Microsoft-Antispam-PRVS: <TYAPR06MB2189D676BBEFDFE33F735366A2949@TYAPR06MB2189.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8DJxBQS3KaSGoT7W1tWPIwk9RFpTLOEN3sp8XWJYmQNhGXDMf81JT0hjEOr/gYSlgwYeCOLHwiRHjljveUT3bPfuzp2yHcAq/PmxwPG6LEh3MmGf4vXvQx04M0UzFIY2/fvamWpg0Cdjmv3uajy0Dd1dh75M+qjeSnhzrrWw4sj1tSpnThK1vp6Z/LCncaw88P1pXq9prfnUwt6254IdMgfHBAN+EPJ68ZnQE6n78cZuIncOEui5LLiFkchJzdAQHCZWQ7CiUjRZguwfcNdrqAmLLoqdDhn0oRsCR5f1to1nczhPwk9zIXCfVeN+Y++LTdNJPvSvEGfk/cXun/yc9qncxQovfehm4c8Ky6n6JD05gjbujwTsHXJDVCEDjBWgAuUUBFOHJa5R1OTUiJcT9aRuTdczTka4czH5OLRzJ+6Jyx9W2nQwCnIeRyDDnBGTD++s72UDWzFljK9vK0DF/i9EAUnu1kUhDV2zLlNkqopKCOMzgnmqyc68r0F05RtGuXk79nIM/teULMiyozfnXskIKgb/GeW1vYfh9ctbnSHkLUPtWHD7Qw6b0epot+M1tWtMEiZBIrbiVjhMaiZYGFhqFQVzkZ7mYkrcq9TfhmyYsTTQaZFEikWW51mkEN5GjQoX8TxKSqcEJtFCtPkj9ZZjIk1UyjRQiNYuRqEPz2WcsXCY0Hw4qYuOZHlxJU4F4/HlrIAUGLJniwEcx4QCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(186003)(66476007)(83380400001)(5660300002)(107886003)(38350700002)(38100700002)(66556008)(1076003)(2616005)(8676002)(110136005)(6486002)(508600001)(26005)(316002)(8936002)(86362001)(6512007)(6506007)(66946007)(956004)(36756003)(2906002)(4326008)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MR0AqHktOCjBtqim8pxYo0i9iCjK6HBrbxIAyQ3vg+ucDvbeTRpsLEQke8h2?=
 =?us-ascii?Q?a6/OftNjUFDLTgPVjIASVYbRBt+lCfUFo0zg5FYPtCSGKGn4WiLPO4Cng0Sy?=
 =?us-ascii?Q?nifdy9wHefTDcIcHib+uzFOL6PfiEgMwCylQneCnjglnccNvSy71Aw0hEaBP?=
 =?us-ascii?Q?0CO+CobF4ufesBW2yNkwdsNOtVFFIGrcClyds1/g4o90MwpDBnk3hlEYshKq?=
 =?us-ascii?Q?uxFv8e8uIgbolcUEbUQ+fjKjB9bHZ2jdxMLKxS0NVc9p7aYYVA2vIeQ9YTF/?=
 =?us-ascii?Q?QXa5gzLDs+Hja0eUBl9++8/GFQu/y9SdAJCU4nTGZnOBvPlIeMm9+GBkdw3Y?=
 =?us-ascii?Q?KkAitYhiA323ChbAgDrUy2jGwjMqlTxKlPQwuAGwhhki+cfGE1276mYy7fUn?=
 =?us-ascii?Q?ehfwg6Bmk7BRz4MdYt19073IuaRZFEuZn/eX1UAL2OeEOEPzepjBnqOVpol0?=
 =?us-ascii?Q?tAGgEPCxRjEe/9SmxlSGN+Y77/Le1s7HCVEmE+mqU68YJRG77dvwuTUARbJj?=
 =?us-ascii?Q?/mAIJ54WgjGo7oR8UVkIszCjo15nF/0Y4CpQMZ2MaiAMCm4pggjmMSJOoFS5?=
 =?us-ascii?Q?8HPjk1aAQKjAzwmyZu0lfAeVpZyG1iHBtZMDkdPi8XrGGA7kBDHPzhbLwgim?=
 =?us-ascii?Q?P5LyCPUYg4AagQrA4Okm9RUHItOnUdbmzLtklRG5x1tUlZRp6oqa/17h7w/X?=
 =?us-ascii?Q?wCxIWH8UFYInSVMw2Lk5Wp3xu+VyEV6albV0Bfu50VbCZbE9rK/v+HsMQpqk?=
 =?us-ascii?Q?V3cVHlLhwWp3/ns6WE52IaoDsH/53z2odehR48egfQ74YRYBvpQ8DPuJR5gl?=
 =?us-ascii?Q?gnMvzW1yfsU6u26B3Sq7HOzlZglRnQb9E6LYaIEZfSrxJPsDZXHx1NJ/s+kC?=
 =?us-ascii?Q?J4g7px3k8B/nzxVze8WNqfZEpZCzvXTux01y6uMNaIW8tBJhnkSyHV2Es7M7?=
 =?us-ascii?Q?h2sjskfBjZmm2LSbQ9McXBoHsSqerWzVPWhtn/jQ+S+dZB9ONTaiaTOAs+HZ?=
 =?us-ascii?Q?56qB/u7KgRjsb2MGWMtuhwDoy0ewHbST/DvTLpo4syzc0BwtbUzm5YFKc5FD?=
 =?us-ascii?Q?liw4/CFr3f7HnvGR0z5DPq6KBSTBJ8bOran7VliqbVx1eQT0y5+LB+wUY7WV?=
 =?us-ascii?Q?WdG0Ce0dIl2f8bKQT/Q3tY45KfywQPpWYqjGm0PgaQx/4KiagSqRvJW5cpZt?=
 =?us-ascii?Q?OiGC5QTnxuVw68yeiN02K5reOtbLMbjU6EVxpVQyMpNSPmFmmr/ndFbNeabH?=
 =?us-ascii?Q?zV9gC2EHVrGVmChRRGf3TwvnK8nPyyXMK5/cKpFqSvJKcJfC0005faJLxHY3?=
 =?us-ascii?Q?af55Om1eW6YpTNLh6JakIveL1Nl1aljKJJkcG0o561Yiwd1EcBnJOB9ig5aC?=
 =?us-ascii?Q?Tlk4NHUGEOsqNrsL5BktYfWFkm0BOmFsdWX5P2jA45f+QzdiUfqROF6bpYtl?=
 =?us-ascii?Q?qkVZY/Z+DrTtcUQ4IlpfjNhCjgqVuwertmZw3oLYhOkDgZEFSujNWKrmoYn8?=
 =?us-ascii?Q?VoZA6hI689cBTMk7pbMaHRVEPZBtnvRdoGcEgQSrIK4Dbkjbvvdi1mv7SAuY?=
 =?us-ascii?Q?ALd/qJWotrIi0LCQF4EA/h6v9b2EzQzHD4gJJvB4rxon8VhOGprU6vvWgyDD?=
 =?us-ascii?Q?tyYNQciNkNDu4qkThUsQ0S8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641bc28f-78bb-4640-4e1c-08d9a50a08df
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 11:54:36.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoV8zC//r1/cE23EZZ1clM7cN6B5p22yuhm+pkHt4AaJnGhzxpvodlpny88hPgWJx6uXoGDvn0FiiyHMacIcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'swap_ranges()' and replace it with the macro 'swap()'
defined in 'include/linux/minmax.h' to simplify code and improve efficiency

Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
Change log:
v3:
- Fix the commit log.
v2:
- Remove the 'swap_ranges()' function and replace it with 'swap()'
rather than changing the 'swap_ranges()' itself.
---
 mm/damon/vaddr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..814dc811d7c4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -97,16 +97,6 @@ static unsigned long sz_range(struct damon_addr_range *r)
 	return r->end - r->start;
 }
 
-static void swap_ranges(struct damon_addr_range *r1,
-			struct damon_addr_range *r2)
-{
-	struct damon_addr_range tmp;
-
-	tmp = *r1;
-	*r1 = *r2;
-	*r2 = tmp;
-}
-
 /*
  * Find three regions separated by two biggest unmapped regions
  *
@@ -145,9 +135,9 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
 		gap.start = last_vma->vm_end;
 		gap.end = vma->vm_start;
 		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap_ranges(&gap, &second_gap);
+			swap(gap, second_gap);
 			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap_ranges(&second_gap, &first_gap);
+				swap(second_gap, first_gap);
 		}
 next:
 		last_vma = vma;
@@ -158,7 +148,7 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
 
 	/* Sort the two biggest gaps by address */
 	if (first_gap.start > second_gap.start)
-		swap_ranges(&first_gap, &second_gap);
+		swap(first_gap, second_gap);
 
 	/* Store the result */
 	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
-- 
2.17.1

