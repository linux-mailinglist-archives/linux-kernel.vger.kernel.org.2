Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1E44FD2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 03:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhKOChY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 21:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhKOCgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:36:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C191360F0F;
        Mon, 15 Nov 2021 02:33:18 +0000 (UTC)
Date:   Sun, 14 Nov 2021 21:33:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Add length protection to histogram string
 copies
Message-ID: <20211114213317.78ec57ec@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

Update to tracing histogram variable string copy

A fix to only copy the size of the field to the histogram string
did not take into account that the size can be larger than the
storage.


Please pull the latest trace-v5.16-5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-5

Tag SHA1: db2ed9a1d3f9d93cb36d38110e6567c1bd8d1e9a
Head SHA1: 938aa33f14657c9ed9deea348b7d6f14b6d69cb7


Steven Rostedt (VMware) (1):
      tracing: Add length protection to histogram string copies

----
 include/linux/trace_events.h     | 2 +-
 kernel/trace/trace_events_hist.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)
---------------------------
commit 938aa33f14657c9ed9deea348b7d6f14b6d69cb7
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Sun Nov 14 13:28:34 2021 -0500

    tracing: Add length protection to histogram string copies
    
    The string copies to the histogram storage has a max size of 256 bytes
    (defined by MAX_FILTER_STR_VAL). Only the string size of the event field
    needs to be copied to the event storage, but no more than what is in the
    event storage. Although nothing should be bigger than 256 bytes, there's
    no protection against overwriting of the storage if one day there is.
    
    Copy no more than the destination size, and enforce it.
    
    Also had to turn MAX_FILTER_STR_VAL into an unsigned int, to keep the
    min() comparison of the string sizes of comparable types.
    
    Link: https://lore.kernel.org/all/CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com/
    Link: https://lkml.kernel.org/r/20211114132834.183429a4@rorschach.local.home
    
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Tom Zanussi <zanussi@kernel.org>
    Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
    Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
    Fixes: 63f84ae6b82b ("tracing/histogram: Do not copy the fixed-size char array field over the field size")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 50453b287615..2d167ac3452c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -673,7 +673,7 @@ struct trace_event_file {
 
 #define PERF_MAX_TRACE_SIZE	8192
 
-#define MAX_FILTER_STR_VAL	256	/* Should handle KSYM_SYMBOL_LEN */
+#define MAX_FILTER_STR_VAL	256U	/* Should handle KSYM_SYMBOL_LEN */
 
 enum event_trigger_type {
 	ETT_NONE		= (0),
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1475d7347fe0..34afcaebd0e5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3026,8 +3026,10 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 		if (val->flags & HIST_FIELD_FL_STRING) {
 			char *str = elt_data->field_var_str[j++];
 			char *val_str = (char *)(uintptr_t)var_val;
+			unsigned int size;
 
-			strscpy(str, val_str, val->size);
+			size = min(val->size, STR_VAR_LEN_MAX);
+			strscpy(str, val_str, size);
 			var_val = (u64)(uintptr_t)str;
 		}
 		tracing_map_set_var(elt, var_idx, var_val);
@@ -4914,6 +4916,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 			if (hist_field->flags & HIST_FIELD_FL_STRING) {
 				unsigned int str_start, var_str_idx, idx;
 				char *str, *val_str;
+				unsigned int size;
 
 				str_start = hist_data->n_field_var_str +
 					hist_data->n_save_var_str;
@@ -4922,7 +4925,9 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 				str = elt_data->field_var_str[idx];
 				val_str = (char *)(uintptr_t)hist_val;
-				strscpy(str, val_str, hist_field->size);
+
+				size = min(hist_field->size, STR_VAR_LEN_MAX);
+				strscpy(str, val_str, size);
 
 				hist_val = (u64)(uintptr_t)str;
 			}
