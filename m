Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA83CB09A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhGPCAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhGPCAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:00:49 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F216613DA;
        Fri, 16 Jul 2021 01:57:55 +0000 (UTC)
Date:   Thu, 15 Jul 2021 21:57:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] tracing: histogram fix and take 2 on the __string_len()
 marcros
Message-ID: <20210715215753.4a314e97@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing: One fix in the histogram code and another take at the __string_len() macro

Working on the histogram code, I found that if you dereference a char
pointer in a trace event that happens to point to user space, it can crash
the kernel, as it does no checks of that pointer. I have code coming that
will do this better, so just remove this ability to treat character
pointers in trace events as stings.

Add macros for the TRACE_EVENT() macro that can be used to assign strings
that either need to be truncated, or have no nul terminator, and depends
on a length attribute to assign.

Note, this is take 2 of the git pull I sent last time, but this also
includes an actual bug fix in the histogram code. I rebased it, where
the histogram fix is first in case you still have issues with the
__string_len() macro change.

I hope my reply satisfied your issues you had with that patch:

  https://lore.kernel.org/lkml/20210714175633.3b53346a@oasis.local.home/

I agreed with you that the __assign_str_len() macro should have a 
do { } while (0) around it, which I updated and tested.

If you still have an issue with this, you can either just pull the
one fix, or I can send you a new tag for just that fix.

Let me know what you would like me to do.

Thanks!

-- Steve

Please pull the latest trace-v5.14-4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.14-4

Tag SHA1: 04a6869693232b86b6640d2db3c25968336a9670
Head SHA1: 85f666175d522f9f1c089f04ed9af5aa4ec84202


Steven Rostedt (VMware) (2):
      tracing: Do not reference char * as a string in histograms
      tracing: Add trace_event helper macros __string_len() and __assign_str_len()

----
 include/trace/trace_events.h     | 22 ++++++++++++++++++++++
 kernel/trace/trace_events_hist.c |  6 +++---
 2 files changed, 25 insertions(+), 3 deletions(-)
---------------------------
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index acc17194c160..2ebacf03fba4 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -102,6 +102,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
@@ -197,6 +200,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -459,6 +465,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -507,6 +516,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __string(item, src) __dynamic_array(char, item,			\
 		    strlen((src) ? (const char *)(src) : "(null)") + 1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
+
 /*
  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
  * num_possible_cpus().
@@ -670,10 +682,20 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __assign_str
 #define __assign_str(dst, src)						\
 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
 
+#undef __assign_str_len
+#define __assign_str_len(dst, src, len)					\
+	do {								\
+		strncpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len); \
+		__get_str(dst)[len] = '\0';				\
+	} while(0)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0207aeed31e6..16a9dfc9fffc 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1689,7 +1689,9 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (WARN_ON_ONCE(!field))
 		goto out;
 
-	if (is_string_field(field)) {
+	/* Pointers to strings are just pointers and dangerous to dereference */
+	if (is_string_field(field) &&
+	    (field->filter_type != FILTER_PTR_STRING)) {
 		flags |= HIST_FIELD_FL_STRING;
 
 		hist_field->size = MAX_FILTER_STR_VAL;
@@ -4495,8 +4497,6 @@ static inline void add_to_key(char *compound_key, void *key,
 		field = key_field->field;
 		if (field->filter_type == FILTER_DYN_STRING)
 			size = *(u32 *)(rec + field->offset) >> 16;
-		else if (field->filter_type == FILTER_PTR_STRING)
-			size = strlen(key);
 		else if (field->filter_type == FILTER_STATIC_STRING)
 			size = field->size;
 
