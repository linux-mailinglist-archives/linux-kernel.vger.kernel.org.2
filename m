Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4566C3611FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhDOSTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhDOSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0701C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x4so29252873edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=428k0AMzSmqdKdmEqEyPT/nED8Tp6UynaMYEPum1cPk=;
        b=RMJcdVN1t+an/1vn1xe2D71krKshq66o8EATIk84vthzlp6pUazycyGwi3YrS0g/Ci
         Zv+eyvDGwVVR7SUpjD94Qh9PbqANotxlb368FbGC46fyqOyN33eO9hMg1unvp4Z6dgGN
         iIgp9xX/3xPZ6p4LGJKdtpULQ+HnweUxPdcun7IMK1fRRV+trRh4IPpzL+eKYsw8wmdr
         KgNPZ6uxnTBlESaXvci1tlkBl7pbN9BN0u/e11Gm/LKpu8RT1Dx6LVJfmQ9We8jgYuXA
         xuHBwNN4tgE419XzTX1+Pczq6RCZt0GU7U6IZ8CSOG6BR0VcXsZeYIYIjrqo++O8fGrG
         VZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=428k0AMzSmqdKdmEqEyPT/nED8Tp6UynaMYEPum1cPk=;
        b=hB7eAOHXgdo+7jFSKUH4Cen4W8+tGSCPkKrS+jw7Alwq+M8sRmr/HrTZwiXwAmLbB5
         VkHy0OhusIZQamB9DXVtSEobT6uwxSa2MS95BHKKIfgauNMdDFJN5zLZP354xa5tStiR
         CNE0wgEU440HU18WR9YYNv1km7irCn1xxL/Ej3Q91Q6h0o0FcuTBvx/qANjX5RZHjAkq
         67HzxN/fbPhyYbXz8jfkpaDozAGeVoNITEb8WRYVO3hPMWta4DykQm6Fe0mW7dwYb9ch
         kusVMd3/i1c6DTj2E40obvt6BjMuyA7Znu7m07gSpOquGSgM2qMpdCa5S1AiFHr4p+4n
         tLiA==
X-Gm-Message-State: AOAM5312wWX6o5Y26A06LEn44/xJfBbDCGYrjxYvupaKP4oc0v8I0j70
        vINsi8NXACrA6BWuXC+51yO7spu2TKU=
X-Google-Smtp-Source: ABdhPJyzC6apzBSgcGiObSCrF/rnxIhq7S6LTLURabpdj8d3R/VX4Su2edn1T2m7Z5JutpCccA3KdQ==
X-Received: by 2002:a05:6402:a4a:: with SMTP id bt10mr5749489edb.39.1618510753464;
        Thu, 15 Apr 2021 11:19:13 -0700 (PDT)
Received: from localhost.localdomain ([84.40.93.55])
        by smtp.gmail.com with ESMTPSA id h9sm1130903ejf.10.2021.04.15.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:19:13 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v4 3/6] tracing: Add "last_func_repeats" to struct trace_array
Date:   Thu, 15 Apr 2021 21:18:51 +0300
Message-Id: <20210415181854.147448-4-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415181854.147448-1-y.karadz@gmail.com>
References: <20210415181854.147448-1-y.karadz@gmail.com>
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
 kernel/trace/trace.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)

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
index 6a5b4c2a0fa7..a4f1b66049fd 100644
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
@@ -358,6 +369,7 @@ struct trace_array {
 #ifdef CONFIG_TRACER_SNAPSHOT
 	struct cond_snapshot	*cond_snapshot;
 #endif
+	struct trace_func_repeats	__percpu *last_func_repeats;
 };
 
 enum {
-- 
2.25.1

