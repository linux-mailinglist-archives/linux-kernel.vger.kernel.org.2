Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0E44F346
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhKMNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231589AbhKMNQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:16:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4132660551;
        Sat, 13 Nov 2021 13:14:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mlsr7-000Rn5-Py;
        Sat, 13 Nov 2021 08:14:05 -0500
Message-ID: <20211113131405.640431719@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 13 Nov 2021 08:13:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 2/3] tracing/histogram: Do not copy the fixed-size char array field over
 the field size
References: <20211113131340.640683117@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Do not copy the fixed-size char array field of the events over
the field size. The histogram treats char array as a string and
there are 2 types of char array in the event, fixed-size and
dynamic string. The dynamic string (__data_loc) field must be
null terminated, but the fixed-size char array field may not
be null terminated (not a string, but just a data).
In that case, histogram can copy the data after the field.
This uses the original field size for fixed-size char array
field to restrict the histogram not to access over the original
field size.

Link: https://lkml.kernel.org/r/163673292822.195747.3696966210526410250.stgit@devnote2

Fixes: 02205a6752f2 (tracing: Add support for 'field variables')
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8ff572a31fd3..6a9fa34e2785 100644
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
@@ -3025,7 +3026,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 			char *str = elt_data->field_var_str[j++];
 			char *val_str = (char *)(uintptr_t)var_val;
 
-			strscpy(str, val_str, STR_VAR_LEN_MAX);
+			strscpy(str, val_str, val->size);
 			var_val = (u64)(uintptr_t)str;
 		}
 		tracing_map_set_var(elt, var_idx, var_val);
@@ -4920,7 +4921,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 				str = elt_data->field_var_str[idx];
 				val_str = (char *)(uintptr_t)hist_val;
-				strscpy(str, val_str, STR_VAR_LEN_MAX);
+				strscpy(str, val_str, hist_field->size);
 
 				hist_val = (u64)(uintptr_t)str;
 			}
-- 
2.33.0
