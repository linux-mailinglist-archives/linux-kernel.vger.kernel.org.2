Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E6425A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbhJGSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:21:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35624 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243584AbhJGSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:21:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197I5bc8025160;
        Thu, 7 Oct 2021 18:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ztRI9qgc0t3v+U02wSqBcenJLvI0kf9QUfmuM/9rRZg=;
 b=cz9TvFrZKFxVCKNXnlxPtP6sEXubOpyWpBC3WJBW6R5jfGT6/kr2Pn5559gsu5oMeCjK
 yU+blKTr9+DYeF0WqciU+YrfQHkueQYJdIywRvwe9R5pdgDCkWAybnGyzqVbSUzRthwp
 z+LJBln4Jjj33H4Qr0y5eZ3cN3e2vnRfHN8lspKd8dyKn8dufrr+wrkD3TXB9oHGuKTs
 T/vK/d6O5+m8qJcU7wMXUP11/KoOfCEKtQdmamuUuOr1V9mTTdWEOuq3DDW/JxqxrQnR
 aGVmLJvuWWC9vb+djf1/dBH8T0y9iio2jGUUxrpTI9AvWXAauqgaZz9iYTpR+BS71loX dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw2vfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197IA8BP047007;
        Thu, 7 Oct 2021 18:19:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3bev7ww3ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On3VyucICEzczI4ZX+Tr85bWNvqFceqkdwHYqdoNfuM8g+HLJgIUNq/4SCF1PG/FuA0yUvEAsctz8DrGm+/bVaQkH6QGQg7hXM/6IriCyfaORnSg0iw0i5Dm+zXAjq33BCzASXSGhLmO9/k2W0oTXu+9n3CYkZ3nRaleUpJ58IrK94RShHSodeUaLhKsCiekhDafP84p9IfiQv/d3HPIeqfEU3oEWXYYNHRlsgcXWwCpmTAt0nFWkNjWxO9jmzh4hLNkTwGqlqodG+lbHRCHDTZxsRFs/xP3jjjO+IBF/FJXJb4F6O3Hu0UI/h9EVo5ECaTKmsYtkYWEp81dh/bMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztRI9qgc0t3v+U02wSqBcenJLvI0kf9QUfmuM/9rRZg=;
 b=dnbmizEcDEX9cij/r3IDe7y9vq8/+59/Ll9CvggU2ErVOdLrbu2DnT+2tuM4cEDDivuzBHK+BRrWEWMRcwmNmNvaccdirg08AjHj2xOdE7/fFKyoWibkunvgDpga0NH/jHZiX6lzT6Fbo8nX8jwyZVggZ0/whX+Oh1EjaKJ37tddgGI0p7xmVCvD186s5qCbbC1yExgzNi2ao06gE7UnqtINLSCpo7a3FEirrhbgRF+qTjej7VCJ+iv90Be1V4NGRwRuTwyGOX15tZLmrXckIy6Q8qF25UHxvuKHtlPg4gKD8AX079bamTrd5KgZrC46xDneNYcYZ3ycSI97hOnIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztRI9qgc0t3v+U02wSqBcenJLvI0kf9QUfmuM/9rRZg=;
 b=oqADCcqSsTP7SJPFRJs0TOq8KYP42fOrrgLcZKEiBg3TD4npy7kvqV1caHZIl+70C51MEZ9wfJj6jeIzF4VBBzLeoWmjWrbYNXnFgb10QHOSUR9kOV8OwBo+W/ZjvSkNbVcO4W+O1GgZFjwH1a8pdwTjx8JCMU2Oe5j3CzKut1A=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 18:19:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 18:19:36 +0000
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
Subject: [PATCH v4 1/5] hugetlb: add demote hugetlb page sysfs interfaces
Date:   Thu,  7 Oct 2021 11:19:14 -0700
Message-Id: <20211007181918.136982-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211007181918.136982-1-mike.kravetz@oracle.com>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 18:19:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9e528f3-5d95-40cb-191a-08d989bf04bb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2552339DB1642BECA0EB805FE2B19@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JY9zgc9p5ZQ4MGU+H7SWhlPpI0FPHRgIENLz1dS7k3ufW6kMXfdfm09JNVMn8i1suffa/6qZT2B3DY2ZHHHy7mDdYmK54PPmP4PzwgRGtlrEF/pkYqjKyOLVtZG4bWxcP0Y6Ddbo2bjkzKFNLrxECdJwXIfj1jtA2Am1J2FeGRSey3x59vJCLOdaGrb7s6lmp2eJ2WeuYcIjZUMYRaUsvW4Ys1TVVwAWHU5vs9dKiinTJSdaYSVTPs1CAyS8lWv5Ka6ias4Ycde8hDXf9rxhdv51MFjOG9Lmc6sv8buOD2haPZV3HfRNZmJ2Zphz03WWhtcIyv/tbhCTv1uM3Ib/E8mNHYaTzb+AlTn9yKQ44nX5W4daiguJlOxxzSiqQOqyldMvCG7TlmdKhxYpfkkkie+yYjHWp8t4mgUsBU5pekPvhm3MPjRYQ7tG0XyhxUvhSv5j+nGTfJvC3X40kaxMYJ6cQS0uhEyacPhjtZNT3/WX2ipGw3M9bLR+ppJFP+7Ie8+xGuaAmjBuU0z+8u5lzTesXSjuLNkzyq+vtitJvXzSQL+9nqg44ZNG6jwb/wUiOFGR4SNsxjmup4J0+Ql0AM4jfWiEg06ng7TDRGOWuw/udazRwFHNZJZOn7J8hDTHXW29Ku4mlipFg7rNcX8HNvdOXzUmOJ671HGHp+cm2bdTBRf3bVkjDIaCoajog7saYjdPT6QoMSE4By19wC7iUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38350700002)(316002)(7416002)(44832011)(5660300002)(6486002)(107886003)(2906002)(1076003)(186003)(508600001)(54906003)(38100700002)(6666004)(66476007)(36756003)(66946007)(4326008)(66556008)(52116002)(7696005)(956004)(2616005)(26005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bYSrn1gd/h+jzt4EN4md/QoAF2ZYI6WwcTsb+ZWSPe3UqYQaQpShaR3hfLqh?=
 =?us-ascii?Q?UZZrw1FqL91mjwauCH1vIbLKBsbo2KqTzBc1j6/qKiHb4B/i5oZTEBpTDxTU?=
 =?us-ascii?Q?9+KBFnOGLheA/CXezAMBgkXa0poHRJjnq1IzRT0ruq9Sit69jc60LGASs2qQ?=
 =?us-ascii?Q?z0t9UsRNiuzYcuZZQ/LeKSJFlB5mEVOU+9iVR9NzvbAxTv876CHNpF1fw/08?=
 =?us-ascii?Q?oDZP3AE/lBwZIesE+6EbLHT1dS9bN+H3b8+9uXTOFwfcGbMx8zqNhSZ44lT+?=
 =?us-ascii?Q?H4u7VFQlUWUYiRXSup2edZ9Kvrm/6dNO2wRGpB6Zpi6J1kVZX0qYjinC8GWy?=
 =?us-ascii?Q?DEEkRlC6OdSLBJE06rXpuygz5unl6hs55lPHZWkqilikOmZyuSjR14YkgFf3?=
 =?us-ascii?Q?lG67FU2H0kXk0K3hXoZsBqCDd8lY/F7LtdYh2iNz/r+vaBPYi0y84tGsNDFg?=
 =?us-ascii?Q?AWlPmRaGLJe2oOrv62Hb9HBRoh16mFv3EKQc0rToVCcISWPma3QBh4WRECrF?=
 =?us-ascii?Q?onduqRIw5jxNIIQ3NSpHWiw4okzZOrkXjMjlZIe5Nhnp3VcaVwOMPqeeN0ns?=
 =?us-ascii?Q?ScMANOGx6Lix3Ut7YaTqJ7ckqf9vmXdJ63otzSYTRF6lVcegyFW6cPRrWjZQ?=
 =?us-ascii?Q?smtsbtZHKLi1WcQbaheF31YsPadFnQBIOkbbwjYpK45hglAXeZuhEiWGpody?=
 =?us-ascii?Q?57fC7I4XdCacYTflKGs4NRDsP+dXq/QGjJPtvUj00szHARPE3XLA0R7/aiLO?=
 =?us-ascii?Q?bHvpvrhm/ehcMcIelYRNwm37zlFgv4G0OamAlDVf86sKELBQEoq5h9pEkka5?=
 =?us-ascii?Q?9nWKazAGNKpvLdFfw4D3YJeFMTu1xq+ec/RsWKXIvRy9VnjHOk4xMh7zk3lo?=
 =?us-ascii?Q?/pD2bEK6UBYdWPPXAvT3XeNHgXuTElKLCJw1Sd/CbTG7t3hMWY1gni+I5cCu?=
 =?us-ascii?Q?cCQtJ0jphGPEFZxyFJ8WYx97ZvSZo49Cor85uaTbtOe8gbDWPMbog2Jg2BCS?=
 =?us-ascii?Q?BLP2JxgdCpvSpJNqG9/yiJ/3KO0+zyVZD/si6ozMb5cDVjVOK79rWWRLvXVV?=
 =?us-ascii?Q?dAyyb/ACbwhCotPqGQe592Ek7Xs0buA1buRg7mzX+2HnIUQxB10lRRDnfMt2?=
 =?us-ascii?Q?MmNdiiBv1kIRkWB467+zOEC/vAAVYoaTOsBrmFo0DFnRsM0lr+0Hex+ZB7ii?=
 =?us-ascii?Q?2woBw1/iQdx5BjaXxjhi6sBjWIpnJjZmyJJzP065YSHQ9bdpewPepRy4mDIS?=
 =?us-ascii?Q?cem3Wk07fNn3iDxPjok59c0aOikCx/nKvxTE/Ht2R3H7eKIOaI/sAoDssdGI?=
 =?us-ascii?Q?sFtMk7fHQQ/iwXABPh/j9zKx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e528f3-5d95-40cb-191a-08d989bf04bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 18:19:36.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPzxH/JerXjmRxFkQkeDtfnoQfYQkOOOd+G23IZzvrr5rRVEZ/HsYC97B/Vwv5cPne9AqMnkiTTG4pXa+J/JVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070118
X-Proofpoint-ORIG-GUID: SNwzrWpT0vRQtK854lBRoxbbgw5hLTEx
X-Proofpoint-GUID: SNwzrWpT0vRQtK854lBRoxbbgw5hLTEx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new sysfs files are added to demote hugtlb pages.  These files are
both per-hugetlb page size and per node.  Files are:
  demote_size - The size in Kb that pages are demoted to. (read-write)
  demote - The number of huge pages to demote. (write-only)

By default, demote_size is the next smallest huge page size.  Valid huge
page sizes less than huge page size may be written to this file.  When
huge pages are demoted, they are demoted to this size.

Writing a value to demote will result in an attempt to demote that
number of hugetlb pages to an appropriate number of demote_size pages.

NOTE: Demote interfaces are only provided for huge page sizes if there
is a smaller target demote huge page size.  For example, on x86 1GB huge
pages will have demote interfaces.  2MB huge pages will not have demote
interfaces.

This patch does not provide full demote functionality.  It only provides
the sysfs interfaces.

It also provides documentation for the new interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst |  30 +++-
 include/linux/hugetlb.h                      |   1 +
 mm/hugetlb.c                                 | 155 ++++++++++++++++++-
 3 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 8abaeb144e44..bb90de3885d1 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -234,8 +234,12 @@ will exist, of the form::
 
 	hugepages-${size}kB
 
-Inside each of these directories, the same set of files will exist::
+Inside each of these directories, the set of files contained in ``/proc``
+will exist.  In addition, two additional interfaces for demoting huge
+pages may exist::
 
+        demote
+        demote_size
 	nr_hugepages
 	nr_hugepages_mempolicy
 	nr_overcommit_hugepages
@@ -243,7 +247,29 @@ Inside each of these directories, the same set of files will exist::
 	resv_hugepages
 	surplus_hugepages
 
-which function as described above for the default huge page-sized case.
+The demote interfaces provide the ability to split a huge page into
+smaller huge pages.  For example, the x86 architecture supports both
+1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
+2MB huge pages.  Demote interfaces are not available for the smallest
+huge page size.  The demote interfaces are:
+
+demote_size
+        is the size of demoted pages.  When a page is demoted a corresponding
+        number of huge pages of demote_size will be created.  By default,
+        demote_size is set to the next smaller huge page size.  If there are
+        multiple smaller huge page sizes, demote_size can be set to any of
+        these smaller sizes.  Only huge page sizes less than the current huge
+        pages size are allowed.
+
+demote
+        is used to demote a number of huge pages.  A user with root privileges
+        can write to this file.  It may not be possible to demote the
+        requested number of huge pages.  To determine how many pages were
+        actually demoted, compare the value of nr_hugepages before and after
+        writing to the demote interface.  demote is a write only interface.
+
+The interfaces which are the same as in ``/proc`` (all except demote and
+demote_size) function as described above for the default huge page-sized case.
 
 .. _mem_policy_and_hp_alloc:
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1faebe1cd0ed..f2c3979efd69 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -596,6 +596,7 @@ struct hstate {
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
+	unsigned int demote_order;
 	unsigned long mask;
 	unsigned long max_huge_pages;
 	unsigned long nr_huge_pages;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95dc7b83381f..44d3c9477635 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2986,7 +2986,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h;
+	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
 		if (minimum_order > huge_page_order(h))
@@ -2995,6 +2995,22 @@ static void __init hugetlb_init_hstates(void)
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
+
+		/*
+		 * Set demote order for each hstate.  Note that
+		 * h->demote_order is initially 0.
+		 * - We can not demote gigantic pages if runtime freeing
+		 *   is not supported, so skip this.
+		 */
+		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+			continue;
+		for_each_hstate(h2) {
+			if (h2 == h)
+				continue;
+			if (h2->order < h->order &&
+			    h2->order > h->demote_order)
+				h->demote_order = h2->order;
+		}
 	}
 	VM_BUG_ON(minimum_order == UINT_MAX);
 }
@@ -3235,9 +3251,31 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+	__must_hold(&hugetlb_lock)
+{
+	int rc = 0;
+
+	lockdep_assert_held(&hugetlb_lock);
+
+	/* We should never get here if no demote order */
+	if (!h->demote_order) {
+		pr_warn("HugeTLB: NULL demote order passed to demote_pool_huge_page.\n");
+		return -EINVAL;		/* internal error */
+	}
+
+	/*
+	 * TODO - demote fucntionality will be added in subsequent patch
+	 */
+	return rc;
+}
+
 #define HSTATE_ATTR_RO(_name) \
 	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
+#define HSTATE_ATTR_WO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_WO(_name)
+
 #define HSTATE_ATTR(_name) \
 	static struct kobj_attribute _name##_attr = \
 		__ATTR(_name, 0644, _name##_show, _name##_store)
@@ -3433,6 +3471,105 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
+static ssize_t demote_store(struct kobject *kobj,
+	       struct kobj_attribute *attr, const char *buf, size_t len)
+{
+	unsigned long nr_demote;
+	unsigned long nr_available;
+	nodemask_t nodes_allowed, *n_mask;
+	struct hstate *h;
+	int err = 0;
+	int nid;
+
+	err = kstrtoul(buf, 10, &nr_demote);
+	if (err)
+		return err;
+	h = kobj_to_hstate(kobj, &nid);
+
+	/* Synchronize with other sysfs operations modifying huge pages */
+	mutex_lock(&h->resize_lock);
+
+	if (nid != NUMA_NO_NODE) {
+		init_nodemask_of_node(&nodes_allowed, nid);
+		n_mask = &nodes_allowed;
+	} else {
+		n_mask = &node_states[N_MEMORY];
+	}
+
+	spin_lock_irq(&hugetlb_lock);
+	while (nr_demote) {
+		/*
+		 * Check for available pages to demote each time thorough the
+		 * loop as demote_pool_huge_page will drop hugetlb_lock.
+		 *
+		 * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
+		 * but will when full demote functionality is added in a later
+		 * patch.
+		 */
+		if (nid != NUMA_NO_NODE)
+			nr_available = h->free_huge_pages_node[nid];
+		else
+			nr_available = h->free_huge_pages;
+		nr_available -= h->resv_huge_pages;
+		if (!nr_available)
+			break;
+
+		err = demote_pool_huge_page(h, n_mask);
+		if (err)
+			break;
+
+		nr_demote--;
+	}
+
+	spin_unlock_irq(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
+
+	if (err)
+		return err;
+	return len;
+}
+HSTATE_ATTR_WO(demote);
+
+static ssize_t demote_size_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	int nid;
+	struct hstate *h = kobj_to_hstate(kobj, &nid);
+	unsigned long demote_size = (PAGE_SIZE << h->demote_order) / SZ_1K;
+
+	return sysfs_emit(buf, "%lukB\n", demote_size);
+}
+
+static ssize_t demote_size_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct hstate *h, *demote_hstate;
+	unsigned long demote_size;
+	unsigned int demote_order;
+	int nid;
+
+	demote_size = (unsigned long)memparse(buf, NULL);
+
+	demote_hstate = size_to_hstate(demote_size);
+	if (!demote_hstate)
+		return -EINVAL;
+	demote_order = demote_hstate->order;
+
+	/* demote order must be smaller than hstate order */
+	h = kobj_to_hstate(kobj, &nid);
+	if (demote_order >= h->order)
+		return -EINVAL;
+
+	/* resize_lock synchronizes access to demote size and writes */
+	mutex_lock(&h->resize_lock);
+	h->demote_order = demote_order;
+	mutex_unlock(&h->resize_lock);
+
+	return count;
+}
+HSTATE_ATTR(demote_size);
+
 static struct attribute *hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&nr_overcommit_hugepages_attr.attr,
@@ -3449,6 +3586,16 @@ static const struct attribute_group hstate_attr_group = {
 	.attrs = hstate_attrs,
 };
 
+static struct attribute *hstate_demote_attrs[] = {
+	&demote_size_attr.attr,
+	&demote_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group hstate_demote_attr_group = {
+	.attrs = hstate_demote_attrs,
+};
+
 static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 				    struct kobject **hstate_kobjs,
 				    const struct attribute_group *hstate_attr_group)
@@ -3466,6 +3613,12 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 		hstate_kobjs[hi] = NULL;
 	}
 
+	if (h->demote_order) {
+		if (sysfs_create_group(hstate_kobjs[hi],
+					&hstate_demote_attr_group))
+			pr_warn("HugeTLB unable to create demote interfaces for %s\n", h->name);
+	}
+
 	return retval;
 }
 
-- 
2.31.1

