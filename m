Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F653EE01C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhHPWvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21938 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232641AbhHPWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMmFhE020124;
        Mon, 16 Aug 2021 22:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dHD2WuM/ybdU4ii+bYUQxuX3QoRCL/c9D3+uW5FKocQ=;
 b=kcrNUF8X7EXZoJqbFN2a6XkMrj052tQScnUOFI3x444Y5RnouO+37Hb3VZeK8Kg9ug4a
 5Bskd9Q4f6PGNv0oFMiIfEtrbLr1h9pPhRVFk9vwUGkWziSeV7EZMAV+gNVVC5Lg1Dk5
 6X3f44ndfSzmc+ca6IWLYR2ChBAuAoG2G+azmriJyimC2lvYQxtU2yeQ0Bn3PKuXkP7p
 yw5DoSW6aXsVrrH6FGvU3R3KHy6SxUtlo31TBhU5KGh98bouEdnJhn6WhVlymIKWn5fZ
 k8gMfjC5DtXOV+szyCyHvQHO6Px6kq9VFsuV/0i9R/H7DVFervbPeUAjeFKTYPbDxWRa +A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=dHD2WuM/ybdU4ii+bYUQxuX3QoRCL/c9D3+uW5FKocQ=;
 b=cQrweU5IEqpR7sX3V8i7gIaa0zSzVsypyYwmjiIctN3himJHcCaI2miRSGAWCROxTvck
 f4LFjLTttn2XieeW2mWBXUIsv1tHbHMVME16zX7XvZZ2w2y7PBUv6VPJOplPcIEANOE+
 rI0KPxq7JZvw5oMcB0EpuEwnmFNxeqS3//skm3OG5/phcKuf6g8NyfBOHicBY8sc0sky
 BRI5zrghFRzE+5JICIqhA0PWEo2mtkKHfP4lrarR6vGzYEzdUw/3e+hz0sRPI7fMTDrk
 8Z87KakCsvGpg4F+Dutslbum3aDOFNlK7Mzinek+EdI2NwVUVH7yASclQ/2obGfLJlTC xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af1q9bd75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMium6171583;
        Mon, 16 Aug 2021 22:50:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3aeqkt0pdq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANEs9hcY2LHTHg7mdH1/DIbLkOcdMvW8bHZexrYHgc5WQHdvGJoah8Se4bevsmqkbY9tB1/By+G+gFvNP3BfMqhE2MdkjmlV3Um4Y3ZSmuVhHjVabOZZestKpyJiWkxVm9RakoztXtqGykBUfVaJtxWpzc0zIkvUwXzFmYJ3mwywaqH2px1gupKwpJOMr/QzYS7xSl5NpCW9zoH7i50wtRtqym7l3PyGYC552iidNPZSJoVSckV+csk1ltDjD0ALQ/E2TUZUausbj41zqJsZ+4gBJ75OZA1rN1KgU2TqjneOaVQXVj2BBji3D7e6ilQ8rpYWmoToMIIE2VxBP0RFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHD2WuM/ybdU4ii+bYUQxuX3QoRCL/c9D3+uW5FKocQ=;
 b=D17hzT0WfqqfBF++7XYTpH7CkuEHg/1vp1TCpeMc2Qcwp1wLFFrLSPe1BZsjzYnWj3pGycOhbko5TS5Smc7KIp23aFfydZ7hvC4jipTBvQ3KQvRO4NTvQfWwChgpxMcTfUa30dwhDlTVDcfAVe3cQ/tnCDLsBKlWEUdAAFWgbrp5T2glr4wGL9LaH3syDdwRdN1x//ze/rikRlaCONObw/z3oUq/TfPGEAk+vBRM2/a9OeVYcmy8WoUaRGsZ7zGZl+J9OH9/LmEulggpPAwNHNdyFaw1w17yizCtQfKXxveajvmp0PNv+wjCz+K4/xO4q/cQKdzBKSf0Ymbt/W728g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHD2WuM/ybdU4ii+bYUQxuX3QoRCL/c9D3+uW5FKocQ=;
 b=jgpQOEgMjMxtCiTvYqqzoVnSh4QHOJR2O1hqfnqGYv05c/pjrNnPvVsT5qA2OXfN8HEACoPN1GrEQGLL55JN3qbs6Y/ZOlAR1kSqhX4UgLfQxReP4fqsZcg2j6rz53IeBGxDU523dTY7eHYFpFAMvlJo49AwZ6WF/0HUlP9ik5E=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:16 +0000
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
Date:   Mon, 16 Aug 2021 15:49:51 -0700
Message-Id: <20210816224953.157796-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afea18e2-526c-419a-1aba-08d961083770
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3397A20D93FA3AADDA9E8FB9E2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1DBnWohQPUyQfYv+XTyk6K7LZOAjsWhFrGeVzhaAow9mdTfY9BW1eYDBJg5cx00+nap6gHGfafDAOcuXakjYr7lgvwvavX7fezKSsnkwbiFtklmENFvEEz99Kh1jKi4anjCRF21hzo2h7vQ6CVtyzalaIFzNkELcnyI6S1D5Z/YlsS+BrZES6nWVE6to67h9p9TPwrYvsJ+XwuUGXuVdVJDwLt8mDKKNgCxKXbrijYElPD40NNfOJ/FVayEv0B1sdPZmBjZZ3FxClK9Vw2xhRK8mUXggJa7UZAAQMvdO8OiRcJRbCrqyyZdEjA5Qm8wy0EK2kst3Yk4p1GmWco+08qxvb/4K8SLE35DuBKwTqWwhGGLOW5f6ARnolGQMmasjvu/nPT0AnXW937ez0wywWMWGh4Y+eYG7tAvNHB7Yjnzn27c0wUaiR/8+03NsBK2oaq/aYZjMwz++NCe+F3D3KpKL8/tucy7ZxN5qtEJoYErU3Syic6N4zIPvUskjYvHULK6nh5XGCxXGyV9NtFu7tUZT6SH1WPgi1bDcK5RSvgQP6Nzu1GOPEVkLBGb6AI1bW3zgc/l9CTgu0GJybuQDm/ieG4lihP7TUyjX8BXSCdFFLRAcGL0oMbUB29++fHxHml9TsiEGBiSXo8WFKLC3kYUS8RxChXSzI5S9efBw068jrK8AzHCsNmLsb2mol2kuNA3yDqnX9vTM/KwHrT2UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(30864003)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQEyHA3MYpQpaIU2adEk9Xi2QLGUsbTMdLNxjweD5xDeJGCJRi9+SdKBnBXn?=
 =?us-ascii?Q?FyAxTfTSZ4g8lV+wND9sn8iJkcruMXfuddFfs4XHB4KExCmWTLHdHJKQr1Qx?=
 =?us-ascii?Q?Zp3qNkdjODyEAd0HCSCq82KS2neWATUkx2oDdnAbudpseSvn+mv6NcX0Gdco?=
 =?us-ascii?Q?RiGw46Xo0ddLkytktffJ2/bSgVY8JdHQJb39ccy0PRkCVZgpCGixiBSWzVLB?=
 =?us-ascii?Q?T3Bz9fHMwqSH/MiRiWMl+v9ofm9MsDTc/IOdl7YRaqdSNf2EtDlLxfVO0ozt?=
 =?us-ascii?Q?ZtFroSSNuG31YNZQBWXsyKsHlHmd3pKUs2LD7749NCPsUHJMTAVrRtQfYGk5?=
 =?us-ascii?Q?j4wmWM7RwTra1nHpzDAS6bKFMwN145CWXzCeWm0j8SzQpJU4crWwa1blGiMW?=
 =?us-ascii?Q?16hLzJiDqHcyn/3FYShlJtdLxymjacUTsdAPbfxhLH+sYlrmTt6WfvT2ibOR?=
 =?us-ascii?Q?G4LLsAJcMcwPl5CaVzoDzwcMjToQ2trWWqk0LvCcaUyJpQnvjqH+bbbrS+NL?=
 =?us-ascii?Q?aFYYAFQ5gNjws61n7lHI8OCm1DFLctpXngIDDENcr2BE714z7c0CefvOVemv?=
 =?us-ascii?Q?lOTB8lShis05psADPvIaI0E0VeW9ZHBaw5YhUekyd2AbaufLWQJQgHSFqXx4?=
 =?us-ascii?Q?y4OzeLtCujqCDpeW1Am2x/veb9b86EMfjvinLngFZbcWsq+SSCItg55DEyg3?=
 =?us-ascii?Q?Xh3cT4JJZVI/lk7ARSZgKwZGjG/n4m5SxL9tIUnzaA/gnoplvhf40P6h8MFt?=
 =?us-ascii?Q?94upu7QHYN2ZJUPnXR1p4ryFxMGXNuxcHfaTGPTesBpUCikJx3AewQcNPNrp?=
 =?us-ascii?Q?Fh5clZUvBqekTP3ojptS2vrpQLsExh1ulh+/ht5uDeTBtxjdC/iSqBL+ge3M?=
 =?us-ascii?Q?f0HleeOFgpbAG/VQMd8a1d6T+4ZKzp2503EIkX3x6U/+IWIJr7EdE01n7Nwn?=
 =?us-ascii?Q?sDghgaEfllj23TGvjFjzGEfQrTYbgrTNs9tzYHSYUtEb6wWIEKXZ5a8vLP++?=
 =?us-ascii?Q?HnoQIMh7sBIe6rLAHBf4v26KAX6JRXAlKT3sgZmuIGmCOn5zS4S5twDxk0Nq?=
 =?us-ascii?Q?w0tQTQOaGZXX6kYS/1ZtFiW2gySbJtbLp3Y4Blh6B4pM6TGe2UaHMTn4wUo6?=
 =?us-ascii?Q?cCi6vLldWLsO9uFNgm0CrBYraDJlAGhtsgtE4jm/KsHJqKb/Rlqnei26oJWF?=
 =?us-ascii?Q?1aXrZufgo40PV9pHvhPHzl5N07eiFFXmx60hwZei+f7IX9L2hZ6dcMzhrDD0?=
 =?us-ascii?Q?Ot640gxxcBA910jXHs+N91PH5UUay+uLY3vsVY/4pLQ4geKWVEQb66BaQfVb?=
 =?us-ascii?Q?62uvUx9as2l6c8p3YmNrv/Ic?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afea18e2-526c-419a-1aba-08d961083770
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:16.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: touCsIhMSYOZ9V9IpV0c1ySDn6hj/aVKlY1xRyJA/MGTDrGB2hK5xoX99TqjpEQHsEipJJ/sXz16rCRLTPHYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-GUID: 6B_eUD11eZZvXd_QVFBrQDecUXYN6USp
X-Proofpoint-ORIG-GUID: 6B_eUD11eZZvXd_QVFBrQDecUXYN6USp
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
index 4df7b0a437a8..5302ab4aa260 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3172,6 +3172,10 @@ int vmemmap_remap_free(unsigned long start, unsigned long end,
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

