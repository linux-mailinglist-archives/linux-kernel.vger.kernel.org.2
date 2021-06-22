Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4203AFAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFVCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:17:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16208 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231311AbhFVCRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:17:34 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M2AjCw017377;
        Tue, 22 Jun 2021 02:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=dYQZpm9qlCJHQql8M5RmjibYwCoUzVft18eztzISBS8=;
 b=R0yYlhN5/MlbzXb99wpeFToOmHFox7jd+rteBjrRpHB4Rrj+0cU6S5H/5W+z28eouzl3
 nTeGPBmawSdmYjT61Kbs7D4DvsFEOl1eYbRQNp2Q0eUbjn/NGHh2GM1xps/uENQYOGrc
 WB1M/AGDnHlSn29ql+5/ek5OXCaznX05AIVB6DvaOnLhmZhhpcC/oUI6RMsqodU34t0J
 YKdDVMHMY+JNDvfI6bz2vrNmAfTeY9JM0hChbAEkyKx7VmO2CdxAlqqOmenWOMd5/xcY
 /eIsdc2/fIfKv6iLxSpcqsyFwMa82jjY9yD2VcAwvUVSLcaIZk4q0u53jQBFnGYjaL8c 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39anput4k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:14:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M29aL1033420;
        Tue, 22 Jun 2021 02:14:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3996mcqnbh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTiPJ1Aek0yibIykvzq6nWgv+CHhXrowdLgCnL2xB4XvA/yCjdSurku8/OXZW63HEzvyyrwIIjQungH2rTdvOpRhDYzYKqDOOATkx9pGtCyEreyLD4KiGmKXJwdJeWK0b3f6LtY5mriTawLP33A0MkZM0iZSL3tlhrr826YN17++n4QlZcqRbAnq+0fLDK02riK5ib7zKscgT+4/Afv3Tspap3ru2dFlKrsjdBhyozOWaCB71QT6cRMADIu5s02QYJ369cJBRWYQ3j2PdsaUbwdbdsQVefcP3c2fGDeCPwG0GF56wpxcXb2/Vh4i7PBiae4vnpFHs12YYBhy3HWsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYQZpm9qlCJHQql8M5RmjibYwCoUzVft18eztzISBS8=;
 b=MUTfCWOHVFdu6ZvpDB/W1UETAXqMqEU9GQXrW8Puysix4ceNO+ApyTs5OKKMhX5/iCMVfrxyKKI0jVbK/+f5bht5fqwTsdB0lYtphIA+DqLB8U5fdEyTaHH5qGs3twlQd9T8D69CX+gHcYe+RX7D/+RRfpTUjtBw0OBrqHJBd7wxs27RLMCudC/0r+7IgvuHbP7VpAH6ppp/wsMKiiYQrUkq0an6b4wqwbjc2UTMcgVUFlY17iKQfQOLwX/sDETw6+Y/bDBgbiETimb0xIoJ7fNlu+Y2I7DadpAZ8yaXY+iWXyXlHW9snBfXQNtSkMvDVa4yhazeqD5TkZQjr9IhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYQZpm9qlCJHQql8M5RmjibYwCoUzVft18eztzISBS8=;
 b=qR6Xa6SQOgvBBPLZ7dPhKsh4uiVJW1MpHGlk2YRHte375cWvqWlKDoFTmigNA1RtH3+s2Y5BJrmVy8HzBVzIegEyj54nQ7WUfCcqRkMKaL60iEjLyS1tcXbWC8u+GHEn4H9xXxaOTA28ipRIv78LL1Qh98/lV9bb2+6CQLRtr4g=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 02:14:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%4]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:14:42 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/2] hugetlb: address ref count racing in prep_compound_gigantic_page
Date:   Mon, 21 Jun 2021 19:14:23 -0700
Message-Id: <20210622021423.154662-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622021423.154662-1-mike.kravetz@oracle.com>
References: <20210622021423.154662-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Tue, 22 Jun 2021 02:14:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df7594ba-0947-48c0-0e27-08d935237f1d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2664F92427E0BB5273CF752CE2099@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iOZVCgj25ztiAxgY44OYzazlbRAqYQAekqKdrS6Ylgq0UXzAA2EBkRrezMO5Ma+cARxobcuCcEiX+vgFANs/hcFspLz6bxtRx0EhDHsKdh708CS/LMOqurw/ke51xqc0psoY/+D5TIg7+KmPrCsUVSpaKFSup9hCQ1RRTSieSCR0LrnmE6cKyAMH08RmnkPxdaspVDVwXD2nXGhxucdzcylwS8kA0ECeUYn02bYLQwz48OFt/gWKsL3G31G9XjAqqFue6gWxnopAoDbYQaKcTSq75CjZUP1HIoTuDWVyswzrziFuj//B/DzzhPOBGkbXO+B1A2JrHY+wXpUd9Rs2tMqF2j9A8RxTSaRQsojD+TpDHySsjconYnW5g3tzBUcxpjcjoqVpwzNfFNcdmQ5Hceau7pIfWtUCLlEmB0K1ZPvSqnaf8xW6m3WBPHxbJ609mPzLUKbQ2Oc+ziyMK2YIem3wpTEXx/lgGNBGd/NV7pjq+w4aG1RXYJQu4B+yTJGPlyM09+yeX3rVhFRr0Z4roLBpMObEIu7TZR0I9g5nop0ZmHosSh8a2NbKydxfYCK0LgFNhg4GOVQnhtF5WnI0E64ok3j3Y2tE6v12KDSr/6VJSAFy+AuFb4KaAE3eDTSMmADB5jSyVI9+Xz8rN60e1TSE4G0EGV5UTWnru7slmqFBGiwKhinEYI2ecmFNbjrBAabHCvRezkW1qxCRZNM2CTn6ynV6goUIIeTmq2jBaUmQmeLhuWIhZKAVtmenD+bq4S46cngJ62SOjZCwCjW6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(52116002)(16526019)(186003)(66946007)(86362001)(66556008)(5660300002)(66476007)(8936002)(7696005)(2906002)(7416002)(1076003)(26005)(8676002)(966005)(36756003)(478600001)(44832011)(107886003)(38350700002)(38100700002)(54906003)(316002)(6486002)(2616005)(4326008)(83380400001)(956004)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+MFWhlqxhBnlwUdXFlQSwnNNmlSKdA+GFbXdOkkXhy6snNyWuEQDn1CHsT5?=
 =?us-ascii?Q?wWrbicMZxaHm+ukp86s6/2hvftrnQ6TocXnhbk137al0ANk4A0v/ONoDZlzj?=
 =?us-ascii?Q?9MHbm0o7Fwtaaf5xHvxIX2sYEk2yLrsWWre1+uVhggh4EYesjxJZZIKZZrZH?=
 =?us-ascii?Q?0O3Qdtudvbds7HN4hjr6Ejp+FGkiiU4crjxbdPdMgMZvF0cm+eMpJ/XW4eX8?=
 =?us-ascii?Q?Z0mygTDzBcO9PH65TsxVwham+gXvOJBYbUBiC0rwRrUs6UeAGKlfDr8iGSpE?=
 =?us-ascii?Q?AL9VvOEDIqIf13heIV4TG4y1kR6MUmTc40noymRse0TvlL8dqhu2WKKYT29d?=
 =?us-ascii?Q?bjHyQ42Vj6HkZQFmJx9y2fhKy0hZAo7/YIP4vyIDcPojR46cKsu5PO1DX1By?=
 =?us-ascii?Q?0LR+ht0w/oGY+TrgTTj7pvRVTmKfQhoX1zxAB1DDXL1mNQNAzCZ5g2XjzwyK?=
 =?us-ascii?Q?WbvGVyVL9OSn91a5wGsQHLGnM3atQMtgUohg6Yjgdhdgofkkxvf2KDqxd/29?=
 =?us-ascii?Q?Gd5NebJV6svGgLqE0CGo722uOrEOC5+YRZjHhHYSGYVKJAbtDwHNbOip7FHJ?=
 =?us-ascii?Q?HPpgumIQw4g7to8Nwn6H3ZrTyDhdG8HhWe1VGTA9QtIzjLZeTra2kRlnWFP6?=
 =?us-ascii?Q?mK2kPNmyJpziTVjNOdRGqhE01pkKJnqDVLUiPgosJq/EJ634pwH4aeekpU62?=
 =?us-ascii?Q?etMFpb0PcJZbvcVSBDL0LsWk7SW9TqWQz+7dS2QrtviUZiYEWqcvfYaq7vm0?=
 =?us-ascii?Q?GSXB9zMkIi4oMJnajS7ZbRoizHmRdF7tUzNZYllIPGMDSjrspqOXj2tsOD+M?=
 =?us-ascii?Q?/NnT7volAUcL3GLyFSO2KYYFx0QV737RCpFtIw8r0d2Y2MVAMNmDBrvvV4nf?=
 =?us-ascii?Q?W73EM/7USvWz5UhTr5zH8L4UXpdMVuVb8pXlav6BC5qneWVTwVMo4M5hXKo7?=
 =?us-ascii?Q?GXIXk/kiLSgWaYTZKRBTxXHa+M3Rv1GwEDfKODL/dDjKpvLt3w3vGtzNHLCC?=
 =?us-ascii?Q?s/CsglrigriFRwmrlqi7iGJefdzWn0IoReXQNV/HIe6/0Ka7/A1+80LuUEuw?=
 =?us-ascii?Q?bEbW0IijxrSLO434oNpRnkEzIhDj+s/hW2PUQvLRyl775H4KAuPHlR7qqL2Q?=
 =?us-ascii?Q?7XwsNYuFejP09AklzmxPU833Vo8IDMGuleJF9hJ4sHbC6RkB7Ess6nDbaucI?=
 =?us-ascii?Q?xWnOUQ4EIkVrUc8u+B+m4tuuTbK/WetcL1cLcAGgVlkeKMRhIV1bXUAxQiqi?=
 =?us-ascii?Q?HCF1ZjtEOJQx9GAH4HOaFAhdzRayZQ4EJwn+Rf+O4NQxB27Cg3hUdvPkgitN?=
 =?us-ascii?Q?8KZgckUPruZWrvM9xRKE326g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7594ba-0947-48c0-0e27-08d935237f1d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:14:42.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrNheXdAIiOS+Wc/pVtVTIOMCW6OymXQ+127fTnXEeVK0tQRl1Uep1p6UBT/HyLwmasnKor6grNj3K8s39D8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220012
X-Proofpoint-GUID: NGsjaUlOblN-h6p5tPNC7arWFCKyIPpS
X-Proofpoint-ORIG-GUID: NGsjaUlOblN-h6p5tPNC7arWFCKyIPpS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Jann Horn points out a possible race between
prep_compound_gigantic_page and __page_cache_add_speculative.  The
root cause of the possible race is prep_compound_gigantic_page
uncondittionally setting the ref count of pages to zero.  It does this
because prep_compound_gigantic_page is handed a 'group' of pages from an
allocator and needs to convert that group of pages to a compound page.
The ref count of each page in this 'group' is one as set by the
allocator.  However, the ref count of compound page tail pages must be
zero.

The potential race comes about when ref counted pages are returned from
the allocator.  When this happens, other mm code could also take a
reference on the page.  __page_cache_add_speculative is one such
example.  Therefore, prep_compound_gigantic_page can not just set the
ref count of pages to zero as it does today.  Doing so would lose the
reference taken by any other code.  This would lead to BUGs in code
checking ref counts and could possibly even lead to memory corruption.

There are two possible ways to address this issue.
1) Make all allocators of gigantic groups of pages be able to return a
   properly constructed compound page.
2) Make prep_compound_gigantic_page be more careful when constructing a
   compound page.
This patch takes approach 2.

In prep_compound_gigantic_page, use cmpxchg to only set ref count to
zero if it is one.  If the cmpxchg fails, call synchronize_rcu() in the
hope that the extra ref count will be driopped during a rcu grace
period.  This is not a performance critical code path and the wait
should be accceptable.  If the ref count is still inflated after the
grace period, then undo any modifications made and return an error.

Currently prep_compound_gigantic_page is type void and does not return
errors.  Modify the two callers to check for and handle error returns.
On error, the caller must free the 'group' of pages as they can not be
used to form a gigantic page.  After freeing pages, the runtime caller
(alloc_fresh_huge_page) will retry the allocation once.  Boot time
allocations can not be retried.

The routine prep_compound_page also unconditionally sets the ref count
of compound page tail pages to zero.  However, in this case the buddy
allocator is constructing a compound page from freshly allocated pages.
The ref count on those freshly allocated pages is already zero, so the
set_page_count(p, 0) is unnecessary and could lead to confusion.
Just remove it.

[1] https://lore.kernel.org/linux-mm/CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com/
Fixes: 58a84aa92723 ("thp: set compound tail page _count to zero")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c    | 72 +++++++++++++++++++++++++++++++++++++++++++------
 mm/page_alloc.c |  1 -
 2 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 50596b7d6da9..924553aa8f78 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1623,9 +1623,9 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static void prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 {
-	int i;
+	int i, j;
 	int nr_pages = 1 << order;
 	struct page *p = page + 1;
 
@@ -1647,11 +1647,48 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * after get_user_pages().
 		 */
 		__ClearPageReserved(p);
+		/*
+		 * Subtle and very unlikely
+		 *
+		 * Gigantic 'page allocators' such as memblock or cma will
+		 * return a set of pages with each page ref counted.  We need
+		 * to turn this set of pages into a compound page with tail
+		 * page ref counts set to zero.  Code such as speculative page
+		 * cache adding could take a ref on a 'to be' tail page.
+		 * We need to respect any increased ref count, and only set
+		 * the ref count to zero if count is currently 1.  If count
+		 * is not 1, we call synchronize_rcu in the hope that a rcu
+		 * grace period will cause ref count to drop and then retry.
+		 * If count is still inflated on retry we return an error and
+		 * must discard the pages.
+		 */
+		if (!page_ref_freeze(p, 1)) {
+			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
+			synchronize_rcu();
+			if (!page_ref_freeze(p, 1))
+				goto out_error;
+		}
 		set_page_count(p, 0);
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
 	atomic_set(compound_pincount_ptr(page), 0);
+	return true;
+
+out_error:
+	/* undo tail page modifications made above */
+	p = page + 1;
+	for (j = 1; j < i; j++, p = mem_map_next(p, page, j)) {
+		clear_compound_head(p);
+		set_page_refcounted(p);
+	}
+	/* need to clear PG_reserved on remaining tail pages  */
+	for (; j < nr_pages; j++, p = mem_map_next(p, page, j))
+		__ClearPageReserved(p);
+	set_compound_order(page, 0);
+	page[1].compound_nr = 0;
+	__ClearPageHead(page);
+	return false;
 }
 
 /*
@@ -1771,7 +1808,9 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
+	bool retry = false;
 
+retry:
 	if (hstate_is_gigantic(h))
 		page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
 	else
@@ -1780,8 +1819,21 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 	if (!page)
 		return NULL;
 
-	if (hstate_is_gigantic(h))
-		prep_compound_gigantic_page(page, huge_page_order(h));
+	if (hstate_is_gigantic(h)) {
+		if (!prep_compound_gigantic_page(page, huge_page_order(h))) {
+			/*
+			 * Rare failure to convert pages to compound page.
+			 * Free pages and try again - ONCE!
+			 */
+			free_gigantic_page(page, huge_page_order(h));
+			if (!retry) {
+				retry = true;
+				goto retry;
+			}
+			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+			return NULL;
+		}
+	}
 	prep_new_huge_page(h, page, page_to_nid(page));
 
 	return page;
@@ -2771,10 +2823,14 @@ static void __init gather_bootmem_prealloc(void)
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(page_count(page) != 1);
-		prep_compound_gigantic_page(page, huge_page_order(h));
-		WARN_ON(PageReserved(page));
-		prep_new_huge_page(h, page, page_to_nid(page));
-		put_page(page); /* free it into the hugepage allocator */
+		if (prep_compound_gigantic_page(page, huge_page_order(h))) {
+			WARN_ON(PageReserved(page));
+			prep_new_huge_page(h, page, page_to_nid(page));
+			put_page(page); /* add to the hugepage allocator */
+		} else {
+			free_gigantic_page(page, huge_page_order(h));
+			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+		}
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8836e54721ae..a672d9c85118 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -749,7 +749,6 @@ void prep_compound_page(struct page *page, unsigned int order)
 	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++) {
 		struct page *p = page + i;
-		set_page_count(p, 0);
 		p->mapping = TAIL_MAPPING;
 		set_compound_head(p, page);
 	}
-- 
2.31.1

