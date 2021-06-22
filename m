Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150BD3B07BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhFVOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231445AbhFVOqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624373056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4tVsty5sYaIEHvOKmUYgunGdqYa0UCvup1lP+eoTXM=;
        b=S/4yG+bk0Xs4aKfH+zRK2kDS1syo9E4LBidiOBpsK0XltO+4wiJtDu9EA/s6B0kp96BTnx
        qDPMUyoABHN7Z72zuKLTof65Z0NWEgyNhNfPaaFfh4YTWqv/Q+aXYoFBSg70Tl5ykt+W/t
        AsSWbrcpe5+om8c9OVZ8YdMAkl/ap+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-0MnCeMI6MbSgB1rb9ExXpg-1; Tue, 22 Jun 2021 10:44:14 -0400
X-MC-Unique: 0MnCeMI6MbSgB1rb9ExXpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D85FF800D62;
        Tue, 22 Jun 2021 14:44:11 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16B355D9F0;
        Tue, 22 Jun 2021 14:43:51 +0000 (UTC)
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
Subject: [PATCH V5 07/14] trace/hwlat: Remove printk from sampling loop
Date:   Tue, 22 Jun 2021 16:42:25 +0200
Message-Id: <9d77c34869748aa105e965c769d24642914eea3a.1624372313.git.bristot@redhat.com>
In-Reply-To: <cover.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index c3a41ba61052..8756ab24c132 100644
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

