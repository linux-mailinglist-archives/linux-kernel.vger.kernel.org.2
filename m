Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561C13611F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhDOSTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhDOSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA521C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so29189884edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhxG8/VABYOgSLbjnnl5bgLFBwseApWoQ7b55bJQ27E=;
        b=E6V+8MHWnJNcu0uOnIQnI0hU6vGwG7gT2WoMHDIEmKcPyfTCGgCtIWUF7UxZpiP+yt
         5YUPPfpulil/AVQr+5HqTGDd0iKRhKem0bCypfOPsaPCgGj8NFU+f4Lc9w5Nja0isERa
         /uB/r1XpiLIhTcz5meu6NxQV7CtPmR8E5givrrRLxnpKytHSAOnsw5r5+vNSvWnXUSVZ
         reQZKdTn1facnQ0qF9+QWv1FYJPTFmlFl+Ozl7KeUYkhQGP6X5i/pkugySW9YsXAcIsF
         LwxSdqf8LwMP1dtPeo15+j01qEIlQMna2zHeZtj5tvofNCaMehaQZxPP/dYbxOosVpnR
         nq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhxG8/VABYOgSLbjnnl5bgLFBwseApWoQ7b55bJQ27E=;
        b=se89M44NJb4lc+aCeeZU0IjkanlAGEiKYuM9uVrpIkrkggOubGoOfyoMMpUGAYIMjv
         0JQ0BChOmIol3YBobczs0wuwLhSR1k9KxZvSG0dHsV7QmgtXRxktMvJ2Y0iXUHjH9zLI
         tPJu4xjBdqRQpC96yy7Fy1yjv8YmJ+v5Qhpl64H6Lf0yugaa3mHh35+YxOYHW0otdJBE
         9V9PtCayhj4TClH0CMNGmJzhbmJdFGcFqLz0ITwdW5L1GcSEzGmxY4hgVPzZN1X67dkV
         1buH5cxQMxIol61gTa4q4p2BLfWmpzqC/vil8nGZLydN5U8NSl69JQFFHzYt8BzrnbFR
         1YLw==
X-Gm-Message-State: AOAM532uTiuo/J39OBMztmwBux7k3kbOmQnD16XyAZ1zUYWPcubJfWCU
        FbOyrAlsMgFF/pWctOK1/7ifgDHBquw=
X-Google-Smtp-Source: ABdhPJwTc3eSn7gCKVr9nuKn5+27jTu7RnMy72IcCJnm+ooe7YKbDP+kjwsjwbd7HZNLhT3pzfKO2w==
X-Received: by 2002:a05:6402:142:: with SMTP id s2mr5833156edu.2.1618510750515;
        Thu, 15 Apr 2021 11:19:10 -0700 (PDT)
Received: from localhost.localdomain ([84.40.93.55])
        by smtp.gmail.com with ESMTPSA id h9sm1130903ejf.10.2021.04.15.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:19:10 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v4 1/6] tracing: Define static void trace_print_time()
Date:   Thu, 15 Apr 2021 21:18:49 +0300
Message-Id: <20210415181854.147448-2-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415181854.147448-1-y.karadz@gmail.com>
References: <20210415181854.147448-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part of the code that prints the time of the trace record in
"int trace_print_context()" gets extracted in a static function. This
is done as a preparation for a following patch, in which we will define
a new ftrace event called "func_repeats". The new static method,
defined here, will be used by this new event to print the time of the
last repeat of a function that is consecutively called number of times.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 kernel/trace/trace_output.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a0146e1fffdf..333233d45596 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -587,13 +587,26 @@ lat_print_timestamp(struct trace_iterator *iter, u64 next_ts)
 	return !trace_seq_has_overflowed(s);
 }
 
+static void trace_print_time(struct trace_seq *s, struct trace_iterator *iter,
+			     unsigned long long ts)
+{
+	unsigned long secs, usec_rem;
+	unsigned long long t;
+
+	if (iter->iter_flags & TRACE_FILE_TIME_IN_NS) {
+		t = ns2usecs(ts);
+		usec_rem = do_div(t, USEC_PER_SEC);
+		secs = (unsigned long)t;
+		trace_seq_printf(s, " %5lu.%06lu", secs, usec_rem);
+	} else
+		trace_seq_printf(s, " %12llu", ts);
+}
+
 int trace_print_context(struct trace_iterator *iter)
 {
 	struct trace_array *tr = iter->tr;
 	struct trace_seq *s = &iter->seq;
 	struct trace_entry *entry = iter->ent;
-	unsigned long long t;
-	unsigned long secs, usec_rem;
 	char comm[TASK_COMM_LEN];
 
 	trace_find_cmdline(entry->pid, comm);
@@ -614,13 +627,8 @@ int trace_print_context(struct trace_iterator *iter)
 	if (tr->trace_flags & TRACE_ITER_IRQ_INFO)
 		trace_print_lat_fmt(s, entry);
 
-	if (iter->iter_flags & TRACE_FILE_TIME_IN_NS) {
-		t = ns2usecs(iter->ts);
-		usec_rem = do_div(t, USEC_PER_SEC);
-		secs = (unsigned long)t;
-		trace_seq_printf(s, " %5lu.%06lu: ", secs, usec_rem);
-	} else
-		trace_seq_printf(s, " %12llu: ", iter->ts);
+	trace_print_time(s, iter, iter->ts);
+	trace_seq_puts(s, ": ");
 
 	return !trace_seq_has_overflowed(s);
 }
-- 
2.25.1

