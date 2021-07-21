Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9333E3D1A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGUWZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42648 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhGUWZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvPNG003370;
        Wed, 21 Jul 2021 23:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JvqKnCWQpghkClE9kLMTl3jAzhYt2NXfJ3KJieza1Sk=;
 b=qWynysMrLY2cpevrKmwk2vrQFNEFKGtrSbNdwhi5XeYAfGMG3qjw4k3A6hQbSzgprsbg
 /ruorWdvTtJxdX012E/d/L+clYrgehYn0xXb+mp3VrhzBrkxicotLNWmd3ePuF7xZpbS
 7wHeZmOQ1BH6ALhs8M7aEM6HznR2tHXtwnzvc3PK4/dWzBXy4gFhaTWJ9b1Wueee9HQy
 EWD1kW5ryR4nqT1ZNTYVrp8WoL7uOEb38RsVMD/UCtm4h6kmY3SC5vA8K060pj/79Sz1
 yrW76GA43FugLd1wSsBMSIPWwRkvX/qqGZk7mtho6WSruSWoJZFPZhm4A452AWQN3dn+ zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=JvqKnCWQpghkClE9kLMTl3jAzhYt2NXfJ3KJieza1Sk=;
 b=qOFKH6Dja0B86MXTz3RJPLmIluRHnLm5wK24wg6gVzs6TqfcA+Ag45b1yMFEWVxrWmhB
 pfYC53eI6hoDNgDoCCwP8LypLyYoDHJX7laHHE9HIKHHhrYzD8zDPQAaGxmkEf5U5ndX
 pPLOgKEirsBajvVxme0EJ44Kpa4oCGEOWWwJJLgxe/Blww+Ufdtmo+/2P8t7euLSvyKX
 MFm1SeATYujEjLUhLY0LkeNe4d/IDtVdtLSwckBpTpeAsPxQ59kmPlmNIrL0Gux+EUym
 j2lhulUuve/URebS5buNROv7gVg8EFds/nHZqv0dff2vr2tdTnAIllqQJDXJ3b87bVsZ XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39wyq0uqqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN59eQ058644;
        Wed, 21 Jul 2021 23:05:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3020.oracle.com with ESMTP id 39uq1a3wgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbmXM0GCvfhlDm1zsMxXsePWR7lL5lTjK7yX7m3RzzmsGWvOiOPonwKRffgLR2rLYPyzf8fs0PmAZx/1Eczt1EE33DxPm6i+zqrlDPEndBs6R+MSvvPQTRcUxJkKeMeDOJ/th67um0Cs56eqxTczFXst3R7arYYfYdvN36l6rTq/vmMrLHbp24Cn+MtQV5CGGoUhJ64ngZD/neC4Kks7GmK7FHBc3JtfINSJ+Ws9Zaks814fGH1GOXoasv1MgrIC3bNovReZ2h+ECJI47XApbanYczrz+BARknobimFOeP8VBHi/5EYgblpnjAaRnjVk4eQG5/Xyipw69TdyFmNWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvqKnCWQpghkClE9kLMTl3jAzhYt2NXfJ3KJieza1Sk=;
 b=Rls9mM0IDLY5m9IyNXrS92wANgxqnoLZk/+ei3n6IF4AQbWJbGvaw7hHBbZItPmKWmAFKJtcbEcNib+76Nm5Y4Xvk+J5sUYpjpTsPgOS8X6mUim2/ggJGYhF8v0/sFx2BgfYPia5OK2c5roydJNtYyOiMUtCeJChnTyvbC1XLdkDQ6QBnFFxse/rfsGgQTixs7WpJo/Le3mjyow381OB/yIiWrvgKIVmC1fh1FHv3facD0HiQHR5/1h1QwqpAJjRRU53wzhkTz/Nr3qJQ+wBZpeN1v59rIIek/KrSuLbGi9kJjrktYwCyf3RjyG1dp7otIARAt3I2Gvz4pY+2hCN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvqKnCWQpghkClE9kLMTl3jAzhYt2NXfJ3KJieza1Sk=;
 b=jl9y8U0QS9w6HnBbK4FAATki+pxbAxGhspEmQpIF1NGM2YbNOnlEkFmiBBLEnjy+ykKeoUZ/8jkIEkkrU1k9sjf2H1W/j55QLtPpTpVdXKdOx6F6Ty7sQb6oJBnA1VYB49N7HdZju5oJdWYNmFrg+yd4Mcro6H3lXzPLJ3TVgzY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:36 +0000
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
Subject: [PATCH 7/8] hugetlb: prepare destroy and prep routines for vmemmap optimized pages
Date:   Wed, 21 Jul 2021 16:05:10 -0700
Message-Id: <20210721230511.201823-8-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c96bdbdb-4815-488b-ec5f-08d94c9c0c6e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB373522E960F248EFFC4A97C0E2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sU5BlFyuYBRECT8s60d5X5P857ud51bIAgm2W/Y5yt8TMTXpJFSWyYaFl1+aSh67+n988glZFZc6a7b2a/J2LFMtDfEsiMbGLRQ5h0Tc6NB8p7N8UCs7G0TgoNvSZnAvttv4kykZK0ekSw77zpGTdOjaeCi7TCRpStRtPXrkJcCqf9yBhPq5MpFyb2VDVomQTXEZcr9hiQVKQ4Wi6XUvSAu9naMsafHADLVDz5ITxy+Ax7R5nhoKpCOQzdZWlE+N7utnR86rqz2tWu6TGifrxRYwq45EnktV6TEzXaNKnQQR0OoE76nMAaNWnvBgap32I9U4tyDnAwfzWUR8r4cr9Og5vOnkHTssa+HcX/5pQhpJgqbpbQP9+BDOwiTQ8+9WW1DbTNmnBsBrBSak9RrleC2abqHui/EAjbfu1YDjCImwyOoq/TQkUZ9RfHBzNOiXSCLi5QrK6kDG1Z29hghPejnYmPusiAN3WMGOaDJORKyOsA1wltd8UEwFBA9aytYmGr04UZ1lz+vmi3MAvrf7e75cb9G04bkHmW8DZKuXvcOCzaacuBIUti5gCNc4bB1cZLUkhDDLchap70TdDpXvJCaetnCD8+IvUQaZ8QI8xFbZnYCbBMI+s6QJv1lbpo/X1j81SX7mgTk4j0LYoTusbA+bobfKNLsmXrQ+sHJZbutgRPzU8DVxhD14CehNheWsQOXUIexxqyxbklVt+APYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28tmU5xpXiYvCMJgwQK5H14eXlyvRM53eEDBL+YrJRM5JXDB+9cxJBMzBybw?=
 =?us-ascii?Q?VRgk8I832KFW1qzapryEs5F0Z5zF5l2xmPbyM4ZChlC5xUPH3vSJikqMudfv?=
 =?us-ascii?Q?iuXZabah3JQyMXXcJ7ZyQgnFXVqMdXjtYiHL3SFIijvSXfwxuzd4qyl9kgq4?=
 =?us-ascii?Q?kTBAKwVpNZSgfowXA+OJ3Ov8OlyjoPL3WHMDiNcwjp0OUrJmZQP5bTVOY5xr?=
 =?us-ascii?Q?U/PA+HRpVwSmtfN7JSuxIWA+wVl9+3vfnSSR3xfsmVEl6a8tX4mwyYKSQftn?=
 =?us-ascii?Q?qzwJc5nXDOzO8J+hxFJEoUaIqSS2exACvdZDPyoqmJvsi71tLvolgCA87qMT?=
 =?us-ascii?Q?Rj7Ap0nUmzFuUOxXLRHqiZhS/ISZ/VJzK6UfNdhtpjeo+KblWGT517sw5izj?=
 =?us-ascii?Q?VviZPddokZQkt+l0XdQCoiYmsGnsIs6l0N4OcKdPMBymtEhOdsZs3H1dqG3h?=
 =?us-ascii?Q?GWpHY9amBZghmPslb9owKfkL9BlPv4dv9uxUOc25/Vn4vDIy28c3k+NDR91O?=
 =?us-ascii?Q?9prncbohWs8aPx8PWBFmHaEi77Z7zkVhYLyGDCmpHfCMf0sWre1uxseshRJE?=
 =?us-ascii?Q?bwPe7wAfPYy1jOCbyvbGiL0IbXcSj7ne3GFHE6n1zTephT/uvYFFIbMSRxOr?=
 =?us-ascii?Q?KGMLijiXBtSve+QlxXZ4efqf+3xa4eZGScwAyVCGyagg8E8+iOfvPf1bs+/+?=
 =?us-ascii?Q?rNMvIkvCWuNWQG3MngRglotlzfyKjGQ8NBxU4P0/GQRJGKZfamG3/Lr9KVwm?=
 =?us-ascii?Q?GNHhJghqrjokJgf5+DjHa7INJZf9lfEyYPrfEqJtxgn0tfO8zjGMsagMz591?=
 =?us-ascii?Q?3Vkr/h8/i8gaOFk5sprWPHttuj9MAvDxBzf3gMJiB5o/Mc2UeBvXb7NDkubc?=
 =?us-ascii?Q?NkQJSDN31iBVfKoWqIRnGXHib9ZlESPM28ieg3dHhM/Hg0Usu6Vq//LIVTs7?=
 =?us-ascii?Q?44dojVUKy7uSe27a01+uxrQYpC8FTLX/kuJH2OV8VScTn0G3J+B9VFcTiHD1?=
 =?us-ascii?Q?7SuaLzZ/ICvsDHfkKtO7C8dkKb4iKwV/YiKBxDhQK2hXbfFtauncpiIYuvhP?=
 =?us-ascii?Q?w1u/juD14o8xfylRzw4P/Y8uGBP1eA6wsAXBhAnb7xqRiQRElUypyJpvUqiS?=
 =?us-ascii?Q?7J6OMwk71oQ3R8pw9vnZ6FUFSs4+IP75qFsC/OdwXjy5X7IHSUgldgemmfzN?=
 =?us-ascii?Q?Rn4jJdqUAyEWkJEMBnQkMhvcWogAw2Hjyx4rrFA13fSjfE63lGs+QpMM1a6n?=
 =?us-ascii?Q?k+57yu+OHYzwgYFhKJPjSiKVNQiQgAyxhpjk7HqmzOjDyo0C3PAwK20NmS1b?=
 =?us-ascii?Q?Gtf2xjui7rnaPT+3kCHf2B5H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96bdbdb-4815-488b-ec5f-08d94c9c0c6e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:36.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uC3bd4u0O4hLDGSWtROcCiOx0XuO4alBofrtwXWI+CKvOihTtNYG6H2xS1I99UhE6Zz6WX2eyu4nmOI2jxJOuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210138
X-Proofpoint-GUID: YPvNgFB6bkiZhgYIUnFiOWh-9rQVDfoZ
X-Proofpoint-ORIG-GUID: YPvNgFB6bkiZhgYIUnFiOWh-9rQVDfoZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When optimally demoting huge pages with vmemmap optimizations, the
routines which destroy and prep hugetlb pages need to be modified.
Currently, these routines expect all vmemmap pages to be present as
they will write to all page structs for tail pages.  To optimallly
handle demotion of huge pages not all vmemmap pages will be present.
Only those pages required for the demoted pages will be present.
Therefore, the destroy and prep routines must only write to struct pages
for which vmammap pages are present.

Modify destroy_compound_gigantic_page_for_demote and
prep_compound_gigantic_page_for_demote to take vmemmap optimized pages
into account.  Use the hugetlb specific flag HPageVmemmapOptimized to
determine of this special processing is needed.

These modifications will be used in subsequent patches where vmemmap
optimizations for demote are fully enabled.

Also modify the routine free_huge_page_vmemmap to immediately return if
the passed page is already optimized.  With demotion, prep_new_huge_page
can be called for vmemmap optimized pages.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 17 +++++++++++++++--
 mm/hugetlb_vmemmap.c | 12 ++----------
 mm/hugetlb_vmemmap.h | 10 ++++++++++
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9bbfeba3e1ae..4040dd3c6fe3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1255,12 +1255,18 @@ static void __destroy_compound_gigantic_page(struct page *page,
 					unsigned int order, bool demote)
 {
 	int i;
-	int nr_pages = 1 << order;
+	int nr_pages;
 	struct page *p = page + 1;
 
 	atomic_set(compound_mapcount_ptr(page), 0);
 	atomic_set(compound_pincount_ptr(page), 0);
 
+	if (demote && HPageVmemmapOptimized(page)) {
+		clear_compound_head(page);
+		nr_pages = RESERVE_VMEMMAP_SIZE / sizeof(struct page);
+	} else
+		nr_pages = 1 << order;
+
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
@@ -1517,6 +1523,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 			return;
 		}
 #endif
+		prep_compound_page(page, huge_page_order(h));
 		__free_pages(page, huge_page_order(h));
 	}
 }
@@ -1705,9 +1712,14 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 								bool demote)
 {
 	int i, j;
-	int nr_pages = 1 << order;
+	int nr_pages;
 	struct page *p = page + 1;
 
+	if (demote && HPageVmemmapOptimized(page))
+		nr_pages = RESERVE_VMEMMAP_SIZE / sizeof(struct page);
+	else
+		nr_pages = 1 << order;
+
 	/* we rely on prep_new_huge_page to set the destructor */
 	set_compound_order(page, order);
 	__ClearPageReserved(page);
@@ -1749,6 +1761,7 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		} else {
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
+		p->mapping = TAIL_MAPPING;
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c82d60398c16..01c2cc959824 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -172,16 +172,6 @@
 
 #include "hugetlb_vmemmap.h"
 
-/*
- * There are a lot of struct page structures associated with each HugeTLB page.
- * For tail pages, the value of compound_head is the same. So we can reuse first
- * page of tail page structures. We map the virtual addresses of the remaining
- * pages of tail page structures to the first tail page struct, and then free
- * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
- */
-#define RESERVE_VMEMMAP_NR		2U
-#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
-
 bool hugetlb_free_vmemmap_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
@@ -250,6 +240,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	if (!free_vmemmap_pages_per_hpage(h))
 		return;
+	if (HPageVmemmapOptimized(head))	/* possible for demote */
+		return;
 
 	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
 	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 44382504efc3..36274bf0256c 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -10,6 +10,16 @@
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
 
+/*
+ * There are a lot of struct page structures associated with each HugeTLB page.
+ * For tail pages, the value of compound_head is the same. So we can reuse first
+ * page of tail page structures. We map the virtual addresses of the remaining
+ * pages of tail page structures to the first tail page struct, and then free
+ * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
+ */
+#define RESERVE_VMEMMAP_NR		2U
+#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
+
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
-- 
2.31.1

