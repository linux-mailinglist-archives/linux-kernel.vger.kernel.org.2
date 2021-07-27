Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35403D8374
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhG0Wzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhG0Wzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:55:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1BD560EB2;
        Tue, 27 Jul 2021 22:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627426545;
        bh=QkTDByEnE4LCuSQi2L0xJuuRRUXksrvye21QecmaUbQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cHyNZCz2Fr0ND9uYXCCu9ZJk+p+lRu21AaOLRe8kiQelLLnYQTP2/FFtyIrlzVQWU
         0Eg7D51e4nOPJy5F9aiTffmrub5rVvQFYRKLcPGN+CVzdl32Jbd5iMTA8cLJVJPeKF
         K+ybH4lXFpbYLpHbnyiy+Gzs+JAdQwU8WBc2J1Bi2SgjJ29/AhrnmeU4QPXgh2dKIZ
         QWQaygEjIe10V8op5KWyW08Q+Yc9o04goqQQQI68YshMMPdU9fsOgIt5hSIvxEqiaa
         vMAnJrhTbdbSPIm4i0WSean/1R26kH2FRP4746QzwbsZTTuy+4QS4Da0n/nFAowfEo
         WpD6PAhzspxyg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] tracing: Reject string operand in the histogram expression
Date:   Wed, 28 Jul 2021 07:55:43 +0900
Message-Id: <162742654278.290973.1523000673366456634.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the string type can not be the target of the addition / subtraction
operation, it must be rejected. Without this fix, the string type silently
converted to digits.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 76e3100a4840..3eea60e2da48 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -65,7 +65,8 @@
 	C(INVALID_SORT_MODIFIER,"Invalid sort modifier"),		\
 	C(EMPTY_SORT_FIELD,	"Empty sort field"),			\
 	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
-	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),
+	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
+	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -2183,6 +2184,13 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		ret = PTR_ERR(operand1);
 		goto free;
 	}
+	if (operand1->flags & HIST_FIELD_FL_STRING) {
+		/* String type can not be the operand of unary operator. */
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(str));
+		destroy_hist_field(operand1, 0);
+		ret = -EINVAL;
+		goto free;
+	}
 
 	expr->flags |= operand1->flags &
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
@@ -2284,6 +2292,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		operand1 = NULL;
 		goto free;
 	}
+	if (operand1->flags & HIST_FIELD_FL_STRING) {
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(operand1_str));
+		ret = -EINVAL;
+		goto free;
+	}
 
 	/* rest of string could be another expression e.g. b+c in a+b+c */
 	operand_flags = 0;
@@ -2293,6 +2306,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		operand2 = NULL;
 		goto free;
 	}
+	if (operand2->flags & HIST_FIELD_FL_STRING) {
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(str));
+		ret = -EINVAL;
+		goto free;
+	}
 
 	ret = check_expr_operands(file->tr, operand1, operand2);
 	if (ret)

