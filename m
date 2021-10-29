Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4025F43F75B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJ2GlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:41:22 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:32967 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232078AbhJ2GlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:41:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uu6JQh3_1635489529;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Uu6JQh3_1635489529)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 14:38:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/2] ftrace: Tidy up some false kernel-doc markings
Date:   Fri, 29 Oct 2021 14:38:42 +0800
Message-Id: <1635489523-76132-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deals with
W=1 warning: This comment starts with '/**', but isn't a kernel-doc
comment.
W=1 warning: bad line.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/ftrace.c            | 18 +++++++++---------
 kernel/trace/trace_events_hist.c |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index feb1ea9..679db91 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2203,7 +2203,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 	return FTRACE_UPDATE_MAKE_NOP;
 }
 
-/**
+/*
  * ftrace_update_record, set a record that now is tracing or not
  * @rec: the record to update
  * @enable: set to true if the record is tracing, false to force disable
@@ -2216,7 +2216,7 @@ int ftrace_update_record(struct dyn_ftrace *rec, bool enable)
 	return ftrace_check_record(rec, enable, true);
 }
 
-/**
+/*
  * ftrace_test_record, check if the record has been enabled or not
  * @rec: the record to test
  * @enable: set to true to check if enabled, false if it is disabled
@@ -2602,7 +2602,7 @@ struct ftrace_rec_iter {
 	int			index;
 };
 
-/**
+/*
  * ftrace_rec_iter_start, start up iterating over traced functions
  *
  * Returns an iterator handle that is used to iterate over all
@@ -2633,7 +2633,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_start(void)
 	return iter;
 }
 
-/**
+/*
  * ftrace_rec_iter_next, get the next record to process.
  * @iter: The handle to the iterator.
  *
@@ -2658,7 +2658,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_next(struct ftrace_rec_iter *iter)
 	return iter;
 }
 
-/**
+/*
  * ftrace_rec_iter_record, get the record at the iterator location
  * @iter: The current iterator location
  *
@@ -2761,7 +2761,7 @@ static int __ftrace_modify_code(void *data)
 	return 0;
 }
 
-/**
+/*
  * ftrace_run_stop_machine, go back to the stop machine method
  * @command: The command to tell ftrace what to do
  *
@@ -2773,7 +2773,7 @@ void ftrace_run_stop_machine(int command)
 	stop_machine(__ftrace_modify_code, &command, NULL);
 }
 
-/**
+/*
  * arch_ftrace_update_code, modify the code to trace or not trace
  * @command: The command that needs to be done
  *
@@ -7742,7 +7742,7 @@ void ftrace_kill(void)
 	ftrace_trace_function = ftrace_stub;
 }
 
-/**
+/*
  * Test if ftrace is dead or not.
  */
 int ftrace_is_dead(void)
@@ -7750,7 +7750,7 @@ int ftrace_is_dead(void)
 	return ftrace_disabled;
 }
 
-/**
+/*
  * register_ftrace_function - register a function for profiling
  * @ops - ops structure that holds the function for profiling.
  *
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index cddf6bf..aa93e87 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -836,7 +836,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
  * A trigger can define one or more variables.  If any one of them is
  * currently referenced by any other trigger, this function will
  * determine that.
-
+ *
  * Typically used to determine whether or not a trigger can be removed
  * - if there are any references to a trigger's variables, it cannot.
  *
@@ -3050,7 +3050,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
  * events.  However, for convenience, users are allowed to directly
  * specify an event field in an action, which will be automatically
  * converted into a variable on their behalf.
-
+ *
  * This function creates a field variable with the name var_name on
  * the hist trigger currently being defined on the target event.  If
  * subsys_name and event_name are specified, this function simply
-- 
1.8.3.1

