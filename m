Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418FD440120
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJ2RWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhJ2RWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:22:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:19:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v17so17296655wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2HpreeQxrcpiEkneCxlFcZuuWoJwZlDGWyR3gCzd0E=;
        b=DCc1fV5Ck2jVvsEQRwJByHjW0p6z+CWn5XNGJmHS6wVqOpVIsInHDrhr12doGJXLnG
         RrYcddX3cG4kheHeeJdNp1UV2ekKPpoIGoSNy4sEiV+7AXgbYJkfhCIRMSaE4ge+vfXu
         yIJF83IOlTlXNZIuDXC08pDNbFDT06T28If1Zgfmt3Dg0fm0ab5GTNyPxHiS7103eg5a
         eYxHsum8CJxMudAXHOlJkFhYeYzSWslkv1u1E+UEhZpK+T5BH+8WjMUf/bLVSVnhT8Lw
         NGt8sRgaRtVzyHOkvuxJk7xCcMDZrOqtWc1UYekahNOyM2Q0kv1ZZ1coQCJegokUz9hD
         lhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2HpreeQxrcpiEkneCxlFcZuuWoJwZlDGWyR3gCzd0E=;
        b=5dcgFrOxNBG86cn+bhV0P+9v0v/+dYYgupn6ztxUZE/mH5Pwn+x6ZsR5tfIxspjQr4
         f2ZV9NeZQLOPqZrDfq3rAaaSeeiiIOGXVA0AGGJgcOWzJvIQsIayuc6YhOdGTsQFy8Jk
         xeGPRZ+6arqhzkpFOTsR2il5Hu80a0XzyaoNSwKqV/xOOcwP0LOZbLdPmGicgCI6avM4
         QLxoSOsNJM5d6kdlnjRA3Bwhzfpv1qZLSKYdKLuKYUiKvNm4EVshjHL/Why3cpbmrdTU
         zZ3iHURiZUK/Fv8/oRLn3u2ktF8KwPMKobyQC85MCW4uvGRNyuXaJvFok2YabVmhprD2
         /8nw==
X-Gm-Message-State: AOAM5307gN4EGJ88kvuzvpPQ67GiTOH2Lp9qybK4E3xO3BhOBgS4RcsZ
        kSnsSZpOiMOYU0XFgWynxEB+rf4zQ4TgqGMU
X-Google-Smtp-Source: ABdhPJy6xwzhrzRncAHgJDKg/nKsFlo5eUpdiJlVP43TQFvkg7KiMxMGpDFzBKKOPfwsU+2fENGBew==
X-Received: by 2002:a5d:6e91:: with SMTP id k17mr15669442wrz.260.1635527980139;
        Fri, 29 Oct 2021 10:19:40 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m8sm6302980wri.33.2021.10.29.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 10:19:39 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Xiang wangx <wangxiang@cdjrlc.com>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2] kdb: Adopt scheduler's task clasification
Date:   Fri, 29 Oct 2021 18:19:35 +0100
Message-Id: <20211029171935.2926228-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916154253.2731609-1-daniel.thompson@linaro.org>
References: <20210916154253.2731609-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb contains some open-coded routines to generate a summary
character for each task. This code currently issues warnings, is
almost certainly broken and won't make sense to any kernel dev who
has ever used /proc to examine task states.

Fix both the warning and the potential for confusion by adopting the
scheduler's task classification. Whilst doing this we also simplify the
filtering by using mask strings directly (which means we don't have to
guess all the characters the scheduler might give us).

Unfortunately we can't quite match the scheduler classification completely.
We add four extra states: - for idle loops and i, m and s sleeping system
daemons (which means kthreads in one of the I, M and S states). These
extra states are used to manage the filters for tools to make the output
of ps and bta less noisy.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Sorry it's taken so long to respin this patch.
    
    v2:
    - Fix the typos in the description (Doug)
    - Stop trying to bend to world so I can keep 'I' exactly as
      it was before. Instead we now replace 'I' with '-' and
      fully adopt the scheduler description of tasks. kdb
      it an interactive tool, not ABI so this is OK. (Doug)
    - Don't try to enumerate all possible letters in the
      comments and help. You can learn what to filter from
      the output of ps anyway, (Doug)
    - Fix the sleeping system daemon stuff.

 kernel/debug/kdb/kdb_bt.c      |  14 ++--
 kernel/debug/kdb/kdb_main.c    |  31 ++++-----
 kernel/debug/kdb/kdb_private.h |   4 +-
 kernel/debug/kdb/kdb_support.c | 117 +++++++--------------------------
 4 files changed, 48 insertions(+), 118 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 1f9f0e47aeda..3368a2d15d73 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -74,7 +74,7 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
  */

 static int
-kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
+kdb_bt1(struct task_struct *p, const char *mask, bool btaprompt)
 {
 	char ch;

@@ -120,7 +120,7 @@ kdb_bt_cpu(unsigned long cpu)
 		return;
 	}

-	kdb_bt1(kdb_tsk, ~0UL, false);
+	kdb_bt1(kdb_tsk, "A", false);
 }

 int
@@ -138,8 +138,8 @@ kdb_bt(int argc, const char **argv)
 	if (strcmp(argv[0], "bta") == 0) {
 		struct task_struct *g, *p;
 		unsigned long cpu;
-		unsigned long mask = kdb_task_state_string(argc ? argv[1] :
-							   NULL);
+		const char *mask = argc ? argv[1] : kdbgetenv("PS");
+
 		if (argc == 0)
 			kdb_ps_suppressed();
 		/* Run the active tasks first */
@@ -167,7 +167,7 @@ kdb_bt(int argc, const char **argv)
 			return diag;
 		p = find_task_by_pid_ns(pid, &init_pid_ns);
 		if (p)
-			return kdb_bt1(p, ~0UL, false);
+			return kdb_bt1(p, "A", false);
 		kdb_printf("No process with pid == %ld found\n", pid);
 		return 0;
 	} else if (strcmp(argv[0], "btt") == 0) {
@@ -176,7 +176,7 @@ kdb_bt(int argc, const char **argv)
 		diag = kdbgetularg((char *)argv[1], &addr);
 		if (diag)
 			return diag;
-		return kdb_bt1((struct task_struct *)addr, ~0UL, false);
+		return kdb_bt1((struct task_struct *)addr, "A", false);
 	} else if (strcmp(argv[0], "btc") == 0) {
 		unsigned long cpu = ~0;
 		if (argc > 1)
@@ -212,7 +212,7 @@ kdb_bt(int argc, const char **argv)
 			kdb_show_stack(kdb_current_task, (void *)addr);
 			return 0;
 		} else {
-			return kdb_bt1(kdb_current_task, ~0UL, false);
+			return kdb_bt1(kdb_current_task, "A", false);
 		}
 	}

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index fa6deda894a1..2c1abb86a06b 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2203,8 +2203,8 @@ static void kdb_cpu_status(void)
 			state = 'D';	/* cpu is online but unresponsive */
 		} else {
 			state = ' ';	/* cpu is responding to kdb */
-			if (kdb_task_state_char(KDB_TSK(i)) == 'I')
-				state = 'I';	/* idle task */
+			if (kdb_task_state_char(KDB_TSK(i)) == '-')
+				state = '-';	/* idle task */
 		}
 		if (state != prev_state) {
 			if (prev_state != '?') {
@@ -2271,17 +2271,15 @@ static int kdb_cpu(int argc, const char **argv)
 void kdb_ps_suppressed(void)
 {
 	int idle = 0, daemon = 0;
-	unsigned long mask_I = kdb_task_state_string("I"),
-		      mask_M = kdb_task_state_string("M");
 	unsigned long cpu;
 	const struct task_struct *p, *g;
 	for_each_online_cpu(cpu) {
 		p = kdb_curr_task(cpu);
-		if (kdb_task_state(p, mask_I))
+		if (kdb_task_state(p, "-"))
 			++idle;
 	}
 	for_each_process_thread(g, p) {
-		if (kdb_task_state(p, mask_M))
+		if (kdb_task_state(p, "ims"))
 			++daemon;
 	}
 	if (idle || daemon) {
@@ -2297,11 +2295,6 @@ void kdb_ps_suppressed(void)
 	}
 }

-/*
- * kdb_ps - This function implements the 'ps' command which shows a
- *	list of the active processes.
- *		ps [DRSTCZEUIMA]   All processes, optionally filtered by state
- */
 void kdb_ps1(const struct task_struct *p)
 {
 	int cpu;
@@ -2330,17 +2323,25 @@ void kdb_ps1(const struct task_struct *p)
 	}
 }

+/*
+ * kdb_ps - This function implements the 'ps' command which shows a
+ *	    list of the active processes.
+ *
+ * ps [<state_chars>]   Show processes, optionally selecting only those whose
+ *                      state character is found in <state_chars>.
+ */
 static int kdb_ps(int argc, const char **argv)
 {
 	struct task_struct *g, *p;
-	unsigned long mask, cpu;
+	const char *mask;
+	unsigned long cpu;

 	if (argc == 0)
 		kdb_ps_suppressed();
 	kdb_printf("%-*s      Pid   Parent [*] cpu State %-*s Command\n",
 		(int)(2*sizeof(void *))+2, "Task Addr",
 		(int)(2*sizeof(void *))+2, "Thread");
-	mask = kdb_task_state_string(argc ? argv[1] : NULL);
+	mask = argc ? argv[1] : kdbgetenv("PS");
 	/* Run the active tasks first */
 	for_each_online_cpu(cpu) {
 		if (KDB_FLAG(CMD_INTERRUPT))
@@ -2742,8 +2743,8 @@ static kdbtab_t maintab[] = {
 	},
 	{	.name = "bta",
 		.func = kdb_bt,
-		.usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
-		.help = "Backtrace all processes matching state flag",
+		.usage = "[<state_chars>|A]",
+		.help = "Backtrace all processes matching whose state matches",
 		.flags = KDB_ENABLE_INSPECT,
 	},
 	{	.name = "btc",
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 629590084a0d..0d2f9feea0a4 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -190,10 +190,8 @@ extern char kdb_grep_string[];
 extern int kdb_grep_leading;
 extern int kdb_grep_trailing;
 extern char *kdb_cmds[];
-extern unsigned long kdb_task_state_string(const char *);
 extern char kdb_task_state_char (const struct task_struct *);
-extern unsigned long kdb_task_state(const struct task_struct *p,
-				    unsigned long mask);
+extern bool kdb_task_state(const struct task_struct *p, const char *mask);
 extern void kdb_ps_suppressed(void);
 extern void kdb_ps1(const struct task_struct *p);
 extern void kdb_send_sig(struct task_struct *p, int sig);
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 7507d9a8dc6a..19f5c893580b 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -24,6 +24,7 @@
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
 #include <linux/slab.h>
+#include <linux/ctype.h>
 #include "kdb_private.h"

 /*
@@ -473,82 +474,7 @@ int kdb_putword(unsigned long addr, unsigned long word, size_t size)
 	return diag;
 }

-/*
- * kdb_task_state_string - Convert a string containing any of the
- *	letters DRSTCZEUIMA to a mask for the process state field and
- *	return the value.  If no argument is supplied, return the mask
- *	that corresponds to environment variable PS, DRSTCZEU by
- *	default.
- * Inputs:
- *	s	String to convert
- * Returns:
- *	Mask for process state.
- * Notes:
- *	The mask folds data from several sources into a single long value, so
- *	be careful not to overlap the bits.  TASK_* bits are in the LSB,
- *	special cases like UNRUNNABLE are in the MSB.  As of 2.6.10-rc1 there
- *	is no overlap between TASK_* and EXIT_* but that may not always be
- *	true, so EXIT_* bits are shifted left 16 bits before being stored in
- *	the mask.
- */
-
-/* unrunnable is < 0 */
-#define UNRUNNABLE	(1UL << (8*sizeof(unsigned long) - 1))
-#define RUNNING		(1UL << (8*sizeof(unsigned long) - 2))
-#define IDLE		(1UL << (8*sizeof(unsigned long) - 3))
-#define DAEMON		(1UL << (8*sizeof(unsigned long) - 4))

-unsigned long kdb_task_state_string(const char *s)
-{
-	long res = 0;
-	if (!s) {
-		s = kdbgetenv("PS");
-		if (!s)
-			s = "DRSTCZEU";	/* default value for ps */
-	}
-	while (*s) {
-		switch (*s) {
-		case 'D':
-			res |= TASK_UNINTERRUPTIBLE;
-			break;
-		case 'R':
-			res |= RUNNING;
-			break;
-		case 'S':
-			res |= TASK_INTERRUPTIBLE;
-			break;
-		case 'T':
-			res |= TASK_STOPPED;
-			break;
-		case 'C':
-			res |= TASK_TRACED;
-			break;
-		case 'Z':
-			res |= EXIT_ZOMBIE << 16;
-			break;
-		case 'E':
-			res |= EXIT_DEAD << 16;
-			break;
-		case 'U':
-			res |= UNRUNNABLE;
-			break;
-		case 'I':
-			res |= IDLE;
-			break;
-		case 'M':
-			res |= DAEMON;
-			break;
-		case 'A':
-			res = ~0UL;
-			break;
-		default:
-			  kdb_func_printf("unknown flag '%c' ignored\n", *s);
-			  break;
-		}
-		++s;
-	}
-	return res;
-}

 /*
  * kdb_task_state_char - Return the character that represents the task state.
@@ -559,7 +485,6 @@ unsigned long kdb_task_state_string(const char *s)
  */
 char kdb_task_state_char (const struct task_struct *p)
 {
-	unsigned int p_state;
 	unsigned long tmp;
 	char state;
 	int cpu;
@@ -568,25 +493,17 @@ char kdb_task_state_char (const struct task_struct *p)
 	    copy_from_kernel_nofault(&tmp, (char *)p, sizeof(unsigned long)))
 		return 'E';

-	cpu = kdb_process_cpu(p);
-	p_state = READ_ONCE(p->__state);
-	state = (p_state == 0) ? 'R' :
-		(p_state < 0) ? 'U' :
-		(p_state & TASK_UNINTERRUPTIBLE) ? 'D' :
-		(p_state & TASK_STOPPED) ? 'T' :
-		(p_state & TASK_TRACED) ? 'C' :
-		(p->exit_state & EXIT_ZOMBIE) ? 'Z' :
-		(p->exit_state & EXIT_DEAD) ? 'E' :
-		(p_state & TASK_INTERRUPTIBLE) ? 'S' : '?';
+	state = task_state_to_char((struct task_struct *) p);
+
 	if (is_idle_task(p)) {
 		/* Idle task.  Is it really idle, apart from the kdb
 		 * interrupt? */
 		if (!kdb_task_has_cpu(p) || kgdb_info[cpu].irq_depth == 1) {
 			if (cpu != kdb_initial_cpu)
-				state = 'I';	/* idle task */
+				state = '-';	/* idle task */
 		}
-	} else if (!p->mm && state == 'S') {
-		state = 'M';	/* sleeping system daemon */
+	} else if (!p->mm && strchr("IMS", state)) {
+		state = tolower(state);		/* sleeping system daemon */
 	}
 	return state;
 }
@@ -596,14 +513,28 @@ char kdb_task_state_char (const struct task_struct *p)
  *	given by the mask.
  * Inputs:
  *	p	struct task for the process
- *	mask	mask from kdb_task_state_string to select processes
+ *	mask	set of characters used to select processes; both NULL
+ *	        and the empty string mean adopt a default filter, which
+ *	        is to suppress sleeping system daemons and the idle tasks
  * Returns:
  *	True if the process matches at least one criteria defined by the mask.
  */
-unsigned long kdb_task_state(const struct task_struct *p, unsigned long mask)
+bool kdb_task_state(const struct task_struct *p, const char *mask)
 {
-	char state[] = { kdb_task_state_char(p), '\0' };
-	return (mask & kdb_task_state_string(state)) != 0;
+	char state = kdb_task_state_char(p);
+
+	/* If there is no mask, then we will filter code that runs when the
+	 * scheduler is idling and any system daemons that are currently
+	 * sleeping.
+	 */
+	if (!mask || mask[0] == '\0')
+		return !strchr("-ims", state);
+
+	/* A is a special case that matches all states */
+	if (strchr(mask, 'A'))
+		return true;
+
+	return strchr(mask, state);
 }

 /* Maintain a small stack of kdb_flags to allow recursion without disturbing

base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
--
2.31.1

