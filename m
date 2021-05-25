Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62AE390CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhEYXd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:33:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49002 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhEYXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:33:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PNNimE037443;
        Tue, 25 May 2021 23:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Vlz7GS+e5jjLeCXsj7HrB+vZ5FVZ5SzatTXNVNaXj8w=;
 b=Spv/3EaHsFM0s+Kj6bXzX8h8Iv/t6E+hgnsUUTBpONXfDYpe38PmOL//1846RiVXYPYM
 uSULQuOo0piYa+7irVhVBmmm3DZOv7lAHR03uW7jedLMCJgnhNKCpu0KMsIqHliPYnr1
 79D52fPEySY+hjmrjeaQw5ClciHi+XQZP32BvFnqQZq/t7tNfDNGHcvPiaKMQDK2vVCT
 FYOB5aRKSJcbxLvywBwztFPr4i6A2zDihj64FW6YDPvs8kLPlIjfPJmrkg5ub1OhgQ6a
 Sxlf+ozJSr7Mt1MLstJCbH0HF9s2yHPSqEXZghbT9Xk57nZFlYhkbcUQ01pf97xxfHkr xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38ptkp7eeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 23:31:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PNPIdS083807;
        Tue, 25 May 2021 23:31:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 38pq2up3ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 23:31:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsTgK2CB0Em/P4wQ01J/q62MVLUF0TdDSJ06ase5VLkwol8MsiahP8QvMUEgBoItP6Rdyv6YAgfoAlVuPcX6cnOOufor6jJ4Yw1rSsUQStWbN2g54J2X+OiQFcX55SSETpzPxg5UQSmE6WwK+8ZSOPI5JOvmjXe7XTqcJgAxdkSePZQ54r+5Pz9U56fxxrNHtFWxVzD1DpPdRWsUc223W56nf43CS/rYuDxPB5O2dP4tSxIJRkFFP2/pXexwHS97mgD+PQVtIfvUJiDMtdIcdFoe1HS0VXM2nT7+nac3DO2B7VdSi6HH2muipCP7p+h1k5MK/ePLvZfmpptmqwDNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlz7GS+e5jjLeCXsj7HrB+vZ5FVZ5SzatTXNVNaXj8w=;
 b=M1pE0yyJk0N/0i7ltuMkvt17L9qZuMAQ0u/k0embfqcxuoj+hQ2umjdQYxY+1/o5+5g0Tlt1kuAmFuDZMKlDgCdTxRU3bBLJUNLMCWNK2vjwSzTEwviaHQ0jbXH/PTXJ/CYwjlBfop5YSDZlCaboUbgJJmYruScWeK/ooFOBgSQ6dgNZSAJyDZ+x4y87ADHaglLRClpHUHkBlGKzureoC3HhdqJO9lK/UHF7g7QBQPfa7y0dO73w00O3NL39AlDqX3KyefMQMH2sNE70MBLBwQwj8+mqg/qecUWkOlIU6zfTzQketXaSe0vEgSyAloJfEfFYTRlRE/85r4gSfp2dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlz7GS+e5jjLeCXsj7HrB+vZ5FVZ5SzatTXNVNaXj8w=;
 b=R90geKlvN76KuXMs8KsVvJwuMy+KCHBi/UxUoWVfC8+Bam50517Z0G0Ojt/OOSzx0TFzDbtTEOe24hCZbFEHW+4Ng/FgIkiWV7nDcG0UTHVA6kosMr8bLl7xFkGwFEkhqct2X0HrBMr1BFQRzd7D//VeLKKNBZAR27rmPUAX5/g=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 23:31:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 23:31:46 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mina Almasry <almasrymina@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/2] hugetlb: rename HPageRestoreReserve flag to HPageRestoreRsvCnt
Date:   Tue, 25 May 2021 16:31:33 -0700
Message-Id: <20210525233134.246444-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR13CA0021.namprd13.prod.outlook.com (2603:10b6:300:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 23:31:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789041ad-6ee8-46de-3ea7-08d91fd54320
X-MS-TrafficTypeDiagnostic: BY5PR10MB4369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB436908117674A998BAA5E7E1E2259@BY5PR10MB4369.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIP00iHaNqUMWQrCwKBHA8alevrLG9xziHM0EopDG5QITZXNzYmgC4XC7VnZWKq+X7s8Odn7qTPHtciv6omY0FqJKwTcBcbQlcqXwjZbXLgk33LbYSeCnhdOOLt0yJK3k5ZJbGUlyOGscKI8JOPX0S0r0yhXtvZm+3Tgh4uFUL2LStkiaACQJe77hG2Cx9C0TTSr6e74E910ckJ18q68RIixAjiIic6PhTvbPGB8MgC104zbdDILXhXnbPWdQVHisKPLhdeyJwENebvJJHh77nYe1nvhhHK8ATicoff0QD3G+DlbYM81zalETgrd9lO/F2B077CQAVygUgMFIROdeq6fxcHzdgcHtk8WYpcTcivuhxsnojKYOF3NmI/dDYMkhBXanFMP2pcw7Tf0+9/TCt9zFr5CPv1tuVOL4QBo/6dyF6sHBWNd3iYrqrexl8emPZ/Xm9cP/frGhkjl98u/al+nkZPZe0ZlkmSw/JHjlKIucYhQxsRAz8a0A8KCqRgWprUBrTz0PEu2N2MIV+fWAPGnOZbNcGjqB9vEWSon3khgreHDXwtCqfiFVtfUCu9tDfj/e6HnO+gGLMdfmnCRyxXbRwOVtI2v7Dy2uXPxOEfPK9WanyVPGo6C0vWXle5M3O/ohzzNbmmMkBUJ+1jFadmJnN0PT1xIW/iZG1AH+mgX/2aJDke3KOI3opcCeO//4edzJ9ZWoON4putFVjEvcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(346002)(136003)(5660300002)(44832011)(86362001)(1076003)(6666004)(36756003)(4326008)(6486002)(16526019)(7696005)(52116002)(186003)(107886003)(2616005)(110136005)(8936002)(2906002)(66556008)(478600001)(66476007)(38100700002)(54906003)(66946007)(83380400001)(8676002)(956004)(26005)(38350700002)(316002)(145603002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Bt2mJXBshxV0UOua8ACj4cibgZP0O/73Tw1xHgdhldGIYgaZSVTXUlf+v97q?=
 =?us-ascii?Q?/riaOsyHKqCSbnTeFsuS1AAYASVd2ZalxkEH3OXyrS4pkfe5u/OoT8AW51Qt?=
 =?us-ascii?Q?/DiQGhLAW3RxaW5F8DrdD8zxEk8SEiANpV1uawUj/DNGVvbelxVN/zQhOtKc?=
 =?us-ascii?Q?rpzL4ydryTodUw2e4xz1SXxChBnQvVL0KoOwixL6xr6LEPj/oJ28ObxFk20o?=
 =?us-ascii?Q?UAFeZjjinsWc2zAuQ9ZeZ9+hfmQuImgX1LwAvviOCCytI14q+3QhdA5SMSdl?=
 =?us-ascii?Q?nWLfh7G9qZnx7Efi9Bhff2Ta0XrX41vxdSZqfLydAGdW3tOnSYOuVX5h+h6q?=
 =?us-ascii?Q?XJKig0XVGcAOyHydazX8vsZqLPxEnIR4glxUWgL6+7ZRwktBJDD749uD+ZtA?=
 =?us-ascii?Q?tNLgIymvtVK0QA5r2ZXQlueGAMV7WgOi7Wqt1ECgwCkeOTt1N20IXxDbdf9T?=
 =?us-ascii?Q?Yv6gI72xpssyPYVlVYJVu9BMsW9F8IzClwkHj2fMMzMPargTxnbdT/DKoyXd?=
 =?us-ascii?Q?SSvIHGkRDUCS/20kXq5+E1WigK94v+QXKLbsikBBdZiQoW2R9pZDkGMZ3kUp?=
 =?us-ascii?Q?ogmo46Jcf1rF9wwyMsUsM5jQNKL0jafahlHZotKKwEeIvt7Ue6t4inD3D2Ga?=
 =?us-ascii?Q?7UgO1T1wnarvabqeBHlFOe7g+K8G5kwn/RyiNQsPyldgzYpV0znKljsipnWX?=
 =?us-ascii?Q?x+N6TXBNhTiOF/ARTx85VwaYZ2ysn3zU5C3IiPqj2v+lQ0KNG4PUnWrgPuRk?=
 =?us-ascii?Q?I12mCxteXTSd/VH6TV7XYr8xwoSmp9hLSvjp0zA5PI+Lzy8Fa3biaRWtu16t?=
 =?us-ascii?Q?7oIn5h1h19Fry109iqR9JWOaWNMM+G4FJODYMlGQgpL7dQ7MsWvGEHqv3jiv?=
 =?us-ascii?Q?gAJXpmTvYKMLZOZ6+6kvPYf5umf1rBA6ahA/GZl40d0rI81n8RhbQw5g7rKn?=
 =?us-ascii?Q?qUwlhOoYVQKRF5uKAAzO3e6egFUSoXGBzfKi+MXqgdz2Wm0dw8sLKUv0p4Uu?=
 =?us-ascii?Q?rtMSKoaP2gu+eExaByy30AVdpHmQzn9j4adGOygO4Q0ibDYFbYWjZ6rpc8tm?=
 =?us-ascii?Q?D0VFWDMgBVrAOp1W/tr8E/AbJmVl2BhIR6nA4YW+tkXlnYQDEUqlbRDKJorh?=
 =?us-ascii?Q?W3KK9GY1jE7qtaINYw/P0qHHy1yq3HmIW+xK/TVYIfpWEiPLfexhucK8Ahz2?=
 =?us-ascii?Q?Fh6O229X6lyx8Frda+eJRFIqcGsIl+jFw6Sx8Gn/ixhbFzGK+Sw0lL8flA5Q?=
 =?us-ascii?Q?d+WMcM5/4eps+8C26fB+6XQQj+4/0s6orO5qRC5KUg/OGVwJ1a7xMRuXX2zQ?=
 =?us-ascii?Q?fwxMGV2/oNGJvJqS2vhZLVLC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789041ad-6ee8-46de-3ea7-08d91fd54320
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 23:31:46.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqSBc9vYvKx5VtTQ5z01DcnJAiVf+QpQMGAsZcEQX5lW7y7P7zFiGZ4INgDg+rzDL+wIv4Wm9AsQBatyPcdRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250144
X-Proofpoint-GUID: rgkmGDRC2SD9bG72fDHFmL-i9Xg9PyYN
X-Proofpoint-ORIG-GUID: rgkmGDRC2SD9bG72fDHFmL-i9Xg9PyYN
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb page specific flag HPageRestoreReserve is used to indicate
that a reservation was consumed and should be restored on error.  More
specifically, this is related to the global reservation count.

It is also possible to have a hugetlb page allocated where the global
count is not modified, but the reservation map is modified.  In such
cases, the reserve map needs modification in error paths.  Code
performing such modifications will be introduced in a subsequent patch.

Rename the flag HPageRestoreReserve to HPageRestoreRsvCnt so that it
is more clearly allociated with the global reservation count.  No
functional changes in this patch, just renaming.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  6 +++---
 mm/hugetlb.c            | 32 ++++++++++++++++----------------
 mm/userfaultfd.c        | 14 +++++++-------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 55efd3dd04f6..bb4de5dcd652 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -529,7 +529,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * the subpool and global reserve usage count can need
 			 * to be adjusted.
 			 */
-			VM_BUG_ON(HPageRestoreReserve(page));
+			VM_BUG_ON(HPageRestoreRsvCnt(page));
 			remove_huge_page(page);
 			freed++;
 			if (!truncate_op) {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 03ca83db0a3e..e5e363fa5d02 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -511,7 +511,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * of the hugetlb head page.  Functions created via the below macros should be
  * used to manipulate these flags.
  *
- * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
+ * HPG_restore_rsv_cnt - Set when a hugetlb page consumes a reservation at
  *	allocation time.  Cleared when page is fully instantiated.  Free
  *	routine checks flag to restore a reservation on error paths.
  *	Synchronization:  Examined or modified by code that knows it has
@@ -535,7 +535,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
  */
 enum hugetlb_page_flags {
-	HPG_restore_reserve = 0,
+	HPG_restore_rsv_cnt = 0,
 	HPG_migratable,
 	HPG_temporary,
 	HPG_freed,
@@ -581,7 +581,7 @@ static inline void ClearHPage##uname(struct page *page)		\
 /*
  * Create functions associated with hugetlb page flags
  */
-HPAGEFLAG(RestoreReserve, restore_reserve)
+HPAGEFLAG(RestoreRsvCnt, restore_rsv_cnt)
 HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c3b2a8a494d6..2a8cea253388 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1165,7 +1165,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
-		SetHPageRestoreReserve(page);
+		SetHPageRestoreRsvCnt(page);
 		h->resv_huge_pages--;
 	}
 
@@ -1549,11 +1549,11 @@ void free_huge_page(struct page *page)
 
 	hugetlb_set_page_subpool(page, NULL);
 	page->mapping = NULL;
-	restore_reserve = HPageRestoreReserve(page);
-	ClearHPageRestoreReserve(page);
+	restore_reserve = HPageRestoreRsvCnt(page);
+	ClearHPageRestoreRsvCnt(page);
 
 	/*
-	 * If HPageRestoreReserve was set on page, page allocation consumed a
+	 * If HPageRestoreRsvCnt was set on page, page allocation consumed a
 	 * reservation.  If the page was associated with a subpool, there
 	 * would have been a page reserved in the subpool before allocation
 	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
@@ -2364,9 +2364,9 @@ static long vma_add_reservation(struct hstate *h,
  * specific error paths, a huge page was allocated (via alloc_huge_page)
  * and is about to be freed.  If a reservation for the page existed,
  * alloc_huge_page would have consumed the reservation and set
- * HPageRestoreReserve in the newly allocated page.  When the page is freed
+ * HPageRestoreRsvCnt in the newly allocated page.  When the page is freed
  * via free_huge_page, the global reservation count will be incremented if
- * HPageRestoreReserve is set.  However, free_huge_page can not adjust the
+ * HPageRestoreRsvCnt is set.  However, free_huge_page can not adjust the
  * reserve map.  Adjust the reserve map here to be consistent with global
  * reserve count adjustments to be made by free_huge_page.
  */
@@ -2374,13 +2374,13 @@ static void restore_reserve_on_error(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address,
 			struct page *page)
 {
-	if (unlikely(HPageRestoreReserve(page))) {
+	if (unlikely(HPageRestoreRsvCnt(page))) {
 		long rc = vma_needs_reservation(h, vma, address);
 
 		if (unlikely(rc < 0)) {
 			/*
 			 * Rare out of memory condition in reserve map
-			 * manipulation.  Clear HPageRestoreReserve so that
+			 * manipulation.  Clear HPageRestoreRsvCnt so that
 			 * global reserve count will not be incremented
 			 * by free_huge_page.  This will make it appear
 			 * as though the reservation for this page was
@@ -2389,7 +2389,7 @@ static void restore_reserve_on_error(struct hstate *h,
 			 * is better than inconsistent global huge page
 			 * accounting of reserve counts.
 			 */
-			ClearHPageRestoreReserve(page);
+			ClearHPageRestoreRsvCnt(page);
 		} else if (rc) {
 			rc = vma_add_reservation(h, vma, address);
 			if (unlikely(rc < 0))
@@ -2397,7 +2397,7 @@ static void restore_reserve_on_error(struct hstate *h,
 				 * See above comment about rare out of
 				 * memory condition.
 				 */
-				ClearHPageRestoreReserve(page);
+				ClearHPageRestoreRsvCnt(page);
 		} else
 			vma_end_reservation(h, vma, address);
 	}
@@ -2602,7 +2602,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		if (!page)
 			goto out_uncharge_cgroup;
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetHPageRestoreReserve(page);
+			SetHPageRestoreRsvCnt(page);
 			h->resv_huge_pages--;
 		}
 		spin_lock_irq(&hugetlb_lock);
@@ -4052,7 +4052,7 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
 	hugepage_add_new_anon_rmap(new_page, vma, addr);
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
-	ClearHPageRestoreReserve(new_page);
+	ClearHPageRestoreRsvCnt(new_page);
 	SetHPageMigratable(new_page);
 }
 
@@ -4525,7 +4525,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
-		ClearHPageRestoreReserve(new_page);
+		ClearHPageRestoreRsvCnt(new_page);
 
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
@@ -4592,7 +4592,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 
 	if (err)
 		return err;
-	ClearHPageRestoreReserve(page);
+	ClearHPageRestoreRsvCnt(page);
 
 	/*
 	 * set page dirty so that it will not be removed from cache/file
@@ -4775,7 +4775,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap) {
-		ClearHPageRestoreReserve(page);
+		ClearHPageRestoreRsvCnt(page);
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
 		page_dup_rmap(page, true);
@@ -5096,7 +5096,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared) {
 		page_dup_rmap(page, true);
 	} else {
-		ClearHPageRestoreReserve(page);
+		ClearHPageRestoreRsvCnt(page);
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9ce5a3793ad4..58c706697b17 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -432,27 +432,27 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		 * If a reservation for the page existed in the reservation
 		 * map of a private mapping, the map was modified to indicate
 		 * the reservation was consumed when the page was allocated.
-		 * We clear the HPageRestoreReserve flag now so that the global
+		 * We clear the HPageRestoreRsvCnt flag now so that the global
 		 * reserve count will not be incremented in free_huge_page.
 		 * The reservation map will still indicate the reservation
 		 * was consumed and possibly prevent later page allocation.
 		 * This is better than leaking a global reservation.  If no
 		 * reservation existed, it is still safe to clear
-		 * HPageRestoreReserve as no adjustments to reservation counts
+		 * HPageRestoreRsvCnt as no adjustments to reservation counts
 		 * were made during allocation.
 		 *
 		 * The reservation map for shared mappings indicates which
 		 * pages have reservations.  When a huge page is allocated
 		 * for an address with a reservation, no change is made to
-		 * the reserve map.  In this case HPageRestoreReserve will be
+		 * the reserve map.  In this case HPageRestoreRsvCnt will be
 		 * set to indicate that the global reservation count should be
 		 * incremented when the page is freed.  This is the desired
 		 * behavior.  However, when a huge page is allocated for an
 		 * address without a reservation a reservation entry is added
-		 * to the reservation map, and HPageRestoreReserve will not be
+		 * to the reservation map, and HPageRestoreRsvCnt will not be
 		 * set. When the page is freed, the global reserve count will
 		 * NOT be incremented and it will appear as though we have
-		 * leaked reserved page.  In this case, set HPageRestoreReserve
+		 * leaked reserved page.  In this case, set HPageRestoreRsvCnt
 		 * so that the global reserve count will be incremented to
 		 * match the reservation map entry which was created.
 		 *
@@ -461,9 +461,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		 * be different or NULL on error.
 		 */
 		if (vm_alloc_shared)
-			SetHPageRestoreReserve(page);
+			SetHPageRestoreRsvCnt(page);
 		else
-			ClearHPageRestoreReserve(page);
+			ClearHPageRestoreRsvCnt(page);
 		put_page(page);
 	}
 	BUG_ON(copied < 0);
-- 
2.31.1

