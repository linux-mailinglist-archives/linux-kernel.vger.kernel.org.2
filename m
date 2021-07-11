Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325C13C3CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhGKNZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 09:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhGKNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 09:25:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E119C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:22:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg14so27711222ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4SRbFjI8V0i8v+MNYCcvAwRiaH4zdz5UfTrosd2Ai70=;
        b=UMZW4vo98I/YcMYgewxEBquZHHmK4geBlPGh+Uyj952CMnfvNVbnqsO5byXIZsA8/M
         S2x5NtwzjLz2CDwd0GIeS0Rhw35vaEr3QE3O5j6+ZOS3i5XIETPJgZK2QpGhEDxQrlsS
         8qX+oDAqdirML7nX3t/S2rrkz0il23EmIXdriqagnyseXxsznvhxj4qGi2LtRKa4nZXi
         l5Arevbokx5NKHqQ0r8C6nWu+/Wl908QuuN7Jzmyn2kjzDtcDKp4libbx7gaJkJp01TT
         g2129/nd2/aQZUemzp8GvKC3dtOIuQT+nqEhNb4YnTOibgxqsbItjeub73QrSm0LFblC
         IM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=4SRbFjI8V0i8v+MNYCcvAwRiaH4zdz5UfTrosd2Ai70=;
        b=gnYZ4Qe+x73A8wtJqzr5mrZNDDA0e4TGK0nSmqWh5Gt8fHxdPX/JBwYt36Iwj+JQ6i
         kTjkaYd2MTCI66HkMX5vWriWIOZf3jZPAMdKD5GnK/eViu6WB+wBw3pCbZqGF/AGh40t
         IQL1NfhO+a+2NwuZ3bXtGhbPxIBPYC2oagER1UJGyH4eLlfGxaSrcM/BBcXXrKGonkUQ
         MqlWO0RBdj2/BuBXmhePetnUuP4Lwrn/+PZXQgcVTLUZrTfJBJNwbP7kAizLyBHLUEfr
         3Q1wKAcwcnJSZu1SzKbwxmCBw+vEwK/R4ITq8r+smsfIXLByXW6RU7/b4ru0cdkxeqkJ
         xpUA==
X-Gm-Message-State: AOAM530n3K+AvzyF7X4r8LUPOGjoJC+IDepXDXWTpmV5eYYSh9PY0f36
        BfvRFgj4ptIGNBz5sFFLP8O7A8ElgDU=
X-Google-Smtp-Source: ABdhPJxBlovS4TEtO5KM80hDC3wmGS6G7P+6G02j3W8efOzd7Sa+nDf9c+267RK6rY2ISQSSSNi5mw==
X-Received: by 2002:a17:906:d977:: with SMTP id rp23mr4264498ejb.512.1626009770245;
        Sun, 11 Jul 2021 06:22:50 -0700 (PDT)
Received: from gmail.com (77-234-64-154.pool.digikabel.hu. [77.234.64.154])
        by smtp.gmail.com with ESMTPSA id p21sm968204eds.81.2021.07.11.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 06:22:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Jul 2021 15:22:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <YOrwp9xEQ79sHOL0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-07-11

   # HEAD: 7e1088760cfe0bb1fdb1f0bd155bfd52f080683a locking/atomic: sparc: Fix arch_cmpxchg64_local()

Locking fixes:

 - Fix a Sparc crash
 - Fix a number of objtool warnings
 - Fix /proc/lockdep output on certain configs
 - Restore a kprobes fail-safe

 Thanks,

	Ingo

------------------>
Mark Rutland (1):
      locking/atomic: sparc: Fix arch_cmpxchg64_local()

Peter Zijlstra (3):
      jump_label: Fix jump_label_text_reserved() vs __init
      static_call: Fix static_call_text_reserved() vs __init
      kprobe/static_call: Restore missing static_call_text_reserved()

Xiongwei Song (1):
      locking/lockdep: Fix meaningless /proc/lockdep output of lock classes on !CONFIG_PROVE_LOCKING


 arch/sparc/include/asm/cmpxchg_64.h |  2 +-
 kernel/jump_label.c                 | 13 ++++++++-----
 kernel/kprobes.c                    |  2 ++
 kernel/locking/lockdep_proc.c       | 26 ++++++++++++++------------
 kernel/static_call.c                | 13 ++++++++-----
 5 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 8c39a9981187..12d00a42c0a3 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -201,7 +201,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 #define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));					\
   })
 #define arch_cmpxchg64(ptr, o, n)	arch_cmpxchg64_local((ptr), (o), (n))
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bdb0681bece8..b156e152d6b4 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -316,14 +316,16 @@ static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 }
 
 static int __jump_label_text_reserved(struct jump_entry *iter_start,
-		struct jump_entry *iter_stop, void *start, void *end)
+		struct jump_entry *iter_stop, void *start, void *end, bool init)
 {
 	struct jump_entry *iter;
 
 	iter = iter_start;
 	while (iter < iter_stop) {
-		if (addr_conflict(iter, start, end))
-			return 1;
+		if (init || !jump_entry_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
 		iter++;
 	}
 
@@ -562,7 +564,7 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
 
 	ret = __jump_label_text_reserved(mod->jump_entries,
 				mod->jump_entries + mod->num_jump_entries,
-				start, end);
+				start, end, mod->state == MODULE_STATE_COMING);
 
 	module_put(mod);
 
@@ -788,8 +790,9 @@ early_initcall(jump_label_init_module);
  */
 int jump_label_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __jump_label_text_reserved(__start___jump_table,
-			__stop___jump_table, start, end);
+			__stop___jump_table, start, end, init);
 
 	if (ret)
 		return ret;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e41385afe79d..069388d26e3c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/static_call.h>
 #include <linux/perf_event.h>
 
 #include <asm/sections.h>
@@ -1551,6 +1552,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
+	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 806978314496..b8d9a050c337 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -70,26 +70,28 @@ static int l_show(struct seq_file *m, void *v)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	seq_printf(m, " OPS:%8ld", debug_class_ops_read(class));
 #endif
-#ifdef CONFIG_PROVE_LOCKING
-	seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
-	seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
-#endif
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
+		seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
 
-	get_usage_chars(class, usage);
-	seq_printf(m, " %s", usage);
+		get_usage_chars(class, usage);
+		seq_printf(m, " %s", usage);
+	}
 
 	seq_printf(m, ": ");
 	print_name(m, class);
 	seq_puts(m, "\n");
 
-	list_for_each_entry(entry, &class->locks_after, entry) {
-		if (entry->distance == 1) {
-			seq_printf(m, " -> [%p] ", entry->class->key);
-			print_name(m, entry->class);
-			seq_puts(m, "\n");
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		list_for_each_entry(entry, &class->locks_after, entry) {
+			if (entry->distance == 1) {
+				seq_printf(m, " -> [%p] ", entry->class->key);
+				print_name(m, entry->class);
+				seq_puts(m, "\n");
+			}
 		}
+		seq_puts(m, "\n");
 	}
-	seq_puts(m, "\n");
 
 	return 0;
 }
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 723fcc9d20db..43ba0b1e0edb 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -292,13 +292,15 @@ static int addr_conflict(struct static_call_site *site, void *start, void *end)
 
 static int __static_call_text_reserved(struct static_call_site *iter_start,
 				       struct static_call_site *iter_stop,
-				       void *start, void *end)
+				       void *start, void *end, bool init)
 {
 	struct static_call_site *iter = iter_start;
 
 	while (iter < iter_stop) {
-		if (addr_conflict(iter, start, end))
-			return 1;
+		if (init || !static_call_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
 		iter++;
 	}
 
@@ -324,7 +326,7 @@ static int __static_call_mod_text_reserved(void *start, void *end)
 
 	ret = __static_call_text_reserved(mod->static_call_sites,
 			mod->static_call_sites + mod->num_static_call_sites,
-			start, end);
+			start, end, mod->state == MODULE_STATE_COMING);
 
 	module_put(mod);
 
@@ -459,8 +461,9 @@ static inline int __static_call_mod_text_reserved(void *start, void *end)
 
 int static_call_text_reserved(void *start, void *end)
 {
+	bool init = system_state < SYSTEM_RUNNING;
 	int ret = __static_call_text_reserved(__start_static_call_sites,
-			__stop_static_call_sites, start, end);
+			__stop_static_call_sites, start, end, init);
 
 	if (ret)
 		return ret;
