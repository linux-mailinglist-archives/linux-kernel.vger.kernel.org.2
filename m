Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322D0366567
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhDUG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhDUG1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:27:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:27:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h15so10048665pfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwnAlOdpq+wyEz2WSM+M0ERvUu6M/uBx7vTFXtXONT4=;
        b=DpIowsWi2GfYdgnpGRG8PtbRNT39ZRaQsFFJ5oLJ9+3EOrj9hfz0JCDdJiCLwuEoco
         o81qgNZNZifrLUbeAXhtHe07RgTSpgh20obxivdBnMWN+NX47ciykaqNZ2236xRhCPR5
         dI+DRXHMwBrxRqmwNFiUmgyI2Hva/D8s9c0wlaVgA/WgJ/3FgglZiKEp5NEHEt65IKBH
         IsxzKGGeyX75qzv870Z3ePiYScI3KHDQ1W041YCdpGIKCkwRG8UyA/GmdksQd2dM9H9m
         uen8OPQe96aeTj/qxhObVXapCWIjFHWeEipdcgyzcaQI4AC/NTxWOB7XnWOx343DN3Dj
         CTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwnAlOdpq+wyEz2WSM+M0ERvUu6M/uBx7vTFXtXONT4=;
        b=RcO1kruLqsXTMLkOtJ9Alrucaxw14sSOaGkPEbtCjHlhTeXf3YoQImhHfi/yYz/3ar
         uACOW7mohfzfGE7WKCYwt/cgcZfXQe0bj7y8FveB65oXVIc/VPKvdsdLh7yXncV2uWwS
         /lcUwIoXwEJAWkvCJZtqfvBkBkcmkmbc+2LOemn2tg1LWedlFeJGOImzl9SVpi7SM00i
         gclMfhr6bkPPti6GB0RPbGV/jhubE/z09P3xbLaYj6dL1teD4nRbuueRc/YBAiYZVEVH
         k0XdBLChaHUMuGxT7A4DDoB2d/dbfC3B/eju83rV6+RtkFLNvkbk+Y8iDtTsOM/tEN97
         cXjw==
X-Gm-Message-State: AOAM531TtM21srF6tkomqBQc0zf8vQfTgh5n1VCrHx3DtjDykG3eE2my
        VB0aqmgC1YPKBGbdpFB8DZ4xcA==
X-Google-Smtp-Source: ABdhPJxCzYXXUqO8j2cBW2d2M9mtDgb+DXVVcxKJlmj3wxUTj6B4DT5Sxtyal7651FOA3ZSRsIsMGg==
X-Received: by 2002:a17:90b:30c6:: with SMTP id hi6mr9129329pjb.26.1618986426710;
        Tue, 20 Apr 2021 23:27:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id w10sm815408pfq.184.2021.04.20.23.27.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 23:27:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
Date:   Wed, 21 Apr 2021 14:26:44 +0800
Message-Id: <20210421062644.68331-1-songmuchun@bytedance.com>
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
    page_counter_uncharge(&memcg->memory)

This can cause the page counter to be less than the actual value,
Although we do not display the value (mem_cgroup_usage) so there
shouldn't be any actual problem, but there is a WARN_ON_ONCE in
the page_counter_cancel(). Who knows if it will trigger? So it
is better to fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1e68a9992b01..81b54bd9b9e0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2686,8 +2686,8 @@ void mem_cgroup_handle_over_high(void)
 	css_put(&memcg->css);
 }
 
-static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-		      unsigned int nr_pages)
+static int __try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
+			unsigned int nr_pages)
 {
 	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
@@ -2699,8 +2699,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	unsigned long pflags;
 
-	if (mem_cgroup_is_root(memcg))
-		return 0;
 retry:
 	if (consume_stock(memcg, nr_pages))
 		return 0;
@@ -2880,6 +2878,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 }
 
+static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
+			     unsigned int nr_pages)
+{
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	return __try_charge(memcg, gfp_mask, nr_pages);
+}
+
 #if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
 static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
@@ -3125,7 +3132,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	ret = try_charge(memcg, gfp, nr_pages);
+	ret = __try_charge(memcg, gfp, nr_pages);
 	if (ret)
 		goto out;
 
-- 
2.11.0

