Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93344ED1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhKLTQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 14:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhKLTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:16:26 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62CC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 11:13:35 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z19-20020a630a53000000b002dc2f4542faso5305206pgk.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=GsIi8/iqtr2GLgOD7vsfMp3NlXKV3TgHKavw0IFPKpY=;
        b=gt7k/aSehR6cQr0L3Jzrt9q7UFuIliY5b0NVuQY/JpWzn+348526bQv7ipD5Ast66n
         WaqLA8xmZ06AAntCyondqeJwzKAbruZQ+S8xsLRDSc58o7KLPlIqFLB6zgm03lhSjghj
         uo9F2keim+n85vNmhojyW1G109o9zeFxOgL/JSEmQGysXeyW269NHIszvnl55ajrq7DD
         vvzaPi8lqIR//koy8Efi4WdQ16mqo50hxlDvPqJAUOGcuIpwI2grylD9ti45kf5fxj4V
         BwNevQH0mK6mBKdq8rO0Lwjbi+4/V/vNuYi9PvNLm+Jy7AY0UkJvMXfVhLCx4UVkUOEQ
         OPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=GsIi8/iqtr2GLgOD7vsfMp3NlXKV3TgHKavw0IFPKpY=;
        b=PhL0MvfqzvQVTaK40FtP3bcCivBt6livCIP439h6/76/D5cWHYPjasKVEgnCq/8OR5
         jVMxNTJIYCwREEs8so0LRmwqBwzhPeJkow0iOSjpp8446a+9poGDzKywWIQXvfcAbFYd
         A/VVssQgrfeXwpT6ieLqEPijVmF7QHddUhqOAYMS37YxFOLWE1M3i9UaIPX+22QQGv+p
         RE6QinwZNcNsgp3aEFlZ78Q2O3T8HFF0c+LR3O2P5DDtaZHJxG28Txq01S3LeZ4Qit8x
         NLEJ2cPUNpi8q9FgtqBcd7uuc0OlZx8jxtIRaQjyDji7+lWsb7BWQZXZgEXHlubzjJ/A
         f6/w==
X-Gm-Message-State: AOAM531qG4wuedqz53fYmW04rDGUJaLRjDVYtNjkn5bgTXZtBn8vv+Fb
        RsCqGTrmURccwVgimTIxW8NRwF8ZhtIR3jLuHA==
X-Google-Smtp-Source: ABdhPJzYh+LCMezXcM7CyllvNk7f0e4nKS6rGcYs6E6xpHxga3UiQLpCIUS3W+BAnuOP8Al6JRqyNnWj/64XDIm53Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b3bc:434c:ee52:f320])
 (user=kaleshsingh job=sendgmr) by 2002:a17:90a:8a82:: with SMTP id
 x2mr20217933pjn.187.1636744414929; Fri, 12 Nov 2021 11:13:34 -0800 (PST)
Date:   Fri, 12 Nov 2021 11:13:24 -0800
Message-Id: <20211112191324.1302505-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] tracing/histogram: Fix check for missing operands in an expression
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        zanussi@kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a binary operation is detected while parsing an expression string,
the operand strings are deduced by splitting the experssion string at
the position of the detected binary operator. Both operand strings are
sub-strings (can be empty string) of the expression string but will
never be NULL.

Currently a NULL check is used for missing operands, fix this by
checking for empty strings instead.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 9710b2f341a0 ("tracing: Fix operator precedence for hist triggers expression")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0abc9a413b4d..328b1f83a3c8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2580,7 +2580,8 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	operand1_str = str;
 	str = sep+1;
 
-	if (!operand1_str || !str)
+	/* Binary operator requires both operands */
+	if (*operand1_str == '\0' || *str == '\0')
 		goto free;
 
 	operand_flags = 0;

base-commit: 5833291ab6de9c3e2374336b51c814e515e8f3a5
-- 
2.34.0.rc1.387.gb447b232ab-goog

