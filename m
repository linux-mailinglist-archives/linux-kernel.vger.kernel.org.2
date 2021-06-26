Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF03B4EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhFZNIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhFZNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E782C61C3B;
        Sat, 26 Jun 2021 13:05:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx809-000Enp-Vd; Sat, 26 Jun 2021 09:05:37 -0400
Message-ID: <20210626130537.815513044@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 18/24] trace: Add __print_ns_to_secs() and __print_ns_without_secs() helpers
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

To have nanosecond output displayed in a more human readable format, its
nicer to convert it to a seconds format (XXX.YYYYYYYYY). The problem is that
to do so, the numbers must be divided by NSEC_PER_SEC, and moded too. But as
these numbers are 64 bit, this can not be done simply with '/' and '%'
operators, but must use do_div() instead.

Instead of performing the expensive do_div() in the hot path of the
tracepoint, it is more efficient to perform it during the output phase. But
passing in do_div() can confuse the parser, and do_div() doesn't work
exactly like a normal C function. It modifies the number in place, and we
don't want to modify the actual values in the ring buffer.

Two helper functions are now created:

  __print_ns_to_secs() and __print_ns_without_secs()

They both take a value of nanoseconds, and the former will return that
number divided by NSEC_PER_SEC, and the latter will mod it with NSEC_PER_SEC
giving a way to print a nice human readable format:

 __print_fmt("time=%llu.%09u",
	__print_ns_to_secs(REC->nsec_val),
	__print_ns_without_secs(REC->nsec_val))

Link: https://lkml.kernel.org/r/e503b903045496c4ccde52843e1e318b422f7a56.1624372313.git.bristot@redhat.com

Cc: Phil Auld <pauld@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kate Carcia <kcarcia@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8268bf747d6f..acc17194c160 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -358,6 +358,21 @@ TRACE_MAKE_SYSTEM_STR();
 	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
 				 rowsize, groupsize, buf, len, ascii)
 
+#undef __print_ns_to_secs
+#define __print_ns_to_secs(value)			\
+	({						\
+		u64 ____val = (u64)(value);		\
+		do_div(____val, NSEC_PER_SEC);		\
+		____val;				\
+	})
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(value)			\
+	({						\
+		u64 ____val = (u64)(value);		\
+		(u32) do_div(____val, NSEC_PER_SEC);	\
+	})
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 static notrace enum print_line_t					\
@@ -736,6 +751,16 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __print_array
 #undef __print_hex_dump
 
+/*
+ * The below is not executed in the kernel. It is only what is
+ * displayed in the print format for userspace to parse.
+ */
+#undef __print_ns_to_secs
+#define __print_ns_to_secs(val) (val) / 1000000000UL
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(val) (val) % 1000000000UL
+
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
 
-- 
2.30.2
