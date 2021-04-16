Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A67B361927
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhDPFQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhDPFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858FFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so13963837pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8wWJIpwyMTu3hxIlWXzmIud8VzdA+zaDtz12NM5n5U=;
        b=iHBp4oj9JUNupFLCeYguBqBHnt/v6XaFLarmLsBE+1tkt3jxMhzFrhBvE5l8AN997Q
         yoR3q08gqyt+Sx6AKbEcIzEhpyu0SaMeCtIyPXxDWEBmmc8d+jxn8sPUbnCHWffKbanT
         /c72tbHOahxBwRDDNhxZTRoZr/HSGYnPyiKa2252M9kQLGncdK4AWFI9Nb42osoA7MsV
         oawzC8OlTQdgpjx5CaRugEGbD6uaUGlx8fjNkGmJ3d4OSCeLlIlDlN5cLhA0Qh/tb5Ok
         AfnV+x3DYN9fEgAcJbV0sXzSIl8BcX4pCPs/6UlWSYZkFna0+lK1qCsK8xEfiDTxpAG3
         TjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8wWJIpwyMTu3hxIlWXzmIud8VzdA+zaDtz12NM5n5U=;
        b=SamScFv9K+ySEt9RwxeWDEg4arbqX3s5mCyIoHVztLt5wMm4AQ6CSW9iySzlioMR4B
         y/5BfXewaa7eDH6zB0oi05ak8/eoL7NWGubx43GIj8UZnE7slAhrkDHKkNKZhCaYAdGC
         GSFPmjKNbfQ9xjkTc7GsJFPrqV6pLOznniKlnqWzjI69NxQcihGfgaFXJtfmbMdynvTC
         5RCOPedh2o43smZxCsKpsYa40BhfR+WkWJLkkzo2HprwHDbiHwaB+SZrj9V8cRKG5QPi
         RrbtP2OTKkcGRdAjRwf+XTh9T3/9QxkOtoAxt4W72cL5C9lnOOM8V7zBTGwgYfL3/uwk
         iKXA==
X-Gm-Message-State: AOAM530/c4RRXGHLpux0s9U4bCLntmpVg0lFAyDOxj6K9yF3MpaAFy+p
        GcUd+Migaa7dHugxVCCSIfK9Eg==
X-Google-Smtp-Source: ABdhPJxiIy16z6+pQ2PwCIV5UB57x16+veoagt6ZKlXWDE19ptYCd7nfBf8ivXxvb72aa+VHvmL9bw==
X-Received: by 2002:a17:90a:7893:: with SMTP id x19mr7908730pjk.3.1618550169181;
        Thu, 15 Apr 2021 22:16:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.16.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:16:08 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 6/8] mm: memcontrol: simplify the logic of objcg pinning memcg
Date:   Fri, 16 Apr 2021 13:14:05 +0800
Message-Id: <20210416051407.54878-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index caf193088beb..c4eebe2a2914 100644
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

