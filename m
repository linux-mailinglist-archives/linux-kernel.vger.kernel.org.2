Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5E35D869
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbhDMG7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245253AbhDMG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so832371pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FD/YxJiXhb6Cqn7dGyIHqv5BROgaaIUxtbd/p90WjE=;
        b=ON6KiOCCTjcGcoOkHzXj1pJvR4mRoIT7hOPDgNKxVoRqOyrfkENxRRwe4JEVHfsquX
         C2ptIpImrLFi01ukcvaePpwmBK17BAVtOXtrB6YFcnAPhRqTXiV1P8CSMiD4XceSPca+
         s1fdLLTorjlvdVo/4+UXWv9+E7DTlYF5dioGf4ptggNEwkXVFIuoC+DjpwU8R6am+CrW
         rFzwj4Z4H0oCd2o8/B05axkCMQokpYzyK7V0ZAMvP2N6+d1KDgtv0czSEw8qxd0L7nTK
         x2ezcfsydFc9sP/ADeSMpEWLLAvJaYth5Efr7oay0cNJm2TjjGROJqtkmIRQf4vXZq+r
         hliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FD/YxJiXhb6Cqn7dGyIHqv5BROgaaIUxtbd/p90WjE=;
        b=OpjjVoxj3to+CKIizLsnUiyRZ00D0afrDeJGzWAu+91S9wXEjeOUSnAl6fCmbYtJF7
         yHN9e8fqNPl5IL3fZB756gmYGiOgHZooJQXBBFp+cmDzrbhzCc8F+AxaAmqWY3rAyfiz
         qUMRKldddzE4kPk8W+77DShSQFmUcuR7Mw9QnbTlZgD5i6/DJl63F2I0vZNBIX6+0w4S
         dIy8Nmkq8KeTR4I6lOQiS0+mT8lk5RsT0NgP0DuBEtf7Hl/JRp9GmpDSbQPojWj6jeC9
         mWMJbJup3O0jF/ddCsEoWxjl2qcubeA+qFBknoj3ku1v5+Iqx+I+/tCI42Sdoh5vpKvY
         fAMw==
X-Gm-Message-State: AOAM530Fm1KHHjQ7eMTFdMF6QqEsRbjkQcRt20Q25qUAQdrmykxUiaup
        1LtudRXrzbLIVH60cJa8L66KXw==
X-Google-Smtp-Source: ABdhPJwzVPCZNKsdmtjXdTO2whihSoz7AxS92CX6eF1MOYBAjKNAw0sm3rds4M/24NuYVkeznKTcXg==
X-Received: by 2002:a17:90a:528b:: with SMTP id w11mr3371687pjh.162.1618297077558;
        Mon, 12 Apr 2021 23:57:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.57.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:57:57 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/7] mm: memcontrol: simplify the logic of objcg pinning memcg
Date:   Tue, 13 Apr 2021 14:51:51 +0800
Message-Id: <20210413065153.63431-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210413065153.63431-1-songmuchun@bytedance.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obj_cgroup_release() and memcg_reparent_objcgs() are serialized by
the css_set_lock. We do not need to care about objcg->memcg being
released in the process of obj_cgroup_release(). So there is no need
to pin memcg before releasing objcg. Remove those pinning logic to
simplfy the code.

There are only two places that modifies the objcg->memcg. One is the
initialization to objcg->memcg in the memcg_online_kmem(), another
is objcgs reparenting in the memcg_reparent_objcgs(). It is also
impossible for the two to run in parallel. So xchg() is unnecessary
and it is enough to use WRITE_ONCE().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1f807448233e..42d8c0f4ab1d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,7 +261,6 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
-	struct mem_cgroup *memcg;
 	unsigned int nr_bytes;
 	unsigned int nr_pages;
 	unsigned long flags;
@@ -291,11 +290,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	spin_lock_irqsave(&css_set_lock, flags);
-	memcg = obj_cgroup_memcg(objcg);
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 	list_del(&objcg->list);
-	mem_cgroup_put(memcg);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 
 	percpu_ref_exit(ref);
@@ -330,17 +327,12 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 
 	spin_lock_irq(&css_set_lock);
 
-	/* Move active objcg to the parent's list */
-	xchg(&objcg->memcg, parent);
-	css_get(&parent->css);
-	list_add(&objcg->list, &parent->objcg_list);
-
-	/* Move already reparented objcgs to the parent's list */
-	list_for_each_entry(iter, &memcg->objcg_list, list) {
-		css_get(&parent->css);
-		xchg(&iter->memcg, parent);
-		css_put(&memcg->css);
-	}
+	/* 1) Ready to reparent active objcg. */
+	list_add(&objcg->list, &memcg->objcg_list);
+	/* 2) Reparent active objcg and already reparented objcgs to parent. */
+	list_for_each_entry(iter, &memcg->objcg_list, list)
+		WRITE_ONCE(iter->memcg, parent);
+	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
 	spin_unlock_irq(&css_set_lock);
-- 
2.11.0

