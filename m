Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC43635A826
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhDIUyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhDIUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139Knf7h127832;
        Fri, 9 Apr 2021 20:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=1L9TwhsBA2v6El6t2CvKm6wFKzwQGGXKgiuMf5bHZEU=;
 b=Ji+3YRIXB+0ed59Sp95YBBOFGaib2lYum9eNjkOgMg9FiaEWvJoDHoqImiXvslrAfOk5
 pyMV3IV1d9lSw6FMpy32TWgwZVPAb7ErYkPdjDBpNVgH5XcmZh5P9QyumzNeN3SY7Z2H
 uDD/hrX+2VZHcmoeZr64k5PX6tiH1BTuqlht4LDbhPKJDu5dDNjFvluyChsNstHBtbEV
 zFZu0IZyxaGY1xbzs/OYAwI5hby5ZDQHhx63bU2Gm2xPUJefc/lxqZpK7K51wZZz75IR
 x+ioeEU16aNgw8wvcWKipFPDOJMbXkUYfJjLLCLyFnf2sSGSoy7S9HwGrBSIEnz8XiQ+ rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37rva6apka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KjFEX022496;
        Fri, 9 Apr 2021 20:53:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 37rvb30bx4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE7ECFMrhReICepoXYJBwjuszCZYMOFOGleOX8DviAHkU5BypYkTFMUZ+l9EvFPb5ArybaI+/5O08rXYnXENbcUbc3pb9E8g+MhyGrmlvNg4c43rK9YiK+AkkSljFvQlrG31Guzm9EisavmXlTVmGvmddANa3J2Wd6kl9/EWCbmf1XhUNoO3NTJiopgiL91Qw5nKyHZaNSXoFps0rx74hu6qqM3rGqDhJdTj5Y1Kaj6kDFKDwU+/Oq+6DY3MVBpti73HRQMCG4OKHmjmNtysbuynAxcIBgAREi3pDpZ/ZJRhNg9/C9V/9LifqCd4Zkp2Ad4dCpywzp/dhhBHQqU3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L9TwhsBA2v6El6t2CvKm6wFKzwQGGXKgiuMf5bHZEU=;
 b=f4fIUHup2GGwb4wzR972oRhwyCxDlvtwRQJSJyw9Uf7ZsLaZ9HFObjpZZtPMwPyxd1VFYqV3Z0qoGXXlA/YVSXzYi5qo1dbwfWRO7gWRLps9qnG0WsqYK9+H0D/OvLIhXNb3jtiSCFBcAaLdLXiwm3a3doAgAgKu/qzEBrFL0WCwpUSWfk0h+K+i+zCmYSBKRGEzLqL1mDuAbX57N7jlBPIgpcvxDcJqvKr3xoZUMq8TUMgj2IA62gMFcqPgFvxCR7XMmoaObzoWLrSv4S8ZUWIuOKddh+2+MqpM8DMsLyaqnlmc58xb4wxL67VPFdJYZiDb8iMAGrYuNfPHOQYOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L9TwhsBA2v6El6t2CvKm6wFKzwQGGXKgiuMf5bHZEU=;
 b=KcnFbilCdpUn0npJp69+dTb/O776f6O2yKHfcmevhCpP+K465rTNf+tG7T2ytLJ7ydtdTZFD5Zp63ho0wrYopEEj0AXeo1H4BPdsuTaHG2QFAFkCBwehAWPvwy6xdfIzbrMVZ+dcN3aqbfBSYzVzMpFLBSxsEfbOON2nhxKxbEw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 20:53:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:17 +0000
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
Subject: [PATCH v5 4/8] hugetlb: create remove_hugetlb_page() to separate functionality
Date:   Fri,  9 Apr 2021 13:52:50 -0700
Message-Id: <20210409205254.242291-5-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705f21d4-ebbc-43c0-9094-08d8fb99800c
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39726E24C98309D2307BAADFE2739@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjsNdynHYMIhMkmedTmsw0S2ccO+2pxzGmXMnzIm119bsEO51RwEukKrAkKN8l3p4KXyN47idaLYQ5sHEc+DV8RjJ0+5WfmWS1wCCqBA9vxIBwlJs236QRvLn5T7nEB1nMjdfeNmKyBU4ML/oHlmiOzRuTErTlBZRGCh7eGkmT1uM9JKkNNaUhRopBcOokCgznHrCY3xxVnsDldqfUpmdhyVYA0wnPDeX1roaBlSaYPA30TANFbJTG/A27oGmKfVLK9oytqmQGfZBZJO8IVPH69BWYSkuyV+4QhCK4zzMtLoSUrKZFH1tClkO8ngSRUEo2fPghWV0OGCRFJ/7tdzL0QIyRo0w1LGo97M3zOgEjUOIyFdN3f/Zmj4hBYrbosOaddpwPZRWAQ3VET4oiryhMwVtBk8+DTmXD9t7eUasNNXLLujL3bhqM4lqTUSRTCqY8v300O0xpBFJW21gkZeneHjvqPidFdHVl5sC3EG7bMfCUkJ+7njA6vQEdpV+W0JY4hY0YaJOnus+qN748xscsUG30gAt22QbIgmmJ5eg+kOsRPxNw2uukxIBdFQENhbn109sFPHd6llInKwpC+2dNImrK04e3XmBT69iChTIOMNsqIwmqrvlOcY+t4L7ZzahBp/OSoXn0qxSNCC1/35fI5QF8/rE+tb2xJjFJjNB1zHDasD5M9r/p5jTvuUaxcA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700001)(5660300002)(66946007)(7416002)(956004)(6486002)(83380400001)(66556008)(8936002)(66476007)(4326008)(316002)(6666004)(6916009)(54906003)(44832011)(7696005)(2906002)(478600001)(1076003)(52116002)(16526019)(38350700001)(107886003)(36756003)(26005)(86362001)(8676002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zwVXDXeahgFKmv6x6AuzfJCbt2u0PuaaqLdivBX+S8QxDb/iaF9P3rlCILU9?=
 =?us-ascii?Q?N8Q7FKQ/uveloB15/73HtBep44UIUwiSVbzkis8yTLEMTnUwXsGMb9DDQk//?=
 =?us-ascii?Q?blOjumG0z+QGfxZU3Q7y0nbvZIftLaooxHXsI0vyiof1E9POgwoP29c+OLw+?=
 =?us-ascii?Q?v3NrXHJ9X6O1agM+QWHlDYRH+xaAt064LimaaqRUM1u8vpGRXJrSkfrqwnTl?=
 =?us-ascii?Q?p03u4Unm8SVYpgIVSe4HbYt+44w5AJ2C3Haj8ylireXSbeawp8TiGs/MpSit?=
 =?us-ascii?Q?fSi/r0RMxTep0dmdLzvr6zvXe24dhI6i6CtWH3AChaxHNKSn9CYD2lcj2EqO?=
 =?us-ascii?Q?F5kxg1GhfuFSC3a1n65L5n7uvSDAkT5FxJwD1WHFZ7ijt+Ativof81ioAzac?=
 =?us-ascii?Q?PjiGWlq1xfB9VnL+9YtmJdF0n6a2mHQTmQEAn9PTsL0SR+eNredfWTzbtyXc?=
 =?us-ascii?Q?QsdFCp6MoYsLiRw/ut8iF5/pUokOZq+LIUhmNleEWhV5vHx0iWyDmYMugrS5?=
 =?us-ascii?Q?diRHABpxecSSxYaPquAKLMT4/0fdTr4vOYCedPuQLFZnFadA0RzmX70fWV9h?=
 =?us-ascii?Q?BITLJINNLuYU9tehfBpnyw/jIVllMuFFhuMHIFGZvl79Dxk81CZbQ+LqY0U7?=
 =?us-ascii?Q?RqcRgovOK1Oktyw5ZQUTgll9YOX14nHMHIFU0nkuEkldg90YR3jAsQvUzG9o?=
 =?us-ascii?Q?UrMeQIz3E9I0EVHtKBYOpAz5hKsO+/hSmKDbZdG8dcoC9KQjZT2jffhxJEHn?=
 =?us-ascii?Q?/ZO9gBLrgdhe57Qb3Nf/ngKArSw/7c0DKNmVxOPHZ4d8JOaE1gIRg/Ks93YR?=
 =?us-ascii?Q?P/CsZzWN2N0J3s87I2FnS6Z9SVsBG+Sa7iNMBnQmFO3A2vDhnklHH5rjJvP5?=
 =?us-ascii?Q?TO5T0PoVBauOBwMX/0agC9R77/DkfmL2ntXDyD4zO0wwfvFGLwkoN9fkb6JO?=
 =?us-ascii?Q?Azn5D5SieYh5Oji5efZm5nWIqG63s6ZxuYghIeT/MWRn/gYK0d9a+pOsWL+m?=
 =?us-ascii?Q?1auBKmy1KtPzbZtOUj8k2b1y5ICbaPAw3qwDeOWims9iZsZcBiEZT00oE16P?=
 =?us-ascii?Q?flOyUN/K+QK96Q00lCLPcr57P6wlfVMHpsdCA+Ppet/hKuqdEcNw9iWPpQXc?=
 =?us-ascii?Q?BN3e2NNEjKKHcuZxstLdZ2ktEAoAAQSY72cAK4PTvQu7lKLr1q6aDYi4KzdZ?=
 =?us-ascii?Q?ocNAz+dCNkTBSo8iMWy/iXOrA1u5MaNIPA2xtibs/U6JpqqOq6sVxDuOi4B+?=
 =?us-ascii?Q?+7epWXR7sD1vw8OMu0ccVIlj5oA4qhVOV/O7Tzfwi1Y/wyTjStBFx35cBjvP?=
 =?us-ascii?Q?mSr7Yu6rTmtx3KckZYWuwE+/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f21d4-ebbc-43c0-9094-08d8fb99800c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:17.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/6zkBB878cMXYRc4lbNPAdKYdcWZNPQROJaOCPMatJToLo2FMP989JCAGYXY2ILZqMspFnSqSYOsjH2BjbDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
X-Proofpoint-GUID: pQWPBP5n8a82B3gIMuRWlF3Rn2ymmEL4
X-Proofpoint-ORIG-GUID: pQWPBP5n8a82B3gIMuRWlF3Rn2ymmEL4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new remove_hugetlb_page() routine is designed to remove a hugetlb
page from hugetlbfs processing.  It will remove the page from the active
or free list, update global counters and set the compound page
destructor to NULL so that PageHuge() will return false for the 'page'.
After this call, the 'page' can be treated as a normal compound page or
a collection of base size pages.

update_and_free_page no longer decrements h->nr_huge_pages{_node} as
this is performed in remove_hugetlb_page.  The only functionality
performed by update_and_free_page is to free the base pages to the lower
level allocators.

update_and_free_page is typically called after remove_hugetlb_page.

remove_hugetlb_page is to be called with the hugetlb_lock held.

Creating this routine and separating functionality is in preparation for
restructuring code to reduce lock hold times.  This commit should not
introduce any changes to functionality.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 65 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c8799a480784..773081709916 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1326,6 +1326,41 @@ static inline void destroy_compound_gigantic_page(struct page *page,
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
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
+
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		return;
+
+	list_del(&page->lru);
+
+	if (HPageFreed(page)) {
+		h->free_huge_pages--;
+		h->free_huge_pages_node[nid]--;
+	}
+	if (adjust_surplus) {
+		h->surplus_huge_pages--;
+		h->surplus_huge_pages_node[nid]--;
+	}
+
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
@@ -1334,8 +1369,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	h->nr_huge_pages--;
-	h->nr_huge_pages_node[page_to_nid(page)]--;
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1343,10 +1376,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
@@ -1414,15 +1443,12 @@ static void __free_huge_page(struct page *page)
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
@@ -1707,13 +1733,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1751,7 +1771,6 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1782,9 +1801,7 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -2552,10 +2569,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
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

