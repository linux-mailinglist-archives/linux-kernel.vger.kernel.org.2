Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB43ACD6F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhFROZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234370AbhFROZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:25:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDA0611ED;
        Fri, 18 Jun 2021 14:23:25 +0000 (UTC)
Date:   Fri, 18 Jun 2021 10:23:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [GIT PULL] tracing: Fixes for 5.13-rc6
Message-ID: <20210618102323.3b630647@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Tracing fixes for 5.13:

 - Have recordmcount check for valid st_shndx otherwise some archs may have
   invalid references for the mcount location.

 - Two fixes done for mapping pids to task names. Traces were not showing
   the names of tasks when they should have.

 - Fix to trace_clock_global() to prevent it from going backwards


Please pull the latest trace-v5.13-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.13-rc6

Tag SHA1: 41def28d8719d14033b29b043f8b6e141b9ac874
Head SHA1: 89529d8b8f8daf92d9979382b8d2eb39966846ea


Peter Zijlstra (1):
      recordmcount: Correct st_shndx handling

Steven Rostedt (VMware) (3):
      tracing: Do not stop recording cmdlines when tracing is off
      tracing: Do not stop recording comms if the trace file is being read
      tracing: Do no increment trace_clock_global() by one

----
 kernel/trace/trace.c       | 11 -----------
 kernel/trace/trace_clock.c |  6 +++---
 scripts/recordmcount.h     | 15 ++++++++++-----
 3 files changed, 13 insertions(+), 19 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9299057feb56..d23a09d3eb37 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2198,9 +2198,6 @@ struct saved_cmdlines_buffer {
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
-/* temporary disable recording */
-static atomic_t trace_record_taskinfo_disabled __read_mostly;
-
 static inline char *get_saved_cmdlines(int idx)
 {
 	return &savedcmd->saved_cmdlines[idx * TASK_COMM_LEN];
@@ -2486,8 +2483,6 @@ static bool tracing_record_taskinfo_skip(int flags)
 {
 	if (unlikely(!(flags & (TRACE_RECORD_CMDLINE | TRACE_RECORD_TGID))))
 		return true;
-	if (atomic_read(&trace_record_taskinfo_disabled) || !tracing_is_on())
-		return true;
 	if (!__this_cpu_read(trace_taskinfo_save))
 		return true;
 	return false;
@@ -3998,9 +3993,6 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EBUSY);
 #endif
 
-	if (!iter->snapshot)
-		atomic_inc(&trace_record_taskinfo_disabled);
-
 	if (*pos != iter->pos) {
 		iter->ent = NULL;
 		iter->cpu = 0;
@@ -4043,9 +4035,6 @@ static void s_stop(struct seq_file *m, void *p)
 		return;
 #endif
 
-	if (!iter->snapshot)
-		atomic_dec(&trace_record_taskinfo_disabled);
-
 	trace_access_unlock(iter->cpu_file);
 	trace_event_read_unlock();
 }
diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index c1637f90c8a3..4702efb00ff2 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -115,9 +115,9 @@ u64 notrace trace_clock_global(void)
 	prev_time = READ_ONCE(trace_clock_struct.prev_time);
 	now = sched_clock_cpu(this_cpu);
 
-	/* Make sure that now is always greater than prev_time */
+	/* Make sure that now is always greater than or equal to prev_time */
 	if ((s64)(now - prev_time) < 0)
-		now = prev_time + 1;
+		now = prev_time;
 
 	/*
 	 * If in an NMI context then dont risk lockups and simply return
@@ -131,7 +131,7 @@ u64 notrace trace_clock_global(void)
 		/* Reread prev_time in case it was already updated */
 		prev_time = READ_ONCE(trace_clock_struct.prev_time);
 		if ((s64)(now - prev_time) < 0)
-			now = prev_time + 1;
+			now = prev_time;
 
 		trace_clock_struct.prev_time = now;
 
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index f9b19524da11..1e9baa5c4fc6 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -192,15 +192,20 @@ static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
 				 Elf32_Word const *symtab_shndx)
 {
 	unsigned long offset;
+	unsigned short shndx = w2(sym->st_shndx);
 	int index;
 
-	if (sym->st_shndx != SHN_XINDEX)
-		return w2(sym->st_shndx);
+	if (shndx > SHN_UNDEF && shndx < SHN_LORESERVE)
+		return shndx;
 
-	offset = (unsigned long)sym - (unsigned long)symtab;
-	index = offset / sizeof(*sym);
+	if (shndx == SHN_XINDEX) {
+		offset = (unsigned long)sym - (unsigned long)symtab;
+		index = offset / sizeof(*sym);
 
-	return w(symtab_shndx[index]);
+		return w(symtab_shndx[index]);
+	}
+
+	return 0;
 }
 
 static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
