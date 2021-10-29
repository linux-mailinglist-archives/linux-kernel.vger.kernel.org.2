Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419564405BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 01:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJ2X0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2X0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 19:26:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6355DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 16:24:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo16172379ybc.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 16:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=4ulZtdQXwqnMrOOfkX7FfBZZmX4U3TjdWDrwxIXkEPo=;
        b=FEbLmNtj0bxIQoKz/UHIWXSbl03f9eqVUt48Fy1iHKowKXk5YyZ9JPeF9jLn/bRUBe
         wLaSwq2rGUIfy2X3tHuMGD4rvEUZDT/21eXEZA/RmoFpYLb5rA4Oa4slWq9S1MzGgf1T
         TMsrqQYXBFiMOTivIArbLJYFH5ZUO/o5yJhlLG3nIneYHGe8dDH9Hh74W1jCzUpcaaIA
         sA5KA3JnY0kAJYYkFh3f+Hzs0QricYsd1HCxCcYOWz2v69aodiF3EXkW7MyzHEmt3k+7
         /i++4MuZ9rqtg6fFy688a6tnOEjj/tOAQSRvBBtuwrZD7UFUKH5qLqQ0UTM+Aqx94R35
         QbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=4ulZtdQXwqnMrOOfkX7FfBZZmX4U3TjdWDrwxIXkEPo=;
        b=dPsfZNpkGbuLfW4PWnm52uEwV4N4SVH3XUoepXvEv/i4aYtewkZDJMptpPw7lK0PI6
         f5yG7p7HCPgFte1P645uE2wYM7KwrhwNdtWkz7L43bHEdaJwHwdzxl1F612TUEhAWF1/
         C8tGdwDJihY2/wgcHtTGuCgnBhBot/+0wydGW5p8SP1lcmxaQv68TajVvqDbTpGhzF2b
         O3IxTLydZhZ5ye4Z03Ya5Sik7os+tKlIwy22HBbe4leGEF99rH/Plc4DbSwXmJEb+5Wx
         XvOAZLMd1LvKPKfHWu4z+G5Negi0SE705R8JwEFAzyJzpYmcGfsamjIcb7iXGhriW54H
         qedw==
X-Gm-Message-State: AOAM531yxzyiVPt1GRi3KaIaN8p8EG2fZM9Aj2AE3mIFBelbSawmcrDT
        cF2kDBf2HVshe4P05XAi3SY0zen/0tq3mO5+gg==
X-Google-Smtp-Source: ABdhPJzUlpqEFpQy7rB+N/MMkrICHBeWK8LT1dpDhKNQpnTe7yBoh3tTi2q3JoIlgpipnRWAvtlm08Yv3c9Qkn4zKQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b03:1d88:1cf2:4973])
 (user=kaleshsingh job=sendgmr) by 2002:a25:cf0d:: with SMTP id
 f13mr11846183ybg.253.1635549854626; Fri, 29 Oct 2021 16:24:14 -0700 (PDT)
Date:   Fri, 29 Oct 2021 16:24:10 -0700
In-Reply-To: <CAC_TJvfazjdZ=4Y_1YX=R+drsWKRu+faztcFjKEkkD_3Qk6_Xg@mail.gmail.com>
Message-Id: <20211029232410.3494196-1-kaleshsingh@google.com>
Mime-Version: 1.0
References: <CAC_TJvfazjdZ=4Y_1YX=R+drsWKRu+faztcFjKEkkD_3Qk6_Xg@mail.gmail.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3] tracing/histogram: Optimize division by constants
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
Changes in v3:
  - Avoid indirect function calls for retrieving const divisor value.

Changes in v2:
  - Return -EDOM if divisor is a constant and zero.

 kernel/trace/trace_events_hist.c | 105 ++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 364cb3091789..7ccb6b3a1fb4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -68,7 +68,8 @@
 	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
 	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
 	C(EXPECT_NUMBER,	"Expecting numeric literal"),		\
-	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"),
+	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"), \
+	C(DIVISION_BY_ZERO,	"Division by zero"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -92,6 +93,7 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
 #define HIST_ACTIONS_MAX	8
 #define HIST_CONST_DIGITS_MAX	21
+#define HIST_DIV_SHIFT		20  /* For optimizing division by constants */
 
 enum field_op_id {
 	FIELD_OP_NONE,
@@ -160,6 +162,8 @@ struct hist_field {
 
 	/* Numeric literals are represented as u64 */
 	u64				constant;
+	/* Used to optimize division by constants */
+	u64				div_multiplier;
 };
 
 static u64 hist_field_none(struct hist_field *field,
@@ -311,6 +315,68 @@ static u64 hist_field_div(struct hist_field *hist_field,
 	return div64_u64(val1, val2);
 }
 
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
+
+	return val1 >> __ffs64(operand2->constant);
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
+
+	return div64_u64(val1, operand2->constant);
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
+	}
+
+	return div64_u64(val1, operand2->constant);
+}
+
 static u64 hist_field_mult(struct hist_field *hist_field,
 			   struct tracing_map_elt *elt,
 			   struct trace_buffer *buffer,
@@ -573,6 +639,25 @@ struct snapshot_context {
 	void			*key;
 };
 
+/*
+ * Returns the specific division function to use if the divisor
+ * is constant. This avoids extra branches when the trigger is hit.
+ */
+static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor)
+{
+	u64 div = divisor->constant;
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
@@ -2575,6 +2660,24 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	expr->operands[0] = operand1;
 	expr->operands[1] = operand2;
 
+	if (field_op == FIELD_OP_DIV &&
+			operand2_flags & HIST_FIELD_FL_CONST) {
+		u64 divisor = var2 ? var2->constant : operand2->constant;
+
+		if (!divisor) {
+			hist_err(file->tr, HIST_ERR_DIVISION_BY_ZERO, errpos(str));
+			ret = -EDOM;
+			goto free;
+		}
+
+		/*
+		 * Copy the divisor here so we don't have to look it up
+		 * later if this is a var ref
+		 */
+		operand2->constant = divisor;
+		op_fn = hist_field_get_div_fn(operand2);
+	}
+
 	if (combine_consts) {
 		if (var1)
 			expr->operands[0] = var1;
-- 
2.33.1.1089.g2158813163f-goog

