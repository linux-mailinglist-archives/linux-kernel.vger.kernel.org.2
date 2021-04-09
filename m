Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7176935A82B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhDIUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48036 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhDIUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KoO7L167119;
        Fri, 9 Apr 2021 20:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=/cs++IFL2HEM2BnhtMJRQEt6gwqxu4GmDQow6+W7nz0=;
 b=QRubzLQ3hE8bOYhNxIhwlC2mQt/IiQn5v/oUhn3PBRx02cmY5k9yA17wjpdoKsraVjpc
 /8X6Cb+GtwsUufEXTRmGjBqS+kS6vnEYii5Ha/1CFpjwoaFTaBosSeGXACNKFqN7MZ/U
 ApSlpNCGJKMOjnGbhKhc0ipb9u2ZF/hwHIFyTso0kWBIIvXi+UcUIo5S3glY7+/Hotgu
 emjGfvBcTl/xx8+MBBDl2YOkNQrZ4hHwUnInFMpeJv/nAAiRpdulT/79bNsdLGtpv4Md
 17lL4X8ySqLkH63KDEfo6fVgiXa7YxN+/G5pHIRRke9/GtZEJ+LukH9G/EkaF0sUFHdE xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37rvagjqf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KjS6D174400;
        Fri, 9 Apr 2021 20:53:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 37rvb71qqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExWseDeAbLk2g04rm7udU1Rz47gkB60G1GOO8aoaQMlB7aQymMD5Wm8p4krGz1u0EX4pdG24fXVReAxYqy1Fw56VQli4h5fgeFoSFb9vM32QHpze1rKkKJCk9VydIXpfCo1nCEHFWGJpQXUP05OLfNIM8Lb9PVeJkGKOZJnF989EVdisSuxP0/Q1w027GRMHnWpTbSXPPVDhPR5b4aTTl/01fFbC5+VBn+1mdNcGenC6EHaMIw8sJv1oONHiBtU7BTrSzuBnHK74b9ZGv6wd1hX6sB3vyT9UotnaZpsWytCn5iLJgY4d2AKSMpaF8GyZDEcorTpM63MWOqvVwJmdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cs++IFL2HEM2BnhtMJRQEt6gwqxu4GmDQow6+W7nz0=;
 b=gs7W6zSDW8S2Dt9iUD7PTmke9L/734XrhhL7ElS1QVPzPpLHcu2LATSKTTIW57cJ8dqXav3ssKr7LTGUjCvZDqbagLudSLa3eX6UCHEF6y1sdH8Ji0irSqsIJFlMV0f7zl/K2JVTE9btCoApmkR+lJAHng9AulA/u8zHfCYXvRNRM4QvwfojDP0gP8a3iulY5FjoxAsimYr/wrOuLRHVGK3CfyJOVg+5nFLV0fI2xGQvwYPhs69taBZBb0tn0dMtw/SHMX8tWNtb51IjnrmdlPAJU+5+sQnRU9Ez0ktukTj3jnxIkTLfNmqCk6wluc4MMGMlmkq5pWeRtogUg41c7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cs++IFL2HEM2BnhtMJRQEt6gwqxu4GmDQow6+W7nz0=;
 b=kvH4jE0dqEIdJj8omdpvWFFRGZfRRr9ToWeVoHuXStQ5I+1iclX/N0TSx0VA5URw5ZYeINQZrx/VswHhdB326zG0RBz8OeAcOpeAAjCd0FROkPsR5GIseXKRaoDNPgKgmnBuAYrL2vhvZmJX0et+tJULf6aBsmKq7IwZTYSZKT0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 20:53:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:22 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 6/8] hugetlb: change free_pool_huge_page to remove_pool_huge_page
Date:   Fri,  9 Apr 2021 13:52:52 -0700
Message-Id: <20210409205254.242291-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409205254.242291-1-mike.kravetz@oracle.com>
References: <20210409205254.242291-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eaddcd4-fc7e-41f6-4c58-08d8fb998367
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3972942D63F8647BC4C3A6D4E2739@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNh6k9Ul+T7APtIiIJKFV4IKDCkYoithnKLqYdMoHRlIjF1e9JBChdBCLCsayKid7YAyvpD89rAycU6A9ge0am9C0pD3hkzuvMmKSF5Kbb1qeKWO07FT04QOB5uDCgyzut9E+ngF7+Vxg1ZADAlVvW3GgTjGXuieX8FijQDfiTVvojDeNmuIVHTHdZZMsYGP2yllO4/zFo9FGYUCjtyWGDXKFx7kcGgE/6CnaOC9DH15SOg88iCVt6Ng5EEOue8ovMFJAMfi5QvzMPHoTwPBDt4RjFRfrMlmrinW2RWGml6EXH3bh99gUT5pO+zDmE28xOFIGYal4hgms2v3rTvcQg+WGSgYXPfq3qMI3zy9vpAqyMfvfqmoctETRbM5e0hyASEt6G7YsUp6gp9GPe5ivXJnMsEUTTNrSPoBGmyhgW1yvEz5YLMX8TfAS99XLKer+xsnH3JeQRKAnB+eHvk7FWgkXDue5yrxe01hE7adzhb7Q8O6IhGIGlirw2a16pj97rI1RW9LrdjLkxQpx0YdqqLrjDJyEFGS8JOxRqfgL+isWYGFjRpNHqzwO74MaMEA89PsIx+NHaj+J5CtxqH5antVTgZCt2XWFmCsjRfrHtCCHHa0ApZspA/Ch9A8XmRuo599VRuFY4ueLGkFOi+1mJsUB9ik+tWtZThq/tVqOK8oyktWIN7OtEtW4C4v2nCupm25YB+om4urkkDOz5Ra4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700001)(5660300002)(66946007)(7416002)(956004)(6486002)(83380400001)(66556008)(8936002)(66476007)(4326008)(316002)(6666004)(6916009)(54906003)(44832011)(7696005)(2906002)(478600001)(1076003)(52116002)(16526019)(38350700001)(107886003)(36756003)(26005)(86362001)(8676002)(186003)(2616005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AhQZuOfGR7VPtTP3eVgFn3GiECvSztMLcWnj75ntaB89Gc0KHAiHOAKXwr7C?=
 =?us-ascii?Q?ACOcChkWQ1C/x2OdIiWM/jyqk33Gh20ez1rNOZzcaw610hYo+jGKU9JOWLPt?=
 =?us-ascii?Q?Gr3GClyfma+x52Ap+c102938jUFKwiDwZo2OWc41a2sxHxb57clfrY2iZBQi?=
 =?us-ascii?Q?tz/DwkPKMwtWanFblSX7bfGA7JbxBEwKKmGXmYM5W/eJTomxvdqNUlKMoYub?=
 =?us-ascii?Q?JdTyuEcYvYtUiAWjYtkXVnR9txwosKh/LkyqJXtaEZ0vMALnENudZ0uKJi7T?=
 =?us-ascii?Q?YKYe2DcPvz9uAKIlan1dDjoWBMvqBB4+/c1XyStmEzVmbC8pTdFF1tLsRLtS?=
 =?us-ascii?Q?aheZ/lVhgNW14J169m98lLbV549ZFEjWEmo++oOXQtktN+2grCG1JRBAAJkb?=
 =?us-ascii?Q?0rVOhhw+YvR1vDZn5BJuPPDhSt6i8dfvb5h0MpnB3D4dtZ4Vexkn+v8tLHeZ?=
 =?us-ascii?Q?kifu5U/E4lUAie+cL+chqSWXBJdx0NDgXzA8PxVXFdRTnvyGEo1hXNFkOux2?=
 =?us-ascii?Q?1gQdkqPbbNWABWcxGwA3M+MivS8R0rJiBdPiSy7EO23YoxpQ/D9xvDNCw7Wt?=
 =?us-ascii?Q?anXgfo35iOVxKqkojayvvOQdOnzI3RzWPDU49qtvNAvMZvJKcZzNJdhAKdKx?=
 =?us-ascii?Q?1L8iWulMeLKKvro92N5+e352dho9f6Ks1SWaipe9ytY3x7I9D+ns6Qu/GP7e?=
 =?us-ascii?Q?LOPeVsfmnAQamnqsHQvzVNzGTNbmNOHd6N/unZ1GNrCDb3vjgJ34ezrhFaHh?=
 =?us-ascii?Q?e6xlzCk/4Viw1Ioeo1kWmK221lU7NusHnrnfQ5opJJ8nmyLeVutqFMKPohl5?=
 =?us-ascii?Q?yqvUuvSW1JnYdcDX2cpDyO1oq7NKvHUmt9eJ+SaG74duBxVKGLd7owk2EfMB?=
 =?us-ascii?Q?4Y+2kEQhKtUdGRZuLThuqknP/BaUg2aB9rNdyenyUPd8g5dInPQZZwxvEdP1?=
 =?us-ascii?Q?+dQ/sAIM5wS5VhTJlM9MXUJ7XC+/3nmOcSrV79yXHvo4Vey/ypY/W+NLHP3m?=
 =?us-ascii?Q?bjwGgAw8mCfO+WT4q9p8+Pz7hUo2a5J+PhvoaRJdEi1yVJ2DB/TaI0xHKkH9?=
 =?us-ascii?Q?MwGc9m2ciT9WzZenpdexGjWg+MTFLZw4lPLuPvn+RKkArfsspJ32cUifqwmJ?=
 =?us-ascii?Q?3iPQK8lGYBqbCpCqpYEFF5bgMYi10wf+03eIN7JX0h5p2v+MqsD28D4QdlIn?=
 =?us-ascii?Q?SY0AZw7HiulAMBzLKqigyZweuB6owxePcq9oiZZEq6T/Wy2A8TY1bk4E23Q0?=
 =?us-ascii?Q?br/yru7vvrMmqwoNByh8vSrDCAHXidWbkDDTvieekGszSG9ptYO6oSComzdD?=
 =?us-ascii?Q?OUzCuwNj+zKZDu+tC/X43MrB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaddcd4-fc7e-41f6-4c58-08d8fb998367
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:22.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avFg+av8zXl++mzhSjeonN+JoiLP9SkERXMnmgwOuxTSC9P/OkXai52AJ2lo/KGdZRzD/WAxjuYIIBYzXQTxiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090152
X-Proofpoint-GUID: _IeZHdSqDomymu_QdHcFTmtyIdYu8bpE
X-Proofpoint-ORIG-GUID: _IeZHdSqDomymu_QdHcFTmtyIdYu8bpE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pool_huge_page was called with hugetlb_lock held.  It would remove
a hugetlb page, and then free the corresponding pages to the lower level
allocators such as buddy.  free_pool_huge_page was called in a loop to
remove hugetlb pages and these loops could hold the hugetlb_lock for a
considerable time.

Create new routine remove_pool_huge_page to replace free_pool_huge_page.
remove_pool_huge_page will remove the hugetlb page, and it must be
called with the hugetlb_lock held.  It will return the removed page and
it is the responsibility of the caller to free the page to the lower
level allocators.  The hugetlb_lock is dropped before freeing to these
allocators which results in shorter lock hold times.

Add new helper routine to call update_and_free_page for a list of pages.

Note: Some changes to the routine return_unused_surplus_pages are in
need of explanation.  Commit e5bbc8a6c992 ("mm/hugetlb.c: fix reservation
race when freeing surplus pages") modified this routine to address a
race which could occur when dropping the hugetlb_lock in the loop that
removes pool pages.  Accounting changes introduced in that commit were
subtle and took some thought to understand.  This commit removes the
cond_resched_lock() and the potential race.  Therefore, remove the
subtle code and restore the more straight forward accounting effectively
reverting the commit.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 93 ++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d3e5e49bf687..d4872303a76a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1204,7 +1204,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for free_pool_huge_page() - return the previously saved
+ * helper for remove_pool_huge_page() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -1384,6 +1384,16 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	}
 }
 
+static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+{
+	struct page *page, *t_page;
+
+	list_for_each_entry_safe(page, t_page, list, lru) {
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+}
+
 struct hstate *size_to_hstate(unsigned long size)
 {
 	struct hstate *h;
@@ -1714,16 +1724,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 }
 
 /*
- * Free huge page from pool from next node to free.
- * Attempt to keep persistent huge pages more or less
- * balanced over allowed nodes.
+ * Remove huge page from pool from next node to free.  Attempt to keep
+ * persistent huge pages more or less balanced over allowed nodes.
+ * This routine only 'removes' the hugetlb page.  The caller must make
+ * an additional call to free the page to low level allocators.
  * Called with hugetlb_lock locked.
  */
-static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-							 bool acct_surplus)
+static struct page *remove_pool_huge_page(struct hstate *h,
+						nodemask_t *nodes_allowed,
+						 bool acct_surplus)
 {
 	int nr_nodes, node;
-	int ret = 0;
+	struct page *page = NULL;
 
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
 		/*
@@ -1732,23 +1744,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 		 */
 		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
 		    !list_empty(&h->hugepage_freelists[node])) {
-			struct page *page =
-				list_entry(h->hugepage_freelists[node].next,
+			page = list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
 			remove_hugetlb_page(h, page, acct_surplus);
-			/*
-			 * unlock/lock around update_and_free_page is temporary
-			 * and will be removed with subsequent patch.
-			 */
-			spin_unlock(&hugetlb_lock);
-			update_and_free_page(h, page);
-			spin_lock(&hugetlb_lock);
-			ret = 1;
 			break;
 		}
 	}
 
-	return ret;
+	return page;
 }
 
 /*
@@ -2068,17 +2071,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
  *    to the associated reservation map.
  * 2) Free any unused surplus pages that may have been allocated to satisfy
  *    the reservation.  As many as unused_resv_pages may be freed.
- *
- * Called with hugetlb_lock held.  However, the lock could be dropped (and
- * reacquired) during calls to cond_resched_lock.  Whenever dropping the lock,
- * we must make sure nobody else can claim pages we are in the process of
- * freeing.  Do this by ensuring resv_huge_page always is greater than the
- * number of huge pages we plan to free when dropping the lock.
  */
 static void return_unused_surplus_pages(struct hstate *h,
 					unsigned long unused_resv_pages)
 {
 	unsigned long nr_pages;
+	struct page *page;
+	LIST_HEAD(page_list);
+
+	/* Uncommit the reservation */
+	h->resv_huge_pages -= unused_resv_pages;
 
 	/* Cannot return gigantic pages currently */
 	if (hstate_is_gigantic(h))
@@ -2095,24 +2097,21 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * evenly across all nodes with memory. Iterate across these nodes
 	 * until we can no longer free unreserved surplus pages. This occurs
 	 * when the nodes with surplus pages have no free pages.
-	 * free_pool_huge_page() will balance the freed pages across the
+	 * remove_pool_huge_page() will balance the freed pages across the
 	 * on-line nodes with memory and will handle the hstate accounting.
-	 *
-	 * Note that we decrement resv_huge_pages as we free the pages.  If
-	 * we drop the lock, resv_huge_pages will still be sufficiently large
-	 * to cover subsequent pages we may free.
 	 */
 	while (nr_pages--) {
-		h->resv_huge_pages--;
-		unused_resv_pages--;
-		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
+		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
+		if (!page)
 			goto out;
-		cond_resched_lock(&hugetlb_lock);
+
+		list_add(&page->lru, &page_list);
 	}
 
 out:
-	/* Fully uncommit the reservation */
-	h->resv_huge_pages -= unused_resv_pages;
+	spin_unlock(&hugetlb_lock);
+	update_and_free_pages_bulk(h, &page_list);
+	spin_lock(&hugetlb_lock);
 }
 
 
@@ -2566,7 +2565,6 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
-	struct page *page, *next;
 	LIST_HEAD(page_list);
 
 	if (hstate_is_gigantic(h))
@@ -2576,6 +2574,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 * Collect pages to be freed on a list, and free after dropping lock
 	 */
 	for_each_node_mask(i, *nodes_allowed) {
+		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
@@ -2589,10 +2588,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 
 out:
 	spin_unlock(&hugetlb_lock);
-	list_for_each_entry_safe(page, next, &page_list, lru) {
-		update_and_free_page(h, page);
-		cond_resched();
-	}
+	update_and_free_pages_bulk(h, &page_list);
 	spin_lock(&hugetlb_lock);
 }
 #else
@@ -2639,6 +2635,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
+	struct page *page;
+	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2751,11 +2749,22 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
 	min_count = max(count, min_count);
 	try_to_free_low(h, min_count, nodes_allowed);
+
+	/*
+	 * Collect pages to be removed on list without dropping lock
+	 */
 	while (min_count < persistent_huge_pages(h)) {
-		if (!free_pool_huge_page(h, nodes_allowed, 0))
+		page = remove_pool_huge_page(h, nodes_allowed, 0);
+		if (!page)
 			break;
-		cond_resched_lock(&hugetlb_lock);
+
+		list_add(&page->lru, &page_list);
 	}
+	/* free the pages after dropping lock */
+	spin_unlock(&hugetlb_lock);
+	update_and_free_pages_bulk(h, &page_list);
+	spin_lock(&hugetlb_lock);
+
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
 			break;
-- 
2.30.2

