Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFF3A7A99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFOJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231503AbhFOJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623749392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfZs1T64mXM3Zq7p6ZsbJ6lpb0Tom2b/OOqSUKAQnS4=;
        b=hDhrQDn4rtDdSuGcuNTgUuDGbSzWj2qDcPdWu6yACp2FYbr3vyV062qypbcg6RtDnZuhHP
        auBjSI9+273/gKehhqTar2Q4Lz44s2/ViAx2jfrtJUs3TpVLswVzyPTD0tZu3M8uG4ncDy
        w/Be2HDRdJy0PkTiwfrEu0HBgf4rT0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-q7ltiwDCNhOxX07hC7bQvw-1; Tue, 15 Jun 2021 05:29:51 -0400
X-MC-Unique: q7ltiwDCNhOxX07hC7bQvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E819F92D;
        Tue, 15 Jun 2021 09:29:49 +0000 (UTC)
Received: from x1.com (ovpn-113-40.rdu2.redhat.com [10.10.113.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 819E05D6AD;
        Tue, 15 Jun 2021 09:29:45 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 09/12] trace: Add __print_ns_to_secs() and __print_ns_without_secs() helpers
Date:   Tue, 15 Jun 2021 11:28:48 +0200
Message-Id: <1c432d129da06c1c1ccc9051e39f9b75c2219cd3.1623746916.git.bristot@redhat.com>
In-Reply-To: <cover.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
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
2.31.1

