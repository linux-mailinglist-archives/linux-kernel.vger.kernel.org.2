Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73743CE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhJ0QMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242943AbhJ0QM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C22D610C8;
        Wed, 27 Oct 2021 16:10:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV3-000xq4-CD;
        Wed, 27 Oct 2021 12:10:01 -0400
Message-ID: <20211027161001.212318441@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [for-next][PATCH 08/15] tracing: Add division and multiplication support for hist triggers
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

Adds basic support for division and multiplication operations for
hist trigger variable expressions.

For simplicity this patch only supports, division and multiplication
for a single operation expression (e.g. x=$a/$b), as currently
expressions are always evaluated right to left. This can lead to some
incorrect results:

	e.g. echo 'hist:keys=common_pid:x=8-4-2' >> event/trigger

	     8-4-2 should evaluate to 2 i.e. (8-4)-2
	     but currently x evaluate to  6 i.e. 8-(4-2)

Multiplication and division in sub-expressions will work correctly, once
correct operator precedence support is added (See next patch in this
series).

For the undefined case of division by 0, the histogram expression
evaluates to (u64)(-1). Since this cannot be detected when the
expression is created, it is the responsibility of the user to be
aware and account for this possibility.

Examples:
	echo 'hist:keys=common_pid:a=8,b=4,x=$a/$b' \
                   >> event/trigger

	echo 'hist:keys=common_pid:y=5*$b' \
                   >> event/trigger

Link: https://lkml.kernel.org/r/20211025200852.3002369-3-kaleshsingh@google.com

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 72 +++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e6165e36d3b6..1edec5d471c1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -97,6 +97,8 @@ enum field_op_id {
 	FIELD_OP_PLUS,
 	FIELD_OP_MINUS,
 	FIELD_OP_UNARY_MINUS,
+	FIELD_OP_DIV,
+	FIELD_OP_MULT,
 };
 
 /*
@@ -285,6 +287,40 @@ static u64 hist_field_minus(struct hist_field *hist_field,
 	return val1 - val2;
 }
 
+static u64 hist_field_div(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
+			   struct ring_buffer_event *rbe,
+			   void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+
+	/* Return -1 for the undefined case */
+	if (!val2)
+		return -1;
+
+	return div64_u64(val1, val2);
+}
+
+static u64 hist_field_mult(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct trace_buffer *buffer,
+			   struct ring_buffer_event *rbe,
+			   void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+
+	return val1 * val2;
+}
+
 static u64 hist_field_unary_minus(struct hist_field *hist_field,
 				  struct tracing_map_elt *elt,
 				  struct trace_buffer *buffer,
@@ -1592,6 +1628,12 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	case FIELD_OP_PLUS:
 		strcat(expr, "+");
 		break;
+	case FIELD_OP_DIV:
+		strcat(expr, "/");
+		break;
+	case FIELD_OP_MULT:
+		strcat(expr, "*");
+		break;
 	default:
 		kfree(expr);
 		return NULL;
@@ -1607,7 +1649,7 @@ static int contains_operator(char *str)
 	enum field_op_id field_op = FIELD_OP_NONE;
 	char *op;
 
-	op = strpbrk(str, "+-");
+	op = strpbrk(str, "+-/*");
 	if (!op)
 		return FIELD_OP_NONE;
 
@@ -1628,6 +1670,12 @@ static int contains_operator(char *str)
 	case '+':
 		field_op = FIELD_OP_PLUS;
 		break;
+	case '/':
+		field_op = FIELD_OP_DIV;
+		break;
+	case '*':
+		field_op = FIELD_OP_MULT;
+		break;
 	default:
 		break;
 	}
@@ -2361,10 +2409,26 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	case FIELD_OP_PLUS:
 		sep = "+";
 		break;
+	case FIELD_OP_DIV:
+		sep = "/";
+		break;
+	case FIELD_OP_MULT:
+		sep = "*";
+		break;
 	default:
 		goto free;
 	}
 
+	/*
+	 * Multiplication and division are only supported in single operator
+	 * expressions, since the expression is always evaluated from right
+	 * to left.
+	 */
+	if ((field_op == FIELD_OP_DIV || field_op == FIELD_OP_MULT) && level > 0) {
+		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
+		return ERR_PTR(-EINVAL);
+	}
+
 	operand1_str = strsep(&str, sep);
 	if (!operand1_str || !str)
 		goto free;
@@ -2436,6 +2500,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	case FIELD_OP_PLUS:
 		expr->fn = hist_field_plus;
 		break;
+	case FIELD_OP_DIV:
+		expr->fn = hist_field_div;
+		break;
+	case FIELD_OP_MULT:
+		expr->fn = hist_field_mult;
+		break;
 	default:
 		ret = -EINVAL;
 		goto free;
-- 
2.33.0
