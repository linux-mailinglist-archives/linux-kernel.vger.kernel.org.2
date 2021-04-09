Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568E3359EC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhDIMc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhDIMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F37C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:32:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso3114520pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEHZ5qG2Y9NIbhhZ3B17EZ5gBaH7ne5FjVmUdr7WNhw=;
        b=HhI9y7ykMy8qmjJd8T6jqQ4HxvvjCcyyeW1xVnQfYtZzlES1KSGQ85Q+DfM9GA7CQi
         SSIlTfC85Xfx/2gq/5GAnU3p9Foxs6ZApRZK2Ijcw2U8vzpqhy8cjpb9EaZgJEJf2Prs
         eX/U+LX5IkGaJlbTsgcf5zxP26U7l2ydVfxd865qVJYe7cdjeRVszFRwhdq/gNIwuJgm
         pCBHrk6ItplIEzUe8TbAm6EW+anIgZWthNuQ6hpKDJaf+0kyBN/LHB268iJFmdRMG1nE
         Dfi9W6U6lCMtkd5hUkMVeLoQUN1Tnl7ze1uAPrmGFcMe5HzgDSYaSCvoyA91sxWYLpid
         3lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEHZ5qG2Y9NIbhhZ3B17EZ5gBaH7ne5FjVmUdr7WNhw=;
        b=Aajd62JYSoSRsEgLyi+JH+xSHXE5wCa0XOkBGaq2IYzBhbn59zT+ObL0UyV9Qrzodh
         FB/Vifo5zcJe4sbuOy4RBWKGPDDFBP+ciMSA/uyeV3QFUcLervi8sLrJYVjRtog3UfMM
         9N80KrVNwLFCukvkgk0ms11xPAtq09Q3yjIsrUZOL3ZRKubpQEw2H7xAdLvWbv2qB5a8
         DXTTMXay0Lr/aySH2xt0xe4xXRxELwkok+FzOZRwcq5d5mUiiujYep/k/RpH4EDi9BsY
         hk0Z3ZVJ6MxigqNi+N5Z3lvYYI+gGuUYAx1o5++XQ1W+g7foqEjetQ396f3g646is5y2
         nS+g==
X-Gm-Message-State: AOAM531MXIPR6hL/eo3pvv9FUwES9OBZQq9cMFjfhdI8B7ldClIt7EjH
        G4v52CprD0sEV4hd4K13lmf8Dg==
X-Google-Smtp-Source: ABdhPJy7MgN+wnbbgO/53f8oazsZWPqfnfHqoxI3nVximXuOLtS2UPc/V+JY5nOP8tMuCP3A+H3F5g==
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr14391859pje.181.1617971553903;
        Fri, 09 Apr 2021 05:32:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:32:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 07/18] mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
Date:   Fri,  9 Apr 2021 20:29:48 +0800
Message-Id: <20210409122959.82264-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
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
index e7da342003dd..c9efe3542b0a 100644
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
@@ -1040,10 +1063,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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

