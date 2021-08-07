Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C73E36DC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhHGSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:55:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C22C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 11:54:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso23162069pjo.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwnhw9P5p8VVEUDmo0K1Cre6E35VG9qUmmwrKoVfyHk=;
        b=UHxMym9QTIrGRu6rBWPYtIyomq9j1vHJIi9cCg85mqKZPpkkKjw1zhfXcyEZr56ujm
         1lMlN4HkA8DbzaeGwa2poJhh5lIUpNAN/CzCqKtfwlSb+lo1ON9l+j6tzO3lVOyKSD8l
         BwvKpUMwtCuod3ghZZXBddWqE/2xeYe4Kgg9Z3welc/aksUL2uaNvkVuZrPDw0WYmAJZ
         sZQl3by9HhraA7wWfn7h1Q673tKL2gg6wiCh6zYiFH9IBSyljRw2aJsGAqVnK7DR1Kyk
         Myw/+qccc/5IC1ERQoGDNEtxV1M9bTKGERXEhpnVEsLPyqpijAUOr2I01Tmyi7k49wto
         7E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwnhw9P5p8VVEUDmo0K1Cre6E35VG9qUmmwrKoVfyHk=;
        b=muKk0UjZ5JhIU/FBkVRnDFSkjYp7OTQSyAWgTQ2BZL4+/TmTAWN8h/vYFtHu7Myriz
         tIGXcllB9LaHIlHbAIVXrdvna/FvUlOU+Xnx3j3vZkwe/1aR6hMKlARWIJ533l0sxYrz
         LhvBcCfuBAN8kfFhpk/i5eJpYX91ss1Oo4G3E8d9lwjmxp8q9sZNN5DnnKR7gXvO3Gmq
         sc32p9wiBuCdHuPNc0hPojSB3CGJdyD4Jh9bm6uI1HXlvatdIUXJ8NCBbBrLEYBRzPj7
         PUZ9TnxzUQ7S+PWrFSwV9ryf8vuvQ6RXrs5NRjkYgBF8g0EkvopoxejdI1lTB+feq/v2
         aVDw==
X-Gm-Message-State: AOAM531NKHZoAFNnT9Q42SB3H3GInNStpoQ3Q9Bi6RUhsslSBHZ6Z2r2
        dXzgFbEP6B25bXYU67UogQOodA==
X-Google-Smtp-Source: ABdhPJwbFTbNnh76fUMr4jBBD5RkBag1j9jXsAhsKtNlllvf2pvQNfAcpWUJae+6qis1Cv4JIS6I+w==
X-Received: by 2002:a17:90a:df02:: with SMTP id gp2mr8855042pjb.212.1628362485163;
        Sat, 07 Aug 2021 11:54:45 -0700 (PDT)
Received: from T490.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id m6sm2418851pjv.40.2021.08.07.11.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 11:54:44 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        wuqiang.matt@bytedance.com
Cc:     mattwu@163.com
Subject: [PATCH 2/2] kretprobe: manage instances with scalable object pool
Date:   Sun,  8 Aug 2021 02:54:17 +0800
Message-Id: <20210807185417.9209-3-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807185417.9209-1-wuqiang.matt@bytedance.com>
References: <20210807185417.9209-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new scalable object pool to manage kretprobe instances, replacing
the previous freelist, to improve scalability and throughput under
high workloads. The original freelist, a LIFO queue based on singly
linked list, is scaling poorly and NOT amenable to parallelization.

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/kprobes.h |  2 +-
 kernel/kprobes.c        | 83 +++++++++++++++++++++--------------------
 2 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1883a4a9f16a..98b37dc01c35 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -148,6 +148,7 @@ static inline int kprobe_ftrace(struct kprobe *p)
  */
 struct kretprobe_holder {
 	struct kretprobe	*rp;
+	struct freelist_head    fh;
 	refcount_t		ref;
 };
 
@@ -158,7 +159,6 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct freelist_head freelist;
 	struct kretprobe_holder *rph;
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..187997640290 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1217,10 +1217,12 @@ NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 static void free_rp_inst_rcu(struct rcu_head *head)
 {
 	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
+	struct kretprobe_holder *rph = ri->rph;
 
-	if (refcount_dec_and_test(&ri->rph->ref))
-		kfree(ri->rph);
-	kfree(ri);
+	if (refcount_dec_and_test(&rph->ref)) {
+		freelist_fini(&rph->fh, NULL, NULL);
+		kfree(rph);
+	}
 }
 NOKPROBE_SYMBOL(free_rp_inst_rcu);
 
@@ -1229,9 +1231,10 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 	struct kretprobe *rp = get_kretprobe(ri);
 
 	if (likely(rp)) {
-		freelist_add(&ri->freelist, &rp->freelist);
-	} else
+		freelist_push(&ri->freelist, &rp->rph->fh);
+	} else {
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
+	}
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
@@ -1286,23 +1289,19 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 
 static inline void free_rp_inst(struct kretprobe *rp)
 {
-	struct kretprobe_instance *ri;
-	struct freelist_node *node;
-	int count = 0;
+      struct kretprobe_holder *rph = rp->rph;
+      struct freelist_node *fn;
 
-	node = rp->freelist.head;
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, freelist);
-		node = node->next;
-
-		kfree(ri);
-		count++;
-	}
-
-	if (refcount_sub_and_test(count, &rp->rph->ref)) {
-		kfree(rp->rph);
-		rp->rph = NULL;
-	}
+      rp->rph = NULL;
+      do {
+              /* must do pop() first since we have one extra ref grabbed */
+              fn = freelist_pop(&rph->fh);
+              if (refcount_dec_and_test(&rph->ref)) {
+                      freelist_fini(&rph->fh, NULL, NULL);
+                      kfree(rph);
+                      break;
+              }
+      } while (fn);
 }
 
 /* Add the new probe to ap->list */
@@ -1928,19 +1927,18 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	struct kretprobe_instance *ri;
 	struct freelist_node *fn;
+	struct kretprobe_instance *ri;
 
-	fn = freelist_try_get(&rp->freelist);
+	fn = freelist_pop(&rp->rph->fh);
 	if (!fn) {
-		rp->nmissed++;
+		atomic_inc((atomic_t *)&rp->nmissed);
 		return 0;
 	}
-
 	ri = container_of(fn, struct kretprobe_instance, freelist);
 
 	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-		freelist_add(&ri->freelist, &rp->freelist);
+		freelist_push(fn, &rp->rph->fh);
 		return 0;
 	}
 
@@ -1986,10 +1984,19 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
 	return 0;
 }
 
+static int kretprobe_init_inst(void *context, struct freelist_node *fn)
+{
+	struct kretprobe_instance *ri;
+
+	ri = container_of(fn, struct kretprobe_instance, freelist);
+	ri->rph = context;
+
+	return 0;
+}
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret;
-	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
 
@@ -2024,24 +2031,20 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
-	rp->freelist.head = NULL;
+
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
 	if (!rp->rph)
 		return -ENOMEM;
 
-	rp->rph->rp = rp;
-	for (i = 0; i < rp->maxactive; i++) {
-		inst = kzalloc(sizeof(struct kretprobe_instance) +
-			       rp->data_size, GFP_KERNEL);
-		if (inst == NULL) {
-			refcount_set(&rp->rph->ref, i);
-			free_rp_inst(rp);
-			return -ENOMEM;
-		}
-		inst->rph = rp->rph;
-		freelist_add(&inst->freelist, &rp->freelist);
+	if (freelist_init(&rp->rph->fh, rp->maxactive, rp->data_size +
+			  sizeof(struct kretprobe_instance), GFP_KERNEL,
+			  rp->rph, kretprobe_init_inst)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
+		return -ENOMEM;
 	}
-	refcount_set(&rp->rph->ref, i);
+	refcount_set(&rp->rph->ref, rp->maxactive + 1);
+	rp->rph->rp = rp;
 
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
-- 
2.25.1

