Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A603EE019
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhHPWvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19922 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232444AbhHPWvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMllYs031286;
        Mon, 16 Aug 2021 22:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cNHjsKEETFPtt238FV1F88IbK5MVdUjYRpFBkGQe7mM=;
 b=PJZFu1rnUCUcwtPQMvAulSh3Yqp7U6E4kxqwiTn2//fL3Mvh4SwK8dh27+telaWDVlgY
 5MbE5ciJiDUZ3kv/jzMNgW0rceqi/soLMaIGKkA1o6oKHX2OQzlPa4KKpe3YTdDFpT7O
 aA1Z0FNqCRyeqUb88WgCwUkOdTfEptOxHmy+iHnraZtFJI+YTnSma9X6iFnR/h50p5FT
 IWG3ZO1AtwStkuP3SiLIJuEVhv/1JjTPcbJ6198ApwuWMxlGTPR5u+PoJexTS4UBc3HX
 qC0L904tOxxH/ws5k4ZmeUSaZR1uxTZ9kW7Di/tyZr0HM3m9WEwfCtrwZ8dU/UxNUipU TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=cNHjsKEETFPtt238FV1F88IbK5MVdUjYRpFBkGQe7mM=;
 b=E79QKqgnScqeX5r72k3r0E+MKjTz8BoST+5XXZ2UG312ECXN+XhhSW2HRRC7AfGFIkXm
 a3+DT5Yz/PDjQPzA7OsOczIYqojsnY3iQno1A0SJgy8LFIZ1wbKVVc10hQYKyk984xVT
 mWULhHd7bULie2kBlWkOnFNpR7UIGw3RUm3/Jnsc0Vxc91VL8RIGswkp9nHGPLyUNy3J
 qJleU0+uwRDDWm1mZjRAF+EcWz7/MHi0zjRiUVTUDm0UCNSm0jPbcz4QzfUC62e55Cza
 r8c69N787+M46UbObE86L48C0V891i9DrRYESFh6iX3kN/SIZIcIyc8ny15soHHu8Ba7 Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgjb8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMiu6I040104;
        Mon, 16 Aug 2021 22:50:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3ae2xy13wd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFFzBn/KtJcnc/eFyG9y2apOzBCk/PzqgipIHfxu0zTUad+/K3AATSv4HKH42t45bmIOPMWkGzJr59wmd6bdwoJeHzxfueZ8GhWqyl/ntP8GFLU94fYPcCf/Xd06HWrhV2b8aCtXco9SRr0jToMMmiiz0n8S42DDHPJm5a9nTIWEDIUzQMR2qOvklRFexZrAUP/uJPJoGBilAO/qtgj1m5aWlNvAdOocWqtgbntuUxbDfWrjdDUS+8Fn3nTaEoJhWb0XbaHXYxIxJr+mbG+LMmnZKsZ3ckj0zxOA9rXOIBuBMpWo0qip8SSR5JIQXpMnCA33VAFhYAIp9L8G8Io/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNHjsKEETFPtt238FV1F88IbK5MVdUjYRpFBkGQe7mM=;
 b=EpRJHaLDb/TzQVU03ERv2I6CpghJu+rTygdfXgZ/OHCeHHOzUGNCozN5Ae3zqDOAvxa6YEMPIiHP5oRvLAcv1eQl6Q/wDEd0ogEdHqKd7yuB06tKTZwHO72fR6Wn1QG+ieLX6RtyrBb/wVl0AKp9IK/M0eK0Fej5p4PLjOaxd89DkvqcWxMS/wXsO/5aleLEzS+nN5cPp9GG3+48KvVPkHByXkNOSdze2yx17fc6fCVqEaf9X0x3zlQiki2Ze4czELK+5re9wG2UrAS/Rrx4SKkvEXlKpsO+w7nU8SSm80Ge0rvcoYKewddIHKW4XV886pWhKtVvlRi4WUNWXrW3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNHjsKEETFPtt238FV1F88IbK5MVdUjYRpFBkGQe7mM=;
 b=DmPL7HXenVxaO2gJ0BUIP07SkKG1IyW03/vWSK0xt4KW+EXZlDMgMJopOFxQCmLw+h1IXjVMmlc7syysxe8KtAfOrctouFRAqaJ4ATntbHTtqVvac01ihD9WBUcsIzjWZcLCGexTVRRV8qWd88vquYMS+6RaEKdMJAg4Fxzcqjc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:12 +0000
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
Date:   Mon, 16 Aug 2021 15:49:48 -0700
Message-Id: <20210816224953.157796-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e1fe214-46a1-47e2-8211-08d9610834b4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB339791B9CA90853D946975E6E2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmeihMVwqPB4M6deD4qBJIU1KyOgwyoWbMbHQL4BKuT2xi701YO++HFLgYXXs7i1egnMUL69FUdrjwhUOhPjJ0UQx8imfWjp5S2las68hJCMxRirZewMqsindl6U9vZbioUtBrl4/7Jpf+85y/DpFvjFsjgN98x3wyrUYkwdislsPVTX/X2kTgAT2nYzKLlwePzyqX62p7mMvjE4ygdZ0vWm3UJTP8jb4kRICpZB3Euoh815C2S3V2Td8makyxcGgbIfazYfDykur6amenJT1g+pnoJ4Xb/5wYldIWoqaYNV3k+XaZiPdD6E7BEx+0+zXp1oDNSIerQ5ZTKeVNfOW6kpyGGK1cNXmdb0mgvqqHBeUmsvoRjUb38Lj8pi5z/pwOngJI42fvxvTys3qORS7gNErgfvSl1SXBDHFSV8NLyC4PJC/SRYgLr4BJuYWpaijasXoDruM6r7bagqQK0b+ejeLbY7zU2dnuxOxKsZM+l/moertPd0kanFVT4ju/nvrfdSX2fVIa/AE2CMyNIim0M2Sey/VPEjDKpULk6P3/Y5uStq9iX4+7tTXK67tspBDKxP0rRCyDRBsyWgMx0+9+wE80GS4tKKJIFATS+uUsOXXBscFZxR16CYrm3H+yrlA/wFpP3s09EgXgZRitmNrnbWvUscAS3XwnP2fATlAvbfypUpxUkge07De2HPlx1UEHPemJ1ahFwMRdkW8VOfmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PTW3jsx2INRAWbKO/G4vosir8kd4lfwSO6to2g/MR7Gmryhw6ydICGrF8krk?=
 =?us-ascii?Q?hLCHEUS00p/TOHbdL846LL7uG6jtZFwknATTgIKcYgQ1TXXo+n7SE6JgMRJY?=
 =?us-ascii?Q?m9oEix8XhNdwONKnwwkBg4oesKLWBZPujJp3ItHqCGDsqMyDlpbq3qC6dtsQ?=
 =?us-ascii?Q?JWlR4N84gNTWiHa95VrEEl2Qo6kAGsTHspac8yi1alLnryJrQ0ED0aNBn4ux?=
 =?us-ascii?Q?A82mAYj+eVWtydl5V6hh1iqGBiCvaQSxetYnFd5+YXQpUB0gH4yGW7OWkQG2?=
 =?us-ascii?Q?3c+l9mEq/HE3+f8b1sIQtsuTi0sedYjXrQJiyvaNaapp9SYKhCQNriB7G9d0?=
 =?us-ascii?Q?HaG9QtP4V3qJHcDB0u6JdZHcGTCFhKKAq41gM58XaAJaZH1EQEQJCwFdTJkG?=
 =?us-ascii?Q?YeJRlT5bbuUWm10dlFkmw9IbdWYKk6HkR936M5muJ09Utc0pO/hyDF145KU3?=
 =?us-ascii?Q?KKfyG2AXBEUghPGsfeGdpxIG3WGf9gZDX5BtO2avJQK08LfUksHpitWQXf8h?=
 =?us-ascii?Q?JbydSVUqTD0JKxyVl0cU+zGQ7XZ40m4P4SK3Pm4hObC+WDafs2apO6EjWPf8?=
 =?us-ascii?Q?hMCAf70DxhFaHlcRMdsUKEkBVqQBFxudmTPrB0s76YQza9dRmGgZAD1X+2py?=
 =?us-ascii?Q?FnGuW3x0jjczbOgOh8SowblMnaUQjfJXufBScJzWSIJZp8MhOxnNJSHbY93J?=
 =?us-ascii?Q?7FBybpHLhY9W48qoD773+ATnzOYQGCFB0X/mnLHd9OlzsVCQcU+4nI963U1e?=
 =?us-ascii?Q?wPzDhFu+C2HhMXd1N0a/UG8crmAFxb/gg3SpxXHkiq6aeWQGy1BagtbRfm54?=
 =?us-ascii?Q?G4E+az+ZGCRDe5hC2yV7lF6Rz5b88w0715TNVSFhk2fOqNMNWSx7niPRJpdR?=
 =?us-ascii?Q?GTMsmH/4Mr+Ua9R2BegMXa5ewtAKja6iV5VeLFAssoqH/uE/lXTXHWpDHBhw?=
 =?us-ascii?Q?SbzOildlmU2WxCXjKcjAY4w3RBYJVgHCvZ8agNL0ZQs0pLSxPd+Tip3+prg0?=
 =?us-ascii?Q?ni2y4VO4aPYahbwgBuImLN6h9jzsLk0bfWR3YlibkUTRcDDgExPMEdFhqbla?=
 =?us-ascii?Q?Ze+vuEBd6QeJKMdFD2NkYsayKySyMfHwcpnuN5EReb3i4UbPtMoN4PiRGmBf?=
 =?us-ascii?Q?VjkpfRlOBmku+zUPw9AHqO1iLJjuD5SdLo2W0tasIY9KnpPwbZeSqbyozkSZ?=
 =?us-ascii?Q?oCaxorzwOdhPwMq3/Wgzl6XPcHNx23ZqKlEKs9aKA/k7Vxh9ZuTOIRkwZPiZ?=
 =?us-ascii?Q?d+WdfO63M/SkhXBa3SPYeg/vTjSrifbD7LoA3mfbfwO9stNwqqr5XKc1rCbz?=
 =?us-ascii?Q?qUiRfuU/W4BqYi4WocpDRaY/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1fe214-46a1-47e2-8211-08d9610834b4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:12.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8B1UsXFm4DRf4b8s4ZAE85oMMBVWzUTKM1WE/OcUr/ZxZT2BTH76Ce8/c8XxPSNj5aGW7twTYEuH/yasRvaGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-GUID: ZDqPjs5Lb4l7sSJ7rYUm0iqv7m6VnApE
X-Proofpoint-ORIG-GUID: ZDqPjs5Lb4l7sSJ7rYUm0iqv7m6VnApE
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
 mm/hugetlb.c | 54 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 47b4b4d1a8f9..2f2d5002fe73 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1261,8 +1261,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
+static void __destroy_compound_gigantic_page(struct page *page,
+					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
@@ -1274,7 +1274,8 @@ static void destroy_compound_gigantic_page(struct page *page,
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
-		set_page_refcounted(p);
+		if (!demote)
+			set_page_refcounted(p);
 	}
 
 	set_compound_order(page, 0);
@@ -1282,6 +1283,12 @@ static void destroy_compound_gigantic_page(struct page *page,
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
@@ -1354,12 +1361,15 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 
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
 
@@ -1397,8 +1407,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
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
@@ -1408,6 +1422,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
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
@@ -1679,7 +1699,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
+								bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
@@ -1717,10 +1738,16 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * the set of pages can not be converted to a gigantic page.
 		 * The caller who allocated the pages should then discard the
 		 * pages using the appropriate free interface.
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
 		set_page_count(p, 0);
 		set_compound_head(p, page);
@@ -1745,6 +1772,11 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
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

