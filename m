Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0942EC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhJOIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhJOIg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14D8B61163;
        Fri, 15 Oct 2021 08:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634286891;
        bh=w7I3isHilKHKwf+oc042wFtMnSECHsqcb7pKgCqj6b8=;
        h=From:To:Cc:Subject:Date:From;
        b=CMuMbldLi+BxAJoRuEZdIZn+sfA9ivABZDetIc2UHJvdyN+uP3H25TDe+9EEzB0yD
         s6OpVkxgkKKiLLSqeKflU6MOgc1OyBz9O+buW/SD2nVsplf/XzqxnqvNNLqEtW/Dxy
         wq2llFhqUrm9ap/xd+NkxRd7WWOrZ+GKoKObeVFeu0OgcwpjI4bvEqDJHAvEvG/P5n
         0+VW33OBgitbDt9VBQueA1s+m3J31+vUjkZPFxH8urdBHTrWUCQDux2cpY3nz7G3Li
         HEcp0r3JKGfi0mIo1jooDCUUP5Mcbhgb7L2/t5g+6qnUUR3b1azH0/xh8IyKRWPEEh
         p3PgMPqMHz9DQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] tracing: use %ps format string to print symbols
Date:   Fri, 15 Oct 2021 10:34:31 +0200
Message-Id: <20211015083447.760448-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fixes: 69a0200c2e25 ("tracing: Add hist trigger support for stacktraces as keys")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not sure if the %ps format string actually works as intended
with the explicit length modifier, it would be good if someone
could try this out before applying. Would it be ok to remove the
length modifier otherwise?
---
 kernel/trace/trace_events_hist.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a6061a69aa84..640c79898b51 100644
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
+		seq_printf(m, "%pS\n", stacktrace_entries[i]);
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
+				   uval, (void *)uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
 			uval = *(u64 *)(key + key_field->offset);
-			sprint_symbol(str, uval);
-			seq_printf(m, "%s: [%llx] %-55s", field_name,
-				   uval, str);
+			seq_printf(m, "%s: [%llx] %-55ps", field_name,
+				   uval, (void *)uval);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
 			struct hist_elt_data *elt_data = elt->private_data;
 			char *comm;
-- 
2.29.2

