Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFED3A7A96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFOJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbhFOJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623749388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZVlLGY0kqQAYmVdD+6nEDNmFy2iD2bHg+txa/b3qk8=;
        b=MY6mc6h4umwaSFpK6efuz8T9HM1KzxrPZEwQC64ELcT7XMALOdKNy9C8OhiQ6tQYoIFwVv
        ZG/OJeW8RrR13ScqKzLF59sTv6XoTGJqYl27vAb3oOSEFdV7B2T5f3ETjDXdt4l2Vm3ahX
        DcuThrPgQJqdtl75GAM9s/wrOkmhYaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-NaBsZni7PTKROpxqWbz96Q-1; Tue, 15 Jun 2021 05:29:46 -0400
X-MC-Unique: NaBsZni7PTKROpxqWbz96Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D359100C660;
        Tue, 15 Jun 2021 09:29:45 +0000 (UTC)
Received: from x1.com (ovpn-113-40.rdu2.redhat.com [10.10.113.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2E1D5D6AD;
        Tue, 15 Jun 2021 09:29:40 +0000 (UTC)
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
Subject: [PATCH V4 08/12] trace/hwlat: Remove printk from sampling loop
Date:   Tue, 15 Jun 2021 11:28:47 +0200
Message-Id: <ed452f4329d99cce4581417bb484f89759f302e7.1623746916.git.bristot@redhat.com>
In-Reply-To: <cover.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwlat has some time operation checks on the sample loop, and it is
currently using pr_err (printk) to report them. The problem is that
this can lead the system to an unresponsible state due to an overflow of
printk messages. This problem can be mitigated by writing the error
message to the trace buffer.

Remove the printk messages from the sampling loop, switching the to
messages in the trace buffer.

No functional change.

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
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_hwlat.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 0ab6acf6ae9a..86e8541d4331 100644
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
2.31.1

