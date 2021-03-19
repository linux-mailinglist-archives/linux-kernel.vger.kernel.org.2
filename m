Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C03428D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhCSWnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56436 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhCSWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMa8UN027312;
        Fri, 19 Mar 2021 22:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=T5h08E48aTHqHAs7oSFnQWTyUDdovMoQpW+XQm58DBI=;
 b=ZMkTUmIhPom2Zt+sswil7yaW+l/cOjSaO8ekkCZid/3V+BkplOsfbt15AO4rJc8OlbpS
 mBSoDpgw0+STc5aSApKE8DY+wSBcas4v0DOeIYHmd+39ynJTSsnPWrlqLtJzSQHns68O
 Fi215ueQPGlTQBkIvx7592HRv7iJgQ9BhwG7nV70KVH52qGJpw0HJB+ISilC33s9GDfn
 JNp0mg0x0voVr8FI1U9zWboPIE/I1hZqB0BKU0JgzsDZmYmZXsV/ld4ArYK13I804PEA
 B3+ri9KT1a8WzUTUchlr/A+v8Cu57u9p5ZyWKHI5EAbJXI3KAlg458rtZOmGRpxSXGO5 KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 378jwbvhm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMdl6A044897;
        Fri, 19 Mar 2021 22:42:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 37cf2ca49n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzwm2B08K54TDqL3A3hsIaEUzc6m2KPpFRYKtTLrCmcmPb+YQN/J1AzYyUPyRr8vN20HdgJkbDFYxpwnMLWHRW9Zj2cFral+dS7fEdQhhJdYLRhwcuusO2fpvPj5IY52XQ8BlqBg1ohG9rQX2Nv27bwjB1aO9hfuFDR7ZPVC+/lPLKElHvsSAF/oVPL7Gbi9NHk/MF49ywvbypnTPFe7zZs+RcKHw8Nf71Z0JZLhaP5zIB2z44ZATAMtq7shXHM5JJxrcif/NSR3QMsqE++/OChIBBcP1a9FAyNGRB2quwEK0MPI1gMZ2Ai18szZGTEw+ISF9rxL9g0j24Q8jaOwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5h08E48aTHqHAs7oSFnQWTyUDdovMoQpW+XQm58DBI=;
 b=KtubUU1lx8VXu6ifcu+bHXvdWrMvvAmFKDUorG/bNmfqsnc/pGs93pOOkW4n2k5JEEhnyKhFiLaQfehYhkvYOiJTurI1wWw/N3PjRRHn+KBMDrInQnvrEFAcmNuL1NYEKB3VMdwmK0QmibY71hsP0pUa66IZC0EzPmIjAZ/X7uqn+dk5OEhaIte53sa4eO+SEIF/I3DwS3SYZIw1BAEj9bRxC7iSVKkgV6PLabrzboSAnKowtnfz/+ywHnNXskwzYVMLYdKvT1fmVWT5sMJ2xUbAynerLX80mGA9Bm/ruzHclNVkRgtQoQpyfldnMgqzm+NLpGGlmZOVHwCNcVNjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5h08E48aTHqHAs7oSFnQWTyUDdovMoQpW+XQm58DBI=;
 b=IBVUagw3XJ0qus9A08x9MyuhGoSfPYb5VfAMdiiJA4SEN4CsoN5+6m1H0Wnbq8AN50PC3RSsqmV41fchMK6NbARex0vbhb/H1dc9IjqI8NaUFXQvUsfIl0dCNURI5EiR2Du3mfVaUphHflDyni42qkve3S2CHWd0Hy/Hz0GSdS0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 22:42:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:33 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 4/8] hugetlb: call update_and_free_page without hugetlb_lock
Date:   Fri, 19 Mar 2021 15:42:05 -0700
Message-Id: <20210319224209.150047-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319224209.150047-1-mike.kravetz@oracle.com>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:300:116::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3585576b-7cb5-4aee-63f8-08d8eb284908
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB31600B399A2A6706B2E6C74CE2689@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QhvduPRB5Ak5GzB56D8GPF3wLx2ZVqw8fxYm5cTFViBxQ2OR0nD73LrHdhqDphAwDCQBRUE2ePnKPZzd1e/vtI4WooOTFjH4zUL+UuSqPOuHht/J3argiCjjmrVozWCpOAU1Wq4HyJ+Q0ZdmsdW+uuV/GixYiOXvc+PTbQmgW1Sl4UwzxqFj1CKG6u+QKy6JcEclqW+hLA7aitVgkOJch/taMhlJ7pze4dGiC9m5wn6Fzv+bU8XPyL6CEBsyFimApTRfHKkTgWzbbe8yyBMHaRsGT2N1/P2KQ+prgXWeBFWE2E2JfpbirWbf7d544dLqp8sILr8V4SVKFgsgUvqix8asghufacq3Em6LgP+/qZ9nFL/Ucfv6QjIar/lPFFeJLVukVfLtAPTJg8q/0bRR3Va740UynqrGTA1tAMAwrO2v0FQ4KC6ADAMj5KErICgnhw/S1asuGf3tZgOxRcT0EPYCGuutMhB52XEfKhopC45PCNWgvn+EoHNrrfE5I40YORwbfQNr82q//xSAVOnGu/DiBHifcb8aNXkbYD2NOT0oCegjhCaQqgsP7Qi1QN9zlBaPWqmIUjjSCMNzfi4L+iEblTqdCk5T1LYaVsY+3YK9/qBtORqO06wW+JaLT4y4bDtEaYaQnQ6VoZTTj5hlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(15650500001)(8936002)(316002)(5660300002)(66946007)(36756003)(4326008)(186003)(66556008)(26005)(66476007)(54906003)(6486002)(16526019)(52116002)(7696005)(83380400001)(8676002)(956004)(44832011)(107886003)(7416002)(1076003)(2616005)(38100700001)(86362001)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dDVwFc6ZzErNoM67RGhEASNe7rekNTFXjdzzfVqZoNXe1yLjA7Qs52CQeq29?=
 =?us-ascii?Q?5ADe8C65Oblw2YcEIQnaDWtSkiCUos+RIRFwYDneiBQK4ciTihqmzheYOXFu?=
 =?us-ascii?Q?sP7aSxyEsYBgfqK+OgjelWqI5qxvApZlAIUD0mEN6a4/fQFk/yEsgZHVUBZr?=
 =?us-ascii?Q?w7F4o2Smkip/4cC4/LFbrW8Oljfpsq5ZTc9hRoCpIgiZkwdgWp0FQwIVyrRh?=
 =?us-ascii?Q?D8SMANHctuYu8I15bWPdm5FgXSbYrJY9e1QdgWXnlSTQ5g/WbAlzT7/bJEul?=
 =?us-ascii?Q?NKaWOwmZvMXdF1Gtfb9qKlXQGbRuy/E/WnRcnR+PudHuJm07hXbkOa4yBpga?=
 =?us-ascii?Q?tNboVeGlcmZ6s9cLqI0Vb60epRT1oKpljDIoYonH1ePwKw5zumkxoSTBeZ6C?=
 =?us-ascii?Q?Cl//PYgXL4Ghex6lW2+fgjnDySAWXwJdQo8FwZld587E31cXuweXLdl34v/h?=
 =?us-ascii?Q?MFOswepzgeDHh5IC4RUDi5ssfSRA489sdZI+U/tc+8q03h3lIDARh9bvAZIo?=
 =?us-ascii?Q?wvOcrO0jfIVPKJ4n9UDvZzevO7ShClE6OmUII5CiT5QgL0+u1tI1ZEkFIYDV?=
 =?us-ascii?Q?sbCTZKux65PCQ7mJ3mYdSYSwe1PXgIjxjkPG9bBbRK8CVrWdDYWZibUqRl+H?=
 =?us-ascii?Q?u+sbYPSgk+/GHDBGpJg5cUdCB5hULq+nWB/TJDJw9pdyhqTgz41cBFrV313q?=
 =?us-ascii?Q?HsNKATpfIVl3Kj8hXqK5SQN3y4mRaE8FyRtbF1s9nBVpSH+aERMdJEYPp/vQ?=
 =?us-ascii?Q?hPclGxXRJ2xBnb9NZRYjdnrFrq+PLv16ximvQDpF0/SJx5CaWAk7Q5XLfoN0?=
 =?us-ascii?Q?r799C55MKPwii+hHAkdUUl0iscle0ridm54j2xfvY/ezjDPZbHSOFezRfof4?=
 =?us-ascii?Q?EHw7YAsQH4LOswrrOSChery6nbCrd5RBCTbqgwOBgc6LrqOtAQ1ANAJmutfh?=
 =?us-ascii?Q?agoBpHtQBwnYTLHUgn/VwhPLBlaIIduIbE9lKRwfm47nIEuwFPtkY/wVE8VB?=
 =?us-ascii?Q?TS+DKKrJmB/Ib/xSMjhDTeZMON8aMDvjRqN0bfHD0eTpeX7Ce3vADDnu6QjP?=
 =?us-ascii?Q?BUIwOXgrkn6BVmCTeEHMZa1uiXNaizffq6/tsCytZwSA/HaYIP1OTExivYzb?=
 =?us-ascii?Q?YSvqdsBTITA9gANrS+TdD5VS8ZgUezY59zKLPsQStlTseo+6gKTgchs/NfMt?=
 =?us-ascii?Q?7zHDthTym7B/h0ilLK/aC1Wfe0u5tYzGhzWJU+06hQGRMKekQFdGHNm5WkOT?=
 =?us-ascii?Q?uwOcHKLhz9LDMvRnz8J5rLBm0FATEjOk2IogobPyl/trKDgoEVEGGZgr6zm6?=
 =?us-ascii?Q?VqidZax1zrQi+fqvU51eOsnE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3585576b-7cb5-4aee-63f8-08d8eb284908
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:33.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbW4oi7HnF4+Y26Ag9XTqW4ZUqRjK1nMEr6TUdI3cQi8mdl72cHRp71sLzAyW3DQv+Z4JyRM32mWO9TBpjLNEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=943 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of remove_hugetlb_page(), there is no need for
update_and_free_page to hold the hugetlb lock.  Change all callers to
drop the lock before calling.

With additional code modifications, this will allow loops which decrease
the huge page pool to drop the hugetlb_lock with each page to reduce
long hold times.

The ugly unlock/lock cycle in free_pool_huge_page will be removed in
a subsequent patch which restructures free_pool_huge_page.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ae185d3315e0..3028cf10d504 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1362,14 +1362,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_writeback);
 	}
 	if (hstate_is_gigantic(h)) {
-		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
-		 */
-		spin_unlock(&hugetlb_lock);
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
-		spin_lock(&hugetlb_lock);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
@@ -1435,16 +1429,18 @@ static void __free_huge_page(struct page *page)
 
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
+		spin_unlock(&hugetlb_lock);
 	}
-	spin_unlock(&hugetlb_lock);
 }
 
 /*
@@ -1725,7 +1721,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 				list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
 			remove_hugetlb_page(h, page, acct_surplus);
+			/*
+			 * unlock/lock around update_and_free_page is temporary
+			 * and will be removed with subsequent patch.
+			 */
+			spin_unlock(&hugetlb_lock);
 			update_and_free_page(h, page);
+			spin_lock(&hugetlb_lock);
 			ret = 1;
 			break;
 		}
@@ -1794,8 +1796,9 @@ int dissolve_free_huge_page(struct page *page)
 		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, head);
-		rc = 0;
+		return 0;
 	}
 out:
 	spin_unlock(&hugetlb_lock);
@@ -2572,7 +2575,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 			remove_hugetlb_page(h, page, false);
 			h->free_huge_pages--;
 			h->free_huge_pages_node[page_to_nid(page)]--;
+			spin_unlock(&hugetlb_lock);
 			update_and_free_page(h, page);
+			spin_lock(&hugetlb_lock);
 
 			/*
 			 * update_and_free_page could have dropped lock so
-- 
2.30.2

