Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABE41D06D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346836AbhI3AFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhI3AF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:05:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE826C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:03:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so2693737plh.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEMf5o/tB/+G1JYjvjKHnHWKGeU4L35T+mKJz6tMWp8=;
        b=XUvIe1coOSyowS2I6/uzAHiwh4zk58qHCPd2Rhw8gqMWjDjElvPUG1+QHUPPgX0sEH
         25WrVxZH3PjExMxVK/7q0HGEo2SOmBZ719OQT0+F6rXYf2W9mTrzaaGrBKcxiR1+4DmH
         jFjpTC/tlPnL1eYXuTpyEo+Dec43mfoO0ef+8aGKPaXWLQxfM3qMu3QAKWrRhug7Op87
         /qsH8oJv1TU5jKBW6SHaoa/Vws7FmRguUsQtnsP+w9pMk372KzyKhbsdXyO7KIWp6nI/
         kVJeneaN53Mus1J5fpwgNkcLRoyREFys+PHtwrme/OnFwD/KLW4vpz/lE05Qw49eGAVE
         in/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEMf5o/tB/+G1JYjvjKHnHWKGeU4L35T+mKJz6tMWp8=;
        b=CCK7WwotdtfONLgbej9r4TE3xLYHc7l/Dgo13nn5OfWi5+XJnGnC3LpMT5kDB3rxbi
         3SlbbjU1ojkVy2DWPzVpyQJ6OSPhW6k4xIu/YDqTDDFaP9915C97tjxql10p6Z5IDwTW
         2kmrRujPo7IBEiweuNGbsVsnL+Aarf7AJYT0/Wn4dDhR7OFvv6z42OFVgBlyWJ/LpawY
         PietL1Ihmz1xde9uDTM0J1DOuGr409DF94IDiUd0DQzdYkQ1eYCjDGepGWHRzyC5nSkg
         cMSaQEDtqJEuvpV8f0rQEUKJRj72f0exKfO4v5YJDR/tByDFj49OjoNIPgdFEgDcOvob
         EUDA==
X-Gm-Message-State: AOAM533si7bOca7viX03EJTAVQScipW8bc5pTtIOZGBmp1spI3TJjCih
        b90IgJN9gGnv+VbAkWz4fh8=
X-Google-Smtp-Source: ABdhPJyjaSeBJQXFtGH7LN1ia2DVknh63E1R2bHRJW6Ocd7OYlnSE3DR1bBPZpxUI/WXA5sFGtXX3A==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr9473666pji.91.1632960227378;
        Wed, 29 Sep 2021 17:03:47 -0700 (PDT)
Received: from WRT-WX9.. ([158.247.226.116])
        by smtp.gmail.com with ESMTPSA id k9sm788212pfa.88.2021.09.29.17.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 17:03:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] trace: in_irq() cleanup
Date:   Thu, 30 Sep 2021 08:03:42 +0800
Message-Id: <20210930000342.6016-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/trace/trace.h                 | 2 +-
 kernel/trace/trace_functions_graph.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b7c0f8e160fb..aeec5aa0549d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -881,7 +881,7 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 		 * is set, and called by an interrupt handler, we still
 		 * want to trace it.
 		 */
-		if (in_irq())
+		if (in_hardirq())
 			trace_recursion_set(TRACE_IRQ_BIT);
 		else
 			trace_recursion_clear(TRACE_IRQ_BIT);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 0de6837722da..b08d3923de98 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -120,7 +120,7 @@ static inline int ftrace_graph_ignore_irqs(void)
 	if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
 		return 0;
 
-	return in_irq();
+	return in_hardirq();
 }
 
 int trace_graph_entry(struct ftrace_graph_ent *trace)
-- 
2.32.0

