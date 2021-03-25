Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943E73485E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbhCYA3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33882 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbhCYA3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0Ou8Q091759;
        Thu, 25 Mar 2021 00:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=CeG/KlUR9a0yxn1POE/snKgA7hl8ZIq7hVyqToL0PmA=;
 b=uDWVDlo1yEmJC5DSA/IvdRArU7EsYMrPM6c3E2WloEN3AfFZg0eb33JI31S6a3FJudQd
 KaErDhDr4thkseDmDe6Qe/OFoiU6Cx8IThV5YB0593Gt0HEL/heZpjcN7C3lIoo9B6qD
 Xq7i8QDGLMGAhZFN19t66bLJqJo0KhdaqCfYAiLzGxAvLhnjnfW3H69JtBlM4KSrJIh4
 Th2ndddgwmTQhTT29prUm5NvaGlD0dLnGvSyk9SIPOcS7ViuTZhLXXpa9HojR8gV4jAQ
 McnzVgKJQeulZXMwzHfMXKpXPNYr2fF8ig1xGBQ5dFqbI1wYUU1FgHjBLhePopmEmuFN kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37d6jbmrs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0QTDQ040331;
        Thu, 25 Mar 2021 00:29:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 37dty18p2t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+okZx3IVQcBDINOF6VhEzwCnPLSTT5iRLMBExQnvlFmn/Zy3PEpOiLrJegM60FzHnGjPiMQvAUpfl91iAz4g6RieWkqN0qe7OP7qCC0FKNPkt7pP61hLRORWz1qeTTOgFjVv+67pX0Xqr8PXXOBpamLKmu1AgWFZd0gRkqp6p1XfPBD6m8dAcw7zBAz0PBjQ7USAxzER5tPb6ZEs7zQE00S3WpIOjHWik6qsvNfegBIpqurTCjjBnStCvFsDTJaKEu9o6yEg/mmLt5brXLoXnyOmA5uAbGCPWIWtRU8oY80F088YjJDzIrSim1CBpyKNk9KfiXcGdn61R/HMlOYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeG/KlUR9a0yxn1POE/snKgA7hl8ZIq7hVyqToL0PmA=;
 b=WxNAIo8pJUabRG69cuf41cNfDrFogHlWR6GPcli+aM+fGvCULUqHV9B+Ukke9db5aqflLVwjkoqTyhew8swZ2Qvfv3jc0xyJWDYtgVWJrr6/S5NwynBtTbIvfgHSqBaZB6hWL2q5KSoDduoe6L4Z2YtClFORM8oFs03drW/SlCqjAvCY0wZPHwaRQ5L/JN3JrEUQNzTwlgahmTNaU15ogPBrLstNzGsomB3lL9n5VJSCZUfVM+A85cmVIDHOLF1TmZKfAfbv4s+kG6J6FNeW9U+Pb19X2D2JVFeZTemPgzj0dhN/MfMvTL1W+e57R26rvqcwMlbJhc1fHHprHCXPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeG/KlUR9a0yxn1POE/snKgA7hl8ZIq7hVyqToL0PmA=;
 b=rYSMe/FhMFIKy7RdLPsrtoPLY1ZZVE0PCBIN4RGdwE0a4XgvHUVX0hGo+K082sGuK3b7vFHt9w9NIW32Wm87Ph+zn9DXqhIFrAzdeglrOylbZXesQbeCbeinpbJYHKpkky/SRFh0ORdTXISvhxFKPZ31tUCt/xntNgltA2ZK9Pw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3875.namprd10.prod.outlook.com (2603:10b6:a03:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:29:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:28:59 +0000
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
Subject: [PATCH 4/8] hugetlb: create remove_hugetlb_page() to separate functionality
Date:   Wed, 24 Mar 2021 17:28:31 -0700
Message-Id: <20210325002835.216118-5-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:28:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2071e5e3-0d6e-4ed3-f265-08d8ef24fbc2
X-MS-TrafficTypeDiagnostic: BY5PR10MB3875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB387586DA0C3D4AA267F175E8E2629@BY5PR10MB3875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EitNTb1PGBVMt1FNx1Q0IQj9OQU9houARzDjVDeVCxpwEHbETanWn56f/Av+QiL58mXfj+BuxDGl2U1jNtSiZes/XxWFmtPChDDNx81x1NoJUYI2BGuVcog8EE7C1WklkG7erguU3FpQ6mB6wtNmkhSta8cL5KSSZbz088dfGashYq9mOvU+ar4wws7G6vl3QlakBOwTzU9sttrsWiSI+UcaC/u3JPocvw6h+wCzb4N7ou2M6uzGd5Q27skPl2Qk0k3QW1NbmCQ9U8DNv4fw0htADtTcyVUIzUhRlJRztU0efnUsc9TM49g2lYKQr1AMFmEfMOctoOmb3KbIfOSz4XpDFj1+/Zf04cNe0OoQLWrT+4acyBkyzo//4qTYvnisYnAulBH9Wn3LGzNeiEbhdCu/OPWnTAAZ5CAdCAISV995OkULmzcQmY96wnEg9aLpunZvCtvVIaYv/lmavzrV4p1nS7JbGLhb0KzazyhHcQ311dej2soKKt0jKwZ2wrEEybsTdzpbRR//+xUqIrsJhPk1ZKHdgyqrpj7jI2Z2uS18k6cNKeI8kvU1mJJ1FiENgQzFTxmTnmV/d9Fz2ZlXZCLjq0o/LKIJRoN6XLIJgzGYHsbd/nQYXMeWEb1aAeqhwfbghrMNQDytZ7aXXxroA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(366004)(136003)(83380400001)(6486002)(52116002)(186003)(4326008)(66946007)(7696005)(2906002)(26005)(16526019)(66556008)(6666004)(5660300002)(66476007)(8936002)(44832011)(36756003)(316002)(478600001)(54906003)(2616005)(8676002)(1076003)(86362001)(38100700001)(956004)(7416002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kz1vvBB4MbZLoi7ZP9yFwB7b2DXjFcNYscMJiufv/5NPS/jCGhtEZMhuCbNo?=
 =?us-ascii?Q?PlvydZTqUWCnngXTWp5kStyE2pPEbpm0U7bDg19nmjRZxKfaMO2WukZC9i0H?=
 =?us-ascii?Q?x9KRG11tsZtb6X9DZbqeWXQgn75EsmCGlB+449SKPlPcVPOdzfd6pN1RPTrT?=
 =?us-ascii?Q?824oatDdU4WCv0faYKx9fM1A9dIYifXKZUn9bxUDt3+B9tUyPNP/gUnGfxJb?=
 =?us-ascii?Q?zK9B5Prnbi7m/qcF2UXKmAi5Z1lmWcANbHaVGwhJsTkCYVqXlb/zm10E+hl7?=
 =?us-ascii?Q?F/fo6SZm61jmH4fmeVU1JVRfOTB5n/2D1C5g8V4Al9FIi+DSBPWHiQ6H8MZN?=
 =?us-ascii?Q?fOyGqaIVsX792U+HM+Tj7JOGHI6Vn8geh6PpMfBODDsEallyoJnPQ44rCfue?=
 =?us-ascii?Q?gJ1W7M49IRPVPpWzRE4Up1vaDMcxFZxYcvixZebHEKJy1SQApEkMOsd3KeZ8?=
 =?us-ascii?Q?gufBQOnPLuiT32qj5vGY5iSA5hGTjgp8CY+1wLL4qh4bYPNEynJRpdnDOV6b?=
 =?us-ascii?Q?xwJe9VRFTGd4CmFv540R5pQo7ZIV5RJ///pfvxGKZhtBiTqojLOcMkfvJWBl?=
 =?us-ascii?Q?ucRtbGiMk/d2f34BxmlV8tNUAV3HbxV4aIBL+0G3zfF0d+dqC5GElcgLzUcj?=
 =?us-ascii?Q?i1aOg5Q+Om/TlI8kVnOd76t1/Zo+ebGNAGEn5X40snttJMhbPo0OAbrFlHjo?=
 =?us-ascii?Q?nSwJfTigEm1E6oY4vJYV5EwXKQ4YbhcVn/W/6MX+haPV1urDdyXkpcEJbRa/?=
 =?us-ascii?Q?LwsLXrYEP+2uIqrfWrjCR/GJEXsWFXoXn6N2lfH8KJsrSclKpaxYZSBQuKy4?=
 =?us-ascii?Q?LljjLSAD4aSZyzDzVezAkXSNUmZUa9V+WEgZWnIUZMujPo2CC0xTOyAEEJ9X?=
 =?us-ascii?Q?/GGOi8uTPwEWw0PQb9C+I9qDGwQ2B2vkR/EdMpYylGAcM9KP2rqN6+GM19tD?=
 =?us-ascii?Q?mNIcZeMWe6ch/zPiA7u1+XOmH4Q2+INawQGCAjnPw4itASao4Goerp33Scsq?=
 =?us-ascii?Q?IXjMIEdcbmypAg9xgaPNPSHUraGoKRF351A1kOiScJydIKJSU/AHGITVGYH2?=
 =?us-ascii?Q?GEppcvlCiAkyZXJVn0dHnk1DqzWDUbEKqObGVP2Mks9w+7fKILV6Y2whZuJw?=
 =?us-ascii?Q?kQnvyAiJqFPgNFk6/kO62fU5hjB3qEdIrrGCq0xm+GNKHVrqmIfFkhz8l/iv?=
 =?us-ascii?Q?6qKcDGTLfx7FOQ1tWtLkHsT8e7eYhWBGV6T+jP9c4SUPY88+emErUN7zcWYh?=
 =?us-ascii?Q?9Dwj/X/Z6h+ZQZtadG+8CfAL3STWReT1MBg9YH8NYe7zLuVqNzRHbUujVYYI?=
 =?us-ascii?Q?SCje2pPKl/AtC23W2+X8vySA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2071e5e3-0d6e-4ed3-f265-08d8ef24fbc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:28:59.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+ws5csyBI4C9xKRlOr+evtMNli+seJvRCdpSOtj/iDocNs7rSRy7Mpk5OnQb6NjB7xSqNQJ5WNuCJ+LHm0zzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250000
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
restructuring code to reduce lock hold times.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 70 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 404b0b1c5258..3938ec086b5c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1327,6 +1327,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+/*
+ * Remove hugetlb page from lists, and update dtor so that page appears
+ * as just a compound page.  A reference is held on the page.
+ * NOTE: hugetlb specific page flags stored in page->private are not
+ *	 automatically cleared.  These flags may be used in routines
+ *	 which operate on the resulting compound page.
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
@@ -1335,8 +1375,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	h->nr_huge_pages--;
-	h->nr_huge_pages_node[page_to_nid(page)]--;
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1344,10 +1382,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
@@ -1415,15 +1449,12 @@ static void __free_huge_page(struct page *page)
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
@@ -1708,13 +1739,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1752,7 +1777,6 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1783,9 +1807,7 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -2553,10 +2575,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
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

