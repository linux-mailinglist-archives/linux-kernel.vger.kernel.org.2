Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0203B4EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFZNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhFZNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73C261C37;
        Sat, 26 Jun 2021 13:05:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx809-000EnH-Pc; Sat, 26 Jun 2021 09:05:37 -0400
Message-ID: <20210626130537.639504615@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:21 -0400
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
Subject: [for-next][PATCH 17/24] trace/hwlat: Remove printk from sampling loop
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

hwlat has some time operation checks on the sample loop, and it is
currently using pr_err (printk) to report them. The problem is that
this can lead the system to an unresponsible state due to an overflow of
printk messages. This problem can be mitigated by writing the error
message to the trace buffer.

Remove the printk messages from the sampling loop, switching the to
messages in the trace buffer.

No functional change.

Link: https://lkml.kernel.org/r/9d77c34869748aa105e965c769d24642914eea3a.1624372313.git.bristot@redhat.com

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
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 44f46bc1140f..a625bfdb844e 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -182,6 +182,15 @@ void trace_hwlat_callback(bool enter)
 		kdata->nmi_count++;
 }
 
+/*
+ * hwlat_err - report a hwlat error.
+ */
+#define hwlat_err(msg) ({							\
+	struct trace_array *tr = hwlat_trace;					\
+										\
+	trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_, msg);	\
+})
+
 /**
  * get_sample - sample the CPU TSC and look for likely hardware latencies
  *
@@ -225,7 +234,7 @@ static int get_sample(void)
 			outer_diff = time_to_us(time_sub(t1, last_t2));
 			/* This shouldn't happen */
 			if (outer_diff < 0) {
-				pr_err(BANNER "time running backwards\n");
+				hwlat_err(BANNER "time running backwards\n");
 				goto out;
 			}
 			if (outer_diff > outer_sample)
@@ -237,7 +246,7 @@ static int get_sample(void)
 
 		/* Check for possible overflows */
 		if (total < last_total) {
-			pr_err("Time total overflowed\n");
+			hwlat_err("Time total overflowed\n");
 			break;
 		}
 		last_total = total;
@@ -253,7 +262,7 @@ static int get_sample(void)
 
 		/* This shouldn't happen */
 		if (diff < 0) {
-			pr_err(BANNER "time running backwards\n");
+			hwlat_err(BANNER "time running backwards\n");
 			goto out;
 		}
 
-- 
2.30.2
