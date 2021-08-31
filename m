Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9533FC52C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbhHaJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240736AbhHaJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uK5Gw3luJndbFn1Fa9N5OtQXbRTUWbF3Z2jHUj38PoM=;
        b=YxLUDW/DFLPnvTRawW5QWd4ZbgSl20mMZDsYXW9OZRtYAv9URcL+EoVvEwyJf7vM6QMDQo
        7tc7jvNbAfuWEbme7MsBtl8nCjjML6OAgbzu7Z10VXm7k31cQVISGKWXjL0zi6ijBqcS+z
        DUQnpMhSeq7C6Lf/0laSZyFBJBKLUWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-q_FXOJLwNESwRVxTocKqfQ-1; Tue, 31 Aug 2021 05:50:51 -0400
X-MC-Unique: q_FXOJLwNESwRVxTocKqfQ-1
Received: by mail-wm1-f70.google.com with SMTP id f17-20020a05600c155100b002f05f30ff03so1029900wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uK5Gw3luJndbFn1Fa9N5OtQXbRTUWbF3Z2jHUj38PoM=;
        b=W58KZXgHb60vZifVgBJH43245Wv3Fs8BmyEmX+TgWuKBH3QdAfmDgyKECukJbFpwrg
         hNY6bhK/sqIfReHC7NdI/SW5S0j5ZJvxn4ApwZwvSFXmPgRuZ+gjijFoJcTPH9uRz0Rr
         bHk/uuszLWGrIHy4Sp8ikjZn869eqm6UAQmNTx9wGKaKs3tDvvrALjDf5KSMqA/zEgjI
         Kan5WPPg4k0CGrkMrEJqSLktSPnUXoL5nEgyLDDuo97JRlcnZgSqKY6wPendXgf/RQBr
         OqXC4SnXgGrkcls9w5e8Joba3Oxhe63efsYlOTM42QyPYZ1ZuVPcwwBVW2J7MXs0kqUH
         NstA==
X-Gm-Message-State: AOAM5310f9dwOt2u6BgYisCSKYK50XEAzogdrE7TpuCa742/wbCF4vKO
        0uphqKqlF7H4XxMmQuDEfMN8moNvku3fuOEfh+w4y4qjvXT+zLCeIWifdUNkrr8/I+FpKmugn6r
        66mx0/h6jiQ2hKV+UOgYvO01n
X-Received: by 2002:a7b:c316:: with SMTP id k22mr3235163wmj.56.1630403450390;
        Tue, 31 Aug 2021 02:50:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQDlQOr4yHaAI0wp/1WVyoRB28jMuZLOwEex+kYyerzAXTeemfWIxW7uAJAQsdfdrnE4qMgg==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr3235150wmj.56.1630403450186;
        Tue, 31 Aug 2021 02:50:50 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id b18sm17953773wrr.89.2021.08.31.02.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:49 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 5/8] ftrace: Add ftrace_add_rec_direct function
Date:   Tue, 31 Aug 2021 11:50:14 +0200
Message-Id: <20210831095017.412311-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code that adds (ip, addr) tuple to direct_functions
hash in new ftrace_add_rec_direct function. It will be used in
following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 60 ++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7b180f61e6d3..c60217d81040 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2394,6 +2394,39 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
+static struct ftrace_func_entry*
+ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
+		      struct ftrace_hash **free_hash)
+{
+	struct ftrace_func_entry *entry;
+
+	if (ftrace_hash_empty(direct_functions) ||
+	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
+		struct ftrace_hash *new_hash;
+		int size = ftrace_hash_empty(direct_functions) ? 0 :
+			direct_functions->count + 1;
+
+		if (size < 32)
+			size = 32;
+
+		new_hash = dup_hash(direct_functions, size);
+		if (!new_hash)
+			return NULL;
+
+		*free_hash = direct_functions;
+		direct_functions = new_hash;
+	}
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->ip = ip;
+	entry->direct = addr;
+	__add_hash_entry(direct_functions, entry);
+	return entry;
+}
+
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
@@ -5110,27 +5143,6 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	}
 
 	ret = -ENOMEM;
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
-
-		if (size < 32)
-			size = 32;
-
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			goto out_unlock;
-
-		free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		goto out_unlock;
-
 	direct = ftrace_find_direct_func(addr);
 	if (!direct) {
 		direct = ftrace_alloc_direct_func(addr);
@@ -5140,9 +5152,9 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 		}
 	}
 
-	entry->ip = ip;
-	entry->direct = addr;
-	__add_hash_entry(direct_functions, entry);
+	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
+	if (!entry)
+		goto out_unlock;
 
 	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
 	if (ret)
-- 
2.31.1

