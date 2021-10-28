Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD80043D9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 05:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJ1Db1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 23:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhJ1Db0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 23:31:26 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4F2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 20:28:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r7-20020a63ce47000000b002a5cadd2f25so1141374pgi.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 20:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=xxFnKn+d5prwnX+bYk4sBVYpX2zz7LyQFTKYTEX+2F8=;
        b=OBzFFE2FhmUICpJtFyyndcJFSSoSMVaFyii3C91x+qglfIOqHkGqnlcLNrBJOhcH2b
         xhVKgAy+SUouIQ0X3m7e4eHvS0uBT1CiqojPez1Gd5xkfCNW7U/2KR8DtG7c4XelnhAq
         QPzgQijqp6ak9xcBcypdxjibQPszD9NuJQXVUboQlgZWigvdue79zK+ENaDWAGmT7HlD
         UVFyo/nkD0tjgCPoFvWHpzbQa8HyB42k4Ey6cYu9xc8J2QbtK+veJ3C4kO7gD6oZNqT4
         g/GEQ5lnQjXdnOJKChf2M0qkB6cQmqx3iucmILoANP19uP3vDOHTRwtwffcfaM2cgqpP
         i8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=xxFnKn+d5prwnX+bYk4sBVYpX2zz7LyQFTKYTEX+2F8=;
        b=MXwWPtDKWJlCbxewaysRe94j2c7iynUq1mGiDd6zRyGVMD5KLBqDg1eSpYfL/K+s4m
         10R/Y2lq8WsindYbHDKuX0mdoXs356MmLNS0jKGz4deWCKt3CMpaz1xU4Yfa8yJj11QE
         P5dClwqKfV0f5qhX9kCsDLhMDIs5ZO8UymI0kbJ1zZdsskfOEQUZgA8VkVHR9veJZR2L
         RFttgolaB2+JYCQAcPjxBRooYXS13DVQpODcszMTI5SHwsqXS7D817yZKZsMYMgXXf/N
         vcZeF8XLblm2AiPIjCzfD2Fqh3d7nPQ2UVESHV52xaAuLhU+E2OfZMw343qQLsHsWKOW
         NW+w==
X-Gm-Message-State: AOAM532T06NfxDPZK8P+TXCfzrNriF7Fnj+GDarXyOGe0Kk7bKct1Kmu
        ultqJuPTBlxQFzs39kK6I1wQAtHuum+9Vp0wgg==
X-Google-Smtp-Source: ABdhPJzxP5Jy5gRZ2lDNe3byjv0jwX+cd751lrorAYxSkW2Tyg+sdcB8pUO4piDq3W0jryGJoAUmKtfkif1kJIgoKw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ac51:b6be:9b51:3a7c])
 (user=kaleshsingh job=sendgmr) by 2002:a17:90b:17c9:: with SMTP id
 me9mr1739062pjb.197.1635391739275; Wed, 27 Oct 2021 20:28:59 -0700 (PDT)
Date:   Wed, 27 Oct 2021 20:28:54 -0700
Message-Id: <20211028032854.2458440-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] tracing/histogram: Optimize division by constants
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        zanussi@kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the divisor is a constant use specific division functions to
avoid extra branches when the trigger is hit.

If the divisor constant but not a power of 2, the division can be
replaced with a multiplication and shift in the following case:

Let X = dividend and Y = divisor.

Choose Z = some power of 2. If Y <= Z, then:
    X / Y = (X * (Z / Y)) / Z

(Z / Y) is a constant (mult) which is calculated at parse time, so:
    X / Y = (X * mult) / Z

The division by Z can be replaced by a shift since Z is a power of 2:
    X / Y = (X * mult) >> shift

As long, as X < Z the results will not be off by more than 1.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---

This patch is dependent on the series at:
https://lore.kernel.org/r/20211025200852.3002369-1-kaleshsingh@google.com/

 kernel/trace/trace_events_hist.c | 120 ++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 364cb3091789..c806df88ddb5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -92,6 +92,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
 #define HIST_ACTIONS_MAX	8
 #define HIST_CONST_DIGITS_MAX	21
+#define HIST_DIV_SHIFT		20  /* For optimizing division by constants */
 
 enum field_op_id {
 	FIELD_OP_NONE,
@@ -160,6 +161,8 @@ struct hist_field {
 
 	/* Numeric literals are represented as u64 */
 	u64				constant;
+	/* Used to optimize division by constants */
+	u64				div_multiplier;
 };
 
 static u64 hist_field_none(struct hist_field *field,
@@ -311,6 +314,83 @@ static u64 hist_field_div(struct hist_field *hist_field,
 	return div64_u64(val1, val2);
 }
 
+static u64 div_by_zero(struct hist_field *hist_field,
+			struct tracing_map_elt *elt,
+			struct trace_buffer *buffer,
+			struct ring_buffer_event *rbe,
+			void *event)
+{
+	return -1;
+}
+
+static u64 div_by_power_of_two(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct trace_buffer *buffer,
+				struct ring_buffer_event *rbe,
+				void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+
+	return val1 >> __ffs64(val2);
+}
+
+static u64 div_by_not_power_of_two(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct trace_buffer *buffer,
+				struct ring_buffer_event *rbe,
+				void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+
+	return div64_u64(val1, val2);
+}
+
+static u64 div_by_mult_and_shift(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct trace_buffer *buffer,
+				struct ring_buffer_event *rbe,
+				void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+
+	/*
+	 * If the divisor is a constant, do a multiplication and shift instead.
+	 *
+	 * Choose Z = some power of 2. If Y <= Z, then:
+	 *     X / Y = (X * (Z / Y)) / Z
+	 *
+	 * (Z / Y) is a constant (mult) which is calculated at parse time, so:
+	 *     X / Y = (X * mult) / Z
+	 *
+	 * The division by Z can be replaced by a shift since Z is a power of 2:
+	 *     X / Y = (X * mult) >> HIST_DIV_SHIFT
+	 *
+	 * As long, as X < Z the results will not be off by more than 1.
+	 */
+	if (val1 < (1 << HIST_DIV_SHIFT)) {
+		u64 mult = operand2->div_multiplier;
+
+		return (val1 * mult + ((1 << HIST_DIV_SHIFT) - 1)) >> HIST_DIV_SHIFT;
+	} else {
+		u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+
+		return div64_u64(val1, val2);
+	}
+}
+
+static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor);
+
 static u64 hist_field_mult(struct hist_field *hist_field,
 			   struct tracing_map_elt *elt,
 			   struct trace_buffer *buffer,
@@ -573,6 +653,40 @@ struct snapshot_context {
 	void			*key;
 };
 
+
+static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
+					 const char *var_name);
+
+/*
+ * Returns the specific division function to use if the divisor
+ * is constant. This avoids extra branches when the trigger is hit.
+ */
+static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor)
+{
+	u64 div;
+
+	if (divisor->flags & HIST_FIELD_FL_VAR_REF) {
+		struct hist_field *var;
+
+		var = find_var_field(divisor->var.hist_data, divisor->name);
+		div = var->constant;
+	} else
+		div = divisor->constant;
+
+	if (!div)
+		return div_by_zero;
+
+	if (!(div & (div - 1)))
+		return div_by_power_of_two;
+
+	/* If the divisor is too large, do a regular division */
+	if (div > (1 << HIST_DIV_SHIFT))
+		return div_by_not_power_of_two;
+
+	divisor->div_multiplier = div64_u64((u64)(1 << HIST_DIV_SHIFT), div);
+	return div_by_mult_and_shift;
+}
+
 static void track_data_free(struct track_data *track_data)
 {
 	struct hist_elt_data *elt_data;
@@ -2595,7 +2709,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 		expr->name = expr_str(expr, 0);
 	} else {
-		expr->fn = op_fn;
+		if (field_op == FIELD_OP_DIV &&
+				operand2_flags & HIST_FIELD_FL_CONST)
+			expr->fn = hist_field_get_div_fn(operand2);
+		else
+			expr->fn = op_fn;
 
 		/* The operand sizes should be the same, so just pick one */
 		expr->size = operand1->size;
-- 
2.33.0.1079.g6e70778dc9-goog

