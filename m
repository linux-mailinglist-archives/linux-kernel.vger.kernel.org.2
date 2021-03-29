Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8C34DC63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhC2XZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46370 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC2XZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNIgsS153715;
        Mon, 29 Mar 2021 23:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=JI7Wa5vF5HhieQjdC46n81VLuOajTHtMNYL9ERUe/90=;
 b=z6+cnEmXG95XLymHMIPakoOFTiUkJ8Ki1Z6KL+nISJWRfOKILweyXhPOZ0/gQDI7aygU
 Y00N1g6Kr+q1Nqj87+qC+In3JWYiG067XGhp9wGC+WsNSibFTnq5jRJeOSndafe67JB2
 H/+Bk3FQ3Duc3557h81hCFWrkasKv2N1623sRnIbGwf9ch9tA4TAvhwdjjrWuC78mu4a
 MzLzgMkfBdtq7w/MwTRa8xqEufr0rKK9o1LaaPj3ytPAxAUSwhJzi108SpAgUNga1es1
 2tmZPQMMRqYTr9zFlFhQcgdOpd3+H3C8m7AEaC/kmto1uHip6KDt4Ye1OCetBt0EVhZc 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37ht7bdbr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNFYqE055827;
        Mon, 29 Mar 2021 23:24:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 37je9p06pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4mPw4OfmrzzsvIIOQ7aSfkz7xtFawgOAtyR/3L2nYmTOTZuUwUC7U1JSJ3bQnTNSFJ4BBQylv0v76uVXheFgLrEgNC8J4NcD34EAVjxBUN8spSBYHDOZa5/GQP8yVhD0u0wozlFU7tR3NxaS2ffaGBTjBOtOVsUMvDWaAAHDexke6k9UjrK0tSYETSBkm14qv6XPck7D0DxKOMx2Jn64GzrM9zMpbFX1AKwTs+R2gGiKOm8Ah4578FSM/7sGn+9RrcU5x6z60yu/r0PVY/XyalUIGR2dYPqI+cVPBamek0yE2C/vcTpHDvkJDfNlO4GzY/EYl0PqitqRhv9WsKmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI7Wa5vF5HhieQjdC46n81VLuOajTHtMNYL9ERUe/90=;
 b=XgXTY8kgYEPQLq7KXdiPMOFByz+bi1cWp1WtDfwxr7nHmzIZIqZH1jTzHoORVuyTOGww8y6yKQg1Cq0zovaMMsI30Hy8yZxFxih4dNGEbUfqx1em1axsEKr0bG+RNetMrxhSO9dKKnL924MGb7dk7k/jn6K0mUKzw1aHDH5VO6fVvgMTiqGkSbWUjU6cCZ8XdmTBJcKo6KPrBCagB9/2INXcAaTNGzvqFgSGygwCqDKrB30a2A3RnGdF9KUUCDTkuXtwHoFJiCwFL+YsqAkzEq3617n9tVgJWznASTT58RuajFle3BbF6iE6KUFHlws7rQA2QpV6kZIBNkP7ASU7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI7Wa5vF5HhieQjdC46n81VLuOajTHtMNYL9ERUe/90=;
 b=duu8BKVc8fggFotz51sUrOpdHvLeda8S7yrurG/Nh1k0U1XKf6xytg2aLtSMAN+H5DBTxjQnmIdfijyDQ0Rdiln4qhjJzlKXpZ4UNo+H+opgoJo2ecFJ7Xp00evZ4SLbypICmXf6ctyQYVyKaSwOVco8ZrXoTZem3ypenzLQy0g=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:23 +0000
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
Subject: [PATCH v2 3/8] hugetlb: add per-hstate mutex to synchronize user adjustments
Date:   Mon, 29 Mar 2021 16:23:57 -0700
Message-Id: <20210329232402.575396-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329232402.575396-1-mike.kravetz@oracle.com>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dfa1fc8-b901-42dd-0102-08d8f309c93f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB41488EABDDAC348D27630612E27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXKXOH/vwrFvaQYNXm6aI0yf1juFoMS87Jh8n3OXQhasg/rduzUMqWdYy81oUbNUFrNRYy+RufsqELEY9RMrLHgJHFiw/2/aTjwx0pXGfjeoQI7tPL5R7RfRuXIIlP8CSDi8d95u56KLc+qEPMDgz5X9vJgkulbAU2e8in1420UzcSrdQDwsYqT+W82apR11Z2SscsKrsyKYOTsUo9tyqbKobSZqOn2al89GdyYXk1P/sqSBHelaQTf7W2yxxazTI9HyXX4ygwPa2eROnM3BoNFuyixsZaJD+D/TJiG4Ijoi2SvjkilGEHncP0NHV/5CERkquLFlstcwD9Cc4USXTCW8QLYiAjnCWLUdnyyexhUshzRPzZdwfKPv8Fc3fWa8+dB79pBMf0iJic2WqFl2djDR/gWAD2FutUgR4x3UPnjoarg1sZjrYW8h04xkYkHGYcFYkcJ1GhID2s398la5ondSVpr15ahU0A2WwjBdhuxbOODYNB3AjBzAomuC3rXwhVcLy8cZxnqkjQ3esO1xLOiA87b2gRZQftv/OV+wXgqhn2W/m5BQ7+BHP/SQfwzooj/KGT2FEuhTQoSO06x3SA8RwDFb4jFc0C2PBJ07FNYKmfZFLgdDBzDrRd5DCoSKu+uaAlijjfruz34c1Xlpyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(5660300002)(66946007)(66556008)(1076003)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rXGBWcIcDTblO4PxC3sXDxBdIfL1BjHCaooPf/gsZJJq5DF7F8RSJOpB0Q8Z?=
 =?us-ascii?Q?CsPfUKdTDwAmgrguvxA7ONJL8SGK/7Tq1kZYu3Xp2FlkQa6Jy3luv15ayy15?=
 =?us-ascii?Q?WIyboR6fzjK7bJS5Xtmca7eDQiX+ZeNoRo8m3vIQ5uUOooyR+8skx357IAFj?=
 =?us-ascii?Q?//Qv/FUhK8coLPof6qW/iS5BtjHIByJpZVP8q47TZYsWI+0qdaxYSU0ePbTR?=
 =?us-ascii?Q?HpP7HQB7yiDK3lVJfCR5Hkw9v5ADW8VDTJ1SD7eju5MmKkZ5/RLbgZzrA2d7?=
 =?us-ascii?Q?auswPu/E6gOSjHMT8E7EXMHiEsjnSgh0uC5CklcKYPVSxEW22GCfVBaXVMa/?=
 =?us-ascii?Q?PunzBAHDzUo35kWIpvqGCzxDUXNQl1yjk+DCztcATcAGKqi2AyTVnlG2IImZ?=
 =?us-ascii?Q?cAUz4PT8U7mLU3QtZH8LIVmKaEwa9A5oQnJF3atSa+/85v1FBRuBB9fqHTx4?=
 =?us-ascii?Q?Guuxfm5Moq5Mdq50LJZ1fa6EZOk1bk5WPW00HAVbSqqRcC15xyi66EnlBJwx?=
 =?us-ascii?Q?va96V8ePkKlkHbJmqkdPfkF2xwa0BLt1NYV8DrmPHytDJenz6Wydzkfwemo7?=
 =?us-ascii?Q?9pCQJPf4gg7LZc6M/beMzUnx8YDYuniDc1tswLK3tOQlXXKsDCaLx/7YLymY?=
 =?us-ascii?Q?yoGK26GzXlMxIOu/z0GD9oYj0AwppY3JLAiASuLsuKNLXIgQdg/+3ns4pziu?=
 =?us-ascii?Q?E8RDQMj1nB9yAlzp189Q0q88gbNsEUmkXF8Pq38HB9jwVHPXw52201orMvb6?=
 =?us-ascii?Q?r7BmtqJuOskE4qof+j3A0zLjhLpj0qpB9LQLxj3ZFPJfK1W5Qxqz1HtQbSJ/?=
 =?us-ascii?Q?evIrpWfKzuLrwd3a7yyUdgrUqXKaXxt6IpducP1f9JeWFHBm3tErLoMbdX47?=
 =?us-ascii?Q?9hKqjRKXiISacmYmCChcP4XCONSdqMq9+zkoCZIURcoo3rfDAeSUMmO6WPlo?=
 =?us-ascii?Q?czjDxo16u9YUExB4+Xth9cKCb5FTtqvMvMZ5w5Up+G/go0H6M1aEemvak1PF?=
 =?us-ascii?Q?qDxdEy/PQj5Rbk+TjfD5eIAChSD9u2JY1oasMuN7CNoCfcaiv4P5irHy3XmD?=
 =?us-ascii?Q?KCnSZ5qgTlIfXpvNoVCer4G+q3LkL0iokgvgO2ZmdhseJfLfmedBZKjQ3dz9?=
 =?us-ascii?Q?M81nz6fz7QsQO7d+S2sROSjaufFLEgsSIHKl2VOwPm/Ua9TF6YIe4LBK8j6j?=
 =?us-ascii?Q?EQ09vPch6BONDSAWjXyF//juWJSfPVQL2GB7ErbNeoMGhqdl00sZeQAL1RSs?=
 =?us-ascii?Q?gWiPY+BXRx44L++djrg8ZpXFqRr2ewK3oZ03ynVVbT2mJ+MfYgDL5qD0kvFX?=
 =?us-ascii?Q?gv+D+Jah4elW18hcUD74v2a4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfa1fc8-b901-42dd-0102-08d8f309c93f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:23.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piVkJ78VzyTfUIIcKNVeobUqfD6vxROif7NgfNf6Rh+ZWeM0zZPjM91UUSbz124EIB8xfSVqvAyuoEHY6/+HPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-GUID: MwgaKWK70ae5Xy4aL-GrqhpjvWplNn4v
X-Proofpoint-ORIG-GUID: MwgaKWK70ae5Xy4aL-GrqhpjvWplNn4v
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
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
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d9b78e82652f..b92f25ccef58 100644
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
index 1d62f0492e7b..8497a3598c86 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2730,6 +2730,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	else
 		return -ENOMEM;
 
+	/*
+	 * resize_lock mutex prevents concurrent adjustments to number of
+	 * pages in hstate via the proc/sysfs interfaces.
+	 */
+	mutex_lock(&h->resize_lock);
 	spin_lock(&hugetlb_lock);
 
 	/*
@@ -2762,6 +2767,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock(&hugetlb_lock);
+			mutex_unlock(&h->resize_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
@@ -2836,6 +2842,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
 
@@ -3323,6 +3330,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
+	mutex_init(&h->resize_lock);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
-- 
2.30.2

