Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43403E4C70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhHISxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:53:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26214 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235833AbhHISxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:53:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179IqYGC031886;
        Mon, 9 Aug 2021 18:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UG/aAiHICWCxjsvFC7O7lICWLzo8EYGo1APQM/mI0yc=;
 b=HBAdwgcj1IGuLQ9yqo+WxT7qMzUBJKfFtoM5gTSXK66epbmE19hktu+GULaBbfI+OjlU
 Spg8GrHAe9tblerkCg1yjDE/xtBYYyS9jHPU1FQpSjX1lPzpce5h38AiFEveWKiKUYYa
 IYdEHqUYbR6jGJG24zveAKa1Mb2zWzNF89YLo0CmvNfDx0Vz34FgHqUm1eDLRoKtvdzK
 dYsvSmmE/1etpbKbVsbtTQ9NH7dk1L8VPl7shX5bU8QThGBOEPkYsmZKts6S6GmPt9qx
 9Yc3t8P9Tc7GgTyZhrV/RMi808EabU5MOg6gcVWsu8t+r2d2LYPklrfQRVSyxK+7PKF1 vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=UG/aAiHICWCxjsvFC7O7lICWLzo8EYGo1APQM/mI0yc=;
 b=r78fHa1hzLFIoAm7erYB2E7w/gZ7hRAmNYZLvPylH3JJOBA8HTSkIrzTbh62QiVkH/jq
 jHK1bIAQo1+LfrrTQHusiWA7TutwZ/NMXPEZ/nP3AEr6UTNrAUG5gpN17UAlcvTPDLtO
 BQ7DG8gnNeMCcCEwg8FqfIPHpBvjnJGuMYCW7kltkCp0S7AjhjVPmLkswhEDNendDBLa
 rbIG2rpv/baPCSjxd9SvuwRX9sAfrfRc1NM+ZGEf2MqrHD4FdBKkj/ubxhm/gMvNMTVq
 C0Lu53pGD/AgWenf96vulV+TBI24gJydu5Z++bh2LZEGi2Ji7S9Z9Fh+1hJphEbzndU1 OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01r9kx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 18:52:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179IqBUC152733;
        Mon, 9 Aug 2021 18:52:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3aa3xrrm9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 18:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgxW5+ycBOSlNxuaFpxJUD7vKMmSVxcVO24ojjlxkLcIlJLi93t2/ee8nkHBw0d7LCDiYw9EufoAWUtSfj8gkDXVmMMtIrCS3qCtI89YqllfgMHiQjrydgyNEMHJWHiwInwM0Ldn1ANlk9So9NtAXC0eunpQ+2SDLlycfYKY4UjRnSuD46RKYlQx9yNHPpcq/1P3nnD7lVNFa9vL6oXm5kC0ZcUt7Gtzm+LtKInV2ZMxTaNYm3fF381s8+Tn4YWNHorxp2R0L5CsoTb8yKol1JpJRt83jxW/rpJtkSFwjFdLmfIcJZ9jFFSQpxbL9tX1enDP+KAZzcpuv0o1ZNlbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UG/aAiHICWCxjsvFC7O7lICWLzo8EYGo1APQM/mI0yc=;
 b=kKVYLjj8oIyUbQVFPlIs6j/0Nm8gPiHSzPpsErkRPAAXDAYE+xS/+lMkJ+06iLZsBodOaK6FJv2mVRo1zj5EE86/f2X7Qg+UthEKE2j/qmML/ISEKUFOTT01CISUngSD5h3R/iuL3bkxe8iqxw5hxti/cY/Ey+28Yd/Er7tdR2DCpPI0gnNJEcnF8EKY6qw8eYvj8rRktDnmxM21OJXX8URRRU1qnyekT7HrB4wYvGBONXGMd1muV07XBYbQOtBK9KB7jWNMZLpZVYiLZAqF6olH7m/6ifndMVJeSfzhoLGZ+qa2eG5BJNCnY3ynI2/UZUZ0k6rUYifkAt72bw7s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UG/aAiHICWCxjsvFC7O7lICWLzo8EYGo1APQM/mI0yc=;
 b=jc5gxLnrqTTNPiVg2qSeqvqYgV28ptRw/fJHMvaoWZQerpxRWdMF62T9qspjrPTLwo/ayTAv+9ZlHDVYzdbbCaCnRYVsdOFN8DMuZG29NPdNmNr/zofcDkhUE8egArH05iunI7vGnzmGGpsQC8eJ6hxkDpoB4g+zxzcVM2KswSM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2952.namprd10.prod.outlook.com (2603:10b6:a03:89::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 18:48:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 18:48:49 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 1/3] hugetlb: simplify prep_compound_gigantic_page ref count racing code
Date:   Mon,  9 Aug 2021 11:48:30 -0700
Message-Id: <20210809184832.18342-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809184832.18342-1-mike.kravetz@oracle.com>
References: <20210809184832.18342-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 18:48:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7d36706-a30d-4694-404a-08d95b665319
X-MS-TrafficTypeDiagnostic: BYAPR10MB2952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB29528A1F0CDCD7BB2C0E6305E2F69@BYAPR10MB2952.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ge0ZBJ7nbs8EPZRTAXL0mo2jYvobD5rIegF3Ajs+i76YSANngh7AMiCGHP4KT4ZWqsMhu+DBHxDYsWtiTGF63podv0gUJWpvY7a3TpeDNKYjso0hZgA46QOZuJxPl55agpZh0CdDScV6LifSTq7wkCbksUaBGmrmNycyUvK48D1ZgYUsFyHMzM9f2J4Enn6DC7J5sf0Km4/ShQaH6lizGePGWmirbGDBe5Tw7Ugn/QGiLBhcJaJhIc7nRDPLFC1qWAwtcwmyV8JKvI5vfOO7pBDCsn4/RRyQ4GnYV0hl4wspCCJ1+THIydVkNiaT9yJejNVbhTES2yZf0scE5z4SxN+QuecdKBq/zXEuAoDxJ3df1k00d/mwtOrDH6vw6VGD7+jK8XYKVU/6Ry6E0BCOiA0myb+S4BUZ1tDLzVGxIVEiU76iStlwhriDiEWDVgygAQII5PG7HS+bThEvYN4mgjCD9EkFJMtx8WU/xEVAaHCBys8mC1RyR3Wp9fJN7VkzkoBJ5p7cnnYeqMXVUR7CfD0y3ExwmvSUal+jqs3mwqzKSl715XRqTLvCq28NeuEdF6zo257cqXfKC0J7kbwyLOF3/zl6OiY96KTHC6GVlBUnxSp0Kk2IhVTq+VekJVboF7sBKHXTIDBxu3JGUdJOJYQZEFex7pkZPFCArk5SCa6Vk7IkrBwHTBe0251+y/r8EAySteZKZlNPv/8l+W64lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(4326008)(6666004)(54906003)(7696005)(52116002)(8936002)(5660300002)(66556008)(66476007)(478600001)(83380400001)(107886003)(956004)(38350700002)(36756003)(26005)(316002)(7416002)(186003)(8676002)(86362001)(38100700002)(66946007)(1076003)(44832011)(6486002)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2V9JutTlBEWKN36zhySBtEzbyBPGja4rfJrg2PHZRRxLvoz/KGU68DFCpWQ?=
 =?us-ascii?Q?BUqeZYLKwbaFTEMZhtSzKMjGOI6Rf9SYFv8yBTsDvRT+EciHFBRXdEr+0J9v?=
 =?us-ascii?Q?Ggoot/LFHqLRZTkNObJqHXWrvnXw1mQcXYxZHnbiKFU8flPy49vM8vcB9iI3?=
 =?us-ascii?Q?ILpXGselZgsbC4n0mqdWpkojQyMtfKe9pmILGShIt694iH3HUlBrRcO+vMwj?=
 =?us-ascii?Q?eKwgLY/VNtJFXgTxemb/aRtZLBYYqk9jU/a3ilIL6q2LvaF4fSwtITq9eJQu?=
 =?us-ascii?Q?lgwtoVUYxJUo5TBUYNpyt3guxRQJ5vUgQV3NIDsnUgy2lUkHg9F7kWZnZepH?=
 =?us-ascii?Q?XJnS02DYk8pH5cUpieRuZGN4GRLlcC6QQOBpFxLNPI1AjZh9AdEFC2hTvLGs?=
 =?us-ascii?Q?YL2qcWPDlYWKc8Ao29jzg6Edb9nBS10GmVzBA4n+dLmtWOk8kEfRl7EkGbyb?=
 =?us-ascii?Q?zYv4z1c0/JC3jjyq0u90k11a5DNNDrF+GwyGbUUtRq6cf7ajFrQHi0QZXR8K?=
 =?us-ascii?Q?9VckTOcbxwHL7gunqA061RE+j1F0v+iXtnNh2F2rxfdbP+t7Ec8WO2r8OiGW?=
 =?us-ascii?Q?l1uSmCwmkHXbL4FB0azwpvw2Fk6y1lmvSRbVxjoJoxTWcCyqtOJY8b5Zbpo7?=
 =?us-ascii?Q?Cj6/Ez2l0+bXa1NC4WrcNunZFKt4TNVFFx23cJvuJ2XBNs2KNHv38tjDzL6H?=
 =?us-ascii?Q?y8UfpxKvfyUWqCCYUcHeNAZQPLcG4TeYNtDT/DxvLPmiZDmXOQEuqUmTD800?=
 =?us-ascii?Q?08VHF1Sp5hs/orun4N8eCJPv+W7DL0DcrpTIedzrjFnpwIlLmhMLjRXoPtKl?=
 =?us-ascii?Q?2Qr+kyb20lqeqP/6OMSY6KEmIkMKL/lHHWHKOy5RXnfrcNNdVXMloNjAmSMY?=
 =?us-ascii?Q?NnGH0LhafjPMzRkE6WJ1XL6ISycbd0wv/tKw7dw3/NNZIYCl4s1D6nyHxKRr?=
 =?us-ascii?Q?IS3yiiDCUzHQCH6Het8jKJ1OuXX+IzFOBkz1A9DPGRhW1xSayeizoWan4SbO?=
 =?us-ascii?Q?JLk2Gx7YQj3zh+s2Cf8iabPpkPtLvX1iRmVHE7Y8vgZ3hesQTiWfVPWKiirZ?=
 =?us-ascii?Q?5TKU41KZt5Izv8jV2BE645KJOoFfUleTBSsiGIu8R5rWUYwtytaXEo982GAQ?=
 =?us-ascii?Q?y1I1ozyKRx1rYmS/ZLTvj8gXKhucxsSbg1Q8e9C+wFrOg0B+ueX/TcNCAxoA?=
 =?us-ascii?Q?z47KD+q1mi/gEDtkBPsxcBWTsbnA0p3cNUZJdV8edTnQmYncoi4bqMLEalgB?=
 =?us-ascii?Q?3y3vKSTouhZ2mFKw9rUaqWr4C9XhdtJ+RKao2Tj3q5F8TVGZ943jZjQTZSVx?=
 =?us-ascii?Q?ZCNJWBcNSPYcfJ1KA6ZAnYcL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d36706-a30d-4694-404a-08d95b665319
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 18:48:48.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iMSjMKRXuJiVvZqPAlH3RAwdVkvgsXPu1e0Y9X8f7GJDDwqRQ9h5o8RuEq9G8o4LzQ4X0HfcRPxlbWB7LsFhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2952
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090133
X-Proofpoint-ORIG-GUID: 5tsxqjfx-WbWefhT2ly-6g4KQ-5uFSPe
X-Proofpoint-GUID: 5tsxqjfx-WbWefhT2ly-6g4KQ-5uFSPe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code in prep_compound_gigantic_page waits for a rcu grace period if it
notices a temporarily inflated ref count on a tail page.  This was due
to the identified potential race with speculative page cache references
which could only last for a rcu grace period.  This is overly complicated
as this situation is VERY unlikely to ever happen.  Instead, just quickly
return an error.

Also, only print a warning in prep_compound_gigantic_page instead of
multiple callers.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfc940d5221d..791ee699d635 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1657,16 +1657,14 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * cache adding could take a ref on a 'to be' tail page.
 		 * We need to respect any increased ref count, and only set
 		 * the ref count to zero if count is currently 1.  If count
-		 * is not 1, we call synchronize_rcu in the hope that a rcu
-		 * grace period will cause ref count to drop and then retry.
-		 * If count is still inflated on retry we return an error and
-		 * must discard the pages.
+		 * is not 1, we return an error.  An error return indicates
+		 * the set of pages can not be converted to a gigantic page.
+		 * The caller who allocated the pages should then discard the
+		 * pages using the appropriate free interface.
 		 */
 		if (!page_ref_freeze(p, 1)) {
-			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
-			synchronize_rcu();
-			if (!page_ref_freeze(p, 1))
-				goto out_error;
+			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+			goto out_error;
 		}
 		set_page_count(p, 0);
 		set_compound_head(p, page);
@@ -1830,7 +1828,6 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 				retry = true;
 				goto retry;
 			}
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
 			return NULL;
 		}
 	}
@@ -2828,8 +2825,8 @@ static void __init gather_bootmem_prealloc(void)
 			prep_new_huge_page(h, page, page_to_nid(page));
 			put_page(page); /* add to the hugepage allocator */
 		} else {
+			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_page(page, huge_page_order(h));
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
 		}
 
 		/*
-- 
2.31.1

