Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3234F791
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhCaDmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:42:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40630 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhCaDmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3fcCr158760;
        Wed, 31 Mar 2021 03:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=ACpChQM95ueVORwk8vKkG+h8QzE08ollJKkIPrZEYb4=;
 b=nsgNN7bREA36yZuu/bF8CShAUr97nbkPWxerDbqeq9534qc8l/3QEqt6M+Nx2eLEdG+9
 h5JFJ1nO35xn0aplcE6P1wBGiEPgxt4nMbooJL5NbIp95rpKt7UgfWHOObLwXIVB0t7i
 k4AsaulN5rCBV4VPW5TLTf68f9J5WLTDXJdsZQHAuQhigufoI+F6OLUa0HwMlrTU0rcY
 EvCs8gCLBDGJLjXpW0l4Ol7nG8ectpmma6vxUyQeDYa+mW7NOOedA/LFhuf03yeqpPuL
 XnXWX9tvI/z84cdGd3oTJ3VgaENlJDDN9DJRT/6XNuY+1ZQzQukp4qKIKn/Xy0VocfSY ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37mafv0rkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3ebft133184;
        Wed, 31 Mar 2021 03:42:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 37mac4wb6h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+w5oZTXuaJT7pZF23qXTAiRPKEkgrz4AwsAJTl4A9A/eItCwGgXRdp0Ybl2jtZMMbvv8/GETAnNuAE8mUKS29dZ4e4Rwnw/mdIyPgM/+rz0HPc6B/n+z6J3tHv5tfgntj6QWfl3Z+bfzCZDh3xRGYMevcd/LvhqOWS2w9RDMv/oyms9HdsbuDKHB9NcQrT/SVbUlOMaB7suBSxouTThreB262rXeLIh/2PnFokg0huqRyfpTQyvGlQsFdFrJ9Bf2S//AUiMdri1uGiVXa0Fo8ZnH7JuyOg4dXptXP2/qB0Z91Gx59EuXzw9FU4R67P/nOhkKZsV6NzljS7p/bnRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACpChQM95ueVORwk8vKkG+h8QzE08ollJKkIPrZEYb4=;
 b=XVs4Z0W75gCn1L0rdbVzulQ65Apd35eoU5N5tG8mdbIi5gqEqE5rM/goVIa6Y6kGavP5UQOy+DxwFFBOIT+D3hFA/s9fyOvYFjeG31P/sBY88OAUYWL218kqOv2BjPnRx064qpBxQOomOXWdX11IdbgPBaJcLiK24IeKH4dqWFelgCbmRBnsg6BNgHsf3cW1X12Tfq7R0ecJBW9XbZDloYCw+I3nzPzkcBRkhFE4JRlFDF2HJ5hSNalmclZ/6JwywY87ncq+3Jl4X+gO3B20BvVJ1vvFzoRRL5YPQ2tGx2JEUoXGn+iQKQ39MVkV189Gdq0P0FNzwCflI7oL+MBx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACpChQM95ueVORwk8vKkG+h8QzE08ollJKkIPrZEYb4=;
 b=PFfZI11QmxJ6WqX+XujbTyaJCtG8xlp9MwmiWZUMIi9/hOEcPio1eW8DY1ybI7hBOCJ/waNZKWOr3iWUwI6ZsgeI6t6s3lo/IIAxbYoJgWCH8dpbOGx7Ig0Yd9gGwjbm2wCAW4ux1ABuZMyCMfMuIZKfgoZgujlMY2GCxB/Bz/o=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:16 +0000
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
Subject: [PATCH v3 8/8] hugetlb: add lockdep_assert_held() calls for hugetlb_lock
Date:   Tue, 30 Mar 2021 20:41:48 -0700
Message-Id: <20210331034148.112624-9-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66141ccb-c9cc-4ddd-eca9-08d8f3f6fa59
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB446254D442FE86ADC217885CE27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYRidwm8/qVAH26RbfgSBPUZbbHlIMqlI45Puest0uVkwDnlP+k6I07PzT9bssqJiW+/d7JAwDRi2fU0t1ugystnnFZhxpax3/wgw8X605w+CXk5uBwyTDiiJzustN4uTBYvFhb9H/ZU8+GTpNIDyxdibejsLtneQOr87hWQ2eirjVCV02CICPdpvv/D4JHZNAhnE850ow14D+iJtBPEaHWpdrRETAie+o0nTSw/UlJph4olTAmujBGRgMddootpl6hIk09bFkVqSzSU53fIkaarFodZlP1kDgZCzBmNlDytnrmKX0TQnvnrsP9cd96VOswf77UdExnQeGsh0UkdmAonCtg9fVd2rmorhg7bmLJU8G/Iuo/ILbDfTbLM/z1XOCo0v8qx0EWENGFLF7M95OI7nmKcE29w/QzuXPeS77MPI/X5dzICWFUlZNQ5GC7INX2q3CXfi0X2cGdy1Rhpi53wKvmPQkFkvZvIHdzGtOq8Ix/w5nzWgfPTOF6IZmco6qdxuR9dUd/EXTf5jBL7tJHRt8piqLRsm3lmcDtUOC66AkrW74c6dis/87wiQFzZB9sigtTR37A2Vn7R6pvRo91oVZbQmuDw1frE5ZEC11FOkIQLcbAEbkiyyGiw7gYk7+8CmfPRDddmjCLSlJJB4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(8676002)(1076003)(8936002)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ncJAgvieI3PnTt+vEYMzLQvlohzzjbC/bj2CnZkxBi/Hs0mtNiMx+l+eERxh?=
 =?us-ascii?Q?G0UKhVSeYQdHn88XEUssfrXPibLZMdWQv3CrcEyo0z4QCSd2G4Vuh0V9wjqT?=
 =?us-ascii?Q?cJ+TOmYx20UuKva+hWWAP6pm9zJxI0/7pkrYoW0btPrziZaIjl/wNPdAYn5R?=
 =?us-ascii?Q?v//XQVx2h2zRV+2o5nPPQhbhjptSvMoIR+6aL6DLxJvaFEkjD/G22gqy9jyF?=
 =?us-ascii?Q?XmobW0xU6ox/SIl9PZBoC7Ff3NA9fGmKPE5nElD6ZlUem8t/THMR5qVB7sE0?=
 =?us-ascii?Q?nUwmL5vfp2SOQrZppQnw9Y6/WkVnM9Gsjh7w/FBvDf1H2z0jzkgO1P12ga7I?=
 =?us-ascii?Q?DH/bZYRgkr+O+PSmGD4Ig9ZScYYJWaTX6IFR2wveFBfKC77XWD8/iOBEtwzl?=
 =?us-ascii?Q?m3dvux31gW0ZtcsChrcWvveYA9bq6YNTct7IfoagieJn6WsSOBTKNueA0hmJ?=
 =?us-ascii?Q?GszNK+2FCy8gr2UaKIEoIwC8Ke2UsLNfg/sCht48yWbj+u5/0gpee784E4u1?=
 =?us-ascii?Q?Jf0iBbEoXKJonwQpb1ZhZ8j36hzb19mM+cQBC9cs3xqJmasACr45RoJ0Y7tO?=
 =?us-ascii?Q?i7YpxX4WTNS6YoAbV2Faz7mj7Byh0m5+aci3xNlOwlMb880RXULub0YWnEgV?=
 =?us-ascii?Q?p2mmRCLBCcwu2F/u3C3NQN179/AM+p+pTW8uGc2idfH+NqP4Dyv6JtNCaJ9y?=
 =?us-ascii?Q?l+ZeT7BrFCUjhgf36gEHcKNkoZ++t8Fqfb6Ftdy6B1SlwdJQHiphegafKam7?=
 =?us-ascii?Q?TneATxyCinK2R6XkRO+8gvpE3GVKE8qCNxqdIu48txrEPJo7bi1283+VmfWY?=
 =?us-ascii?Q?fxrS3y4Osj0fn2rvPlswLKlsqXZVxRpSg/rC4xrTrmkWqULyyO9CvnVHT7cV?=
 =?us-ascii?Q?2PCZlHDOcpZjw5ymigcpnCt4WJfEWH0SbDzE/0mT7P1lZ2R6jmGrGQWYWs+M?=
 =?us-ascii?Q?sGW+yOY2dbdivRA20OOHgPJOLiiF47NyRbwrRIzc3JND9RvuVqVyBVmFOo+Q?=
 =?us-ascii?Q?NglhBtoHDZ/Y4nEtaW2m6UUp4d8+rAgjkDSZstC1z5xWHh0Ui5ibqJRnswnF?=
 =?us-ascii?Q?3U3yaXFekCdrM//rgikt+j2lQJWZ+UOt5DDkdu+oY0rnkL6XzCZhkj41t9uc?=
 =?us-ascii?Q?gUtZMnAERWDNwO4L6kM5sc7B08z6p3J5Za4ElPYJ1Ab7st/k2f1bLQBHEBV9?=
 =?us-ascii?Q?pyBOYf6C6WLIbsXMRV5nag6mUAuJLqND5YZlWqjcThGa7pUvZv4YfHz15jbZ?=
 =?us-ascii?Q?0FsTlHAIo3SC4Sc5OpF7PtMbru39Ueo+hAQtiR/XIOmqVOLOK2HJ6M/bSOFm?=
 =?us-ascii?Q?pzdgEeAZrd1zpKHZkvDnh0YA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66141ccb-c9cc-4ddd-eca9-08d8f3f6fa59
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:16.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57X+JdLthOLexHSBVmvWaz6l+BeLelDhTt3DZ2nel9zXBjYPNVMAmKfJKjfUZrG4e2mj2hj47q87zPMaaNaXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: D9qyPm0UK6kOCRsNSWIXPt8eNutY2G3i
X-Proofpoint-GUID: D9qyPm0UK6kOCRsNSWIXPt8eNutY2G3i
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
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
index 0bd4dc04df0f..c22111f3da20 100644
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
 
@@ -2641,6 +2648,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	int i;
 	LIST_HEAD(page_list);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h))
 		return;
 
@@ -2682,6 +2690,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 {
 	int nr_nodes, node;
 
+	lockdep_assert_held(&hugetlb_lock);
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-- 
2.30.2

