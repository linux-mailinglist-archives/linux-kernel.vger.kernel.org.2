Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BF38121A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhENUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232491AbhENUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621025541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdLfPCTH/k2y9ae9077TQAvYD1PaILS/qKOK1BGuXAA=;
        b=UiytKyzlXOts1HpkFncwzMXTfRB9O1mdj6cnP/6+uHrxVuurIXa2DlWDOpvNbxIIcPNb55
        w9QyW9suYTBB8aEATe21UmxGkUc4R5VX4L/VkyNNEJ0Wg1Iar8ybntv1v1p9oqJHGnhc9e
        sCPzfHtn96lwFsng0YcSzPaJeR9Qu9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-_r9hK2y8ONWuyCTCiBlSSA-1; Fri, 14 May 2021 16:52:19 -0400
X-MC-Unique: _r9hK2y8ONWuyCTCiBlSSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0901D1854E24;
        Fri, 14 May 2021 20:52:18 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECA541A868;
        Fri, 14 May 2021 20:52:07 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: [PATCH V3 7/9] tracing: Add __print_ns_to_secs() and __print_ns_without_secs() helpers
Date:   Fri, 14 May 2021 22:51:16 +0200
Message-Id: <2c59beee3b36b15592bfbb9f26dee7f8b55fd814.1621024265.git.bristot@redhat.com>
In-Reply-To: <cover.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 include/trace/trace_events.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8268bf747d6f..248090415b97 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -358,6 +358,21 @@ TRACE_MAKE_SYSTEM_STR();
 	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
 				 rowsize, groupsize, buf, len, ascii)
 
+#undef __print_ns_to_secs
+#define __print_ns_to_secs(value)			\
+	({						\
+		u64 ____val = (u64)value;		\
+		do_div(____val, NSEC_PER_SEC);		\
+		____val;				\
+	})
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(value)			\
+	({						\
+		u64 ____val = (u64)value;		\
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
+#define __print_ns_to_secs(val) val / 1000000000UL
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(val) val % 1000000000UL
+
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
 
-- 
2.26.3

