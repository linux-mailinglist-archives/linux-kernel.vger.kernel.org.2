Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA2457615
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhKSRwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhKSRwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:52:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B82611CB;
        Fri, 19 Nov 2021 17:49:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mo80T-001NIn-NX;
        Fri, 19 Nov 2021 12:49:01 -0500
Message-ID: <20211119174901.559106307@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Nov 2021 12:47:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [for-linus][PATCH 1/3] tracing/histogram: Fix UAF in destroy_hist_field()
References: <20211119174730.441176580@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

Calling destroy_hist_field() on an expression will recursively free
any operands associated with the expression. If during expression
parsing the operands of the expression are already set when an error
is encountered, there is no need to explicity free the operands. Doing
so will result in destroy_hist_field() being called twice for the
operands and lead to a use-after-free (UAF) error.

If the operands are associated with the expression, only call
destroy_hist_field() on the expression since the operands will be
recursively freed.

Link: https://lore.kernel.org/all/CAHk-=wgcrEbFgkw9720H3tW-AhHOoEKhYwZinYJw4FpzSaJ6_Q@mail.gmail.com/
Link: https://lkml.kernel.org/r/20211118011542.1420131-1-kaleshsingh@google.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 8b5d46fd7a38 ("tracing/histogram: Optimize division by constants")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 41 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 19 deletions(-)

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
 
-- 
2.33.0
