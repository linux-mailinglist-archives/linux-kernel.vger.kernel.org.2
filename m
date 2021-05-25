Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606B4390CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhEYXda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:33:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49028 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhEYXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:33:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PNNvYh037556;
        Tue, 25 May 2021 23:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=5/tEr485WcGCoFRUAKeLIfPM8W+6j6cVGn5BpGAPNmg=;
 b=Uqt9NouR29uW+Je+poZOAtDQ2MShlLS69JlVaRSltLbbFbf1IJT0Jp8+67ftw7cHcbFL
 oarx4R5msEjxRDc9iJC2RSRvWZ0i1hRk/wH/crUdGcNC9Ds0noL+/Wgvw5fxCJkICdQY
 PGtaJ3Q7UmPtDNeXMe8wBoCTxWFFWpWhqqKVoRuIJfMpHfjPuw8rQN6N4zzLfSljzUmv
 d2C9uPe10vxWBtcZ7HT6XMLoZvNMJBplAFv7ER2jCxP6WBRNbfGe3I8WsPKYZ6b4vKcf
 SCwxr0MYD89JquhqFM+YrJjWg+LIZ4UD0HCUJ6nPstV1L+axc3/npN0TQ1Qe8Lv/vcfq +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ptkp7eee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 23:31:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PNOs3T048247;
        Tue, 25 May 2021 23:31:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 38rehbbc50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 23:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW5KsfgkyvcopsNc3dMfiNXQYwgqelFa/S214RZqsTc+BeK2xMChx97txCKQ0VTLbJOhzLXUQUB5S09Jh+ghcIUByUNaQ4niAfMlnScKTVzgScFfYZ+8sf1DgQPOmUPaaoWvBwOIBA5NR1Mm8CXhjluHIya7Cl3JETOIBfuCFWmXPLtbrKMg2fGRzGuW8u7hgM2Ngey1DPDsKd+EB6blC1hbcoBTwbZsl4NyVCOs10RlplgEHxObNw1St+STLwAV/XeXOcuAWJsC/pAZP8n8Udz23QcKejgvoXeCRLYpVs6e70tJnJJKDken5vxZ4YD3wFoji/8qHNnPaDRU5YlOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/tEr485WcGCoFRUAKeLIfPM8W+6j6cVGn5BpGAPNmg=;
 b=Uq0CjhlJCmIZBJkER9TDdMNr6mWOjNq7grM4GGITgLmbX+fE9Aq5SEXKuVSQvE6edVS8BTmqzCSijAFmUabBIv+ENsFl+/GEOQRtF8BVuu/hBXQqnm/Z3CEF7y4Vn6jdaxxOAGxiqBogEtUmC3ioxd7oH5TzBSI7atlKYq+lEn5q/B61SIfhX2kyq4FuOEYVM42f4j7dPB3ldm826i33ya5zxhm0R8Aa0waN/ghEIZP1VYXsPL+5k+tCtBdAB27ebIdkXChIRrG5ZKDfyNmBx+HI/roiALtg0ft39gNurxteAqIvFZJJS+lMIgqMy78GgsAu9LHxNw11TlI3F4ye8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/tEr485WcGCoFRUAKeLIfPM8W+6j6cVGn5BpGAPNmg=;
 b=dWg0N0VpqAI+v0FYSvZWO1cae3Ljoy6U+AGC4S1+BVI1/CoCKaNCu8grK4sDHMWOBKTiFqu5m+Yd8/q2Tah6nbkK16Nge8Q9iLG3qldqi90Y0XFzVnN44DgXRsh+nJqYdgexJa/UOPXl1qY+i862N511vzY7LXEGvh5Ny2kuElo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 25 May
 2021 23:31:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 23:31:49 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mina Almasry <almasrymina@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/2] hugetlb: add new hugetlb specific flag HPG_restore_rsv_map
Date:   Tue, 25 May 2021 16:31:34 -0700
Message-Id: <20210525233134.246444-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525233134.246444-1-mike.kravetz@oracle.com>
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
 <20210525233134.246444-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:300:16::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR13CA0021.namprd13.prod.outlook.com (2603:10b6:300:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 23:31:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a728c1bd-289d-4fd8-6d4d-08d91fd544f1
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB266427C2426790F925D458BFE2259@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/wXgqNLz5tq9y8FTUwQoRMLPwGgy4pmbm7ibmlDfD8ui7OqpaC9peFUqesvl4MAj/Q/eeJJqDgkv3IdoHFEN7L8bJxtrMDGOhkAteKxL8BfZBJx+g6MJmD5K13VEpaFWBg21oDk/jmhF6LT0Atv1kfhOAaNNnxy/H6WLY+WOoQnWNZD28EP014nR7yaxpXd5uhDufuLuQt1utyjHbQ/1Gl/RjtcLuBM/szco861tl+d8AOh2n3+CaAI8gkq7zTQIQszTpD3XOHk59loQJEs60lfsF5FKdL2dVdi8u7FKNEHaljLd6zKWHfBGzmJBW8sjFpQeYDWrzdPIAu41m6Ozsl/N7Xh75ZIufIsvWaZ54xKg1PwpdnFwzkzWf5t89+Eictaio+IqpdBVmIbPW5W/ur3N0oct/Ocy3FQTNJapxzVUcEHa9AWg/yLWTDTTdekXpUMO2PtkiM6hzGiZt5bddZKblZs8MHXvdK7VGn3hLmkF1AkcBINDKQtjNq4B8Gp+7jY+guWULxN4CfEtKrUFrQ/ZruMg5kfJdOaXiDLYH4xo5ne8LyWj1FFbQr7m0Todkpq0Q1KKiUdlRBSymZOllWcpr1Nb+aMyRG0MdJh4veG2s04S82qrMuMHntqmp5SzbIeufA8aYR9HqvI4c2KKAiXsM4z5SXcbdLakM9saj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39860400002)(396003)(26005)(8936002)(6486002)(6666004)(956004)(16526019)(5660300002)(107886003)(66946007)(66556008)(1076003)(7696005)(52116002)(186003)(44832011)(4326008)(2616005)(66476007)(316002)(478600001)(36756003)(2906002)(86362001)(38350700002)(8676002)(110136005)(54906003)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TSAqFyi4bypNZCuM2jRIikH+8cL07yyEFuzO8Pk4LlhQ4arzSDsyeNUnUj3M?=
 =?us-ascii?Q?po/h3XdlUCzQsgLUvd8jS/HqQtvQJOYH3GC/zz+XA37MuZdA8S70A5IqY7ex?=
 =?us-ascii?Q?z0B/rLZjVmtgbTTalqs17jEXwPXkuMMR2bf+ylaHwxqNhNwPmLSqsvb8Rq/a?=
 =?us-ascii?Q?UreH2EmDaV3RpUwk6FRjhu1XVxDOqyIxsovquJJLo4W+v1ekOxcDR4i7MUsZ?=
 =?us-ascii?Q?sbxuxoEcFyr7uGhjZSznPRibU0+nYvYMiN+jRUN9gg+9h+n6bNm8yfcq5xJt?=
 =?us-ascii?Q?mngF9X86Ss2Q+Rcr2nwFk7fVV9nzzDcnZN7FPzYHT1LTIJdtfVjtu5Wkednc?=
 =?us-ascii?Q?Sjf66WpSUmY2sLX+WW9WcymSWge1RgmfMqVrt84t69+VBqeiu3NX6McMnvnz?=
 =?us-ascii?Q?GBJ18yjAYR867EYCVfzRVZTmXbiQjCpe1tyhk8zwLvfi9KN848RYw7kpNlVk?=
 =?us-ascii?Q?61CzQ5lR9CVqFKQDwuQo85k4VCVg2f/PdcpAtGvpp4tCoi03FDsxCY5/6mbb?=
 =?us-ascii?Q?W+CWWaxtusyJ0spyxM7LKCtZXS9GSePnN4brYh2cXdw6ykcZ+a1UppIP5m98?=
 =?us-ascii?Q?wxzBHBE7B5SDQzFctqBbXkp67hh066qA7lb7NMdBHemBgaNPa9703Alcfo1i?=
 =?us-ascii?Q?dbRo3QKuBDvvWWlLTKvAKaBNjBxQGCJJClSYp8FGxbjuLWueIJJQgq/nG00E?=
 =?us-ascii?Q?XChTMG9EoaxIirV7rR64f1Thut+38sMEdy/IoMMjPWYNax2ErQbZFeGF5MJP?=
 =?us-ascii?Q?zt7DMb/DgIUzQRB0XWY3h1KVxUiyPEs1Hbkd0Q6IFYtP7SgDYC8inDkfjOXC?=
 =?us-ascii?Q?1v5nV3VYlW7hy8PWUkgB2TJqiJP+srM3py+PXG+rFz4kvQ70GZt+N1rlzrGZ?=
 =?us-ascii?Q?rLAop/YqQNSPZH1vaYxCg7VcwDv6MijZhXIJ9tY9vj7kYT+h75s/tO/dn2Nm?=
 =?us-ascii?Q?SOVZ7IHlrfg68Gjoy0o/7rle77btD1MBHolmFH30kfrWppcaLqrq8mTUCLzk?=
 =?us-ascii?Q?19Me0POR/tsC2TBijOUcyMb+s5/B8rra8G5nJKAfApPrzgmeoa4u+j7E8QPh?=
 =?us-ascii?Q?0qQoK6vZ8S/+lr7Jt47f/ZdfmY9U31II+WAOLooF650LiJdX3OXRP0HVZFbQ?=
 =?us-ascii?Q?eWUjj5eXjDWTM+RgCJiMLtzD7ewg8TmoyShqDLRGxt4AkrOQMETkVvS78kpx?=
 =?us-ascii?Q?n0yl22MVUzhXAF66oXkP6KOK39tvzgoHakr2jQgyicJj3/nVQ/eNr8yfqExP?=
 =?us-ascii?Q?1aN4RycSklysTamPKMOmC3Ar90I7OZpebwpjnXRYGn9rpmnwX2Nfx8xu77E3?=
 =?us-ascii?Q?zhDLZpaCO7HizsbCn3mtP31t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a728c1bd-289d-4fd8-6d4d-08d91fd544f1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 23:31:49.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeSCcy7qWpWcQMaZsANR3Ktj756PgKO3LmghZBodc9Gb7t01srzC1Ae9TwazKHb11PXRsp/JmyEh7KdyRPpPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250144
X-Proofpoint-GUID: boEep6s4jmcrMmvDSprMN7m0ahcSNAjh
X-Proofpoint-ORIG-GUID: boEep6s4jmcrMmvDSprMN7m0ahcSNAjh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a hugetlb page is allocated via alloc_huge_page, the reserve map
as well as global reservation count may be modified.  In case of error
after allocation, the count and map should be restored to their previous
state if possible.  The flag HPageRestoreRsvCnt indicates the global
count was modified.  Add a new flag HPG_restore_rsv_map to indicate the
reserve map was modified.  Note that during hugetlb page allocation the
the global count and reserve map could be modified independently.
Therefore, two specific flags are needed.

The routine restore_reserve_on_error is called to restore reserve data
on error paths.  Modify the routine to check for the HPG_restore_rsv_map
flag and adjust the reserve map accordingly.

Add missing calls to restore_reserve_on_error to error paths  of code
calling alloc_huge_page.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  1 +
 include/linux/hugetlb.h | 11 ++++++
 mm/hugetlb.c            | 82 +++++++++++++++++++++++++++++++----------
 3 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index bb4de5dcd652..9d846a2edc4b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -735,6 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		__SetPageUptodate(page);
 		error = huge_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
+			restore_reserve_on_error(h, &pseudo_vma, addr, page);
 			put_page(page);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e5e363fa5d02..da2251b0c609 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -517,6 +517,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	Synchronization:  Examined or modified by code that knows it has
  *	the only reference to page.  i.e. After allocation but before use
  *	or when the page is being freed.
+ * HPG_restore_rsv_map - Set when a hugetlb page allocation results in adding
+ *	an entry to the reserve map.  This can happen without adjustment of
+ *	the global reserve count.  Cleared when page is fully instantiated.
+ *	Error paths (restore_reserve_on_error) check this flag to make
+ *	adjustments to the reserve map.
+ *	Synchronization:  Examined or modified by code that knows it has
+ *	the only reference to page.  i.e. After allocation but before use.
  * HPG_migratable  - Set after a newly allocated page is added to the page
  *	cache and/or page tables.  Indicates the page is a candidate for
  *	migration.
@@ -536,6 +543,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  */
 enum hugetlb_page_flags {
 	HPG_restore_rsv_cnt = 0,
+	HPG_restore_rsv_map,
 	HPG_migratable,
 	HPG_temporary,
 	HPG_freed,
@@ -582,6 +590,7 @@ static inline void ClearHPage##uname(struct page *page)		\
  * Create functions associated with hugetlb page flags
  */
 HPAGEFLAG(RestoreRsvCnt, restore_rsv_cnt)
+HPAGEFLAG(RestoreRsvMap, restore_rsv_map)
 HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
@@ -633,6 +642,8 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
+void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
+		unsigned long address, struct page *page);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2a8cea253388..1c3a68d70ab5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1551,6 +1551,7 @@ void free_huge_page(struct page *page)
 	page->mapping = NULL;
 	restore_reserve = HPageRestoreRsvCnt(page);
 	ClearHPageRestoreRsvCnt(page);
+	ClearHPageRestoreRsvMap(page);
 
 	/*
 	 * If HPageRestoreRsvCnt was set on page, page allocation consumed a
@@ -2360,24 +2361,26 @@ static long vma_add_reservation(struct hstate *h,
 }
 
 /*
- * This routine is called to restore a reservation on error paths.  In the
- * specific error paths, a huge page was allocated (via alloc_huge_page)
- * and is about to be freed.  If a reservation for the page existed,
- * alloc_huge_page would have consumed the reservation and set
- * HPageRestoreRsvCnt in the newly allocated page.  When the page is freed
- * via free_huge_page, the global reservation count will be incremented if
- * HPageRestoreRsvCnt is set.  However, free_huge_page can not adjust the
- * reserve map.  Adjust the reserve map here to be consistent with global
- * reserve count adjustments to be made by free_huge_page.
+ * This routine is called to restore a reservation data on error paths.
+ * It handles two specific cases for pages allocated via alloc_huge_page:
+ * 1) A reservation was in place and page consumed the reservation.
+ *    HPageRestoreRsvCnt is set in the page.
+ * 2) No reservation was in place for the page, so HPageRestoreRsvCnt is
+ *    not set.  However, the reserve map was updated.
+ * In case 1, free_huge_page will increment the global reserve count.  But,
+ * free_huge_page does not have enough context to adjust the reservation map.
+ * This case deals primarily with private mappings.  Adjust the reserve map
+ * here to be consistent with global reserve count adjustments to be made
+ * by free_huge_page.
+ * In case 2, simply undo an reserve map modifications done by alloc_huge_page.
  */
-static void restore_reserve_on_error(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address,
-			struct page *page)
+void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
+				unsigned long address, struct page *page)
 {
 	if (unlikely(HPageRestoreRsvCnt(page))) {
 		long rc = vma_needs_reservation(h, vma, address);
 
-		if (unlikely(rc < 0)) {
+		if (unlikely(rc < 0))
 			/*
 			 * Rare out of memory condition in reserve map
 			 * manipulation.  Clear HPageRestoreRsvCnt so that
@@ -2390,16 +2393,47 @@ static void restore_reserve_on_error(struct hstate *h,
 			 * accounting of reserve counts.
 			 */
 			ClearHPageRestoreRsvCnt(page);
-		} else if (rc) {
-			rc = vma_add_reservation(h, vma, address);
-			if (unlikely(rc < 0))
+		else if (rc)
+			vma_add_reservation(h, vma, address);
+		else
+			vma_end_reservation(h, vma, address);
+	} else if (unlikely(HPageRestoreRsvMap(page))) {
+		struct resv_map *resv = vma_resv_map(vma);
+		pgoff_t idx = vma_hugecache_offset(h, vma, address);
+		long rc;
+
+		/*
+		 * This handles the specific case where the reserve count
+		 * was not updated during the page allocation process, but
+		 * the reserve map was updated.  We need to undo the reserve
+		 * map update.
+		 *
+		 * The presence of an entry in the reserve map has opposite
+		 * meanings for shared and private mappings.
+		 */
+		if (vma->vm_flags & VM_MAYSHARE) {
+			rc = region_del(resv, idx, idx + 1);
+			if (rc < 0)
+				/*
+				 * Rare out of memory condition.  Since we can
+				 * not delete the reserve entry, set
+				 * HPageRestoreRsvCnt so that the global count
+				 * will be consistent with the reserve map.
+				 */
+				SetHPageRestoreRsvCnt(page);
+		} else {
+			rc = vma_needs_reservation(h, vma, address);
+			if (rc < 0)
 				/*
 				 * See above comment about rare out of
 				 * memory condition.
 				 */
-				ClearHPageRestoreRsvCnt(page);
-		} else
-			vma_end_reservation(h, vma, address);
+				SetHPageRestoreRsvCnt(page);
+			else if (rc)
+				vma_add_reservation(h, vma, address);
+			else
+				vma_end_reservation(h, vma, address);
+		}
 	}
 }
 
@@ -2641,6 +2675,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
 					pages_per_huge_page(h), page);
 	}
+	if (map_commit)
+		SetHPageRestoreRsvMap(page);
 	return page;
 
 out_uncharge_cgroup:
@@ -4053,6 +4089,7 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 	hugepage_add_new_anon_rmap(new_page, vma, addr);
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	ClearHPageRestoreRsvCnt(new_page);
+	ClearHPageRestoreRsvMap(new_page);
 	SetHPageMigratable(new_page);
 }
 
@@ -4174,6 +4211,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
+					restore_reserve_on_error(h, vma, addr,
+								new);
 					put_page(new);
 					/* dst_entry won't change as in child */
 					goto again;
@@ -4526,6 +4565,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
 		ClearHPageRestoreRsvCnt(new_page);
+		ClearHPageRestoreRsvMap(new_page);
 
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -4593,6 +4633,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 	if (err)
 		return err;
 	ClearHPageRestoreRsvCnt(page);
+	ClearHPageRestoreRsvMap(page);
 
 	/*
 	 * set page dirty so that it will not be removed from cache/file
@@ -4776,6 +4817,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	if (anon_rmap) {
 		ClearHPageRestoreRsvCnt(page);
+		ClearHPageRestoreRsvMap(page);
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
 		page_dup_rmap(page, true);
@@ -5097,6 +5139,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		page_dup_rmap(page, true);
 	} else {
 		ClearHPageRestoreRsvCnt(page);
+		ClearHPageRestoreRsvMap(page);
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
@@ -5133,6 +5176,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared || is_continue)
 		unlock_page(page);
 out_release_nounlock:
+	restore_reserve_on_error(h, dst_vma, dst_addr, page);
 	put_page(page);
 	goto out;
 }
-- 
2.31.1

