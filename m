Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9354B3428DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhCSWnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCSWnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMYWrg111010;
        Fri, 19 Mar 2021 22:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=F0xSyHo4sNncbJblqG4BraCgk5CJapCgb4Ww1gZK4J0=;
 b=vq2+76+mQW/EweTzuhNykmGsZM/SfiA3nJ202CXeDimecEKlYGd/t3lkV8ZzUqHIdNtN
 x2Al91fidpxUeyacCmHhetlwu/IX+is83T3i+GdKckHqqZwwu4dqSgreSdg4M7tRoi1Q
 xk6TT8MCiITxgBJAXDa8xzIUmwabnJQAsbVfPAhtirefpktTnoeDY3KOnCibZ2apMbZ7
 mWgQ9juEstY+CxdM3WJ7NOtAkLLx8+MwclQGnp3tltK8AyBo/KA871aAcl+6afM99KW8
 956fGVy3lAgm7DmFB8yefy9vAZGIZEwxYUoiMw9c65PoOANtxGf99S4dtDfBAUqOFWMi mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37a4em1cjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMer2x001735;
        Fri, 19 Mar 2021 22:42:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3796yxyng7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeJCAKWEhc9LNqR2YqpPRfoqXk4nSgL1rv0QsEUQQVGw89s5Ha0n8Mj/gAYE/ztSDqjE9kwbfAsw+m6s1d88aMDlREgYXx88bSKR1qUnQeU02KBCgokMuxI8q0ZN6oMNAmi+TFP3KybAz1zahKyvFgGzCnV9YEt+VJDOSpeJ7nLq0HMLK5Aph7NNqBlolVWiPbZKYtdm3/p/wgn62kx+k7lAWcwmGflmQ51BEBwjMt6PO96bI9Yi2+ZijXjOAsgdZgFd7Kr30B3HVcEccZpQVJYInzysg4/9YVX4//wYtXMTJHvmzveCEFoEmU/AfdLyeNmjDHsH7JEYV9RWVdZiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0xSyHo4sNncbJblqG4BraCgk5CJapCgb4Ww1gZK4J0=;
 b=dkp4dQlHQOaYuoYqIu58iZfMZZX0zodrXIfpsB4uz7bI7oHwRz2s0DgWNz163oZoOJQgro6zn8aly3Lz/GzDjqcL9MlZMJgyYE6ty5xA/YuTSoqTnHqgT3JgaEUwPL69VXQ0KZc2grw/JW8z+enm9LGbc2I3FsVSlmX1jdvwUEsNKhmR6g2/qlrGCE3dpmyyW0CmXqPIC9CIMn2oMHX6NugzLK28lqxg1wSr+Qi1/E3R5FNZAlFKGvVW/TsOI/Q9+uH4inGqp1+GMI5XbEdX3xfq207JyrWbnTOkqbhbSzUQAbNu+FLwBIby7lPntHfmR7cO9p9QgNaFEDDmlnVQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0xSyHo4sNncbJblqG4BraCgk5CJapCgb4Ww1gZK4J0=;
 b=qS9yi8xV46DnqMfmTKlkbG9q0+NCHugEdKA7V1Q1vfsYTqvWCyFdyvGweCdaGIGXPcoJeV0twDg3nLBq6QDb7Ucgf5cUROhY8f3u5M4cM9jE/nGh8qxfoSb9nwNwBdwF22dMfUf14yhb6EKN8GovzF90zaNFsS1wD8lAoMt8FwM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4211.namprd10.prod.outlook.com (2603:10b6:a03:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 22:42:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:39 +0000
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
Subject: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for irq context
Date:   Fri, 19 Mar 2021 15:42:08 -0700
Message-Id: <20210319224209.150047-8-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86e9ce0d-8429-42f3-a226-08d8eb284cd8
X-MS-TrafficTypeDiagnostic: BY5PR10MB4211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4211BB4987F1C6B48271AFDBE2689@BY5PR10MB4211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NbMZvWZ6mleUJLLiAZHKXBUsZO6uR9zN1adCGY7voG+qkJui/d1YPL47CTaArF7Gu2x1yvtlZxH3pn1hr/HgLZf8lEbb4Z+5gORhyIDs/CroV+3t8uFong5LxujUJQ5dTFiILQhCbycj2A6E8asu3zgYX0OCA7j27/Rf0plVWxo4Kg/x9uWCNnuVhfje+Go02dr2Be+fZQQZM7D/yLrd7Z5gmKhGQnaMdH7EmteYFIWlttVp+suuyIqYEo43A2alv60X20whDCsEdl/gIsryuHTEEPa4S08lFz+2bple43k9iQL0047amP8g+gCESe7y+3eBHyqLDlETqToInHtqzkuK0TAht2PToCxmNtceh0g0wN1uKFitaxnyZ6bUAqr0MSgLHSJ1FTN3mJDW3RDStZjBH2jBe4R4xWwBpO3UOo4oHUY9dzkf0kn1Tze55B6u2z/HCJo+gDgH2MMp8zk89Cw57iYlNxnC8Y6FNHOS0XuSozudEi1AXGEoCCWZNXSuROKQArb4OERQA8wZTeczmUoPkgUjKmcafLN0JnVYBK54kWPHXTiGBgxZRYDhK1R8pmgPrn3bJPX0qeIbsqFdm71AveSEuDs/6Qag+UWdGK5PUFiKB5eZUo8lKcwY4q7kSq3wdfGMiar7NFwYSmJ0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(66476007)(66946007)(36756003)(86362001)(6486002)(16526019)(6666004)(15650500001)(26005)(2616005)(83380400001)(107886003)(316002)(52116002)(7696005)(956004)(7416002)(2906002)(1076003)(66556008)(8676002)(186003)(4326008)(44832011)(54906003)(478600001)(5660300002)(38100700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4d/ZBaMLhga4T6+UOaZ1RJBf+5vWs3dfPVe8T0SAkuotfkt1LL6/xJlGHXj7?=
 =?us-ascii?Q?I589heTKaax+D6gY7O51nvt7rWmTQoDCMelmcVkC0rXXjul5Srb8gDdz+aMX?=
 =?us-ascii?Q?QmhTTADRp5bw79mOXn8Fv5EN3BZSMmuk1kSfpuhvmPycpgRvKKLyseBF/MJM?=
 =?us-ascii?Q?IbexDyjjKf58L5a7nQ82k+VJIX+WuBwTSCcPkGjylP+EV5Ta4Xnzc72h8FQc?=
 =?us-ascii?Q?sMFYPca15X9hBxjjGL2n6XMHB/eqKxhtQX9c6zDvsRZmljG3d+OWNt8A4Hcj?=
 =?us-ascii?Q?6NEKjVvA9+cBQ5RCHxxjNubaRXl+1BCNaRwELlcxcSiXqBDndpux12D1n460?=
 =?us-ascii?Q?hHiIOHwVAmSqpX5NWd7K0mVe1D/FpzCBcMpLcjW+jjpS4WmCodONYS/X6vlM?=
 =?us-ascii?Q?NSowajKlB8Im7IrsVG1OswZrl16Dqh8SdiyT6RRfXuL/Eb2h/bHRHL/O3cUd?=
 =?us-ascii?Q?dV0zvvavMGZpbtWvB2pbrrYNWCMRDD3TFW+8gS0l2GcLXHDd1yjSbgL3IB1y?=
 =?us-ascii?Q?0RrPwL28V7/mu6vLbWr1IWaPCB9/nHJRBr2KLTNzbqfITKasDvDGDDAjGpZX?=
 =?us-ascii?Q?KG9WYIvoY8vrAQ8xq2wRRG4lOIDZTrK1z0i+/xvZpf5K3rckp8KymzZsavLh?=
 =?us-ascii?Q?DYAhkWMHgVtLDJ7bevBAcxQnHwQHKFcqBzL381kuyWnXTBgnrPV2jNlD4XoB?=
 =?us-ascii?Q?syvtHqqJGL8R918r+TXtpofbNwesy5/0airk51G19mIvwzw9d9mF1HT91vWx?=
 =?us-ascii?Q?Z9IjP1/lTtWWLNWRXQDn4gTMwzAiDXIeAG4cu8b88eoR7lqoX0pAgtMJs2kl?=
 =?us-ascii?Q?CkHskZa0eWj4Qdjao+u65zNTFHlGSY5DXZqUxFWXVKvgiEMVDCO+NRTz6cGW?=
 =?us-ascii?Q?ZwiWnSrogIxw1Xju1OND3x12Jh3g7TEqy5SxnG8Chdax6Sc+rMjp2xEcy+Sp?=
 =?us-ascii?Q?0or5yv8zv3sM2RgLGPH1TFTDq3WjThEyvr/CqimXqQCrjr6EJqZLPiJJGRoq?=
 =?us-ascii?Q?EVVIOsYihzfnWm9Hw0pgs8sAe44TWnzsYgxh2htLkEFBBC1e2pm0EZZNTh4n?=
 =?us-ascii?Q?QZunD3UpoFlBst2H4GnZdGklFnwZ4yftnyBi6hI/m6rcIkcgKz+xjmFIq5fI?=
 =?us-ascii?Q?IRSW50maZWQy568l+xRkJ1tfsNBUVb7pWl+YeB+1gJW1Bm21AIXEAJ1/3POE?=
 =?us-ascii?Q?iwSbzrlB6bUyqsmG1XpcjWolo48Pz58kKUXsffGGGShzh5dHS9yIaMMwUT6+?=
 =?us-ascii?Q?AoTldzirmwu97FZWEa+dfADgaoUvoS0DCsXNkdVSuNdUPJN7dsehuT+CRseU?=
 =?us-ascii?Q?9wgEHC0rctDUkW+MCq16Nv4d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e9ce0d-8429-42f3-a226-08d8eb284cd8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:39.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma/QjEKl3iOtPvV3Uvig9zz7YBvanUi/SzN8WfsoJ1AGc3cqT/TOHRIAQqyYUvnOIsvJyom9iz/HhmlOsZwJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locks acquired in free_huge_page are irq safe.  However, in certain
circumstances the routine update_and_free_page could sleep.  Since
free_huge_page can be called from any context, it can not sleep.

Use a waitqueue to defer freeing of pages if the operation may sleep.  A
new routine update_and_free_page_no_sleep provides this functionality
and is only called from free_huge_page.

Note that any 'pages' sent to the workqueue for deferred freeing have
already been removed from the hugetlb subsystem.  What is actually
deferred is returning those base pages to the low level allocator.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 12 +++++-
 mm/hugetlb.c            | 86 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f42d44050548..a81ca39c06be 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -666,9 +666,14 @@ static inline unsigned huge_page_shift(struct hstate *h)
 	return h->order + PAGE_SHIFT;
 }
 
+static inline bool order_is_gigantic(unsigned int order)
+{
+	return order >= MAX_ORDER;
+}
+
 static inline bool hstate_is_gigantic(struct hstate *h)
 {
-	return huge_page_order(h) >= MAX_ORDER;
+	return order_is_gigantic(huge_page_order(h));
 }
 
 static inline unsigned int pages_per_huge_page(struct hstate *h)
@@ -942,6 +947,11 @@ static inline unsigned int huge_page_shift(struct hstate *h)
 	return PAGE_SHIFT;
 }
 
+static inline bool order_is_gigantic(unsigned int order)
+{
+	return false;
+}
+
 static inline bool hstate_is_gigantic(struct hstate *h)
 {
 	return false;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 82614bbe7bb9..b8304b290a73 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1351,7 +1351,60 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	h->nr_huge_pages_node[nid]--;
 }
 
-static void update_and_free_page(struct hstate *h, struct page *page)
+/*
+ * free_huge_page() can be called from any context.  However, the freeing
+ * of a hugetlb page can potentially sleep.  If freeing will sleep, defer
+ * the actual freeing to a workqueue to prevent sleeping in contexts where
+ * sleeping is not allowed.
+ *
+ * Use the page->mapping pointer as a llist_node structure for the lockless
+ * linked list of pages to be freeed.  free_hpage_workfn() locklessly
+ * retrieves the linked list of pages to be freed and frees them one-by-one.
+ *
+ * The page passed to __free_huge_page is technically not a hugetlb page, so
+ * we can not use interfaces such as page_hstate().
+ */
+static void __free_huge_page(struct page *page)
+{
+	unsigned int order = compound_order(page);
+
+	if (order_is_gigantic(order)) {
+		destroy_compound_gigantic_page(page, order);
+		free_gigantic_page(page, order);
+	} else {
+		__free_pages(page, order);
+	}
+}
+
+static LLIST_HEAD(hpage_freelist);
+
+static void free_hpage_workfn(struct work_struct *work)
+{
+	struct llist_node *node;
+	struct page *page;
+
+	node = llist_del_all(&hpage_freelist);
+
+	while (node) {
+		page = container_of((struct address_space **)node,
+				     struct page, mapping);
+		node = node->next;
+		__free_huge_page(page);
+	}
+}
+static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
+
+static bool free_page_may_sleep(struct hstate *h, struct page *page)
+{
+	/* freeing gigantic pages in CMA may sleep */
+	if (hstate_is_gigantic(h))
+		return true;
+
+	return false;
+}
+
+static void __update_and_free_page(struct hstate *h, struct page *page,
+								bool can_sleep)
 {
 	int i;
 	struct page *subpage = page;
@@ -1366,6 +1419,21 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
+
+	if (!can_sleep && free_page_may_sleep(h, page)) {
+		/*
+		 * Send page freeing to workqueue
+		 *
+		 * Only call schedule_work() if hpage_freelist is previously
+		 * empty. Otherwise, schedule_work() had been called but the
+		 * workfn hasn't retrieved the list yet.
+		 */
+		if (llist_add((struct llist_node *)&page->mapping,
+					&hpage_freelist))
+			schedule_work(&free_hpage_work);
+		return;
+	}
+
 	if (hstate_is_gigantic(h)) {
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
@@ -1374,6 +1442,18 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	}
 }
 
+static void update_and_free_page_no_sleep(struct hstate *h, struct page *page)
+{
+	/* can not sleep */
+	return __update_and_free_page(h, page, false);
+}
+
+static void update_and_free_page(struct hstate *h, struct page *page)
+{
+	/* can sleep */
+	return __update_and_free_page(h, page, true);
+}
+
 struct hstate *size_to_hstate(unsigned long size)
 {
 	struct hstate *h;
@@ -1436,12 +1516,12 @@ void free_huge_page(struct page *page)
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page);
+		update_and_free_page_no_sleep(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page);
+		update_and_free_page_no_sleep(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
-- 
2.30.2

