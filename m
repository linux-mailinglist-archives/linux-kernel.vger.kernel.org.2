Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DF41F3ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355503AbhJARzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:55:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51692 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhJARzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:55:39 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191GxaHM011106;
        Fri, 1 Oct 2021 17:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=oN/4ATE+WL0d9Mqp+VtfP/b0NQsDUEDHkS39qUTI6lE=;
 b=AnsYkF1PetuIMf7XXmjOnbqtt1mAjXvRqrrKh4Y/SmkVUM4/BWHbh50ka95a6/clKFP6
 1luj50pDOy9SkqYB8+mAaLyoqPrLGNyL8nRQqIt4UwSGzpPYkbuD0QsDad6TL6GijYs3
 EOASldxn9piGhdkOMYhTzRoXJXAz9tp/X+I93avMQrXguJgUk1bqgRY7p+d4P5y6EX9f
 wcezeshaEULoSbrsyJMUjrRvbNFOHeyp7vJYyo0NIL8c1L2FeAFjsaMe5MYQ5wJkGE7m
 qsASnG36VHqna5txkkZzGF+UM8AVe+ykSDBPJcuFijTf0x6nqNx1+mV6rq9DQtDMQEMj wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3chgyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191Hjwqb194733;
        Fri, 1 Oct 2021 17:52:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by aserp3020.oracle.com with ESMTP id 3bceu8y918-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOOzY67mtRxYKm4o3FUmE1fK1K7sAo1o2D7/uilDOUA914MSeKmNP3DHnILuPPb7RYwifQtIJ065SGvAbQnYZHWHTPn83cLUsucF884aSXLjrVTHxeoWAQGjWoKg699Kok9dvQF2g01V/IE0oRROVFI+worUDcWAS4uw5GIZeNohD/KhJrihrH01omZqgVG2ZnJbYEuFTBeOT6p2oit/k+1XTulqJ5YTyh3qBmYtwuFw7LmbqNLKwDvvrRayLlXVapE/9cOXrS6oENRi9taHA0cgTpafyEUHa9cZovmZ64zFUb+//w9HwBXqNMNrXzuWANct4TUdm2RoWrf4wA83Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN/4ATE+WL0d9Mqp+VtfP/b0NQsDUEDHkS39qUTI6lE=;
 b=Pdzsrru+xw6sCqBP0m1o/VKwCi7lyTkBKRTVstFWRrE1qHu7JCjihYX8a+uKBxJXvlSMRYwSLLFFBNQEi5tRIaYmxfXAXTCnIv5hc3VAuEBwrSTtgCfo9vZTAnop/BcARlSb4IwNkAmfYG2OxXDTI9190lrFVOzq3FSVduXOAx+oZFpIGDzYU3r8q8bi8LYV7e8iREob44XY9lZYnT6/i7b7i8dc4aiOVCj9zAQxaX5xV9BCbipzwzCcochNNc1OzZ1wEDuijhlcEvxPv9yqZ0ESENKEV8B5GcR3Y2m2+RxLs+gHQI59CWqkJOTICoHiziHEpGNHB4a67hCWv2uFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN/4ATE+WL0d9Mqp+VtfP/b0NQsDUEDHkS39qUTI6lE=;
 b=GKYxu+o8g8MvMSJ5+rWv/RtsypEllqsEuANhGFr29l2r6uUyepZAkb6MyqFMv0Gg+PHnWhIUb8UDOpaDwxBQdbnznTW4/1AC4GT7ItqUslMFGId6Rj7ZFHXtBGehekeiPKc0db4JhD8rVgz/4VWVOaqv7xH+K7b9WaFeZvHF/Bw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB4924.namprd10.prod.outlook.com (2603:10b6:610:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:52:32 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 17:52:32 +0000
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
Subject: [PATCH v3 1/5] hugetlb: add demote hugetlb page sysfs interfaces
Date:   Fri,  1 Oct 2021 10:52:06 -0700
Message-Id: <20211001175210.45968-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001175210.45968-1-mike.kravetz@oracle.com>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0060.namprd22.prod.outlook.com
 (2603:10b6:300:12a::22) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:52:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56b26c8c-616a-4363-9dcf-08d985043ea7
X-MS-TrafficTypeDiagnostic: CH0PR10MB4924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4924F1E3C35027476AF633C2E2AB9@CH0PR10MB4924.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFfR3BSIpoojvfpnx56EZazHpYHdgWfkr1AimCSPoj3tYzOQaOOrvRfvyC/p87CPlj63CgjF4OitxZEYK6nKsuhSx5coLLg31v7QSZsefM9tMZXt3uAXVJ4CP0IembM8/OmHItTEE2ZW79eMgmxfA3GWlOlldTTZB1GxK6Z7Z5ranDSwvXVRyzdeHpzqGv/rDGezzTlWRwucT4EeQ+hX+9R5UX2CKp4ViW9bESbDLdKiypdGk/LFxQQ3pFLwfOERKeO/Gb43EtFf2WceUyXMmd+rhbAlVQd/MAH+CorxIeab14zF5MiK5Wb/N7VxdlR6qL2MtZ6dwpn97cIm4bqRP/b7lzxmfxDGZplu3FIPv0Ex0R5L77p6Vl6Vat6UiVftWKAc0t6RzYQMvQyIc/V3rP665m3Ri4hRP5X12DVWCyUGF5NJ03vteRQ2O3ED67w7ku28XWQd6DVlosnCNPGw6XogF85Hp4MqvlWEnpo+gGqtJ/FhDo3h8G6U3rCnx4WOE6OC5xpVTbNrTGosDVpOLh+3MTzXVrQ2nKGFfIMautx9WdwCIrEvdv4Q+dPVylAlXtv/ZFuDYC3KHWlaQ+pBq2UlTNFUqsDShrYb+GWkn67fvnOyua6beZo+zrpmV+lulf3EqyuSWhGQN4E8YLJ/H7sWEUYNKRoa8uBpU0RbamdpjQgHOFDy+QhVvjepmQBd7prNdatJO9pRR1KErZGJEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8676002)(8936002)(52116002)(508600001)(5660300002)(6666004)(316002)(66476007)(7696005)(54906003)(83380400001)(107886003)(44832011)(36756003)(4326008)(66556008)(7416002)(2616005)(956004)(2906002)(38100700002)(1076003)(38350700002)(26005)(186003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DiOn311C2qOdSBb3gzSKuKX9DKjBMZo+9Fen0ubFgcwByp/oS9a9WYNrumdr?=
 =?us-ascii?Q?Eam2DGtJsAHkJqtgsywQfSTlXV3uzMoZDL0iTZfsMrQDFVlSA17wl+SAR2Iv?=
 =?us-ascii?Q?+TW23/McX0YJ5JMfu2E1SrEQ/j9FBf62c809+B8Wa1P7+aGf42Meamj3nf4A?=
 =?us-ascii?Q?2c2ytmdjGQJRS1h/dQmGeuKYjTnXcp3xW2kx2TOeVjcVQao1qUQv4GZlfWgR?=
 =?us-ascii?Q?LUQN1N3FkdAhyxL0E400Je2dKQT8uZhqtvBDHxUo2C8PXX0hmEn4VHlf3b/1?=
 =?us-ascii?Q?tAJGGdV7cT8bjCIhN42I8FNXwQ1RXscPd+Ka/krZWnWW7dhPqX/gB6wS8Z4Z?=
 =?us-ascii?Q?m0AImI6hspW5SHtyAuLa5Xt1Uucz1WREb5kF2XqQVyf5ypZAwkdw9u/RctUA?=
 =?us-ascii?Q?uioELb6eJScL2/4fTSNYqmDn2qkNVUHWUWXcv9xebrhBb8HxreOkI3o7mTkN?=
 =?us-ascii?Q?Vck/FC9QHTjOZUhVc3FRgGpv4/+Twmi+DhZazkQZoYLRLBSG6cjQG01hungP?=
 =?us-ascii?Q?fZtdh9JXPCE5LVm0jt8lgj+q9TU6HC8bNH3FNEwav4mnCa9kxAd1LMtQjSZG?=
 =?us-ascii?Q?ZIqRcsysUJ0KX82nUyZZu92MrO+RiivvQBMiLM5tguDtjc8xxMC53zcprwxr?=
 =?us-ascii?Q?/Bo0m7oKxZ5KlGUDu/vdHuVniSIGimMmdoNpSixLIGVJcwF7v06+16lAvHd6?=
 =?us-ascii?Q?Gc+X/UI5AhAhG0iMJtUWS5JM9ynugmWRVpuhtFPaYzW2EERt71y2efm8yyaB?=
 =?us-ascii?Q?x37qpzKAZxKuDgEjFznUy0vTNYjxjTpzOTib9B9P6LzU+A1PXtkO+4n+WnID?=
 =?us-ascii?Q?xFjhLsj08I/C/gM5g1mTiV5KxKQi92QL3PpkNV4ytrEIE4ChVTxkRn8rEYQb?=
 =?us-ascii?Q?FNbPiQNeMIyUE7Z/QY/wvVHMe0Z6xJbYejFMy0ThEqYoxQD+I+0nDNDftJ02?=
 =?us-ascii?Q?9ss5qzViEy/ivKUz6VxRkHvCXAeIdNgleBiMxS2h6aygrSuwYmGl++NF6DLu?=
 =?us-ascii?Q?J0yftqt4GZchwWCzxEyB/j7KnsXnOaS9kzV/j+rZezYKLf3j4YITpZaeBoDZ?=
 =?us-ascii?Q?zhWiSRyvbEbPu7nJckz8XE8eA/782PCIgZukUQbcoj/yngc1nGN2zsADU7tF?=
 =?us-ascii?Q?HUSTVoHLprrK3oDKKN8FYer2LVxRPMHdi0v8yWqvZGO3zVtDgDn8a9o7q3EH?=
 =?us-ascii?Q?F7wsPknu9oQ/dE4AvhvADtF3dBdbFqpzFTNPVfmPIjZ1AGb8Wx885HTQohW7?=
 =?us-ascii?Q?QSNHU3CKehKNPptqOH/uwgJOeTdfcwBQ5cApKLgzetM2SC4GWh70kzjEacrg?=
 =?us-ascii?Q?S+v39ygCJoYELa7JDWlDaO0t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b26c8c-616a-4363-9dcf-08d985043ea7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:52:32.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ORK0X/SGKq3Ss6dCu2Lso6gT7G1mCCoOWGHCqLwV5XlK995Q964+8UGM3V7TVffmffVPNbK08vz9MutIroLAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4924
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010127
X-Proofpoint-GUID: XU8OG_qETKqFpFCF6uMpn_yc5rxaXP3h
X-Proofpoint-ORIG-GUID: XU8OG_qETKqFpFCF6uMpn_yc5rxaXP3h
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
index 8abaeb144e44..0e123a347e1e 100644
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
+        these smaller sizes.  Only huge page sizes less then the current huge
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
index 95dc7b83381f..f4dad1ab12d8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2986,7 +2986,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h;
+	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
 		if (minimum_order > huge_page_order(h))
@@ -2995,6 +2995,23 @@ static void __init hugetlb_init_hstates(void)
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
+
+		/*
+		 * Set demote order for each hstate.  Note that
+		 * h->demote_order is initially 0.
+		 * - We can not demote gigantic pages if runtime freeing
+		 *   is not supported.
+		 */
+		if (!hstate_is_gigantic(h) ||
+		    gigantic_page_runtime_supported()) {
+			for_each_hstate(h2) {
+				if (h2 == h)
+					continue;
+				if (h2->order < h->order &&
+				    h2->order > h->demote_order)
+					h->demote_order = h2->order;
+			}
+		}
 	}
 	VM_BUG_ON(minimum_order == UINT_MAX);
 }
@@ -3235,9 +3252,29 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
+	if (!h->demote_order)
+		return rc;
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
@@ -3433,6 +3470,106 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
+static ssize_t demote_store(struct kobject *kobj,
+	       struct kobj_attribute *attr, const char *buf, size_t len)
+{
+	unsigned long nr_demote;
+	unsigned long nr_available;
+	nodemask_t nodes_allowed, *n_mask;
+	struct hstate *h;
+	int err;
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
+	spin_lock_irq(&hugetlb_lock);
+	if (nid != NUMA_NO_NODE) {
+		init_nodemask_of_node(&nodes_allowed, nid);
+		n_mask = &nodes_allowed;
+	} else {
+		n_mask = &node_states[N_MEMORY];
+	}
+
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
+		if (!demote_pool_huge_page(h, n_mask))
+			break;
+
+		nr_demote--;
+	}
+
+	spin_unlock_irq(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
+
+	return len;
+}
+HSTATE_ATTR_WO(demote);
+
+static ssize_t demote_size_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct hstate *h;
+	unsigned long demote_size;
+	int nid;
+
+	h = kobj_to_hstate(kobj, &nid);
+	demote_size = h->demote_order;
+
+	return sysfs_emit(buf, "%lukB\n",
+			(unsigned long)(PAGE_SIZE << h->demote_order) / SZ_1K);
+}
+
+static ssize_t demote_size_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct hstate *h, *t_hstate;
+	unsigned long demote_size;
+	unsigned int demote_order;
+	int nid;
+
+	demote_size = (unsigned long)memparse(buf, NULL);
+
+	t_hstate = size_to_hstate(demote_size);
+	if (!t_hstate)
+		return -EINVAL;
+	demote_order = t_hstate->order;
+
+	/* demote order must be smaller hstate order */
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

