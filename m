Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3331DC68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhBQPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhBQPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:33:27 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582BDC06178C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:32:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb24so1668085pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kE7mLzgqqc+6vOhYxJiqUhHI6vUz0T4aeCDVC6PmU30=;
        b=b2qP0aVfIrVcgB8xO4ckm7QHZL+79RAzka2JYVw36Lk0gYh3+CcaMpoTvULGB3KnjV
         z2evxWo7r63ifxXyOahnUPH2qhAbGDdInmxbxD+zLuZtGlQOoYImpA8HWgrC8xHidjrC
         yN+p+as2K3h4pxEX8HqyqlDoQ9pQzNNkuoWVx1Q5Qp8aCsi7aMnh8wnYlJXlAMxAt3/z
         sK+f5GeOPDdRBimcprVKJ8zp3FtwYB+hyvR7GUnq9uRWsO393v2C1HY1eRC+dEBvHTWB
         JFmYRXffi90t/TfvyOjQUQszkdXRXFWfLO2LAynThYyENVz5bSup1abPgMk2gSu4lzUV
         RoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kE7mLzgqqc+6vOhYxJiqUhHI6vUz0T4aeCDVC6PmU30=;
        b=b3veJarSg/GwIACkl8yGu/7gfs0Bnd+1rRIukkXaaJjQfz3Hafc8i7fyJmM511xKvs
         agEO6JiLHuEyZIqXsyiCUtGMue1XlIziOtu0/6+dxxoUdgcmrBKUK8IhuAKnLv0VbxX7
         snvQYAafho3q5+snd56pRBuDfwDQYAV4rXH+WtxaYmKyXm/LxxMZ39LPx63qAQaphLis
         FeJ61SQJoNrnlZtkpb6S0el63B+Kt/j/fWw2v4Qtq+4Zu9eEdez3YytnIU84AWUpmby6
         YnwAXAhpDUvDJARUppDOm71JBrBM4a02WZBweA5s4orhQA0sUT2DL5udzSy3g/OR/unw
         64tg==
X-Gm-Message-State: AOAM5312oH0q8nr9pOP0bEw2jHiyPzCpGppBZcp3KZQCUXBFfVpWURRZ
        m5FP4vNMI6nBFF7zaP0mxdf7QQ==
X-Google-Smtp-Source: ABdhPJzdRsnShuvnl7vxNO0E4ReAVQVWkufj2Kb8+xK3S/HwZZqQZ7Qrw9qSk0mzav2oIF6Tv4aqkQ==
X-Received: by 2002:a17:902:b610:b029:e3:2b1e:34ff with SMTP id b16-20020a170902b610b02900e32b1e34ffmr22440894pls.69.1613575965826;
        Wed, 17 Feb 2021 07:32:45 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id q13sm2877921pfg.155.2021.02.17.07.32.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 07:32:45 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: [PATCH v3] mm: memcontrol: fix swap undercounting in cgroup2
Date:   Wed, 17 Feb 2021 23:32:37 +0800
Message-Id: <20210217153237.92484-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pages are swapped in, the VM may retain the swap copy to avoid
repeated writes in the future. It's also retained if shared pages are
faulted back in some processes, but not in others. During that time we
have an in-memory copy of the page, as well as an on-swap copy. Cgroup1
and cgroup2 handle these overlapping lifetimes slightly differently
due to the nature of how they account memory and swap:

Cgroup1 has a unified memory+swap counter that tracks a data page
regardless whether it's in-core or swapped out. On swapin, we transfer
the charge from the swap entry to the newly allocated swapcache page,
even though the swap entry might stick around for a while. That's why
we have a mem_cgroup_uncharge_swap() call inside mem_cgroup_charge().

Cgroup2 tracks memory and swap as separate, independent resources and
thus has split memory and swap counters. On swapin, we charge the
newly allocated swapcache page as memory, while the swap slot in turn
must remain charged to the swap counter as long as its allocated too.

The cgroup2 logic was broken by commit 2d1c498072de ("mm: memcontrol:
make swap tracking an integral part of memory control"), because it
accidentally removed the do_memsw_account() check in the branch inside
mem_cgroup_uncharge() that was supposed to tell the difference between
the charge transfer in cgroup1 and the separate counters in cgroup2.

As a result, cgroup2 currently undercounts retained swap to varying
degrees: swap slots are cached up to 50% of the configured limit or
total available swap space; partially faulted back shared pages are
only limited by physical capacity. This in turn allows cgroups to
significantly overconsume their alloted swap space.

Add the do_memsw_account() check back to fix this problem.

Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: stable@vger.kernel.org # 5.8+
---
 v3:
 - Replace !cgroup_subsys_on_dfl(memory_cgrp_subsys) with do_memsw_account().
   Thanks to Shakeel.

 v2:
 - update commit log and add a comment to the code. Very thanks to Johannes.

 mm/memcontrol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..b5a66b98af74 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6771,7 +6771,19 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 
-	if (PageSwapCache(page)) {
+	/*
+	 * Cgroup1's unified memory+swap counter has been charged with the
+	 * new swapcache page, finish the transfer by uncharging the swap
+	 * slot. The swap slot would also get uncharged when it dies, but
+	 * it can stick around indefinitely and we'd count the page twice
+	 * the entire time.
+	 *
+	 * Cgroup2 has separate resource counters for memory and swap,
+	 * so this is a non-issue here. Memory and swap charge lifetimes
+	 * correspond 1:1 to page and swap slot lifetimes: we charge the
+	 * page to memory here, and uncharge swap when the slot is freed.
+	 */
+	if (do_memsw_account() && PageSwapCache(page)) {
 		swp_entry_t entry = { .val = page_private(page) };
 		/*
 		 * The swap entry might not get freed for a long time,
-- 
2.11.0

