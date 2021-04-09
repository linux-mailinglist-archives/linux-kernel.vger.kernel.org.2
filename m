Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF935A557
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhDISLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCFCC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:10:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so10017117ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFwcOu4xRxqbiyWXa2HmZCe+M5m6xHGIKM2VUv3lA68=;
        b=PmtpoltgTjIBn+xoDZhDszfwCFIvr8FMJkFgDwEfIffN19lmVBYc3x9taTcNRXYlQG
         Lf/EXNM6LZqeSZrfkXSvmHt1MhtdwZMFi3aQkRakIc4Ju+bwuWpP9lZIYYJ7OxNo6rhS
         +fHh+EvHLBWIgB1dnkpjnM+wx1TUBZpSMqK8uBsvnDefmEG6AWqnl/NCcQpf8wRNoVNp
         rDrR8Xg0RVHYvUQnX3zmoF2wTKfu07HeRKfW0lGRpEGq+WaJ4oUQNXfxyFj5lGhfIRWB
         woOYhvUN0bbIt4nNlq8tSk3/UbI2RYiLmMRXA+1z4VKLzVYSs9groxU2nLlYGASKdYWw
         YxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFwcOu4xRxqbiyWXa2HmZCe+M5m6xHGIKM2VUv3lA68=;
        b=Ng3yz0mMcVVG9eQXDmd6UE35/dKn6h5GTQam+9833YEJxAmZgy9QT9g328hM7cRN7L
         IllmluQno1fB8c1ghJlC3IM5lGe//roq+FDXNAFjutKKe1ETckFj/LS23LHy2R4J+8Ls
         okRcHBNKys8SvWCh+sGZYo9kh8t3aUbc5J9LoYfpaSoyesX8q/2/73jb8J/uRFgITTk5
         KOe9My3ry7JS5+EXgfiwOtrhQAm5293dchRKSwexVazHkCE7xc8soN1qSBwG1Lo5K1wY
         OJnFpRBHpICffIvry4ZguHnIUWT/FVQm0+AE2r6vjDDW0W5gyiE6TkK+/HRcB90czgFF
         wNRw==
X-Gm-Message-State: AOAM533ch55zM4lI46RlVptMzTnHel+PMsruOoC5gGLK7N7FVBb4oG76
        DnuAcOE+q1ZvWeL8aa0BxSwBxN4eKhzxSA==
X-Google-Smtp-Source: ABdhPJwvlZUKLIfVdEW54lUuyI3plBCMSjQrlRQkqAbylOydJ4P3yo0Ic/olAm/RPikgOPXu8xb30w==
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr16943994ejz.382.1617991846722;
        Fri, 09 Apr 2021 11:10:46 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id s20sm1806303edu.93.2021.04.09.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:46 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v3 2/5] tracing: Add "last_func_repeats" to struct trace_array
Date:   Fri,  9 Apr 2021 21:10:28 +0300
Message-Id: <20210409181031.26772-3-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409181031.26772-1-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
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
index 507a30bf26e4..82833be07c1e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9104,6 +9104,7 @@ static int __remove_instance(struct trace_array *tr)
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

