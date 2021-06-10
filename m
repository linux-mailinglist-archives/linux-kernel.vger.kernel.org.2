Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD63A218E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFJApP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:45:15 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB33613F1;
        Thu, 10 Jun 2021 00:43:19 +0000 (UTC)
Date:   Wed, 9 Jun 2021 20:43:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] tracing: Fixes for 5.13
Message-ID: <20210609204317.48df7807@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 5.13:

 - Fix the length check in the temp buffer filter

 - Fix record mcount handling of st_shndx

 - Fix build failure in bootconfig tools for "fallthrough" macro

 - Fix error return of bootconfig apply_xbc() routine


Please pull the latest trace-v5.13-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.13-rc5

Tag SHA1: 000cdf0e4dec9904fa4a66eb4a173b14208377c3
Head SHA1: 9e419de4c678418a7eb17f27f9d07c0e47bd463a


Liangyan (1):
      tracing: Correct the length check which causes memory corruption

Masami Hiramatsu (1):
      tools/bootconfig: Fix a build error accroding to undefined fallthrough

Peter Zijlstra (1):
      recordmcount: Correct st_shndx handling

Steven Rostedt (VMware) (1):
      ftrace: Do not blindly read the ip address in ftrace_bug()

Zhen Lei (1):
      tools/bootconfig: Fix error return code in apply_xbc()

----
 kernel/trace/ftrace.c                       |  8 +++++++-
 kernel/trace/trace.c                        |  2 +-
 scripts/recordmcount.h                      | 13 +++++++++----
 tools/bootconfig/include/linux/bootconfig.h |  4 ++++
 tools/bootconfig/main.c                     |  1 +
 5 files changed, 22 insertions(+), 6 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2e8a3fde7104..72ef4dccbcc4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1967,12 +1967,18 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 
 static void print_ip_ins(const char *fmt, const unsigned char *p)
 {
+	char ins[MCOUNT_INSN_SIZE];
 	int i;
 
+	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
+		printk(KERN_CONT "%s[FAULT] %px\n", fmt, p);
+		return;
+	}
+
 	printk(KERN_CONT "%s", fmt);
 
 	for (i = 0; i < MCOUNT_INSN_SIZE; i++)
-		printk(KERN_CONT "%s%02x", i ? ":" : "", p[i]);
+		printk(KERN_CONT "%s%02x", i ? ":" : "", ins[i]);
 }
 
 enum ftrace_bug_type ftrace_bug_type;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a21ef9cd2aae..9299057feb56 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2736,7 +2736,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
-		if ((len < (PAGE_SIZE - sizeof(*entry))) && val == 1) {
+		if ((len < (PAGE_SIZE - sizeof(*entry) - sizeof(entry->array[0]))) && val == 1) {
 			trace_event_setup(entry, type, trace_ctx);
 			entry->array[0] = len;
 			return entry;
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index f9b19524da11..7e8a11ed5e2f 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -194,13 +194,18 @@ static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
 	unsigned long offset;
 	int index;
 
-	if (sym->st_shndx != SHN_XINDEX)
+	if (sym->st_shndx > SHN_UNDEF &&
+	    sym->st_shndx < SHN_LORESERVE)
 		return w2(sym->st_shndx);
 
-	offset = (unsigned long)sym - (unsigned long)symtab;
-	index = offset / sizeof(*sym);
+	if (sym->st_shndx == SHN_XINDEX) {
+		offset = (unsigned long)sym - (unsigned long)symtab;
+		index = offset / sizeof(*sym);
 
-	return w(symtab_shndx[index]);
+		return w(symtab_shndx[index]);
+	}
+
+	return 0;
 }
 
 static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index 078cbd2ba651..de7f30f99af3 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -4,4 +4,8 @@
 
 #include "../../../../include/linux/bootconfig.h"
 
+#ifndef fallthrough
+# define fallthrough
+#endif
+
 #endif
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7362bef1a368..6cd6080cac04 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -399,6 +399,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	if (fstat(fd, &stat) < 0) {
+		ret = -errno;
 		pr_err("Failed to get the size of %s\n", path);
 		goto out;
 	}
