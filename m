Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5660A354911
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhDEXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:02:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56860 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhDEXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:02:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135N09Em118942;
        Mon, 5 Apr 2021 23:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=rN1Ph4/WEiFUVkJO1x0Thnt6ZIpHDaZzFrTDFQd0u4o=;
 b=beXQvoP+z4PmUOdp2WAEYhHtuRzj8yDTClMyT/WB9XWUXnvtaLweH0myq5FVyq2X0mMM
 PvfOgtjObP0c9KYh4sQnUYd9XxwI1jS3xxK/BmF1VrF09loshynlgG0Z00mxvLSstUl2
 dolLooVcW9fx2nPfaLAKXBX1wpYhnUXgw1P7dQvituhgrBWkrxm7GcgH9t+RSUPajE7c
 rpY3P/qMzqFdQoQfUdeqYh4+VjtnW7pfDP4P9y7R+YOiZr8sVJoHXzHAWZeCXJuGhmi1
 8jAfPCse9gxR5Z87+pY+ecrQcHs2t4ESi1UEW4ZjmNzOYkkEJdFLg/ll5CB/l0PiiO+S Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37q3bwkk9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MtpU6089329;
        Mon, 5 Apr 2021 23:01:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 37qa3hp3j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a71MKINqrnIzXx26JKOuSPwqx8sVBrxMWqtQkmi1pIP+XwDcHa8TFcsKpob7A4tPD9oe+cLyt1repTGtKiI0/01u2WolP9vgf4zlDbsDjgvGraEQvKt3gKQsv/0QiJ1iUBb7pR4v55xPyQMqaX0jRLVgLFTUtXfkBbSQWrkKZllr553UVyjswTw3lFTlEWUIqSJ6OIMKIfAAMf0tVGvv3x/MvOocQkGizJwWjDnhSiqR6xQBbB4U9z6dQ/a/yWOVZCR6+fyFWJidoNjnp0pNrTRttFWxhRPm6eHMxz/R4CiD98oioIKaBOdXlZZbwuU3hb/vMt/QZsSR1pB3BvI2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN1Ph4/WEiFUVkJO1x0Thnt6ZIpHDaZzFrTDFQd0u4o=;
 b=mFSwssSVfyeWiriEredcL/Crr/NaRIQsdlWnW84mJ1ywE7st4mX509NYd518lfMTHdl+AdYESFPSFp/++2yXGxDt2cJ5aCkHaPNIjfGw1xcnNqEr/r4Q3kdZi4KjN429Othu9YYeN3w0spV/bibiMW6D3QdJMX5AXdAF0VqeMNKA3ASSWNhGOOQq7KhVCXekvFvZCrU9BfQ+kwXJJrxhzRnL3AbEGqwoGAK4+utzx6B4DMhiEXhGmGnRW3lF/l2AIn/Z9ko0O+Xu5QQBfmfFtmX7Qst8sKHLAsiuDJQzr6+enWD4pjP1Ri2q1I7dTp9x7UZejej2Jtusyt1mD/DuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN1Ph4/WEiFUVkJO1x0Thnt6ZIpHDaZzFrTDFQd0u4o=;
 b=F2y0ipls3Q+dfujDVoQvA+3P2wwHNyTv4sQNAmMrcoVQ1e+owC/vEOWQtOiXc8atI5uyTQU6bw3TDdjLxd/ojqoBQhicxR+K6Cj99RFTGfcq/P31ejZciIsJtOmMJl7ZgrqQ8ElPWFuwC/2G0xGOrp/h+0ZsTlNFb/gDaSWQ7MI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 23:01:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:44 +0000
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
Subject: [PATCH v4 8/8] hugetlb: add lockdep_assert_held() calls for hugetlb_lock
Date:   Mon,  5 Apr 2021 16:00:43 -0700
Message-Id: <20210405230043.182734-9-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdedd394-b14a-4dff-6156-08d8f886c869
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB35443DFA88FA7150BE50F02AE2779@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+jQ0DfLALoQKk+ZpYs5HUCbQWFbNwR+uN2ONDIe5FPn+NZ2KI3LxTdwa9hfB+SenzlqfBvvmyJcZmluyE2w83vaSsZClF6AUwR5JZysG1NA0ZaNgeaEJXwY9u9l89FQqYhxEPxCUd/OxZhtZM859G7Yu4iMAR7nHbQV7whaGX6LdaJfVBMVmckYZMaqQIwrzp/nVYnTm435D3MGRnEOdYUAYxjNffQhiMFQJ8176tm7amYbny5GjI8CdaIXJjs5uo5GPK5nNnGQspLty+p0mLxlcyGPqt1Q0KppqRVh0sMcHjQSdGMHN8XjdDSgN140oT6lKioZceCPUg6eUWDAv0xUHoNk13q17k3UME6B0FV5TuKjOQ6qQiiIrj3oQDp3MNc01rDFEYYIX8HxxmL3rjKa8yi5tgHi0m7PVWAdfnh+8VErNUs5W9TQUx+l7QqguxBaPTLSom+H++pKIu1esdpVu5AgUAiYGI1xen4uAEQeOVcIx7lkz6UeMrfvurjGbIdC1G2Kl+A5K/BwkB3IU3ycAnnS8DtZzTA9Im39gVFXcl9ffjkRQ4vBcrX0DnZ567svzETcE/6JhpZdElg9ujPumD6w6qNBc/aZSh7OT3oUzqL7bvetRA7ZgMrS5bgHUHBXv3FDKKsGE+YqzXAMp7Lk4VApjhJPVby3LBZSN8r0WGYoAdEqxi8q7qGvZm8H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(44832011)(66476007)(5660300002)(107886003)(8676002)(86362001)(26005)(6486002)(66946007)(16526019)(38350700001)(1076003)(2906002)(54906003)(83380400001)(4326008)(52116002)(7696005)(186003)(7416002)(478600001)(38100700001)(8936002)(36756003)(316002)(66556008)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GOZlXb0PQrB9U2r/Uxws8KrRZ0ckgpjlNVIcLsRmpAItlHq5TwI8ptEL+B96?=
 =?us-ascii?Q?4+cGcyY1ECZCmm489YDNTFnV+CHtrnUubV61nnt+ex0R6ppuBEtSQJ8Zqswa?=
 =?us-ascii?Q?w7XjVgnYkjFs8V70e839cVV8h/Tx86KMAtB1EzXj1LQ1ITaRBrngN+lfvTfb?=
 =?us-ascii?Q?UJ3NtMCdeMU8BxxS2FMShLHBta6a/7d0Vn1l/YQ0NjacPjpi5osdE6keQ6wj?=
 =?us-ascii?Q?q4Vc8gFVizuqFhr8pT4aHZwUpZvYZIObzv1pT6jKgA5lfEXGeHCicWvHr+WG?=
 =?us-ascii?Q?YkPz1JO3loUDuGTexSwcJduS7jPeMoVMDRjlgZnRRuo5MX5NZXgD0BXJmas4?=
 =?us-ascii?Q?5T2hT4TnEICPjP6x5RRnaulwTV2Y8zs20JkVY1yeKz4R2dnDeZhP1oWcaxYu?=
 =?us-ascii?Q?FXv7PZ0O2lpKUzFYHKiTksytOQ1fTw5yj7HUFU3rT/WSCXA6LMsCMQsxbO7G?=
 =?us-ascii?Q?IfI/A0VFJiOa5Nodzipfq2H3/M20AR0D3BMOB4RcLVEpaD8x4B2oBnpNfgWb?=
 =?us-ascii?Q?2JtBTAva+++VC16FYBDOElUL038HKBTdS25L12xqIWHQSLHRSHq6TPf3kwRi?=
 =?us-ascii?Q?f+pz6zyKPvNolxd1ekUcwwPiOOhAocbQ2qieBzoQr5eBVu4qCzuWA3jVBb2V?=
 =?us-ascii?Q?Sp6QLPLaceFc3WFbHBokV9yHM3XEY2FvMmsxIMWr3l8/9iDR9spvD43+Uq+j?=
 =?us-ascii?Q?57LxpZv6iIEN3UqWGfEJ5Ac3vt7HKIPTK3U5c9IqClDyaeg3GCUy3CfCdPJ4?=
 =?us-ascii?Q?i4zy4V+6S3OipNzPtmXYjwbWn50GQtDAEQgeBioLP9oNGZ15m4V5V6ZNc7/w?=
 =?us-ascii?Q?RB3YgAJVDS3qX8qMJmdL3PN3EzGUNHScahfDFw3yNe2ayghdJRDzvw+hY07w?=
 =?us-ascii?Q?nW7/4ZglP7NxTfOSg6HPr4TE/KpbnRaiirv0CH2Ndo5uB/CsNsi/YK3hUTUR?=
 =?us-ascii?Q?c6QRyNfnK66BiV/ztdcM8ZuIq1gCB+hPKl8VBw9j+TZFHHt57om5l7s0biG+?=
 =?us-ascii?Q?FIC1hoO3xOu+Nts6V8iFI3xBeRdXWcTj956nBdnxjHzk8GAh3pTMoT8+5aLV?=
 =?us-ascii?Q?Xz5AhLSbCm9iK8ozZw2UgCTEtm64Oa1qb2fg95OrjK2xwD1Fvz/TsVmjWwP/?=
 =?us-ascii?Q?0u1NSah7hzrluxyUPwRE5TVDUfNHwC9Ot6HxIj3tqV/mFdMkeD3n6D0SRU5V?=
 =?us-ascii?Q?34ZrhR+8c0qXrjpyjHgdyNhxPXRQJmFdnI/9RCNaw4HIgSVTYVgvntadmbsq?=
 =?us-ascii?Q?3NCWYYalSjTyNZu4bE6lqcB+j6n3aIZVkIfJ+kh3JcAalKUTkPShNPfxAxl+?=
 =?us-ascii?Q?YWO4y23uaAvQW8GZuGYiTwXK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdedd394-b14a-4dff-6156-08d8f886c869
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:44.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WlS1JCoBKM70EyETrON0/YlRYTWAWs2RiWAID3ASBSrJpCveZMTsXS89HZrjfDOPTzMCLSCEdZamtwMfMWIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: JmmVlhfpD62OQrU6c3vtPwg2ciht1v65
X-Proofpoint-ORIG-GUID: JmmVlhfpD62OQrU6c3vtPwg2ciht1v65
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
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
index 15b6e7aadb52..5d9f74e2b963 100644
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
@@ -1341,6 +1344,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 {
 	int nid = page_to_nid(page);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
@@ -1696,6 +1700,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 	int nr_nodes, node;
 	struct page *page = NULL;
 
+	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		/*
 		 * If we're returning unused surplus pages, only examine
@@ -1945,6 +1950,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	long needed, allocated;
 	bool alloc_ok = true;
 
+	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
 	if (needed <= 0) {
 		h->resv_huge_pages += delta;
@@ -2038,6 +2044,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	struct page *page;
 	LIST_HEAD(page_list);
 
+	lockdep_assert_held(&hugetlb_lock);
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
@@ -2640,6 +2647,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	int i;
 	LIST_HEAD(page_list);
 
+	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h))
 		return;
 
@@ -2681,6 +2689,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 {
 	int nr_nodes, node;
 
+	lockdep_assert_held(&hugetlb_lock);
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-- 
2.30.2

