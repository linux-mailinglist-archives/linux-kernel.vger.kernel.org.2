Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605B2432D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhJSFdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSFdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:33:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6CEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:31:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x61-20020a17090a6c4300b0019f789f61bdso938093pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bTvjpUw+v44xOQyiDOrpyeAvjeh0PeLGrrtEgDcXk3Q=;
        b=dzDW55/AvVnlnOTRCBhfh/tGgo76XZN41srQjHvzCV8HWKHeQUl76UeBzWr4ow9znv
         GbHVRcn3t3Mu5Uq3hIC9/nWqtB6WqMbf2s0e6/VCTqvR2/AwB2CtU/n/M9w3VYZdRBhq
         J1upNbqXuh4/AjocATvDn3++L8iqt+SJwXxXAif5MdvOIgMRpPDA9CsuExEyiojr0tjM
         EWYoOt7EwwP7oHQEW+307peBxBDxlzLeb/U/9j1la6EVJLh/QxgmhbeoUK/EwHcZaYEU
         OW/L17k0sIQPat0B5HbggmT0XjqX+c6kEGcvSnSSvXdHM8D9Jv+iYjkF3sFSDYv81cxA
         6AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bTvjpUw+v44xOQyiDOrpyeAvjeh0PeLGrrtEgDcXk3Q=;
        b=jc28sSjaPhuzzyWvSd2f5bsqZR/x0NEuxSJb119vWUqUtsgYPVjN/laGY9Y7CpfRbl
         2A2rucxUYw+9Tw0GcxiRnAOEQ7j66mXNGHsBy7aymcD+0+jjZmUH4zonSM7CtU0VL27h
         uNY1Rsuu4ypQXedgtlYUnfJKbHnFMpST2Qap8kLk5c+wBfiJIQdIUbA8eJtXAnaXVpoo
         /JlU89I+ecX9YUoERq1ktjW0Yi/9DnUqb6cGoTvN6/lKzqki6j2zzIrEo49hzcIufO+6
         GNgdcfpnkMeTakUI1CHZsBUTtzKV1AUOKVcRN4sHCoXU4E0Ucm3HLs9KIdOHNkS5h9me
         MePg==
X-Gm-Message-State: AOAM532uPr7GLsbQkUfzA82Cq9ZbfLhMT7MNey+p5ZO/2CVyVl112fae
        X+4Mj96nKV2JEa79Rb4vYm164XBrmdGxqA==
X-Google-Smtp-Source: ABdhPJzRX6EYJfwmw5Vuyhc9lAfK9sizun/NV2qiIXjkm66asup902s0JYOkrDdf6Q88RoiOVYhKWpMSzAYRig==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:6d48:cae4:d5cb:a596])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:188b:: with SMTP id
 mn11mr4167902pjb.170.1634621484796; Mon, 18 Oct 2021 22:31:24 -0700 (PDT)
Date:   Mon, 18 Oct 2021 22:30:58 -0700
Message-Id: <20211019053058.2873615-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2] memcg, kmem: further deprecate kmem.limit_in_bytes
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deprecation process of kmem.limit_in_bytes started with the commit
0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
explains in detail the motivation behind the deprecation. To summarize,
it is the unexpected behavior on hitting the kmem limit. This patch
moves the deprecation process to the next stage by disallowing to set
the kmem limit. In future we might just remove the kmem.limit_in_bytes
file completely.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes since v1:
- Replaced EINVAL with ENOTSUPP on setting kmem limits.
- V1 was posted last year at [0].

[0] https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/

 .../admin-guide/cgroup-v1/memory.rst          |  6 ++--
 mm/memcontrol.c                               | 35 +++----------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 41191b5fb69d..9be961521743 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -87,10 +87,8 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
- memory.kmem.limit_in_bytes          set/show hard limit for kernel memory
-                                     This knob is deprecated and shouldn't be
-                                     used. It is planned that this be removed in
-                                     the foreseeable future.
+ memory.kmem.limit_in_bytes          This knob is deprecated and writing to
+                                     it will return -ENOTSUPP.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f1d9c028897..49a76049a885 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2999,7 +2999,6 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 				   unsigned int nr_pages)
 {
-	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	int ret;
 
@@ -3009,21 +3008,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
-	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
-
-		/*
-		 * Enforce __GFP_NOFAIL allocation because callers are not
-		 * prepared to see failures and likely do not have any failure
-		 * handling code.
-		 */
-		if (gfp & __GFP_NOFAIL) {
-			page_counter_charge(&memcg->kmem, nr_pages);
-			goto out;
-		}
-		cancel_charge(memcg, nr_pages);
-		ret = -ENOMEM;
-	}
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		page_counter_charge(&memcg->kmem, nr_pages);
 out:
 	css_put(&memcg->css);
 
@@ -3715,17 +3701,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-static int memcg_update_kmem_max(struct mem_cgroup *memcg,
-				 unsigned long max)
-{
-	int ret;
-
-	mutex_lock(&memcg_max_mutex);
-	ret = page_counter_set_max(&memcg->kmem, max);
-	mutex_unlock(&memcg_max_mutex);
-	return ret;
-}
-
 static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 {
 	int ret;
@@ -3791,10 +3766,8 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
 		case _KMEM:
-			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
-			ret = memcg_update_kmem_max(memcg, nr_pages);
+			/* kmem.limit_in_bytes is deprecated. */
+			ret = -ENOTSUPP;
 			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
-- 
2.33.0.1079.g6e70778dc9-goog

