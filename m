Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C013734220F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhCSQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhCSQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:38:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AC3C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k24so4047226pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1x9F0RxytCzXg/daJ/mfbteZTYPjROB2MKRFPS4wa0=;
        b=DEMZOb2ZxxtpsbPJtNeCUdXVflxX0xnzNmd0okHPwRSj8fPXt7AUSn/411t7ZnSc1V
         mE6TsuZKMqrrwsil/GbrCJeIPHzCu+25dTYIxKzm72VWt6NO59WeZZ/QsJXqR4CRuZqT
         GBQHQIn2nlJmGOJnLFb4R9rm8pEvGE2Fj31DotWldMM1g9KRLtxBLhv0rtLzgXoYMTad
         ACquv1g/mbCZGDrX0KrYzoofSH5h9SeC1S2Qdo5hDoHUV/ZeC5WIruC2QrNrjBoJTyO8
         vZ/tDIROyr5ka6LxC/5tIDXSLbKKMHZ8l6DyHC79+09L6/f/bFKZHMYFCJqtclTkXpT6
         T12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1x9F0RxytCzXg/daJ/mfbteZTYPjROB2MKRFPS4wa0=;
        b=IjB/UAfvBUHIG23nXSUjYTOTlqQK5h5tlZevxEqiJrdAz6rpmprUJe+bvBBWVFyYNT
         e2hC8pX8/JelkNrZhYzLcpgTKePcI+y/3UbijbyGlw8ZqcrAOkceUCEl4D7CkTonNh3T
         gBZk0BT8XvzeJuXcOo1demxMXKtGCABdhh5M6uBe3UMMdz3PtF1t72hebgqt4KOJHuXU
         xUS8SRc2z7RJWuKSw4I+u7HjhvOMsDxjnrXFbAu0H+28PpsJwmFvYwl1k4tMJ0wUdSaH
         u4aTf4CJSR6SZ50zWK0ptdfaZGAmNNohLjmahbGlvCyfj+jrFMc3/x0Qn2+j7BP1iu2M
         UTZQ==
X-Gm-Message-State: AOAM530B8pjvYicgAt8OAb/HbSU4+94/z4kpC81TyI6T+4gWr0loN/vj
        Ka0Dn+h54EFzuNXvy9sFhVjkWQcWQepVCbzm
X-Google-Smtp-Source: ABdhPJzv6KoFJsnEXmVe1wLnx5vlmo8q+uLsN4x2hPYnirz8Y5YOPeFFmr8wTjnjzbdpJXF6MUvWAQ==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr11855982pgh.55.1616171922411;
        Fri, 19 Mar 2021 09:38:42 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.38.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:38:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 1/7] mm: memcontrol: slab: fix obtain a reference to a freeing memcg
Date:   Sat, 20 Mar 2021 00:38:14 +0800
Message-Id: <20210319163821.20704-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210319163821.20704-1-songmuchun@bytedance.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_read_lock/unlock only can guarantee that the memcg will not be
freed, but it cannot guarantee the success of css_get (which is in the
refill_stock when cached memcg changed) to memcg.

  rcu_read_lock()
  memcg = obj_cgroup_memcg(old)
  __memcg_kmem_uncharge(memcg)
      refill_stock(memcg)
          if (stock->cached != memcg)
              // css_get can change the ref counter from 0 back to 1.
              css_get(&memcg->css)
  rcu_read_unlock()

This fix is very like the commit:

  eefbfa7fd678 ("mm: memcg/slab: fix use after free in obj_cgroup_charge")

Fix this by holding a reference to the memcg which is passed to the
__memcg_kmem_uncharge() before calling __memcg_kmem_uncharge().

Fixes: 3de7d4f25a74 ("mm: memcg/slab: optimize objcg stock draining")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 845eec01ef9d..2cda76ff0629 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3181,9 +3181,17 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
 		if (nr_pages) {
+			struct mem_cgroup *memcg;
+
 			rcu_read_lock();
-			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
+retry:
+			memcg = obj_cgroup_memcg(old);
+			if (unlikely(!css_tryget(&memcg->css)))
+				goto retry;
 			rcu_read_unlock();
+
+			__memcg_kmem_uncharge(memcg, nr_pages);
+			css_put(&memcg->css);
 		}
 
 		/*
-- 
2.11.0

