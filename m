Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D169B36F37E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 03:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhD3B0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:26:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30658 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhD3B0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:26:17 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13U1K0d6013067;
        Thu, 29 Apr 2021 18:25:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hFjXnlD1yIcDaTPa0ZdVOW/34gUfaEySCHKTpQg6pPY=;
 b=bxVCQbhqhzgMoXiLzoAkmx4fYVNkzvYDrZTzMv2LtZQjGhYRau/FTv8PGxNqOSj5pJDB
 8iJV3LuiNLGEMfXlCVKceMeL6MHbJ52+c+uP5QpikhX2aLJyc5mQ8XP4juG4iHIS0Im4
 Kjy7lNtnk3DZ8TpXlFShjTQVzk1r9OVqV34= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 387a5ft56t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 18:25:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 18:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP/8Gl8MWgj5kPz9hPY2A2paE3aRwzJFOYvByY6yGn7Xo8n3aLAcdgXxJud03kiWVma785bTF2WnmNCZBn0PXUtIXY2jRQYH3KWpeyK6blR0znVVkuq/9oFuqsogDCng2LlUIClCjFVHiq2qBShnUmOb4cuftN2Gos0WYm7dSghwJuPj+etVyWqDpA2NaeHmvnGkQnKrC7iaxHW2r9N3DDbv0lDn9uPtobP4EQDEmNuvdnInIVWjxofVzI3DnicQB8QI6hLbJbeHTRIHBUcGtq8XkRSJL0lCoq6qxPUyIkYMgXvSBbneUL9qmzLDwhtjZfmo6hZ7fjM8i3dGS3e7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjXnlD1yIcDaTPa0ZdVOW/34gUfaEySCHKTpQg6pPY=;
 b=lC9BfdxulKSN6wkqIo1yrqkichmoIt6l376Qo4tbSvMVgXMkYVKCBDkiIE17aaMpr8T0g9iQPU8L+6nvl1aelsa5y3UGiKqoEU7ohi3p1408mi76gjJy3FnboOnshqkRgUZebxzkAkmajgg65gD6xiFxwydjo0EQJKGnlwerdEHR3YR1JoaOyI909pjux9o+yPLRwyn4jhoHupWacC6wlsxjzxB7Uz3PWW51uCAjsORsER/ZS6qUgZft93GQxQhZ/CflacVEw+zxPriOQbqXwhdfROvnfW4guMFgFMFh9wYMd59o2TKbYxjBEggMmbAX9CTOAdkPsZC2sG747iz08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3604.namprd15.prod.outlook.com (2603:10b6:a03:1b1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 01:25:21 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.025; Fri, 30 Apr 2021
 01:25:21 +0000
Date:   Thu, 29 Apr 2021 18:25:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Dennis Zhou <dennis@kernel.org>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210427073448.GD32408@xsang-OptiPlex-9020>
X-Originating-IP: [2620:10d:c090:400::5:75c0]
X-ClientProxiedBy: MWHPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:300:116::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:75c0) by MWHPR07CA0024.namprd07.prod.outlook.com (2603:10b6:300:116::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 01:25:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ceb2e2b-5276-4c31-8009-08d90b76d267
X-MS-TrafficTypeDiagnostic: BY5PR15MB3604:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3604BD0A331D4861EDA63F02BE5E9@BY5PR15MB3604.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZgYKp862/8YsOqc+Eb5y7JD1pbj+KgfdjmReYDc478ewiE9ggdkcNt3kwgGMlKCm5C11lYb+7dr8Pld6ztJssd9TqxppCHTeYCZcL7JRA234WFhjgqqlVCmbMnPuGtP8DC19NkPQHx6oBcdFR5sq+uuZF/hhvgNOPT1fpVd9F+CDQcC4COl6nQSczX136LbHNsj9vt+imvHgvbtIMKsMHWZSeuzafIBA68ngFoHzoo3pfE+DJzH34gZag9aJf+kRS1Xny3lrQFpbC/tIU6cgvoD52vaCFmE2xlTDpEEkpv2u+Ibj7kQwP4YVqVCA5YW0rtzP5/XMwm2gyrtgDjnC1qDE/o7bcDxM8K6K2l7cii9CouGUvfPCEXZGlgzhjVurpel88yfapIuvgX5h+prW2TZwGgMEukwBNTtdYuu5pD5LqPo5JOUYRU+LZE54XuszJDbu9OFPP/fZfYuFNUWVIU2CNIol84zCUrNjtBXOF5JtFrEL7bmQmh8sRR8EMPW/RKEWHoSDuOCJdiBJeNSYYyIqDDCePF1BbijE9PcyThMX/yZn9SWfkX7vkMxvPH1DFC87Aa4e12rFpVSyiRzpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(38100700002)(16526019)(186003)(316002)(66556008)(2906002)(54906003)(83380400001)(6916009)(66946007)(9686003)(66476007)(478600001)(6666004)(7696005)(8676002)(6506007)(52116002)(4326008)(55016002)(53546011)(8936002)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aIMHqUlp4jHDGGzYXrO6CEvCN60dLvnKiKf81w+PHBk/Wq+u04LEuMZoXMxo?=
 =?us-ascii?Q?8vOwcughnLz7mAHf7Ne21xg5rbIMFdR/OnbSsYUaZP31WSX3uSF9re61XYZJ?=
 =?us-ascii?Q?bJx5fNsGH4AvPPbz0bt/Z+3QYe5PbeZrbBnK3rotXDu3Sq0GhZpwwaMy4Jvl?=
 =?us-ascii?Q?CnhwzgPAuanVEQ9vpnAf2Exnb19o438lyEIyRvMLVA+Z07GaqHWAuXqz/TGX?=
 =?us-ascii?Q?y/9ZyCP8YzrV+qdvVq2qfO7gm0JJbmAE2+Yl1eqJ9SHAauj+yN0rcxO0Xwy1?=
 =?us-ascii?Q?3541tGt2uzXTy+XdKqQfGUVEOLf0QGCN0ygytEs+0mSCGvdZBfANhqZ69W1Q?=
 =?us-ascii?Q?y46T40C1Z6g7XF4watZWN/RgoWWISY1ZDHEdRwxqMno3tletfNrs51Q4HOPk?=
 =?us-ascii?Q?J6kzytTz1OJa9UV1237qGEDpDQTsNx5Okwk+K+/FPo/kAecAJ3ps+kOxi4vr?=
 =?us-ascii?Q?dnT1aztVbULYtLmF4D2YJnTlqMBVandtLUsfWZ+Rr3N5ug7N2+MAQj/PQnk0?=
 =?us-ascii?Q?28oehY/dM/TpmwHXFOYCK4h5mkV/SXtnuSbVs5xmHhMDWP9/e9ttTBiyRlXI?=
 =?us-ascii?Q?30nK5ecuFrycb1k/T1KkiFtSfluf/99Oj1a3enr+RoqX/f4gh0ojHzaCxk60?=
 =?us-ascii?Q?SpX6PnI+WC8xolA4Oc8F3oaMV6lROlgTJEYa+CKGAqyEwY3MhwHQLlwtYmfU?=
 =?us-ascii?Q?J0JLVO4CEwFQy56X73DFKFdoOeiYMk391e+fQpzkIdItLscmxrH0tBva6M/R?=
 =?us-ascii?Q?xzMhPngLHzGpFXPO8OdOIgxiX3ebflEdYFV/M9UjDfoQ23Wj7aLwTILB4Ik9?=
 =?us-ascii?Q?6dCHKBDG8CMv7FOsZLQoS31EzM9R+CuPO19eMWpoHov4+837wQ3JhyyQ42dZ?=
 =?us-ascii?Q?tA6SsZ2rnpQrDy1d1jU94vurJXVB9SHJbpMbGOEYREhnFSADz/vwg6p6voH0?=
 =?us-ascii?Q?6/RHbZcrLVxgAOIXNGa9TKCBiuMMWfPGSmixqKzwtXjXjt13B1Em/rG6u6Hg?=
 =?us-ascii?Q?R86jRhHvV4CuUJQiRfWtaDhooclROPRbwWi+PetTZvvJZ2HDIHG7/V/9Uw9H?=
 =?us-ascii?Q?pN0M38upmTxi1xE7Xi9E0uaE3hVC0s+3OqraJBqHV7DKgyl/4lu+Fikhyf7X?=
 =?us-ascii?Q?T6csp5WFAFzCwBFXmSLI/r/fJzRmTd17X1twzpLBvuNniV+SVUR3QF0TdHqV?=
 =?us-ascii?Q?2HOxGwaATB3FUfpmY5GhZfdVUTHLTpJ6ZkdWAaKsJJNiW/IhZO/evSv8v53m?=
 =?us-ascii?Q?alid42nxrFz8HMvXtHuMMliauWHEYgvR4e7ScW7fScXGi8SJ9aD5GClqeT43?=
 =?us-ascii?Q?7MesyOwkxLH8T7wMrfifWuTFTwKKYi/0P9PuL+9kX5XhfQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceb2e2b-5276-4c31-8009-08d90b76d267
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 01:25:21.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VlZNTAbO9s5kmW/ftbGPC1twpaQEkWb3PUOHfSn6q7Z+SxJpAKyikPlfBZXmmVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3604
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: OYrCkUijFWM8jriJw2-gtnMVrfsDfKfK
X-Proofpoint-ORIG-GUID: OYrCkUijFWM8jriJw2-gtnMVrfsDfKfK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_13:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:34:48PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -2.3% regression of aim9.sync_disk_rw.ops_per_sec due to commit:

Wow, that's very surprising, given that there are no pcpu allocations on any hot
paths there.

I tried hard to reproduce it, and I think I see something, however the data is
very noisy. I'm not sure I can confidently attribute the regression to
ace7e70901 ("percpu: use reclaim threshold instead of running for every page")
rather than
f183324133 ("percpu: implement partial chunk depopulation").

Anyway, in my setup the following patch seems to fix the regression.
Is it possible to test it?

Thank you!

Roman

--

From 6ee182110126cf93cf43389923bcf49ba12cb9a0 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 29 Apr 2021 18:01:40 -0700
Subject: [PATCH] percpu: optimize locking in pcpu_balance_workfn()

pcpu_balance_workfn() unconditionally calls pcpu_balance_free(),
pcpu_reclaim_populated(), pcpu_balance_populated() and
pcpu_balance_free() again.

Each call to pcpu_balance_free() and pcpu_reclaim_populated() will
cause at least one acquisition of the pcpu_lock. So even if the
balancing was scheduled because of a failed atomic allocation,
pcpu_lock will be acquired at least 4 times. This obviously
increases the contention on the pcpu_lock.

To optimize the scheme let's grab the pcpu_lock on the upper level
(in pcpu_balance_workfn()) and keep it generally locked for the whole
duration of the scheduled work, but release conditionally to perform
any slow operations like chunk (de)population and creation of new chunks.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 245d89f6f0a9..f6bc8157cb3e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2005,6 +2005,9 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
  * If empty_only is %false, reclaim all fully free chunks regardless of the
  * number of populated pages.  Otherwise, only reclaim chunks that have no
  * populated pages.
+ *
+ * CONTEXT:
+ * pcpu_lock (can be dropped temporarily)
  */
 static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
 {
@@ -2013,12 +2016,12 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
 	struct list_head *free_head = &pcpu_slot[pcpu_free_slot];
 	struct pcpu_chunk *chunk, *next;
 
+	lockdep_assert_held(&pcpu_lock);
+
 	/*
 	 * There's no reason to keep around multiple unused chunks and VM
 	 * areas can be scarce.  Destroy all free chunks except for one.
 	 */
-	spin_lock_irq(&pcpu_lock);
-
 	list_for_each_entry_safe(chunk, next, free_head, list) {
 		WARN_ON(chunk->immutable);
 
@@ -2030,8 +2033,10 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
 			list_move(&chunk->list, &to_free);
 	}
 
-	spin_unlock_irq(&pcpu_lock);
+	if (list_empty(&to_free))
+		return;
 
+	spin_unlock_irq(&pcpu_lock);
 	list_for_each_entry_safe(chunk, next, &to_free, list) {
 		unsigned int rs, re;
 
@@ -2045,6 +2050,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
 		pcpu_destroy_chunk(chunk);
 		cond_resched();
 	}
+	spin_lock_irq(&pcpu_lock);
 }
 
 /**
@@ -2056,6 +2062,9 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
  * OOM killer to be triggered.  We should avoid doing so until an actual
  * allocation causes the failure as it is possible that requests can be
  * serviced from already backed regions.
+ *
+ * CONTEXT:
+ * pcpu_lock (can be dropped temporarily)
  */
 static void pcpu_balance_populated(enum pcpu_chunk_type type)
 {
@@ -2065,6 +2074,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
 	struct pcpu_chunk *chunk;
 	int slot, nr_to_pop, ret;
 
+	lockdep_assert_held(&pcpu_lock);
+
 	/*
 	 * Ensure there are certain number of free populated pages for
 	 * atomic allocs.  Fill up from the most packed so that atomic
@@ -2092,13 +2103,11 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
 		if (!nr_to_pop)
 			break;
 
-		spin_lock_irq(&pcpu_lock);
 		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
 			nr_unpop = chunk->nr_pages - chunk->nr_populated;
 			if (nr_unpop)
 				break;
 		}
-		spin_unlock_irq(&pcpu_lock);
 
 		if (!nr_unpop)
 			continue;
@@ -2108,12 +2117,13 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
 					     chunk->nr_pages) {
 			int nr = min_t(int, re - rs, nr_to_pop);
 
+			spin_unlock_irq(&pcpu_lock);
 			ret = pcpu_populate_chunk(chunk, rs, rs + nr, gfp);
+			cond_resched();
+			spin_lock_irq(&pcpu_lock);
 			if (!ret) {
 				nr_to_pop -= nr;
-				spin_lock_irq(&pcpu_lock);
 				pcpu_chunk_populated(chunk, rs, rs + nr);
-				spin_unlock_irq(&pcpu_lock);
 			} else {
 				nr_to_pop = 0;
 			}
@@ -2125,11 +2135,12 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
 
 	if (nr_to_pop) {
 		/* ran out of chunks to populate, create a new one and retry */
+		spin_unlock_irq(&pcpu_lock);
 		chunk = pcpu_create_chunk(type, gfp);
+		cond_resched();
+		spin_lock_irq(&pcpu_lock);
 		if (chunk) {
-			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_relocate(chunk, -1);
-			spin_unlock_irq(&pcpu_lock);
 			goto retry_pop;
 		}
 	}
@@ -2146,6 +2157,10 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
  * populated pages threshold, reintegrate the chunk if it has empty free pages.
  * Each chunk is scanned in the reverse order to keep populated pages close to
  * the beginning of the chunk.
+ *
+ * CONTEXT:
+ * pcpu_lock (can be dropped temporarily)
+ *
  */
 static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
 {
@@ -2155,7 +2170,7 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
 	LIST_HEAD(to_depopulate);
 	int i, end;
 
-	spin_lock_irq(&pcpu_lock);
+	lockdep_assert_held(&pcpu_lock);
 
 	list_splice_init(&pcpu_slot[pcpu_to_depopulate_slot], &to_depopulate);
 
@@ -2231,8 +2246,6 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
 				      &pcpu_slot[pcpu_to_depopulate_slot]);
 		pcpu_schedule_balance_work();
 	}
-
-	spin_unlock_irq(&pcpu_lock);
 }
 
 /**
@@ -2256,10 +2269,14 @@ static void pcpu_balance_workfn(struct work_struct *work)
 	 */
 	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
 		mutex_lock(&pcpu_alloc_mutex);
+		spin_lock_irq(&pcpu_lock);
+
 		pcpu_balance_free(type, false);
 		pcpu_reclaim_populated(type);
 		pcpu_balance_populated(type);
 		pcpu_balance_free(type, true);
+
+		spin_unlock_irq(&pcpu_lock);
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 }
-- 
2.30.2
