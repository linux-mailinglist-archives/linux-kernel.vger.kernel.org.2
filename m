Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422EB437F99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhJVUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234433AbhJVUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF88613A2;
        Fri, 22 Oct 2021 20:48:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T2-000QTZ-8H;
        Fri, 22 Oct 2021 16:48:44 -0400
Message-ID: <20211022204844.089918832@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [for-next][PATCH 32/40] tracing: use %ps format string to print symbols
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang started warning about excessive stack usage in
hist_trigger_print_key()

kernel/trace/trace_events_hist.c:4723:13: error: stack frame size (1336) exceeds limit (1024) in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than]

The problem is that there are two 512-byte arrays on the stack if
hist_trigger_stacktrace_print() gets inlined. I don't think this has
changed in the past five years, but something probably changed the
inlining decisions made by the compiler, so the problem is now made
more obvious.

Rather than printing the symbol names into separate buffers, it
seems we can simply use the special %ps format string modifier
to print the pointers symbolically and get rid of both buffers.

Marking hist_trigger_stacktrace_print() would be a simpler
way of avoiding the warning, but that would not address the
excessive stack usage.

Link: https://lkml.kernel.org/r/20211019153337.294790-1-arnd@kernel.org

Fixes: 69a0200c2e25 ("tracing: Add hist trigger support for stacktraces as keys")
Link: https://lore.kernel.org/all/20211015095704.49a99859@gandalf.local.home/
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a6061a69aa84..b64aed538628 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4706,7 +4706,6 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 					  unsigned long *stacktrace_entries,
 					  unsigned int max_entries)
 {
-	char str[KSYM_SYMBOL_LEN];
 	unsigned int spaces = 8;
 	unsigned int i;
 
@@ -4715,8 +4714,7 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
 			return;
 
 		seq_printf(m, "%*c", 1 + spaces, ' ');
-		sprint_symbol(str, stacktrace_entries[i]);
-		seq_printf(m, "%s\n", str);
+		seq_printf(m, "%pS\n", (void*)stacktrace_entries[i]);
 	}
 }
 
@@ -4726,7 +4724,6 @@ static void hist_trigger_print_key(struct seq_file *m,
 				   struct tracing_map_elt *elt)
 {
 	struct hist_field *key_field;
-	char str[KSYM_SYMBOL_LEN];
 	bool multiline = false;
 	const char *field_name;
 	unsigned int i;
@@ -4747,14 +4744,12 @@ static void hist_trigger_print_key(struct seq_file *m,
 			seq_printf(m, "%s: %llx", field_name, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
 			uval = *(u64 *)(key + key_field->offset);
-			sprint_symbol_no_offset(str, uval);
-			seq_printf(m, "%s: [%llx] %-45s", field_name,
-				   uval, str);
+			seq_printf(m, "%s: [%llx] %-45ps", field_name,
+				   uval, (void *)(uintptr_t)uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
 			uval = *(u64 *)(key + key_field->offset);
-			sprint_symbol(str, uval);
-			seq_printf(m, "%s: [%llx] %-55s", field_name,
-				   uval, str);
+			seq_printf(m, "%s: [%llx] %-55pS", field_name,
+				   uval, (void *)(uintptr_t)uval);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
 			struct hist_elt_data *elt_data = elt->private_data;
 			char *comm;
-- 
2.33.0
