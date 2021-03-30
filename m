Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6834E557
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhC3KWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhC3KVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:21:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD20C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso9220333pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bUVH6CYiEDE2OojiUwNW4YxUovgMumcyycakaekQOs=;
        b=rc7vxMSybQciv9/5dtRhvyJjfFL8C1QprmT4SwgF2AknzGU48EXo4+csaZ88DVCOXN
         HLlyMSTI83QInTdlLsM8wBPyhykOQhUA/6woR2kxUWN+MmoJVmdL1vS71CF8KVeKTdTJ
         PKc4xisUKrZmhoRDxyT2rRl3UDmkf6Lh7h8b9EYup+jepXkv/1CLnlPJ9UxibpwX715z
         Q+gfpkC4dMvYufZcIUNgZ6i/Z7ZQ3FLiey5sq6MfWLruvg6IU3TW2N+UxDLIGk6HM0eF
         wUMId628x41BQmLxwu9CJoCIODDjm7BlALZL17b24aZbF+qb/aSW2b9vu4AAJRFuAY28
         xwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bUVH6CYiEDE2OojiUwNW4YxUovgMumcyycakaekQOs=;
        b=Jk23iuk1vNvmbGVkzkqufHdXnpASojcCVZx0/uMDyl0deBRXsfXozu6h2z/opdnP8a
         nKUuqmsPHZtEI9Cg5tv7FUF9IKzcM1kafX5FRQSqHEIZvlopxPfE1hI5q7ck0kqfEbIB
         Fn32T+IOfpYDBSfiiv+FXTZbxiB4sGcH9+nSSB/5HOs7q8QATYcCGqjgV0hc5vKOKnI3
         1MT3p0BSARLHJAdBzIcPeh6TWQt1lGCOw0v0qIyA8JVzT389G0htq4mJcRH0CNXlGEI+
         glch2nEkYXoH7W52XiJKnTtiEwxhot3RJzVz9ZmRrYZcF6it/ayiLTPdouSAFC2YyUUG
         mCPQ==
X-Gm-Message-State: AOAM531M8KC+68wZEd59yEHOR0cHavrpqP6MMJo5yK/MLpHtIylg3HCh
        beE0a0IgGiUpLVphyjgrLUsF9g==
X-Google-Smtp-Source: ABdhPJwUaQ5H5WNHLQADgPnCOwmyrS9JVPM2onvAWbxdHSJgQZXin+hFD74iiQOLABz8q4nyQCLqCQ==
X-Received: by 2002:a17:902:c101:b029:e7:3268:6fed with SMTP id 1-20020a170902c101b02900e732686fedmr19897636pli.79.1617099715239;
        Tue, 30 Mar 2021 03:21:55 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:21:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 07/15] mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
Date:   Tue, 30 Mar 2021 18:15:23 +0800
Message-Id: <20210330101531.82752-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we reuse the objcg APIs to charge LRU pages, the page_memcg()
can be changed when the LRU pages reparented. In this case, we need
to acquire the new lruvec lock.

    lruvec = mem_cgroup_page_lruvec(page);

    // The page is reparented.

    compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);

    // Acquired the wrong lruvec lock and need to retry.

But compact_lock_irqsave() only take lruvec lock as the parameter,
we cannot aware this change. If it can take the page as parameter
to acquire the lruvec lock. When the page memcg is changed, we can
use the page_memcg() detect whether we need to reacquire the new
lruvec lock. So compact_lock_irqsave() is not suitable for us.
Similar to lock_page_lruvec_irqsave(), introduce
compact_lock_page_lruvec_irqsave() to acquire the lruvec lock in
the compaction routine.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/compaction.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8b8fc279766e..d6b7d5f90fce 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -511,6 +511,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+static struct lruvec *
+compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
+				 struct compact_control *cc)
+{
+	struct lruvec *lruvec;
+
+	lruvec = mem_cgroup_page_lruvec(page);
+
+	/* Track if the lock is contended in async mode */
+	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
+		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
+			goto out;
+
+		cc->contended = true;
+	}
+
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+out:
+	lruvec_memcg_debug(lruvec, page);
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -1001,10 +1024,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
-			locked = lruvec;
-
-			lruvec_memcg_debug(lruvec, page);
+			locked = compact_lock_page_lruvec_irqsave(page, &flags, cc);
+			lruvec = locked;
 
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
-- 
2.11.0

