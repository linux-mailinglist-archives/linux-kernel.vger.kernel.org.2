Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465E240FD11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbhIQPsp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Sep 2021 11:48:45 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:20270 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343606AbhIQPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:48:07 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-I7gHnH5TOGuCnP9Tr-AKZA-1; Fri, 17 Sep 2021 11:46:41 -0400
X-MC-Unique: I7gHnH5TOGuCnP9Tr-AKZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4968B192376A;
        Fri, 17 Sep 2021 15:46:40 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.22.17.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A0CA5D9C6;
        Fri, 17 Sep 2021 15:46:37 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 16/19] rtla: Add rtla osnoise hist documentation
Date:   Fri, 17 Sep 2021 17:43:59 +0200
Message-Id: <a6dc18ad89c52ee0c034e60d78c0a0067474af53.1631889858.git.bristot@kernel.org>
In-Reply-To: <cover.1631889858.git.bristot@kernel.org>
References: <cover.1631889858.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Man page for rtla osnoise hist mode.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../rtla/Documentation/rtla-osnoise-hist.txt  | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 tools/tracing/rtla/Documentation/rtla-osnoise-hist.txt

diff --git a/tools/tracing/rtla/Documentation/rtla-osnoise-hist.txt b/tools/tracing/rtla/Documentation/rtla-osnoise-hist.txt
new file mode 100644
index 000000000000..56d98ab10387
--- /dev/null
+++ b/tools/tracing/rtla/Documentation/rtla-osnoise-hist.txt
@@ -0,0 +1,117 @@
+rtla-osnoise-hist(1)
+===================
+
+NAME
+----
+rtla-osnoise-hist - Display a histogram of the osnoise tracer samples
+
+SYNOPSIS
+--------
+*rtla osnoise hist* ['OPTIONS']
+
+DESCRIPTION
+-----------
+The *rtla-osnoise-hist(1)* tool is an interface for the osnoise tracer. The
+osnoise tracer dispatches a kernel thread per-cpu. These threads read the
+time in a loop while with preemption, SoftIRQs and IRQs enabled, thus
+allowing all the sources of osnoise during its execution. The osnoise threads
+take note of the delta between each time read. Anytime the delta between two
+consecutive reads of the timer is higher than a 'threshold,' an
+*osnoise:sample_threshold* event is generated reporting the detected noise.
+
+The *rtla-osnoise-hist(1)* tool collects all *osnoise:sample_threshold*
+occurrence in a histogram, displaying the results in a user-friendly way.
+The tool also allows many configurations of the osnoise tracer and the
+collection of the tracer output.
+
+OPTIONS
+-------
+*-h*, *--help*::
+Print help menu.
+*-p*, *--period* 'us'::
+Set the osnoise tracer period in microseconds.
+*-r*, *--runtime* 'us'::
+Set the osnoise tracer runtime in microseconds.
+*-s*, *--stop* 'us'::
+Stop the trace if a single sample is higher than the argument in microseconds.
+If -T is set, it will also save the trace to the output.
+*-S*, *--stop-total* 'us'::
+Stop the trace if the total sample is higher than the argument in microseconds.
+If -T is set, it will also save the trace to the output.
+*-c*, *--cpus* 'cpu-list'::
+Set the osnoise tracer to run the sample threads in the cpu-list.
+*-d*, *--duration* 'time[s|m|h|d]'::
+Set the duration of the session.
+*-T*, *--trace*['=file']::
+Save the stopped trace to ['file|osnoise_trace.txt'].
+*-P*, *--priority* 'o:prio|r:prio|f:prio|d:runtime:period'::
+Set scheduling parameters to the osnoise tracer threads, the format to
+set the priority are:
+  - 'o:prio' - use SCHED_OTHER with 'prio';
+  - 'r:prio' - use SCHED_RR with 'prio';
+  - 'f:prio' - use SCHED_FIFO with 'prio';
+  - 'd:runtime[us|ms|s]:period[us|ms|s]' - use SCHED_DEADLINE with
+'runtime' and 'period' in nanoseconds.
+
+*-b*, --bucket_size 'N'::
+Set the histogram bucket size (default 1).
+*-e*, --entries 'N'::
+Set the number of entries of the histogram (default 256).
+*--no-header*::
+Do not print header.
+*--no-summary*::
+Do not print summary.
+*--no-index*::
+Do not print index.
+*--skip-zeros*::
+Skip zero only entries.
+
+EXAMPLE
+-------
+In the example below, osnoise tracer threads are set to run with real-time
+priority 'FIFO:1', on CPUs '0-11', for '900ms' at each period ('1s' by
+default). The reason for reducing the runtime is to avoid starving the rtla
+tool. The tool is also set to run for 'one minute.' The output histogram is
+set to group outputs in buckets of '10 us' and '25' entries.
+
+-------------------------------------------------------
+[root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M --skip-zeros -b 10 -e 25
+# RTLA osnoise histogram
+# Time unit is microseconds (us)
+# Duration:   0 00:01:00
+Index   CPU-000   CPU-001   CPU-002   CPU-003   CPU-004   CPU-005   CPU-006   CPU-007   CPU-008   CPU-009   CPU-010   CPU-011
+0         42982     46287     51779     53740     52024     44817     49898     36500     50408     50128     49523     52377
+10        12224      8356      2912       878      2667     10155      4573     18894      4214      4836      5708      2413
+20            8         5        12         2        13        24        20        41        29        53        39        39
+30            1         1         0         0        10         3         6        19        15        31        30        38
+40            0         0         0         0         0         4         2         7         2         3         8        11
+50            0         0         0         0         0         0         0         0         0         1         1         2
+over:         0         0         0         0         0         0         0         0         0         0         0         0
+count:    55215     54649     54703     54620     54714     55003     54499     55461     54668     55052     55309     54880
+min:          0         0         0         0         0         0         0         0         0         0         0         0
+avg:          0         0         0         0         0         0         0         0         0         0         0         0
+max:         30        30        20        20        30        40        40        40        40        50        50        50
+-------------------------------------------------------
+
+SEE ALSO
+--------
+_rtla-osnoise(1)_, _rtla-osnoise-top_(1)
+
+Osnoise tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+
+AUTHOR
+------
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+REPORTING BUGS
+--------------
+Report bugs to <lkml@vger.kernel.org>
+
+LICENSE
+-------
+rtla is Free Software licensed under the GNU GPLv2
+
+COPYING
+-------
+Copyright \(C) 2021 Red Hat, Inc. Free use of this software is granted under
+the terms of the GNU Public License (GPL).
-- 
2.31.1

