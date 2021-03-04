Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED832CF41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhCDJDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbhCDJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:03:01 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1375C061761
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:02:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id do6so47918882ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xy+b5w2N5EmHPHbbReyFTzUMq5WYB0fmy/sdV/QrCmg=;
        b=njL+mKTUkZ6v9wURhcyA6iFkyIjCGTIxD83DdcCzfc3AF3qg1W7izYXesCpHAxMnnJ
         im/Px0DAfRhRAlccgEK6Cp31nR3HAVyzb11iHMY1eykddzAMKE1Cu6xhy0mjvhjJCfsF
         RQB5DQeHtJW+6vpDRSKcgLQk+h/LtB6+XeDWdvgfrhmUtjRz5tSfqe7KVbYp/zePcvvO
         CltIGyVYMMoQnXAocs6Kk2LZaCEF0P/X/21hUFvuEn84QBUjI3Zl1C25w2WFsKEmGCrr
         +pEHTqYr3008rmzD1p5qCxLuKP8s+GoVjmH1yP0zkx/dp5PgBMSVpOh7A/WZVf47Qts3
         PVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xy+b5w2N5EmHPHbbReyFTzUMq5WYB0fmy/sdV/QrCmg=;
        b=DtyU/W2FbMg/afkVHurXZ3r/tYHp0A/0armitBocQTTF4xH/D8PHMSlX+9c/ttsEJx
         Uz55wxqLtBhWy2QdJyIOZ8RgxUWwq1tXrkjDbyH22VBVJUm8Wjb5ZsbZ6dblLtkWf88X
         qqy4F2IR4TYlqLjZeL6t9vACDlTp+eeyJXMssg0T+E9YcLUZu2eTrDznZy73jkHuWfFj
         hq2254Q7HPvln8i95G3om745GwW8b7oDsLI3P4fxd2/hquGAYkCwTYIhA+uFDPd9atQJ
         2T67mdUqjRdSbveicdoaIOTRocLfN8M6Cx/ejSMdQ1jqXvb6G6xIdHA4Mi7QwOiVACFw
         vnLA==
X-Gm-Message-State: AOAM530YhlVFiHnRssnWgp86GXt6I/KxPzf7aKMw6syQHcH+59dnQwTv
        jaN6C0eKD+4O7ORwN7Pv5COA1cwW0LKUng==
X-Google-Smtp-Source: ABdhPJxKAExOoxXKfvUK/GmkPjebYbTZjHrbpnAP8XXR13tjRyYFfYkJvHMMCcDee6uKpfkz2gq3lA==
X-Received: by 2002:a17:906:5597:: with SMTP id y23mr3146403ejp.165.1614848539458;
        Thu, 04 Mar 2021 01:02:19 -0800 (PST)
Received: from localhost.localdomain ([95.87.199.88])
        by smtp.gmail.com with ESMTPSA id f22sm23123552eje.34.2021.03.04.01.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:02:19 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 2/5] tracing: Add "last_func_repeats" to struct trace_array
Date:   Thu,  4 Mar 2021 11:01:38 +0200
Message-Id: <20210304090141.207309-3-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304090141.207309-1-y.karadz@gmail.com>
References: <20210304090141.207309-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field is used to keep track of the consecutive (on the same CPU) calls
of a single function. This information is needed in order to consolidate
the function tracing record in the cases when a single function is called
number of times.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 kernel/trace/trace.c |  1 +
 kernel/trace/trace.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e295c413580e..5f5fa08c0644 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8895,6 +8895,7 @@ static int __remove_instance(struct trace_array *tr)
 	ftrace_clear_pids(tr);
 	ftrace_destroy_function_files(tr);
 	tracefs_remove(tr->dir);
+	free_percpu(tr->last_func_repeats);
 	free_trace_buffers(tr);
 
 	for (i = 0; i < tr->nr_topts; i++) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2be4a56879de..09bf12c038f4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -262,6 +262,16 @@ struct cond_snapshot {
 	cond_update_fn_t		update;
 };
 
+/*
+ * struct trace_func_repeats - used to keep track of the consecutive
+ * (on the same CPU) calls of a single function.
+ */
+struct trace_func_repeats {
+	unsigned long ip;
+	unsigned long parent_ip;
+	unsigned long count;
+};
+
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -358,8 +368,15 @@ struct trace_array {
 #ifdef CONFIG_TRACER_SNAPSHOT
 	struct cond_snapshot	*cond_snapshot;
 #endif
+	struct trace_func_repeats	__percpu *last_func_repeats;
 };
 
+static inline struct trace_func_repeats *
+tracer_alloc_func_repeats(struct trace_array *tr)
+{
+	return tr->last_func_repeats = alloc_percpu(struct trace_func_repeats);
+}
+
 enum {
 	TRACE_ARRAY_FL_GLOBAL	= (1 << 0)
 };
-- 
2.25.1

