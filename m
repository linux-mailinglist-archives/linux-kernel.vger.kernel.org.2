Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68641425A92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbhJGSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:22:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4228 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243603AbhJGSWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:22:01 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197IBips020977;
        Thu, 7 Oct 2021 18:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=k1gSGNFr2IAFYHqvcKNZGTQZUar5E01BP6TqHAFUhKg=;
 b=R8G2awi2pyf7eq6KbL9W638FQJRD8/0hrVKJjWsPLOqgpL4Eb0BiE6Nl5xbd3OszurLY
 9CDF+0qZ8J5RKHjFNlQyDMFX8LlU55QieSNUeyJ+RDYG8c/Sv2ztvhx2SnMCOUht2y3p
 zQYFMxrdMj+ZtwsN7XOlrRPzs6rOQrccXqvQHqn3Za3uQoOtfQ3qV8k3CDavY/SaJqIx
 r+tDwzd/SV9iAKHWJdbYSitLIIS8tDrx7BJ/u/uc5DxLEBBjkBehYQmdibsM0pwTo7do
 2+fcw6jm16tiu3TUg6adhHEZBmPh+jEIOiG1htm2KHFJekcWoZqs6fi3xvNwl3QGe910 ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhwfdkuje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197IAnt5177657;
        Thu, 7 Oct 2021 18:19:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3020.oracle.com with ESMTP id 3bf16x914v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfYQDNkeRF/HgkM/yvAjTxU+6tmMZKG5SB24jaFewXiR/QJkg8VcyoMz6heJaDAnK7ciMdyfQ7yNi0IBJmUjtsWld3hFblP45pyyqsxvtNi229dcVggxfOfsv0IOTzHBcZaIKQuAALfjHlTtLEGiF9sVa7e0fSEe6y/nhOcxDNExyQNVBmKGX0kyCLa0ISCK6FNu+UwskP3h3xopl0rd+N1jk1JLMTcsPIRIRpTT1UotGw8pIvaKuQyoQh/jw5DPjkEitbxbQZCzF8ToqcYvV2GGPEeM4gqqmJOn8e/J63y090KMlCPVdWXVHVYOrMVUiRWDwWQhCrOljRpwTHEcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1gSGNFr2IAFYHqvcKNZGTQZUar5E01BP6TqHAFUhKg=;
 b=j03xYWgWsiI/B1ivnoFB6RiooO5Z/MER+0kp6qnH/TJCGufA1s0WeXsdEwuH+sT5MEu+7kfB3wouDlO/foZ8HqRmP0cMc1w4zwYRuFxS+IMNsAbpT51lOo6/4g55TGbLJmh4/9JuV57aqZGybjcOOndGykXL7fnOGRv5h2wWmirNKYs7JumrVFovuJS+DgnJnvcV7vUXtA79Y4FCV7VIx51DCuqGzwVLipmfkznYvciXLyokutbFZpW7K2Rj8NHVmBPvB0ZeR6fsAWasFFQjmMX9uZwJtm/+LmwCoXfkMOj5dvbXFOaG5KXsm7yYFpEWKR+4KDuUY1aQtT6kvkDfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1gSGNFr2IAFYHqvcKNZGTQZUar5E01BP6TqHAFUhKg=;
 b=L/4fXMgsx2x7u0XI/fBM1bAGAtP+ng3EFBC8RARQ3QJipS+qMFas+yIf+JvlvzTSbBw8oE+zbZ6nTJZLFRuNTNATzJnzs3Hpsr/n853spw2k5VFt15YXMfSfPkDn7pYufdPS6b4OE5pjVdA9Op/J7qbx2Xr//lrf9F/hLJIdQHk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 18:19:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 18:19:44 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 5/5] hugetlb: add hugetlb demote page support
Date:   Thu,  7 Oct 2021 11:19:18 -0700
Message-Id: <20211007181918.136982-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211007181918.136982-1-mike.kravetz@oracle.com>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 18:19:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70f09238-7147-4cd0-812e-08d989bf0965
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB255275BB1517213B360AE422E2B19@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oc0E0bfM3q1W+NSAY8MnGMuLkm4FExQmaaj9Iueifn0EO5GvLCRdArP8zyKUK+cnkR3aIYLBVUs2cAE0kvk0lf7f0BlM5r8d34BVlIKiJ1VBY2ueUnR+sLsBQbmAQlqvDTbJizIk/EssD9F8HxHy/MbA07EFrV+fLCcuPaBtH7uGpA7dRYgoNmQ9mzNNbnADDmvxhEbTVoYKyXX1G6nXnRtpOpK+7fUCG0GudlKaLV+hRiAZbGmBbloMO3AP6qjM1FRy7+Dwj3GUGHUSZY0+CldzM2ZU85p3Jg6BCoP5lS85dKlvedS8CBdNDMtceqkL0CCV0IjvAd+BrJw3fmXlt8a9vzCxWx4Dy003h41g6tgOBig+aGDVQsEVHdDAQ33BLTZA/GNDAGH2l9SHMZVq6nOCs1XEH+RhV0VPQTlE2ipH8N0odR4mcSancCbKPCN8crVKKySjczLFhZapUGVyBzd/qK7mQzKwRfgdQgdkYSF2Cp2eQvTqFGK/3uP3mrURGjst1xYNV74oLeh/08Lk0zpZs7IQAgGy8TzPrkYrM0Sgfrqyxh7tm5LiDc8KQmRgn3rqXeFYhH5zd0vJYZVbC0oERlYA0J4Dt3xPIt8tat2Wxroo+kvPL+tsjn848StsuOpyclvfEzaTGamN5sZf3OyNDeV/pCee5OD3pW8yiR7z5fUAeF/QpHAN3MNNcTd0yK+EMyyeOm/EQC0JiWV5sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38350700002)(316002)(7416002)(44832011)(5660300002)(6486002)(107886003)(2906002)(1076003)(186003)(508600001)(54906003)(38100700002)(6666004)(66476007)(36756003)(66946007)(4326008)(66556008)(52116002)(7696005)(956004)(2616005)(26005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PIdGzAlDSagakaHvy0fnguLaoOhpp9kLYyAa6Dkk67jRohiZ/aVMYjy83Zam?=
 =?us-ascii?Q?HLPoCJ3jxP8NJkpUeuA2IPCeSK49vNqLev6W113vzyvbBL7Aj33T1TPpQFjv?=
 =?us-ascii?Q?72Y/8QUOUKSiol1Ads9yeUWOjRBQdIQQwlPMyphqGxgl1zUHMv3k+l1RfYGF?=
 =?us-ascii?Q?JwxP7XP6pVjkeRDX06EHiRUShXDcQvJKR+teAdptmm11lkKnUb5h163Fsktn?=
 =?us-ascii?Q?HxfYK7s5olt+21d6vvF8bQnAfQShoaFLVt0nPYSrUQbXEbWuIMGInKaoSihx?=
 =?us-ascii?Q?sjhbxEvUiFCZZKOdwY22VNAabkNw2plEdScCffQ2KgwTuhExLJwbRskCJnNm?=
 =?us-ascii?Q?QjlJ0vgpnLwyywROSHzRmTrRAd3DER23/LrAHE4Lu7gb7k2EVYbuNJ+HZsGu?=
 =?us-ascii?Q?mo3KqQEjf0qN7XyMC3FkY5StlKpekoAklZcRDXrSx9SYV3UxJWjztC/Fdi3D?=
 =?us-ascii?Q?VYuEJKpkN7WUKM6fD1Ns0WH0aKbT/cWrBvAeQk53ru/JPSJrNAUViwhsAHND?=
 =?us-ascii?Q?RaTKoVQ5mPzmIB1VSLEugaDWtnKirco2YdmtQdUUueervjsOBCGbv6bUeM1r?=
 =?us-ascii?Q?FrCnNCVllVWGxlvHGI7f6/TMnxuVZEOMS7qdxzSUcDZXmTFm3j3d7Wlg0fNm?=
 =?us-ascii?Q?QggUWsoGwE3ExzsB4vi8aA+uX8/SPLy3n/UWrzndTg5lmsJ4yNeNh+g4crip?=
 =?us-ascii?Q?OSs+91DAIRJnU7EgHJk3ETJzjkBJFXmKCu8ckKBkzGRbtVgT/45yv9mLdoed?=
 =?us-ascii?Q?hn4kLfAtYcFamfsm5sgoSnwCSGwGuApFVF44MaXAAgzNIMs/EEdn3Vp6MwCc?=
 =?us-ascii?Q?aR2DwL9Fb2J5eblJz3Hm321/QnyBnR2FIZl03vf7d8fpnvQm+W2yg9wM63q9?=
 =?us-ascii?Q?qrDRkN+hu+nX6cQ0mi1g9i7a2Lp88QJe8exnN3fwcbgHSQsInqPxShmuWfnI?=
 =?us-ascii?Q?kI1HubsK9QutoJi682EeXLIBGICleXK62fjZrhQKYp+d8+JMBRXWOIyZgKRu?=
 =?us-ascii?Q?BNMVMnMiMdymfnXUmN8NfMFB7SDaByB8ofeq4mKKacG8IggyundkYPjeLXsx?=
 =?us-ascii?Q?FAAz0FzYotKVL4I9j/3/s6zmIvEEw9PMIGcm03Rgw2OB2+gzC69iSuzgJGpZ?=
 =?us-ascii?Q?cgZFkYgmCQI+T5Adxkw1nSFHTQmAs7uzGucOCK9pZUUAulP4UnnjKddhiwBw?=
 =?us-ascii?Q?YfvOzbqUJPpzCqGRaTs3UacwqzrlFuBTp5QRWv02+fy6QO5rIT13ikHDf993?=
 =?us-ascii?Q?/Nl/kZuD3e73KxcScWmGR7GjU9kndXqYoIUQffBlkgJ1dj53CT5JVM+evQ52?=
 =?us-ascii?Q?q6N8fv459eny0vEvO3z7JT36?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f09238-7147-4cd0-812e-08d989bf0965
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 18:19:44.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rOi98N9NhmFC9RqR05NgojdS0jqk4Hhk1cnDZ4XH3ZXOCHXV2iZMi0Z2iKtCjAiQU+HSf4RwLwigY4qvFK7BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070118
X-Proofpoint-ORIG-GUID: hhoGVzZ_e14Tb0pHbGJ8gUhQ--30tzDK
X-Proofpoint-GUID: hhoGVzZ_e14Tb0pHbGJ8gUhQ--30tzDK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote page functionality will split a huge page into a number of huge
pages of a smaller size.  For example, on x86 a 1GB huge page can be
demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
splitting the huge page.

Added '*_for_demote' wrappers for remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page for use
by demote code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 794e0c4c1b3c..22cb6126be7e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1270,7 +1270,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
 		nr_nodes--)
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
+/* used to demote non-gigantic_huge pages as well */
 static void __destroy_compound_gigantic_page(struct page *page,
 					unsigned int order, bool demote)
 {
@@ -1293,6 +1293,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_hugetlb_page_for_demote(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, true);
+}
+
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static void destroy_compound_gigantic_page(struct page *page,
 					unsigned int order)
 {
@@ -1438,6 +1445,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	__remove_hugetlb_page(h, page, adjust_surplus, false);
 }
 
+static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, true);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1779,6 +1792,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return __prep_compound_gigantic_page(page, order, false);
 }
 
+static bool prep_compound_gigantic_page_for_demote(struct page *page,
+							unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, true);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
@@ -3304,9 +3323,54 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_free_huge_page(struct hstate *h, struct page *page)
+{
+	int i, nid = page_to_nid(page);
+	struct hstate *target_hstate;
+	int rc = 0;
+
+	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
+
+	remove_hugetlb_page_for_demote(h, page, false);
+	spin_unlock_irq(&hugetlb_lock);
+
+	rc = alloc_huge_page_vmemmap(h, page);
+	if (rc) {
+		/* Allocation of vmemmmap failed, we can not demote page */
+		spin_lock_irq(&hugetlb_lock);
+		set_page_refcounted(page);
+		add_hugetlb_page(h, page, false);
+		return rc;
+	}
+
+	/*
+	 * Use destroy_compound_hugetlb_page_for_demote for all huge page
+	 * sizes as it will not ref count pages.
+	 */
+	destroy_compound_hugetlb_page_for_demote(page, huge_page_order(h));
+
+	for (i = 0; i < pages_per_huge_page(h);
+				i += pages_per_huge_page(target_hstate)) {
+		if (hstate_is_gigantic(target_hstate))
+			prep_compound_gigantic_page_for_demote(page + i,
+							target_hstate->order);
+		else
+			prep_compound_page(page + i, target_hstate->order);
+		set_page_private(page + i, 0);
+		set_page_refcounted(page + i);
+		prep_new_huge_page(target_hstate, page + i, nid);
+		put_page(page + i);
+	}
+
+	spin_lock_irq(&hugetlb_lock);
+	return rc;
+}
+
 static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	__must_hold(&hugetlb_lock)
 {
+	int nr_nodes, node;
+	struct page *page;
 	int rc = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -3317,9 +3381,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 		return -EINVAL;		/* internal error */
 	}
 
-	/*
-	 * TODO - demote fucntionality will be added in subsequent patch
-	 */
+	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+		if (!list_empty(&h->hugepage_freelists[node])) {
+			page = list_entry(h->hugepage_freelists[node].next,
+					struct page, lru);
+			rc = demote_free_huge_page(h, page);
+			break;
+		}
+	}
+
 	return rc;
 }
 
@@ -3554,10 +3624,6 @@ static ssize_t demote_store(struct kobject *kobj,
 		/*
 		 * Check for available pages to demote each time thorough the
 		 * loop as demote_pool_huge_page will drop hugetlb_lock.
-		 *
-		 * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
-		 * but will when full demote functionality is added in a later
-		 * patch.
 		 */
 		if (nid != NUMA_NO_NODE)
 			nr_available = h->free_huge_pages_node[nid];
-- 
2.31.1

