Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537503D1A28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhGUWZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37706 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhGUWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMuRYr020157;
        Wed, 21 Jul 2021 23:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=LAfpmG+F4us2CJXJQgOM8oeTtf/v302JFO/6wDULhy8=;
 b=InY94sd0DVNL0QRotgCDT7zT18UoHMh1nfP85IlCuTF/A1ujr0uIpZYrUzAsl+zAZpJy
 aktVu9TH6pskdoyyoLfRc2JPqsgjVCLW36JTfvXYF4ggYj0Lp0VVniOrKJvOJoYIfXbA
 nBqbKBwix8hzVps1fxwIyAZDCz7gY9ChRBCd3WxoemoKnS33Aeb+7AO1o9ee4me7F16p
 7mlALPvkUAQP8gxpHam6g4afs8YgBGicm7t9LYCGu8Ruw+mtsrwywcI9rYFJi3qnauYC
 Ut9F8baiIgr5SZmr0y2cvKZCtgYV/jm7+nFNzrYT2685TYlwkz4LLRGlLZ6Woz7k/ytr wg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=LAfpmG+F4us2CJXJQgOM8oeTtf/v302JFO/6wDULhy8=;
 b=hT2lwzHrXxkNOf0h3r1JvvBEdfvcTUyFGxsyNpLZUqybnUYblrnMDBcSdL13wCJZpDve
 lB4igUD4SUG1uY+oXmXqmKkOBzKMcizqQVdktjZ6+8qoEORYDI/yYoJQkakVFF6V1yQr
 vj2AW47taHQvSSS1SV3uLOxQg60n0ReXgcb3veGK5mq0B/pzJKG0AV7cDYOubx5T+Cvm
 5MZ7oj6w6o64RFLczP4Vgl8tFw8/iuLHpgIRH1ET8kOeMBAa0zOnTRZ3tEnBZfllYIc5
 VciEgYtehFViiOjKwoppHRWr+QzlR+IuIsqFnUTJyxpxpfzjTpYYCIsbNvPdBhMhfmtB pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xvm7r0ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN5NPp103248;
        Wed, 21 Jul 2021 23:05:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3030.oracle.com with ESMTP id 39wunmv2ae-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpA3Pz5yiVOe9Nr+EJGnoAVUdwpodQwPzh4BQgOxMnLAOroHditMm/Ps+Kazd9zLxMbfWBWH/ww8Tgqmvy3gmYqLgRzaavjHWr1lZ95o1jJtwwY5YTDZD3GWWikDnF9njn8LROJ504m0bHG+I4Em8N0KH0rxFcWAcnViqNg201uB1TYtBahia+CPDzq2OqLg6uR/0ApmRaBooM4mSuwPUgD7KArDzNGtvHzS7sST7iLVc7/XKWg3D/bUKnkk74kX5y8aYLvwCwex9NxdElWefa7/qosuxhqXm5gipAPNYPdys4y7DaZPYaLZ4uNURF/KORcOBlWWh9YvbcoAAPmzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAfpmG+F4us2CJXJQgOM8oeTtf/v302JFO/6wDULhy8=;
 b=CxDYhdJhOJE2Mt0gbVXhwtRBE7BKnXxVQbjDPIvGkWWFgeW1+h6v6Sz+NdLF0AavSkrzMzznfQqiF5Yrlo+VYSuNyYJJmh8+3OdxQmp+dMRlvRDRDGqZIWUCma3lDucoU9lbZX9LTYINwDl1AL27FPn8FosJpnEJIrlMVuGlpDnY85YuFavgDIvxDav8ddh6+75U4gi7CXqjvvsC7pmSzIcNEqJ5oOEIDQRgcTuMhGbb8W+gBOTnTyRehe0pUAx9lLCGC0BdFZZqVTNpwsEZOGyoivqQTfxbUZrHz5CgAvx5J7yWLuQOP0NnjGdolQ54kUDwKCk/FDvNDrufrIju3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAfpmG+F4us2CJXJQgOM8oeTtf/v302JFO/6wDULhy8=;
 b=ex709avpsBBEMQJRkDINVfMTfeV+oz7bqveysAIjlE4yvkpZggCYWA11fg8I16OR7R3PUmhxElsSJM//zlbGQNdGD4dN9m2luCw8KQHEEZ8UKf6m12CXNOtI9G2NRPjOjc7CN1ECH4AzlachDGFm1CQXcr+qjr0vTjmxcG6ZNGI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:24 +0000
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
Subject: [PATCH 1/8] hugetlb: add demote hugetlb page sysfs interfaces
Date:   Wed, 21 Jul 2021 16:05:04 -0700
Message-Id: <20210721230511.201823-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b2acb7b-2193-48ad-9faa-08d94c9c059f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3735D190F31B89816B0A04BDE2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RGQkEWE11VI9MtMO2rurkrJJbbskmNDJFIf/4DpJFW0U5Nf4RMUN8peaRBNZFlMebRYV69EB1IgyMBBxUp20ylfHMP+pgImvG5VJxthWYW0BNCYw3wsTzQavXTpjw4WWObuhq8CHAtZgwCeZI/kNmYXqXWxrmE1UXzG2L/LwSKb3IxDzNtU0Zl5KZzoG8soJh8rBicDxmLa83ibPM2Z7+8/EoZjvrVgP+yfwBWoFUGm0NjAFzM+xfW5m3+49I8p3qytR81W2sdYKK8bMOKuLpa2U+S0t0zfRlzc1kk6QesoSM3lrNobdy1BNa3yVa0PwI5gueNdYNPB6rfD/Z0LxxhrPmm0IUrYKLZ4ttZAkle42HMLDN49zx3dyJuZw6fOd5jHZQAnLoj0J6qJqlKrtPRcMQ8eObw2+Zd2lMeqhIkCvaW4REvwg3/y3A93uaShkzVQvrFPe+3UcPR+7bJGEO3LXBCNsen1jfuEHvWLqxIGUzF8gXNjs2AinRNzkzj/pcx/tC8sESrTN2/JvTw+VlCh9VaLYcsjag4rg/P8IWLO5t/8/TCl28nmQsRVCVEE2nwZU4mfegpigf7uUEzzEWHp1E2aRjexuMyAGJW/1snsM65DBuemei/pHMylLifKny8A36zSQLD8IFLHi/COrW8RDNf8Q+E4+UrjlT8wHwwB7Bm4JJbdBqgDaFvueRLyI3aaOvl4HiIp3tnTntGYug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/tl+uW4UPMZ0nGaNx88oX1ksfSotmXuSrFndNoYAr/uvddpBdaMvnv/N4cWQ?=
 =?us-ascii?Q?QFpHpt7eX2zMGt1HewrIIJOGl2qf9YS+Wa0DS5m/HsbEuVr1fRsPd5KgYl+a?=
 =?us-ascii?Q?HopsIfrLg4N8cdQSdToO2YpGBD39fyqXvzZW2pihdZSi9nPP+4g2XNo0dNnO?=
 =?us-ascii?Q?3Diy6dmH9zAc4xvSPmNfVAMbVorkcnZJQzUT5Jd8h9WCpgZ4t98YI8Jpztt9?=
 =?us-ascii?Q?/kKqVaNksjVPI7a88RlzfVrtMjrNBWquLWLUD1jKACEaxroxZA5kGF2ihAmh?=
 =?us-ascii?Q?JE1OaLyy1jyHoxtjyQHdhmR8Ze/L+GKvnoC9ocoRldvWtcxWfwSJ3u43GA3s?=
 =?us-ascii?Q?yFNJZ6lStnNhJubDjrHLF/p8QG83k6acJmgeRF3jqXNfI919fRy+HAiofUQq?=
 =?us-ascii?Q?mQ07rOGhvOG5CLq+c4Qk3WfJknNIiFVTuhAIXI6z9+vCmhGDoABtNQWzKPSi?=
 =?us-ascii?Q?kr/LCFZKt2vjcLPeFYZdXpaImlit95G62oAC6Xf7LfNyjYoe7l7m5QFWXKpb?=
 =?us-ascii?Q?AQgfH4BMhIkzkTqr28Q07kEg9JWCW7xzcZClKD/IdiqbMFXL1LC1xh8Sqhzf?=
 =?us-ascii?Q?uBY0RT8VmnKMIXmCXE/41KEHjCj1zgXSd5TGSKrLY6ohrjVGR+SqqBMGarET?=
 =?us-ascii?Q?+ZJq64NX68KQAeEFddA4kwqbKhMcnuQPhrFEvNDxam4PSYeo7uoHRpWD18UO?=
 =?us-ascii?Q?zd8n4UuOE0dk3DwUlmsF4Ulbf8ByPYFic7QeEVpUMNJa/eDI+yXRjWQbEgQ4?=
 =?us-ascii?Q?WytsPLvVrYtG2yBmgQ0nup0sRp6QQMo4WZqOvlws1sWn0hXxryZ6sx1b2mgz?=
 =?us-ascii?Q?1T1p8atPGgb5HjZB5229P0Hwrgd8H2aDycDOAtUWbo2HHBBzeY9znsBNGLYx?=
 =?us-ascii?Q?nJ8k015ngT3FIJPLzy5AfAU50z24Y6W9Qi5iFLrfXdX4OFRELw557KStAIpv?=
 =?us-ascii?Q?2m07UUYG2VAfXO8b30PMQ/zhWcvcqguelqEzvi3Qn9gN4qG2IKfxRBIKsQkS?=
 =?us-ascii?Q?zX8rGgIogF5IDkcgOrXZYezU3o54CdxBFplKH9J25LUX1yvrH6y74eFgIV8A?=
 =?us-ascii?Q?+RSPvvsZ92N7BsSxKFtvoqYuetM5ChdxFbDSZMyKmxJe+/bsVL2Wj9AZBjjo?=
 =?us-ascii?Q?Uenou3wFx93C1ugUuKf/PggwVqTn0sMSfmRf/ErWwb0tyNNzPoQxDcA5DSdi?=
 =?us-ascii?Q?QUtKHC4+KyhGLXXiCsZa/8G+5wtn5aUBw2ovCvu+8RzwQ0BYPZl8oS+iQwRQ?=
 =?us-ascii?Q?zjMs4W60P/+Tf/uLEBzbKDX17QPZjrteHTSknibP3H+fPVJr5HGX3kqqsre7?=
 =?us-ascii?Q?fw7b/acPw1ksaWsw/pcxreGm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2acb7b-2193-48ad-9faa-08d94c9c059f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:24.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQPwlUi0UC104ZZXUhmFPFjxleZvs4C/Gi3ajgah+bxkCIaNYzBskHlApdT6MnQ6iK2V5QfaOsT/r0sh1zVojA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210138
X-Proofpoint-ORIG-GUID: xzlZ6P8GUtB2xmJqjx6e37xyDn5rPiTD
X-Proofpoint-GUID: xzlZ6P8GUtB2xmJqjx6e37xyDn5rPiTD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new sysfs files are added to demote hugtlb pages.  These files are
both per-hugetlb page size and per node.  Files are:
  demote_size - The size in Kb that pages are demoted to. (read-only)
  demote - The number of huge pages to demote. (write-only)

Writing a value to demote will result in an attempt to demote that
number of hugetlb pages to an appropriate number of demote_size pages.

This patch does not provide full demote functionality.  It only provides
the sysfs interfaces and uses existing code to free pages to the buddy
allocator if demote_size == PAGESIZE.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |   1 +
 mm/hugetlb.c            | 121 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a3870ea..d96e11ce986c 100644
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
index 95714fb28150..cebc6dc353f3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2964,7 +2964,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h;
+	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
 		if (minimum_order > huge_page_order(h))
@@ -2973,6 +2973,17 @@ static void __init hugetlb_init_hstates(void)
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
+
+		/*
+		 * Set demote order for each hstate.  Note that
+		 * h->demote_order is initially 0.
+		 */
+		for_each_hstate(h2) {
+			if (h2 == h)
+				continue;
+			if (h2->order < h->order && h2->order > h->demote_order)
+				h->demote_order = h2->order;
+		}
 	}
 	VM_BUG_ON(minimum_order == UINT_MAX);
 }
@@ -3213,9 +3224,36 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+	__must_hold(&hugetlb_lock)
+{
+	int rc = 0;
+
+	lockdep_assert_held(&hugetlb_lock);
+	/* If no demote order, free to buddy */
+	if (!h->demote_order) {
+		struct page *page = remove_pool_huge_page(h, nodes_allowed, 0);
+
+		if (!page)
+			return rc;
+		spin_unlock_irq(&hugetlb_lock);
+		update_and_free_page(h, page, false);
+		spin_lock_irq(&hugetlb_lock);
+		return 1;
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
@@ -3411,12 +3449,91 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
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
+		nr_available = h->free_huge_pages_node[nid];
+		init_nodemask_of_node(&nodes_allowed, nid);
+		n_mask = &nodes_allowed;
+	} else {
+		nr_available = h->free_huge_pages;
+		n_mask = &node_states[N_MEMORY];
+	}
+	nr_available -= h->resv_huge_pages;
+	if (nr_available <= 0)
+		goto out;
+	nr_demote = min(nr_available, nr_demote);
+
+	while (nr_demote) {
+		if (!demote_pool_huge_page(h, n_mask))
+			break;
+
+		/*
+		 * We may have dropped the lock in the routines to
+		 * demote/free a page.  Recompute nr_demote as counts could
+		 * have changed and we want to make sure we do not demote
+		 * a reserved huge page.
+		 */
+		nr_demote--;
+		if (nid != NUMA_NO_NODE)
+			nr_available = h->free_huge_pages_node[nid];
+		else
+			nr_available = h->free_huge_pages;
+		nr_available -= h->resv_huge_pages;
+		if (nr_available <= 0)
+			nr_demote = 0;
+		else
+			nr_demote = min(nr_available, nr_demote);
+	}
+
+out:
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
+HSTATE_ATTR_RO(demote_size);
+
 static struct attribute *hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&nr_overcommit_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
 	&resv_hugepages_attr.attr,
 	&surplus_hugepages_attr.attr,
+	&demote_size_attr.attr,
+	&demote_attr.attr,
 #ifdef CONFIG_NUMA
 	&nr_hugepages_mempolicy_attr.attr,
 #endif
@@ -3486,6 +3603,8 @@ static struct attribute *per_node_hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
 	&surplus_hugepages_attr.attr,
+	&demote_size_attr.attr,
+	&demote_attr.attr,
 	NULL,
 };
 
-- 
2.31.1

