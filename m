Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294B34F798
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhCaDnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34776 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhCaDm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3djBt182236;
        Wed, 31 Mar 2021 03:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=3zU4pl1Ot5Tu7Z4gSP5dVU2b4RXriobkHAZmtAsLDMQ=;
 b=vizjcvO8D8nyXVyxU/CrC3XooIOEccHVw7ffHrfWPhfZSMXVRXbQSoqVQjsczQbXvHQP
 AAorSwJ/yUBwEMtF0v+1QCpf2hFk++ndZfhT/26TuhImW7S0VU7/B54WhgYIWcq9PtnG
 +vVlPvWhAn5hKTCE3n7GFFg4Dg5vU94HvCz9vdQd87azhALD6LAtBPAW+tSiUiZ5Gq8g
 3qx/UC4RuZd3exSA7roYwfcmMY23vyxrXK6L8Ggg1tuANwSgSMMHTdfOl+nH7ZZDR3X9
 Ff6CgZTpbSBjKQ/++gGedhEtjaurfDWyWpPi3dAyxD/9TMvRGwT9trbU3VqbYXbOM/5Q 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37mabqrsak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3fWW9086160;
        Wed, 31 Mar 2021 03:42:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 37mabkmmnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P77tQ2L9dW0HKxGZLKPI/8zWTLMKzKq088Nk+paVquZ3za7IerKrtslTmVE84oBdfDtoQbxKc2nenOkHpvEL4KN6ZFH2OlQwfzM6CXsYtw+rt1tk9HZW4r00kq9ivt51DA6qF7+70hjtfQMTbwaUwZDdDTbB3xImw1dsSy1uOJYB2qh6J8G9VWXQwhRYbBDMhIw+XdVC9ekgDW3jBsyR7ppKfapAs23oHUqUa3KisE7kljAlg+NqQymB1ZbckCCVX7PEABIcWb2mvWwCcHaEY1SDj7ozyyaA4a3kmNbzJIGx25ggG4+j9LPRlVaEwjaU4U/RUi/RTZJIUHeCWUdenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zU4pl1Ot5Tu7Z4gSP5dVU2b4RXriobkHAZmtAsLDMQ=;
 b=nqFdXlmsmbql8RC2wK5o0vUY3hcl2DEJ1fiuG5jm/x+7xNXo7r2lDLK/wZtwp+NZuAk8BDmRNHOxOVYEPDLqGNUvVJPOb92m53YdFO/T0konHx2EH87fM3obVKPAk3eXEkcripN1xERLZQSkVjpvwbVOc7/dvs6KTZEk4aRyZSqrJf6fkEHB+Z4iG7aTaWrHlhMZQoftYZw/yAAOo4pu92H0xfzegBKyIMOfFMpVFCtoBO/UQOAxPcJqgRjnvdlmjGYp6OxwFOmrsD5xGfAd+nESQMm0ZNiCyBtE19f+ADuzVNUI9PZiFzY1i7l432gbWxDvXs/FfdhXNVCt4z8hKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zU4pl1Ot5Tu7Z4gSP5dVU2b4RXriobkHAZmtAsLDMQ=;
 b=MGSdQcYFCNskqUwA93cqN9iWOB5xQEkv5E9zLZ3hmzVaicdhmuS5MGXHjrUqn+sHmD3z3YoglYGhiMra3fSxeDLj17y7FVt1Hf9oiavc5ojL8WJ9Gs9j0BLASLKprHUeURqQyYmsB6wrq5vdySdb1O5zWq5FAvK14R3z8Mv4r7k=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:12 +0000
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
Subject: [PATCH v3 6/8] hugetlb: change free_pool_huge_page to remove_pool_huge_page
Date:   Tue, 30 Mar 2021 20:41:46 -0700
Message-Id: <20210331034148.112624-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331034148.112624-1-mike.kravetz@oracle.com>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fdfa20c-5981-42d7-04da-08d8f3f6f824
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4462D4DE2DE72573269D57B7E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sq3IXW/1nvk0uB6YiQO9528sUFK+HYm15lnA7fe3SFMw1tVQG98oXBe5oWyqUyQRi+PTuz2c0+7l7b+xPHPvqczCWZH74jd18IFq9JWN+eEHOKRAGW8b2qeDSmrDs9JodFwoqtoUjSfX9tHeGjTP0HYfi/BLewqxbTesWKBZeO7V9M7/ncX2xi72isjETl1lWtYfJhavSTn5GQlcIY2DKARy1vPBDOd7r8Be9cUeQU/PhChQo5hzGO4W2Q8LJ0ujajAmpoWOWwo0piH+d4KzQXTjqakiWoV8pz6La1KMvsjdHkBbdLlTblwvkhDx2brnJPar9eKXAg15Xfn9PF5e29FM7NGfx63ndvlyVVuvO6F1NuSO8sUMVYE8xs8l4WyM0EurMB/i5GuXrvg8m36XxwpIy26eKR+KImmDhRCKYg6kK9gGmvaZI17yUYdg4obNk5kZ2dFt/z6w+U/bzbwL+3MnKSoK4PI1p92KkCOhUtK01esnd1wHUYX/G7ftZcgx1OHCQo6TFWMR6ydwjt3yO7+/FDx4NBvOX4nA1JFZAygbllK32/Cvhv3yQOfUtNHokEB5cGAtai556MoigttEPzuyj41XbQOeGcnzkvxqRQeUyB9WiWI7O/ePzr7/MtBoMBiWHR5WcnhrJSYelzQdS+lDlOPKGxvNM4Bmc+uh/Js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(8676002)(1076003)(8936002)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0cgKrcdNlfpi5EfITp/UnAi8S0BmYEDo2fkee9xEvT5bHDO/N2CKx3VYYdNb?=
 =?us-ascii?Q?vY2eHxDdyP6HuR8UjbvF2raMbRWPI4TPKomfCv49B1skbU/N7oQeJ8mZdXg2?=
 =?us-ascii?Q?WW24GjyXhFnK2w7ZlyMgMhwRFcwGnQZZHZPc714dMEDHleYlHiGwC+1GRQFe?=
 =?us-ascii?Q?z2nop9KJfH/VpwuUzf3m0N3TxRDPrnUvI9PJlgUkjK9YQbBKGwlcajVF9CA8?=
 =?us-ascii?Q?IabH9T+f89h1/pVyJeyboo6bmd/RFZf6Zr7Ro4aHV3Htl0Uo3pAIimqcRFX+?=
 =?us-ascii?Q?6NtBaXo8LC8ZorH/VBcBvmyF/HKGU67gQ/fcqmDcxIrAlbTkIe3gJlCc5AH0?=
 =?us-ascii?Q?U7Rr1ye4LicfgTFzio8SbkVDhj0KmkUcj4GeCMbAvA04cEVbZok+eAywqT0Q?=
 =?us-ascii?Q?eoupnmB+Xh7VSolbXWeuZ7kV04iwbEPRpKsSAd2nCRxIjlVzaUACZefmcCnu?=
 =?us-ascii?Q?/UTvBiO9W2D7bq1frdM9jF6emrCQfnm1zEJWph0tohqyp6qCmkAT9IIpeq9J?=
 =?us-ascii?Q?Wc5s+Rs1bD6PzYXeTpolilGh9CnvotTWgvhgZtGtq7v9uX/Siq50rgWNIHh8?=
 =?us-ascii?Q?kzLXyIrWln2ZsR/05e9MJnwtAgblF0QiIZWfY1ML2DziM45UyLEkuBo3NYVQ?=
 =?us-ascii?Q?Vbs8U+99PlXMwkcfLqR0trAJmd7q73PShAr1HF6Qfp/2amCFIm/FFuiIbWOe?=
 =?us-ascii?Q?h9h6mQuFEuvJa23A434lTPu0px38AK7OTBtNS0BY7XdwYmyXyrMXQ1NDS8JW?=
 =?us-ascii?Q?TAdVFIATgTmtG0mUo6DJWUhGgYSmaxn+BOKaWiQLbG56A1VcLR36fCCB55UX?=
 =?us-ascii?Q?W7OLp7eXfKzWsa48tgPz1fNRREUL1pV0YUyE7sjAUtOBMOnpA0IPJ0UilzsR?=
 =?us-ascii?Q?ngeO6KvqeRW7hVzIES5gy/UYrqe6s8Qfe1+vwqubPTA/G7CQXv4VVTroW+tY?=
 =?us-ascii?Q?fgMT6lQHpQySxtxR+mdyUz5cJ+Ihn05rX30OQxRevSO/ipzZ57oVFsrtZcrb?=
 =?us-ascii?Q?u8zkLNrbfFcpJD+96iFj9K5tATShqR/1JBTb8lb04Xavk9R1EqpvQmvRPUIS?=
 =?us-ascii?Q?pWjAadNeW+45KEorhSbeZU2kmHkATyo/9DzitddeUyeQGjQtoevp/9ae3qFm?=
 =?us-ascii?Q?KTlCpQ1hUsbG1Sjqj7gbfpDl9Zlj31lGyzcNugb5vUO/X7gMsg1kaWjsao1y?=
 =?us-ascii?Q?10w1m8cKFmUiyJHQEhFJ7FhtOqVHDx4VGbQzwcdu7pqXyrVmPD5j+iKLIPAt?=
 =?us-ascii?Q?wqOohjaHxviSObQGnfhb8XPpMWkffJWo3x8BkPfYq9CsQLqHabvcSQSGPsS5?=
 =?us-ascii?Q?YgvuzoWbSvTzcC7D0QN+KSeV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdfa20c-5981-42d7-04da-08d8f3f6f824
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:12.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3jaLkYkARpnXIZL/GwssQh30x3b2/TzMs89eWxh8ZHA5mmc8t5UpZL9GyIVoqbcNwf2PoX6VVw8w2g92F7aFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: 65sAj6JnM0nd5t9K7AD8PJdW5a-0QTfb
X-Proofpoint-GUID: 65sAj6JnM0nd5t9K7AD8PJdW5a-0QTfb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pool_huge_page was called with hugetlb_lock held.  It would remove
a hugetlb page, and then free the corresponding pages to the lower level
allocators such as buddy.  free_pool_huge_page was called in a loop to
remove hugetlb pages and these loops could hold the hugetlb_lock for a
considerable time.

Create new routine remove_pool_huge_page to replace free_pool_huge_page.
remove_pool_huge_page will remove the hugetlb page, and it must be
called with the hugetlb_lock held.  It will return the removed page and
it is the responsibility of the caller to free the page to the lower
level allocators.  The hugetlb_lock is dropped before freeing to these
allocators which results in shorter lock hold times.

Add new helper routine to call update_and_free_page for a list of pages.

Note: Some changes to the routine return_unused_surplus_pages are in
need of explanation.  Commit e5bbc8a6c992 ("mm/hugetlb.c: fix reservation
race when freeing surplus pages") modified this routine to address a
race which could occur when dropping the hugetlb_lock in the loop that
removes pool pages.  Accounting changes introduced in that commit were
subtle and took some thought to understand.  This commit removes the
cond_resched_lock() and the potential race.  Therefore, remove the
subtle code and restore the more straight forward accounting effectively
reverting the commit.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/hugetlb.c | 93 ++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac4be941a3e5..5b2ca4663d7f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1209,7 +1209,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for free_pool_huge_page() - return the previously saved
+ * helper for remove_pool_huge_page() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -1391,6 +1391,16 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	}
 }
 
+static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+{
+	struct page *page, *t_page;
+
+	list_for_each_entry_safe(page, t_page, list, lru) {
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+}
+
 struct hstate *size_to_hstate(unsigned long size)
 {
 	struct hstate *h;
@@ -1721,16 +1731,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 }
 
 /*
- * Free huge page from pool from next node to free.
- * Attempt to keep persistent huge pages more or less
- * balanced over allowed nodes.
+ * Remove huge page from pool from next node to free.  Attempt to keep
+ * persistent huge pages more or less balanced over allowed nodes.
+ * This routine only 'removes' the hugetlb page.  The caller must make
+ * an additional call to free the page to low level allocators.
  * Called with hugetlb_lock locked.
  */
-static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-							 bool acct_surplus)
+static struct page *remove_pool_huge_page(struct hstate *h,
+						nodemask_t *nodes_allowed,
+						 bool acct_surplus)
 {
 	int nr_nodes, node;
-	int ret = 0;
+	struct page *page = NULL;
 
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		/*
@@ -1739,23 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 		 */
 		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
 		    !list_empty(&h->hugepage_freelists[node])) {
-			struct page *page =
-				list_entry(h->hugepage_freelists[node].next,
+			page = list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
 			remove_hugetlb_page(h, page, acct_surplus);
-			/*
-			 * unlock/lock around update_and_free_page is temporary
-			 * and will be removed with subsequent patch.
-			 */
-			spin_unlock(&hugetlb_lock);
-			update_and_free_page(h, page);
-			spin_lock(&hugetlb_lock);
-			ret = 1;
 			break;
 		}
 	}
 
-	return ret;
+	return page;
 }
 
 /*
@@ -2075,17 +2078,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
  *    to the associated reservation map.
  * 2) Free any unused surplus pages that may have been allocated to satisfy
  *    the reservation.  As many as unused_resv_pages may be freed.
- *
- * Called with hugetlb_lock held.  However, the lock could be dropped (and
- * reacquired) during calls to cond_resched_lock.  Whenever dropping the lock,
- * we must make sure nobody else can claim pages we are in the process of
- * freeing.  Do this by ensuring resv_huge_page always is greater than the
- * number of huge pages we plan to free when dropping the lock.
  */
 static void return_unused_surplus_pages(struct hstate *h,
 					unsigned long unused_resv_pages)
 {
 	unsigned long nr_pages;
+	struct page *page;
+	LIST_HEAD(page_list);
+
+	/* Uncommit the reservation */
+	h->resv_huge_pages -= unused_resv_pages;
 
 	/* Cannot return gigantic pages currently */
 	if (hstate_is_gigantic(h))
@@ -2102,24 +2104,21 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * evenly across all nodes with memory. Iterate across these nodes
 	 * until we can no longer free unreserved surplus pages. This occurs
 	 * when the nodes with surplus pages have no free pages.
-	 * free_pool_huge_page() will balance the freed pages across the
+	 * remove_pool_huge_page() will balance the freed pages across the
 	 * on-line nodes with memory and will handle the hstate accounting.
-	 *
-	 * Note that we decrement resv_huge_pages as we free the pages.  If
-	 * we drop the lock, resv_huge_pages will still be sufficiently large
-	 * to cover subsequent pages we may free.
 	 */
 	while (nr_pages--) {
-		h->resv_huge_pages--;
-		unused_resv_pages--;
-		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
+		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
+		if (!page)
 			goto out;
-		cond_resched_lock(&hugetlb_lock);
+
+		list_add(&page->lru, &page_list);
 	}
 
 out:
-	/* Fully uncommit the reservation */
-	h->resv_huge_pages -= unused_resv_pages;
+	spin_unlock(&hugetlb_lock);
+	update_and_free_pages_bulk(h, &page_list);
+	spin_lock(&hugetlb_lock);
 }
 
 
@@ -2683,7 +2682,6 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
-	struct page *page, *next;
 	LIST_HEAD(page_list);
 
 	if (hstate_is_gigantic(h))
@@ -2693,6 +2691,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 * Collect pages to be freed on a list, and free after dropping lock
 	 */
 	for_each_node_mask(i, *nodes_allowed) {
+		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
@@ -2706,10 +2705,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 
 out:
 	spin_unlock(&hugetlb_lock);
-	list_for_each_entry_safe(page, next, &page_list, lru) {
-		update_and_free_page(h, page);
-		cond_resched();
-	}
+	update_and_free_pages_bulk(h, &page_list);
 	spin_lock(&hugetlb_lock);
 }
 #else
@@ -2756,6 +2752,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
+	struct page *page;
+	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2868,11 +2866,22 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
 	min_count = max(count, min_count);
 	try_to_free_low(h, min_count, nodes_allowed);
+
+	/*
+	 * Collect pages to be removed on list without dropping lock
+	 */
 	while (min_count < persistent_huge_pages(h)) {
-		if (!free_pool_huge_page(h, nodes_allowed, 0))
+		page = remove_pool_huge_page(h, nodes_allowed, 0);
+		if (!page)
 			break;
-		cond_resched_lock(&hugetlb_lock);
+
+		list_add(&page->lru, &page_list);
 	}
+	/* free the pages after dropping lock */
+	spin_unlock(&hugetlb_lock);
+	update_and_free_pages_bulk(h, &page_list);
+	spin_lock(&hugetlb_lock);
+
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
 			break;
-- 
2.30.2

