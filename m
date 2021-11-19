Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F3457807
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhKSVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 16:15:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234002AbhKSVPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 16:15:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB6961AFB;
        Fri, 19 Nov 2021 21:12:29 +0000 (UTC)
Date:   Fri, 19 Nov 2021 16:12:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Subject: [GIT PULL] tracing: Histogram fix take two and two more fixes
Message-ID: <20211119161228.18322a90@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Tracing fixes:

 - Fix double free in destroy_hist_field

 - Harden memset() of trace_iterator structure

 - Do not warn in trace printk check when test buffer fills up


Please pull the latest trace-v5.16-6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-6

Tag SHA1: 61ba32adb5e7d2d6534234bd22bd43a259419187
Head SHA1: 2ef75e9bd2c998f1c6f6f23a3744136105ddefd5


Kalesh Singh (1):
      tracing/histogram: Fix UAF in destroy_hist_field()

Kees Cook (1):
      tracing: Use memset_startat() to zero struct trace_iterator

Nikita Yushchenko (1):
      tracing: Don't use out-of-sync va_list in event printing

----
 kernel/trace/trace.c             | 16 +++++++++++++---
 kernel/trace/trace_events_hist.c | 41 +++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 22 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9139dc1262c..88de94da596b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3812,6 +3812,18 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		iter->fmt[i] = '\0';
 		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
 
+		/*
+		 * If iter->seq is full, the above call no longer guarantees
+		 * that ap is in sync with fmt processing, and further calls
+		 * to va_arg() can return wrong positional arguments.
+		 *
+		 * Ensure that ap is no longer used in this case.
+		 */
+		if (iter->seq.full) {
+			p = "";
+			break;
+		}
+
 		if (star)
 			len = va_arg(ap, int);
 
@@ -6706,9 +6718,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		cnt = PAGE_SIZE - 1;
 
 	/* reset all but tr, trace, and overruns */
-	memset(&iter->seq, 0,
-	       sizeof(struct trace_iterator) -
-	       offsetof(struct trace_iterator, seq));
+	memset_startat(iter, 0, seq);
 	cpumask_clear(iter->started);
 	trace_seq_init(&iter->seq);
 	iter->pos = -1;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ea2c9ec54a6..9555b8e1d1e3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2576,28 +2576,27 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	/* Split the expression string at the root operator */
 	if (!sep)
-		goto free;
+		return ERR_PTR(-EINVAL);
+
 	*sep = '\0';
 	operand1_str = str;
 	str = sep+1;
 
 	/* Binary operator requires both operands */
 	if (*operand1_str == '\0' || *str == '\0')
-		goto free;
+		return ERR_PTR(-EINVAL);
 
 	operand_flags = 0;
 
 	/* LHS of string is an expression e.g. a+b in a+b+c */
 	operand1 = parse_expr(hist_data, file, operand1_str, operand_flags, NULL, n_subexprs);
-	if (IS_ERR(operand1)) {
-		ret = PTR_ERR(operand1);
-		operand1 = NULL;
-		goto free;
-	}
+	if (IS_ERR(operand1))
+		return ERR_CAST(operand1);
+
 	if (operand1->flags & HIST_FIELD_FL_STRING) {
 		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(operand1_str));
 		ret = -EINVAL;
-		goto free;
+		goto free_op1;
 	}
 
 	/* RHS of string is another expression e.g. c in a+b+c */
@@ -2605,13 +2604,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL, n_subexprs);
 	if (IS_ERR(operand2)) {
 		ret = PTR_ERR(operand2);
-		operand2 = NULL;
-		goto free;
+		goto free_op1;
 	}
 	if (operand2->flags & HIST_FIELD_FL_STRING) {
 		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(str));
 		ret = -EINVAL;
-		goto free;
+		goto free_operands;
 	}
 
 	switch (field_op) {
@@ -2629,12 +2627,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		break;
 	default:
 		ret = -EINVAL;
-		goto free;
+		goto free_operands;
 	}
 
 	ret = check_expr_operands(file->tr, operand1, operand2, &var1, &var2);
 	if (ret)
-		goto free;
+		goto free_operands;
 
 	operand_flags = var1 ? var1->flags : operand1->flags;
 	operand2_flags = var2 ? var2->flags : operand2->flags;
@@ -2653,12 +2651,13 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr = create_hist_field(hist_data, NULL, flags, var_name);
 	if (!expr) {
 		ret = -ENOMEM;
-		goto free;
+		goto free_operands;
 	}
 
 	operand1->read_once = true;
 	operand2->read_once = true;
 
+	/* The operands are now owned and free'd by 'expr' */
 	expr->operands[0] = operand1;
 	expr->operands[1] = operand2;
 
@@ -2669,7 +2668,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		if (!divisor) {
 			hist_err(file->tr, HIST_ERR_DIVISION_BY_ZERO, errpos(str));
 			ret = -EDOM;
-			goto free;
+			goto free_expr;
 		}
 
 		/*
@@ -2709,18 +2708,22 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 		if (!expr->type) {
 			ret = -ENOMEM;
-			goto free;
+			goto free_expr;
 		}
 
 		expr->name = expr_str(expr, 0);
 	}
 
 	return expr;
-free:
-	destroy_hist_field(operand1, 0);
+
+free_operands:
 	destroy_hist_field(operand2, 0);
-	destroy_hist_field(expr, 0);
+free_op1:
+	destroy_hist_field(operand1, 0);
+	return ERR_PTR(ret);
 
+free_expr:
+	destroy_hist_field(expr, 0);
 	return ERR_PTR(ret);
 }
 
