Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1A3485E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhCYA3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbhCYA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0OnEe093913;
        Thu, 25 Mar 2021 00:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=DmpR3IHpRf0BF79O8TyIEbdtG2PrSinAJXwQxxRNiOA=;
 b=QRgSFcnU7E/nEQw+H5ueF2YQKTytUKW+6FI81EhJ7nY/q62LxtgP9df8s7qnRXCwcvp8
 GxDEzjk9rfX88n8SeJQcnOPFU4kggDOi2bmptJ8vHkIRcx5JwmytBHmY2I3qU+nj5ci4
 4Zr6t/mlRgjZ/M3AK0t8EITvIpjdkFxaYV8Ef/zzBywzMJASn+3bHj8ad2ZLVSmbwt+c
 6CdxpSKhb6Loly5SYTqsa1exFlkPYmb/P2Pv3rKWtC08ztqhrMMmSn/DvE8mcFAyrnIE
 OPiZ+8NYiSBwIwU4m46wLXIYpjOZ7w0pNqNA4MOtz3JADkpPYfR7tMwZUGOEqjX4LKtS iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37d8frcn7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:28:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0PEng162585;
        Thu, 25 Mar 2021 00:28:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 37dtmrgq90-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihfpiSisCL2vSG75DSjtcLY+0L4R1kfNPipxFZKjC1rJ8wRx8L5p1kwbIdfRRATAa/KfMedWm2QmPMLXvbrZDXhZkNs8EwEi1CpVF9Bgt0IVTXIFri7+d7LU204jCfy/Zja5aFKUfRb7JuM+QxuttM+VwlA+oLTzrUOS89NCa6n9lxOkUj4z611ySuZaC/H8oFUzYxD9Q/UlDgN4KNZFtqs6ybDNACBJFgubWNEps6CgcZVzxWoS2XPTB1hkYum6FGJXZDc5b5aXPrzaj+2W4Al30Zgvoq0mEAayOKys/TpTuGibuloSZ0aiLseuF2/jCDOgHmTgAtrSEEjQovBWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmpR3IHpRf0BF79O8TyIEbdtG2PrSinAJXwQxxRNiOA=;
 b=DdyT64prTQ1pyu5+yQHIeNhUvq1HGC05vICeCYorDzqYqjRBK2nBFSDUuIkdhmCZC7p4BV9ddEaA13/Zk8VLYVg+HxxFSY+/OOP5VNUEZXEZrvKNwIvOJ8O28JuinAI25eDsWOsb4uBjFOC1glLy6MI7ZKGg7a4E2CSJZSQrMZ2hRrgLUbh184ytlOsdu4WFe9e5YqjaB0Bs1WwwkjlxLLpbvkCPYTO5sP5axC6d5CZxDv1qZqHYpyw5HJyOHElZFD5B82MdwEtPTzaI0sMovfaUeZXrJ3y+oudo9HD0pHUmSsE407HfMdBsdj8ltWyyFmxrVHcrGe4piEY+8t2B9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmpR3IHpRf0BF79O8TyIEbdtG2PrSinAJXwQxxRNiOA=;
 b=ojiEW73JqEiT/G/GCT3IplaHGYGOc01+EqkIjM0Ps3iAfJhGFsnK1Gx4wXNq5ZYKpT9U5kSV3cKYAiQ0cWQD3vz9wE6x511SGc+KTZHYwVjkfiMkY2MCL79n8rZAp8y0jhI/XOCVwQHGABQPaKLZgAiK8mjRaT0jRplBGtHMlk0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:28:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:28:56 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/8] mm: hugetlb: don't drop hugetlb_lock around cma_release() call
Date:   Wed, 24 Mar 2021 17:28:29 -0700
Message-Id: <20210325002835.216118-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325002835.216118-1-mike.kravetz@oracle.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:300:ad::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb70555-4e50-4bc9-8c78-08d8ef24f995
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB446262FC744CED54D1EE3BA7E2629@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiidFO7zLcG2+s0XtvSDrnKwt4M/XFhdKOLECLwhinAPpN+LY44bpqqK255HwkgEbQNiFYWFH2+eLO0cPRkOBz67dTY/Qg7yVdNvDDjg7aJBTiKt1t+nYWf8NXhQeeQtZDVc2kbKZAL31S7ARkpytzvB72+paFFIXbvwsCpGy5TNn9KDS3ePxb5zXwcBfDuJv5EJm3jcPPVz2rt1WqFUFmVJqRbAUARgU0lZerB6VAQg4IBKN1uQ7Qgoni5+3q+iFMMy7gPOi7LN9eGJPUkRXoVcevkrSrWoIBQIugYY2YKDcWbb6jbyGSuZMU9c6jPLG/jAXD0rMJuhS7jHuwTym2dmo5VrM90H9Ax3iVrlKZaSd+JZWya3IROFPIdctGZkjQzSjDlDNXH0IKbBx5JsIelDW7CWSDUMfWYqRJcqdoWi3mR4gI1GmZwcMTAqg85vUniEnK1QDuBs4y+b1jU0luQo4JH55rNJ0DIxiFio9ji664kDbTX/DyVQnr50c54Vh5+GG52/OQMlM6Qy7TBiZVtYtWHZ0zZ477EBOU6mO2LkaYbQ+/qGG2TlVwVDkRncoX6QxOB5bwvD1rhhdiJL/TXbw+mebDaBT2SDRl6c/Lca4LXm8NerOKgpxlhJNps22oOafphtbudBh+tTLYKAAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(8676002)(66476007)(66556008)(86362001)(6666004)(4326008)(66946007)(956004)(8936002)(107886003)(36756003)(44832011)(5660300002)(1076003)(2616005)(316002)(54906003)(38100700001)(7696005)(26005)(478600001)(186003)(83380400001)(2906002)(6486002)(52116002)(7416002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vAcymb4fQTlIePyEYxNJT1ixGhLASInvei4/DBMhStNi7YG/eOZ863qk8pLd?=
 =?us-ascii?Q?INh/jGEjuC9NfneJMqMPVtmMQbZ4ZrFRdIUNE5GAJAiXk7NRI53Jv7g1cn+y?=
 =?us-ascii?Q?V4yQoZQTsMHFixHlkDRG0DPz8LOUARoTZ4AsxRA6BIB47spngh2dVoElm2Ar?=
 =?us-ascii?Q?VJ1a8YxT/vKOMoQV5vi8V9SgDREZINwU8CSfBZBCGmKuxXM8zcuDY7t8h1Wf?=
 =?us-ascii?Q?W63EDU8Cn0q0fAaIUMsTVh7fnzio3WO0jVUI8YjY72CEUGW0bA//8ooPEJl2?=
 =?us-ascii?Q?qeBVWsoEA2uvPfJ1rl80E1rSBKKrMai254DYp/ttkf4imCjMVi+qx04Y6GMr?=
 =?us-ascii?Q?r1hoOfMVjk8pK3bC8nRI7bnFncs6/JoEO+9ZcB/OUevXmtm2aF1uUIfuAXO/?=
 =?us-ascii?Q?K2N+TGLqnIzuc+ScT8BmJZ7m7h5t8+/jl6gNSFZLrmMsCN2CTuQ1lGyoaztc?=
 =?us-ascii?Q?8xOmWKlAiTSRDs8QIxmYsl05gHvzEHDvMis4MxRYHBwd/RlhWw2iGj6r5x93?=
 =?us-ascii?Q?Q6TMxt+i6yQYW6sQfKetsPasUnBuDxcrgWV/Sz7cUMZRHu4WCGgEbPn1bb/G?=
 =?us-ascii?Q?sh8T6Wp1eguRRRc4JZLZUoNj7HbpiQlUW6oNASRCgRPqxbaMThnBQBuxhUA4?=
 =?us-ascii?Q?7jds+kp6i1xCKt41qKJYY+R9v+m0PzEAaVwz+httse/yetH0DKhGqgjGsWGr?=
 =?us-ascii?Q?bRHwaUJdQ3S97QVaXkvWm/jAzcsWShQeNJrGsgJl3KW87/qAumOWLCuaP1KI?=
 =?us-ascii?Q?JrodYp9MwIu7YM6MmtXNa5frwnIsUuONs+tIJpZS4SQAGdCE0AgjdoK8OSKD?=
 =?us-ascii?Q?Z0QjdO6m6MpH9LEbSyT1Ej4njuQFRuBGu2Qa//3PvBVyKrZ0v38qxRt7PQQX?=
 =?us-ascii?Q?J/XLphLxsTCDUV3lqePSMWqaFiAsNrQ5SZqhA2CmUauVnkmvzy61QnX70Io8?=
 =?us-ascii?Q?BMuklfJoV8m8YqMbN1mTfeh+B4hyoe7eqssQqTVITfJItul+pPeuFRDtGQ2z?=
 =?us-ascii?Q?g7uDUnBjCS7kz8fR4+Se2Cciuj7tnT4KG84o2sLqM/cDJJMHHVqGSIAeLP3B?=
 =?us-ascii?Q?YWKYdcOpA8w11GrYmRZXI387vaCUc1T+tmUn/GcCLaL89IUqUU+xRJ9Uyyb4?=
 =?us-ascii?Q?sw2e5lxISREYqP3qCP6jqLELCZJpJZ4O6kJLtwlIHDijIO+5jhD6QNTO920t?=
 =?us-ascii?Q?KNkG86uyNTKRNC659Ac+qx2Elgz4GIavzGqapAh7nOkR/MgxKVJAb5/+KVE+?=
 =?us-ascii?Q?tBc1DjWFDo1j6/27bogNiXeqeALhSvYC4/F2N9TMrHciagMs5TDHLiY64RLk?=
 =?us-ascii?Q?MlWvYC4Wco5a9weurAnN35++?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb70555-4e50-4bc9-8c78-08d8ef24f995
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:28:55.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knY4k15ZQKAPj2nb7+j3+ol3F0IJpjDtbxWrTwXWAJlXlVSN4K7citLydJXmZ6KH2X+p4bOyCkQO6CGMX3b+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

Replace blocking cma_release() with a non-blocking cma_release_nowait()
call, so there is no more need to temporarily drop hugetlb_lock.

Signed-off-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 408dbc08298a..f9ba63fc1747 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1258,10 +1258,11 @@ static void free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
 	 * If the page isn't allocated using the cma allocator,
-	 * cma_release() returns false.
+	 * cma_release_nowait() returns false.
 	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+	if (cma_release_nowait(hugetlb_cma[page_to_nid(page)], page,
+			       1 << order))
 		return;
 #endif
 
@@ -1348,14 +1349,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
-		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
-		 */
-		spin_unlock(&hugetlb_lock);
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
-		spin_lock(&hugetlb_lock);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
-- 
2.30.2

