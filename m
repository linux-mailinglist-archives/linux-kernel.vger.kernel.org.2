Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70C2425A90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbhJGSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:21:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57022 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243599AbhJGSV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:21:56 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197I5Bu6009665;
        Thu, 7 Oct 2021 18:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Ke4NJ37Bas3PZDEjWRZOHB+0MmguX7q3UWkBCvvRwU4=;
 b=SfNZHhCj86jCrpFeKMnWluDfdgvKC3Fyz8YUp7lF29EqzkzcJ6vBqckIBNlNU2WRedT1
 bs16xB/qD1eGRJs6XmLe2GDkNuxmx9MLT4G/T0D1EfTTzCAn3u3IM3CglZcu1bOM76vF
 fx9TldBsyXlzQW5osAgEoEv5jiGdVQtnxe2K2HoUEw5qC2YxQ8qYhMtpX+n0jfddWVF/
 CZ3IN3sUAW/s1ul8Mr5VZNHnr+dA4H8wkzrL5NlRpzCvrkV44w3tVpBCbA1/WaOw82Di
 swboOfUsLnWY/y59t26iOSm4wKenn0d+zmBny4zDBuKoZSJoDIKbj/wLTl8aW/6/9CvH zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhxbs3rxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197IAnqg177633;
        Thu, 7 Oct 2021 18:19:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3bf16x9114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK++3nCbOdfcuj5bkQgc2/Zf9HSNNxmzzZAyztee/zN498+jOA9wgeIzfkVjzWSkwwPl/8oL7mbrh30eSafm9QMcbTGjgZFpO0QVZXFyTOxxKSuWo8B4aCnxIPeGHVt5qbHFLVcVCUcrWScd1spWvrbGPhxN2f8biSkM8cqNOEQT1h/Ortf8sNZ9gAH1AfxPi0JxXt59PhnNgU5WphjyC3wmOk3sQ8SiwrsSP2nHHbkihHnKnZg7nl7bXhjgQOGQPvF3W76C1eukBsOHyjHcwL6l13vMMmOiwlCKSEKB/MbBjAfimeND0JcJA7hAk5kzPsYiVOHPehCkPKqb1lrHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke4NJ37Bas3PZDEjWRZOHB+0MmguX7q3UWkBCvvRwU4=;
 b=ixCSQSVfcTycSdvByfykJbP/hFJmqmRrz8vlf84HVascKraRceswJ0TaYTVUrLu5os8yiF6ZvHIRnJrNgdP3jrTxqgjmG5cyNHlGXVnPxS24QVVyzXGUEPhjqytABf+ZPVCO5YTN5ifFqdGpnP2o2pq8ZPNpQXjHYSQCYYSiePmcPJk6wB47aUfyCwpWaKb0mHb4h8oZyjgzLOJh36xanAlircomCt3XQF8Q6JN2CqOxv+JHFjfeZihLOKtJaIjkNTGkZGEb4GrH15+qlU6wCXLIYvov09TplLNcdrPdMOINA+skNnJIG0yuTEsLUd/uU9rKYobniSE/bXv0o5n96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke4NJ37Bas3PZDEjWRZOHB+0MmguX7q3UWkBCvvRwU4=;
 b=u9g7MYrm+z/BBDj1pbsUkd2ONlOeAt+oGRlsP5xTMqb29fAx3+ePi2hW5vxcMNxRWK0f8p43+YBcOt7APdQ5muVcuD9FDU/qbg5DAENs1AEWh9vZHqgjlBIKMvEdgnzMOgxadu5YYiclLw1QBr/iyPKOmb9dT45DRyxSGncvrFQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 18:19:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 18:19:39 +0000
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
Subject: [PATCH v4 3/5] hugetlb: be sure to free demoted CMA pages to CMA
Date:   Thu,  7 Oct 2021 11:19:16 -0700
Message-Id: <20211007181918.136982-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211007181918.136982-1-mike.kravetz@oracle.com>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 18:19:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5270edf1-4e36-40d2-3c9b-08d989bf06b4
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB25520CB988EF167C8B3EE682E2B19@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qg+/9WQUpsvY1pOKhXGRzvBfUIA3788sv1FFY36GDtnPD+puxrnbRxrJxkdiS8YNHkbsGQw0KymC3UoIeVkrONUAXmv+T59V7JVmWqZ7+Lym5axTHq/o25LznmosNzMgJrK9YMnWte2NMjez/h81Sif+nfj0QF41jcs7IT5UEeP1AeO30cKWr74dT+/NRyAMCF16cr0Pw59CTqd1GLQq+MSWeFT8O181pyzamAexYnu49WpUq6UloA1ZMUEcucGjZmtxCJ9ANN3CxioT+AI90nQk3XZx+wEAQ8k81UydcGkvrLMuHIqvun1K5AHRXIiYbSloVgTX/xz9uvITHEL8fHG8843vVRu/IEIq6WwuzUw/rKsBQB2ZgIGa+DVvCtRE18IZ6dxkcm096jWHhx99LvNX4xv4ZkHXbg2SFWlBe0ZsdSfP7IQZliLk8XMYEnoqYRwmQ+1PloOVcKRvtvtANG6KTfArTa2M9dvFLW+ggZgflEAMBjEXFK07EUBDzxa43mloI5kVAESmKCSiEyfmkYCIojiAg9AWUOvl84arUKSQxZIpD4FRXrakpAnbgR/mK5y+ilsHvBtpgRv+mMhT0IYYVl5ZWVXbYtzesECT11Hyb0rSrfBPSePUYlS5VF2GGS/ob7PcPoa3d7n9XK87sAHlF8TCLRtrCtnWUir+rKh/AlejVp8qfGnTjT3ndXj6iZMvnqQq6+IAT2LH0fU0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38350700002)(316002)(7416002)(44832011)(5660300002)(6486002)(107886003)(2906002)(1076003)(186003)(508600001)(54906003)(38100700002)(6666004)(66476007)(36756003)(66946007)(4326008)(66556008)(52116002)(7696005)(956004)(2616005)(26005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/nssMMxVHzHBJgUuM/DtRAwL8rx/0axWnqs4eQ1gO06GuoE2dmlVMytpe9yy?=
 =?us-ascii?Q?n1MG6EXC0pEpxaXCw4m8ITt8+vWUylNkHy6Pd4rNAQjlUbZlFkK4XDU2QK9j?=
 =?us-ascii?Q?hgFg/9SuRkIDxJ5B5o2vOHZ0ocmkDGXmF6oCOr7Ve/OCzPutyh/LJ/uYSq+K?=
 =?us-ascii?Q?UU61MmpmpbuXYEeidaQ1jv5Wubt/VZmyMli8sWVBG3MjbpooezD+z8O9kYAn?=
 =?us-ascii?Q?05IBuryzXzsLVbQGh1CFZTE2Tq2c8j3w3t8Xau0jJRPx515p8GKtyoocAB1x?=
 =?us-ascii?Q?UFBO36Q2EBMQzccYzVOZyRavTXDV9b9fqeDr+LMZ1uuKqXiUupEOe/Td9gra?=
 =?us-ascii?Q?Xs8MwuZyode+47RJuJPs9Xxa2dfYmqsXbDIFgwu9t7MEMH94l4W7c/T6Sp2U?=
 =?us-ascii?Q?XKKl64DAIYlXWuNijtwWgLUhASGsmX1IJhDujvBzKvOIwRMx8rLplL6A5zu4?=
 =?us-ascii?Q?1jBprLgn1swlWQvyY45LBq9iYu94OvhmVrwCSa+srBpogPRU//+2TRRQsHbi?=
 =?us-ascii?Q?vh8e5cD2Xxg8aEepwo0K1VQ/3zN7/9eVWpfs6zM9EIejYmIYpn1+VHlyrCGe?=
 =?us-ascii?Q?0kha60b+21BEfZHHDGEhiPn3mVDptdrNv78PX0lfb/hwFL/ykbH3N2KcAFdp?=
 =?us-ascii?Q?VQdfcV3MV192eaepY1sa6JaoWUAr7g6YbDB0B8l7WGMCAPVVrfXm6TpHveps?=
 =?us-ascii?Q?XwrPQCw5qnjmDI0zQNhNG39L8jmsBfY44vqVPx2MLMAB2Z6yxaTGxu8wXyNd?=
 =?us-ascii?Q?JY0J0urvmV8Y3WrhOqzXqm6EsZsOr+EnJlOAfk3WLMnSuZMzIq5yaB39KJFC?=
 =?us-ascii?Q?pFlIzrSRAvYu04ot0wy9cW4Mndx0nY8/3yC5pBknI77q33ACaGj/EndH32QQ?=
 =?us-ascii?Q?0DvvZOcNhdPZ5jM/1UEJ+KKq17VAdK96j9lkwcygPmls0UFnhgR0W+maXO3I?=
 =?us-ascii?Q?IBsAx1l2MJf1Baayty3kym5/VpUvp40s7aBeyXjTGdQ5QfxU0HQzWYwytFgu?=
 =?us-ascii?Q?hHC0Q2KuiakvlCIZnTHYnQUlLkGjhgJjulCIy2o/x1C+WU7rpz8FKcbCfBzQ?=
 =?us-ascii?Q?cXnJi4f4VNZq/ybuDFFTk91qsvKam9Ict66Fti0/B1pXcHtkNUKJYFNCpHM4?=
 =?us-ascii?Q?tAlekZ0br4rtvydXvcBl3E9CpePTG2/8YY9rE1KT56KrieI4LZitxPuP4EEO?=
 =?us-ascii?Q?P3YQwC6mGAKhtgaLRNT10lpEilpUPFaOm89rFtvHkM8y8+tg7CYjtSvFi/3v?=
 =?us-ascii?Q?4PcMPhP7GgmtiprT9TOcCegQqR0Rvmkyul1JxcWqMfyLI5fV2EjMuas4bbRK?=
 =?us-ascii?Q?tQr1Ltpb3h+JEB/ZXkvFj2I3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5270edf1-4e36-40d2-3c9b-08d989bf06b4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 18:19:39.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIp0yEOL/K3qBaxh6HGEkwbQ6f9/L8MiXv2rzt5wpj72JdSLud3+Echoxwf6aBdYGdsBvJakBS28ghB74B8nbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070118
X-Proofpoint-GUID: 6CtEoH-PluYfsDRJVY6SpD-4Ndk-JwhW
X-Proofpoint-ORIG-GUID: 6CtEoH-PluYfsDRJVY6SpD-4Ndk-JwhW
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

This also requires a change to CMA region creation for gigantic pages.
CMA uses a per-region bit map to track allocations.  When setting up the
region, you specify how many pages each bit represents.  Currently,
only gigantic pages are allocated/freed from CMA so the region is set up
such that one bit represents a gigantic page size allocation.

With demote, a gigantic page (allocation) could be split into smaller
size pages.  And, these smaller size pages will be freed to CMA.  So,
since the per-region bit map needs to be set up to represent the smallest
allocation/free size, it now needs to be set to the smallest huge page
size which can be freed to CMA.

Unfortunately, we set up the CMA region for huge pages before we set up
huge pages sizes (hstates).  So, technically we do not know the smallest
huge page size as this can change via command line options and
architecture specific code.  Therefore, at region setup time we use
HUGETLB_PAGE_ORDER as the smallest possible huge page size that can be
given back to CMA.  It is possible that this value is sub-optimal for
some architectures/config options.  If needed, this can be addressed in
follow on work.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 44d3c9477635..563338f4dbc4 100644
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
@@ -3001,9 +3018,13 @@ static void __init hugetlb_init_hstates(void)
 		 * h->demote_order is initially 0.
 		 * - We can not demote gigantic pages if runtime freeing
 		 *   is not supported, so skip this.
+		 * - If CMA allocation is possible, we can not demote
+		 *   HUGETLB_PAGE_ORDER or smaller size pages.
 		 */
 		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 			continue;
+		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
+			continue;
 		for_each_hstate(h2) {
 			if (h2 == h)
 				continue;
@@ -3555,6 +3576,8 @@ static ssize_t demote_size_store(struct kobject *kobj,
 	if (!demote_hstate)
 		return -EINVAL;
 	demote_order = demote_hstate->order;
+	if (demote_order < HUGETLB_PAGE_ORDER)
+		return -EINVAL;
 
 	/* demote order must be smaller than hstate order */
 	h = kobj_to_hstate(kobj, &nid);
@@ -6543,6 +6566,7 @@ void __init hugetlb_cma_reserve(int order)
 	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
 		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
 			(PAGE_SIZE << order) / SZ_1M);
+		hugetlb_cma_size = 0;
 		return;
 	}
 
@@ -6563,7 +6587,13 @@ void __init hugetlb_cma_reserve(int order)
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
@@ -6579,6 +6609,13 @@ void __init hugetlb_cma_reserve(int order)
 		if (reserved >= hugetlb_cma_size)
 			break;
 	}
+
+	if (!reserved)
+		/*
+		 * hugetlb_cma_size is used to determine if allocations from
+		 * cma are possible.  Set to zero if no cma regions are set up.
+		 */
+		hugetlb_cma_size = 0;
 }
 
 void __init hugetlb_cma_check(void)
-- 
2.31.1

