Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E741F3B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355515AbhJARyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:54:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16678 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355530AbhJARym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:54:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191Gx6GC011126;
        Fri, 1 Oct 2021 17:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+yqbwHdGWttKhN7nmszckzQMd5R0+R6b0HBaQLIonpA=;
 b=cWU2rLf5CyAWZcR2WTJZS/MKE2JgEaMdGTZI0Tkd8ICLIpuiI1oyOS0iom5IBw9xFA5C
 rpGBo5pNWT55L/mJFNZSLOCFcnjB1Bk3KREpSlqBsai0bkKr24pJP6mhDMmTmL1a0gUK
 QI2Yf4qbpBT3bkeHV0n2/sIFyOmp6DcYlxspluZx/RFNdogbveUdtXbUJNOU/NjbcpRN
 C+UQgp5ljKFqBlHqAeiTG2BYibkt84JuJNwW3NYxQp4UEvCQaq+QyBlzRkNGo5tL8lHN
 NiRPPNSNew6u3R+NC1k80cV0q6PIb5/M7Ln1MnSfw/Jhs1cfUDkEHz3ulL7ty0QqyG7c 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3chgyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191HkNvs109128;
        Fri, 1 Oct 2021 17:52:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3020.oracle.com with ESMTP id 3bc3chupan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk4dw+hUC+8HDVv3zNWY3hks9HbsyfIYeyjBmca6vYSHpiIq2v+x32DHKD9WFZRtV4f4giBcygReK2xVArkuQ2OIMQi2AstrcX8ua4nFAEkBXSUC2cdbxHVzZwJFjjdjgl2OqKFwrBCxNFdHi/kzFj/RdujmIXa2RU67qBb2tIT/TS16b13RWgaleA7Na59W1lijf6iTBp4cIEzBtxPaAP3Dy0ZJ2avHp6LzLg0RIeZ5p4YZ6qOJxdwmvdVGqiwSelqPpX06gHXThltIZs8jwaQQd2gpIkljMLgfIO8a+C64WGGj6H7AdxTZFbP/4kXo33t5u8P+JcBR5CX+W2dzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yqbwHdGWttKhN7nmszckzQMd5R0+R6b0HBaQLIonpA=;
 b=fNskxlnUe0z6bpFvd872lZAYv4m9c+twWuFGTE9IzINIxPvsAN2o+eE4lGUEdVLnqjpZ8vLi+fyONVhCoW0x224aj60ckq1QKxQSENAgj81VnrH/HhI3c760NPHuLHbdH4NDyDzVFckILSv25/o93iPcWN99j4vMk/TJsRL/ZmIK4N8EYiov1xESYt3Y3GVoSMw7M4EvWEyu12oYZotfT5mogU5VuFnUK8z6BldEbtNNe3RgTeUfxh5iQffAaYFM0K1fnTORq5qRkqjaIcbLkjeNTef8ZuIN49WJp+rq5IgRgsSQ7hGIayHJyfMzxpHWGGppwLolZHtbp+F9ecFzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yqbwHdGWttKhN7nmszckzQMd5R0+R6b0HBaQLIonpA=;
 b=d9gI687hLopzuFAM8k6wNbKaePdOcLqax7AyvsKObGrJVQnUn5E9JF8ZPrBaKZ+u6IzsMuLAJ1eu/3jFlfK/Vxvmley6f9QTA8n4ZcSI8NKfVwhuHAg9AG7bLuxpCIwhswPuq9x7FvIt1YB0oXJWgXt38Mv6sWazV/iHdkHzk8Q=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB4924.namprd10.prod.outlook.com (2603:10b6:610:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:52:35 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 17:52:35 +0000
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
Subject: [PATCH v3 2/5] mm/cma: add cma_pages_valid to determine if pages are in CMA
Date:   Fri,  1 Oct 2021 10:52:07 -0700
Message-Id: <20211001175210.45968-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001175210.45968-1-mike.kravetz@oracle.com>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0060.namprd22.prod.outlook.com
 (2603:10b6:300:12a::22) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:52:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ea421b-1d8a-46e6-ced9-08d985043fec
X-MS-TrafficTypeDiagnostic: CH0PR10MB4924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB492425CBA9236ED7524C6F63E2AB9@CH0PR10MB4924.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sY6IDhkNoxrRFQxv4tFsW7n8m0/L+xMk+OJTwulrg8vf/YeBevsuPLtzaBVH8iuEhevS8023D8koBKagdUS1LTHZ/kHF0Nt1Nb31E3rt9Dlzo374xZctLo/CTk5T1fcTEc0FYdgwfguNKhkF3hMEbE9QhqACeWoCb1+0miGpIZ3ylY37FhY2orlHlcjS1Ez5xofSA7uaFMCbix9YPdjTkV3nasVfFFP4Cg9/VsLYW+FY9zOZSMrSj6p4hlnGhWWy12lvz+Tta6DKvtiasQgRfW5Hv0H1VzT7EZ9qwpO8eHTQsVbYKkxq7su90NbuhZKd5Zrjh8J7oGOIz4F+bgRRw8E+jlxEmQtr0DRMJJY0yQSU+xeAFMU7zpT2SEl1y4nSqjHShGrX5rJYqKw/4wyaQVtXxJiMCLgpT4jKEVd7lLLPDGeFZWr1ZqbJ+Fa7WDsCYhmZOtLcOTsfCMXNxyXw/Yq2G9fSMpmPoBmBc56LjA/5VtZ84q0buVRr2keetgdxSZIWYjHCB5MDoav38//AC9zjx2SFySsc52+GEkfMoW2usDbBqntDbA5QvHGF/SYUWvn3HrPnqCH8elw7VSodnRhhdx2FflUeetOhwcT/p1AHIS0XN0jIDLuutDwlgsxukdv1Bs4E47qT2njYIh4NnmuLwomAJCxBHZVDcD5Rqg6k7YCvkN//1cZTzxh0eL9jXfUgXO3sYo6INx8DYOpLng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8676002)(8936002)(52116002)(508600001)(5660300002)(6666004)(316002)(66476007)(7696005)(54906003)(83380400001)(107886003)(44832011)(36756003)(4326008)(66556008)(7416002)(2616005)(956004)(2906002)(38100700002)(1076003)(38350700002)(26005)(186003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCPat+gf5ttt57RgJGK+CcKXL3Fi0AI2VW+KkP7ZNpUC7sYOltlDY6L4AR7y?=
 =?us-ascii?Q?TLaPXgyJn1nM4aliKPoLrbhUyl/SvZJOb38klqoMULrLXI0Y9/13pHBThOJx?=
 =?us-ascii?Q?hD11+/Degvfi5Fjc8FFVlgCjsWfVRfWa2rZnMLdf59eSJPDJBJryjWgYYBw/?=
 =?us-ascii?Q?8zI3bPtujcGqGbMHnczZVKNRD3L0YwKSo/4mOu4x9309GI8p+srKqCkwYfcA?=
 =?us-ascii?Q?sSE9CNN8ecuRkPZdSlWTDLc0kEUev3Hz6xXtd5VMfGuYZYczMmBpb5mLN7j6?=
 =?us-ascii?Q?3w50lQ1gUTvIDRZTaOdewUQAavwYydJg/BlnJMaKyFDDAsof9Boc/w/MUXwe?=
 =?us-ascii?Q?jio3mwpFcRRTfIg9eM8qw+IDbqGeisLFPsGwoOaQPn4KLGO206DkmNMVpKOO?=
 =?us-ascii?Q?6zVdjJA4NKeainDnPMbdB7sk7dOb7s6Affb4jHhewwbaQqK4bOteX52+EOHz?=
 =?us-ascii?Q?hFOQqlHgAdUnF8p7LVpiPfu9l0fJLhLYNcafmkDC5OlQJP/+if4/2Rzfgz5n?=
 =?us-ascii?Q?Rm6op5evJvZqzDUuMny0YYxZFmPxQSmibiB5fbQtX+HGS2hJ/YpBAb7qN9uC?=
 =?us-ascii?Q?6D4imZ+EURi5DqKZu6QH+9HtgNK7NURNtZ5BCR+H4GRjeZ/cW0Qo5y8OfvAR?=
 =?us-ascii?Q?fbFiLSqHkkVqNfqSsqNzVqpEMGge+F9VbgcEy3PfUH262I7w7tcChhcq2MMO?=
 =?us-ascii?Q?oDYQpheLfmWOhfVZLbgsngMo5izpQ52cOyHMvhNsab5cNxskpwL7dodHRm1H?=
 =?us-ascii?Q?aKs3+DxHPDY2CrATDY6RUbRQLs28yTlZg+s9OnUE+xkJqj+NJh5zuDk5FvgN?=
 =?us-ascii?Q?NDgxudyiQELmEfqtrP4j/k+/ZOFCwRrMjjmSCmSFiGfGgofWtNoC4bEmg7vz?=
 =?us-ascii?Q?I/7TLC/IxSj3HY/9gU6AAREFewTMcYTCgx+Lmw06kYt+yu1A/3KquZ2w1kKR?=
 =?us-ascii?Q?vP0K96VfXu/tsO+sU2fs5yQYkmlPP0DwFm31VRg5kSJefujc0EVUO43noZil?=
 =?us-ascii?Q?FaPloAK2OQYQeLa3ex0oQT20ggHE/BUn9pMejstjUIr8pOGgpUmQWVn4HtOg?=
 =?us-ascii?Q?UyIKEaF6J0JyheYJSYEn6mbnJMuFVfo15m/zm+CLiQzxoIy65WpVlSH45nEH?=
 =?us-ascii?Q?OEk2IdZHXYZLFBawfof4IooDIH7Lrpao0Ikz1hlzoZiqYNK/QkGLmp3ydEvY?=
 =?us-ascii?Q?gBewwf2JDqWnHqO9uWbYtAmsLne0C3OGbSw1WsnvHYn0YvEyfYgSUk0jKEVF?=
 =?us-ascii?Q?+PyRHuHNtOCJ2vh1X6bklvfsOndR3oLEo3qSBfSJFrp9D+egkg2g3wXidn0T?=
 =?us-ascii?Q?QdQ13U99i3gH2UNaqbiDicCh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ea421b-1d8a-46e6-ced9-08d985043fec
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:52:34.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jzxu0dwBF2OeyGzg1pmtNe7awYT5UzDcRUZQl7Ynz7ZSHLomeR/9V27R+bCvVMyvAfapaVK+Nx8/TNYjs44ZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4924
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010127
X-Proofpoint-GUID: ZYjnydTQcoqQVV6Huq2RBk1XYA-nhW72
X-Proofpoint-ORIG-GUID: ZYjnydTQcoqQVV6Huq2RBk1XYA-nhW72
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new interface cma_pages_valid() which indicates if the specified
pages are part of a CMA region.  This interface will be used in a
subsequent patch by hugetlb code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/cma.h |  1 +
 mm/cma.c            | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

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
index 995e15480937..960994b88c7f 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -524,6 +524,22 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
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
+	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
+		return false;
+
+	return true;
+}
+
 /**
  * cma_release() - release allocated pages
  * @cma:   Contiguous memory region for which the allocation is performed.
@@ -539,16 +555,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
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

