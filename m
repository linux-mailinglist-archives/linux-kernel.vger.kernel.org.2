Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E998945520F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbhKRBSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbhKRBSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:18:46 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:15:47 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 4-20020a170902c20400b0014381f710d5so2086039pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=fLkjY/BIHicqb1iO6w7V5vCubha0RpnrJMU8Fe91ixw=;
        b=srlZmz2R/8GRZyq3EzvYSowJqm5XjAcgvtXEIyDtnNtSTrPapN95IK3zLk+l1S9GEs
         z+DZm7qs9jj2WqtCYH+23IrFSi14FLWyrlRRkPTxCIRKEjgp7H0AJpntxgWmuezI9B2+
         arAEMOZ+mo3eGtgQM4GiutqklXufLO+j4GPvC3hz34PRE8rVbOYWr3RurM3E+OoOkyiy
         k5wtclFZKF+cs27DEWzMFnXc5RezTfT0Xupvd5fmRu3kgB/7Hzmf7Vyd0AHo1BzHkbhT
         zAbF5hzqxZLl2FCr+5mgDspOQ3tSM8MQv/iyZ+l9G7kHf06FYvlQcKWPqq4CvjtKE7nh
         Ig+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=fLkjY/BIHicqb1iO6w7V5vCubha0RpnrJMU8Fe91ixw=;
        b=gBGz5kZIezTORV2+pTo2jYBYVfQbUWFMGOafhGqJAFfwIAGLGsqHbUC/IzN+m8PLLz
         sj9LIWwwLadHZahzEZVoNQ/8rdHQ1e8eVRSasEuXzzrkFwUVbji/vDIbibNy53l0Gnwu
         SIv6QTLSD6m+cK8NCxn3uJVLwcnSqsug9ni6EZ592gt/WDdspegM4WgLMKJrNVvyu0q6
         sPurz0NgrFkCR/+8M5jy3JxQ5NrmRj8xRtfq3IkFsNrCkV0ZpO4uksUTh2+KwPxQ4wsB
         iZhdbrKu0RxD00+TaXShHzFFZ+WGmO98+Tj+SzqbxYA3c8hQxWz5vhdLJkN3Ph2oA6je
         kPlQ==
X-Gm-Message-State: AOAM5306Ib81r46kEYrJp7h8SZfU/kGg0Sf5V0fQiKOnIeP1RTe26tU4
        TlRODTJxqrUHLHlk/fsGr4/WOXj0h9l/xvBvPw==
X-Google-Smtp-Source: ABdhPJz+c5Uuu341EfnUjGaSBvvXDF5OPghzyitBM+6mW5n2GmA5mQaXQKHgLD2ufvRpST/iWCuk0vAiaOeT4sJRiQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:66f8:c703:9fd3:d05b])
 (user=kaleshsingh job=sendgmr) by 2002:aa7:91c5:0:b0:49f:a400:9771 with SMTP
 id z5-20020aa791c5000000b0049fa4009771mr52884493pfa.79.1637198146720; Wed, 17
 Nov 2021 17:15:46 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:15:42 -0800
Message-Id: <20211118011542.1420131-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v3] tracing/histogram: Fix UAF in destroy_hist_field()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        zanussi@kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling destroy_hist_field() on an expression will recursively free
any operands associated with the expression. If during expression
parsing the operands of the expression are already set when an error
is encountered, there is no need to explicity free the operands. Doing
so will result in destroy_hist_field() being called twice for the
operands and lead to a use-after-free (UAF) error.

If the operands are associated with the expression, only call
destroy_hist_field() on the expression since the operands will be
recursively freed.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 8b5d46fd7a38 ("tracing/histogram: Optimize division by constants")
Reported-by: kernel test robot <oliver.sang@intel.com>
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
 

base-commit: 8ab774587903771821b59471cc723bba6d893942
-- 
2.34.0.rc1.387.gb447b232ab-goog

