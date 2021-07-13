Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF5F3C7884
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhGMVOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 17:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMVOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 17:14:40 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD73460FE9;
        Tue, 13 Jul 2021 21:11:49 +0000 (UTC)
Date:   Tue, 13 Jul 2021 17:11:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] tracing: Add __string_len() and __assign_str_len()
 helpers
Message-ID: <20210713171143.7784697e@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Add macros for the TRACE_EVENT() macro that can be used to assign strings
that either need to be truncated, or have no nul terminator, and depends
on a length attribute to assign.

Note: A while ago Chuck Lever asked for these changes, and I sent him this
patch to see if it would work for him, and he said it would. But because
I never made a commit for it, I forgot about it. Although this is not
an actual fix, it also has no functional changes. It introduces two
macro helpers to the TRACE_EVENT() macros, and that is all it does.
These can then be used by Chuck for work that will go into the next
merge window.

It would be easier if it were upstream instead of him carrying the change,
and likely conflict with work I am working on as this touches the core
file that creates the TRACE_EVENT macro. The other approach is that I make
a specific branch that he can then base off of in his tree, and we both have
that as our base branch. But still, that complicates things. Third approach is
that he takes this patch into his tree, and I take the same patch into mine
and just work on top of it even though they have separate sha1s.

If you do not want to pull this because this is not technically a fix, we
will then just go with one of the above approaches. I'll let it be your call.

Please pull the latest trace-v5.14-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.14-3

Tag SHA1: 7217c1cf4cd4c5f22e7b3bd641a594bbe7b7c8e1
Head SHA1: ac58f4f28369ce3287982da131ad3c6fb283d4e6


Steven Rostedt (VMware) (1):
      tracing: Add trace_event helper macros __string_len() and __assign_str_len()

----
 include/trace/trace_events.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
---------------------------
commit ac58f4f28369ce3287982da131ad3c6fb283d4e6
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu May 13 10:50:18 2021 -0400

    tracing: Add trace_event helper macros __string_len() and __assign_str_len()
    
    There's a few cases that a string that is to be recorded in a trace event,
    does not have a terminating 'nul' character, and instead, the tracepoint
    passes in the length of the string to record.
    
    Add two helper macros to the trace event code that lets this work easier,
    than tricks with "%.*s" logic.
    
      __string_len() which is similar to __string() for declaration, but takes a
                     length argument.
    
      __assign_str_len() which is similar to __assign_str() for assiging the
                     string, but it too takes a length argument.
    
    This string can still use __get_str() just like strings created with
    __string() can use to retrieve the string.
    
    Link: https://lore.kernel.org/linux-nfs/20210513105018.7539996a@gandalf.local.home/
    
    Tested-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index acc17194c160..a0fa8a3a691c 100644
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
@@ -670,10 +682,18 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __assign_str
 #define __assign_str(dst, src)						\
 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
 
+#undef __assign_str_len
+#define __assign_str_len(dst, src, len)						\
+	strncpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len);	\
+	__get_str(dst)[len] = '\0';
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
