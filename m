Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDAE34DC68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC2XZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54220 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhC2XZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNOK3t074256;
        Mon, 29 Mar 2021 23:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=7XROPzrFGkucbYlToRA9exFdiYfTr5yDZyzXfAg591c=;
 b=PPBBh2j9x4k8mx5oPxIq3oNUxiZ2iAn3hHlDEHMb24DC98Gc99djBmCgfo/HW+t5yqk+
 sTDGWG94HwHUqeRFI4eCyCyseNbYrJR/yzuY1KG+S6gkwfwr1Usujto4O4aFtbWFZe1f
 dQr+Z8xZU+JJuQuH8v3Qw7s+TyAv4KP8s58n271TSJVwtIayp6h+OnRoW6pt2bkMkSn5
 RjPPOJQW9PKCfb6DYXzy0oDNoErNIk35y/VGSozVlKPszfLm5c1z64U8YqUd+ezakfOX
 7ZTZEpOKxIkWk8o6i8JvHgiUDvgxKR4pSxlE09Q5RKxIfwvALCYkdhlWTJlJkCgzhVle UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37hwbnd6u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNFZJu055929;
        Mon, 29 Mar 2021 23:24:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 37je9p06qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4LRGL0SEtx/wleB74x0VRos97AuABxr6X9aDXNTSUvi3kxoxhuku6TnK0YkzA6DvrqMkAlh1Zy5xUFS+Gd1BWpqyUY9xuvrgSjth0p+PRkI8a8K6yMizFXdWYhRhyn0In4gj1u6djwRmwvl8vqFD4IFeaalswZr6NszBq188rWAALLNdvcV8ldcrVA1z4N3hAOrAP+GMGd3J1qtIeSJUcBDeCIsaSIJR3ngKtNV/xUjTSWIRYowhJjGdIvE6DraNdkQTei6cE4NIfLtHkY9GDVmf3uFpayqZSWhXun5CuyAFclSEbRILJtU8sTcvTNMomh3h7O+mB+w0J0TYLRBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XROPzrFGkucbYlToRA9exFdiYfTr5yDZyzXfAg591c=;
 b=jpq2SH6EhxJuCkLNv2z6gPVg0Ra8EYwyyD0bsGzbf+nLfZYd9Fih5lLd0ZGDBN9wQ+LVwXubHgeMS4cX4wQZifO0dd7N2SZ44Qf35exrcJ7VSpYr1XhwdEXNLKvqzkXdZ0jT43qdPTltzftlKFuQIrt8lvVR74+FP0/hoJLLPxfZP6wpqNLZiNgD/S+pjCfO0bGXPSkhDmbHcTvX20KD/peUYM95CT1XeHlknZrwtvKS0r+0X9NY8OxMS6faknd6+m4B1irtNXBNo8iYiRXrHGdXkSM2QhtlqN2VHeLIOtyCFwHz6Jxy97BGAU+hnWB4yLcTlw0hc5NlidOfsAittQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XROPzrFGkucbYlToRA9exFdiYfTr5yDZyzXfAg591c=;
 b=egdKsq3K/b4olq8A1PzaauMabunvWoEEpeBr4yiVGuxBq0Hne7RdbgKQ76GN9ZgjKRFqcBxO28bem6dPHSmYBQ8vX9YRW/+iSgUXgKyJqodrtUaOGzLQ+Dj69Rp9VXSoCU59oTFy2iiEnMFtFPVcR/ML046e2j80S6Z/erWF9VY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:25 +0000
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
Subject: [PATCH v2 4/8] hugetlb: create remove_hugetlb_page() to separate functionality
Date:   Mon, 29 Mar 2021 16:23:58 -0700
Message-Id: <20210329232402.575396-5-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4487722-d170-4fb7-1a04-08d8f309ca7f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB41485B1F4EAA65268D5907C8E27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+6keLxO2TBAhIt8seV9spWKEQTzBuMRpp3KI6LsP2nqAmW5lLXRAVNoG6YoliYce8zCNSiGD/9sKVtPjV9EjPboPs/JUOakf8F7LuGfOKoExyEyMCI0b35ii0P9BZZrvJTvfxyornPcrlZ/I0qjG+1HkfEACyR0X+30TaJ+yvennqrKJoZP0VkfVJLtUfNvgjQWCv11MgwJUIRkKfIJz4BetSR0GAjYxJoHOUYwrOE5poCUH1BaJIvaXpU+q7jFZ2j62y1lkLCY6TTkzRpgoxCj03un+aY0EU2eXV0DDsDO1QfrLhCZjBORYmelP3I3I7Bfei8nSsceVJe0cOG83FPbu52d03MbEvgLtOm1bR7c+uIr47u9Gx0MiiDSVCmtQp+KJM8i8ma+qTrgo1XoWFIh9mNIy+yoAzbohBWx8LwZSvEYoqnpTCUR9Ro0XASn4E7vh5O2nVmahQfPCt/6lci6BGOMfQurRh9a66aKraRtF10d1Z4zTn9tljYKs70Ow5GEVeZgMIePoOKdW9XoV2Jvzq0QGNFgcGm5pbOMoljffve0Yt2gO4ZY6ZlvtEb9GCKqHkvG3JiMEWG8HCKA/5+ouASQKgjFJYV5QIgxqGsy5ZMlWQa9f0utPPmAJx+hpxKYW1HB9xnplTRpIQ060Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(5660300002)(66946007)(66556008)(1076003)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e6IEW3uxjbZR1ahTMdXuEJd0OBkxz06HAiv6Sg+cOoScS2J7ClNtfMNEQiMV?=
 =?us-ascii?Q?ud/oOZerUfEfhvDV5ej+zduPMpJbv0zIlns93XhDJgfevF8YFJ6dR48lFsZc?=
 =?us-ascii?Q?PEElvItbQIk1P5mknWgH2G4M/XZSkkUcjyxHf84B3gMm63VV/zBfEZf8yIhO?=
 =?us-ascii?Q?9Xwxa4gRYfROtHeAKh5YjYVVLX5sYWTjgZGHR/gjUqgngNbSd3fRbkwZzJLR?=
 =?us-ascii?Q?eIU6ABjPwaTck8tX1wMz5I4Lqs85dDmfx0Q+dgzU6icZR5CSYG6gBFXzbsbg?=
 =?us-ascii?Q?oFQ8WxmDeFLVN9dIrme/dH2GyNcfsfjtTSrG4H1OqiCXMY0nyx2ko1Vr2Dz8?=
 =?us-ascii?Q?n5z1MUqn/E19JruU/J2Vlp++Dm1kSeLk5HeSnf4RqNdpOCViupxR6iBFcK2K?=
 =?us-ascii?Q?O40dFDTRYEiDjngGF9pX9wjFLh7FVCfdQjz/ugXRxU+sad4cGLkMp0Wvbkrm?=
 =?us-ascii?Q?0NbrpeUDVdktU9O0vj5YQ2GJqiXF9mckzZeW6bhkvhv2YXc/zHCWUOVTEfnv?=
 =?us-ascii?Q?Nb8uYVC1G+sViLg6d3sHItyLyW7hKd64kinkWiUVLIXo28m7mfKOvflSNlkW?=
 =?us-ascii?Q?oo3jZTJ03IYFFXjujcKAO9dGlk8Li0FdSF3icaMd7G1Dqd0NOyNJDZ4Vwm85?=
 =?us-ascii?Q?CPSPXo3Ig47PcSzf+4LtrlbKi6mOgHzP/LUo4MtKmkgi9fOTNv7guTNg0iwN?=
 =?us-ascii?Q?BGukm54nrrtQZkL4d9yrsHi+/4wM4yZ2HmOpFXeOl97FUvBMEdJqu3dwKbjl?=
 =?us-ascii?Q?qmxUUT7Gra6QkPYawVAphwJaN0xK5VlomZX+XUaTWCBsWD+58pCeg4dKQ1qv?=
 =?us-ascii?Q?h0QKVoeSaozdCm8y0Tr2OCu5XSzlLSq/Zix+1H6JhKb9uQd/BSmlUvQ/Gs2b?=
 =?us-ascii?Q?vQuZmPdHeylXrevW1/vE5FAN4tkOsu4r38SoBeXgsZJTFoYqU5PKCA69+Zg5?=
 =?us-ascii?Q?axo6zJZ3V2RoTSlfRUWndFZ/xIAFssXhVkAUfn3RfRjpjiHFUQaylnVepwE6?=
 =?us-ascii?Q?1wa/Q2aY268fX5UOiM1oDZy07AM7KIj7YxANysHJxcpmoeWX+gpqBkFXWouK?=
 =?us-ascii?Q?5LodZ7O0vC8Rxiqy9ZcPBSM4wljmpcCBRMeWLFeHaQKeeegBNA6i15Bfxp+I?=
 =?us-ascii?Q?keLCpC8roxisEVaRlUltwHUqhVO9Pj/xQ4Tbzf0d0pX2EyJkXncieQY5zaE+?=
 =?us-ascii?Q?bArIHFHOtopVTwda1XVRnqHq2VlG6TFLLQpq524LpIUnXe3Ud0tyzXAwj9Jx?=
 =?us-ascii?Q?UP0PxcQbaUEBxqLap3cA7zKxRi3KjfnrTwuc8ZaltVYA1Ilj6pDIJjXMdHdt?=
 =?us-ascii?Q?Z3mTrIr4OYeoXGAhFsM+jpcU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4487722-d170-4fb7-1a04-08d8f309ca7f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:25.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frHFy/+U4/o2wn1ydhjhD64UKAh4ahgXEgZvpnipI/AMw1tKYezYRV6oH/TuGuo7Dkfzi7Ml4rHqaoJkduGq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-GUID: MjWLei6ZqedJkNYUHb27k5wPeRLtEti-
X-Proofpoint-ORIG-GUID: MjWLei6ZqedJkNYUHb27k5wPeRLtEti-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new remove_hugetlb_page() routine is designed to remove a hugetlb
page from hugetlbfs processing.  It will remove the page from the active
or free list, update global counters and set the compound page
destructor to NULL so that PageHuge() will return false for the 'page'.
After this call, the 'page' can be treated as a normal compound page or
a collection of base size pages.

remove_hugetlb_page is to be called with the hugetlb_lock held.

Creating this routine and separating functionality is in preparation for
restructuring code to reduce lock hold times.  This commit should not
introduce any changes to functionality.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 67 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8497a3598c86..16beabbbbe49 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1331,6 +1331,43 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+/*
+ * Remove hugetlb page from lists, and update dtor so that page appears
+ * as just a compound page.  A reference is held on the page.
+ *
+ * Must be called with hugetlb lock held.
+ */
+static void remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	int nid = page_to_nid(page);
+
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		return;
+
+	list_del(&page->lru);
+
+	if (HPageFreed(page)) {
+		h->free_huge_pages--;
+		h->free_huge_pages_node[nid]--;
+		ClearHPageFreed(page);
+	}
+	if (adjust_surplus) {
+		h->surplus_huge_pages--;
+		h->surplus_huge_pages_node[nid]--;
+	}
+
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
+
+	ClearHPageTemporary(page);
+	set_page_refcounted(page);
+	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+
+	h->nr_huge_pages--;
+	h->nr_huge_pages_node[nid]--;
+}
+
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
@@ -1339,8 +1376,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	h->nr_huge_pages--;
-	h->nr_huge_pages_node[page_to_nid(page)]--;
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1348,10 +1383,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
-	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
-	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
@@ -1419,15 +1450,12 @@ static void __free_huge_page(struct page *page)
 		h->resv_huge_pages++;
 
 	if (HPageTemporary(page)) {
-		list_del(&page->lru);
-		ClearHPageTemporary(page);
+		remove_hugetlb_page(h, page, false);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
-		list_del(&page->lru);
+		remove_hugetlb_page(h, page, true);
 		update_and_free_page(h, page);
-		h->surplus_huge_pages--;
-		h->surplus_huge_pages_node[nid]--;
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -1712,13 +1740,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 			struct page *page =
 				list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
-			list_del(&page->lru);
-			h->free_huge_pages--;
-			h->free_huge_pages_node[node]--;
-			if (acct_surplus) {
-				h->surplus_huge_pages--;
-				h->surplus_huge_pages_node[node]--;
-			}
+			remove_hugetlb_page(h, page, acct_surplus);
 			update_and_free_page(h, page);
 			ret = 1;
 			break;
@@ -1756,7 +1778,6 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1787,9 +1808,7 @@ int dissolve_free_huge_page(struct page *page)
 			SetPageHWPoison(page);
 			ClearPageHWPoison(head);
 		}
-		list_del(&head->lru);
-		h->free_huge_pages--;
-		h->free_huge_pages_node[nid]--;
+		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
 		update_and_free_page(h, head);
 		rc = 0;
@@ -2667,10 +2686,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 				return;
 			if (PageHighMem(page))
 				continue;
-			list_del(&page->lru);
+			remove_hugetlb_page(h, page, false);
 			update_and_free_page(h, page);
-			h->free_huge_pages--;
-			h->free_huge_pages_node[page_to_nid(page)]--;
 		}
 	}
 }
-- 
2.30.2

