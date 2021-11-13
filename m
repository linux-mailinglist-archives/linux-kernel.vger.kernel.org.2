Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9999344F349
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhKMNRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:17:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233872AbhKMNQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:16:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C3E61027;
        Sat, 13 Nov 2021 13:14:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mlsr7-000Rnc-W9;
        Sat, 13 Nov 2021 08:14:06 -0500
Message-ID: <20211113131405.826879242@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 13 Nov 2021 08:13:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-linus][PATCH 3/3] tracing/histogram: Fix check for missing operands in an expression
References: <20211113131340.640683117@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

If a binary operation is detected while parsing an expression string,
the operand strings are deduced by splitting the experssion string at
the position of the detected binary operator. Both operand strings are
sub-strings (can be empty string) of the expression string but will
never be NULL.

Currently a NULL check is used for missing operands, fix this by
checking for empty strings instead.

Link: https://lkml.kernel.org/r/20211112191324.1302505-1-kaleshsingh@google.com

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 9710b2f341a0 ("tracing: Fix operator precedence for hist triggers expression")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6a9fa34e2785..1475d7347fe0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2581,7 +2581,8 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	operand1_str = str;
 	str = sep+1;
 
-	if (!operand1_str || !str)
+	/* Binary operator requires both operands */
+	if (*operand1_str == '\0' || *str == '\0')
 		goto free;
 
 	operand_flags = 0;
-- 
2.33.0
