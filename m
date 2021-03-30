Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3834F527
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhC3Xo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3XoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:44:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1EFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 16:44:20 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g20so17732133qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=tbt+Wr8D7RF2IDMuf+UsIa6Y7VNe6gu7kB9zX9lwwNE=;
        b=UTLkqaoPxsFd4hVxfCdR4/TwI2Gqit6rdTdr54qg+p87gUukGjLYevnzXuEQYfzSW0
         2AVylzrW6aV3dSiymbrpuA5XVQT/8TXwTXNOAPIUMmc92xmQ8cy9gR4oTEqx6XvsAK1N
         ELjan+5IpdZCuNq0ef9fUSZy2O8Fa5PwNT6OP7RgAlcbFAZBTooMhKlJjXFyIEhpkUO4
         jlYTsG0y1ELm0rUGFWPMXVV5KJeD9EO6j0eJ9cmJ431Zox287eN1Jja5hMQ27FGrI9za
         3XXLiKEhQFylKIPT0L45eSSu+df+zc0gVd6NUIOFNXYdcPOyUP0Eo3e4p9QjId/Y1ZTL
         lXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=tbt+Wr8D7RF2IDMuf+UsIa6Y7VNe6gu7kB9zX9lwwNE=;
        b=qFBGOLrMu0Po4+YBy/bitLZK4SubKydSJ4So0zZwa4DYKHROv/oPMoZWVRWVuDGwCF
         LVO08SUcJz7uc9hFXi/wdGdmoKIGdhFrC73BZIdXBPWXScvjHJw7ZXpS/DlaDhzNqlAa
         /Ne9GPVG+svKH81eIWhq34kx3VgUEd607LpLq+AsUn+1pLaVDdgQeutAR3IeSG2+O/1G
         g5j0MHMisu1NmeeetPC/14gyG3Cg40DCbS0plFp/a+0Z0HKOnsFP8HAMQRNN42gIFNtu
         hMXqpzXlTPxxfB8zXpN7aGj9eX8cZN3gaGyFo/VMNh0r0Okv7F1e24QK3K8hW94XbHGv
         EGRw==
X-Gm-Message-State: AOAM533l1gg7TaHuSdSrY3mta+izN4Y9+luo78kAN0A9aebOY26ZZNnX
        MsVK/6EyGwVjrqV9RQ+fpwS9Yw==
X-Google-Smtp-Source: ABdhPJxc2JvaxYgZNwYGkXF4tE1bYB17KkgQNOLk/2jDXZ1LJvy3WOa5yUT2vjyFydYzzJQ7A7mICA==
X-Received: by 2002:a37:42cb:: with SMTP id p194mr690996qka.213.1617147859029;
        Tue, 30 Mar 2021 16:44:19 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j129sm228556qkf.110.2021.03.30.16.44.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 30 Mar 2021 16:44:18 -0700 (PDT)
Date:   Tue, 30 Mar 2021 16:44:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     kernel test robot <oliver.sang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: [PATCH mmotm] mm: vmscan: fix shrinker_rwsem in
 free_shrinker_info()
Message-ID: <alpine.LSU.2.11.2103301640240.2584@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep warns mm/vmscan.c: suspicious rcu_dereference_protected() usage!
when free_shrinker_info() is called from mem_cgroup_css_free(): there it
is called with no locking, whereas alloc_shrinker_info() calls it with
down_write of shrinker_rwsem - which seems appropriate.  Rearrange that
so free_shrinker_info() can manage the shrinker_rwsem for itself.

Link: https://lkml.kernel.org/r/20210317140615.GB28839@xsang-OptiPlex-9020
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Yang Shi <shy828301@gmail.com>
---
Sorry, I've made no attempt to work out precisely where in the series
the locking went missing, nor tried to fit this in as a fix on top of
mm-vmscan-add-shrinker_info_protected-helper.patch
which Oliver reported (and which you notated in mmotm's "series" file).
This patch just adds the fix to the end of the series, after
mm-vmscan-shrink-deferred-objects-proportional-to-priority.patch

 mm/vmscan.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- mmotm/mm/vmscan.c	2021-03-28 17:26:54.935553064 -0700
+++ linux/mm/vmscan.c	2021-03-30 15:55:13.374459559 -0700
@@ -249,18 +249,20 @@ void free_shrinker_info(struct mem_cgrou
 	struct shrinker_info *info;
 	int nid;
 
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		info = shrinker_info_protected(memcg, nid);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
+	up_write(&shrinker_rwsem);
 }
 
 int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
-	int nid, size, ret = 0;
+	int nid, size;
 	int map_size, defer_size = 0;
 
 	down_write(&shrinker_rwsem);
@@ -270,9 +272,9 @@ int alloc_shrinker_info(struct mem_cgrou
 	for_each_node(nid) {
 		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
 		if (!info) {
+			up_write(&shrinker_rwsem);
 			free_shrinker_info(memcg);
-			ret = -ENOMEM;
-			break;
+			return -ENOMEM;
 		}
 		info->nr_deferred = (atomic_long_t *)(info + 1);
 		info->map = (void *)info->nr_deferred + defer_size;
@@ -280,7 +282,7 @@ int alloc_shrinker_info(struct mem_cgrou
 	}
 	up_write(&shrinker_rwsem);
 
-	return ret;
+	return 0;
 }
 
 static inline bool need_expand(int nr_max)
