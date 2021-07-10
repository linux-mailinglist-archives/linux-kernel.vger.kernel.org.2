Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD583C2C18
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhGJAjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhGJAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:39:15 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C74C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 17:36:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id g11-20020a0562140acbb02902c77e759580so7617280qvi.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 17:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZSFxQqEllnhgQqgVGWhX1TPVzgfo+pOEQxzVXUrGXrk=;
        b=sAc/7ecFZP5kXA30C5YZ8xkXOBRQdtm2F5t0/CXgWYYABwvtTUr/VKqm/I/gky0Rq8
         WveSgzFU18PV2ZevoAP+ectWUbltAEfoTlMnhaj/RjMSDDPfpZ4P36rsnHFI1zv7oHT5
         AuepZM6oeCMBUm0kxEG65nYNsEVn3AIOnXyEHJ7TlLkF0Z2Vb6FULt+zS/JoVFNTjHhe
         1ArC5OTnPtacdAyffJBWyYYjx3lrCgZGjp9uK/zuiR0Kc7YDoaBa1Pp5MdKA040qqPX/
         7N0i9ZQTB556jwAN+CJxb8G/iCx2WwlA9F25zL7moMckGy85MVe2PxoqJBl/9kj8Oe47
         2Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZSFxQqEllnhgQqgVGWhX1TPVzgfo+pOEQxzVXUrGXrk=;
        b=WL6LaKurYItyepSAmuIJqb+/mBnoX/Nd6iyOwb4WUutDVjZ7M8MV+VwQOijHfAUO91
         AtylgJwLNEvEAc4TIJBNYMfPdIQSWc2NOL3qgwVR6CCnOgTzLc0ahucy6HuVuUOP9tWV
         ky0PNCgL9zy34woKL+tHQZosbndSKQglS09xRaylnBiz64MRicPLr87UbFBtz/J3pBC+
         JcqeaDzle+gcMpzq0JnSRgFgof3qBM81kXfiZnjFafgu5nAjCGwcXsxKWd4vSy9QZ+RP
         IJ1UxP2xF59H1G/6cH4Imd/28/tMbPN7rfwZ1z6p9rUf4aOUbWLAbhxdvrXsPmlQfIlA
         7JIg==
X-Gm-Message-State: AOAM532ad3ardW2EPjmC9JVjp51SliPG9KSY+Hq1vfGFZE4alHaCCq9I
        Dd/dmy+6NN0q9wNv6mwGAIWC82nMRAE=
X-Google-Smtp-Source: ABdhPJxkP75WgV21IZcNxlRS6TAmzQqF7mR5/9LIYDXJQsk1G4XmdLL2D1kY+MbFVZVjIcVqYIoBzqaGKgs=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:9f62:e8e9:4de2:f00a])
 (user=surenb job=sendgmr) by 2002:ad4:5386:: with SMTP id i6mr39090484qvv.2.1625877390205;
 Fri, 09 Jul 2021 17:36:30 -0700 (PDT)
Date:   Fri,  9 Jul 2021 17:36:24 -0700
Message-Id: <20210710003626.3549282-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, david@redhat.com, willy@infradead.org,
        apopple@nvidia.com, minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap and
cgroup_throttle_swaprate functions. This minimizes the memcg overhead in
the pagefault and exit_mmap paths when memcgs are disabled using
cgroup_disable=memory command-line option.
This change results in ~2.1% overhead reduction when running PFT test
comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
ARM64 Android device.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 3 +++
 mm/swapfile.c   | 3 +++
 mm/vmpressure.c | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..a228cd51c4bd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7305,6 +7305,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
+	if (mem_cgroup_disabled())
+		return;
+
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1e07d1c776f2..707fa0481bb4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3778,6 +3778,9 @@ void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 	struct swap_info_struct *si, *next;
 	int nid = page_to_nid(page);
 
+	if (mem_cgroup_disabled())
+		return;
+
 	if (!(gfp_mask & __GFP_IO))
 		return;
 
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index d69019fc3789..9b172561fded 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -240,7 +240,12 @@ static void vmpressure_work_fn(struct work_struct *work)
 void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		unsigned long scanned, unsigned long reclaimed)
 {
-	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
+	struct vmpressure *vmpr;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	vmpr = memcg_to_vmpressure(memcg);
 
 	/*
 	 * Here we only want to account pressure that userland is able to
-- 
2.32.0.93.g670b81a890-goog

