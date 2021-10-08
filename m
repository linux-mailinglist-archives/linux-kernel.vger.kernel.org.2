Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2682426666
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhJHJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236335AbhJHJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUb/i9RBmi1Fh2lX7yds41KHjfH6nx836x27H5fnG4k=;
        b=SM6IO0K7+FnWRglD3StwEfyVuKraT9nXkD321ZV3nmeoOC+CGKo6AWxYRs6fzdE0VNF8es
        Ofb0wHDQ3j5ekpiGgtkCwzwe+ZXnSLjLEorbhRTIQAEmm+NRn/mOvs6pJ0CnD3CiRuxszT
        eNJXPcDlBQHd8s1SIYpZBLq7yJmYQ7Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-D2LVGXZvMaucusRd26a3Gg-1; Fri, 08 Oct 2021 05:14:02 -0400
X-MC-Unique: D2LVGXZvMaucusRd26a3Gg-1
Received: by mail-wr1-f69.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so3131003wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUb/i9RBmi1Fh2lX7yds41KHjfH6nx836x27H5fnG4k=;
        b=ET2duQA5etyBkiKgSzLn6Vl/taqAL3ycYdqlZ4R61iA774y9PoggqG3wh9dJ2ONQNS
         OMd3rElFqW8opq8LsLDtXL9HUzLJEMiZChK5L2WoylSV0jZmG7/kUw5OsP3l/XlQn4rN
         YJQEi6BTH69bvmCIYPYbphrx/Cb5uB0h8tAykwrIuhQWjitMcOsOSy8uRFywyLrq+TuZ
         /ncchMvwiSoS8a2qwcYCiu4F8j+tA46ZMNGihyxtJT8oWH71lbH4EJVszfmeero0txdj
         YI5HNfkNVfQrKxRRek9AOV5Bfga49W6bmXP5JHMHN0/3DuyyS/GTF7RVl2whnTq+8qld
         +W/w==
X-Gm-Message-State: AOAM531ZFIFEYF2o8PmM2wUnBxK/fIf5j+1g3DMMUbdPL5FpkL/8+oUB
        JK7qrfDkiwBCwPzhKg5m914ppIVXW557QMfqaqDrlDq5CFh5k+R3eVZepKZkAmfJBpral3HkGs7
        xNPbU7Oai6g48TSpNxleN5ajO
X-Received: by 2002:adf:c986:: with SMTP id f6mr2691102wrh.216.1633684441555;
        Fri, 08 Oct 2021 02:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz74rdA9MIuzk3OP1VjqcSnfHAvyHf5rVZuc+qGDMTLv6UmeZvBAgk9qtrFDqvInkOO8GT8WA==
X-Received: by 2002:adf:c986:: with SMTP id f6mr2691081wrh.216.1633684441342;
        Fri, 08 Oct 2021 02:14:01 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k9sm1814581wrz.22.2021.10.08.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:14:01 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 4/8] tracing: Add trampoline/graph selftest
Date:   Fri,  8 Oct 2021 11:13:32 +0200
Message-Id: <20211008091336.33616-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding selftest for checking that direct trampoline can
co-exist together with graph tracer on same function.

This is supported for CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
config option, which is defined only for x86_64 for now.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/trace_selftest.c | 54 ++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf7ef194005..917b7e3bf1ec 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -750,6 +750,8 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
+noinline __noclone static void trace_direct_tramp(void) { }
+
 /*
  * Pretty much the same than for the function tracer from which the selftest
  * has been borrowed.
@@ -760,6 +762,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 {
 	int ret;
 	unsigned long count;
+	char *func_name __maybe_unused;
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (ftrace_filter_param) {
@@ -808,8 +811,57 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-	/* Don't test dynamic tracing, the function tracer already did */
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	tracing_reset_online_cpus(&tr->array_buffer);
+	set_graph_array(tr);
+
+	/*
+	 * Some archs *cough*PowerPC*cough* add characters to the
+	 * start of the function names. We simply put a '*' to
+	 * accommodate them.
+	 */
+	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
+	ftrace_set_global_filter(func_name, strlen(func_name), 1);
+
+	/*
+	 * Register direct function together with graph tracer
+	 * and make sure we get graph trace.
+	 */
+	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
+				     (unsigned long) trace_direct_tramp);
+	if (ret)
+		goto out;
+
+	ret = register_ftrace_graph(&fgraph_ops);
+	if (ret) {
+		warn_failed_init_tracer(trace, ret);
+		goto out;
+	}
+
+	DYN_FTRACE_TEST_NAME();
+
+	count = 0;
+
+	tracing_stop();
+	/* check the trace buffer */
+	ret = trace_test_buffer(&tr->array_buffer, &count);
+
+	unregister_ftrace_graph(&fgraph_ops);
+
+	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
+				       (unsigned long) trace_direct_tramp);
+	if (ret)
+		goto out;
+
+	tracing_start();
 
+	if (!ret && !count) {
+		ret = -1;
+		goto out;
+	}
+#endif
+
+	/* Don't test dynamic tracing, the function tracer already did */
 out:
 	/* Stop it if we failed */
 	if (ret)
-- 
2.31.1

