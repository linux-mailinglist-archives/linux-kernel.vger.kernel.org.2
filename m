Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE5346246
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhCWPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhCWPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:04:36 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D72C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:04:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c17so7690980pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MA6xbw4+r8K+wq0zQny62MlNgzy94Yz5IxA7fznNkvI=;
        b=bjsLkDqYNs6Nimr2YkIoa0MqhhaWRwuXycLjgACzZ23PSATVqBtlI2HfmXoU9Pfzfc
         1wC9SYV5Rz1O3qgwI5WbdJFPnbYg7W1Sf+net5S8GinMRw5Pmyvt8WrHZgvR94FqpHRR
         Ha1u2jwXPjsEeaf3EVVWkZUssMKFJto3S99CknnBU50iccwrUU88WJ9XDZcJUP5RFtx1
         lQpVZdIiNlcSyIE4kcHqIE70/GzlmPSCANHYTTm0+qeLzUoFRNosqlLZ3nhOvizRxfp8
         NXC5KAR8vUspWHG9Zwh8DIQl9o2havE0KnYLXRFbELlZ7G25gLmgf5WKnpRprqCQK7pp
         c7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MA6xbw4+r8K+wq0zQny62MlNgzy94Yz5IxA7fznNkvI=;
        b=GSxhs7hjE5Q7Yp0m01ny6I0Z94uv4e4bGRUh9cr0HeDbeSlImv8mHYqri12GA8SLdf
         dXvCweQQxrWbeTcHGQDBH7IWOUenMHgtPpnnz6ERWfWIMUu9PUUIcoHI3VIsasnltsJH
         vSq5LCPhOW2RGPH45un5zsAvJO7ENMQsZqQC5HVFK4d48F4yQl3t5CorcTs9+AHAgqtt
         5gZQWCWRMB4NE3c2hy3RQps5dgisf+ZreRYBTD0ZrOgPLS0e1ApfqS+HgC1lDbQZ4IG4
         1wVeFj5RchuZCFQdn9rTtH5ZuB9jAL00uEn9xv3HIfLTzwXsWX8FSHSFmRnb4QFq/OFW
         pF4A==
X-Gm-Message-State: AOAM533Z+NhGHuzf+MTTmA32NLce28IyseFNiIdWEz/mWwas/LOilLaA
        +YXNElyMJxRONHujVv4ghjigsInLMjenfcN7
X-Google-Smtp-Source: ABdhPJzwv9I7nq+ty6tFP/gu93RhNIET/zLYJFLrYl9HVXoilh9y17OjemBwBDL4sl71xlthRzQIMQ==
X-Received: by 2002:a17:902:bcc8:b029:e6:f010:aa15 with SMTP id o8-20020a170902bcc8b02900e6f010aa15mr4950803pls.55.1616511874786;
        Tue, 23 Mar 2021 08:04:34 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id 132sm17234595pfu.158.2021.03.23.08.04.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:04:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix memsw uncharge for root_mem_cgroup
Date:   Tue, 23 Mar 2021 22:56:53 +0800
Message-Id: <20210323145653.25684-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pages aren't accounted at the root level, so we cannot uncharge the
page to the memsw counter for the root memcg. Fix this.

Fixes: 1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 533b4b31b464..7d765a106684 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7155,7 +7155,8 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (!cgroup_memory_noswap && memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
 			page_counter_charge(&swap_memcg->memsw, nr_entries);
-		page_counter_uncharge(&memcg->memsw, nr_entries);
+		if (!mem_cgroup_is_root(memcg))
+			page_counter_uncharge(&memcg->memsw, nr_entries);
 	}
 
 	/*
-- 
2.11.0

