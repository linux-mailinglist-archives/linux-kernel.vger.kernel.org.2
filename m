Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4604228F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhJENzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:55:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:57714 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236196AbhJENyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=+lz1/go95FssiI/cLhtGGYl9CHp3b3jFYmH54jsnHyI=; b=rBz4zQKu+pNWpq26plJ
        RkQg2gp595jIucfIjkMZBtUSmOs7SZEeLs/KfOtT7dvCvuI4YGwpxKVCV0hfRpVgnc6odjOAERqd9
        RDwgjl9weNDyd/9ehQYG1gUZcHLtkcBrdO3cBXBa97CLsy2Gv1+8QEYTvGE+/1oTS0lNJbEEM60=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mXkrw-0054Ue-Qr; Tue, 05 Oct 2021 16:52:32 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v3] memcg: prohibit unconditional exceeding the limit of
 dying tasks
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YUM+saaJEce0TJyF@dhcp22.suse.cz>
Message-ID: <b89715b5-6df7-34a3-f7b9-efa8e0eefd3e@virtuozzo.com>
Date:   Tue, 5 Oct 2021 16:52:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUM+saaJEce0TJyF@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory cgroup charging allows killed or exiting tasks to exceed the hard
limit. It is assumed that the amount of the memory charged by those
tasks is bound and most of the memory will get released while the task
is exiting. This is resembling a heuristic for the global OOM situation
when tasks get access to memory reserves. There is no global memory
shortage at the memcg level so the memcg heuristic is more relieved.

The above assumption is overly optimistic though. E.g. vmalloc can scale
to really large requests and the heuristic would allow that. We used to
have an early break in the vmalloc allocator for killed tasks but this
has been reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
the current task is killed""). There are likely other similar code paths
which do not check for fatal signals in an allocation&charge loop.
Also there are some kernel objects charged to a memcg which are not
bound to a process life time.

It has been observed that it is not really hard to trigger these
bypasses and cause global OOM situation.

One potential way to address these runaways would be to limit the amount
of excess (similar to the global OOM with limited oom reserves). This is
certainly possible but it is not really clear how much of an excess is
desirable and still protects from global OOMs as that would have to
consider the overall memcg configuration.

This patch is addressing the problem by removing the heuristic
altogether. Bypass is only allowed for requests which either cannot fail
or where the failure is not desirable while excess should be still
limited (e.g. atomic requests). Implementation wise a killed or dying
task fails to charge if it has passed the OOM killer stage. That should
give all forms of reclaim chance to restore the limit before the
failure (ENOMEM) and tell the caller to back off.

In addition, this patch renames should_force_charge() helper
to task_is_dying() because now its use is not associated witch forced
charging.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
v3: no functional changes, just improved patch description
v2: swicthed to patch version proposed by mhocko@
---
 mm/memcontrol.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6da5020a8656..87e41c3cac10 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -239,7 +239,7 @@ enum res_type {
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-static inline bool should_force_charge(void)
+static inline bool task_is_dying(void)
 {
 	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
 		(current->flags & PF_EXITING);
@@ -1575,7 +1575,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * A few threads which were not waiting at mutex_lock_killable() can
 	 * fail to bail out. Therefore, check again after holding oom_lock.
 	 */
-	ret = should_force_charge() || out_of_memory(&oc);
+	ret = task_is_dying() || out_of_memory(&oc);
 
 unlock:
 	mutex_unlock(&oom_lock);
@@ -2530,6 +2530,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	enum oom_status oom_status;
 	unsigned long nr_reclaimed;
+	bool passed_oom = false;
 	bool may_swap = true;
 	bool drained = false;
 	unsigned long pflags;
@@ -2564,15 +2565,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_ATOMIC)
 		goto force;
 
-	/*
-	 * Unlike in global OOM situations, memcg is not in a physical
-	 * memory shortage.  Allow dying and OOM-killed tasks to
-	 * bypass the last charges so that they can exit quickly and
-	 * free their memory.
-	 */
-	if (unlikely(should_force_charge()))
-		goto force;
-
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
@@ -2630,8 +2622,9 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
-	if (fatal_signal_pending(current))
-		goto force;
+	/* Avoid endless loop for tasks bypassed by the oom killer */
+	if (passed_oom && task_is_dying())
+		goto nomem;
 
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
@@ -2640,14 +2633,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
 		       get_order(nr_pages * PAGE_SIZE));
-	switch (oom_status) {
-	case OOM_SUCCESS:
+	if (oom_status == OOM_SUCCESS) {
+		passed_oom = true;
 		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
-	case OOM_FAILED:
-		goto force;
-	default:
-		goto nomem;
 	}
 nomem:
 	if (!(gfp_mask & __GFP_NOFAIL))
-- 
2.31.1

