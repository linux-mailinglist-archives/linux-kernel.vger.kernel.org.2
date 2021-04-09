Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4E35A825
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhDIUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45480 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhDIUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139Ko0uE029060;
        Fri, 9 Apr 2021 20:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=h417aWzw347MnoAPkccllHqg7trnRDLqcpBc0czHGzE=;
 b=pf4VdaNqJoUF/jjKpDp/pVxcUuYke+H5LIUicZG6DuyoyxVPcQUEBEA5YBsR5OBeB8Rb
 AEAbbCkP+7qVvE5f7keaj3k97FSMrz6ZE5ZZvp/F3GS1Rhle/bya48cqbTwexgZGzyha
 ly6n+duYgHCEcWUd5W89dJLKarMRAPr8+RNrTq6Pi+C0jTgE4DI+mN8siumS+eHFIEOU
 u86gHPVlLOeMU9sBb2dxajfXZEy/xVpoWDMeU9PT0YROnK6EgCTdoC1GDt1OszfdqglN
 E/heRqmourU32WBR18ztDcQoHQqlG0bl0iVmYZs9yASamdzSAeCKnOIxGaPpcPZdVbu/ hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37rvawaqaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KjFEV022496;
        Fri, 9 Apr 2021 20:53:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 37rvb30bx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDDCYMSzZ6DglqWQt2AI6yZB+6fzE8vCl6j6UKOM2mujWTEKP1FTG94hNJt3Uy2j6aM1bAbAFUfYe7jE9R8OXOnyPIKmhZv02/OntZFs5Nfjc58yerKJlmkLCg6r49ObclYRxxmb6ViTBpcs7SCb5fZkIhIR2EOhlfETzpU0+KWxt0dmHD7TPgz6Z7+FR+twlhBb2DF7M9Hs0tFfMvM5ACTRrnn974TxgyWEaw4MLOs1q3u1ljd/lYyDcvklIgjdvq8jR7TGNfE5I7ReiaFUmqrzMVRf3aukYuG3M9boGfeLuLHX7SNuvqWO5z4In+b/GFmT3CO78FqRAHSEn4xpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h417aWzw347MnoAPkccllHqg7trnRDLqcpBc0czHGzE=;
 b=QG251vEz0Lm2TlirgQtSDn1Q/rDFutE+Mw51jMTl/FLfHri0qyBS2aOujsyLKVezI+TlRsiZDmr7ziJImdTNmRQ+iX739ZWoeyhQCbBL64zzDdwCkeh1K+MJnkc3w9Jk5DoU2ErVgapYMBSI7lbnb5K7996nVxXIVAkwCMXhj2xbt/PP+EYbLAamNoBihyrNWNmtLZV1UtbtL5nJ8/QI/7lOdZ1P9+0C0ULmpISa2qn8rfdl2pM2tyazREDcRwotPP7aI4HC2avdRN7Sh5Q/L7fZ+PWuplYxJ+X1ElnPFuV8GQ7E8s409jh0DhZEmsNzKMhlcQ4p9nCD5SNwUGfaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h417aWzw347MnoAPkccllHqg7trnRDLqcpBc0czHGzE=;
 b=HyehORepqLjRmR1hrl2bsDFoI2RGjc7/1JQ7RtoS5tozmz0IA8S6jxJg0M+VN7r5heHHEn5VtjV7M34oJRPsgUFCKXrIKAc8OoGIs+goxIIvI/0T/hARfqjdvC21xwpobrwxIb6TcSiQg6Wab03KFW3im1Bd6sUKvMi/0nkqYR0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 20:53:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:15 +0000
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
Subject: [PATCH v5 3/8] hugetlb: add per-hstate mutex to synchronize user adjustments
Date:   Fri,  9 Apr 2021 13:52:49 -0700
Message-Id: <20210409205254.242291-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e61f71d-7df2-4afe-1dbe-08d8fb997ee2
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3972ECCE69909D2E715960D4E2739@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+6wQENXQDO5DivC+Y08eXVi4YUzPnMDvpido6i0dWoa+W3GXEL5sVUnZXkq7yn6euYvjhseH5kKHJDqLRKyxoEw8QcK2tohXIXac147+u4U9tbeQSV1u9QS/qht1kPJ8s923qO3qEGrHmVSbKCUui+0NN04ukY7s/zb/S2zhEqgzMQpok23KJoxonGrS3zC/DSEdrp9HJpNA9Vtyu84sp+re95HJ1lZoy6Xbt3DwoJ0ycK/oIvi9Y7b9GHNgvpqtH5nhEjRA+JrmSY1aIpeVDrbnXIFwsPoSNEft/LWlCz/A8qIKJiRSNM9Qj7nwM4Uhpg5DYvel8uwOkSM7aTgExj1SZJqqNyoiTU8xz3PE/2wMCpeI2SFYHoMCEDz//KXjn4kYyNmrNS/BvY3OLzqfGYJKn0jHZCx8DGucNateYnWhdqKKEUoGbYB5XG8B22bKoGIb7DfYdRlSUfs6BWGfqgaCwqAcUPPmvHlJ+NwrKJ0yZJkW0IxgjxYDlaOII/yIFmFWEy+CDOQaK6C5E7i7zVcZPtn6p2CAfgsb58Bytuu9gcd9JffC/gSM+XvGJrXFnSZ4rDAwjaDl3+t/E5qZ9NaKVhr1YKfLVXMijMzfDyFHJfxmdX0UR0vWm4C95d7ygF2hBDk7K4Opf69D/iWftEffs2cRYEJ5paVBHHX7uukYQk0h4BxvuIYsw7aYPen
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700001)(5660300002)(66946007)(7416002)(956004)(6486002)(83380400001)(66556008)(8936002)(66476007)(4326008)(316002)(6666004)(6916009)(54906003)(44832011)(7696005)(2906002)(478600001)(1076003)(52116002)(16526019)(38350700001)(107886003)(36756003)(26005)(86362001)(8676002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gyGadv5lIE8arTMxqZvAVSeZCmHHJCEm7sjv8QSdVeWQ2McxTvOLSbIJKMdd?=
 =?us-ascii?Q?U7WdMoTJIO4n0uIeCDqb/wlx3UlhYzecxY4xvB1MKKyE0Ho2OU4JTQ2ao8//?=
 =?us-ascii?Q?31rVfeGTJV8J+QnTIbkJLBNed2oBI2ZJmtq3oyMUzL0GMtBISU/lfOdAkWUM?=
 =?us-ascii?Q?awvWQnIC23TaQDhXw+Wa/vtdiDPoFniUyC7XyM+9dMPimMVXP1N7zByFWepa?=
 =?us-ascii?Q?iolFyj/bfMWG1t/1F+a+9H6UD0ClLqIxQDheMhHVYwqKB+DZVgmPbR8aLaMm?=
 =?us-ascii?Q?sR/F+gMb4ML0WhzdZoxTDXef/z+bI0eLCw74dZkZcg6iOV8zQHAL9KVD57NS?=
 =?us-ascii?Q?cIpiacvfAnCvJboRt/CTy+cM5+4P9cupcuuNPCp/yMQjT41iHF1lQPGe2U0K?=
 =?us-ascii?Q?DlwtTcOLqLnMw0n3HolcEGWrqGDWkB8iwHVIbfIL1dfnIPFdn886Ja+6R0ex?=
 =?us-ascii?Q?Np+/h8pGHA6uwqYckHk0IyC/J96+TNJswplyEwRcV2j1b0ZFh1aNM/qN55Uf?=
 =?us-ascii?Q?v8vAx7o6RzjIT1WPijzjUpLqt4hW9q2oGfp0Mv+GLYaUk7xeBuHJ7DKdawZs?=
 =?us-ascii?Q?6u/c93QaC0zEMZnOmg2MF1nVGJmlEcBc77XLRrjCrfbKHCtRM2ojXDojMQlo?=
 =?us-ascii?Q?Ioa1LzDAnGheSh2OOJmuTl5FzTtYGuuo5TL8JTmynm7ZblCNlNYqqi6AUBy6?=
 =?us-ascii?Q?T/b0G45BfmWE9qQHn5EJHINirlJSDgID+ElFIUvv3YanU8ii5bg8EKMGvpPI?=
 =?us-ascii?Q?IFUewMr7ckNz5nQa+WkYMKrvfbd+9r/Al+0FLC6+/9G0qbWx6dhbzYkJNeAn?=
 =?us-ascii?Q?VdBJeUMWDhdg/lyKt0s5Pyu+AQ85sfby2DK6Vs9zIG4SeqK8f0ZeYrpdhgSN?=
 =?us-ascii?Q?Xk7P/kUQxiZJpAMzXTrMtgq9ggVAwMevJhRKT+uzIbf4Pp/Luv7p1pjHuDKb?=
 =?us-ascii?Q?bHyftqo5Y2BgLluZcNu+zzWhpR0OfZGse/eMz2dDX+OUnRmlXtUybVWTo64u?=
 =?us-ascii?Q?R/aWKL8GMQUD8MSL2kTnqYMtJYGqwO3WRBcGdnbpyDQZ/GtEq+f8OzUnD6Mq?=
 =?us-ascii?Q?LA6h5wmgujsWs8Tp32GwGdhNJ+A/xbUBlqRcs7D2W+ags4oKkaw83W2yP6YZ?=
 =?us-ascii?Q?CraatW4IZu2Qp7p5C05lssayFZJ98TurRvJjzAcLk8+bd1LUI1NwOjPkFMI5?=
 =?us-ascii?Q?UuTAMdg5+RmrEjGu+LhYNDf1R9Pk32NZeBkf4O5gi0BH1fVfRT9iGgv2OWiI?=
 =?us-ascii?Q?OdP6h++RFPjdM1x3uq4lQ5RlmiGhq2XBUJy5uZkYlYE120u2wR/XLApVcUwt?=
 =?us-ascii?Q?V8upKUBi0VzUFeEz3ugHz3Au?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e61f71d-7df2-4afe-1dbe-08d8fb997ee2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:15.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ooylu10KebcAtjfawTLJxsPV9KxiKRt2HJB+mtJWuuLCJWhKv8Y55PJFYvr711sG0aQVpgr3jvxETwD4k+zOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
X-Proofpoint-ORIG-GUID: r58iJwuVxoXUsz89nLFGlRqm4XccczSY
X-Proofpoint-GUID: r58iJwuVxoXUsz89nLFGlRqm4XccczSY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper routine hstate_next_node_to_alloc accesses and modifies the
hstate variable next_nid_to_alloc.  The helper is used by the routines
alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
called with hugetlb_lock held.  However, alloc_pool_huge_page can not
be called with the hugetlb lock held as it will call the page allocator.
Two instances of alloc_pool_huge_page could be run in parallel or
alloc_pool_huge_page could run in parallel with adjust_pool_surplus
which may result in the variable next_nid_to_alloc becoming invalid
for the caller and pages being allocated on the wrong node.

Both alloc_pool_huge_page and adjust_pool_surplus are only called from
the routine set_max_huge_pages after boot.  set_max_huge_pages is only
called as the reusult of a user writing to the proc/sysfs nr_hugepages,
or nr_hugepages_mempolicy file to adjust the number of hugetlb pages.

It makes little sense to allow multiple adjustment to the number of
hugetlb pages in parallel.  Add a mutex to the hstate and use it to only
allow one hugetlb page adjustment at a time.  This will synchronize
modifications to the next_nid_to_alloc variable.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a7f7d5f328dc..09f1fd12a6fa 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
 #define HSTATE_NAME_LEN 32
 /* Defines one hugetlb page size */
 struct hstate {
+	struct mutex resize_lock;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3a10b96a2124..c8799a480784 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2615,6 +2615,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	else
 		return -ENOMEM;
 
+	/*
+	 * resize_lock mutex prevents concurrent adjustments to number of
+	 * pages in hstate via the proc/sysfs interfaces.
+	 */
+	mutex_lock(&h->resize_lock);
 	spin_lock(&hugetlb_lock);
 
 	/*
@@ -2647,6 +2652,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock(&hugetlb_lock);
+			mutex_unlock(&h->resize_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
@@ -2721,6 +2727,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
 
@@ -3208,6 +3215,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
+	mutex_init(&h->resize_lock);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
-- 
2.30.2

