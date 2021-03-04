Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5707E32CF3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhCDJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhCDJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:03:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F74AC061762
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:02:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lr13so47846422ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eu5OJzH7maufbREWovWushZstOy2hgo0oLSHqoVL++k=;
        b=imRENuLrcxxdbwjnbS0xNPn/qyDaRMGGVsSekjpuWvRIXE+UCPxeYOsD4eCQ+IUeZ8
         gJN7qL20TeeXL+pID9+i370/fmIt0EJGeHbzVuTKu5YneKqwx1nhBFUIMpN4xrZe1N9n
         iNy4ETNY6nF2xx+SKmZmPYiXhT1Ndw3WXpPUZFxZvm+Zq5PWtrPi6IzSeelu2xpKLOn6
         yNzRCxGwvMPkjYhsa1Vw2hE4nD0xQq+ivHc5TiO2Zk3730LtYE/R3gP2oLNltZhPmM6+
         Ym38u7T8f0xPtu7eIjhEKV86KUjASeCE11TCMmF3bRubdPe4U/Kcq9ijfdY/icoungF4
         8q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eu5OJzH7maufbREWovWushZstOy2hgo0oLSHqoVL++k=;
        b=Xg63PFMOPzOMx2+FkbB3HH81S04+xUgEKI/9S0LAKf4cQT9jwOShYXQ2/lMgG07f5v
         oWiwFC2E8e1fIL/zRYWtVCyj0Vv6DMPjRVzby15W3I3z+gx9GP+9hAY8PbOyhdNuZc8b
         rDZ7aV91HJxEvKPvXoe0mKqmI2U6wa3o+6Y6dIW6Tk7TcVnnYb68hfUoyiqEUOAqhCya
         59rcDyGYkFefg/vRrFdp1UBnUH1mVT8YczHBUVsorb/vzDt+xzaUtcoGs/rHCa2MFSlS
         gpuc9F2bqkchmU96pD9DflkAatYpdzu2SF477o7lQfh6hRo36UMWlkorpRUgZrzL7Ti0
         3cng==
X-Gm-Message-State: AOAM532CwSbeeHftmHeqmIzgLRoVqkmdDUpCdD11nxqs24lN8K0rygts
        +RJBt6/Y6rZkXxd7DETGC34w4Zl/rEG4AA==
X-Google-Smtp-Source: ABdhPJyEbmfrsrKvhMCXHGkT7tCMNu0vMNzRiLUG9aq2u988kNB7WgUTSf6tlVtZNMAc1s3zojRBYA==
X-Received: by 2002:a17:906:5043:: with SMTP id e3mr3142322ejk.260.1614848540740;
        Thu, 04 Mar 2021 01:02:20 -0800 (PST)
Received: from localhost.localdomain ([95.87.199.88])
        by smtp.gmail.com with ESMTPSA id f22sm23123552eje.34.2021.03.04.01.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:02:20 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 3/5] tracing: Add method for recording "func_repeats" events
Date:   Thu,  4 Mar 2021 11:01:39 +0200
Message-Id: <20210304090141.207309-4-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304090141.207309-1-y.karadz@gmail.com>
References: <20210304090141.207309-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only provides the implementation of the method.
Later we will used it in a combination with a new option for
function tracing.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 kernel/trace/trace.c | 21 +++++++++++++++++++++
 kernel/trace/trace.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5f5fa08c0644..5c62fda666af 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3109,6 +3109,27 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 
 #endif /* CONFIG_STACKTRACE */
 
+void trace_last_func_repeats(struct trace_array *tr,
+			     struct trace_func_repeats *last_info,
+			     unsigned int trace_ctx)
+{
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct func_repeats_entry *entry;
+	struct ring_buffer_event *event;
+
+	event = __trace_buffer_lock_reserve(buffer, TRACE_FUNC_REPEATS,
+					    sizeof(*entry), trace_ctx);
+	if (!event)
+		return;
+
+	entry = ring_buffer_event_data(event);
+	entry->ip = last_info->ip;
+	entry->pip = last_info->parent_ip;
+	entry->count = last_info->count;
+
+	__buffer_unlock_commit(buffer, event);
+}
+
 /* created for use with alloc_percpu */
 struct trace_buffer_struct {
 	int nesting;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 09bf12c038f4..0ef823bb9594 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -696,6 +696,10 @@ static inline void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 }
 #endif /* CONFIG_STACKTRACE */
 
+void trace_last_func_repeats(struct trace_array *tr,
+			     struct trace_func_repeats *last_info,
+			     unsigned int trace_ctx);
+
 extern u64 ftrace_now(int cpu);
 
 extern void trace_find_cmdline(int pid, char comm[]);
-- 
2.25.1

