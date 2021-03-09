Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54CD331B90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhCIATl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:19:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCIAT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:19:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1290BRA5176186;
        Tue, 9 Mar 2021 00:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=0XxGqGQ5zWu+HR4sSayDXeOjmvKqZHA8xBlQY8MwUG8=;
 b=TDWBRqJrCVZ9o2dUy4ZShj8HTAdZMwk8WRx2PHc7/PbmgzMOZqU0noFd6tvkknUSw3gL
 QVuQXPLvGBvXCUr20l5JeAapixN7HtrTh1cwd4e+6zQXkZsr8YD56VnxKVqAVMQpcUMz
 skreh4XyDbCClKRXIPnq5xJdvbW0496O+1kD7bS0XBPZLUwJsbcFlDOQxxIofaOfYSem
 Xw7e2iz982DXuI4BV5Xs/jr9yO8y+zIwgd1de1PtHFkHFaUBjbwtBNTn6GZpdzCBIvrx
 EKCZfEx6jmplOXF4GT75S5gta8dSzeEn4G7HTWJfxCZtTppi+J96Tm9h3BsyWswVyu7y Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3741pmdhep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12905QHm180715;
        Tue, 9 Mar 2021 00:19:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 374kmxpy4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSYKE89mFsTjxLYCsqiJARDKEmQ1p8o4QxarUWa6TkkpdkfDCoyp4VHLoBbwMCHRJqaZZCk86YfHx+vlp3yytAghoa6Wy2Uf0TE5PU44U2G37oXYj9ONDSw27NCs6Qyf7wLRK2q/sdDq6/SkEQ+keMPAhOUH7X0Gkqjt9UMSzKuDgFPZ00PRk7Z/eAha/imHJFa8ouxs9XHMxXB2Au1owucKeqX6Ynx98+dcT6M9GKekWk0ZVQsOPzqghlpx5i5WOth9wrNhJrIwUXm/hVeQZ1W5Ng/8mU2jBw5AAxI+PmEdHqYNqxCgioE/6+oHAlwOxQbf9SQ1JKbRad+xy8zThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XxGqGQ5zWu+HR4sSayDXeOjmvKqZHA8xBlQY8MwUG8=;
 b=cqsebxVlCD+FCR2kDT/SfGXPCUiTeSzNiJjk2pYd8YdGsQZ7s2ArKQjGIhnJ5ltMcaNFJ8iiSe5Kfh1EOGvINOpw6jEAsmzWZW3es91Jc4lBNV8HwYEgASZdj/1vY6MuwV30EU09iF7Os+PUqGYVzLSdmv5sd8wL0YkuaBvcMv6rgcOLuz0F0krxufsyhR8Mq3chMk45nZaoklXwslTowX+LpwiZfd3pZIDYBDMqkRlHDyqGR2dDPuHPxRKPzdwae+sILUlIQLtejVAxabNhSAjuViLkyOtI02DCJloDx3fesTp0BrAI83OcP7yNnSCt5KHMhJZP/Ae06SkN4fMd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XxGqGQ5zWu+HR4sSayDXeOjmvKqZHA8xBlQY8MwUG8=;
 b=H2hAJS/pdpPKpaQSB1gb9mdKdWBiUoxHUKBQoyhmX2XMWLPb2RbOM09yRtchfOnne1vy0xQaD7kBi6DRL+fdrxrz7V9xsUNxg5BJajhGxtucEirEdZfpMYjug50BOLCNMI3xPUn7McvK4nQyqOlVWy7sVjobnIltSh3mLHRS5Q0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 00:19:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 00:19:11 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 2/3] hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
Date:   Mon,  8 Mar 2021 16:18:54 -0800
Message-Id: <20210309001855.142453-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309001855.142453-1-mike.kravetz@oracle.com>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 00:19:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f850c1fa-c1b3-49bb-265d-08d8e290f606
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB454110A1A3A16DF2F015C77BE2929@SJ0PR10MB4541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9t4bkTXnhTjTHKNQdYOdENRDjiKPNn17ahBExIkocsEtqJacmsiobIkoUAp2MxWDkns4/xK0N32mq4QwIusKJqljMfr5l0oZu5lk9f7qkJau3O/xp+ZrcENQk4GuFDxyDIwGijl5+0SFJ5RAS7zEuXLSjx3my2+w9vEMJatTLUBZawDxERj2+FLqovT3F5os2PckQchNhQhtX0VtLJLhTVx5ITnA8SF3cA6BmX2Zi7gnxkggrdvHzOxImYZa3TNfnTCGcPZLhMI31CX6nw9QRpEoHqCEekfL3KkRicB+LkzKte/1s2GumGjKqJOGN6wYfWwDmdPCRBuDNDBvQjrVk7ALJDIQN6qHkSo5mWeNIKW8dJIVtPpK6xC2RkmlUGDTVACplzUTlyYJTRE+3OJmEXpZWi7hDBwcZYfTuMqMbi9B7AbgmpaeYvtXVdX4AhutC1RG1q/GAh0zpzxcoivx/hX9rxdHq7ZDTwGPtg6zKq0+wQqMnFNJm7D7FLXdZhasyerYqRd4nTSXzzXNGxQcWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(478600001)(2906002)(66946007)(186003)(6666004)(7696005)(956004)(1076003)(44832011)(26005)(36756003)(6486002)(52116002)(8936002)(66556008)(4326008)(83380400001)(16526019)(66476007)(8676002)(5660300002)(107886003)(316002)(86362001)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HLzkU8nUPzd85RnE2oGala4iZGdyKl0eTaMbwWl1bzm0PqBPBMpsiaagpQO9?=
 =?us-ascii?Q?veRBG4cutmpUnfFGeZOHp4bsjaPVcaylb1gsE5GZn9YomvPcrVULWN8I1oVl?=
 =?us-ascii?Q?3veuVdXifivaaZq/QQFrjtrDYyhGUDhvF0PoVp/uevxWiahK6i2755Q6VyHk?=
 =?us-ascii?Q?WXIxFot9KPcsje1V+H07yTCErZeuybbXzauSK5P7nk1oj6d4YIcMXlfnSAFn?=
 =?us-ascii?Q?SjOrm5IfJpiGbFybyn4X2opjwjmLwjE4/siwDF0nWXmVrmtkMbPJFcoTf656?=
 =?us-ascii?Q?nPRt4vP/mMh1MbAkh62ibSwVvOEosob1+zB68yHnZ0HmM9pI/P47Y3CL58SS?=
 =?us-ascii?Q?nBHWCQ1UBXLqKfudpbr0bn65Gu4KlMxlPxyZJuV8iBNnIQJfCiYkX17+Vmcx?=
 =?us-ascii?Q?1rlwuyTvO5X1Bja/Ffq/Kjw2JTxQ/n21Xw9e53sDjTHFt+BpTy1IClvV0f+1?=
 =?us-ascii?Q?17+spmGp85XWz7ImTKNp9X+inRGVhZ79k6GR75I+AKXbovR4Azi/6RZ/G7fn?=
 =?us-ascii?Q?Z2SYQ1m1N76567WAHy+jYLOUYH6tfoXNfcKHgkvyxFgHltnw7Om+upIr1khH?=
 =?us-ascii?Q?pxm5mBmhDV+rYUyIfSuljHCLvtWXi5G7dvLYiRIKZzAVVdSkSDNyovyPGC2t?=
 =?us-ascii?Q?FZoXaC0FsLYL2ybx7xt9XVmKXrlhrBe0nVysdDXtGM9lMD43T7Faif/I2sxS?=
 =?us-ascii?Q?+k9y7RkIx3owLgOdsZ/DsXN/q9DD9UROi22kIXt+LKseGa4b58dufgXjp7Of?=
 =?us-ascii?Q?IMVWzhTCMGPjD3lOAjBkFLo8DuTG8bSvRou/Aa6MTTXCUAT49iMU+T2iIjdH?=
 =?us-ascii?Q?cOqPADILxvU5ocwDqXcvognxZkv0twoaTP/0NLM8b5dVAbuB4+ZQPlXHWdvG?=
 =?us-ascii?Q?Zis+1aUql8nYjkZKCmxm9g4kB7o5YDS0Nr5z5o/qVUSZR5Elq8SZ5Fu8QpgP?=
 =?us-ascii?Q?4lQOUofinjmngoXUVbqjVSorCyVL8wuHZgrzmm8eFiTBMnx0YEb5JscKTjv0?=
 =?us-ascii?Q?n7GwzpzCEJk0ekCIEdPf2D8Qbva4F4LEy7XI53A9f1lRSmVLgZKs6/1HHgJa?=
 =?us-ascii?Q?hxL5IzN1GSS0iQ1CEBvOY+AvAzC5dwTk+j77c+21nJy7n153YJCZHd+eAvn6?=
 =?us-ascii?Q?lY6njk6Os7tLGUGD15MhIVfg2OVJvrNhn5MYw15vsPWPr0tBx8WvGGJBJquk?=
 =?us-ascii?Q?wZ4EQ+q/VCwa53ofvCJDiFKuirlOjJoryy6Y8t5TUNEl/HztsaHRpd7ZGD7G?=
 =?us-ascii?Q?9i8eYoB3j4FYZ/AVCPM2ZmRWjOuyhoDy4aNtSTM2Eb0XBPuL6WruQbIobqoO?=
 =?us-ascii?Q?0ECyacTk12YNuBMfV421UZUC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f850c1fa-c1b3-49bb-265d-08d8e290f606
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 00:19:11.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExnFBQtLVedTLpCqZmRlzv6oGWI5Yi5QC3RYP1m+jeswK4+zijagLStBZyVkz38Uyt/vgiqjkRdqieuGWAMBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When huge page demotion is fully implemented, gigantic pages can be
demoted to a smaller huge page size.  For example, on x86 a 1G page
can be demoted to 512 2M pages.  However, gigantic pages can be allocated
from CMA.  If a gigantic page which was allocated from CMA is demoted,
the corresponding 2M pages need to be returned to CMA.

In order to track hugetlb pages that need to be returned to CMA, add the
hugetlb specific flag HPageCma.  Flag is set when a huge page is
allocated from CMA and transferred to any demoted pages.  Non-gigantic
huge page freeing code checks for the flag and takes appropriate action.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            | 27 +++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5e9d6c8ab411..b4ec2daea5aa 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -498,12 +498,18 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	modifications require hugetlb_lock.
  * HPG_freed - Set when page is on the free lists.
  *	Synchronization: hugetlb_lock held for examination and modification.
+ * HPG_cma - Set if huge page was directly allocated from CMA area via
+ *      cma_alloc.  Initially set for gigantic page cma allocations, but can
+ *      be set in non-gigantic pages if gigantic pages are demoted.
+ *	Synchronization: Only accessed or modified when there is only one
+ *	reference to the page at allocation, free or demote time.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
 	HPG_migratable,
 	HPG_temporary,
 	HPG_freed,
+	HPG_cma,
 	__NR_HPAGEFLAGS,
 };
 
@@ -549,6 +555,7 @@ HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
+HPAGEFLAG(Cma, cma)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 161732ba7aaf..0c29b7d0d469 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1261,8 +1261,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		if (hugetlb_cma[nid]) {
 			page = cma_alloc(hugetlb_cma[nid], nr_pages,
 					huge_page_order(h), true);
-			if (page)
+			if (page) {
+				SetHPageCma(page);
 				return page;
+			}
 		}
 
 		if (!(gfp_mask & __GFP_THISNODE)) {
@@ -1272,8 +1274,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 
 				page = cma_alloc(hugetlb_cma[node], nr_pages,
 						huge_page_order(h), true);
-				if (page)
+				if (page) {
+					SetHPageCma(page);
 					return page;
+				}
 			}
 		}
 	}
@@ -1334,6 +1338,25 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 		free_gigantic_page(page, huge_page_order(h));
 		spin_lock(&hugetlb_lock);
 	} else {
+#ifdef CONFIG_CMA
+		/*
+		 * Could be a page that was demoted from a gigantic page
+		 * which was allocated in a CMA area.
+		 */
+		if (HPageCma(page)) {
+			bool cma_ret;
+
+			spin_unlock(&hugetlb_lock);
+			destroy_compound_gigantic_page(page,
+					huge_page_order(h));
+			cma_ret = cma_release(hugetlb_cma[page_to_nid(page)],
+					page, 1 << huge_page_order(h));
+			spin_lock(&hugetlb_lock);
+			if (cma_ret)
+				return;
+			VM_BUG_ON_PAGE(1, page);
+		}
+#endif
 		__free_pages(page, huge_page_order(h));
 	}
 }
-- 
2.29.2

