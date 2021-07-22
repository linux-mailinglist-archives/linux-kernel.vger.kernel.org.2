Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C383D25B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGVNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhGVNsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:48:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA1D61278;
        Thu, 22 Jul 2021 14:28:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m6Zgj-001bBg-E5; Thu, 22 Jul 2021 10:28:37 -0400
Message-ID: <20210722142837.280718447@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jul 2021 10:27:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 1/2] tracing: Have histogram types be constant when possible
References: <20210722142705.992001628@goodmis.org>
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

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 34325f41ebc0..5c9082201bc2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1589,7 +1589,9 @@ static void __destroy_hist_field(struct hist_field *hist_field)
 
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
-	kfree(hist_field->type);
+
+	/* Can likely be a const */
+	kfree_const(hist_field->type);
 
 	kfree(hist_field->system);
 	kfree(hist_field->event_name);
@@ -1646,9 +1648,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		hist_field->size = sizeof(u64);
-		hist_field->type = kstrdup("u64", GFP_KERNEL);
-		if (!hist_field->type)
-			goto free;
+		hist_field->type = "u64";
 		goto out;
 	}
 
@@ -1662,7 +1662,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		hist_field->fn = hist_field_log2;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
-		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(hist_field->operands[0]->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 		goto out;
@@ -1671,18 +1671,14 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
 
@@ -1695,7 +1691,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		flags |= HIST_FIELD_FL_STRING;
 
 		hist_field->size = MAX_FILTER_STR_VAL;
-		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 
@@ -1708,7 +1704,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	} else {
 		hist_field->size = field->size;
 		hist_field->is_signed = field->is_signed;
-		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 
@@ -1794,7 +1790,7 @@ static int init_var_ref(struct hist_field *ref_field,
 		}
 	}
 
-	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
+	ref_field->type = kstrdup_const(var_field->type, GFP_KERNEL);
 	if (!ref_field->type) {
 		err = -ENOMEM;
 		goto free;
@@ -2163,7 +2159,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
 		goto free;
@@ -2289,7 +2285,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr->operands[1] = operand2;
 	expr->operator = field_op;
 	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
 		goto free;
@@ -2677,10 +2673,10 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
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
