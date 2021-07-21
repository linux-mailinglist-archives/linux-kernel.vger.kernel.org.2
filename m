Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608AD3D1A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhGUWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29918 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230376AbhGUWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvG6u009329;
        Wed, 21 Jul 2021 23:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=g+6VZGRQSNnCGSvjXcCWDjj7JZh/wgzNtXrvPGSgtPs=;
 b=gEIPkGCuq/xbqaf9dusP7NleUhO0ZwjPAjMTluxHAW2OcsX4IyHXty0Onz8MAxgl3eKL
 HQYM2pidcraQ/dq2sE8vwfhgdNTkU/ffgUknlwC9arNNibrXp0NJADuM3YcTyQzUSbbg
 TdHs26GypPzoKkHtoIfsxEStsshbqH0t1qe++5PMkg17HLofcgv6U5O/PF0x1P6HRxFW
 i77nT6JuxPMMoe5UZm16RcBIfigjMrOMFyjt4qojafxKGquLCZbcIiZxNzIwcbpMY6zG
 tu7KAV80ZidQRdW1vFD2SUV9trcVElItCSOfgGhthkyEEeBhrWgnyb1zEKNsAeY3FZO2 uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=g+6VZGRQSNnCGSvjXcCWDjj7JZh/wgzNtXrvPGSgtPs=;
 b=qtwxDFJa8pC1mN+WwY/aAzYNhgbAscZ8bl6zcGRBJHJqiAcg0FdY970QYG1UaAeaYIJl
 F9YMQdLW5PC/WrzRM1iFnOonlFSEPV5+oHe7cUWGDEI3VdQVljIcCxzNUU9j5WPoJIEy
 mkU4hcEzFzxB/ssYkhupzMN9BsCPCUY/BnBhMvaSs/WfnOWnH77GMdKkWGussiQGOfyp
 XsjRT2Kyt78F8c6WqoVVucXMzoDA4y91U0RfOVhZnf3N9hVSNErLPaM5raxC77M5txYP
 qJ6/alqcI+uzRijyD9QiSOeZNL+EuX64PqxwP551ceZUwfALiTzQ3DXqneblBVfMi8mp PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xu2fr5wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN0Z0h143558;
        Wed, 21 Jul 2021 23:05:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 39umb3qdx8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKMNnt03KUZrlLaoursapZoUeP67Ys3e4e+F7VbRp9EcRRSgYkv991E5nDJFylXbb1nWjhfyNWxou2knIMvQfjzB1rxDZZ62mwoWgjW8Xbc+7mjKh09J0RKvmTUFSAChJOKji5aKd3ZJ3mR5i8jLNS89b1Jn8eXvtC/61AofaP/qZqFRSxPUZE76GUbP8n4/5x2uj46L07XppDMVYVSNqTrel/hIu3s5R1Rroa0BffeB2TbrQRFlTECkTraWF8pBAR/tWWX6OV/6EwpyOvoXhMT94HGOTySTOb6i+aPg1oHcb/bzBA2Ryqf6qUtAjmxdRZmBH7VGQY9t0TiXjiO8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+6VZGRQSNnCGSvjXcCWDjj7JZh/wgzNtXrvPGSgtPs=;
 b=OzsXu64JkzcGteUh2n0BYK6LdtVkUXKP899JNafYItKwBEkwg6Fn38OBrI0tpQJkksKjc9jfZIB6CHDCLJGHoI31g5GlGNFmuHfSeP5jZwd9FPHr4nI6A3xBGdKhQPlXxKPE5dBkz5l00xWFEHPBnkMdgJX+U1BP4+EgBuhm3U4fSNYkRPC0ArU53et4bq6oqoUGN1895E9xUWqVMPKU1NFyywiz4h1pyAUtIC8P0oYg9ruYezAsnCbJVlf9x2Oonvw9JOVJBo5TmNT3KyjpIxTd6aTa4ia5GD+ohTlUFao8P65CUCIua0sBW5uheZKk3bMXijT87Jxy27HU+qUapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+6VZGRQSNnCGSvjXcCWDjj7JZh/wgzNtXrvPGSgtPs=;
 b=S8ZMVtdNBmGupWrR4i7l9CESLX0BxizUKZETR5m/YX3qJEjfKghJ7mGzOD16qkYZnBD8gGrZpL8WfbVK46Pkb9ZbgjPRQCbaswhJCKhsVx+noonLj8HdS+AzpR96UTOdUf3O/mg6k4WreYo73LrrwGtuDEOM1TfNTecqJtexrXM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:28 +0000
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
Subject: [PATCH 3/8] hugetlb: add demote bool to gigantic page routines
Date:   Wed, 21 Jul 2021 16:05:06 -0700
Message-Id: <20210721230511.201823-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cdbd765-48b1-41d3-79df-08d94c9c080a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3735FA2AB215091B8BC8FBCAE2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RBMTsoYgi8Nd19JOyby0SZZQicMAfFpVYuLblLtexl+J9nGS+gqFpRZxJR1/eBD2dWnTpiZPjBayxlbhkORNrYyqpMYvXN9AawRKOcqqLKeUiHf3180si+86b7iGdh37G3HAPQVb6o71LYg85aH4uGgMjn2iSvPT8Qcvts7dWMEip8KXDDTWryh+qnUPn0colkSPX1zglLrbOk+i1bsij0/poGaxw9MGFfrzNFU+v1X9dI67COb/yr+fNI+QNIqcOUo8420931uAxf+WI6lejFVaB0he3fC+BWTMcX0ynq/9EqCtdsbGkCOb3YUdjOoGwxSmss9S1c9+86AuhUlGzgMjjCykKL5AXmLME867+hpt1s+2XLyPwREiSsXbUucp4Gv3aJrSgMIaoftvuLZ/Pg6uoZ5fbcpCF6KPSU4HneITnTkz4jEDsd2dgnAdN3826n4o+S382x0zktfnR7hQ9vrrvnv0nTZwFZafmwZ6srzIEbN9RpZG7LypZqABh8S9MWJHipGAzP13AgNUO6S9LV27XQcGjoxQ1bDK3m0rUXiZSC4pScM4ifHu3YLqlce+KHOCpJFC7Jw52fF33Hwm7ecc8hYnfMverSPRr4cKkWL4XZ0/b0CtO7eNur6qz54xycPCQleny4CpythW6bgQAKxuf/99nJCujM3WBQZdgVAVR67Yd/2VDZBLapF+CU7Hdy886+4kehZr93dV9qVGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IqjJ+cySHOcDSQE39ZeJASOLHxhQjyQYQTs3SnpEwyHF/jjAezjSw+S+Kqtp?=
 =?us-ascii?Q?U30MaXoRzsPkNIPg2dpF4qrwan9m7x20drtNc+jxUEPbrw6A+4KJRFsBqLFf?=
 =?us-ascii?Q?UeDxfcs0VDQ4fLZ0zK2IlmL2KEloSDER2y3n/m7Elx/DIRtURampJtsw6tsa?=
 =?us-ascii?Q?kKHAvoxgYy87AWHw9FAswBb7Zj1nuyxw85sizqOpCLSSrvqn0f4rN3MvRTNA?=
 =?us-ascii?Q?UMEOvm7w1FFXBZoJv7eR07VYAICEu28mWxPDWG+McZwv4yY1hTm21PakaUaz?=
 =?us-ascii?Q?qDbViyNqcRsGkcXGmAhpovOnJCHLR73DPV/h/CJrrrDwSbM/HyR9v7/iugi+?=
 =?us-ascii?Q?A5ytlPCMKDT+MSDnPFn1CxbxF3swBa7FF2ucjN+TCFTyH5i7ges8IlMEeOA0?=
 =?us-ascii?Q?t0l+NFxJz5itx3mRrfbxqSoukLLBd3X6IGYC1czx1hnWC+/d/Nlsf2DkVEHH?=
 =?us-ascii?Q?9UNYRjKv4eDSrUwg0wlC3JCYyPX3LzY+xLz8xnjyQDs9O6H1mwRB8rM3wQZS?=
 =?us-ascii?Q?Cj4rVkQqvqKyMSjfaG0Z016P9YA3ttUq8QW9nfYTJ4eRY0gRQGG345sw1wBi?=
 =?us-ascii?Q?L1iOpsSkNiopCp66Kq//HvY1WZp1HgG3dIRP/VTYGxbBixF7Xr1nDm+e45M4?=
 =?us-ascii?Q?S2hARReyMlHJfNB2HcgYyZmHqUyQn0eK023uMbdrQsHpvc1DeWxoTz52V8/E?=
 =?us-ascii?Q?UJG3FklgTPrF5s+lO9NXynad8nNnRidu0WT5nCwB50jMIf94moZwSlycl7TT?=
 =?us-ascii?Q?pNPySjwS0K9freQ/yguJ1ESj+oQXcTt4AOc5c4abd7z8npb+8nqNXN2fTctS?=
 =?us-ascii?Q?NQwRWQtBHZoxQBLCpcpbictZ1NDFBXelKD+7bbooSsQdiXrx4IoXakGD08F9?=
 =?us-ascii?Q?9uiZ5N2aFrTlR0t9QaNFEJb6K7O/E2fwiGEsqEqw3GFZwF2gcRm61P3Diqm/?=
 =?us-ascii?Q?VcB5ruKkFv8T+o7lY7k3Ux4z09fmbiPdcR4mBqPURJdlxZuvsf6nDENpOPs/?=
 =?us-ascii?Q?YSk27hD4lrPuCz3uyaYPpj5JvoD1Y9FEwG85BogQy+hebm28VZTEf9g06KDn?=
 =?us-ascii?Q?BjhyGuXNj5zlDSxHFq/rdQztGwI1A7c+FphcH7GG4A5acbsnQk5yFYqrVPKR?=
 =?us-ascii?Q?NTYWuxJz8sipubzsLgyUKXcEoGmbbG1m0IVn+ZQntmZdUUS3cKE3zcqFNR3Y?=
 =?us-ascii?Q?AlFLCoG/nPN/Gvcmdurc46ajTt3K3hriGUFes4VNtW8NYkjUZ14qeKz1P51z?=
 =?us-ascii?Q?vYa1wiXhApVfv5a9Oj4VSn/pwkQ5Vied4FYIE84HxVPj8d4JnqK6a2Bf8QC0?=
 =?us-ascii?Q?0g5hhZmF7PB6IqMnVwIrIvKZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdbd765-48b1-41d3-79df-08d94c9c080a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:28.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqL8FYER7HvI3f+Mtk+wFB3t8B8UKR8lCBjHrjmkBKypU2kBxRtkcXs0t/90EOetuie+lmE/mPEyOrNwPd1g2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210137
X-Proofpoint-ORIG-GUID: CL-P7M6HLSveF38KOGyW2bRvyl444ucQ
X-Proofpoint-GUID: CL-P7M6HLSveF38KOGyW2bRvyl444ucQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routines remove_hugetlb_page and destroy_compound_gigantic_page
will remove a gigantic page and make the set of base pages ready to be
returned to a lower level allocator.  In the process of doing this, they
make all base pages reference counted.

The routine prep_compound_gigantic_page creates a gigantic page from a
set of base pages.  It assumes that all these base pages are reference
counted.

During demotion, a gigantic page will be split into huge pages of a
smaller size.  This logically involves use of the routines,
remove_hugetlb_page, and destroy_compound_gigantic_page followed by
prep_compound*_page for each smaller huge page.

When pages are reference counted (ref count >= 0), additional
speculative ref counts could be taken.  This could result in errors
while demoting a huge page.  Quite a bit of code would need to be
created to handle all possible issues.

Instead of dealing with the possibility of speculative ref counts, avoid
the possibility by keeping ref counts at zero during the demote process.
Add a boolean 'demote' to the routines remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page.  If the
boolean is set, the remove and destroy routines will not reference count
pages and the prep routine will not expect reference counted pages.

'*_for_demote' wrappers of the routines will be added in a subsequent
patch where this functionality is used.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 55 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d034a223d5d7..0ad75e7775dd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1251,8 +1251,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
+static void __destroy_compound_gigantic_page(struct page *page,
+					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
@@ -1264,7 +1264,8 @@ static void destroy_compound_gigantic_page(struct page *page,
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
-		set_page_refcounted(p);
+		if (!demote)
+			set_page_refcounted(p);
 	}
 
 	set_compound_order(page, 0);
@@ -1272,6 +1273,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_gigantic_page(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, false);
+}
+
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 #ifdef CONFIG_CMA
@@ -1344,12 +1351,15 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 
 /*
  * Remove hugetlb page from lists, and update dtor so that page appears
- * as just a compound page.  A reference is held on the page.
+ * as just a compound page.
+ *
+ * A reference is held on the page, except in the case of demote.
  *
  * Must be called with hugetlb lock held.
  */
-static void remove_hugetlb_page(struct hstate *h, struct page *page,
-							bool adjust_surplus)
+static void __remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus,
+							bool demote)
 {
 	int nid = page_to_nid(page);
 
@@ -1387,8 +1397,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	 *
 	 * This handles the case where more than one ref is held when and
 	 * after update_and_free_page is called.
+	 *
+	 * In the case of demote we do not ref count the page as it will soon
+	 * be turned into a page of smaller size.
 	 */
-	set_page_refcounted(page);
+	if (!demote)
+		set_page_refcounted(page);
 	if (hstate_is_gigantic(h))
 		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	else
@@ -1398,6 +1412,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	h->nr_huge_pages_node[nid]--;
 }
 
+static void remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, false);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1669,7 +1689,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
+								bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
@@ -1705,12 +1726,17 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * the ref count to zero if count is currently 1.  If count
 		 * is not 1, we return an error and caller must discard the
 		 * pages.
+		 *
+		 * In the case of demote, the ref count will be zero.
 		 */
-		if (!page_ref_freeze(p, 1)) {
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
-			goto out_error;
+		if (!demote) {
+			if (!page_ref_freeze(p, 1)) {
+				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+				goto out_error;
+			}
+		} else {
+			VM_BUG_ON_PAGE(page_count(p), p);
 		}
-		set_page_count(p, 0);
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
@@ -1733,6 +1759,11 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return false;
 }
 
+static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, false);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
-- 
2.31.1

