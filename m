Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F323D1A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGUWZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29892 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhGUWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvG6t009329;
        Wed, 21 Jul 2021 23:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Q1yPM7aeSKO8g+X+N9Ys7mqaY/V7l224/sXdLF0nqpo=;
 b=RCcMkO+CZo+3ynZUkq/ZgBqljz+G+9U+EkzqVkT18Zo3Hj58go0gO/WYTQC+ab+9HYP0
 Upj+Py892NmsfDLcSH7YgYM68ZgLcNxfL5geaYPR0xczspeq4QnKQpYDju+xEW0knsAg
 zZ32YH4veIj1QLFYlkptneZG/eC7CtsD+VWCURPW8DfejLGnrBSYUl+dg+9VZvXLBunZ
 QrnoJ1PRRQRo+uViVo4UlOL+yNZom0E5b64/LqgFItxMCDo8INBpcofpgg3t7hhOdFeV
 0ONWdqni95+mC+P2pnllcyrmsviC27eVTavy8GwhDYPu3BuaAHMd0XJELY8ay+Zz7MTL Xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Q1yPM7aeSKO8g+X+N9Ys7mqaY/V7l224/sXdLF0nqpo=;
 b=R+QvXtu+gEkMZA8upJpCa7/SFu/Wx2hdim+FvF8HQrqxkCMqAt5IzVSm3tJlHFLCejVa
 l8vTxoNy3IGdtWKEYgwCSSCGyw9RSWIQcvG/0LM4ioBupTETaKqng9HRr2MjPP1B24ac
 Cv5Qr0GSk+YuEwUVE5QbBGeFHsPPwUXOt7n/UGxM6UrFkx4Xvq5e1mhkhINl0qw5d9nW
 vZeZedGGTiISjf3eO2nGzd4VPA0FWkulbqzYK95fH0kb7HHHVQjI4g0eHFpwJAFi9ytP
 nAMZgv4bcOHoUfq5netgtDBpt6PIlPHmv84Fa5I3SNKqmynpYHtbMyeLYX6RZz7NHLRN Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xu2fr5wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN0Z0g143558;
        Wed, 21 Jul 2021 23:05:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 39umb3qdx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABtm6yq56IA2Vb3XFF5TqoDpPuhepYuMAX8YHJ6eKoskflY/IptfU82N0ZrxtOPIZV8EwNB/LpmFFeyKz4w9hzOb9VKnI4TWuWJDc49uE+9uNbdmZA4JGArClfKqJPI98NbwHyEE8eMocbbpk2XvINWpIhf4XIyy/TsAniutN3jPddpipkzzMbTRtHGagQoXY/bbpDyL55eIWBQlKUv2dmyPqpu7NXThb78hdtMD9pjbI2fceUeNQW0ph1Q8iSQSsFnQMpC3UrbgvJhSSnw00WknB2VbcMPsMP1gW27aDitkwMYAvc2tBaJnet5dHnc56BnZrXL8VozQILpCmT7LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1yPM7aeSKO8g+X+N9Ys7mqaY/V7l224/sXdLF0nqpo=;
 b=nt/gzVdBauONFalx6dqMKJyTARzbV9NwE0AsBsK0N66xpFSmPcGPscQgKo5scfewEuhLH6O6yjjn1BGeix1vQYNzoVd19givzRTa9cJwJCHsFcxQex2Vywt3mWE3QfYq/fE97UCNwsjG5YXd+68NXQNBL034UZGeW6KFL/GNwJTwj6ARtH3MN/qYlznuJi80TwwItnqbvNux8cv9sZBcr/7IqqILZDgIjNcLqw6Tk16ad+bkSnJDILUxwl624ziYryFpfRZ4O3Xy1z4xiZTxB2r+YcjWLAJW9r7MZUCc+W7AjcUgK6nBTZipopXLei4ds7eOg+GtQPksy7HcLKLoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1yPM7aeSKO8g+X+N9Ys7mqaY/V7l224/sXdLF0nqpo=;
 b=Cxj+Dn1lMuz8F6yQZbt6rVKJLM/AsL/nXjySieufFvjU8gIn0Ss3N1XCFo+uCrjAXAcHiuQyg0hJiOgse+FbHB7vPmdjEa9axXgvM1lc9wEJ7XOVcH5do3ilYE8ZcRrZhKUQ2jRMNNQc4qXXREtgg6IApZzqo9b18tPFRPK80W4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:26 +0000
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
Subject: [PATCH 2/8] hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
Date:   Wed, 21 Jul 2021 16:05:05 -0700
Message-Id: <20210721230511.201823-3-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b493156-02da-40bf-44ed-08d94c9c06f1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB37357A10A77DF125B02465FBE2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqY+U2o6+6wg5BU9l/R8f7KEItPIQiYNxyJms9LJkZJs30lcDO+LcCGh/+TFFRIJN49d4vCiSQz/MHSXYj5q82Stwl0p72CA/8weJ0NuI6kf2qpzkACOpalv4L7UFAG1rZ5FcX3PJTQhE3zezXV0RbaIvutQyuUYE0K6FbXo5ADkGB44lC4EYjXcPN5/b4Ialx7WD3ErZlmqopcivrydi32rIvMewzosi1dn3SqG04X+piSMIDDrfhnLlyy3yOBQNiSZbshy+nhChxcSI7mg1tW+eii8p3lfjRtKCtFcc71dLvXJV6oaNnNuIF9P0SK1bFeRgMCawpzd5BLP3KMf06TmfaMy9e6mHYwAEl4id8v4yX4YezAQlC9KFN572uZMgv5mxuhOGTlYusQQNMI1iFqnn+7Xzy2FaPXTUA2hzF+7xJSGM3T5GDUd29v1grU8yd3uG4vGith6h5MjNb7dRjEeNIHugLTw4KqAvN1Ft9CZZVU2yzDTwhdfcCALSIDFhN49TtrwXcBHaCaep1XbuXpURMpEVx3n6teO9NHKa6hI6WScDgaA0ikyJ1qvz/AY7Re4hM90TrFromq3F9uoyNJwDOB9ZF6ic6TXYdp+2ux7PitJ6sIm7C9Cul+0roMPOUFZ9k0uisYF+8uD/WJIndy7qDqF2XyFaaoJ4Wox932gHQgjc0QqxURiJPSPHPC5xWoAiRO/KQq5dRWrCvqGyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bu2790WppkZgY+Bt3ON0a2uwBSx/F/5Jv1pAnwMP/Xf0RbTQtJM2+4o3Cl+7?=
 =?us-ascii?Q?zDxJHEoFJqG+5GwmEQs1DKRLOehqkup8RDJa8VmdRyK8qRUf1dwf30/lv2pV?=
 =?us-ascii?Q?ZcBL86wvSvGfN8nl6hn5i0oTI2/8lyzxe1B6oIvpMTj/BFnK4J4FlmsjmWXw?=
 =?us-ascii?Q?+Zho85Q9GqeQY0WfSmW9Eiyy264ZB15XPAebvFXH4xAErtJdPlPocnhvlwMl?=
 =?us-ascii?Q?sjZzOv7KWO3Gwik7xRgS3km8bh1da4TAZd1Mv/gpOwndAWRjhlTpwUpPLBLK?=
 =?us-ascii?Q?Ly07brlrBAwTtymbg0UhQdWB4zKNKx1IsP/l0q86mJWWmOaIs6PaWDrC96fT?=
 =?us-ascii?Q?toXO/zPcEGrlUuxCOV3tbMC9ncuMKJxRpsanFBuPRNvunqqW6Z8h3cQ1kmE5?=
 =?us-ascii?Q?xUPm7ckwAM2HWWRSNEqE+C3T/8O6YFVCPGgUh+VDQkryCc3vx4pE7OtnSYhR?=
 =?us-ascii?Q?XAzETTUsIIQtb2Ick+w7MKUvy7KMW+1zLqEJPtU2k6NT13oETy27RDHT2IRr?=
 =?us-ascii?Q?qz8gCv3nFnzpnJjNUViyUmxpdb2JDDu1CdGnzZ9OWTahSRnsnpXldPbPFHzN?=
 =?us-ascii?Q?rWAoo0tQBUKMQFwwT+83em7W9FD4duGVB/O/dpQoBF+KXjqPZJ8UEE8E9BMx?=
 =?us-ascii?Q?gkPGF6XjC3jLzsm7mQqmts/nLAHE4hwlGP2nzalimBHQkmHFoHP2o68HDlna?=
 =?us-ascii?Q?9Gh2ZnUO582sAQUM5eld0t4UJD2T1+lUy3ejYPbKdwXuBVftooWBL0p50yo1?=
 =?us-ascii?Q?cPuppF0J0y2GvrseoItoZW8Q0WOZSfx9DZRFAmRaEKLC6G/P+L/2TrE9khrb?=
 =?us-ascii?Q?VrxGBDZ2IgYJEAqNZGXrQ9T9wXAgXy+hzB87eixrq4ao04iPGr73jJ+rMpg8?=
 =?us-ascii?Q?qDqq3jTiST8MDqAkZTwzCf2swLDO2bBQ6JpWyP7dnS6BpX6Bz379oQ2HdxGr?=
 =?us-ascii?Q?beCBvkNroAm44VSLOIEZao1WvnLhhKWmko4n0gabmHa8h7TyQdPPrlH5+08j?=
 =?us-ascii?Q?LNXjRTLn86mJAHOZjSmHct3RwxsoGPFDEptWs7k1y1T2+1YtpqhvMhnospHb?=
 =?us-ascii?Q?NOf4oJ7CjfGRcNNvu8zWgMMLkIOxHbEXfkL64f3qmXQ4kDGYSJPzyMFfwv7j?=
 =?us-ascii?Q?0m+38NvE7uwFJypJ+acjLnaQQkaTBmaruVT4bBjjlCvB4JkqKIGVFeeXCPmj?=
 =?us-ascii?Q?Z+tN6UqbkSOlkz7+vk+iUlcSAxF/irOrQznfcal19dvgtXa4hTWasU9TAWf/?=
 =?us-ascii?Q?UX1soUWb4BA+SieoAz3wVENgkQ3qHz4Smu9yopqmUW5+rE1U/5U2XGrctCCf?=
 =?us-ascii?Q?PLZuBGugvzmB+AOaaGktEJ8V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b493156-02da-40bf-44ed-08d94c9c06f1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:26.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPHZc6T0KUtWSzjtplku1+r6OGrS+XA7PEagv6btRDtcfjA5yZ6rLX6KhrTFb5fRtVKnrSGuC0CcqEPSXln/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210137
X-Proofpoint-ORIG-GUID: KMrpNXp0Hhay1jtszOXLZBQM89i1M4uZ
X-Proofpoint-GUID: KMrpNXp0Hhay1jtszOXLZBQM89i1M4uZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When huge page demotion is fully implemented, gigantic pages can be
demoted to a smaller huge page size.  For example, on x86 a 1G page
can be demoted to 512 2M pages.  However, gigantic pages can potentially
be allocated from CMA.  If a gigantic page which was allocated from CMA
is demoted, the corresponding demoted pages need to be returned to CMA.

In order to track hugetlb pages that need to be returned to CMA, add the
hugetlb specific flag HPageCma.  Flag is set when a huge page is
allocated from CMA and transferred to any demoted pages.  Non-gigantic
huge page freeing code checks for the flag and takes appropriate action.

This also requires a change to CMA reservations for gigantic pages.
Currently, the 'order_per_bit' is set to the gigantic page size.
However, if gigantic pages can be demoted this needs to be set to the
order of the smallest huge page.  At CMA reservation time we do not know
the size of the smallest huge page size, so use HUGETLB_PAGE_ORDER.
Also, prohibit demotion to huge page sizes smaller than
HUGETLB_PAGE_ORDER.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            | 46 ++++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d96e11ce986c..60aa7e9fe2b9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -533,6 +533,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_freed - Set when page is on the free lists.
  *	Synchronization: hugetlb_lock held for examination and modification.
  * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
+ * HPG_cma - Set if huge page was directly allocated from CMA area via
+ *	cma_alloc.  Initially set for gigantic page cma allocations, but can
+ *	be set in non-gigantic pages if gigantic pages are demoted.
+ *	Synchronization: Only accessed or modified when there is only one
+ *	reference to the page at allocation, free or demote time.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
@@ -540,6 +545,7 @@ enum hugetlb_page_flags {
 	HPG_temporary,
 	HPG_freed,
 	HPG_vmemmap_optimized,
+	HPG_cma,
 	__NR_HPAGEFLAGS,
 };
 
@@ -586,6 +592,7 @@ HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
+HPAGEFLAG(Cma, cma)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cebc6dc353f3..d034a223d5d7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1262,6 +1262,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	atomic_set(compound_pincount_ptr(page), 0);
 
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+		p->mapping = NULL;
 		clear_compound_head(p);
 		set_page_refcounted(p);
 	}
@@ -1273,16 +1274,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
-	/*
-	 * If the page isn't allocated using the cma allocator,
-	 * cma_release() returns false.
-	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
-		return;
+	if (HPageCma(page))
+		cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order);
+	else
 #endif
-
-	free_contig_range(page_to_pfn(page), 1 << order);
+		free_contig_range(page_to_pfn(page), 1 << order);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
@@ -1301,8 +1298,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
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
@@ -1312,8 +1311,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 
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
@@ -1470,6 +1471,20 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
+#ifdef CONFIG_CMA
+		/*
+		 * Could be a page that was demoted from a gigantic page
+		 * which was allocated in a CMA area.
+		 */
+		if (HPageCma(page)) {
+			destroy_compound_gigantic_page(page,
+					huge_page_order(h));
+			if (!cma_release(hugetlb_cma[page_to_nid(page)], page,
+					1 << huge_page_order(h)))
+				VM_BUG_ON_PAGE(1, page);
+			return;
+		}
+#endif
 		__free_pages(page, huge_page_order(h));
 	}
 }
@@ -2981,7 +2996,8 @@ static void __init hugetlb_init_hstates(void)
 		for_each_hstate(h2) {
 			if (h2 == h)
 				continue;
-			if (h2->order < h->order && h2->order > h->demote_order)
+			if (h2->order >= HUGETLB_PAGE_ORDER &&
+			    h2->order < h->order && h2->order > h->demote_order)
 				h->demote_order = h2->order;
 		}
 	}
@@ -6496,7 +6512,13 @@ void __init hugetlb_cma_reserve(int order)
 		size = round_up(size, PAGE_SIZE << order);
 
 		snprintf(name, sizeof(name), "hugetlb%d", nid);
-		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
+		/*
+		 * Note that 'order per bit' is based on smallest size that
+		 * may be returned to CMA allocator in the case of
+		 * huge page demotion.
+		 */
+		res = cma_declare_contiguous_nid(0, size, 0,
+						PAGE_SIZE << HUGETLB_PAGE_ORDER,
 						 0, false, name,
 						 &hugetlb_cma[nid], nid);
 		if (res) {
-- 
2.31.1

