Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78E236A59C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhDYH5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 03:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhDYH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:57:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616DAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:57:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v20so53386plo.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTSkEph7qL8ctEwVYodw+espySzWTEr2PJqwjnU2IwA=;
        b=YArwpms4v/ebs6QBCf1CGl2uuaUyu+UF1v0h7p108viBd2U9qf+F2CEuWeL1v1SQYA
         hkn/IuRVgXsDg2MsWYBr6dQJIYosab3LRXZODBHGsGEgSnMM1qO0sM5T/O1BKhmU0xgd
         2JqiNp7PSBPQQIVFxkmXIsqbmCaVOkGaQe59xXb+pRACMxHXSFq5aD/jE+hsrd0vIW2d
         Ji0ga2wU2ahPoF7clxKb5BmD/Bx5jJ5XM76+S46Q+AL4UhDbi14ihQXoL5H7XFVC8Bxn
         BvSmdixlYxfyPMH5aZL0I+Jq742Z0nZcAj9LA4z7WSFGNgzmrdEFi+RQmAlB4oksXgF3
         GOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTSkEph7qL8ctEwVYodw+espySzWTEr2PJqwjnU2IwA=;
        b=XS98Dx4/4Fm4Dr4MnH4MRMmkROPzKWKuFCuXfehwpE8G7Cn90R31ezaMyEiRXHIFi4
         ZpGRRNclFSFpAAj3z7l4WGxhIS3v8ZrfR9Ax1IXm3sFMFZ6q4RXLyP/pY3bRPBGep+ZL
         ZqQF1YSfpsQe01AgVY0Wk3clAthYuerzU0icQb2IxV6oCMYLVKltQh8ClqjKW8VH+xR4
         55TeMa/mJp3hcZqiFXju0i6winMoerugBF3d1bcIvVeFfURCg0ohpS3Ir/W5JO7w7hC+
         PQeerp4clLyTMm1MMK6c2LO0kL+EQl5oaT5srg5qXSC/l+eYkmOW2a6SgGmERO0yMrug
         xuAA==
X-Gm-Message-State: AOAM533Cis5wP8fOkviPnlqvay+YTlpZB3hwuEMwOkF0SpCfXWyQ5Qng
        jhu4as2F/0+1XGyPSGWju8KBZg==
X-Google-Smtp-Source: ABdhPJxt94EaODQ6xUr6u0EpOWiZ6SVb3NyMWhIkriwxWC5qFE6d12Ze1J4FmoZNRU9GljOR+A9WCA==
X-Received: by 2002:a17:902:6ac3:b029:e6:c6a3:a697 with SMTP id i3-20020a1709026ac3b02900e6c6a3a697mr12560454plt.2.1619337419848;
        Sun, 25 Apr 2021 00:56:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c193sm8689444pfc.11.2021.04.25.00.56.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 00:56:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcontrol: fix root_mem_cgroup charging
Date:   Sun, 25 Apr 2021 15:54:10 +0800
Message-Id: <20210425075410.19255-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below scenario can cause the page counters of the root_mem_cgroup
to be out of balance.

CPU0:                                   CPU1:

objcg = get_obj_cgroup_from_current()
obj_cgroup_charge_pages(objcg)
                                        memcg_reparent_objcgs()
                                            // reparent to root_mem_cgroup
                                            WRITE_ONCE(iter->memcg, parent)
    // memcg == root_mem_cgroup
    memcg = get_mem_cgroup_from_objcg(objcg)
    // do not charge to the root_mem_cgroup
    try_charge(memcg)

obj_cgroup_uncharge_pages(objcg)
    memcg = get_mem_cgroup_from_objcg(objcg)
    // uncharge from the root_mem_cgroup
    refill_stock(memcg)
        drain_stock(memcg)
            page_counter_uncharge(&memcg->memory)

get_obj_cgroup_from_current() never returns a root_mem_cgroup's objcg,
so we never explicitly charge the root_mem_cgroup. And it's not
going to change. It's all about a race when we got an obj_cgroup
pointing at some non-root memcg, but before we were able to charge it,
the cgroup was gone, objcg was reparented to the root and so we're
skipping the charging. Then we store the objcg pointer and later use
to uncharge the root_mem_cgroup.

This can cause the page counter to be less than the actual value.
Although we do not display the value (mem_cgroup_usage) so there
shouldn't be any actual problem, but there is a WARN_ON_ONCE in
the page_counter_cancel(). Who knows if it will trigger? So it
is better to fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changeslog in v2:
 - Update commit log.
 - Rename __try_charge to try_charge_memcg.

 mm/memcontrol.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..42dee9798ab8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2504,8 +2504,8 @@ void mem_cgroup_handle_over_high(void)
 	css_put(&memcg->css);
 }
 
-static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-		      unsigned int nr_pages)
+static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
+			unsigned int nr_pages)
 {
 	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
@@ -2517,8 +2517,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	unsigned long pflags;
 
-	if (mem_cgroup_is_root(memcg))
-		return 0;
 retry:
 	if (consume_stock(memcg, nr_pages))
 		return 0;
@@ -2698,6 +2696,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 }
 
+static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
+			     unsigned int nr_pages)
+{
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	return try_charge_memcg(memcg, gfp_mask, nr_pages);
+}
+
 #if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
 static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
@@ -2925,7 +2932,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	ret = try_charge(memcg, gfp, nr_pages);
+	ret = try_charge_memcg(memcg, gfp, nr_pages);
 	if (ret)
 		goto out;
 
-- 
2.11.0

