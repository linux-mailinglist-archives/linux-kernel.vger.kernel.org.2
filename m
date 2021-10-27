Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EB43CE60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbhJ0QMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242946AbhJ0QM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CD761040;
        Wed, 27 Oct 2021 16:10:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV3-000xrC-OX;
        Wed, 27 Oct 2021 12:10:01 -0400
Message-ID: <20211027161001.592319549@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [for-next][PATCH 10/15] tracing/histogram: Simplify handling of .sym-offset in expressions
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

The '-' in .sym-offset can confuse the hist trigger arithmetic
expression parsing. Simplify the handling of this by replacing the
'sym-offset' with 'symXoffset'. This allows us to correctly evaluate
expressions where the user may have inadvertently added a .sym-offset
modifier to one of the operands in an expression, instead of bailing
out. In this case the .sym-offset has no effect on the evaluation of the
expression. The only valid use of the .sym-offset is as a hist key
modifier.

Link: https://lkml.kernel.org/r/20211025200852.3002369-5-kaleshsingh@google.com

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 43 +++++++++++++-------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7a50ea2ac6b1..bbaf2e16b7ae 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -68,8 +68,7 @@
 	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
 	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
 	C(EXPECT_NUMBER,	"Expecting numeric literal"),		\
-	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"), \
-	C(SYM_OFFSET_SUBEXPR,	".sym-offset not supported in sub-expressions"),
+	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -1672,10 +1671,6 @@ static int contains_operator(char *str, char **sep)
 	 */
 	minus_op = strrchr(str, '-');
 	if (minus_op) {
-		/* Unfortunately, the modifier ".sym-offset" can confuse things. */
-		if (minus_op - str >= 4 && !strncmp(minus_op - 4, ".sym-offset", 11))
-			goto out;
-
 		/*
 		 * Unary minus is not supported in sub-expressions. If
 		 * present, it is always the next root operator.
@@ -2138,7 +2133,11 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			*flags |= HIST_FIELD_FL_HEX;
 		else if (strcmp(modifier, "sym") == 0)
 			*flags |= HIST_FIELD_FL_SYM;
-		else if (strcmp(modifier, "sym-offset") == 0)
+		/*
+		 * 'sym-offset' occurrences in the trigger string are modified
+		 * to 'symXoffset' to simplify arithmetic expression parsing.
+		 */
+		else if (strcmp(modifier, "symXoffset") == 0)
 			*flags |= HIST_FIELD_FL_SYM_OFFSET;
 		else if ((strcmp(modifier, "execname") == 0) &&
 			 (strcmp(field_name, "common_pid") == 0))
@@ -2463,24 +2462,6 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * ".sym-offset" in expressions has no effect on their evaluation,
-	 * but can confuse operator parsing.
-	 */
-	if (*n_subexprs == 0) {
-		sep = strstr(str, ".sym-offset");
-		if (sep) {
-			*sep = '\0';
-			if (strpbrk(str, "+-/*") || strpbrk(sep + 11, "+-/*")) {
-				*sep = '.';
-				hist_err(file->tr, HIST_ERR_SYM_OFFSET_SUBEXPR,
-					 errpos(sep));
-				return ERR_PTR(-EINVAL);
-			}
-			*sep = '.';
-		}
-	}
-
 	field_op = contains_operator(str, &sep);
 
 	if (field_op == FIELD_OP_NONE)
@@ -5999,7 +5980,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct synth_event *se;
 	const char *se_name;
 	bool remove = false;
-	char *trigger, *p;
+	char *trigger, *p, *start;
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
@@ -6047,6 +6028,16 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		trigger = strstrip(trigger);
 	}
 
+	/*
+	 * To simplify arithmetic expression parsing, replace occurrences of
+	 * '.sym-offset' modifier with '.symXoffset'
+	 */
+	start = strstr(trigger, ".sym-offset");
+	while (start) {
+		*(start + 4) = 'X';
+		start = strstr(start + 11, ".sym-offset");
+	};
+
 	attrs = parse_hist_trigger_attrs(file->tr, trigger);
 	if (IS_ERR(attrs))
 		return PTR_ERR(attrs);
-- 
2.33.0
