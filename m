Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D44331B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhCIATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:19:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48086 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCIAT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:19:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1290Ba08045013;
        Tue, 9 Mar 2021 00:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=mKX63CAEiSTV2kJ6BQEt+/16nlyc840Ar6tKsdeH9Cw=;
 b=0KPaKL7uqUn8bUFsPgSUAhXz36ixRynlCo8/hb4YFs1XZAGMjR913wEnEnclxPk6lycQ
 tDo+HPm3PFjkb3fsynhelUmj7S6lbvwMfdo/koKfcI+Y/1PealT+ErtOl+mRtU4iUM3H
 U7EAP2ZtQCh484aXtYINqk1snxI/GAKZ0lM3lYNN42OkVU8tbYJHXYo2xdlq4gAUHGhi
 kdJIRcQnUXALZ9m9ZCU9QD1uNvFXfqyi+tQTL+0HVUdJ7z2V0EhA3S0kvdK9leHkwyG8
 MKT1QrOx0OlRi7rhTgH58MEk9jcVooxr7TD384DiZWmkFg1W8p0C1/I25T1a8qd46Z89 gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37415r5j3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12904wd9053198;
        Tue, 9 Mar 2021 00:19:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 374kgr1w62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8J66MXQtNLQoxCcm2a85v26QqtvwbmjYuNVo6krQyUuQKhmT1jnShrSBRhx7lE9P6OPsVAU5YtjqhSAq5jsLPqCgmKvLvIsPT7BpS8IoJ4CvicbkvjbyCHR0FrLdRLiJQ1/cOSep4GLiIQponi5BJFYpqfwQEG4D6XTOtUf8mwmtl+//bR8dXK/DrHtiTEfpGMYHBJ1uJEvMDnA/EFnenEgmZZ5capy6R5WSpsJQPZgqkbH9hng8BDkIdSdRqVb3Se22VS2x3QMH0h4+5OyqY+pD5CSC4/aE0fiGAIxnBrADz8/MqfcWNzJMBtKPp33hgc7Pb25fmYN3nwLpV8bIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKX63CAEiSTV2kJ6BQEt+/16nlyc840Ar6tKsdeH9Cw=;
 b=kPcct1y5vXR2eD9GJMdTPeITL18rgNlyDFunMC1Lu5KTyPNSQZCoMJ39ziZXmar+N+/DhH/eRBYYf/7u0TDUKX7AUp3a0g6iXgQFfKz+r2F51/zDsP1z7Q88EkYcYU1Wnd/GxjyK0Qz/XSutLsV4vjSFVbRUZDZxbmJEg/pVveTCJ/X6lcFU+2T53h9nu4eDyYz6tAykYXnLp6C4PvOoLj4igL61+4YRcXn4O2jv0fjlMh+U0fy6pp8cIdj+Q+eQ7R6aBiWSZoz1KsN5FLsl0SF3Z0uqgEtJegUj87rTgBzwU5ULPqqx9jlxFVMC0BHemD2QPt6uU6/eel7EmCjy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKX63CAEiSTV2kJ6BQEt+/16nlyc840Ar6tKsdeH9Cw=;
 b=GuY9eE2m9JjqscnWDkSUlqX4pvhP5LfNgXQk+r7CTjY3kQbmkwZkoLYBsQ+LebuHyLu//3mG0lAReBCMdJUPs8OSyLPIlKJcVuswsz2tXnWrDJjWmWaP3cNLGnuTLjAzWR/Kz2GKMXTWJ8M7nDcdnRivvs/iUah3N8hnhea+C/g=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3000.namprd10.prod.outlook.com (2603:10b6:a03:92::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 9 Mar
 2021 00:19:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 00:19:08 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 1/3] hugetlb: add demote hugetlb page sysfs interfaces
Date:   Mon,  8 Mar 2021 16:18:53 -0800
Message-Id: <20210309001855.142453-2-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 00:19:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f57b2fe3-d090-4efd-7d11-08d8e290f4ec
X-MS-TrafficTypeDiagnostic: BYAPR10MB3000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3000FE73C9C71F06F43DFB60E2929@BYAPR10MB3000.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBpHv+TSHt3YmMm5fX/RCJi/y9qAxuU0cnUyrXywVWCXXvTjLwEPPA8TZYWYL9tTOMhe++n24tHR/zRhKKPPd8t250gxLGgHhxoHcgg1Ly/svb/J2p9E15RnLvJuV7rvgdRdC65iWSm8NGviaEBC5D/mhwmmReW6CSHJ0qmBWZztB7hdUU05KvIy3J+lM7kPmFKBZNPm4oogqIAY43ci5h+panuUVks6np+ZD8eBwLEBCXa1++rCUXPRs4si3VpKc6zGdzGssBB/6LEGmvmac192vVGuU2j42Yf2iom+YnxuUJf7QAQLDufZpHydGhcE4qujnLWHhbKdZC3pvqW+MA9JmCs+SzShCbc8M/vhJ2M5r3Q0PlOTuC0zZgW2B9BWCIWmFqh6ELgkohZXiO1aZ0KjzL6J5C4omB12+MH0mKQYQJhZJmJMjJSgJDRwSS1ESWRRMrWCqOypLDqFF7wPq20RaHCm8ZP9xgbrfGGb8nfgtJwzG/SdK83m9+2otPWnwYiObN4yhJx4pZCmt+Iehg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(66476007)(54906003)(5660300002)(6486002)(36756003)(8936002)(7696005)(2906002)(83380400001)(52116002)(956004)(316002)(2616005)(44832011)(107886003)(6666004)(8676002)(478600001)(26005)(16526019)(186003)(66946007)(1076003)(66556008)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GGs57rfRN17aM8Elwwn4NAhdBU+Y8gBcWu5Gcbh8mzi8MMfZH5yijHMJIF+p?=
 =?us-ascii?Q?0PBlLIswu/k1FbYDw2r2q9e1XuvFYK+PAyHPy7FDP8q3zsgWeqMl7tdvx8Aq?=
 =?us-ascii?Q?aZPy8FlYhouNCaa/I0mJzy2YXv2P2Soaae+A6t4PSd7YiThZJ3IdfP7GPqZH?=
 =?us-ascii?Q?g9V4/eppVptZuPb939/+PAWkJ5JBCR4FZ988hSiaCJRqlfjmXQ2zsVI8P7i9?=
 =?us-ascii?Q?YbMwIk2HO88KXkSvtAH2qTqwHgYYIYuu0hzD1l7tMw+caoo/uFv1NND8emVP?=
 =?us-ascii?Q?K7ctR54w/2dtYz4UXuHHTGBHIVPfsUd4ALx84h1+xmOlSkcjZOH0DFlW/LDC?=
 =?us-ascii?Q?gZcrqLVlNfXeEidRLoPkyeyfNGED7zwPWQ+f1tpt1SK+oDylwcFAWhY0Qjep?=
 =?us-ascii?Q?a7U9jA6KlVXA2ZlCeJnE7QWVifPT/mUHtGiLD8Edc0dATh1iIzAGceFKrt0W?=
 =?us-ascii?Q?KDNKzJ2DN5qoVJKA7OBkN+FMZPo0N/LzWy9WUqsFGKi6Y2a7MiE55G6PYYm2?=
 =?us-ascii?Q?Al2w8YzfnJ+4CThUhqxjZgZY46Ya5/jhUv+xvfuPUnFWg7y+69/MYLZtqJB0?=
 =?us-ascii?Q?xhtc/g34a/ip4vSfxGfXcrmRB3exLHuFY/OJILOT7yxmGrPPrL5XfwXRofmX?=
 =?us-ascii?Q?GBnKkb965rsIpl0Mk/0Iayi7eb2ZNT1ShptsePffu2y9RVDfaihhD7qivGJm?=
 =?us-ascii?Q?SGmeC6W2rqhQkPfb5zJPcRkUuBn3pJdZf4DhaP8FWI6hUgNnffX58sVIzRmX?=
 =?us-ascii?Q?HxMMUCC9O3VmsxdkE/HCd3GsGqKtqxhVgBw6uR2h1280kVkmn7yQ9tAbHprQ?=
 =?us-ascii?Q?0T9EgJpqIsgDz+DZvfTRMi46UUYUrDFSPxbhkLFTx2eNyE/udwnQtvZpiMqH?=
 =?us-ascii?Q?26bo8vxCW3JTbCMoJzVxymjs8CXYoVtns9pLP5MizjcRUCJNaojYntlcr+49?=
 =?us-ascii?Q?GEuZhzgngKnfwc+QJtKMRsBssOf8V3jZcLucpciRTVME600cu8LaoamKYOHq?=
 =?us-ascii?Q?wQFpNPE7CYeDQR9/wNVKnqH8O9q4z2ZDuDAtF0+TjwoYtxMpXRKv2FrNCItW?=
 =?us-ascii?Q?XZ8yocIFMEttnuEuM2IPc0LEAESwjQmZxz1O4Uy5MCMvOJRH+xuZU2x7PF0l?=
 =?us-ascii?Q?4GbQyjDASNDCAmhD3pEhRYZhHzpT086KDLdNIS0Ae8ra4gry9Gb3wwO3CE1N?=
 =?us-ascii?Q?98+9519+k3qIQf4uBW5YEp0Ts49tr1sDHxoFcJKMoYn+IY0uhbWCqCHNOY/w?=
 =?us-ascii?Q?JHqjgcg4jxeQGBKlmZlPxAHRj4u7Bq1qA8RoWJ5BhnYAv9VIsX3FbzFINlZP?=
 =?us-ascii?Q?NwKxY2aLgPo0wadZQULzH8f+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57b2fe3-d090-4efd-7d11-08d8e290f4ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 00:19:08.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH6OUbByaWRLjHnoD6cZ7V40OSAYHi2v8haoDSXSsnPuKJH/WyrtbMbm89nJM7PBp+WqKXxg9lJjz0xDBD0VTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new sysfs files are added to demote hugtlb pages.  These files are
both per-hugetlb page size and per node.  Files are:
  demote_size - The size in Kb that pages are demoted to.
  demote - The number of huge pages to demote.

Writing a value to demote will result in an attempt to demote that
number of hugetlb pages to an appropriate number of demote_size pages.

This patch does not provide full demote functionality.  It only provides
the sysfs interfaces and uses existing code to free pages to the buddy
allocator is demote_size == PAGESIZE.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |   1 +
 mm/hugetlb.c            | 117 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cccd1aab69dd..5e9d6c8ab411 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -558,6 +558,7 @@ struct hstate {
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
+	unsigned int demote_order;
 	unsigned long mask;
 	unsigned long max_huge_pages;
 	unsigned long nr_huge_pages;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8fb42c6dd74b..161732ba7aaf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2492,7 +2492,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h;
+	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
 		if (minimum_order > huge_page_order(h))
@@ -2501,6 +2501,17 @@ static void __init hugetlb_init_hstates(void)
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
@@ -2710,6 +2721,20 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+{
+	int rc = 0;
+
+	/* If no demote order, free to buddy */
+	if (!h->demote_order)
+		return free_pool_huge_page(h, nodes_allowed, 0);
+
+	/*
+	 * TODO - demote fucntionality will be added in subsequent patch
+	 */
+	return rc;
+}
+
 #define HSTATE_ATTR_RO(_name) \
 	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
@@ -2908,12 +2933,100 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
+static ssize_t demote_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0\n");
+}
+
+static ssize_t demote_store_action(struct kobject *kobj, const char *buf,
+							size_t len)
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
+	spin_lock(&hugetlb_lock);
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
+		cond_resched_lock(&hugetlb_lock);
+		/*
+		 * We may have dropped the lock above or in the routines to
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
+	spin_unlock(&hugetlb_lock);
+
+	return len;
+}
+
+static ssize_t demote_store(struct kobject *kobj,
+	       struct kobj_attribute *attr, const char *buf, size_t len)
+{
+	return demote_store_action(kobj, buf, len);
+}
+HSTATE_ATTR(demote);
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
@@ -2983,6 +3096,8 @@ static struct attribute *per_node_hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
 	&surplus_hugepages_attr.attr,
+	&demote_size_attr.attr,
+	&demote_attr.attr,
 	NULL,
 };
 
-- 
2.29.2

