Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2567439BD4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhFDQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhFDQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622824515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ckw2E1Ngpso/ifdgV6VuqK7lcpBewZb6ObJGqL9fiA8=;
        b=fnOhM7wFyJz8DeirEquOLF6quAkY52t4T/vjNVUsf7DthOnYK2gHNLKMd/wK/R0WNUfe59
        nvLQQJ33iSmfNy6DfO3fwWBhe2Z7j2hjePjj7vLM4jeSEQFXe1WsRmh618mWMwcxJ0MD6P
        tE3bua+Q7EJ2UatoGerh4UMm/usT7pw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-qVY0eeT4NFqWEWjbkU2Xow-1; Fri, 04 Jun 2021 12:35:14 -0400
X-MC-Unique: qVY0eeT4NFqWEWjbkU2Xow-1
Received: by mail-wm1-f72.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so4655018wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckw2E1Ngpso/ifdgV6VuqK7lcpBewZb6ObJGqL9fiA8=;
        b=cAE1UsJJtsZAHTjB42S22pY2gg3ITS0OqwNoY6KfywDNrdwOpwlOUh4y/GwXn/Sqv4
         BM7NPH6SF6B28YMqLP7QeWjfjuyGWQkt43xu3CSdq+Bq49BtQcCISJoZLlLvor13Ghi0
         zyrSUkbhZbmllKoxlEr+z1pU7Kh2Eoizw/yEwaOQyyEO293Q1fEISo8+xIKdEXj9n9wI
         nF4zUyaqh4XTeCTQOa9Idj0SGvhj0nDT7wvF8azf42IbRRF3p9Xig53xadyGiCI/MJ9q
         zC4P6QfFZBqYX7VVdvGv2MhV84WEWK5k+dcrJtzKtsgdpfbZbCkEWIpbFy/ozFzCN40z
         7yZQ==
X-Gm-Message-State: AOAM533ghPfUwB4VJfFqlhPxi3AcNCGmiOo+DN1GgSHJ10RHaxb6LlqD
        e4jlsm/catyYYm072o7vD1W52GvzLklmeDR5NDv65A2Ydj7hqDa7kRhtcBhWuCELl5WQIRSOly0
        9VkkguL24c1tABLMjpkoELgYC
X-Received: by 2002:a05:600c:1910:: with SMTP id j16mr4436900wmq.39.1622824513090;
        Fri, 04 Jun 2021 09:35:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRZwBc4V+uUTlWRHsJEOKi/XH2eg3b+TxrQBmiqUV0Q3ylR6scIhTDYo4rBe9omz1fKDi8CQ==
X-Received: by 2002:a05:600c:1910:: with SMTP id j16mr4436888wmq.39.1622824512926;
        Fri, 04 Jun 2021 09:35:12 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id l8sm9375926wrf.0.2021.06.04.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:35:12 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     axelrasmussen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mtosatti@redhat.com, tglx@linutronix.de, bigeasy@linutronix.de,
        nsaenzju@redhat.com
Subject: [PATCH] mm: mmap_lock: Use local locks instead of disabling preemption
Date:   Fri,  4 Jun 2021 18:35:06 +0200
Message-Id: <20210604163506.2103900-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap_lock will explicitly disable/enable preemption upon manipulating
its local CPU variables. This is to be expected, but in this case, it
doesn't play well with PREEMPT_RT. The preemption disabled code section
also takes a spin-lock. Spin-locks in RT systems will try to schedule,
which is exactly what we're trying to avoid.

To mitigate this, convert the explicit preemption handling to
local_locks. Which are RT aware, and will disable migration instead of
preemption when PREEMPT_RT=y.

The faulty call trace looks like the following:
    __mmap_lock_do_trace_*()
      preempt_disable()
      get_mm_memcg_path()
        cgroup_path()
          kernfs_path_from_node()
            spin_lock_irqsave() /* Scheduling while atomic! */

Fixes: 2b5067a8143e3 ("mm: mmap_lock: add tracepoints around lock acquisition ")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/mmap_lock.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index dcdde4f722a4..2ae3f33b85b1 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -11,6 +11,7 @@
 #include <linux/rcupdate.h>
 #include <linux/smp.h>
 #include <linux/trace_events.h>
+#include <linux/local_lock.h>
 
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
@@ -39,21 +40,30 @@ static int reg_refcount; /* Protected by reg_lock. */
  */
 #define CONTEXT_COUNT 4
 
-static DEFINE_PER_CPU(char __rcu *, memcg_path_buf);
+struct memcg_path {
+	local_lock_t lock;
+	char __rcu *buf;
+	local_t buf_idx;
+};
+static DEFINE_PER_CPU(struct memcg_path, memcg_paths) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+	.buf_idx = LOCAL_INIT(0),
+};
+
 static char **tmp_bufs;
-static DEFINE_PER_CPU(int, memcg_path_buf_idx);
 
 /* Called with reg_lock held. */
 static void free_memcg_path_bufs(void)
 {
+	struct memcg_path *memcg_path;
 	int cpu;
 	char **old = tmp_bufs;
 
 	for_each_possible_cpu(cpu) {
-		*(old++) = rcu_dereference_protected(
-			per_cpu(memcg_path_buf, cpu),
+		memcg_path = per_cpu_ptr(&memcg_paths, cpu);
+		*(old++) = rcu_dereference_protected(memcg_path->buf,
 			lockdep_is_held(&reg_lock));
-		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), NULL);
+		rcu_assign_pointer(memcg_path->buf, NULL);
 	}
 
 	/* Wait for inflight memcg_path_buf users to finish. */
@@ -88,7 +98,7 @@ int trace_mmap_lock_reg(void)
 		new = kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_KERNEL);
 		if (new == NULL)
 			goto out_fail_free;
-		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), new);
+		rcu_assign_pointer(per_cpu_ptr(&memcg_paths, cpu)->buf, new);
 		/* Don't need to wait for inflights, they'd have gotten NULL. */
 	}
 
@@ -122,23 +132,24 @@ void trace_mmap_lock_unreg(void)
 
 static inline char *get_memcg_path_buf(void)
 {
+	struct memcg_path *memcg_path = this_cpu_ptr(&memcg_paths);
 	char *buf;
 	int idx;
 
 	rcu_read_lock();
-	buf = rcu_dereference(*this_cpu_ptr(&memcg_path_buf));
+	buf = rcu_dereference(memcg_path->buf);
 	if (buf == NULL) {
 		rcu_read_unlock();
 		return NULL;
 	}
-	idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
+	idx = local_add_return(MEMCG_PATH_BUF_SIZE, &memcg_path->buf_idx) -
 	      MEMCG_PATH_BUF_SIZE;
 	return &buf[idx];
 }
 
 static inline void put_memcg_path_buf(void)
 {
-	this_cpu_sub(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE);
+	local_sub(MEMCG_PATH_BUF_SIZE, &this_cpu_ptr(&memcg_paths)->buf_idx);
 	rcu_read_unlock();
 }
 
@@ -179,14 +190,14 @@ static const char *get_mm_memcg_path(struct mm_struct *mm)
 #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
 	do {                                                                   \
 		const char *memcg_path;                                        \
-		preempt_disable();                                             \
+		local_lock(&memcg_paths.lock);				       \
 		memcg_path = get_mm_memcg_path(mm);                            \
 		trace_mmap_lock_##type(mm,                                     \
 				       memcg_path != NULL ? memcg_path : "",   \
 				       ##__VA_ARGS__);                         \
 		if (likely(memcg_path != NULL))                                \
 			put_memcg_path_buf();                                  \
-		preempt_enable();                                              \
+		local_unlock(&memcg_paths.lock);			       \
 	} while (0)
 
 #else /* !CONFIG_MEMCG */
-- 
2.31.1

