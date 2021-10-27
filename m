Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67F43CE61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbhJ0QMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhJ0QM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6597610A6;
        Wed, 27 Oct 2021 16:10:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV3-000xrl-Ue;
        Wed, 27 Oct 2021 12:10:01 -0400
Message-ID: <20211027161001.781380582@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [for-next][PATCH 11/15] tracing/histogram: Covert expr to const if both operands are
 constants
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

If both operands of a hist trigger expression are constants, convert the
expression to a constant. This optimization avoids having to perform the
same calculation multiple times and also saves on memory since the
merged constants are represented by a single struct hist_field instead
or multiple.

Link: https://lkml.kernel.org/r/20211025200852.3002369-6-kaleshsingh@google.com

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 104 ++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index bbaf2e16b7ae..71b453576d85 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2411,9 +2411,15 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	return ERR_PTR(ret);
 }
 
+/*
+ * If the operands are var refs, return pointers the
+ * variable(s) referenced in var1 and var2, else NULL.
+ */
 static int check_expr_operands(struct trace_array *tr,
 			       struct hist_field *operand1,
-			       struct hist_field *operand2)
+			       struct hist_field *operand2,
+			       struct hist_field **var1,
+			       struct hist_field **var2)
 {
 	unsigned long operand1_flags = operand1->flags;
 	unsigned long operand2_flags = operand2->flags;
@@ -2426,6 +2432,7 @@ static int check_expr_operands(struct trace_array *tr,
 		if (!var)
 			return -EINVAL;
 		operand1_flags = var->flags;
+		*var1 = var;
 	}
 
 	if ((operand2_flags & HIST_FIELD_FL_VAR_REF) ||
@@ -2436,6 +2443,7 @@ static int check_expr_operands(struct trace_array *tr,
 		if (!var)
 			return -EINVAL;
 		operand2_flags = var->flags;
+		*var2 = var;
 	}
 
 	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
@@ -2453,9 +2461,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 				     char *var_name, unsigned int *n_subexprs)
 {
 	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
-	unsigned long operand_flags;
+	struct hist_field *var1 = NULL, *var2 = NULL;
+	unsigned long operand_flags, operand2_flags;
 	int field_op, ret = -EINVAL;
 	char *sep, *operand1_str;
+	hist_field_fn_t op_fn;
+	bool combine_consts;
 
 	if (*n_subexprs > 3) {
 		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
@@ -2512,11 +2523,38 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	ret = check_expr_operands(file->tr, operand1, operand2);
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		op_fn = hist_field_minus;
+		break;
+	case FIELD_OP_PLUS:
+		op_fn = hist_field_plus;
+		break;
+	case FIELD_OP_DIV:
+		op_fn = hist_field_div;
+		break;
+	case FIELD_OP_MULT:
+		op_fn = hist_field_mult;
+		break;
+	default:
+		ret = -EINVAL;
+		goto free;
+	}
+
+	ret = check_expr_operands(file->tr, operand1, operand2, &var1, &var2);
 	if (ret)
 		goto free;
 
-	flags |= HIST_FIELD_FL_EXPR;
+	operand_flags = var1 ? var1->flags : operand1->flags;
+	operand2_flags = var2 ? var2->flags : operand2->flags;
+
+	/*
+	 * If both operands are constant, the expression can be
+	 * collapsed to a single constant.
+	 */
+	combine_consts = operand_flags & operand2_flags & HIST_FIELD_FL_CONST;
+
+	flags |= combine_consts ? HIST_FIELD_FL_CONST : HIST_FIELD_FL_EXPR;
 
 	flags |= operand1->flags &
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
@@ -2533,37 +2571,43 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operands[1] = operand2;
 
-	/* The operand sizes should be the same, so just pick one */
-	expr->size = operand1->size;
+	if (combine_consts) {
+		if (var1)
+			expr->operands[0] = var1;
+		if (var2)
+			expr->operands[1] = var2;
 
-	expr->operator = field_op;
-	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
-	if (!expr->type) {
-		ret = -ENOMEM;
-		goto free;
-	}
+		expr->constant = op_fn(expr, NULL, NULL, NULL, NULL);
 
-	switch (field_op) {
-	case FIELD_OP_MINUS:
-		expr->fn = hist_field_minus;
-		break;
-	case FIELD_OP_PLUS:
-		expr->fn = hist_field_plus;
-		break;
-	case FIELD_OP_DIV:
-		expr->fn = hist_field_div;
-		break;
-	case FIELD_OP_MULT:
-		expr->fn = hist_field_mult;
-		break;
-	default:
-		ret = -EINVAL;
-		goto free;
+		expr->operands[0] = NULL;
+		expr->operands[1] = NULL;
+
+		/*
+		 * var refs won't be destroyed immediately
+		 * See: destroy_hist_field()
+		 */
+		destroy_hist_field(operand2, 0);
+		destroy_hist_field(operand1, 0);
+
+		expr->name = expr_str(expr, 0);
+	} else {
+		expr->fn = op_fn;
+
+		/* The operand sizes should be the same, so just pick one */
+		expr->size = operand1->size;
+
+		expr->operator = field_op;
+		expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
+		if (!expr->type) {
+			ret = -ENOMEM;
+			goto free;
+		}
+
+		expr->name = expr_str(expr, 0);
 	}
 
 	return expr;
- free:
+free:
 	destroy_hist_field(operand1, 0);
 	destroy_hist_field(operand2, 0);
 	destroy_hist_field(expr, 0);
-- 
2.33.0
