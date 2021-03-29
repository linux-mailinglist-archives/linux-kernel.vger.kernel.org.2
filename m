Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5534D0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhC2NGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhC2NFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:05:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B331C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ap14so6205532ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcEAlZFU4CnirkermcUf7WLqW4ILifDoriBMp1wclsw=;
        b=Zv7vqKqdbKaCe+ttBAYu0uJP+rHtpn/tDzxwRFNDM/u/r+LezsdPT3MdVF/mJs/nnq
         KR3wl+xJJLhhJITi5C+p2dBEJmk7u3OOc5mQFvuctofum+nta5Ly6+Bu2yL1QwfjE0lZ
         maCDT8ZVap0bS1mqGqh0/GoAcxluuUKGR4VpAfZEE43uLuGhAQX1v65Mt3cYBCYW0D44
         gtbJKERW8v35SGaivFl9OKSypbINS+p7Ls2fM2u20X5EFxPJ6DYFeSz5NfP996S6DUK3
         1I3MSWxhiKyir8DkFuq5vApPoixnjedCEmGvn7c9l561mQlqaQDMK4gizcShMIqoRigi
         DbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcEAlZFU4CnirkermcUf7WLqW4ILifDoriBMp1wclsw=;
        b=kXfoLGpLEucIqB8ELz7Svu0PRSOPnXu2xfM4ZiBxQ9R4SA4N20q7RlLw9UM+yU22Qd
         7oWVLn9jg2GeEdfCcWrItEpgmVEmc30KcUSz9Q8SwNQHP02O7Oa+ipiHROnUSnkWQbJz
         uMQs1NfR534d1jlv0eb0XXtGWQ9WJwUjzVxXUfnYDAdqrLdH1aCttF+iB03iPRTIR9Oa
         qVQCxTpkwexWq0X8+jFFT9jlQimvIgdPazPiPZnoSmeoQal+qyZ3/UFAHxaNQjsQBWSn
         WL9r/V913mPmVXznVaTna+LHe4KA9qCXbWtFBVSa1ZaRgs5JrmADNL9I/kfdaAfDhySp
         A7tA==
X-Gm-Message-State: AOAM530ybdEmBv+0oHZZZkQ1/MBK9EIiXj3fIBQfh4ub5HOgvfKHN+EI
        aWyYgBtWxP9Jt0DwFJNCgTuR0O+H2aHfew==
X-Google-Smtp-Source: ABdhPJzbESUxfFbuY2RlLbd6A1uDSjL/MxHFKfRxC2zm7xHkzvbwA1o2zIgB4AtqhCi22+WIL0EVBw==
X-Received: by 2002:a17:906:379b:: with SMTP id n27mr29339643ejc.182.1617023147779;
        Mon, 29 Mar 2021 06:05:47 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id gt37sm8123905ejc.12.2021.03.29.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:05:47 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v2 2/5] tracing: Add "last_func_repeats" to struct trace_array
Date:   Mon, 29 Mar 2021 16:05:30 +0300
Message-Id: <20210329130533.199507-3-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329130533.199507-1-y.karadz@gmail.com>
References: <20210329130533.199507-1-y.karadz@gmail.com>
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
 kernel/trace/trace.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3c605957bb5c..6fcc159c34a8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9103,6 +9103,7 @@ static int __remove_instance(struct trace_array *tr)
 	ftrace_clear_pids(tr);
 	ftrace_destroy_function_files(tr);
 	tracefs_remove(tr->dir);
+	free_percpu(tr->last_func_repeats);
 	free_trace_buffers(tr);
 
 	for (i = 0; i < tr->nr_topts; i++) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6a5b4c2a0fa7..1cd4da7ba769 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -262,6 +262,17 @@ struct cond_snapshot {
 	cond_update_fn_t		update;
 };
 
+/*
+ * struct trace_func_repeats - used to keep track of the consecutive
+ * (on the same CPU) calls of a single function.
+ */
+struct trace_func_repeats {
+	unsigned long	ip;
+	unsigned long	parent_ip;
+	unsigned long	count;
+	u64		ts_last_call;
+};
+
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -358,8 +369,15 @@ struct trace_array {
 #ifdef CONFIG_TRACER_SNAPSHOT
 	struct cond_snapshot	*cond_snapshot;
 #endif
+	struct trace_func_repeats	__percpu *last_func_repeats;
 };
 
+static inline struct trace_func_repeats __percpu *
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

