Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C5C3D1A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhGUWZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40554 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhGUWZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvDcM009325;
        Wed, 21 Jul 2021 23:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=MIxRDmB8nzh0QgtoXqdcIgpuGwLwYMo24Dc9amAPQRU=;
 b=GOxLJ5Uy8KAS0ltujil3lUmhkt9DLfbwkfuyz9HSqEtSamy4Hd1bRKLHYRF0c8C1havw
 FIjocxvusNChP4/LDK4leorzU/d8gEcwHZBcGmLNH+okYzTcJdWSH4GHASkM35fIpmnj
 QS+E/uBeRCp5TjA5eNnMJb1l+ox4/iFiiNA4uAkAnpgexFDFK9E30zDPt/vkL9HiX5Hq
 VIxAy+Y6lf/MMtorCq1ur7s//kPYjz8Mcc47yFyF5/NfLlt96zqTEOEWif+bwUoe9B/J
 z51Kk11xHG1JJegzDrrcjWQ0gHzgkLDc+Ka2FHMLZULfkGNMNfyS3BToU0x/1+s0yDoU WA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=MIxRDmB8nzh0QgtoXqdcIgpuGwLwYMo24Dc9amAPQRU=;
 b=sF+mi86m7x+7klhRkbAiTsU7KXFVZmk8gXSXF98W3uxX/ZN8PSnwaB3BHpaA6/3xNEa0
 GnI4oLcFHDXcnIuS5LJi+bLHhA1jImcEhR1iVW+R212nEQ1eWlNKGZLsjIN8vKGoJvLh
 T6X7IvA9dSeOL+KYeLDKA8HmcNQWVnqKlrkWNa0hmJxvLUllcxLLL5C6km/BDILkvPt3
 tHZL+WVyQ3f2YI1Gjdof56ydFMs7vfk6rBgWJwcXgCLbmpA/gc2lwAZusmOVHS/B0RAT
 7Q1DOWFdDEMlZbyT5jgbzRM9GzQ6ac8A/291H9Bili21c+p/viXuSIkCRH4eVsmbusZw lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xu2fr5wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN0ZqG143586;
        Wed, 21 Jul 2021 23:05:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 39umb3qe17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKX++ncLI05qY2xt2tYwGhZoVkocEzGyL6v+MRLKI7pIStAa50FbZU/r15B/Tmhastf0yHr/pM9ROAdLSkcMMRGbx82jbZtdmvMXK4WnrYqU7yi14S/MoYdfA0kMdbb287eEWhOqjR5RdY8DHVGIduNMTfcV9R5+HLty9vNxiKmo8XZe7rBXbaVRcEB5sjyWvdj0vvC2ca/zYw6LVk6pWL1Bn7QammDOKjecbRqKcULHfjgUH80hK8hlLgdjOEuU8T4t80TmKR2xrw1JSQcbV52UABGoSPd9BBQ0+jy9rpiuNZwGtiN9OKTSpEoh9cZblAHxozWUwRisHqXFtV9vZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIxRDmB8nzh0QgtoXqdcIgpuGwLwYMo24Dc9amAPQRU=;
 b=dSh3VwM4o9nH9dvwiyS2LklbEjIaZNSq2P1Y0K7+F5LliEwhvu4mRVcYwEiY0pVNaagevvJD7mM2OrDOdY4hpMiiJUT0lfdzSF08SiTz8V9gKylmAbH+fp2SuZGKWc/pfzRuA9ALYw+7g4ZvkJ3Re1ntnlSFbz2SyoB7ioxQytJZb6XJIsB5mIQ37SUUY5T5FGZ7Uq6tDgL3lleRht7lJ9QT4VPJhx6zwopUO2qJQbczLNwrOc439fIv87DDmamzmUccJBwkR+wRO3vZFqYS7uBIo423EQfxdgipODNayPchd7/9WOtxaHdTYjO9giv629noNOl7sZHxXBA86BxKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIxRDmB8nzh0QgtoXqdcIgpuGwLwYMo24Dc9amAPQRU=;
 b=dihowa4tBlV0ceufeFGsKj29cZ0flQ/uHoTtoxph44cowHrTJQ/3OEhlkZ/4rvVNDyIquP1ysG1JIC3RTKE5Rw0zhXGQpYFmAhNeZCW8RmVDySwmYabKkLdEJWMf7yk8espE+SxhlFIXj9QYefl7odA3rVn7i8373nkOao3e1+s=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:34 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 6/8] hugetlb: vmemmap optimizations when demoting hugetlb pages
Date:   Wed, 21 Jul 2021 16:05:09 -0700
Message-Id: <20210721230511.201823-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721230511.201823-1-mike.kravetz@oracle.com>
References: <20210721230511.201823-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf508e1-0f52-4e57-cdd9-08d94c9c0b4e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB373544C45514AAA2A08EF314E2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtSVaq29R2H7e6Lhe416hhMcRakCjyUwt+8B6nX+pWXV6PpHEoiG73TPdwZ1a6x5gIkuX6fW8jibHmxCmjx3vyLsfpJ0kmRb0sRwbplVb+pG5V5UUuZ0X2ppH15CuyZF1kLbko5OLcWtyIR8opHbLHbwkvHMiDNbDdaQ4WwlTha2JxAG0vEgxOjhNVC0ZwPOfkIRncxdjbOo93t4sS2d/DmlJ2twaZ6O48j4XaVsrjMCJykrPNSMRthQi3+tg/PJYEA9RTiRrAJ7ESoLjOIAmSwMKedypUFTGVZPLxKM5iLCV4YaxAUAiXDhcCWW9iSZPO+i+mw75Riwg/5ZQXBAU9ITOMpT5Bi45YxXnj8TLwF9aWahfAG49Oh6CkrRNfqCGGEAu/DBSGFgEHYRwmW5rB6tHXDMnHG9eoPzQcarywdos7wKSyw+3bDEdaAhX99XIpvA6/CY9YDHEdFKF9tnP+ufW+P4nStPBtdOB48F1Z6vjLtv9JvA5kP0BgJqjC4sPcI94utqOUh9lqY2MrGMrTTmiPMI/ntrvoiOmki20qbjzM9/+uhzbfJrs8J5tVsDcHcRbGzbdWOY390fmykK4Yg/PgTf//90s4d3cS+d+8tXr4OE1nxwmcWck0zrqeDsLV0COWg7tgL+RlYHvFk1PlWGSSfDin7gybIt3NcMRuhlscfAqCu3/UF85vGXeMXtUfdC+Rv2QJLjx1QdExImaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(30864003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XIVWhSapFP0sga6CMAaCIqCGZhnWqy7Gw2/qWdtCbfsQ5JSJU8sbckPokcas?=
 =?us-ascii?Q?Px3lrX0DtVp9VDpPGxqF71YHbD0loxBS2hulDB1UIk4GgiU46pHXnJpjXItv?=
 =?us-ascii?Q?hZWi7HNS2FNhC4Bv189oR17es63IW9us/ApLUppgntEC0CiaJZvmk3+b9akD?=
 =?us-ascii?Q?Fgx+ztwj6PM+lMcbwTaZVtWQ/iXbQR6jBfQRh90QmWYsUxPjAa/86w+HVzyz?=
 =?us-ascii?Q?I/JRowq1QLdjwyttwkvMiah0LgCwEhSy53iOH00wzzVKyEdtimLgjbajfr4c?=
 =?us-ascii?Q?6Dlasyv9+5PyrFgxpMty+qMh3+aL/0UaWcqVqWMqi0cljs1fjXVomXELA/4d?=
 =?us-ascii?Q?86Z9Nvvjr8c/bARvoqkZcqwTw606kxn6Dt0g34R4mbPl/g+2VtG3E8uJ5kVm?=
 =?us-ascii?Q?Iki0dGI1i5eJ5wx7ZhAJcQDrKejLB1y/Yc20toYVL8SfXhIZQvG+V73+IbPk?=
 =?us-ascii?Q?1moa2oUD4QAopOZyYxyNDWT1fWwzbFc0kqp1lYOX1Hj8BYvdA57vyi3BOSXN?=
 =?us-ascii?Q?kj2ylPuzgX7pZJ4WXU/SPo4jLP/+Ks9xL6+PTnw+q4z+FT4hG/jnOYBk6qyF?=
 =?us-ascii?Q?54MC5NBl5aFQbn/SkLITmFI4JERvtYtpXKHYeU5B29MXaE23CvM1whvpl6YT?=
 =?us-ascii?Q?KDKIWgPWkRTgvLyCRltrgDgx8PxF6DzzkdY2lNnb5efLAbv9Bfy9r9W1VaNJ?=
 =?us-ascii?Q?8o1ctxe7Lgku/imseVoNCOLFPWD1x0mOjDr8glg7t7Dd2vlbQ4Wf2s3AYjBr?=
 =?us-ascii?Q?79j/+FzkU9ddEcK7P4aeMwFEOtJ0chR8VcRm6a0GNMG6fLmSmoxe+GR8zQ/+?=
 =?us-ascii?Q?VZCWeF7ZHseQFAEBtpILIn4XZXyUE2iR1xvVIrKKJ7CwmVGp1pBVIi5Cud8o?=
 =?us-ascii?Q?qUvOqSxxtod5jdG17pSm9G2sLNGtpDJQCMTt9tyyBQ4NoFw3p9AWpB/0M/t+?=
 =?us-ascii?Q?BSFhrkIHDnfg5vhR4St0iQav5tlH0tyweEVyz6kfO1rWYNA4t96IgQB9JKXe?=
 =?us-ascii?Q?w8jeKqb5wa9xNKFq4GcuQEqRS3c1aLn3SVcYH1VtFoiWUSgqRNAbBNSoXeGY?=
 =?us-ascii?Q?WzJpKb1tncmYtDMcXr82Ecd1TD8DSS4iRfB6KwfIfjpI1POKuTnFBc8hsOn7?=
 =?us-ascii?Q?nQTtnxk5rIaY7sOY4kymWIJXnna0ir2oyne+d2O/QdeCfeR9mIVi4co5/tkb?=
 =?us-ascii?Q?h3eSRQAv5y/LVWUqwfTPhchC73gzAfbTXxvYRB4ce6JwXdmJE7SxVWQ8Myuz?=
 =?us-ascii?Q?tWJMfgbigQDcXUcUrQLNppUNU5v8QcFFzOZhroYjPR+htZbZDfJvxd7kLsZ2?=
 =?us-ascii?Q?kHD9uJh8JF0M/030QlXrDiXJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf508e1-0f52-4e57-cdd9-08d94c9c0b4e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:34.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5fW3Ys/lwaf+eytBHiz20vs84O6dlkvTbXklTYGzYwxdXhBcVK6kzlmLBq5U/Q71foeIzRgNGEtZmen5aFICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210137
X-Proofpoint-ORIG-GUID: SI4Vrv7gCgMFVQL_iyJnfJ7rX6OI_OLH
X-Proofpoint-GUID: SI4Vrv7gCgMFVQL_iyJnfJ7rX6OI_OLH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When demoting a hugetlb page with optimized vmemmap, we allocate vmemmap
for the entire address range represented by the huge page.  Then, we
split the huge page into huge pages of a smaller size.  When preparing
these smaller huge pages for use, we optimize vmemmap for their
associated address range and free vmemmap pages.

It is sub-optimal to allocate all the vmemmap pages associated with the
original page and then free most of those pages when preparing the
smaller huge pages after the split.  Instead, calculate the number of
vmemmap pages needed after the split and just allocate that number of
pages.  Then, only populate those areas of the vmmap required for the
smaller huge pages.

Introduce two new routines:
- demote_huge_page_vmemmap - This has knowledge of the hugetlb demote
  process and will calculate the number of huge pages needed for the
  smaller huge pages after the split.  It also creates a 'demote_mask'
  that is used to indicate where within the address range of the
  original huge page the smaller huge pages will reside.  This mask is
  used to map vmemmap pages within the range.
- vmemmap_remap_demote - This is the routine which actually allocates
  the vmemmap pages and performs vmemmap manipulations based on the
  passed demote_mask.

These routines will be used in a subsequent patch.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/mm.h   |   4 ++
 mm/hugetlb_vmemmap.c |  60 +++++++++++++++++++++
 mm/hugetlb_vmemmap.h |   6 +++
 mm/sparse-vmemmap.c  | 123 +++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 189 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..269b135489e6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3080,6 +3080,10 @@ int vmemmap_remap_free(unsigned long start, unsigned long end,
 		       unsigned long reuse);
 int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 			unsigned long reuse, gfp_t gfp_mask);
+int vmemmap_remap_demote(unsigned long start, unsigned long end,
+			unsigned long reuse, unsigned long demote_nr_pages,
+			unsigned long demote_mask,
+			unsigned long demote_map_pages, gfp_t gfp_mask);
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c540c21e26f5..c82d60398c16 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -264,6 +264,66 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 		SetHPageVmemmapOptimized(head);
 }
 
+/*
+ * vmammap pages will be allocated and mapped such that this range which
+ * previously represented a single huge page will now represent a set of
+ * pages of a smaller size.
+ */
+int demote_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	int ret;
+	unsigned long vmemmap_addr = (unsigned long)head;
+	unsigned long vmemmap_end, vmemmap_reuse;
+	unsigned long demote_mask;
+	unsigned long demote_nr_pages;
+	struct hstate *target;
+
+	VM_BUG_ON(!h->demote_order);
+	if (!HPageVmemmapOptimized(head))
+		return 0;
+
+	target = size_to_hstate(PAGE_SIZE << h->demote_order);
+
+	/* Number of vmemmap pages required to demote page */
+	demote_nr_pages = pages_per_huge_page(h) / pages_per_huge_page(target);
+	demote_nr_pages *= RESERVE_VMEMMAP_NR;
+	demote_nr_pages -= RESERVE_VMEMMAP_NR;	/* pages currently present */
+
+	/*
+	 * mask to identify where within the range new smaller pages will
+	 * reside.  This will be used to map new vmemmap pages.
+	 */
+	demote_mask = ((unsigned long) pages_per_huge_page(target) *
+			sizeof(struct page)) - 1;
+
+	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
+	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
+	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
+	/*
+	 * The range [@vmemmap_addr, @vmemmap_end) represents a single huge
+	 * page of size h->order.  It is vmemmap optimized and is only mapped
+	 * with RESERVE_VMEMMAP_NR pages.  The huge page will be split into
+	 * multiple pages of a smaller size (h->demote_order).  vmemmap pages
+	 * must be callocated for each of these smaller size pages and
+	 * appropriately mapped.
+	 */
+	ret = vmemmap_remap_demote(vmemmap_addr, vmemmap_end, vmemmap_reuse,
+				  demote_nr_pages, demote_mask,
+				  RESERVE_VMEMMAP_NR,
+				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
+
+	if (!ret) {
+		int i;
+
+		for (i = pages_per_huge_page(target);
+					i < pages_per_huge_page(h);
+					i += pages_per_huge_page(target))
+			SetHPageVmemmapOptimized(head + i);
+	}
+
+	return ret;
+}
+
 void __init hugetlb_vmemmap_init(struct hstate *h)
 {
 	unsigned int nr_pages = pages_per_huge_page(h);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index cb2bef8f9e73..44382504efc3 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+int demote_huge_page_vmemmap(struct hstate *h, struct page *head);
 void hugetlb_vmemmap_init(struct hstate *h);
 
 /*
@@ -33,6 +34,11 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline int demote_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bdce883f9286..ac2681bf006b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -43,6 +43,15 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @demote_mask		demote specific.  mask to know virtual address of
+ *			where to start mapping pages during a demote operation.
+ * @demote_map_pages	demote specific.  number of pages which mapped for
+ *			each demoted page.
+ * @demote_tmp_count	demote specific.  counter for the number of pages
+ *			mapped per page.
+ * @demote_tmp_addr	demote specific.  when more then one page must be
+ *			mapped for each demoted size page, virtual address
+ *			of the next page to be mapped.
  */
 struct vmemmap_remap_walk {
 	void (*remap_pte)(pte_t *pte, unsigned long addr,
@@ -51,6 +60,10 @@ struct vmemmap_remap_walk {
 	struct page *reuse_page;
 	unsigned long reuse_addr;
 	struct list_head *vmemmap_pages;
+	unsigned long demote_mask;
+	unsigned long demote_map_pages;
+	unsigned long demote_tmp_count;
+	unsigned long demote_tmp_addr;
 };
 
 static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
@@ -262,6 +275,51 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
 
+static void vmemmap_demote_pte(pte_t *pte, unsigned long addr,
+				struct vmemmap_remap_walk *walk)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	struct page *page;
+	void *to;
+
+	if (!(addr & walk->demote_mask)) {
+		/* head page */
+		page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+		list_del(&page->lru);
+		to = page_to_virt(page);
+		copy_page(to, (void *)walk->reuse_addr);
+		set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+		/*
+		 * after mapping head page, set demote_tmp_reuse for
+		 * the following tail page to be mapped (if any).
+		 */
+		walk->demote_tmp_count = walk->demote_map_pages;
+		if (--walk->demote_tmp_count)
+			walk->demote_tmp_addr = addr + PAGE_SIZE;
+	} else if (addr == walk->demote_tmp_addr) {
+		/* first tall page */
+		page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+		list_del(&page->lru);
+		to = page_to_virt(page);
+		copy_page(to, (void *)walk->reuse_addr);
+		set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+		if (--walk->demote_tmp_count) {
+			walk->demote_tmp_addr = addr + PAGE_SIZE;
+		} else {
+			walk->demote_tmp_addr = 0UL;
+			/* remaining tail pages mapped to this page */
+			walk->reuse_page = page;
+		}
+	} else {
+		/* remaining tail pages */
+		pgprot_t pgprot = PAGE_KERNEL_RO;
+		pte_t entry = mk_pte(walk->reuse_page, pgprot);
+
+		page = pte_page(*pte);
+		set_pte_at(&init_mm, addr, pte, entry);
+	}
+}
+
 /**
  * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
  *			to the page which @reuse is mapped to, then free vmemmap
@@ -327,11 +385,9 @@ int vmemmap_remap_free(unsigned long start, unsigned long end,
 	return ret;
 }
 
-static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
+static int __alloc_vmemmap_pages(unsigned long nr_pages, int nid,
 				   gfp_t gfp_mask, struct list_head *list)
 {
-	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
-	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
 
 	while (nr_pages--) {
@@ -348,6 +404,21 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	return -ENOMEM;
 }
 
+static int alloc_vmemmap_pages(unsigned long nr_pages, int nid,
+				   gfp_t gfp_mask, struct list_head *list)
+{
+	return __alloc_vmemmap_pages(nr_pages, nid, gfp_mask, list);
+}
+
+static int alloc_vmemmap_range(unsigned long start, unsigned long end,
+				   gfp_t gfp_mask, struct list_head *list)
+{
+	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
+	int nid = page_to_nid((struct page *)start);
+
+	return __alloc_vmemmap_pages(nr_pages, nid, gfp_mask, list);
+}
+
 /**
  * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
  *			 to the page which is from the @vmemmap_pages
@@ -374,7 +445,51 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 	/* See the comment in the vmemmap_remap_free(). */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
+	if (alloc_vmemmap_range(start, end, gfp_mask, &vmemmap_pages))
+		return -ENOMEM;
+
+	mmap_read_lock(&init_mm);
+	vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
+
+	return 0;
+}
+
+/**
+ * vmemmap_remap_demote - remap the optimized vmemmap virtual address range
+ *		for a huge page to accommodate splitting that huge
+ *		page into pages of a smaller size.  That smaller size
+ *		is specified by demote_mask.
+ * @start:	start address of the vmemmap virtual address range to remap
+ *		for smaller pages.
+ * @end:	end address of the vmemmap virtual address range to remap.
+ * @reuse:	reuse address.
+ * @demote_nr_pages: number of vmammap pages to allocate for remapping.
+ * @demote_mask: mask specifying where to perform remapping within the passed
+ *		 range.
+ * @demote_map_pages: number of pages to map for each demoted page
+ * @gfp_mask:	GFP flag for allocating vmemmap pages.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int vmemmap_remap_demote(unsigned long start, unsigned long end,
+			unsigned long reuse, unsigned long demote_nr_pages,
+			unsigned long demote_mask,
+			unsigned long demote_map_pages, gfp_t gfp_mask)
+{
+	LIST_HEAD(vmemmap_pages);
+	int nid = page_to_nid((struct page *)start);
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= vmemmap_demote_pte,
+		.reuse_addr	= reuse,
+		.vmemmap_pages	= &vmemmap_pages,
+		.demote_mask	= demote_mask,
+		.demote_map_pages = demote_map_pages,
+	};
+
+	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
+
+	if (alloc_vmemmap_pages(demote_nr_pages, nid, gfp_mask, &vmemmap_pages))
 		return -ENOMEM;
 
 	mmap_read_lock(&init_mm);
-- 
2.31.1

