Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5274D3EF2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhHQTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232923AbhHQTnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8C161053;
        Tue, 17 Aug 2021 19:43:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zH-004TNI-FB; Tue, 17 Aug 2021 15:43:03 -0400
Message-ID: <20210817194303.305479503@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 04/19] tracing: Have histogram types be constant when possible
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of kstrdup("const", GFP_KERNEL), have the hist_field type simply
assign the constant hist_field->type = "const"; And when the value passed
to it is a variable, use "kstrdup_const(var, GFP_KERNEL);" which will just
copy the value if the variable is already a constant. This saves on having
to allocate when not needed.

All frees of the hist_field->type will need to use kfree_const().

Link: https://lkml.kernel.org/r/20210722142837.280718447@goodmis.org

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8e87c4a429fd..bb466a82b938 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1616,7 +1616,9 @@ static void __destroy_hist_field(struct hist_field *hist_field)
 
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
-	kfree(hist_field->type);
+
+	/* Can likely be a const */
+	kfree_const(hist_field->type);
 
 	kfree(hist_field->system);
 	kfree(hist_field->event_name);
@@ -1673,9 +1675,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		hist_field->size = sizeof(u64);
-		hist_field->type = kstrdup("u64", GFP_KERNEL);
-		if (!hist_field->type)
-			goto free;
+		hist_field->type = "u64";
 		goto out;
 	}
 
@@ -1690,7 +1690,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 			hist_field_bucket;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
-		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(hist_field->operands[0]->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 		goto out;
@@ -1699,18 +1699,14 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (flags & HIST_FIELD_FL_TIMESTAMP) {
 		hist_field->fn = hist_field_timestamp;
 		hist_field->size = sizeof(u64);
-		hist_field->type = kstrdup("u64", GFP_KERNEL);
-		if (!hist_field->type)
-			goto free;
+		hist_field->type = "u64";
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_CPU) {
 		hist_field->fn = hist_field_cpu;
 		hist_field->size = sizeof(int);
-		hist_field->type = kstrdup("unsigned int", GFP_KERNEL);
-		if (!hist_field->type)
-			goto free;
+		hist_field->type = "unsigned int";
 		goto out;
 	}
 
@@ -1723,7 +1719,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		flags |= HIST_FIELD_FL_STRING;
 
 		hist_field->size = MAX_FILTER_STR_VAL;
-		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 
@@ -1736,7 +1732,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	} else {
 		hist_field->size = field->size;
 		hist_field->is_signed = field->is_signed;
-		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 
@@ -1822,7 +1818,7 @@ static int init_var_ref(struct hist_field *ref_field,
 		}
 	}
 
-	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
+	ref_field->type = kstrdup_const(var_field->type, GFP_KERNEL);
 	if (!ref_field->type) {
 		err = -ENOMEM;
 		goto free;
@@ -2215,7 +2211,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
 		goto free;
@@ -2355,7 +2351,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	expr->operator = field_op;
 	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
 		goto free;
@@ -2743,10 +2739,10 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 	var->var.hist_data = var->hist_data = hist_data;
 	var->size = size;
 	var->var.name = kstrdup(name, GFP_KERNEL);
-	var->type = kstrdup(type, GFP_KERNEL);
+	var->type = kstrdup_const(type, GFP_KERNEL);
 	if (!var->var.name || !var->type) {
+		kfree_const(var->type);
 		kfree(var->var.name);
-		kfree(var->type);
 		kfree(var);
 		var = ERR_PTR(-ENOMEM);
 	}
-- 
2.30.2
