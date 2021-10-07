Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F347425A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbhJGSVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:21:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38994 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243588AbhJGSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:21:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197I2r7R025138;
        Thu, 7 Oct 2021 18:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+yy9K+4Qv5Wn6Gj8K3ENqioNUdsnU/Fa18h9VDvRMdU=;
 b=C1HM24rs39NX9XWL50JM5dnq9gsBXnuU1nQ7rvDwNxImJGf5d/tBgzKvTm5LI3Xo2upc
 bbJ52n/YDeWlvSSh/XKm/hAtSulJa4hzhzTB9N32775vQwN58A1267RU8Zwt5Un3TCrI
 OuLcxu5lCTtunpXdhQ2lX5oM2b+Uyh82a4dJC1qjvqznhdNfCy6Uuez0zk3kwYKHYTKN
 txCBCsxYsLKW5EYp4xmrvoQcRRTfvoHHvfUQvpl2WGpMNeAhpLN9bUlLpLfgEZLD9+LM
 SgHm+wXUHoX+UJPSNI9Ylz7wYmfQ2lIx9WSAUqZItMUaBfXjlw9I8dPiYayFrTglXQOp 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw2vfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197IA8BQ047007;
        Thu, 7 Oct 2021 18:19:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3bev7ww3ea-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIjH9MzJzM4TuT5x6IeCK59pgI/rgDE0BBqqSCXaAcq99Oi/cR1TpVK2lRUwnDeLceQcgaKt7yXxMXEhLjeSXCeIIPDwCm8WjOEUo5MvikqJN/CzI1uGLWq/pnwIJWASvKmKuJCknJ1DgyEZYqexef1epFh13Mqa2uc0/O6qZKs0+NVWRjz2w4sx32a5yq2T53jGyo+dDyz2pvDCnTJPSba3qBeD9VSZ3LZ9jkwoa7NF+bohyAy+WaID792wx0s9ejL8s36HVTTLoa2F6ONL4PxG/5g4oi7ZQg///wPt8d3a0oR7Twpjvkl++VTJK3ZIneRE17d2XASxeWpW9Tsc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yy9K+4Qv5Wn6Gj8K3ENqioNUdsnU/Fa18h9VDvRMdU=;
 b=Mghyy+8IKgiFgg6bCxzWsbu+g6AuORSpgxft7RnfSQn0mLRAH2XYUe4i82WcFFTFBKuxJiSxXRa6RuqUZ1cYIBI/G/uVnnMyDtbLUEwJRF0sJfwS4etja/ibRt11Eqxp3b+JbPQ4eszKNzxzH4HTk381weUXJgY1ee7uXmaYhTCGLheivy8Evd3hIJlvRI/Vkft1lLjLZ5rJ75P4SL3qYqAt1a1wfFf34chJbfT8rtaGFWWqRlW5kEqXsR4HtUK0VoWhMy9nnUpfqNF60apBA9WLA6K6lzgxQ5SX7jhFxKUrl19MJh8jW1yxTH8NLIxJ1i8ddGnoSgfzGesVCz3VSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yy9K+4Qv5Wn6Gj8K3ENqioNUdsnU/Fa18h9VDvRMdU=;
 b=z5+5r2VSY5j544ZwraZTTdvdHYnTx26SYkIOd1cxuZwpm700f1GT+ewuD45UdXLvMr/k2FZGhuHJ5rpnhw4x3cHmBVNeZx8lvq19bePg9BPoj/hUm5AkeiV5zLz5Jy9a9z7zDR8njtWEGrcg/udXqwu/vZyeRgSBIY2gZPmHYDE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 18:19:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 18:19:37 +0000
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
Subject: [PATCH v4 2/5] mm/cma: add cma_pages_valid to determine if pages are in CMA
Date:   Thu,  7 Oct 2021 11:19:15 -0700
Message-Id: <20211007181918.136982-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211007181918.136982-1-mike.kravetz@oracle.com>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 18:19:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07e5530b-df52-4dab-39d8-08d989bf05c2
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB25521FD447F6C03C3C14217FE2B19@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAIltT4E8H9OS+YmBaISTbzDbwwN3EF6O3kJLeStloVNCuqPTuWy+XDL7Am492LjU8DA6IfB4iorDtT/FSmhjgqEtjadG5Kq/uRp717aqqDzo+jdh2QW5IwKNO6O52YryNvITL3LRoYS8MjuBhMQkInverksypSg0lhIpzNCJGkLzXTUq0U7ZxYetIWtPPw1vjub+/7DCoR4rnNaLZNgPxrUA6AxLcILSRg2fBXa7z+WLRGqQZzCTBx3CQZGnA8NAKnrbgvu6A0za3EkG8UCvtZ4OoMO2tffJ13Qlyn2v80sL1cyWEMDXpwK+8SGPNeDKsPmXM000xI6jkbe0Q0zoG2UvmCD2IyMu1OWoug0wPR8jIg8W/3w6fC0cqSSDz6CfMMauckuItnDWLrzBOKV/L2DdlzRFg2hZNJNcO2cYD1tnO8Cw8WUkE4Sxkvpu7Dl+ucDkDsg/wu2xbUu4MMJkA6S5gODwCc2OBaFS15lzJKVNspBbUV6UftPcbFNQyVl1zrL05iHjxIWS+Qh7Y+viyfMB/kz7z9KnfzrlGoZ8u/h2VO18r9uypqTklfhutwh4boGGF2hv1xLNRdT/h0OhFKiNZk3X+yZ4n9zFLY8pC3/fuMR5lxPAKJYJ8tSYtWX72HOMSzk5AIklAfZ8jZE8zmqHIgn2ChtbFmUWIoM/tcXG6qiJdhL7CELt8NPGkocDvo5YrAhrOGQkBSNLcA2Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38350700002)(316002)(7416002)(44832011)(5660300002)(6486002)(107886003)(2906002)(1076003)(186003)(508600001)(54906003)(38100700002)(6666004)(66476007)(36756003)(66946007)(4326008)(66556008)(52116002)(7696005)(956004)(2616005)(26005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plesN2WI2FBg2Wi7JdwkRzo+9eCaxiAMoM4kvp5dlkqgK4GDlsgEB/lb9yD6?=
 =?us-ascii?Q?EjhgSZxYea6fF3hxCFH2k+yDhJMgzgRVPWRoCh4djtHl/sfc4EOuraz563iI?=
 =?us-ascii?Q?SFbmfgo4xms9WJmyXqKl4WIXAtLYtVn7bHWclhig7iJZov8L85Mt0lcHCU/P?=
 =?us-ascii?Q?pvcWlMDQ1aEejcWoDLatZ4qD7lpVh250zcWqj9Ir0/Kh0SFAjLiJMplGFKsK?=
 =?us-ascii?Q?uQsBElJwygwnID+NohJtxFU01IXJ52CQ8bDfgTGfGPTCQCQCro0Z4gCYuTRM?=
 =?us-ascii?Q?JVMEmDh8ur8uKoIjdtYpggsDJfhEqhAJYbGTQqYqWALWgVIqEz4UlG9OaY/W?=
 =?us-ascii?Q?UY9EkxKXGVtpq6fTgjBW32N+NKiBpGYMHpzQs/KCTHEIcCzE6mP+r3wRgdoj?=
 =?us-ascii?Q?3rgrCJAZ5bt39YrONOas5LwTIaTLNb3QctUiWztncnX1pchd+KAiRjCL6A+B?=
 =?us-ascii?Q?m+E3iTSB+L5htRUDS3O8QjRWQ3ir4cjH5lyGFjsaefhqb8rcSELKPR3YrMvH?=
 =?us-ascii?Q?1ExOxkfXFTI1cnroagetDpoWc6//RTGHyVdx48vuhbMXOvnE5KPMLs35dV6o?=
 =?us-ascii?Q?MGnbRP2lm2TB5GrDyuKMmgr41t577EPwjDO9IM1sshX+31jPdh82woMPnV2K?=
 =?us-ascii?Q?faCqIAYNJ8b2S+PaGrw3rcIkCrPuyV4OLVO/b1PhJ8lZTll3voZLX4ZBdqxS?=
 =?us-ascii?Q?uNeDqn2zur6AfOEqWUzKQyZ0LgDex5ofbHnvIyogWy/EmYXL99pj4WNtzxiq?=
 =?us-ascii?Q?+OxCga3FzApwEgW8HSv9b8x4YEpIAEaopvxXx44oXQYVi2Z3PDQ8Q8pv0QL5?=
 =?us-ascii?Q?MtNWpvSMaILkrRSvp7Dl5Czl2vv+vr6MMTxK9C720U1HLU+5KHG3Vs+SHbgL?=
 =?us-ascii?Q?/rGDVYFpWg3Me8Or3tWJtzkd9i9lyMBOYpjWcef0OG+vCHGDHGvrrEXE++05?=
 =?us-ascii?Q?Kzid2TTnmUrVdT0XAE9BaNV3x3oUw//DkXUW07rARV11aNgJ6d59tWxXkeqN?=
 =?us-ascii?Q?lXPk5W0RUP30nvkJbSnU2dQMvXACZRuuYkDIsvO01qZKC8t3K8XpQ9CB8AnV?=
 =?us-ascii?Q?WQ7CGqkRv7M4zYLS+P2bFCSUVXzu3buE/TDqQBEk7uiHW2Dwf/l6FLwR9vg2?=
 =?us-ascii?Q?WNHm7nqx2foOws7MHKi++uIemNZW9s2CYzQlgCp8iHykJUyV0YR7s2B+DjCR?=
 =?us-ascii?Q?lXt4QUMHF/3/A7AHcjiJcrydlVeHvcYl+bBOEUjw/wrIbK+Od2y8gxZ016+G?=
 =?us-ascii?Q?H/bE/c9Sm4XUZaK0D826XTCjY0ps8p78VvTvWng8fn1d1CjYc6q3BRLrUKKd?=
 =?us-ascii?Q?TWnCsRvJIft7zzDTLHbv8IlN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e5530b-df52-4dab-39d8-08d989bf05c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 18:19:37.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWMJXJM4Vmx+jpmr1SneTFfQUIH9DvwvELkJQk4eTVDN5ttakF0PLUgQV/UJT3N5xd+1CPHYbq2Rjl3KzM//VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070118
X-Proofpoint-ORIG-GUID: I_sqvM63uolDTOObbGsKPwvXGi6X6JGA
X-Proofpoint-GUID: I_sqvM63uolDTOObbGsKPwvXGi6X6JGA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new interface cma_pages_valid() which indicates if the specified
pages are part of a CMA region.  This interface will be used in a
subsequent patch by hugetlb code.

In order to keep the same amount of DEBUG information, a pr_debug() call
was added to cma_pages_valid().  In the case where the page passed to
cma_release is not in cma region, the debug message will be printed from
cma_pages_valid as opposed to cma_release.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/cma.h |  1 +
 mm/cma.c            | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 53fd8c3cdbd0..bd801023504b 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -46,6 +46,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
+extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
diff --git a/mm/cma.c b/mm/cma.c
index 995e15480937..11152c3fb23c 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -524,6 +524,25 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	return page;
 }
 
+bool cma_pages_valid(struct cma *cma, const struct page *pages,
+		     unsigned long count)
+{
+	unsigned long pfn;
+
+	if (!cma || !pages)
+		return false;
+
+	pfn = page_to_pfn(pages);
+
+	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count) {
+		pr_debug("%s(page %p, count %lu)\n", __func__,
+						(void *)pages, count);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * cma_release() - release allocated pages
  * @cma:   Contiguous memory region for which the allocation is performed.
@@ -539,16 +558,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
 {
 	unsigned long pfn;
 
-	if (!cma || !pages)
+	if (!cma_pages_valid(cma, pages, count))
 		return false;
 
 	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
 
 	pfn = page_to_pfn(pages);
 
-	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
-		return false;
-
 	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
 
 	free_contig_range(pfn, count);
-- 
2.31.1

