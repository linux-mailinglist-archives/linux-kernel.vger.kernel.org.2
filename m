Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6641F3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355501AbhJARyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:54:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33092 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355499AbhJARyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:54:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191GlTMq005267;
        Fri, 1 Oct 2021 17:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=7dalMIrGbHq7VXgagd4qH08OoOiTNy3EBK6658fLPVs=;
 b=ZKzm2udg054M04/WBtJhwaflGRDxfk8EwguyFou0h0QJqDJ8LUREvrBu3VvoUOd2nmgs
 6NNXt+TA8+aPtvyjQXikj9UJ9eIYG0xlPOHU3SXmV08M5xji8h/dwdHsE9IxbnbK1ha/
 Zwwy6OhzcxyJU3JRFCXnXRWYAii8zcAaIhqQ/NLMLD6JR5V0LICw4RVjS0CmQhNFOWUj
 5WU0jGO1H+5NrT+p19ZDIuLI67ZV6metIcTEYhbpXP0169Fz1MdryInQTCi/ibEUzYCn
 4wJ9psRHyVDAI76igKY8iI3ItiYyHjRsx0MT9BbZbBxvM6M0SBmm70XhPx7kyK9oC4cW DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bddu91jjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191HkMKF109010;
        Fri, 1 Oct 2021 17:52:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 3bc3chupbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC4n4Dkrnd8L4M7Sc34haDQyoNmU4jPi6QUsPWRPMkZXwOGR83W6hVkNcDz+bguPr6sw35Hri2tJ3jvePWJt9+n7plVXuaT6lb6KLFBwUCoizc45oTzyzDoZFkOsm2hYd7D2yZE/NkwC0lgqjc04CQhpzXpWePLIj6s0qThsGIE7vGP+nL4pMNd4S/F584KPcQgKncvVwZBLJX7JkLN8NPh9PzqdHzJbsk95nY7GF1vO/IWdpNQ76tFhYcS3cbLgWE5oX2xcfMfQ9qIPboRahXw13MZ8Tf1tmFIw2zCrupycGEshmz6GFLql5kE8W/a5pr5g5N9XRD2gdDKSXEzxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dalMIrGbHq7VXgagd4qH08OoOiTNy3EBK6658fLPVs=;
 b=Kf/6GnlllAHcpEY8tBtYlP000MeXZTzyt/ughJLo+L/abdoC7xo65Q7MhPRpARUiuMCRKEYnwJx/+6qo8+Ih7MwxRLnhfTAaBoleUh9rKCxiDfIsB+faH4YHGP9orY1TgOA77K6TSRo2WVt//1iWO7BntNOUGevpvLgTCoiAAVUlw/4ZEeorsfHz+74XBMHCwbMnmLSPj/8L3Gd7arw+GdNT1Pz6s2oat0vr7FPgEJd1Nhm2Wx0zwkTObd17HYPc31+6kIZsKSkiq7HaG3ovX3icQmHlqjO/W2Ab/Unx9srloj4tBpn6FS0fxnekZ+7txqmS3r8ex32WABXoMxApTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dalMIrGbHq7VXgagd4qH08OoOiTNy3EBK6658fLPVs=;
 b=HqQq8JtbWuwlo/YnZSoeQ9VapONAswUR8dIBm5XM/W6mDGtOYEUf8tmWU11a3OoyjLUlVIRcbd3a2iGSZGkTUeR58NFWJ7ipgRAogsKdR4B1rQE1ZIAsRzV57/y5+5O/43QYBlY/fmvXvt/vx5vBN1sIMwHQmNqNRGguQFTUjxc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB4924.namprd10.prod.outlook.com (2603:10b6:610:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:52:37 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 17:52:37 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 3/5] hugetlb: be sure to free demoted CMA pages to CMA
Date:   Fri,  1 Oct 2021 10:52:08 -0700
Message-Id: <20211001175210.45968-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001175210.45968-1-mike.kravetz@oracle.com>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0060.namprd22.prod.outlook.com
 (2603:10b6:300:12a::22) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:52:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a29e1f88-216a-4822-36d2-08d98504412d
X-MS-TrafficTypeDiagnostic: CH0PR10MB4924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4924E9D80E18D4C94C74C15EE2AB9@CH0PR10MB4924.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niYF+GsLFxCPgS57khWQODrCiuNKhvJ6kYV4x5EpXHv+xOPmrUaX1Rsin1McUp4XGRlPOVgmaKuhsYH/wP9FaCFqOuyAeM9LaJLNvtvQqik86aWhVTX2XFXnTPVXolVvtYm9mAllc8MA05fLbE0w/v7TlBibBudbiC4Xpz2/KZAiIoyfNkeNqGayZnZnkg4G6azdzlzJpJ1nQEJI9kLM0Bhx0yCun4KDwT2Uao0h/Nzfk+WexSojEdEpPFwz+EgyFbkRlH1F9S7l11eG8S5nUWMKF/XRHRFlATvoL5mMpvtNLdy/i/XUF/Zeccrj6h/klizwhTX49rxFuIOwpmY6m60B9YDkGbWLkTKFK7TyLmQiR+yUkG9X8NUewfBF6bkzaMMqCWajn/a2r9BuzH0zGcnYvcasQbtvdYHKyza5rxHmaQy86xn6eV7nKf/2uvxHsCC+s2Bk+PuTwwtlHD6VI8k2BTfTLPIf3EI+35jGIgvEDXvB1o/4NPpU/SZILpHaSiKEXAEiOOscghO8j1F1iQDVIxPPGOtwDp7S8GxmxMePjMtyxreHrzHTNerm8/CJHDxlaCJtWrQfku3EHqoUp63VRotXXl76DDfpvjUewnChRqIkmrt111D8TTxSbOxglhc+cOQ3PjiLASw6HcySyRuxHQNnhIM6nPYqywf1MxtYMjMU6rNaJ0D1hC3p63EzNTyxXyizhDch+MArVaymIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8676002)(8936002)(52116002)(508600001)(5660300002)(6666004)(316002)(66476007)(7696005)(54906003)(83380400001)(107886003)(44832011)(36756003)(4326008)(66556008)(7416002)(2616005)(956004)(2906002)(38100700002)(1076003)(38350700002)(26005)(186003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XnWQqhLOI5sKlyfp+RBN/8YlHYEE4Pa6vy1FDHvDpLTkvFZaQAhEFPDeD6h6?=
 =?us-ascii?Q?QgJQ5p7tZgr2BN3fpzqSefdS+oJ2HKPSWWARZiZ8S13ZuL58PuLV00vr60pM?=
 =?us-ascii?Q?3INwmgwC36bVkk6KHhLpMyHd7HxmnG2aeiluTq56Bdw5mjM3p5jKzY0tkn5C?=
 =?us-ascii?Q?S7AN1NDOQhw5rY8aOpqG26k1pHaGcTioPGEr4248QwPebdajpJnr7Rh4GXk9?=
 =?us-ascii?Q?qXv/cxJLuNY/z013YhfwnCwM7O8/Oqusz0POUif6YmALYk1VWlYmoRVMjHap?=
 =?us-ascii?Q?pCOX2BY/+V61utIIUCbzCPz9iJv8vwdMFeksPAt8RnG9GIn0IaNK8bO67nxZ?=
 =?us-ascii?Q?ZRviI7ppWOHLMEr+hkUy5dc1wB5FHoOVsSnF1knFSpUcicBz7AoTDrA9Qhju?=
 =?us-ascii?Q?6KDcW2ED0IVqT8u2LmsGUmnnaAJ3oYZRG1FjA8Xbgr8vTYtdHVMzurXdR4lD?=
 =?us-ascii?Q?5fbY0YSYjAlC0CSVkqh+2FyZ32CF+VamrtC3mxI18Y5kwlniN+h73q3RCQwi?=
 =?us-ascii?Q?S2S0dbdh5gUxNEQsPKXRuLR5fTGGBYI2FbYv/j+EfJaIae528ZH5zZDq/OYR?=
 =?us-ascii?Q?Vp/D040n1+gdissXP5PP3YgFNbh179Q+x1+Jns+znfHQaJrw6miu4PB69YBL?=
 =?us-ascii?Q?Ig/YnxmK3oTVH/kLTY2fhNYuSJT1Xx7no7N8cSguD3ODVaxi76r0LscVc1nW?=
 =?us-ascii?Q?e8XL7aU2ThKfsz7Jf6Aynf7jGbEJLT9aOU+fyKSCUUNi9SQUL9jORJd8sdyo?=
 =?us-ascii?Q?q2QD7CvLnBwSiY2ECz0+IGsD1BsiRpxUwq+RBrWEXPaDl3gvgmqvUdLndqIp?=
 =?us-ascii?Q?41rbSW+2sWX0o9tOLYFHQidIaoJCxlidX8EIfL3vyUH/NzUAw0kFLuFlneGP?=
 =?us-ascii?Q?zRCNgdrfZgod2jfNWBSaA8I3yQG1WDZiYLX7y9h7sP9Flcg11o1rbezr5hrX?=
 =?us-ascii?Q?98rHQum9zR8N3zPdB20FzT8uJwECys4kPcnrU5Yu5sca7LckfO1RlYQZH6lf?=
 =?us-ascii?Q?kVftwwOfOfGYOJk41juqDoProj2olDXQyqzr/7CkF+5YZ2U+xAlaYW+19Dm4?=
 =?us-ascii?Q?rejbqWmwVUCyLLY5njDYP1M7uGUxvnQmLmceyJ/4zdZt6NV1MUSEwP06Fk5w?=
 =?us-ascii?Q?mTNi7vHHuAsFxRij25yEuk+tcikZLzSkThQIF0f/GqkMKBgZFIMXc0q4z9zT?=
 =?us-ascii?Q?ypbjZ8Xo4AdMgEftRQrGNFGv9rYHgz01k6HrukpA9Pdprp2UCTmzsPXbJRr7?=
 =?us-ascii?Q?arD8LBft3h/plldlOikWhXrf6ZbwM2tY7ATVSojQeCztf9S9ckaANAvaQqEG?=
 =?us-ascii?Q?lps5WPoZdgxh6+znxBG+Z9jS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29e1f88-216a-4822-36d2-08d98504412d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:52:37.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X75UyMKlc4Ey8qsoEcDaqRi5/H9WhdgKxNBYSNhOVBZjQUFx6/eFe1H8IONubbS/3aLagih+d3cz3t2yuaCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4924
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010127
X-Proofpoint-GUID: PbUjBTRAdqpm8D8WN4RBfTGjXgZLW2mS
X-Proofpoint-ORIG-GUID: PbUjBTRAdqpm8D8WN4RBfTGjXgZLW2mS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When huge page demotion is fully implemented, gigantic pages can be
demoted to a smaller huge page size.  For example, on x86 a 1G page
can be demoted to 512 2M pages.  However, gigantic pages can potentially
be allocated from CMA.  If a gigantic page which was allocated from CMA
is demoted, the corresponding demoted pages needs to be returned to CMA.

Use the new interface cma_pages_valid() to determine if a non-gigantic
hugetlb page should be freed to CMA.  Also, clear mapping field of these
pages as expected by cma_release.

This also requires a change to CMA reservations for gigantic pages.
Currently, the 'order_per_bit' is set to the gigantic page size.
However, if gigantic pages can be demoted this needs to be set to the
order of the smallest huge page.  At CMA reservation time we do not know
the size of the smallest huge page size, so use HUGETLB_PAGE_ORDER.
Also, prohibit demotion to huge page sizes smaller than
HUGETLB_PAGE_ORDER.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f4dad1ab12d8..a15f6763e8f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -50,6 +50,16 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
+static bool hugetlb_cma_page(struct page *page, unsigned int order)
+{
+	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
+				1 << order);
+}
+#else
+static bool hugetlb_cma_page(struct page *page, unsigned int order)
+{
+	return false;
+}
 #endif
 static unsigned long hugetlb_cma_size __initdata;
 
@@ -1272,6 +1282,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	atomic_set(compound_pincount_ptr(page), 0);
 
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+		p->mapping = NULL;
 		clear_compound_head(p);
 		set_page_refcounted(p);
 	}
@@ -1476,7 +1487,13 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
 	}
-	if (hstate_is_gigantic(h)) {
+
+	/*
+	 * Non-gigantic pages demoted from CMA allocated gigantic pages
+	 * need to be given back to CMA in free_gigantic_page.
+	 */
+	if (hstate_is_gigantic(h) ||
+	    hugetlb_cma_page(page, huge_page_order(h))) {
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
@@ -3003,7 +3020,8 @@ static void __init hugetlb_init_hstates(void)
 		 *   is not supported.
 		 */
 		if (!hstate_is_gigantic(h) ||
-		    gigantic_page_runtime_supported()) {
+		    gigantic_page_runtime_supported() ||
+		    !hugetlb_cma_size || !(h->order <= HUGETLB_PAGE_ORDER)) {
 			for_each_hstate(h2) {
 				if (h2 == h)
 					continue;
@@ -3555,6 +3573,8 @@ static ssize_t demote_size_store(struct kobject *kobj,
 	if (!t_hstate)
 		return -EINVAL;
 	demote_order = t_hstate->order;
+	if (demote_order < HUGETLB_PAGE_ORDER)
+		return -EINVAL;
 
 	/* demote order must be smaller hstate order */
 	h = kobj_to_hstate(kobj, &nid);
@@ -6563,7 +6583,13 @@ void __init hugetlb_cma_reserve(int order)
 		size = round_up(size, PAGE_SIZE << order);
 
 		snprintf(name, sizeof(name), "hugetlb%d", nid);
-		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
+		/*
+		 * Note that 'order per bit' is based on smallest size that
+		 * may be returned to CMA allocator in the case of
+		 * huge page demotion.
+		 */
+		res = cma_declare_contiguous_nid(0, size, 0,
+						PAGE_SIZE << HUGETLB_PAGE_ORDER,
 						 0, false, name,
 						 &hugetlb_cma[nid], nid);
 		if (res) {
-- 
2.31.1

