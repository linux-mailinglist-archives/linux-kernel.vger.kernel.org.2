Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B382335490F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhDEXCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:02:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39622 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhDEXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:02:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MxNOB023313;
        Mon, 5 Apr 2021 23:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=DwfHARgXSwAHwerjLcKAXizpQAo9ZwGoNO+AVwhn8b0=;
 b=rORKI4G07YuYotesOZYRWBOBZJQtFu6KxTbFKWlnlo2rtzQOoM+gaPehloDAIjRQ3tRp
 gpLAGnb9WpjWoWQyTVXI4O24Sm28r/qES40jWm3+mr3UI7KOjBz/JrhmDc5wdfKJWLHR
 6JLsC/V+PdEn3y1gd2lLJ0a3aA05uDHDDOB9COihiOAGUzKUz52LuH8tlXO0ejzA9nSK
 xT14kg4BD1J/DvwEL3L5JjK73HE97/YWy+wh9F8lkI3hTTsQRTxYyP+z3N0s/43fRq+2
 4nZzpPqHzYYDSy+u0EFigCM5D57plk0LFu+SqReamGkSef4Gf108vQ6dsBWzuQk29IKA LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37qfuxawxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MtBgp020405;
        Mon, 5 Apr 2021 23:01:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 37q2pwt153-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhBpqxRPLrMN/1hHAgNk4+CVotC8AI08GUpAzKbk+b5FKUiNU6hVdw6NZPKsX1w2YuEm6wAhRKp84dTu/5x28phnb8Ho4SaR0EbGakHo3uQBn2nFAX54jAr1gu4RmDCzfIzJzf0mwFvtkOWpsFSY5usR3tp8A3Id8AwT/ULGQMwIe1yFfLegMODMXmLTK0nnStxo7KgJeGkEx9V3pjjH718kruYe9Tb60sdFiVvCyT3lNXDs32eXUvYT8uRLlv8SX46+HrqbBKpN7vg0BXdzi+otpNLvQf9tzD1LoKjQOv41Y4hE7TQn9gQg6hZS7xt6Axzt+0AvxBEYRhTIKmzMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwfHARgXSwAHwerjLcKAXizpQAo9ZwGoNO+AVwhn8b0=;
 b=lrPYmxFu2uncFgrAe7KTdsj12UiVtVVoMbQp8XQLM+10g/jF6ofhCDi3Ldfxf+bSR3Y6KbnnHl0Re6foGp7ywar0m9fCks97PXtvwi0pMmm/KN8oK6KDeKxubJzbseLBku752ohfs5+4v7lNoHfVNde+OEjYNKbs23YpAiJFRN4F952SuGqYcs0OT/UoAI1Tlz5/OY6HodEW0Bui3NK9ik2YYJQeLLyKRQs/isaTGDwt0fqxGDMWAEXMBIEe9/o86/iT6PHhP/77hEV7v6/ncw1QvqyxF9wDv5ZB7i/WLS46yxlKROSGTSUjfY1nkLiadptKKaRBUNu7BhaxkuTH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwfHARgXSwAHwerjLcKAXizpQAo9ZwGoNO+AVwhn8b0=;
 b=fKuKpGmspksTJbJj/2JzKA4J93xhGTpnGxCOvFATRW+9W9EPs/+AYD4BQimt4zG+/8b6k+PnU6tIxI4jRl37Qd0Z0IWtoW22PWTp48agGVrPyAUMrHNvNWi08Z0L2LDzko4LRdCVgONg7C+NrFcK1YOf2WcE36af9hBqKmsNCDw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 23:01:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:34 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 5/8] hugetlb: call update_and_free_page without hugetlb_lock
Date:   Mon,  5 Apr 2021 16:00:40 -0700
Message-Id: <20210405230043.182734-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210405230043.182734-1-mike.kravetz@oracle.com>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f674453-a4a5-49f9-46d9-08d8f886c247
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3544A7C07BF077B393C29E85E2779@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkA8iodh7P7PReh9uFyaMFdEh7ymioOXi1V1UeU2HgTD8u9Tg2XFQZL9V3sDXrByRaDdVmZy4jQ3GHq5bSgAvoQA5AYNWkpe2sjJQIztTihFdFHF2NNxrwJWQZLtzd0Pqvc76rPQzCQH2RpVaxmRS9uOS5T8TzNFuM3xCGclBTr6+Os7C1q+vph1Mn2KKCeuMofG26xjWis6mdCGo9oVgvTL8yNEW5MAIddIJ2RwWTKKwBMUehJp/1pKhaPddBVF1SwHE1CZeRNtQ8gv0hhVh+CFsn2tpDrDdqVqCksOvkz+dh5a3+9T5cAnHeGB4NxvoGHWRXUximefcT/eWXYL6LqONi3uydko8LJGO0muTnynB1CMNVaLobYzJYz5dQ1H8FNT5I32sNcwwHzBaHrhkRCAf3ZySAhoTjrAuG0V+AnLmwGLEgIpRpYhXXHdVcC9PNSwccSneL6LIDV9e3uwy7aCKFfvxpC6OXptahuivTJienpoqW7TEEOCmyQmfYUbee3h/TO2sGekp9TmP+Fth0/rVh2/P56p3yyCAUYlEfAMyEOSUBykGFWeXwbz+AEpW/s9n6a8SbFhGUlKN/Lv+l7V1LYNOax/7OtZavhViU343SQXydPEeXRo1r71DbuUt9sz5uZJIyX//Ggc/VLPiJmg1n26dwiU6QiYBdYJ2l/ELwtL5GytYGQWmaRIcobi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(44832011)(66476007)(5660300002)(107886003)(8676002)(86362001)(26005)(6486002)(66946007)(16526019)(38350700001)(1076003)(2906002)(54906003)(83380400001)(4326008)(52116002)(7696005)(186003)(7416002)(478600001)(38100700001)(8936002)(36756003)(316002)(66556008)(6666004)(15650500001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VeTCCU7ovjHaq/kk9EC33W1q4zbsDTL7ceNRmVNFUQEcj9yHF+6VQ8JxNfxy?=
 =?us-ascii?Q?7hDE0WkEXTCbcr0H4EdY0fmp2NQq90RQIC7WI2YsB7Cu4NOnypWjyAYWMwoZ?=
 =?us-ascii?Q?ZRL/OA9CNUJO/JorQyYaUMjbeJCHXzhr547EHU09kjxPqhmy5w4GjVBR+R9V?=
 =?us-ascii?Q?4uhusO1u9keyseyrvLHY4dSp/yX/uJ4dgCTHy4ROrcTaFsk58x+lzWPdGu+u?=
 =?us-ascii?Q?STP3u7yTF8XkrFYlYwMOWuaunAcNMUGjFM8xCOmX4sK7og+aQSzt3JssDd3x?=
 =?us-ascii?Q?hzIEo41UeAs4ww1WsSzEP6dhA66kAlI8w66FZnVh6RElHKTr7c2RcBShtnlV?=
 =?us-ascii?Q?MiYhs/6GhiaXV1vXT9OIuJ+hW4/ZTJ8fOo+ZEMdoHG0Cn6I2ATFTHTK5QnRB?=
 =?us-ascii?Q?4Y08VJLzepc6Hq/CCtdSrOTMeMU8m4cs96QoylW7XNaYnEwQLWEM3kWtu2Mt?=
 =?us-ascii?Q?g1GFatg4HEVEdkAzuzN00uptTmsqxuPSo9L7naJ5QpKbT9oNqnTh6a5sXttb?=
 =?us-ascii?Q?12MD06sga4ErReyumB/EpiEahUY7Lu1J9imPuQGFuOd6Q1/Q3KxjXdoJU6gc?=
 =?us-ascii?Q?XAwH0ykLJ69xdyQ3FB33AQdpKBWc1ZOpIIXVMqyvIRJi1jRGh8l6WCV/MQH7?=
 =?us-ascii?Q?giS+h+lX/3nG22KqjdnAPy9Bf5mjqk3zqQBLPWF/xI3I4Hd6QDe3ie7aaOr/?=
 =?us-ascii?Q?8eYR+dK9+g+BK0upvA8kVizuBYl2eGc8gHTtYRjGuqdP3SXlnIvIWRV/Tsc2?=
 =?us-ascii?Q?ttpBmM14eQW1BjhwVK+0kezc+9bI+H79hmeEbbcvHeR0Ec/eDLS3sSr9E7DH?=
 =?us-ascii?Q?+98RkeXURUZWiePcHTZ92jRz2ppkMfYi7s+fpriLgoAt+YHrzYk07Mov35Gc?=
 =?us-ascii?Q?CKPJ5DqInp7HiNm5d38sHiT2HE78gMR7fmDSrR9KjA9H1PUw5pNdQzN6e6oq?=
 =?us-ascii?Q?3APOoB1ML4P1NLSQfa8r0+mJM1Ra4WvfOXv0N82STh35O+AfjnwPA7ZCZPq3?=
 =?us-ascii?Q?VNP2L91/QnCZ5H085n24SVhWLyozxItoG9BgVjN8Uw1buoZx3pcxYnamEAmh?=
 =?us-ascii?Q?VUNYRfLDVPdT+Mu1WNgN/bFXKoi8us4HbpjsKLtsSBRNrR3UL9FNAOA72PB0?=
 =?us-ascii?Q?Ow+1J5p7CVKpsyEqgX6u0ORYUuBgUoXLlIJ+NofkjUs0bj6Z61YtYX+ZffK3?=
 =?us-ascii?Q?HdyiV98nNu8ft2lAoC+8elxJQGxd4nuBw3Q6oSVE8oG5cmME7TLqEjefqSuk?=
 =?us-ascii?Q?32Rt0lQ9x9CHTcQfVwAjNxSGG2zaOg1cPeN5Q9y19B+Acm5XlXU1ZoWlX6mC?=
 =?us-ascii?Q?X+HmscUgsseUnA+oZ7wwTvDT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f674453-a4a5-49f9-46d9-08d8f886c247
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:34.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zwcPbDvRRqRUUtS3hzQthed+mfjIKyCR1nQHZLv1+yNjecPrkIqq33R5Jg8b+s2+JjESgowQTkdQl/1fl8vsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: Wqg87V0OSoN5nvBJGKl9UfO9QoHEKc-i
X-Proofpoint-ORIG-GUID: Wqg87V0OSoN5nvBJGKl9UfO9QoHEKc-i
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
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
 mm/hugetlb.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index df2a3d1f632b..be6031a8e2a9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1446,16 +1446,18 @@ static void __free_huge_page(struct page *page)
 
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
@@ -1736,7 +1738,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1805,8 +1813,9 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -2291,6 +2300,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
 	struct page *new_page;
+	struct page *page_to_free;
 	int ret = 0;
 
 	/*
@@ -2313,16 +2323,16 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Freed from under us. Drop new_page too.
 		 */
 		remove_hugetlb_page(h, new_page, false);
-		update_and_free_page(h, new_page);
-		goto unlock;
+		page_to_free = new_page;
+		goto unlock_free;
 	} else if (page_count(old_page)) {
 		/*
 		 * Someone has grabbed the page, try to isolate it here.
 		 * Fail with -EBUSY if not possible.
 		 */
 		remove_hugetlb_page(h, new_page, false);
-		update_and_free_page(h, new_page);
 		spin_unlock(&hugetlb_lock);
+		update_and_free_page(h, new_page);
 		if (!isolate_huge_page(old_page, list))
 			ret = -EBUSY;
 		return ret;
@@ -2344,11 +2354,12 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * enqueue_huge_page for new page.  Net result is no change.
 		 */
 		remove_hugetlb_page(h, old_page, false);
-		update_and_free_page(h, old_page);
 		enqueue_huge_page(h, new_page);
+		page_to_free = old_page;
 	}
-unlock:
+unlock_free:
 	spin_unlock(&hugetlb_lock);
+	update_and_free_page(h, page_to_free);
 
 	return ret;
 }
@@ -2671,22 +2682,34 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
+	struct page *page, *next;
+	LIST_HEAD(page_list);
 
 	if (hstate_is_gigantic(h))
 		return;
 
+	/*
+	 * Collect pages to be freed on a list, and free after dropping lock
+	 */
 	for_each_node_mask(i, *nodes_allowed) {
-		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
-				return;
+				goto out;
 			if (PageHighMem(page))
 				continue;
 			remove_hugetlb_page(h, page, false);
-			update_and_free_page(h, page);
+			list_add(&page->lru, &page_list);
 		}
 	}
+
+out:
+	spin_unlock(&hugetlb_lock);
+	list_for_each_entry_safe(page, next, &page_list, lru) {
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+	spin_lock(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
-- 
2.30.2

