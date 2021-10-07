Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D3425A91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhJGSWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:22:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60704 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243612AbhJGSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:21:58 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197I450W009645;
        Thu, 7 Oct 2021 18:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=V3c6Vzy/AeULLYVxMtzlAeTECPEIEraba5pN5XoNpVk=;
 b=NIYFrSdeUdkS5axxwnwLtz6XSKrU/HJ++Ohi6e8VsSdjkB9jrdmSrVBuTrcIaIB0WGAM
 2THVFykK+9hx0I7C1LdFrqzBQHbXSAimqJH+U0bqg6u/A44mscp4LPKYYj3XU8T3PnDY
 QSALX0QgMbqIxrLalUpu2w4bhNO9AFc9HB3acZfgk8+QH1r7B1GScfrCHfGYzrYwIIoH
 oD9GlRkjhER0fJ2VywDs5XR3kB6KhmteHIywerK/3ygXc+w3K7+rxMgLkNupy5H7ytlg
 arV8DNhioMA68snxDxqBbW8MzB5KFFQRZ3F6DDSwar5H+jvWri0NqJbJPtsLBJ3lYRKk 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhxbs3ry8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197IAnqi177633;
        Thu, 7 Oct 2021 18:19:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3bf16x9114-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY/aTTpsJZ1Nq1vYXTTnvmrk2I9Bip4M9NjlwOxlDJun+TyAPwSmxLdV9ncuIhSSKKcJnbo7wkciQ+O5sqDFWi6nb6/yeawZe6ucVk0RYaMlDgqAOW9dlSATpV2agQs+n+G6bu3HIKl/2dG7xcU8aCWTV99TtNGga2LtWtIVebAPuFfk5PW52o1a729GuT5D9XRO39BumPU52e/WRkSZWi4EvuYNAshHx47OOvtbsuJ9uAGajDYAIa91TbNjrfl+fOxRjPQVCB0lAEtMhFdtYxpeokBlAHvO2F76cdAgteroptrGJIDvTk0XTxXbECe5/EQ+a8OWHWmBscStdhgiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3c6Vzy/AeULLYVxMtzlAeTECPEIEraba5pN5XoNpVk=;
 b=deJBw55B8wbOwcVLKaLpXVqlGYJQDU+J74vSecoFsGloTTo2Q/jyR3lZDy0m3mQ/5tZpBdulU2ZoOCO40tmKjwZY++HuI1DiiZHV4L7bplaAebYE9LwjEJCtb/GkrN/ae2iOifRBk2NgQ2pzVIG3QdSN87guOSyn7QR1jaC7NSY8d4Pn6V3EwO2wI3Fngocu5NzfC7EnW+Vwh8GQg1rcsgW/FSfRRHKtEMb4uuD8h2PSY732Wg/3uEBXTZVBDyaC7Xhy51p/8yPRkhheQOInnaGL7pnXiuwI+xjyCJ8VpB2/Zzd1gmBDgL7lHCKkWw1dW4aAywFlM7KRpxkPkU3Ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3c6Vzy/AeULLYVxMtzlAeTECPEIEraba5pN5XoNpVk=;
 b=y8s+o8tRElAA0yp2QHDr+6kUDii0v6CyXAPqPMPiu0V8cNhDdspDDBcMD5d5XI8S8rwYODhtKBPBaY4hHqewSH1LLzlfYu5G64Vayjy9oypj0Rw3xz+Q7LrgJgypmiJQ2Rn3/N7T8wsP9h+mIMiyzdOjWejJMANuHvb3eMznH1A=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 18:19:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 18:19:41 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 4/5] hugetlb: add demote bool to gigantic page routines
Date:   Thu,  7 Oct 2021 11:19:17 -0700
Message-Id: <20211007181918.136982-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211007181918.136982-1-mike.kravetz@oracle.com>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 18:19:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb97c48-61bf-4062-bbfd-08d989bf07c8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2552D323E4684500A5EBD6B8E2B19@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyYOo1i0YzPExBwo97Mbb2WeqXXeBo1+VXLbUti9+6cIjqwyz8+ER4XF/clVCDK2U8RodvIRVeFPYt55zy2fAzAYHCqtHAiesel+0C44kdRlHj6qiiYDzlE+VNj2yKJTVhNYo2W/C4XBJmRfzjk7PTPyExoK5zXb4bEz6ysoLkiVVPCyfCE5GDfBnjQax0qjKl+W0KS12fC1hfYfMNtYL4BnbSH4mEkITWw8kXNgSjFO37V8ckImogJZADRWPQN3BIhfhyyo3rjrTCicKyQUvKO2LWvvXcB+HLvvfSpShMp4PY0CX29aVJPIBQovwOiKeVk31V76/JHMhNA1O6eb2B0bZlA32Y5D9NsMhOkMmwSHarzLWcMB7uPo0LlOTISqh6hEJNz2kiYGi6vMpCrpKwt+65UYmLsV81jVOFi3mY7wwtltK4/yLC846EzTNq3vmbP45OaJ8j+julEGgUhND8XOIrL581pLXQARJBGCVKABAV6z0SgaQGEdvXoIUQ3Vs1bSeVrsEaOvDAJlGtLNcl7IcmILU8OIafSamHV3ZpsBTQjAfjFoilCBEnSlN4bb6e2Yn6Vk35FJSbz02xVQLhuqCdIZ9jd2lBkDCYhYrgU0+owpVXoEhIEWFd9TNf3SubHihvi2n/qxtJ7JViyjIQ+0tGQ7AyHnJICyc+78ZwyIF7WOGaD4V63GnWe8HMZAh6mCCQuxPkyjOZVZByCG/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38350700002)(316002)(7416002)(44832011)(5660300002)(6486002)(107886003)(2906002)(1076003)(186003)(508600001)(54906003)(38100700002)(6666004)(66476007)(36756003)(66946007)(4326008)(66556008)(52116002)(7696005)(956004)(2616005)(26005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6oKAZgR5eczfhf48LzePNXUP3PUHy1PAByYHz35zdtQ3vBffNxojje+hSfk?=
 =?us-ascii?Q?cWNY7XiuZChyNRQpYVhhk0fAtQRQtB/kgGjtGwCL7qnXiR9A9ywcxD55DOVv?=
 =?us-ascii?Q?n4P7p1SO5sFtYb+zVFQQQTx3hCZVv0fXF4WVkCAAO5a6MCQIjRVfz7iIkvP1?=
 =?us-ascii?Q?akmO6JN+8kZggACzAfUB4AyGqorTJkipnyIniQXSFIYQQO9Tovb9ZU/DCmAJ?=
 =?us-ascii?Q?DXnhN06ujdjf+vksRfSael0iTkH6SL/W6qX/59JTSwBn/maib+xO/XBl4rRq?=
 =?us-ascii?Q?n2xCkGtLf29WzgK/J9LvgYTw9I87erM2ole4bXlJW2qiUmEwh16O2uyYD03S?=
 =?us-ascii?Q?PNPrsAb+JUDweLofrE9pBxAwKSrFKVNnKCkJEsJ+twnUsMq2P4nJhz7A0YxZ?=
 =?us-ascii?Q?GCk4sqHhAQLdS6o6L0e0bANlrV3e3LA0cXuGvCFvvnGuR5e7JB7aRbdFi7yw?=
 =?us-ascii?Q?OTCgPbCikCEVlqYahXBat+lxEMEMjVLVWScDcFp+/ufS8cquZBZ24qCiLCAY?=
 =?us-ascii?Q?WDyEOHXfeScwASM0jYkGvKkUdbhG91I7Lwj3nFvkETcnq0hrXoNTkK7OzE2Q?=
 =?us-ascii?Q?f6vfvMxHYyi50isI8FDEfdh27ttJsKEGnDUdgLw8QOUNalAhOD3zB8xFNnes?=
 =?us-ascii?Q?BN9rWgw5Mqvzfbp0XtYpaj7RqrYRbA9rtvTPHCEHQQZORp6Kf9GmsCEwv6et?=
 =?us-ascii?Q?1pWcEmD4Y261ULRHKskDI4RbBTB2I0dFelTepGTCR7IavW5neOT3klEzfdhc?=
 =?us-ascii?Q?oosxsEIaLF/JVZsJcK2deaXLuxWBMsP4MaeUIk0PoeUpl8XXhHNyTsWevNP6?=
 =?us-ascii?Q?zU/RNaa+kcTWiO8vUFhUXQqg2jJG/iIjudmwvqdBJSveY0alGSxgoy7eXMY4?=
 =?us-ascii?Q?3fLoEfe/WoxhyieZU96KFFTcKCHeSJPl5pepFGX4CIVzaO451RbIHKDoa+5F?=
 =?us-ascii?Q?yIAm2xbxVshYa8WhuTqP132Od5GMTnh5BeUKDJ4O2SFU8HdDJOw1ry9D5Jls?=
 =?us-ascii?Q?8r5S8VJVUl2qWmCN+imqvE46yGyZm7FQY6N64ZaXXn5oq1DttrXk5OR5DILl?=
 =?us-ascii?Q?8M2enc9eONYORj8ifXLNvMt7AKqwPp55mFouNqnRt2faoZPuJ0L2PYVy+fSN?=
 =?us-ascii?Q?s7jmyiB1PEqizSLyHW0cy7UOJmQ+CyeNjo+631gmqajL6hVkoHADJ5Rh36q6?=
 =?us-ascii?Q?W/3QvLv5VSYeMgh/a4lbj2MZ1aYM8ugyYP+MfdWgmZP7/LsHvoCtG3dqUtwY?=
 =?us-ascii?Q?/GjSdar624SGvltpTtA9N6NY0oNV1UlG3ArrtkNohntmEvXV7RBlwq9hqbsX?=
 =?us-ascii?Q?O5Hh7AzrCwcdRHhkPMUCxcp7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb97c48-61bf-4062-bbfd-08d989bf07c8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 18:19:41.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtYdt6kiGFywvreNtwuwkPFRdw17kxX4GHhopvh4KL0cWG6SpIhuXugphZO+c6nM5cZ+Zq/VQnffyJUtX/KXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070118
X-Proofpoint-GUID: Ig5iUroze3oKPTKexSaLSL63zx7RCC_2
X-Proofpoint-ORIG-GUID: Ig5iUroze3oKPTKexSaLSL63zx7RCC_2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routines remove_hugetlb_page and destroy_compound_gigantic_page
will remove a gigantic page and make the set of base pages ready to be
returned to a lower level allocator.  In the process of doing this, they
make all base pages reference counted.

The routine prep_compound_gigantic_page creates a gigantic page from a
set of base pages.  It assumes that all these base pages are reference
counted.

During demotion, a gigantic page will be split into huge pages of a
smaller size.  This logically involves use of the routines,
remove_hugetlb_page, and destroy_compound_gigantic_page followed by
prep_compound*_page for each smaller huge page.

When pages are reference counted (ref count >= 0), additional
speculative ref counts could be taken.  This could result in errors
while demoting a huge page.  Quite a bit of code would need to be
created to handle all possible issues.

Instead of dealing with the possibility of speculative ref counts, avoid
the possibility by keeping ref counts at zero during the demote process.
Add a boolean 'demote' to the routines remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page.  If the
boolean is set, the remove and destroy routines will not reference count
pages and the prep routine will not expect reference counted pages.

'*_for_demote' wrappers of the routines will be added in a subsequent
patch where this functionality is used.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 54 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 563338f4dbc4..794e0c4c1b3c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1271,8 +1271,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
+static void __destroy_compound_gigantic_page(struct page *page,
+					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
@@ -1284,7 +1284,8 @@ static void destroy_compound_gigantic_page(struct page *page,
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
-		set_page_refcounted(p);
+		if (!demote)
+			set_page_refcounted(p);
 	}
 
 	set_compound_order(page, 0);
@@ -1292,6 +1293,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_gigantic_page(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, false);
+}
+
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
@@ -1364,12 +1371,15 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 
 /*
  * Remove hugetlb page from lists, and update dtor so that page appears
- * as just a compound page.  A reference is held on the page.
+ * as just a compound page.
+ *
+ * A reference is held on the page, except in the case of demote.
  *
  * Must be called with hugetlb lock held.
  */
-static void remove_hugetlb_page(struct hstate *h, struct page *page,
-							bool adjust_surplus)
+static void __remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus,
+							bool demote)
 {
 	int nid = page_to_nid(page);
 
@@ -1407,8 +1417,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	 *
 	 * This handles the case where more than one ref is held when and
 	 * after update_and_free_page is called.
+	 *
+	 * In the case of demote we do not ref count the page as it will soon
+	 * be turned into a page of smaller size.
 	 */
-	set_page_refcounted(page);
+	if (!demote)
+		set_page_refcounted(page);
 	if (hstate_is_gigantic(h))
 		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	else
@@ -1418,6 +1432,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	h->nr_huge_pages_node[nid]--;
 }
 
+static void remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, false);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1681,7 +1701,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
+								bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
@@ -1719,10 +1740,16 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * the set of pages can not be converted to a gigantic page.
 		 * The caller who allocated the pages should then discard the
 		 * pages using the appropriate free interface.
+		 *
+		 * In the case of demote, the ref count will be zero.
 		 */
-		if (!page_ref_freeze(p, 1)) {
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
-			goto out_error;
+		if (!demote) {
+			if (!page_ref_freeze(p, 1)) {
+				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+				goto out_error;
+			}
+		} else {
+			VM_BUG_ON_PAGE(page_count(p), p);
 		}
 		set_page_count(p, 0);
 		set_compound_head(p, page);
@@ -1747,6 +1774,11 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return false;
 }
 
+static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, false);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
-- 
2.31.1

