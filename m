Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB932BAD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358305AbhCCMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451378AbhCCGDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:03:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B692C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:02:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a24so13417934plm.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbGTbs5FDqW8dfi9ZRBPOsJxUqRFINYZ3rgDHjWLvwc=;
        b=Q3V/YknHFmRgj1PwWc0SRV2EtAx2M3OksOg3m9d9fOM2iJqT91NYD9rWa9oG/+FIGR
         HeJpIGHB4jht045gvudvL97cnfXrobWymkOfWo5TcCTsrHCz7CEyiai7x41Ai2EYJKbe
         eJydamPnBgFMAI8XSJGov8ANqot7MF1CDptuPRm0ffhLQm4fDvZdthd+VZseO6xvhkIK
         0WK8apIgp6ieI+KkrF80w6wnyT14aLOrXTCiYNVa4kYRAbmaNwA2/3nadnkirsGi2TQE
         /lMiF8ztv933IGT5RXnU4Ka0AklPFhE3C8P+wggnAdHRBy5HwV39xFwGr0RcfsCVuWTX
         yIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbGTbs5FDqW8dfi9ZRBPOsJxUqRFINYZ3rgDHjWLvwc=;
        b=Aw1vkaBqRKQop6FqBmXMTB3rWCAfpoYTZsuVA5jqmtmExJXfeGCnLGe5eZjdjqs9V8
         4lEivR7JZ2O9Q4GKTaThAVOf7oE6NibFDPn27Qtu1L/xJogiIr4KQ2oCX/BXAA1VG3sU
         8MVIXm+g/OL5NmxRVgAjsSQIeYTk9MgiRrr6XNz0MF02brpxk8w93AtbBvwQJV3GmJCi
         M10EvYH4HZAC6sStIMZKUTl263vHO6mKSRfD2QiinmR+2CiISVFglfFvA0lh42TKh8RF
         vELHLKNnbbrLeB8HMrjb6FWNe8reZuYIIkPDPaM1r6Eq1kRZHJvuZ4uKhZo54XxM5Ii3
         W0Ng==
X-Gm-Message-State: AOAM532AdfEovPgrMUx5oT7cgbpS/LE8XdUNDVnWrCi751+TYnI2LcRH
        VXwxWBkklvVF70Dt6paQxUmU4Q==
X-Google-Smtp-Source: ABdhPJyLf+noO6Y8PTxKht/Kj/fFJWB5G0zB0M0F8H7PQEohcTvEYAbxhevCUVGoyQQMN8plhzsijA==
X-Received: by 2002:a17:902:be12:b029:e3:8245:f16c with SMTP id r18-20020a170902be12b02900e38245f16cmr1479021pls.57.1614751333000;
        Tue, 02 Mar 2021 22:02:13 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x11sm6131088pjh.0.2021.03.02.22.02.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 22:02:12 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 4/5] mm: memcontrol: introduce remote objcg charging API
Date:   Wed,  3 Mar 2021 13:59:16 +0800
Message-Id: <20210303055917.66054-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210303055917.66054-1-songmuchun@bytedance.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remote memcg charing APIs is a mechanism to charge pages to a given
memcg. Since all kernel memory are charged by using obj_cgroup APIs.
Actually, we want to charge kernel memory to the remote object cgroup
instead of memory cgroup. So introduce remote objcg charging APIs to
charge the kmem pages by using objcg_cgroup APIs. And if remote memcg
and objcg are both set, objcg takes precedence over memcg to charge
the kmem pages.

In the later patch, we will use those API to charge kernel memory to
the remote objcg.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/sched.h    |  4 ++++
 include/linux/sched/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/fork.c            |  3 +++
 mm/memcontrol.c          | 44 ++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ee46f5cab95b..8edcc71a0a1d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1318,6 +1318,10 @@ struct task_struct {
 	/* Used by memcontrol for targeted memcg charge: */
 	struct mem_cgroup		*active_memcg;
 #endif
+#ifdef CONFIG_MEMCG_KMEM
+	/* Used by memcontrol for targeted objcg charge: */
+	struct obj_cgroup		*active_objcg;
+#endif
 
 #ifdef CONFIG_BLK_CGROUP
 	struct request_queue		*throttle_queue;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 1ae08b8462a4..be1189598b09 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -330,6 +330,44 @@ set_active_memcg(struct mem_cgroup *memcg)
 }
 #endif
 
+#ifdef CONFIG_MEMCG_KMEM
+DECLARE_PER_CPU(struct obj_cgroup *, int_active_objcg);
+
+/**
+ * set_active_objcg - Starts the remote objcg kmem pages charging scope.
+ * @objcg: objcg to charge.
+ *
+ * This function marks the beginning of the remote objcg charging scope. All the
+ * __GFP_ACCOUNT kmem page allocations till the end of the scope will be charged
+ * to the given objcg.
+ *
+ * NOTE: This function can nest. Users must save the return value and
+ * reset the previous value after their own charging scope is over.
+ *
+ * If remote memcg and objcg are both set, objcg takes precedence over memcg
+ * to charge the kmem pages.
+ */
+static inline struct obj_cgroup *set_active_objcg(struct obj_cgroup *objcg)
+{
+	struct obj_cgroup *old;
+
+	if (in_interrupt()) {
+		old = this_cpu_read(int_active_objcg);
+		this_cpu_write(int_active_objcg, objcg);
+	} else {
+		old = current->active_objcg;
+		current->active_objcg = objcg;
+	}
+
+	return old;
+}
+#else
+static inline struct obj_cgroup *set_active_objcg(struct obj_cgroup *objcg)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_MEMBARRIER
 enum {
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY		= (1U << 0),
diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..b4b9dd5d122f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -945,6 +945,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+#ifdef CONFIG_MEMCG_KMEM
+	tsk->active_objcg = NULL;
+#endif
 	return tsk;
 
 free_stack:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0cf342d22547..e48d4ab0af76 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -79,6 +79,11 @@ struct mem_cgroup *root_mem_cgroup __read_mostly;
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 
+#ifdef CONFIG_MEMCG_KMEM
+/* Active object cgroup to use from an interrupt context */
+DEFINE_PER_CPU(struct obj_cgroup *, int_active_objcg);
+#endif
+
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket;
 
@@ -1076,7 +1081,7 @@ static __always_inline struct mem_cgroup *get_active_memcg(void)
 	return memcg;
 }
 
-static __always_inline bool memcg_kmem_bypass(void)
+static __always_inline bool memcg_charge_bypass(void)
 {
 	/* Allow remote memcg charging from any context. */
 	if (unlikely(active_memcg()))
@@ -1094,7 +1099,7 @@ static __always_inline bool memcg_kmem_bypass(void)
  */
 static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
 {
-	if (memcg_kmem_bypass())
+	if (memcg_charge_bypass())
 		return NULL;
 
 	if (unlikely(active_memcg()))
@@ -1103,6 +1108,29 @@ static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
 	return get_mem_cgroup_from_mm(current->mm);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static __always_inline struct obj_cgroup *active_objcg(void)
+{
+	if (in_interrupt())
+		return this_cpu_read(int_active_objcg);
+	else
+		return current->active_objcg;
+}
+
+static __always_inline bool kmem_charge_bypass(void)
+{
+	/* Allow remote charging from any context. */
+	if (unlikely(active_objcg() || active_memcg()))
+		return false;
+
+	/* Memcg to charge can't be determined. */
+	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+		return true;
+
+	return false;
+}
+#endif
+
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -2997,13 +3025,20 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
-	struct obj_cgroup *objcg = NULL;
+	struct obj_cgroup *objcg;
 	struct mem_cgroup *memcg;
 
-	if (memcg_kmem_bypass())
+	if (kmem_charge_bypass())
 		return NULL;
 
 	rcu_read_lock();
+	objcg = active_objcg();
+	if (unlikely(objcg)) {
+		/* remote object cgroup must hold a reference. */
+		obj_cgroup_get(objcg);
+		goto out;
+	}
+
 	if (unlikely(active_memcg()))
 		memcg = active_memcg();
 	else
@@ -3015,6 +3050,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 			break;
 		objcg = NULL;
 	}
+out:
 	rcu_read_unlock();
 
 	return objcg;
-- 
2.11.0

