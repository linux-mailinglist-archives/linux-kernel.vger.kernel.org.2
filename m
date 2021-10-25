Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0F4396AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhJYMyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhJYMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:53:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE52C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:51:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so11322867pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0gxeYb7CuPuOEYUzEz6CBsyCpJ15hKcmaTNWBN6Ra0=;
        b=fbyV+ZZ1F6ASV4drvbf1fIgx3k1wRSJ/h4+kf2Yjc6N3kQdd+XApOqXH8rv8psJM82
         BC/gmPQON6chy+iMDeA6/JcwfeUG83H/jVNXZBU2FPtadW6t2370uvj7XS4vcpV52Fki
         VJ2y2LNeAUIGFxirOnH3WP/lKCkwi4HWwr/NeohR0PjpCZXMuQmgaymZI/lNS59wNngI
         W/qOkMWkf68hRl1xUlyaQvgLL9H46M/+eW5BNoe977YqZRnzLpprefAlr/qU7IxSp2Zx
         Ne3NbBsD7JSV4mtrAdKA2HpcJQ1kQoomeRIGlcHBNzJePGVfQmayv5/YL/ioyYY+81ia
         pBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0gxeYb7CuPuOEYUzEz6CBsyCpJ15hKcmaTNWBN6Ra0=;
        b=WoxRgB2Ho9cSbeGTBEa8S6FA8tfbBsZg6LU5ZTMSt36DFQ9YHaEVsWo2F4oXTJHvnX
         tnge0UGp06ZpXeyUO9KCcmWCKiAvmXuvgREjBvImOshzRafhlySjv4wfbDTG3cK6fd36
         oapwTiqoP86bI7WcirDJktytb8vmSgA9fldcDHOcxClObUp/rkzDQzagRf24rdXpfH3d
         9663toBh0+qygMCCiLr1wuYBx7kSWRWofsdML00Kw/2kU+hQBSSV8Y9wlRqeDFwhs/AY
         Sn63r4l52hzcdOxCWw5G/1fSLjYw+G/eu9RKHkBQKhNUm9Q/+yuwUt70+nFEesHzLrxt
         UI0Q==
X-Gm-Message-State: AOAM531C0xDcX8nfBuMRpKpTy2zrPE2E9iVnWs1bK+7y8E453iTOIk0k
        tVC379khL3eb4fHV+gi2iB7vcw==
X-Google-Smtp-Source: ABdhPJzspTiZhhAOdxhF/PoEWNdFL59WC9kQRhjlVlbfM4tk1xVTlSDLJuGpuRoB7Rc/Nx4OolFCRA==
X-Received: by 2002:a17:902:728b:b0:13f:c086:bdfe with SMTP id d11-20020a170902728b00b0013fc086bdfemr16422107pll.6.1635166296351;
        Mon, 25 Oct 2021 05:51:36 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id y6sm15692823pfi.154.2021.10.25.05.51.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 05:51:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mhocko@kernel.org, shakeelb@google.com,
        willy@infradead.org, guro@fb.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: remove kmemcg_id reparenting
Date:   Mon, 25 Oct 2021 20:51:02 +0800
Message-Id: <20211025125102.56533-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since slab objects and kmem pages are charged to object cgroup instead
of memory cgroup, memcg_reparent_objcgs() will reparent this cgroup and
all its descendants to its parent cgroup. This already makes further
list_lru_add()'s add elements to the parent's list. So it is unnecessary
to change kmemcg_id of an offline cgroup to its parent's id. It just
wastes CPU cycles. Just to remove those redundant code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6538595994d2..e26f87cd7e4c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3645,8 +3645,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *parent, *child;
+	struct mem_cgroup *parent;
 	int kmemcg_id;
 
 	if (memcg->kmem_state != KMEM_ONLINE)
@@ -3664,21 +3663,11 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	BUG_ON(kmemcg_id < 0);
 
 	/*
-	 * Change kmemcg_id of this cgroup and all its descendants to the
-	 * parent's id, and then move all entries from this cgroup's list_lrus
-	 * to ones of the parent. After we have finished, all list_lrus
-	 * corresponding to this cgroup are guaranteed to remain empty. The
-	 * ordering is imposed by list_lru_node->lock taken by
+	 * After we have finished memcg_reparent_objcgs(), all list_lrus
+	 * corresponding to this cgroup are guaranteed to remain empty.
+	 * The ordering is imposed by list_lru_node->lock taken by
 	 * memcg_drain_all_list_lrus().
 	 */
-	rcu_read_lock(); /* can be called from css_free w/o cgroup_mutex */
-	css_for_each_descendant_pre(css, &memcg->css) {
-		child = mem_cgroup_from_css(css);
-		BUG_ON(child->kmemcg_id != kmemcg_id);
-		child->kmemcg_id = parent->kmemcg_id;
-	}
-	rcu_read_unlock();
-
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-- 
2.11.0

