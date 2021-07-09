Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC113C1C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGIAID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhGIAH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 20:07:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4551CC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 17:05:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j186-20020a25d2c30000b029055ed6ffbea6so1698246ybg.14
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 17:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ljZtH/3TfSN/L2o7cH/WG4F/EQa0MpAf0ZWdg5C/FNc=;
        b=tjuzLHVF6l4VVoKLeCICczn6YDJN3WpgP2EKbpGIwoImA0pbzF/WW9fGwmIFgZjIbF
         ioFEOo80oORCzs77cXbZqQuT/dC8ElHWoBKrlQCrAisasje6lH4lQlJCXjncXzU4DqQh
         2AU0p4gnRO7+7Eu9EL6ZXgZ44X/qWm/IzNyC32JDqh9i3SbKbBPTlFBUvit5atKoadxd
         7JZ65EULEJRyeFkovh0oGnZfcOfKGVQVu88YAAMnPVktwy7KV4m/qX2aRgOidCH095n7
         SdgX49cVT5lkj5ZtQr0JzkyElR8g/YiUM4L5WTjEHJL6M0JzllWjTEVN5V0u5340zWZ7
         bT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ljZtH/3TfSN/L2o7cH/WG4F/EQa0MpAf0ZWdg5C/FNc=;
        b=nA5ucAbxPIeJloP1t4GVQ2P/2iKeBkQwU5VqqFvAfvUUPvszb6PLSHWlA2wTKi81Hy
         2+htqpY/Pp1p0+rOMeoNt3XtaiN88iU6bL1kpaesr8rWsbQmSq2oaz1dz5rUeW4CuSMG
         EMracvSgDZmBZTLdZr0yeCv5WpSzMlzO5574+8Y8sx7o9DYVZSq0+ukBCXnl+qAV2Yue
         rPS3yOD7sZz3ekg5FlBiTu54ieZkS28ZEWrytXCyAM9Qr5Gc7A6CAdXYo7QqtRuJslTD
         k4j6gcSXVmQ8Y9GZ4XPr0WKxHoT1S68SraetLLBdcFATd4CacjrRzs3IqWbTxZv2OXcB
         eKFA==
X-Gm-Message-State: AOAM531Zyc3I/wrcPA66bhwPamPvYkXbP05bsdn5jzcDQUPmVcFgCc35
        qARZmr33e+9PXMiSlv5rGcArxVN3gRI=
X-Google-Smtp-Source: ABdhPJwUx/316sM6z63yIL3OPNiVYfnRJDICSxKoHBNF68vCz9qUEr6Sz5IXrfRfisKkM8fwNjl5Tx8HMyI=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:7a7f:fa1f:71a4:365b])
 (user=surenb job=sendgmr) by 2002:a25:2c01:: with SMTP id s1mr46509637ybs.387.1625789115394;
 Thu, 08 Jul 2021 17:05:15 -0700 (PDT)
Date:   Thu,  8 Jul 2021 17:05:07 -0700
In-Reply-To: <20210709000509.2618345-1-surenb@google.com>
Message-Id: <20210709000509.2618345-2-surenb@google.com>
Mime-Version: 1.0
References: <20210709000509.2618345-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 1/3] mm, memcg: add mem_cgroup_disabled checks in vmpressure
 and swap-related functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        vbabka@suse.cz, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        david@redhat.com, willy@infradead.org, apopple@nvidia.com,
        minchan@kernel.org, linmiaohe@huawei.com,
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

