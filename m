Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F73D24D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhGVNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhGVNGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:06:10 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D731F6135A;
        Thu, 22 Jul 2021 13:46:44 +0000 (UTC)
Date:   Thu, 22 Jul 2021 09:46:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] tracing: Allow execnames to be passed as args for
 synthetic events
Message-ID: <20210722094638.0f7caef2@oasis.local.home>
In-Reply-To: <20210722222924.c4ff024b507c69c08f8575a3@kernel.org>
References: <20210721214702.4eeb1cd9@oasis.local.home>
        <20210722222924.c4ff024b507c69c08f8575a3@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 22:29:24 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> This looks an interesting improvement. If we can do this, can we also filter
> the event by 'comm' (or execname)? 

We would be able to filter on the synthetic event, just like any other
event with a comm (or other string) But I don't think we can filter
before (that is, in the histogram code).

> 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> > Changes since v1:
> >   - Hit a bug on freeing the histogram, found that I used "char[]" for the
> >     type, and it expects to be freed. Freed the old "type" and still use
> >     "char[]" but have the normal freeing use kfree_const() on type.  
> 
> 
> BTW, if we can use this technic on the hist_field->type, we can cleanup 
> other type = strdup("<any const type>", GFP_KERNEL) with type = "<any const type>" ?
> 
> Anyway, that will be done in another patch (I think that should be done first,
> then we can avoid an odd kfree() in update_var_execname().)

You mean like this? It was done after the patch, but I can move it first.

-- Steve

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index bb1956efd5ef..6b9e4fb70bc1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1590,7 +1590,7 @@ static void __destroy_hist_field(struct hist_field *hist_field)
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
 
-	/* execname vars use a constant type */
+	/* Can likely be a const */
 	kfree_const(hist_field->type);
 
 	kfree(hist_field->system);
@@ -1648,9 +1648,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
 		hist_field->size = sizeof(u64);
-		hist_field->type = kstrdup("u64", GFP_KERNEL);
-		if (!hist_field->type)
-			goto free;
+		hist_field->type = "u64";
 		goto out;
 	}
 
@@ -1664,7 +1662,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		hist_field->fn = hist_field_log2;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
-		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(hist_field->operands[0]->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 		goto out;
@@ -1673,18 +1671,14 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
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
 
@@ -1697,7 +1691,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		flags |= HIST_FIELD_FL_STRING;
 
 		hist_field->size = MAX_FILTER_STR_VAL;
-		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 
@@ -1710,7 +1704,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	} else {
 		hist_field->size = field->size;
 		hist_field->is_signed = field->is_signed;
-		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 
@@ -1796,7 +1790,7 @@ static int init_var_ref(struct hist_field *ref_field,
 		}
 	}
 
-	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
+	ref_field->type = kstrdup_const(var_field->type, GFP_KERNEL);
 	if (!ref_field->type) {
 		err = -ENOMEM;
 		goto free;
@@ -2165,7 +2159,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
 		goto free;
@@ -2291,7 +2285,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr->operands[1] = operand2;
 	expr->operator = field_op;
 	expr->name = expr_str(expr, 0);
-	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
 		goto free;
@@ -2679,10 +2673,10 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 	var->var.hist_data = var->hist_data = hist_data;
 	var->size = size;
 	var->var.name = kstrdup(name, GFP_KERNEL);
-	var->type = kstrdup(type, GFP_KERNEL);
+	var->type = kstrdup_const(type, GFP_KERNEL);
 	if (!var->var.name || !var->type) {
 		kfree(var->var.name);
-		kfree(var->type);
+		kfree_const(var->type);
 		kfree(var);
 		var = ERR_PTR(-ENOMEM);
 	}
