Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD0453E47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 03:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhKQCPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 21:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhKQCPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:15:36 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB182C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 18:12:38 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so728961pfx.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 18:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=ViCp0q68S8yutt+Uti8n/05oH+t8EcE+iBuYStHsLpI=;
        b=eZv9BnCHJfMWDgJtP6Ilq87FmUD9A21/0XpuNe0jlOA+rszoDmf6b3xuPAdzNwdtda
         qaraPq0KsTN6gRFqyrtV3l4NlF8EaDLY8FEaM7lsAE45QIUab6669WbOqfdGZ3V+U0zB
         4UXWROTPb+IP8JX0x6zf2eZgt3loNagCDXW0mqEC1ArMQ1SDf8WFQYlipmBzLoXiC8A3
         fQDqQQysttaFwvE1FyHRkAhQy3wqqq4qnsAh5UQQIO8/da2XXZnbeiwZpW9fVrWyT5aQ
         pmnC7u/tOirTIkARuhM863tr4cAcgBQuKqdN2VqBp+edaFqaE5afGiQCZBgDPPrXAt9R
         MfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=ViCp0q68S8yutt+Uti8n/05oH+t8EcE+iBuYStHsLpI=;
        b=JeFTJqzkMgcTC2D+fRVMPES8a2qy/De8fAl27sorW65Nqocc33e/wwxfnQSXSpcSnn
         zsfbwX7K39tJmJZ/B+dcLNejCV2Ng9XNNAYwpGqdi0a7/tHS+BiIEvdPB7KCkdaZKiFK
         5no/9QNYT+qR5AwyGnpl+nhERtixRSqAyeULJSmP2NEqp+bkfDvZyomGRXRz7JX7SeB+
         K2PLWIJeZ+d/wC1y4CpP5j5YZpnw1HjZmS8TOsay2IGvGnPOPX7bnw9l1tQ3X5Xu3VlO
         Lmi3+2OIgvZtXKQHlL0wuZZjgsXeL9i98+B8Fois8EXkVj9ex3kvD03A/mfD39o8DCSX
         kVSw==
X-Gm-Message-State: AOAM5303CKGL/siiKQ0KVqzk2t/HXQ/XPzoHWpDrIEl/VO6faOjoIdi5
        ScwP7TNQERo9uGVEYczpr3HDDkMrqAiwgaoMhw==
X-Google-Smtp-Source: ABdhPJyUyn0PGPZ/YCCesYf7c7npNSh1aDTOK3+9RXlzVBQpruoU9sGMcqsSQRhPOEawrimsIEaxrGpu6wGC/Sd4AQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:c20a:7cc8:f6b5:d9cd])
 (user=kaleshsingh job=sendgmr) by 2002:a17:90a:4b47:: with SMTP id
 o7mr5012303pjl.92.1637115158198; Tue, 16 Nov 2021 18:12:38 -0800 (PST)
Date:   Tue, 16 Nov 2021 18:12:22 -0800
Message-Id: <20211117021223.2137117-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] tracing/histogram: Fix UAF in destroy_hist_field()
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

Fix this by only calling destroy_hist_field() for the expression if the
operands are already set.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 8b5d46fd7a38 ("tracing/histogram: Optimize division by constants")
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 kernel/trace/trace_events_hist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ea2c9ec54a6..e3856eaf2ac3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2669,7 +2669,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		if (!divisor) {
 			hist_err(file->tr, HIST_ERR_DIVISION_BY_ZERO, errpos(str));
 			ret = -EDOM;
-			goto free;
+			goto free_expr;
 		}
 
 		/*
@@ -2709,7 +2709,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 		if (!expr->type) {
 			ret = -ENOMEM;
-			goto free;
+			goto free_expr;
 		}
 
 		expr->name = expr_str(expr, 0);
@@ -2719,6 +2719,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 free:
 	destroy_hist_field(operand1, 0);
 	destroy_hist_field(operand2, 0);
+free_expr:
 	destroy_hist_field(expr, 0);
 
 	return ERR_PTR(ret);

base-commit: 8ab774587903771821b59471cc723bba6d893942
-- 
2.34.0.rc1.387.gb447b232ab-goog

