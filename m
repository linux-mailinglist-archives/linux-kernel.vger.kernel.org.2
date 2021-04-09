Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801B535A828
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhDIUyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45558 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhDIUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KnFd7028850;
        Fri, 9 Apr 2021 20:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=KFsTE2vrECjTbvsLeSvgSWewsuDLc2psH6Wi8Zq6GX0=;
 b=bdCLvTDkwnT2gkxHrV/rx6N6JOkiT6K82v6hnBI/8gF/suiSb22M/640DKc44wlI1zyg
 fyR85ZLR8t353UGIbdipAhG1HByNzLKTA1GULTWLVQzdq7y63VJndJGEFyOiSz0dKgYI
 973dHMly9Ec/2op0MPhk7fODlz7HUNk2PQW7rW9SOvov3/IKz06v1n6UpR18c+NGX6hc
 /pVGBv3zXpUDSvJeYPkImMJ91FfmuaeTA1FQeWCfUA61mxpdnrwPNyZoB1UrdxxpSDaJ
 8Gr/gmJvZo/xoBlhP3D+TK0I+4tsCxZXsVJULg5K0CtORUG7dTjW/ARwBd4+X/rkBfRy dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37rvawaqb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KkEYQ178858;
        Fri, 9 Apr 2021 20:53:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 37rvbj1prb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq+zzwwjgZ/unbmpKVAKWnkIbQJ2/1ybWlSZ3YTjEn/5TDouNWS+0DttqdYGc7zn8RzCnjO+4b+Gql37NcuvDo/mHkgoXV3Avkr1qzPlDHRcv0X4mvbWOR10J22IQjg4zPJYWNKK2oARnCNncxZcdq4IS5r22P97rsrnPs4H7nGUN1/6k3iQWVtZBU4jhWtNkG+MeLadpq1D0fz054wu/HbWtVzIJRL4Arf6WVZoVf08Cpo2DR1ejlYIs8C6e5yr4HK654TPTOtc5mGh+vwsb6SzgTRZ+q7b4kiK0VKMyEYKDVU5rwhu2DWKZn9IZsLKE9ErpQTL4O7GX1nz63kNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFsTE2vrECjTbvsLeSvgSWewsuDLc2psH6Wi8Zq6GX0=;
 b=Wk2U3chVzi1/ryDo/4VsaP4Pu9bmb3ibN3/cmfnPYIaSNLZqH3kTDR0Ljo7UuhUe6hVgNqK8y9OcTQFJ+7xNRYFIk5t2EZkU5sa1Kk9f4E2VTHEY0rcNEjP0qPkKHLe4YqVnkTTBlsy723c2RWm6OE+VF3QOSkh3zQsXcpPOPkb1w91DKiHyNZVwNUvsiwA5wAVRpx1dmMEkSAuRtOiDf3Y3I0r5w67vurejbzJCKi/5/QemTJVNOdoUt654oMamgXY8VTx1PvT3xs3BBgqVh1SPle35zyv6TSM2p7+BH2dNtX3qsZ4jBJ4KVPPqEos6uTKzq9b+T90ko5RxXjdfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFsTE2vrECjTbvsLeSvgSWewsuDLc2psH6Wi8Zq6GX0=;
 b=oHUhXfS3Xwx7OtuFSMepKrsPNlNmxF4C1VRXqVHEocbDXEh5IiSD761AzaATFcZDW6E+zegyYa6zZjdUomYUVx4TthNvPrTi56n98wIExWH+8sA+kHGph48MjJF4gzjf8vDNjZyaM8mvWwe3ANeSn0QUvVlCM6Vca5L1pupIx7E=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3988.namprd10.prod.outlook.com (2603:10b6:a03:1b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 20:53:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:27 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 8/8] hugetlb: add lockdep_assert_held() calls for hugetlb_lock
Date:   Fri,  9 Apr 2021 13:52:54 -0700
Message-Id: <20210409205254.242291-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409205254.242291-1-mike.kravetz@oracle.com>
References: <20210409205254.242291-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d0f73a3-cb30-4cc4-19d2-08d8fb9985e8
X-MS-TrafficTypeDiagnostic: BY5PR10MB3988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39884C17EBE5EE0E31D73D00E2739@BY5PR10MB3988.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJzPSjCD50aoYXzHsexL4mLJFXXl3DIdFB8Hl8+3/UEpCJS5P1IQgkvms4DX44nq84lN3gE6+CRxKFdfcGW44C7561XNkURh+nMqltPXucxzVfftVoVBvEnBN662OvQpC+jmzchQfhq63LotKv+/4oDemF01HnBPdQkFR/Kt5ry5NYg3ElHn0hYaUadABgWPhyxgcKLay8ESjVwzRrlHNKBPXV2Q57/VRY/jdZ8RqpYQuMVuoeuMYYlXt68/N7WG3N3GoE9hef/UdAWRqoQKZ9ox/mtsUeshQ62PvORqkq/yQ9PWWsitaHpUCln7358pSqkm2Ejxmm+rAqge7s9URJx1QPiET8OntMU6h0QT10D64ugizmbCb8yKje4NXSRw4gODdxaBsIFr9Besn7HdVUY2XoTAjur68Z9g4Iv9duBbuho8lSA4Z4labJmYTKH+3Izl1ATfkpmHwt3lcn6JjnLoxNM+ghe3p4ouIWRQLWlmjqiYT4uqjhk0dVJVnlFzcS9tNXRmS23u5kUF/XcZymBaAjnyiKnJcyZIMPNGNrC98IAeo/MSZSaC8X6vp0b58IdoVErLESbScfgWBcMGWsB5q7ZWv6AS1RY+lkcfkYqGzDrnZnEC4Mq/80EGETaJ0clwCoFuxiL13diBPbW2EiN93v85omFjX3VoRjOmM6JUnOwAm1d6s5uUTmq4YRzs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(7416002)(478600001)(8936002)(107886003)(83380400001)(36756003)(956004)(6486002)(52116002)(8676002)(2616005)(44832011)(4326008)(38100700001)(38350700001)(2906002)(86362001)(66946007)(26005)(66556008)(7696005)(16526019)(6666004)(186003)(316002)(1076003)(6916009)(54906003)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cyRA/lTHwt/ZUdGIrnmjgdTbz1rkN9ZCzUMx8EHZjMcbmFUiaQwZaSXFtdMp?=
 =?us-ascii?Q?bJhWKBhqm8J1s3oXxOzmuhTEpNrVyFXzj8I0B5kNFcw19shCsKgUVAeoWYZA?=
 =?us-ascii?Q?trW3RJ7MC1PZVoXw3DUCyrqlCuul4uVRVvQ6of8u5aHqA7JXgKLxgNIsEx3d?=
 =?us-ascii?Q?MoexMaSlAgTYUp+TjmkwPoKq7xHD9qgo/I21EWHXJ/Yp+5wySVcpeoydMgUB?=
 =?us-ascii?Q?ddSGrzWmRW5C5P1nCVcKO53SkfKrw1OWgonXnXep/Y4DhidoJaulqkmDD9tX?=
 =?us-ascii?Q?TIdPDueupr0qM0B27sqCarV7tNKe7SZ+l4l77eRyHPuWlKal5HGCknmxr6CB?=
 =?us-ascii?Q?adfrvyAL3ILWHkDJJHDOZq5VvDlz2E8EkKTAkK7OHM54rVeaPEVir7Ia5Z0n?=
 =?us-ascii?Q?Uc67H0U2kkLvzz8XSvsU8vkaGR6Xr2dZ5zoMNd0u6TLWfu0CHRDDH7URk/pB?=
 =?us-ascii?Q?obQc5G+MUrmSEQKJsgdxjO3oZ8IUpORuYLGuPVML0xrqNdUGekqjg/PR5eDf?=
 =?us-ascii?Q?ILZ3vHp4QBF38C6+DWybrFVNKRrbbuolz5yh6kYeMkrCvD7CTQ9TVKCeu0f4?=
 =?us-ascii?Q?iAsX12hw/k6OoJaHUm1PnR46MFSEA8K8zZwaIPWCU3ZKnmjNTwfhIuN+VkAq?=
 =?us-ascii?Q?iPoLqwiiXXx6qA5nq614EwPfCGxEcMiyIqsd4tAP7xxHykOOhtRI86MU/UY6?=
 =?us-ascii?Q?OgYNn+cQB22nnIgSXEq8aEtftcRFPnYVNIJNvDG9bmMZK4M7d9wrpzvTbobu?=
 =?us-ascii?Q?hl4pQuhnxE0yXWlqx3RFiu+GxtHtTxY9Tc9veNth73a+FzGghF+gcwAp3w1h?=
 =?us-ascii?Q?p25NGgjco+amp3glnqxVu4CvQkSggUSj6Ke27PpiKK3NjgnayoFsjBWz+bHj?=
 =?us-ascii?Q?fOaMxggsoL89zDdvD2yVSCeqQ8FvE1nPGyyQ0xInL6tgKgkxKcxMKoxkD4T6?=
 =?us-ascii?Q?g3+aTy9Zt6Qa1M9/wvfpUThgigM+Nf8ixSf+a1290eaoggXanh1g35WowHNQ?=
 =?us-ascii?Q?LmEMhmBE2jxZLImZdDdhFbMEY/pG30kHSfbALPcqiDuNquoKcCYj5JwFLuLl?=
 =?us-ascii?Q?bRi145TGaiw4RF8emJRBwkOZVHTDkXl7jPqDMIQyRYifvYWDh79K3THe9x6e?=
 =?us-ascii?Q?jl4vAKFc5esNS9X5NVEdMAI2+UeIeVhY6GGK7mS4DY5/9G9Y4dUTfyxuaehz?=
 =?us-ascii?Q?84RC6UDIHwxUGfc8nLwy5Lu5ee3E3usy6aTz4aB40Au/YrnWUDzsxO2s23hX?=
 =?us-ascii?Q?SgPQiFDT4yPqJeEXDy4/YRiKlhS9N/TFF1VE+2PEBOhCxcKX6jBMNzq9SlpM?=
 =?us-ascii?Q?bLV3waZ7vnm8XKWa88zCqwSk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0f73a3-cb30-4cc4-19d2-08d8fb9985e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:26.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Lc1KW/iyas++eVDh/ESSZxRaQRzFVlw0BaHgUHtTYBNLCo/dacUiK/uw1KMQpeTGgyQkupq+Kfuz2gO6SYAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3988
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090152
X-Proofpoint-ORIG-GUID: kzBVHzZqU5QGTFo6kwtiGUmyHpnJ3dXw
X-Proofpoint-GUID: kzBVHzZqU5QGTFo6kwtiGUmyHpnJ3dXw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
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
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 049ca0bccfcc..5cf2b7e5ca50 100644
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
@@ -1344,6 +1347,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
@@ -1694,6 +1698,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 	int nr_nodes, node;
 	struct page *page = NULL;
 
+	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		/*
 		 * If we're returning unused surplus pages, only examine
@@ -1943,6 +1948,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	long needed, allocated;
 	bool alloc_ok = true;
 
+	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
 	if (needed <= 0) {
 		h->resv_huge_pages += delta;
@@ -2036,6 +2042,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	struct page *page;
 	LIST_HEAD(page_list);
 
+	lockdep_assert_held(&hugetlb_lock);
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
@@ -2524,6 +2531,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	int i;
 	LIST_HEAD(page_list);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h))
 		return;
 
@@ -2565,6 +2573,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 {
 	int nr_nodes, node;
 
+	lockdep_assert_held(&hugetlb_lock);
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-- 
2.30.2

