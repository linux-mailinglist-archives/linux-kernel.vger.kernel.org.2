Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29D34DC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhC2XZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhC2XZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNJ2Sf085899;
        Mon, 29 Mar 2021 23:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=E/j0flEP1Kls1T1q7bRm7gBdK+p9PElm2UJyBCVFWLo=;
 b=hR63QKOhCCwUpabDn0c3eS+7ZDti1CR5gwiQkd1qYszfDimmbs/faAOjTJ0cGl6VemRC
 zXJ9sFlcBfVDBq0nfDJic+iHZWZ+nE/Fj+5ckrp1cpIVLsH1SjMAkz/QhLqp3JnAOom5
 SQjK7PUpoHWmlzTf7ajDAuuZo8V0MpDLxFVJYzUSIzLect3RKnI8XLhCNswwxB+GOVKo
 cYUxH4Qaelo0mVOMtvIeXT9zE49jT4gxHh7ZjMnlsLXT2eY6gRzZ3WtD/0J6sfBtS0uj
 1dqik+t7tF59jYDF/f2OLShN3jRiaxAn+b5G3co371WpyAKmo0GYYko9Xa4+D35XEYI9 yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37hv4r57u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNEmsa088346;
        Mon, 29 Mar 2021 23:24:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3020.oracle.com with ESMTP id 37jekxsrdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oiat5dNdLSp1+mudpzLWxA6z3knUeKZeDL185CPCjFIE6X92yDWjISmtVtPyRTx3n7YYYXcOsnKip8rs34ACvmkPQblTSZJfRJZU9w1qwqnwTtnON5Hpi+BXEok2D/JUSoSEE6uCOrILcGe73Np4ISRjqdtqFS2rUw0I/OQB73ekUOw+JqSiPr8//KUqtQI+/2SfQx4hYlePK6GT6zJUVkgBLSZiNpwGn7m7RErBkklt52SpuYriW8g1x6LsCtAhOjJwgbfWc4QFQz3dkNPuWYjHrXYXqG9pUMn7VM1YbspNfy1KrHUpeHGgXm9twBLT+JCjKFxYEA5+9+F3TV22Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/j0flEP1Kls1T1q7bRm7gBdK+p9PElm2UJyBCVFWLo=;
 b=SbfSe50A7joxsl4maGLrJCyfknEQfYCLue7DNUw9h8T5rU0OF42eTSxwi2btuiSWKR8B3mFejKU46jE0JgwIVWFvy6OqDQLiZfmXL1UzxBj1QLzkApvPN5yBmuXacNJtOuMc9rEqrnzTaQPcM9Xhbs2DP7fJuyxzR8R7VWHozI5hqufwFpH4FuaSMvIwd1zqg1wpFQeZNpLa1q8USXAhMYccH37+U6+UC6lXdtAREa27LO72KPT581XpBq+78RxUkBf9ojtSykqKhdkRMoGEqy7omPn3pC3v1qFDjX572+HfiKasWelkL5W3Z76jJBH3x5tzP0XhseDb4YtJKKvc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/j0flEP1Kls1T1q7bRm7gBdK+p9PElm2UJyBCVFWLo=;
 b=fZ70yb9EjVyvQBRODWRhhFf1IzBxcsc2sWsaOV5D7x/4mf7nTAPglwWk/MofwwXNPhKPWnyPNRX3Mrmdt3kgxplqHJOIV272VKV9lNWtPslIWqrr4N42vu2c+4bhuji06mKCA2gTDr50FFkX/8RmltNm0K6pQ3eWExzkyHsDIuA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3301.namprd10.prod.outlook.com (2603:10b6:a03:14d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 23:24:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:34 +0000
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
Subject: [PATCH v2 8/8] hugetlb: add lockdep_assert_held() calls for hugetlb_lock
Date:   Mon, 29 Mar 2021 16:24:02 -0700
Message-Id: <20210329232402.575396-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329232402.575396-1-mike.kravetz@oracle.com>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bc9152e-0d75-4876-bf06-08d8f309cfde
X-MS-TrafficTypeDiagnostic: BYAPR10MB3301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB33017DE6133ED16892D7DC5BE27E9@BYAPR10MB3301.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdBKnjt5MoTwlTrUn1pcaOZJzSB41pq7HIKWCMj7ujV7b4sg2TVa4ccRrzkDnzr+pVIBN+skoroWWp8eR34LTyTy6ZBbbP5amgbalbC5TbBEbPKq6yatc7lAZPaegbkH5n8ehqXwYQA1O1Knh+xuBM4H5dfE4skuI8oIIIOi22PAnU8ul9A8dxuoFVyjnhbToB2iDI27lQyIxDIkI8tJD8fMBT8KMj9MP4U7WAZGWrhnmmLrP7L7gS3I9l5USImDi7X0Qi58fZ//HqV5TY87W1Wo5ZgfKgCburryEtC+/CtN6XY5qYUf04ta3Qcmi3Lq9aWZZOOlHezZsQpYmnOGnip6NhffcnDmyUFYl80/myoR9EcTJt4PmmYzYd8WonK++fIeCMhUg1ZeblgKy6FSFaUFCeUDDh5IhbiP+N0aaM4hBA1+4MkDDmGcPRut7nLbQVwKK4l3raHO1PpDRpHzxRrHul+6zuYqlCzPJd8MXJUbnwReC4rzjNRRP0dm4279r/eCTdnkB60+CPy6xvuQs0Nhnl8nGNZJL7NE25sBx0CPebrUvNvHbRPuX4S+lJovmLl2l3SDqTsxhT7RTT3Kn7O7aRZolpk2sizyLJr9nNP0Mlsk/MANRzXqo4itKp3xRkbLnQNCwTP6yKZAkBxm8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(136003)(346002)(396003)(316002)(5660300002)(8936002)(54906003)(66556008)(6666004)(6486002)(956004)(107886003)(4326008)(16526019)(2616005)(186003)(1076003)(7416002)(86362001)(38100700001)(66946007)(66476007)(26005)(478600001)(83380400001)(8676002)(44832011)(36756003)(52116002)(2906002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2qxPvR8aNKQH2JoHjuA/+8Q4KoPjBK2P102AfMqucJRgPLTm5BSvrLvf3R2G?=
 =?us-ascii?Q?pmWwk4q/Ohnxb4qLj/jwb0SEv0eW8Q8sg6AHn8zFE2Bp3DpR8mDYEtNtEb2L?=
 =?us-ascii?Q?tAaNaERDeXCv6gDGC9YL9YB4HSvRGWCEvvr94abMgpkNjhS4jmmZ8SVAQ7Wu?=
 =?us-ascii?Q?IoyM1SKqNqSZS60v5r+3YDOeeb0z1WJM2YAC4SGOd0Ly0JUy52XT+WUNbfVa?=
 =?us-ascii?Q?pzZb4Pvu53LGbGosGaa0LCdUqylSASl3M60bX7cuw4Wpox5JescR2wWNGBrE?=
 =?us-ascii?Q?H/o4QCiGenL3UVA0k/ScvV4mBfsIlgohr51axGfcgZiE2IwLFLK2ulUQwgms?=
 =?us-ascii?Q?kyDOFroE9HlpuH2CmYwlON5RvLFTTSKBBTmuiqOWrb7LdvGK1gbRPwlcFkyp?=
 =?us-ascii?Q?XM6kSV68nVDmlrN4+FOpRz2GvwNiKVFMislu7MT0B5ro68QmBLYzeGaPcCtV?=
 =?us-ascii?Q?sMJ9rZoRmDaIp+Z1NsevIsLUq8vJscD5hVnzTSFwAr+S049JXume0vWkxEV+?=
 =?us-ascii?Q?UUWDqVJc0QbuK317XRRyeH+CoSbACGNkwK/+ARkscxGXCO0lLEOpURCwtI/w?=
 =?us-ascii?Q?UxnUByd/Ouzs5ITZvETTQtCtPaAILL8ukKqsjDcnLDWrQ6Gyg8KmdtCDI2vT?=
 =?us-ascii?Q?+LXEDW2YIhXSTXDN59fRjqYNeBZk1rfcqCZ/zWGWhPQH4P4N0YJ32ms2GS5s?=
 =?us-ascii?Q?6f3pAVWv6CIiZXpM+7kC9ge0MYeSXbxLkma5AAV836I9KBwqmBQtsskW2zgx?=
 =?us-ascii?Q?6Ldk6iAZXEdyLBStKFCcHwUmILocI6DgmEJ/RbKhPM5hptoMO1cSu/Zcewo6?=
 =?us-ascii?Q?fLUoQo756lyOQ6zH4HJKhUz3R6Yx5edDxytQIXm4A4JYpENKPs3SR+cZnaAT?=
 =?us-ascii?Q?OdqNLnTfpF7txBDN38sCNHI2F/qA4puoYfADOKSsZIFFi8fELcNXqYlKKdjZ?=
 =?us-ascii?Q?QENPswcHfgXmgQvWt13zRyYx8GlccOdRnhOwGUQKQfhHbBZBQhDUQcJTgpi6?=
 =?us-ascii?Q?kAdpflKcmsVFUtv78NxU9j/w/xEWOWd+BZ27hTFt3/UBWailyg1f+lOzBM5t?=
 =?us-ascii?Q?d9CPXfnDKwy8asQu/6kwpr6Sh8TIjhlS1PvMhyXWbMxorhCdJaHotu5vyMq6?=
 =?us-ascii?Q?HBboULAoAB059HrRnOYfJIdI90kAD8Ctjydybfj/E0i019t72nhuJhevmPHD?=
 =?us-ascii?Q?izFQ88XeGkY+b4In6hSuqgnW8/lJ/7hAkcdc1RXyeJSJBus4VcOjMgnEjWTn?=
 =?us-ascii?Q?jfscwk9CAGPutzG6NwCz8ooHJ8Y8wILz6R07CI1kqSfc3BGnll9L5e1ytRJx?=
 =?us-ascii?Q?C46WzpDsPJ217HncvKsGexhf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc9152e-0d75-4876-bf06-08d8f309cfde
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:34.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yxQobtZAoY132BpJGbp26nPLG3xphZnnWZsLLehOFxU7vqRkwZ4m0z1gdk2j5PpKO2HsZrRNGFxIqLHX4Opww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3301
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-ORIG-GUID: eNEPhUXXKycuHjFhxqkTGMEU4-YRi_n4
X-Proofpoint-GUID: eNEPhUXXKycuHjFhxqkTGMEU4-YRi_n4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After making hugetlb lock irq safe and separating some functionality
done under the lock, add some lockdep_assert_held to help verify
locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf36abc2305a..06282f340f40 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1068,6 +1068,8 @@ static void __enqueue_huge_page(struct list_head *list, struct page *page)
 static void enqueue_huge_page(struct hstate *h, struct page *page)
 {
 	int nid = page_to_nid(page);
+
+	lockdep_assert_held(&hugetlb_lock);
 	__enqueue_huge_page(&h->hugepage_freelists[nid], page);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
@@ -1078,6 +1080,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 	struct page *page;
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
+	lockdep_assert_held(&hugetlb_lock);
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
 		if (pin && !is_pinnable_page(page))
 			continue;
@@ -1346,6 +1349,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 {
 	int nid = page_to_nid(page);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
@@ -1701,6 +1705,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 	int nr_nodes, node;
 	struct page *page = NULL;
 
+	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		/*
 		 * If we're returning unused surplus pages, only examine
@@ -1950,6 +1955,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	long needed, allocated;
 	bool alloc_ok = true;
 
+	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
 	if (needed <= 0) {
 		h->resv_huge_pages += delta;
@@ -2043,6 +2049,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	struct page *page;
 	LIST_HEAD(page_list);
 
+	lockdep_assert_held(&hugetlb_lock);
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
@@ -2642,6 +2649,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	int i;
 	LIST_HEAD(page_list);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h))
 		return;
 
@@ -2684,6 +2692,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 {
 	int nr_nodes, node;
 
+	lockdep_assert_held(&hugetlb_lock);
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-- 
2.30.2

