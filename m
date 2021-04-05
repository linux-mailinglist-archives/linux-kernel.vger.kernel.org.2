Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408D435490E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhDEXCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:02:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36940 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhDEXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:02:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135N07Sl014878;
        Mon, 5 Apr 2021 23:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=bjJ8BITTlbisNR/LOqpXpU5wYr8TGaUYDvW6QoK/vq8=;
 b=dIthAsTC9r8xaBRAxTOax+cum4Qi7Ai1HHrXZyTf0bgg6a0Yp9d7uN9YY/upbYgvx8kR
 Qqx8AhiN25/5wjd/AUTU5RS7j6clvyNGbcGhc7AWXr7T/nhlwuGwtMKonSDryFGwWubE
 2BKbzZCmCbatdrj8lArTO6vYie/1MhP8aJzzcuIim+hOVeZJpaVdmnaFbOLyKqgAjgYG
 HwuQF3mJkkuxJaQYBBAQy42buTWYbUXzBstjTIDitMbBOn4NPhUzKQ2EInTcPto9vjfC
 vp872pjcKKvfF8OU1rPtnTAUt78AZSN+B9qM/kD9UV5opJ0ZPksaPG1UutUblE4bt5lY bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37q38mkkba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MtqFj089438;
        Mon, 5 Apr 2021 23:01:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 37qa3hp3ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbNz2d+qYFjtWBicp+eWOhq88bkAP95p7wtI9VWZ9YS25nvY3H+Sap036xplCjL4RxcoKm4xwzpM8h8CqCsoTcjXPHNkR7acDxQvWvZLDy5q+AU6onhYeK7ZJWzJak1SP+oL8WAoWx2lr1KrDAr525sSx5MqU86XPeleUhJV5LKXTAUYQ+Pi0Ji3Ovoch8s4qk264WfYZFxh/WWu2yoUp9IiZHKlYhd4Rqs721Rwmgvpj50NMdqV+JCWlAikzbRWWMIEF6GLjH5E7BbYqbD4d8YXmTNOflsxY23EN9aHhlaVunxo0uS0k03FXaIOXJS1uQB3dmXq2vXoVLfMpcxI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjJ8BITTlbisNR/LOqpXpU5wYr8TGaUYDvW6QoK/vq8=;
 b=HHHZrCEyUcPw6+lIwbnvdUf6WGEORyN0Yb67yghnVSL1/eFRckv/UpD1RiJuJPbO8No6S4RLtWSJKWQSI97mkACnevVASeybyFzzsczhd6o6E39AVEDXxYuCZx4NJ5OPaFwElK/c26cP7Gc4sMLDYd+X8IQbcIMVoTAl3d/oS9uhgkHhWTkSu3wdya3sX5DRmU+ixwh8bVSi81WD2UinMYwkf/8Uf2PfrLu5UGs9mVoDlNCAHSjP8HnHwZVTB58cX/WzJYGcUj+0Mviy2bA8m0wf0EA+GI/ClPu+GufHlJhGaX6vQEdQViT4qLJ6JdfbUleZMfetgbL6x5g5HKIt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjJ8BITTlbisNR/LOqpXpU5wYr8TGaUYDvW6QoK/vq8=;
 b=G3mFkMoer+T6gcqDSn5y9eZPCybnpGeQpU3AwvPeojAON5IX/CxQBKZqzTSFVukunMzZr9R8RA4FFtqRQV8WaTwIVY+JYcBMgED01f5jqVhlB/SNkGyWIFT5wFyWsCnip85+jZUDgP5s2Y8XH1iZJR4d2/YD8ZuR1TDMtkiAyBA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 23:01:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:37 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 6/8] hugetlb: change free_pool_huge_page to remove_pool_huge_page
Date:   Mon,  5 Apr 2021 16:00:41 -0700
Message-Id: <20210405230043.182734-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210405230043.182734-1-mike.kravetz@oracle.com>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9daf939-9e2e-4fe2-5329-08d8f886c3e6
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3544C526658945E66D0473CDE2779@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udS3Xf8Z6OOW9Nhht2MG77DdVeyT6277pfQ6zrppmFNWsghgqHFJIzZPCAUz9yroT2ykyj7dztfVkw3JxmhG/9pejpV1Jnov5euq4r9l3sYiP6c2UTqEu7Pp0K9rpfi1tsqoBVvyRaeq0NxVbseJMBImqqL+hNFlIZs5OyDyZnHPSx5q1kQPmW8dHhZScpwWsWNrwoZPuUIiGHLt9mZFCTCDD4GT3kxgJV59/FQ+AEkV0RwUke3EF0srdJqZOuFEJeTx+vZwJ7mzMgmONDElMAfpKJ5QXCnoLMoZNwAih1JxiZ1ycOiV1FboQkM3JESBqDwoLUaZ/Qv0f/uMBjFdQxSO7n6pa4NIQOuTAGeq2pNvpHx3WlCCaQIom8PY8cqoe7rpncw9I8s0fcOiMESgOhQYZFVNk9hTkUD0zsdgNbJNcCJIZX0CInZJIh+jOgOoV/owmFFQTeZdVcPQLJqFmdx+pU6R50KZBAZZvAABF1o4masEN8cmZm+KgZDiumAtsX3kznjL8M6J7CY85EcBDPHiUfX3uR2Z6LTBwqMDzsOSV8CdsSdRx0ZEPvyroGC7OII7CO3A9CsJaOXHRqN0TkGYQfwVE17+oYuHdwZ9+OlfR9sWSHjYldOV2DsMcCmutJQReAeUXJojL0aqJVwJyRoCRd+u99QVnin0buN42YfCjkiBKbZ9RS84BjKJI3rRIChEx/SKTBVb6JlaAzfl/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(44832011)(66476007)(5660300002)(107886003)(8676002)(86362001)(26005)(6486002)(66946007)(16526019)(38350700001)(1076003)(2906002)(54906003)(83380400001)(4326008)(52116002)(7696005)(186003)(7416002)(478600001)(38100700001)(8936002)(36756003)(316002)(66556008)(6666004)(956004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+UJqpB42TlONBETEKU3YXHW/apKDjTO0c5yS8g6DVc7CCpZfz2/gGvkNH39L?=
 =?us-ascii?Q?4eCv/EqgYDlUwoM5xHsblxIVGFhC/9SQCOyA1un7Eij2bd9NZdRZnzszbcQV?=
 =?us-ascii?Q?zvIO+4kSMPtco6JdO38PyP9MUgMdO2zsPxuXD3ZePVjpmZPL3kJ2JflCaUdU?=
 =?us-ascii?Q?LEWN1e0vZoc7UhH5Lth6md/lAqrh3df3nFOx+g/DeiIL0G1xjwMpwNr58kma?=
 =?us-ascii?Q?TCuRrK/c3ivNwSACAX5Mi0ofVmDmmcoRnf/S2/PekgIKggGn/wmNvH9yZs7r?=
 =?us-ascii?Q?uZFFu2cV0iGx5k13+pvY2z1hp2ooT3vNt8Qh1ruZHgfGRjtNXkI+yyAUKBwH?=
 =?us-ascii?Q?qDnWCYKXPEeMcKoKtSFS0heOYbl3FxlO6YNIkFhMyutZ0yBul12DPc28p/DD?=
 =?us-ascii?Q?IV9NVcNsLDPpoQvd+rczxr6KT4IiOeM4/qelev+49MEUCLhcIJ8UnnXwlC8R?=
 =?us-ascii?Q?XuVJlxHtS2SDxwFZOqD/xRBfWUqXfLvAhxswI0EGfjWtBbObrQ1QVqrYXs2d?=
 =?us-ascii?Q?7WaDUAE8Dx7Hzf0fMZi9IhQPf5AlV9CdHV6nOx9utigHyjC+SwsrTNQSO1ko?=
 =?us-ascii?Q?O+fTeJKlzfkXmPJ2xlo/MDNUpamnY7BtuC17usMXTdyxKAQBtlZTHkLM99MD?=
 =?us-ascii?Q?6A9isWH7ZsnvpMt6EWP5yq04YT7ZcMhswTLi/Iv6+zcarz061ogLZgUuCjkl?=
 =?us-ascii?Q?RGSeqkGdtofxBI0zSGdkOUP/YLeJgt76GBuqE8FS0aYCUKWxcj9GIjsxgmD2?=
 =?us-ascii?Q?fCc3Zk+pTROi9sF7c97XFD+UvaEvXlfkhLa8+QxFfcGoXoC6BxzhyyXN3gRt?=
 =?us-ascii?Q?T9PKtV9zeEwvpQAXf8sm4bsbFjtpHKO57PcsPh9XE61pE4CvxWCuZfj/C1a9?=
 =?us-ascii?Q?8sD7cV/PPkoFlAov1rAjVTUzrSvE7zXCRUY2L8TDMnm2hyf5bqC13kDzeOne?=
 =?us-ascii?Q?byzpPX6W4W7NNet1lnwIS3sdmqLtXuuj8qbZLzSj0o/4LHCXNvRTOeDjJMqv?=
 =?us-ascii?Q?3p+9VXvIBjrBzAf5cD1LdyZOLQI9p1IHUA5/WZcNbrPu+9XkS9FWk1VauxX8?=
 =?us-ascii?Q?eU8pP6yRrKwkcCsE3hE61iMDcfZt4kMgPWARIO4s++fvlMvFCBdwbs/a7oP6?=
 =?us-ascii?Q?X7iMtEs/N/C3KSkveMVpw/cfdgOtznks99pDS1wfOFBWCzUIv1MXUvTb3jQW?=
 =?us-ascii?Q?QAkIk7hDQ57Fi6ewNGczl3g+NlfTu7UpY+PVp99FpJsqcVZAE2Wlaa85Ts6N?=
 =?us-ascii?Q?+w5gBu0o1SsTvIlgrbv+uByyYmbuQ8QUS75MyEJe32EPKJLmEDjlIdi5HQ7C?=
 =?us-ascii?Q?w46acBG2wpA1/REEwURYmvX1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9daf939-9e2e-4fe2-5329-08d8f886c3e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:37.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dkupVK7za+Eaj6fUlsM/Hr3gB2IK2W3g3mfGiQCsEGApRv69MIBqtc7MsQHU/7q06CKSQiWG9/Z56mFwQ3ecw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: smRMt5xKuNbAVAUTDkFDsi0ItUVRceh-
X-Proofpoint-ORIG-GUID: smRMt5xKuNbAVAUTDkFDsi0ItUVRceh-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050152
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
---
 mm/hugetlb.c | 93 ++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index be6031a8e2a9..93a2a11b9376 100644
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
@@ -1386,6 +1386,16 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
@@ -1716,16 +1726,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1734,23 +1746,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -2070,17 +2073,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
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
@@ -2097,24 +2099,21 @@ static void return_unused_surplus_pages(struct hstate *h,
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
 
 
@@ -2682,7 +2681,6 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
-	struct page *page, *next;
 	LIST_HEAD(page_list);
 
 	if (hstate_is_gigantic(h))
@@ -2692,6 +2690,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 * Collect pages to be freed on a list, and free after dropping lock
 	 */
 	for_each_node_mask(i, *nodes_allowed) {
+		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
@@ -2705,10 +2704,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 
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
@@ -2755,6 +2751,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
+	struct page *page;
+	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2867,11 +2865,22 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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

