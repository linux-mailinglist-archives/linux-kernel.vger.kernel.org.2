Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6048C3EE01A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhHPWvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35698 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232550AbhHPWvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMm00K013214;
        Mon, 16 Aug 2021 22:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+J7Zw52+JZpunur+6wO3AoVPGRNPuU6huCAySr+7gcI=;
 b=JklqlkKeoKslzO44l2dMHVa00X4A1xNoOCfP6Ib3l9ErveBw5Uydn7lFwZCinG7H/luL
 8JarjC7n5UNecSM0uGwkwWvgQXow91BU1ImgtswaMSfxBp00zkd+DMvY4ZBfF17G6TAE
 +bA3q9fSfSYjLVs9GieXfDU9CGHuI/iXNgCZhR8U6WiBIYYnH3xWkngihZL2uKcKnFo3
 +bq8Va2PEMdjPS4vQY8MZf1J+SZ7t6cxTI1yslR9NVLHEiTitjNzlWsJ3JE4yEnM4If0
 GdjzSZRJPjiCWSa2NGYgMxH0mCRm2NFCH+nXS/TrnhbWMqUHu+7lEHmdyes7os6gurFl Fw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=+J7Zw52+JZpunur+6wO3AoVPGRNPuU6huCAySr+7gcI=;
 b=fe8KICibS7Qyns3Aiwp3VuVaAGX/TuzCs8KfeMcNRNK656oQCOn21oagctgOK3WBga3q
 ifTOGqihlifxlCb8eAV/XM2PHIfIN2445G/RdTFavIuHSWEtwSYy225EfHgct9ImMUg3
 oGa4tA4O9REIHYN+/l1Phv+XmmzGmPIIVtfnXkH0qT1WzsH2E4KEQ+rTlawFlihIhzzz
 et+W91N0a+1lxPvNUu/5k+1jQzRwE8yhXPC37xCL1bzAKaWuEW2WLiJud4h/67xe+olz
 sgFdu2giuxh9JwQ54FEUOegCVDnpHHXyc8IpDag3qWOcWynOVzTOkN2yFrbrTDStYpZi bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd2nd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMihdJ152058;
        Mon, 16 Aug 2021 22:50:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3ae5n6fxx6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFf14vFtHkZ48YIrwY7omcFo9zDsT6cAPaNgCtGFOrBzv+VgscJN2Md4vO56fvxXd/tNOLSFyymBkv0KFiJdAN3xLrOBwE+UTnbQnGuO1hmJUuCb8JgH8oQ9RfPWmiFImByqXzl34t3tY9yJIXJ1iGA37+2DXhU+tuIiaBoE7MmQ++IttWEwvsrZe6OaP7KmZvvkxOBTJRYGHP5cYp5172j0+veMRM3ymnhMDjfNWemyTr4aNflJcnuvSaw5NFAwFwH+AcCH6jfwUX+XU8wWfjU4Gzf61jpjFLRVIxcABYLzARBfWhqAsVek0Nv57stTX6l5ZxxgBT3ibu1q/a3u0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J7Zw52+JZpunur+6wO3AoVPGRNPuU6huCAySr+7gcI=;
 b=V6FH0Nxt/ccPmTihhTSSZU8ej4TGG+IJh/xfuuLaafOKyimE12M3kaQp6U3X84SM8qV+jjftHy4ukk1SvZ9Ovb15LDhoOj2dnhIwHY4+e1mL3lUKttUQBvwYi0Kg8Qnt04dHk1CxgzQy0u4leTASY88b7tKPPBX/GX6NM8JXn/WB5ulQOJSHKxJdCt8/CdQb0RndV8S4Uz3QdbAtpqVOIVg127DEMNLEQfL6ut0Xzg3l4K1v1PHAhOR28JBPqjK1gU7bNoenVAb2thdNF+ZDdT618Qsg3NyDx8Dyya6LefKX8Z8YnJisA7ak264zL7Mf2WXgxLhpS+hJQMZvl3f9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J7Zw52+JZpunur+6wO3AoVPGRNPuU6huCAySr+7gcI=;
 b=V3cr7cCg4JdSv9ri/Wan5AsmpqAy7KMtZ1cOxyDF2uqaVRLs7fNOMCcxi9eFdSQI0F8xjRJFgv+X1ZPjeEbww/pZQpSn2lu0rew47Lea66DtqEN0aUjsehUUJlsBO0kZhH7lNIkqmrf6b5HBruJTt/35SU7XDIGP9ZE7rskFcU4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:08 +0000
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
Date:   Mon, 16 Aug 2021 15:49:46 -0700
Message-Id: <20210816224953.157796-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8491b0-c9a8-49ed-735c-08d96108327e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB33971BB216F4D3A55F541E02E2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Fte0Drq8ij0Ec3wkDgKzHzPC7ZOiBokNhSoouyU+YW6ZjaX7bgPcGxsiXykwO05VX/62morB3VBLb9lA6v/5SU78S2S/cAS4ibdrJWJVyzjETx/w4mJ/2X84R0K1L/PrDUuVjrzbci1SiaURXhblOLS7dmYOfuzuoP5PlHaYepMyMpFybAEoa1+mAeAAlidCcvS1Go9PuPASV8+Afx8U8Iwy7XvDee88Nj0xs60+FGDvWPLqC/Ct8Fl/l8A6Owf1V2OesBtpTmHyD7fPKwrhWRerKEGeQQmS7FJ/ohF3gkjWuuORjHhRUpAUtmSn5RLBcQho5ZEfOpWvNKLUKD9VIPZUCprzWVstdgo8t1/krg1GXpsJ8Vh487dOPZFfT7LVKkfKCT487fC/rMufl4LyRTAmlIx6NoBMTXpqoXcZTFqpb6z21jj/moqxlU4rWznwOScS/XP8UG53Fit1lsKO1FaSKThXbehVwowUJgyFPLsfXKOqMjBYN1ODlKVBotlkotDvHdxUI4E5JTlXe4YdznRg9qSqh0hk+MSUmU+PjWXDqcNxJAIj3ETwx0xkLvli/PpN52vaeBbK4Wh1vqOVkQ2BMKBttHs3f+rWmNKRDyyoZlcw0D1FHsC5zdQePza63g2HD9RKJe78KgPAg/4N4xGTRLszmnVUL4KszptMqWJXTl7v5fhjs6oHoD36mGi5iRfIIwutOcYtK5on6jX0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?djeyfESZ5OGWzXrbaKGIn0hyWv4BcX1d+NSERlvhTidsTAXtAPZm1XJQpUEf?=
 =?us-ascii?Q?SEWPj8p1OYG9UY+sdvWe7wWZ7YyYFzhrEWNlUvpcwifWOXkRMIL+xfLeNBPg?=
 =?us-ascii?Q?2g5A++fmsWnup+pQSeXkfT1bELYl9oZpazCRoJKN0fRfNcIi4ZcXF3A5Zyfj?=
 =?us-ascii?Q?VQV+dY5fK60L1m9rZju8ioXOWvEuM5kiHbC0dAor5UcSjEYnkQ0AqHY0oqDI?=
 =?us-ascii?Q?MXyMDBycT9g7+R2Yijc7R12ySH1jJkFS3AbzZJh0iNMUhkhRnkcX+Og9ceTS?=
 =?us-ascii?Q?qRXtsXcy91nQhiRszHmzC5TYk8cA4upIesKt7IP1YbCJ2mz06k2yigMzUZca?=
 =?us-ascii?Q?kSuQsXb9fyNRaEwK7CWqYGd8gCFOxmz2ETMVQzK2ujFtd9h0zSjtvaHd3Dhd?=
 =?us-ascii?Q?Lxq1I5Dqk8bo8aGMo+pPPzLU4cSzkpXy7UfLc7ALvS6jSVb92DENK2Vf99tO?=
 =?us-ascii?Q?Wi5P/5FcsEH+XB/qdDLuV6pAG18eJTVmVn5Q2bUBhrDaJsIbDLwJb6U5yw38?=
 =?us-ascii?Q?63AXJuF+7PQwENnmWBN3lS43IWeW8E0EHE/sKxyyKHO8rppKIt2/gnsGXJXP?=
 =?us-ascii?Q?rUu8HiLhgl4LD5hh2yrmEHq79Q9NBb1NVbOz0ORP5294dEA53BuaqqIN/QWK?=
 =?us-ascii?Q?KmxqJahY6Mlr8nhlxKkyWcN00h/JB1mM8qC4kiM1VyxUzbag3CQTCDQYS/J+?=
 =?us-ascii?Q?HNFii7pcCMVzxRJMDdHTEFSgw3lXpiJYCWQpoONDIK+ELNizKoI5wb7O4aU7?=
 =?us-ascii?Q?cyJzQa3bpvkvklRKz7PxHYPtMiJpmkvaUPKMz5ZPVmDMCEO6S37atof+PC8N?=
 =?us-ascii?Q?gL8AUdmB5rjEjVbBSaOsG9gyoSbM/REgQ8MA9Kce9VXzHFtbRSvTVzXejDz6?=
 =?us-ascii?Q?+8Pee1Uspn6oWjkAAm1a9DFriLgS9SLH+nkWqS+a1RlRrjTR/XLuNXyKkS+w?=
 =?us-ascii?Q?ylEoN0zk5xWKWvoKjhBjVI7Te7D5ZYUX5+R7Z8/DEznLCV6ciU9PwWGvKz4k?=
 =?us-ascii?Q?O5DuxPZ/a0nJNMqz0dI9JgnZfgOZxdT3Ry4tvNx5vJVvEemAnOK0DRzbBdU6?=
 =?us-ascii?Q?Bkp1o4T+FV7aitKb5lfGCyVX0u1gpha9TOsG/vj73gGD/bERDDDOc6cjl5bF?=
 =?us-ascii?Q?B1yV3VrlXOsOxEOCFYx40AGtNcaJrB2emQYK9p51uc9YX9DGJUbcUj//+jtN?=
 =?us-ascii?Q?9l0/pnddwY2V7ozrQc9JgM4riM139eHYItYgcQOrSyu7BwRRT/Hr5wGcQo3e?=
 =?us-ascii?Q?A4psme+PyaojMEFXbp707HlvcjMylnoVjiygig1C2Dafb9Inw3kOwyHXoW0A?=
 =?us-ascii?Q?Yy3oxIje36ZDwh6xNACwrxST?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8491b0-c9a8-49ed-735c-08d96108327e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:08.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiC3ydqsdXAq6tv+VbhCpaRU6EqHQmoDK6B+pdul10ux/2kkUH99UJV/CoypXlWk0bck19/UME0PcZzU+tMRFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-ORIG-GUID: MPAjqycOSwBiKR1tvLvLhbNlNnuUc7n7
X-Proofpoint-GUID: MPAjqycOSwBiKR1tvLvLhbNlNnuUc7n7
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
index 6337697f7ee4..0f16306993b3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2986,7 +2986,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h;
+	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
 		if (minimum_order > huge_page_order(h))
@@ -2995,6 +2995,17 @@ static void __init hugetlb_init_hstates(void)
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
@@ -3235,9 +3246,36 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
@@ -3433,12 +3471,91 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
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
@@ -3508,6 +3625,8 @@ static struct attribute *per_node_hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
 	&surplus_hugepages_attr.attr,
+	&demote_size_attr.attr,
+	&demote_attr.attr,
 	NULL,
 };
 
-- 
2.31.1

