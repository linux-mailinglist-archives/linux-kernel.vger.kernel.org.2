Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1C354912
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhDEXCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:02:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhDEXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:02:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MwvFr191382;
        Mon, 5 Apr 2021 23:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=vQe8pObsRjtowWnNhpKWUIDjEKSCCdNT1PtA7AxP1E8=;
 b=KC580ox951z29QqBISpbYtcbHcXwlM43CHZUUyMevL4RAd0VpEo7phepEcmeGh4GESZe
 kYKWDFIrcWJFOqhYhBb5x2hoHz7uyn4YuJGWV+k+hB79nlg0KcF6aSz49gBUuIg5xVYi
 mzPWLF4a/vD3H/a0e4AszdDh5yAIQErp6ZpwcFnE2U07rKOzFIV4HDM0Ovv+hnAXVgts
 w6w54Ms97O21QC7uq7l8jHxKCVCEkGCUZhv09HHDiWouK7smvl7T/K6/Kg/XXCPvajMF
 sj3Im/5LcEXebomOUZk4gbYcAAiaehlq5q1T/+s/crxRNLXs14w73SNc5jv2bE0RnPkR bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37q3f2bknf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135Mtx75178827;
        Mon, 5 Apr 2021 23:01:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 37q2pbsq1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFumLqRl//FqfbOpKOoaakFOutJ/EqrivGUFAMioo0Ipu8KJvsq6brKVwCzRXuNhJ9WASx29G5szx61RhvyqaDJadr/OSVoihBisj0E6Wr/BwzbvNKWYbF8WQQrobNEU4Wq1fKXSk5tcojOpJnxZmqpJ+rjxyR01zl+uQ/PJg5hlKD8G8u1jmqcJZUr401HynfSI6p95bbSPtBOQaTk4wQ8P9AQkyXON3ZKe/oR/qSP+CVNd/Q23aBOO9GC352ylgzFtStQ1rmXF2YsRrzpiEgH/L1m2kxeGPT9yt07Qv02pz9nRi0U63D9uhQ7sJxhsjUdgJW40STnUyugdBXwZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQe8pObsRjtowWnNhpKWUIDjEKSCCdNT1PtA7AxP1E8=;
 b=dncfLChiATRv22jNqxoL0nnzum/QXWGGLqAupK4DXHNJN5Rua2UKCu/TvOKkPYbBnF08QSkFkQFZLW0w2UqmxMrTDidzONmDo2oxMOVHKJ0SOLYvtrCzyEj8ze8SVeLNtSWf7lGchAqbZ9ASxcyCC3Dg0eNStYDUh2U7vJRscbonK3GZyFA/Y4j+3RorEhL4fNOrrYErJih2jSEUHfetpGOJoWf+XnYLoTwiEXRAH0hAMVOBTUJhuyD6/L55VqODE23bDk5R4CpRPnD1WyQ5DxnFLC6fgmZofosmaJmNkXPXcPHcJGr+HDl9YW5aKV/+7XHt6V3XBQc5CecNI5QvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQe8pObsRjtowWnNhpKWUIDjEKSCCdNT1PtA7AxP1E8=;
 b=E1C4PJax9pV/oTUxwPceq2Dm5yj2f0FzZtavZf5zq0zCnvmHJyaytb5/9v6N8NZhNTk6Vn8Na51gvwTmBLJyLpNnWbKhk9p+VzyAXP3Vc+OT3vogVQiHCJWu4HwGYf+JvjiLgU+i5rwpuGm4C4GMHeFVxksoGFxI3LmkIz+FRZs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 23:01:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:42 +0000
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
Subject: [PATCH v4 7/8] hugetlb: make free_huge_page irq safe
Date:   Mon,  5 Apr 2021 16:00:42 -0700
Message-Id: <20210405230043.182734-8-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9e91f62-cfd1-447c-ae49-08d8f886c6a2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3544EACFAE127F419FB553B8E2779@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jj8Jk0YE96ykJ8GsSAU794BAoK9ZzLPWcQEJI7nATkmCo3KenKwjVrES0HKnJ8/kDHlhZkRWFFgZRz6T4lYX1WYDlbsnQJjLlOEZyjPmFwb9sQs/yFZn0Joqng3QrSsMyrxox3Tm8hKLzeQYllvObag8NccHRpqgJgFBI4XXmdtWzWMvBtUwFRqcrwBsDaeCgIV8UZTQpl3cdZDEQw+8PibShzH2skLKD/rHTMtjEctFhCD8CRbMiWJMCy9ynOAjguAjJqPqIWiL1rJ6VbLosKcZMClaReOpraKz9qXDjIg0FqavE2brC6x7nyxhS8Oj7b8K7k9BVZSovIRDT6rVya0iB0QhEXASOpBD6oF9TddIzvP8T5PQJYai8K6oD6YByrcUPkXW3WgKKTvbPUKwOb0CS2a0oPpEYgboh4HCFhtEnUqDA3XQsSd2Xq1wBnlAlf8kvcBVfhHcN6T2y0VNGkGHeAFgG2YL02NTtzC08I8d8ixwu25z90SpDFj3XKwqqvJfKlXODjici+UUZSdVbNod2P4BSgnsGGE5R6rPWtcYnaFUkrGKxj7xZRJYJ3yqGwKo5r1IRyLimPaaGjbDnHzg6dWrxWUQMPPMQX3zSq8hLeSctWlmizBW8W35VZ8+u3YgKYact+B+ERCoqhNoTfzzahIwHM5rUllZsz05MGQyt2SKxLKHvwrPFYwNb8IMDJZmcvm7YwioMXeLvDU6SXjqMfpKvgaiz7/0uj0TUrWsJXeQdyM4CX/83jz0K5xoxW54wPFbgDvoEP8HT+uNvzPKtPTg0ruN5Z7mVvXsceE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(44832011)(66476007)(5660300002)(107886003)(8676002)(86362001)(26005)(30864003)(6486002)(966005)(66946007)(16526019)(38350700001)(1076003)(2906002)(54906003)(83380400001)(4326008)(52116002)(7696005)(186003)(7416002)(478600001)(38100700001)(8936002)(36756003)(316002)(66556008)(956004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I4WcCFVZu7ZLO1abra4pl7xBhW2g+WpPTgm6S+UyG9Oa8XnqfUb6ZDdAIulP?=
 =?us-ascii?Q?IWghK73BaCB7MuBqUs1c6aZPW1av5WuelfOtbVuNiTUGJTZT9dkvhWugFklb?=
 =?us-ascii?Q?a55zrCdMW7uKlQnheYkHXmmi64wUOXA8S1hCiorWH6GUj+C/5GbHzpmGmYeZ?=
 =?us-ascii?Q?TS8+hYRJfeY4R1qDa6tlmSL5X5jc+bNqVwfISvVn6qd+FsIPdQzubtUSjcNC?=
 =?us-ascii?Q?vnpiNTIU0MGkWsaDraRM18h1KZ3ooUDRZjN2SwAlUpps20VtJw+EPv+PibvG?=
 =?us-ascii?Q?sGP234Rzumyslgdwd9S86tC9VUKwRMy27xZSvv6kQMjyaGbz7+BAPdQyKqW7?=
 =?us-ascii?Q?0GJBYaRSs/RWqdn4MdQLUOwSv47EtxU00E/98r7DKBq1oiTjbEGbych81rsM?=
 =?us-ascii?Q?vrzLuL8bjH7whzxmI2L0sXjTK1I528gAys/nQuBqxlm9Ev+jN61EcqgbMred?=
 =?us-ascii?Q?JpQSoLtpcUnd9i9hvzk6kXA6B5grKtl05mKe5LKfrjQXJJ5WmTEbh8ak9yf5?=
 =?us-ascii?Q?+N+Oi1fQjovERpnyKy4zipXBT68CjXX3LFezRTW7UI79TOKkdtvUhVvsDLo+?=
 =?us-ascii?Q?hy0kR7SQ2fjS4NAqsmXngK9BcCuTSe4IZ0BshNlZ3eHaiPd0NwHH3hodX3Xi?=
 =?us-ascii?Q?xxZF7WGupqSam1GoekyD2B1CB4yZ2Lhd74o7MHc7npPc4bqsHTA+TDk8V/W7?=
 =?us-ascii?Q?/1esDDpUo20W3y1BNs4y+Ichq/RD/c5qoYS9RPoQFKLUlsfXkYZrH8LpkZ0o?=
 =?us-ascii?Q?YrClESEK97UsXt4ihMnFlKH/ukh/96ANQASxewsYOHeLbbOe0dwkVNWuvWQ8?=
 =?us-ascii?Q?XF3MwOOA8B1d8gllPleLzn6HFZKNvEopcTnh/GKc0Eogj0WjruIG8KfN0Fu/?=
 =?us-ascii?Q?Mcfei/YgqGTCobVtHTPfhdLuEDkm6DjR7bbOeLgg1w3FtkxPk/+UN2RRd0D0?=
 =?us-ascii?Q?VvxugEuMfMAf0og5DSjGw5+HCdLYMnrD9gJWI8IT5lUy721g7AKHJGQBGI9u?=
 =?us-ascii?Q?4Fc0EmzIS9HXNwf3zLqE/bRLOoyDqkPib5pOfzopSMy5tq0NXLmfkCh0nJDO?=
 =?us-ascii?Q?sV6t8HdTycw/m73qmNfFIGHnXcWBuxuTwIFdwyi+cDIns7zvDQ9wnAWX1IME?=
 =?us-ascii?Q?tqxYGJEkAlARKxdEprUErPOpjAbdziMiabVsfGl/3zsXKs6KRJPN+0SfSDrB?=
 =?us-ascii?Q?i4i4ss1Xt/jR4PxA7x8Wb6CIyT9kr7sMEegit17/F3pCXJvurH2lANk2+cpZ?=
 =?us-ascii?Q?yWe743xqixFXI/gILVSmSJWdNgt7ALXzOa35II9L51YhNQxSnVQT5FNI2eJK?=
 =?us-ascii?Q?umUoe8ZxEQzyX+wbAjd+a/g3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e91f62-cfd1-447c-ae49-08d8f886c6a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:41.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtRvPt4cH6jTGYsw9t2W/BNP0FOT9kXls4avrOoAF4zNNkY6wEUf3v3r33zW8XKvmYSVwvl9SIove7Qk7qlmDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050152
X-Proofpoint-GUID: YZ7Cz9YH4rU8R-bfabM-52I6uuAJ1o_p
X-Proofpoint-ORIG-GUID: YZ7Cz9YH4rU8R-bfabM-52I6uuAJ1o_p
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
non-task context") was added to address the issue of free_huge_page
being called from irq context.  That commit hands off free_huge_page
processing to a workqueue if !in_task.  However, this doesn't cover
all the cases as pointed out by 0day bot lockdep report [1].

:  Possible interrupt unsafe locking scenario:
:
:        CPU0                    CPU1
:        ----                    ----
:   lock(hugetlb_lock);
:                                local_irq_disable();
:                                lock(slock-AF_INET);
:                                lock(hugetlb_lock);
:   <Interrupt>
:     lock(slock-AF_INET);

Shakeel has later explained that this is very likely TCP TX zerocopy
from hugetlb pages scenario when the networking code drops a last
reference to hugetlb page while having IRQ disabled. Hugetlb freeing
path doesn't disable IRQ while holding hugetlb_lock so a lock dependency
chain can lead to a deadlock.

This commit addresses the issue by doing the following:
- Make hugetlb_lock irq safe.  This is mostly a simple process of
  changing spin_*lock calls to spin_*lock_irq* calls.
- Make subpool lock irq safe in a similar manner.
- Revert the !in_task check and workqueue handoff.

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c        | 183 +++++++++++++++++---------------------------
 mm/hugetlb_cgroup.c |   8 +-
 2 files changed, 74 insertions(+), 117 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 93a2a11b9376..15b6e7aadb52 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,9 +93,10 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
 	return true;
 }
 
-static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
+static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
+						unsigned long irq_flags)
 {
-	spin_unlock(&spool->lock);
+	spin_unlock_irqrestore(&spool->lock, irq_flags);
 
 	/* If no pages are used, and no other handles to the subpool
 	 * remain, give up any reservations based on minimum size and
@@ -134,10 +135,12 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 
 void hugepage_put_subpool(struct hugepage_subpool *spool)
 {
-	spin_lock(&spool->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&spool->lock, flags);
 	BUG_ON(!spool->count);
 	spool->count--;
-	unlock_or_release_subpool(spool);
+	unlock_or_release_subpool(spool, flags);
 }
 
 /*
@@ -156,7 +159,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 	if (!spool)
 		return ret;
 
-	spin_lock(&spool->lock);
+	spin_lock_irq(&spool->lock);
 
 	if (spool->max_hpages != -1) {		/* maximum size accounting */
 		if ((spool->used_hpages + delta) <= spool->max_hpages)
@@ -183,7 +186,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 	}
 
 unlock_ret:
-	spin_unlock(&spool->lock);
+	spin_unlock_irq(&spool->lock);
 	return ret;
 }
 
@@ -197,11 +200,12 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 				       long delta)
 {
 	long ret = delta;
+	unsigned long flags;
 
 	if (!spool)
 		return delta;
 
-	spin_lock(&spool->lock);
+	spin_lock_irqsave(&spool->lock, flags);
 
 	if (spool->max_hpages != -1)		/* maximum size accounting */
 		spool->used_hpages -= delta;
@@ -222,7 +226,7 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 	 * If hugetlbfs_put_super couldn't free spool due to an outstanding
 	 * quota reference, free it now.
 	 */
-	unlock_or_release_subpool(spool);
+	unlock_or_release_subpool(spool, flags);
 
 	return ret;
 }
@@ -1407,7 +1411,7 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-static void __free_huge_page(struct page *page)
+void free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
@@ -1417,6 +1421,7 @@ static void __free_huge_page(struct page *page)
 	int nid = page_to_nid(page);
 	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
 	bool restore_reserve;
+	unsigned long flags;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
@@ -1445,7 +1450,7 @@ static void __free_huge_page(struct page *page)
 			restore_reserve = true;
 	}
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	ClearHPageMigratable(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
@@ -1456,66 +1461,18 @@ static void __free_huge_page(struct page *page)
 
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
-		spin_unlock(&hugetlb_lock);
-	}
-}
-
-/*
- * As free_huge_page() can be called from a non-task context, we have
- * to defer the actual freeing in a workqueue to prevent potential
- * hugetlb_lock deadlock.
- *
- * free_hpage_workfn() locklessly retrieves the linked list of pages to
- * be freed and frees them one-by-one. As the page->mapping pointer is
- * going to be cleared in __free_huge_page() anyway, it is reused as the
- * llist_node structure of a lockless linked list of huge pages to be freed.
- */
-static LLIST_HEAD(hpage_freelist);
-
-static void free_hpage_workfn(struct work_struct *work)
-{
-	struct llist_node *node;
-	struct page *page;
-
-	node = llist_del_all(&hpage_freelist);
-
-	while (node) {
-		page = container_of((struct address_space **)node,
-				     struct page, mapping);
-		node = node->next;
-		__free_huge_page(page);
-	}
-}
-static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
-
-void free_huge_page(struct page *page)
-{
-	/*
-	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
-	 */
-	if (!in_task()) {
-		/*
-		 * Only call schedule_work() if hpage_freelist is previously
-		 * empty. Otherwise, schedule_work() had been called but the
-		 * workfn hasn't retrieved the list yet.
-		 */
-		if (llist_add((struct llist_node *)&page->mapping,
-			      &hpage_freelist))
-			schedule_work(&free_hpage_work);
-		return;
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
-
-	__free_huge_page(page);
 }
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
@@ -1525,11 +1482,11 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	hugetlb_set_page_subpool(page, NULL);
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	ClearHPageFreed(page);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 }
 
 static void prep_compound_gigantic_page(struct page *page, unsigned int order)
@@ -1775,7 +1732,7 @@ int dissolve_free_huge_page(struct page *page)
 	if (!PageHuge(page))
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHuge(page)) {
 		rc = 0;
 		goto out;
@@ -1792,7 +1749,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * when it is dissolved.
 		 */
 		if (unlikely(!HPageFreed(head))) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			cond_resched();
 
 			/*
@@ -1816,12 +1773,12 @@ int dissolve_free_huge_page(struct page *page)
 		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		update_and_free_page(h, head);
 		return 0;
 	}
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return rc;
 }
 
@@ -1863,16 +1820,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
 		goto out_unlock;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * We could have raced with the pool size change.
 	 * Double check that and simply deallocate the new page
@@ -1882,7 +1839,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetHPageTemporary(page);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		put_page(page);
 		return NULL;
 	} else {
@@ -1891,7 +1848,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	}
 
 out_unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return page;
 }
@@ -1941,17 +1898,17 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
 		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
 		if (page) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			return page;
 		}
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
@@ -1999,7 +1956,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	ret = -ENOMEM;
 retry:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
@@ -2016,7 +1973,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	 * After retaking hugetlb_lock, we need to recalculate 'needed'
 	 * because either resv_huge_pages or free_huge_pages may have changed.
 	 */
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) -
 			(h->free_huge_pages + allocated);
 	if (needed > 0) {
@@ -2056,12 +2013,12 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		enqueue_huge_page(h, page);
 	}
 free:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	/* Free unnecessary surplus pages to the buddy allocator */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru)
 		put_page(page);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	return ret;
 }
@@ -2111,9 +2068,9 @@ static void return_unused_surplus_pages(struct hstate *h,
 	}
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 }
 
 
@@ -2316,7 +2273,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 */
 	page_ref_dec(new_page);
 retry:
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHuge(old_page)) {
 		/*
 		 * Freed from under us. Drop new_page too.
@@ -2330,7 +2287,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Fail with -EBUSY if not possible.
 		 */
 		remove_hugetlb_page(h, new_page, false);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		update_and_free_page(h, new_page);
 		if (!isolate_huge_page(old_page, list))
 			ret = -EBUSY;
@@ -2341,7 +2298,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * freelist yet. Race window is small, so we can succed here if
 		 * we retry.
 		 */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		cond_resched();
 		goto retry;
 	} else {
@@ -2357,7 +2314,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		page_to_free = old_page;
 	}
 unlock_free:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_page(h, page_to_free);
 
 	return ret;
@@ -2374,15 +2331,15 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	 * to carefully check the state under the lock.
 	 * Return success when racing as if we dissolved the page ourselves.
 	 */
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (PageHuge(page)) {
 		head = compound_head(page);
 		h = page_hstate(head);
 	} else {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		return 0;
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	/*
 	 * Fence off gigantic pages as there is a cyclic dependency between
@@ -2462,7 +2419,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * glb_chg is passed to indicate whether or not a page must be taken
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
@@ -2470,7 +2427,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 	if (!page) {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
 		if (!page)
 			goto out_uncharge_cgroup;
@@ -2478,7 +2435,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		list_add(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
@@ -2491,7 +2448,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 						  h_cg, page);
 	}
 
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	hugetlb_set_page_subpool(page, spool);
 
@@ -2703,9 +2660,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	}
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
@@ -2770,7 +2727,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * pages in hstate via the proc/sysfs interfaces.
 	 */
 	mutex_lock(&h->resize_lock);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	/*
 	 * Check for a node specific request.
@@ -2801,7 +2758,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 */
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->resize_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
@@ -2831,14 +2788,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		 * page, free_huge_page will handle it by freeing the page
 		 * and reducing the surplus.
 		 */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
 		ret = alloc_pool_huge_page(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		if (!ret)
 			goto out;
 
@@ -2877,9 +2834,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		list_add(&page->lru, &page_list);
 	}
 	/* free the pages after dropping lock */
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
@@ -2887,7 +2844,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	mutex_unlock(&h->resize_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
@@ -3043,9 +3000,9 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	if (err)
 		return err;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h->nr_overcommit_huge_pages = input;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return count;
 }
@@ -3632,9 +3589,9 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		goto out;
 
 	if (write) {
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		h->nr_overcommit_huge_pages = tmp;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 	}
 out:
 	return ret;
@@ -3730,7 +3687,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	if (!delta)
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * When cpuset is configured, it breaks the strict hugetlb page
 	 * reservation as the accounting is done on a global variable. Such
@@ -3769,7 +3726,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 		return_unused_surplus_pages(h, (unsigned long) -delta);
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
 
@@ -5833,7 +5790,7 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHeadHuge(page) ||
 	    !HPageMigratable(page) ||
 	    !get_page_unless_zero(page)) {
@@ -5843,16 +5800,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	ClearHPageMigratable(page);
 	list_move_tail(&page->lru, list);
 unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
 
 void putback_active_hugepage(struct page *page)
 {
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	put_page(page);
 }
 
@@ -5886,12 +5843,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		 */
 		if (new_nid == old_nid)
 			return;
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
 			h->surplus_huge_pages_node[old_nid]--;
 			h->surplus_huge_pages_node[new_nid]++;
 		}
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 	}
 }
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 726b85f4f303..5383023d0cca 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -204,11 +204,11 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	do {
 		idx = 0;
 		for_each_hstate(h) {
-			spin_lock(&hugetlb_lock);
+			spin_lock_irq(&hugetlb_lock);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);
 
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			idx++;
 		}
 		cond_resched();
@@ -784,7 +784,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	if (hugetlb_cgroup_disabled())
 		return;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h_cg = hugetlb_cgroup_from_page(oldhpage);
 	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
 	set_hugetlb_cgroup(oldhpage, NULL);
@@ -794,7 +794,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	set_hugetlb_cgroup(newhpage, h_cg);
 	set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return;
 }
 
-- 
2.30.2

