Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792DB3D8544
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhG1BWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhG1BWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:22:49 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0CC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:22:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mu13-20020a17090b388db02901769cf3d01aso1229259pjb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KmGPLe7yWyGg+5xBmJJBJmFQBI3nGe2qI3u2htSZRc8=;
        b=nuhUlmTMHBefTVNrgYI+UtWHFhAeUZ55sBhNa0QX9fumm4mflb1V6DbSoHCRW6t06r
         onMeMgc+EcsYHFi0X4PcAOFTt1Ca4GWOMdzhbbiOrGVTrb0+gtM9N1DnIZxhXv8HlftC
         DJSqiUVC7neopxxFodop5YR1Gled3AwZiXE7gKa9y/fs3sAr5ZECb/Puda3R9v+/bkI+
         nb00mP95Ua0jnx3xuMqkU9/WGjDryEYGUuk5L5v/oC3oUWmi5Da3evvFfquWnPH15h+y
         PKiZUtUG5Qb4p9eZ7PCfY2pcvyOh2brxBgAENIFwi2xJrsLT1ESfcW03z9V4K8U/cP8u
         YJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KmGPLe7yWyGg+5xBmJJBJmFQBI3nGe2qI3u2htSZRc8=;
        b=jma3MlQMHbpbA3J1uc3bPAEek70dBZ0IHekaGE7uz3fJuXOpXSkGnTyFb2hajaQPAl
         ck7oXlPrmuyEb8EI6WHsGQWLVr++hrgVoj6TClCRtrf/dO+3MSV0YCM78yP6oKyIBVPO
         NfNSiIA1S5UE+VOjjnr3Ufr/5zDyOZMkB/5ytzSE8+KwC1DqVTHgMRqERMfKIbLn3D4B
         jqaU8MH6fS+uv0J1x8WRhNZF3BBpTcClRn+Kmwqse/RHHGaiGV27r4S+NoWqjnv6zHiY
         rZXL/kLwNEpZ0qWsny89Fi3dYgyaoICW+p0/679ehn6Hs/0Buh2y9eIH/BbhRVgpU9Hd
         VGDg==
X-Gm-Message-State: AOAM530ecnvY5JcDnX1WB9FwPJJS9jp/7L/thrOLlAEo7W1xLIEa7L5+
        6LquggcdBY5LL3qITvY43UaHGerMr7pMSA==
X-Google-Smtp-Source: ABdhPJzw9SOwdwjV0WZ2MCa+P1MfPRGVFwKeQeenXU6wTjTUOggsSdYuRL9EvyC6Q1eQ/xQYrxL51Z0AKSHI7w==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:40e2:477f:2bc7:716c])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:3489:: with SMTP id
 p9mr13744551pjb.4.1627435368045; Tue, 27 Jul 2021 18:22:48 -0700 (PDT)
Date:   Tue, 27 Jul 2021 18:22:43 -0700
Message-Id: <20210728012243.3369123-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] memcg: cleanup racy sum avoidance code
From:   Shakeel Butt <shakeelb@google.com>
To:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have per-cpu memcg and lruvec stats and the readers have to
traverse and sum the stats from each cpu. This summing was racy and may
expose transient negative values. So, an explicit check was added to
avoid such scenarios. Now these stats are moved to rstat infrastructure
and are no more per-cpu, so we can remove the fixup for transient
negative values.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7028d8e4a3d7..5f2a39a43d47 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -991,30 +991,19 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
-	long x = READ_ONCE(memcg->vmstats.state[idx]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
+	return READ_ONCE(memcg->vmstats.state[idx]);
 }
 
 static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 					      enum node_stat_item idx)
 {
 	struct mem_cgroup_per_node *pn;
-	long x;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats.state[idx]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
+	return READ_ONCE(pn->lruvec_stats.state[idx]);
 }
 
 static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
-- 
2.32.0.432.gabb21c7263-goog

