Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB144F35C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhKMNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhKMNiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:38:15 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4659861051;
        Sat, 13 Nov 2021 13:35:22 +0000 (UTC)
Date:   Sat, 13 Nov 2021 08:35:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Three small fixes for 5.16
Message-ID: <20211113083520.26ec84ee@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Three tracing fixes:

 - Make local osnoise_instances static

 - Copy just actual size of histogram strings

 - Properly check missing operands in histogram expressions


Please pull the latest trace-v5.16-4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-4

Tag SHA1: 1e06c15eb016180a996fd2bd3838fa1ca9ea21d6
Head SHA1: 1cab6bce42e62bba2ff2c2370d139618c1828b42


Daniel Bristot de Oliveira (1):
      tracing/osnoise: Make osnoise_instances static

Kalesh Singh (1):
      tracing/histogram: Fix check for missing operands in an expression

Masami Hiramatsu (1):
      tracing/histogram: Do not copy the fixed-size char array field over the field size

----
 kernel/trace/trace_events_hist.c | 12 +++++++-----
 kernel/trace/trace_osnoise.c     |  3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)
---------------------------
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8ff572a31fd3..1475d7347fe0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1953,9 +1953,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		if (!hist_field->type)
 			goto free;
 
-		if (field->filter_type == FILTER_STATIC_STRING)
+		if (field->filter_type == FILTER_STATIC_STRING) {
 			hist_field->fn = hist_field_string;
-		else if (field->filter_type == FILTER_DYN_STRING)
+			hist_field->size = field->size;
+		} else if (field->filter_type == FILTER_DYN_STRING)
 			hist_field->fn = hist_field_dynstring;
 		else
 			hist_field->fn = hist_field_pstring;
@@ -2580,7 +2581,8 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	operand1_str = str;
 	str = sep+1;
 
-	if (!operand1_str || !str)
+	/* Binary operator requires both operands */
+	if (*operand1_str == '\0' || *str == '\0')
 		goto free;
 
 	operand_flags = 0;
@@ -3025,7 +3027,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 			char *str = elt_data->field_var_str[j++];
 			char *val_str = (char *)(uintptr_t)var_val;
 
-			strscpy(str, val_str, STR_VAR_LEN_MAX);
+			strscpy(str, val_str, val->size);
 			var_val = (u64)(uintptr_t)str;
 		}
 		tracing_map_set_var(elt, var_idx, var_val);
@@ -4920,7 +4922,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 				str = elt_data->field_var_str[idx];
 				val_str = (char *)(uintptr_t)hist_val;
-				strscpy(str, val_str, STR_VAR_LEN_MAX);
+				strscpy(str, val_str, hist_field->size);
 
 				hist_val = (u64)(uintptr_t)str;
 			}
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 3e4a1651e329..7520d43aed55 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -55,7 +55,8 @@ struct osnoise_instance {
 	struct list_head	list;
 	struct trace_array	*tr;
 };
-struct list_head osnoise_instances;
+
+static struct list_head osnoise_instances;
 
 static bool osnoise_has_registered_instances(void)
 {
