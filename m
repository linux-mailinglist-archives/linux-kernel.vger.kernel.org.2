Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1AE4229FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhJEODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236030AbhJEOCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:02:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA7761881;
        Tue,  5 Oct 2021 13:58:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxg-0055kG-2m; Tue, 05 Oct 2021 09:58:28 -0400
Message-ID: <20211005135827.925180493@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [for-linus][PATCH 13/27] kprobes: treewide: Replace arch_deref_entry_point() with
 dereference_symbol_descriptor()
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

~15 years ago kprobes grew the 'arch_deref_entry_point()' __weak function:

  3d7e33825d87: ("jprobes: make jprobes a little safer for users")

But this is just open-coded dereference_symbol_descriptor() in essence, and
its obscure nature was causing bugs.

Just use the real thing and remove arch_deref_entry_point().

Link: https://lkml.kernel.org/r/163163043630.489837.7924988885652708696.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/ia64/kernel/kprobes.c    |  5 -----
 arch/powerpc/kernel/kprobes.c | 11 -----------
 include/linux/kprobes.h       |  1 -
 kernel/kprobes.c              |  7 +------
 lib/error-inject.c            |  3 ++-
 5 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index d4048518a1d7..0f8573bbf520 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -891,11 +891,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-unsigned long arch_deref_entry_point(void *entry)
-{
-	return ((struct fnptr *)entry)->ip;
-}
-
 static struct kprobe trampoline_p = {
 	.pre_handler = trampoline_probe_handler
 };
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 7a7cd6bda53e..d422e297978b 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -542,17 +542,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 }
 NOKPROBE_SYMBOL(kprobe_fault_handler);
 
-unsigned long arch_deref_entry_point(void *entry)
-{
-#ifdef PPC64_ELF_ABI_v1
-	if (!kernel_text_address((unsigned long)entry))
-		return ppc_global_function_entry(entry);
-	else
-#endif
-		return (unsigned long)entry;
-}
-NOKPROBE_SYMBOL(arch_deref_entry_point);
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0ba3f9e316d4..2ed61fcbc89c 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -381,7 +381,6 @@ int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
 void unregister_kprobes(struct kprobe **kps, int num);
-unsigned long arch_deref_entry_point(void *);
 
 int register_kretprobe(struct kretprobe *rp);
 void unregister_kretprobe(struct kretprobe *rp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8021bccb7770..550042d9a6ef 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1861,11 +1861,6 @@ static struct notifier_block kprobe_exceptions_nb = {
 	.priority = 0x7fffffff /* we need to be notified first */
 };
 
-unsigned long __weak arch_deref_entry_point(void *entry)
-{
-	return (unsigned long)entry;
-}
-
 #ifdef CONFIG_KRETPROBES
 
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
@@ -2327,7 +2322,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	int ret;
 
 	for (iter = start; iter < end; iter++) {
-		entry = arch_deref_entry_point((void *)*iter);
+		entry = (unsigned long)dereference_symbol_descriptor((void *)*iter);
 		ret = kprobe_add_ksym_blacklist(entry);
 		if (ret == -EINVAL)
 			continue;
diff --git a/lib/error-inject.c b/lib/error-inject.c
index c73651b15b76..2ff5ef689d72 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <asm/sections.h>
 
 /* Whitelist of symbols that can be overridden for error injection. */
 static LIST_HEAD(error_injection_list);
@@ -64,7 +65,7 @@ static void populate_error_injection_list(struct error_injection_entry *start,
 
 	mutex_lock(&ei_mutex);
 	for (iter = start; iter < end; iter++) {
-		entry = arch_deref_entry_point((void *)iter->addr);
+		entry = (unsigned long)dereference_symbol_descriptor((void *)iter->addr);
 
 		if (!kernel_text_address(entry) ||
 		    !kallsyms_lookup_size_offset(entry, &size, &offset)) {
-- 
2.32.0
