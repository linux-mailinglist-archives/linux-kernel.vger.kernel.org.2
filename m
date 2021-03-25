Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375143485E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhCYA34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56554 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbhCYA3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0PS9u005752;
        Thu, 25 Mar 2021 00:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=WdVUnI2JmHN0jJBwfh7qNh6wERVSNwNKKiV03MJuxNo=;
 b=ISg0hkO9p8fJmKgE/ESCD6bls0pCYuJjtPJQ0riMd+VwBLH00+5L3o3hLnq9G81O3AWj
 FZ8zpfQ1jdbxibVAEyzWWygdCU6hw6UcAdbbdHofA3lxzT+todNhPTeXD3zENE+LNSGU
 qUg7hVIKnTrziWbwAVcea9ue43r4dpGG+GmCSySUytY7FXMtsT8PyzR5E4rKnLN4p1FA
 Jd5tNQxaa0pMjXHT2qgT7TpFlXE0ooZxgG/POTcDOVsJH16Igc4kybvebWWX5txdeXYb
 ASGLkLtkZc837KpsSXoY23zPN6ksm6udAR5kGwwSuPTBADk21NSawSMZFrZ8oBkjTP1m kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37d90mmmch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0QTDT040331;
        Thu, 25 Mar 2021 00:29:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 37dty18p2t-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqwQBKmZ5+h6U6WiUWdBJlrJ+el6Sq/zBlwUORbMOAezeb/UFhXqhunKaQAihOmOvKivbc+a1ShxDxUx00wp3Z88Jsntmx/04R9KfSQoaMiCwA1L6s8EpzpcliDNnKsWxZJMnuzQsOCv8lDi9mpCHIylr1bXXU8o2Olvt2/nBJxu/kDpesXZS3FuZ7P3kJCS4Iigf47Mwb/dm6A/4IHbIvZYjf/xoKEkEQciuMRwfgrb14V49bNV6w6inPfAYCzmSztPvrVzulKV7SnVLgk9nE90plxB7/Xz148QJChB6sd3YEAEsPWgNIKj4evTUmXffx7Z/UIPr/ZXL0dk0wC1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdVUnI2JmHN0jJBwfh7qNh6wERVSNwNKKiV03MJuxNo=;
 b=Y0Ee67R7r3r2GjG8NFZSLUrS1tbyMHKEY/QhKTy7OYMJlkwN/6oGWTFXdtXFuTQ21YAQhwqc9ks1jj6jkWupZPMoJz1o5cZlNFXQNgFwnT/zJ/pmZ2SsglskzIUrBY/ONYJpaMIe0b3cSqB+IWosDVaVW+wZlEeqDFPJy9uW+E7Gb6bbhqCamiWWvV7xKgU8q3dbOt0s2efZWcaD+AA9DlyWsfLPFRPp6DiKWxcx7gMBCUV2BRu3gRNMk9fqktrS70r78uba2x5Haf6GLoec2HcPJpeQFSuQZSUN0p5RNsvbDgH0qTSuG3osM469e4fO7Lx0qJKlqtNk1zrtarawjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdVUnI2JmHN0jJBwfh7qNh6wERVSNwNKKiV03MJuxNo=;
 b=wDpU8BuueW4DLvy1xUrDa6A8VJcmhCnBJXhlsqu3HovVUKynZJ6I2j/iW4RP5q2SqA9b0Z73mz+ZbGZHeYyzFxQAvPCBcGiLqa/aZJ9TEwZ1HWNRiOY3J06jiid6xeekRuk2aF/6cX8L6xsyVTYDItfGZwY21iaIPsDBclC5rmc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3875.namprd10.prod.outlook.com (2603:10b6:a03:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:29:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:29:08 +0000
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 8/8] hugetlb: add lockdep_assert_held() calls for hugetlb_lock
Date:   Wed, 24 Mar 2021 17:28:35 -0700
Message-Id: <20210325002835.216118-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325002835.216118-1-mike.kravetz@oracle.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:300:ad::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f3e426-7179-4b85-4eb3-08d8ef2500fc
X-MS-TrafficTypeDiagnostic: BY5PR10MB3875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38750C6937400F1C7C802810E2629@BY5PR10MB3875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j46+KVww0v0VvHqpZeGON/JC1r4AruZkh/QLJIrYPu721W3rwgMoJQZimE91aUqOHcXPKYm50Y5zYqveg4iFxcNdMTyGCuT6jxJ4EJjqiSiEMy+h7L46Uk7ujW/pu+TWBgUXApHnENmX/lyqAn91LZbBTqTZVg3IMvCBREXRYeEHLEsT4h8Q9isA4ODD3C75N01HoYXVxrQpxzN14t6B0tCWlhi8XYNzHmA7/QL4f9RMehT46IoFEO/a3uMrD3NH0e6Q89MaHQvs1pKC3FB7nZKnO2+NXG3wx9PV5xVMDifvLYritNocFy6v0ax1UQLycq0ZL4X0TDgls7n8LuueqhhAtpv6HUwyBAI2k8dnp7LU2b3E2K4eeq2XY7OOA1T9Tenfpa+8Bw3fgmtn0mu2iOyAwQSrtt77WsswYEn2SUxkTcP/3g+VOGoU2LUv0p1otET0P//XsnreO9/Ogffqmq2di8tZB4y/kgBA0vCx+PDAklNNP9hlQ3kkT4MBuCE8mh/U2pUv/v38q5U4+ZovuQej5HhLmJGQTA9vT+dmKcsZ4WWhTEKhfejmmYLI5m00DuJwRGf8+W42/g5z7aK8HEbjGCHRuOjbBKaej7sbOypCBMHjE9TV6Y1ZwDJUN4KLDQa4H0UwlcFFkZHFjVDc3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(366004)(136003)(83380400001)(6486002)(52116002)(186003)(4326008)(66946007)(7696005)(2906002)(26005)(16526019)(66556008)(6666004)(5660300002)(66476007)(8936002)(44832011)(36756003)(316002)(478600001)(54906003)(2616005)(8676002)(1076003)(86362001)(38100700001)(956004)(7416002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fEPmPW3F5YG768ywihtIV06UaULC18iLIYJPtxNYfQoyVQsBEV07og0TreJx?=
 =?us-ascii?Q?S2djzzaWTql3zOiuMJ42vlCzJTopFgoIJuqe80wthK1Gcl3tUj3rnPxmUPPo?=
 =?us-ascii?Q?BfWcV4faA7d4v6mzrNBJYvqk0fKyPFbvmARpXUg7O0fu7jz//SKG8wwnQOQq?=
 =?us-ascii?Q?3Z7EEUbi5ffLWvvsdSrXSXfzrepEIKFCybL0CcE/Ts6OvrOKbPMcA3udC/iz?=
 =?us-ascii?Q?lzQ1nmU8Mqifgx25ZUbQuLXCDh0Mxgr9NNA59C31BjQM3zMMTxMxTcxDMrKJ?=
 =?us-ascii?Q?xZFjWUNcNRzdNNRkMn0CH7iI9ifRDH6qvXqwGtJ8YXJJQR+jVp+dz9zPglVU?=
 =?us-ascii?Q?iwEp9w0ZIUZl3vy9z3t0AAs+Br0R0Ds5rTspKjEql6kx5dSlppXKpGhICTao?=
 =?us-ascii?Q?FGi148kv79UMVfJMEmlmVC3S1S9x0Ep9pguII5lEPWriJjJWPOqLL47vprNC?=
 =?us-ascii?Q?VFsZ6Y4Wx4Ks1J/4wiqh25SeikO31GZuBaGMSm/s1DNUldouvKVXEQopwA3z?=
 =?us-ascii?Q?UzqUfaevNBJ7yp038HY7NMSMVPtjb9p5Dzf1ejNBBaSbCB8lkxy7Q1wmSNCG?=
 =?us-ascii?Q?aMs0XCF3NQozYbJYtGtTSDPZFUqZh2188+cw9o9ofrvKeR1mUDNBCsTF7Qg4?=
 =?us-ascii?Q?eovekcFUEi2hq9ZcOAQAANu8zJLSHjXy3NJcBGjoLjeLl5E1Cv7TFmVaQrdw?=
 =?us-ascii?Q?LxxV3x/oDLZhG1z/KDPH3NzdIlLdzMy03IMFLtr+oC75t/GqdOeK6ffXu+3r?=
 =?us-ascii?Q?NieCs/l1c/IubUiouIe0zBTogOH/MSRV9eHYgXhUSjeM8o0V1AgHGH7UEgD4?=
 =?us-ascii?Q?dM9b83loA9y4JDC+McdYimWXQ1lZRqq8EvhqOPDP51ruMuGY81xE7EtA8qWE?=
 =?us-ascii?Q?sVOcjW2sDGXYy/TwZuoLpK0JQeF69GE1It5qK9QgREf8d4LfTOkcJfpMLRMX?=
 =?us-ascii?Q?1WhrSXNQGzvEKLoyJVwmUo9NAl6QyefwJ0jZEz9SSAu2rNIm8YcwdDKYOe0X?=
 =?us-ascii?Q?dhQmvuGwraOkPFHCPoyV5pA9QTk/aCMO+InP3VNkzcjhW64aa3ZLJOdCRbB/?=
 =?us-ascii?Q?yTFiw38FOkoARANO/HFO3TezlSXeW0TMnRd9fd5QcpwRgocnd09TMjV096y0?=
 =?us-ascii?Q?eWGMFlvHq+Y/UepMpWU//0ixaI4/rW48ffyesg+FGBJ7FOdyjeQ0IIpAli+u?=
 =?us-ascii?Q?A6RA1kqXXH77ewGxNV0whtkyYUwt91pzx+mgE9doF06u5arBUxZG2oOkJtVO?=
 =?us-ascii?Q?zgkCMUiC1iYrDZS86JfCl6dY8emxWeOLWDhZkju9HjiBpxIhfV6W9p03lu4W?=
 =?us-ascii?Q?zNsz8C7IxOQMCyyiaowBSFq0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f3e426-7179-4b85-4eb3-08d8ef2500fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:29:08.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: From6nv2s4d2pGj0MItZTFRoP7yqQTU9lLkGLIIMWpotS5ByfSzuJI95M8hXNpFihsb39/Fzy1KW3LfQJvhcmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After making hugetlb lock irq safe and separating some functionality
done under the lock, add some lockdep_assert_held to help verify
locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4c441b878f2..de5b3cf4a155 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1062,6 +1062,8 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 static void enqueue_huge_page(struct hstate *h, struct page *page)
 {
 	int nid = page_to_nid(page);
+
+	lockdep_assert_held(&hugetlb_lock);
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
@@ -1073,6 +1075,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 	struct page *page;
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
+	lockdep_assert_held(&hugetlb_lock);
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
 		if (pin && !is_pinnable_page(page))
 			continue;
@@ -1345,6 +1348,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 {
 	int nid = page_to_nid(page);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
@@ -1690,6 +1694,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 	int nr_nodes, node;
 	struct page *page = NULL;
 
+	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		/*
 		 * If we're returning unused surplus pages, only examine
@@ -1939,6 +1944,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	long needed, allocated;
 	bool alloc_ok = true;
 
+	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
 	if (needed <= 0) {
 		h->resv_huge_pages += delta;
@@ -2032,6 +2038,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	struct page *page, *t_page;
 	struct list_head page_list;
 
+	lockdep_assert_held(&hugetlb_lock);
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
@@ -2527,6 +2534,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	struct list_head page_list;
 	struct page *page, *next;
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h))
 		return;
 
@@ -2573,6 +2581,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 {
 	int nr_nodes, node;
 
+	lockdep_assert_held(&hugetlb_lock);
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-- 
2.30.2

