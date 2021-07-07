Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3363BF177
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhGGVmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233020AbhGGVmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:42:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E7861CB9;
        Wed,  7 Jul 2021 21:39:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1FGM-001744-Af; Wed, 07 Jul 2021 17:39:22 -0400
Message-ID: <20210707213922.167218794@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Jul 2021 17:36:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 2/2 v3] tracing/histogram: Update the documentation for the buckets modifier
References: <20210707213623.250212325@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Update both the tracefs README file as well as the histogram.rst to
include an explanation of what the buckets modifier is and how to use it.
Include an example with the wakeup_latency example for both log2 and the
buckets modifiers as there was no existing log2 example.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 92 +++++++++++++++++++++++++++++--
 kernel/trace/trace.c              |  1 +
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index b71e09f745c3..11094ec6e52e 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -77,6 +77,7 @@ Documentation written by Tom Zanussi
 	.syscall    display a syscall id as a system call name
 	.execname   display a common_pid as a program name
 	.log2       display log2 value rather than raw number
+	.buckets=size  display grouping of values rather than raw number
 	.usecs      display a common_timestamp in microseconds
 	=========== ==========================================
 
@@ -228,7 +229,7 @@ Extended error information
   that lists the total number of bytes requested for each function in
   the kernel that made one or more calls to kmalloc::
 
-    # echo 'hist:key=call_site:val=bytes_req' > \
+    # echo 'hist:key=call_site:val=bytes_req.buckets=32' > \
             /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
 
   This tells the tracing system to create a 'hist' trigger using the
@@ -1823,20 +1824,99 @@ and variables defined on other events (see Section 2.2.3 below on
 how that is done using hist trigger 'onmatch' action). Once that is
 done, the 'wakeup_latency' synthetic event instance is created.
 
-A histogram can now be defined for the new synthetic event::
-
-  # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
-        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
-
 The new event is created under the tracing/events/synthetic/ directory
 and looks and behaves just like any other event::
 
   # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
         enable  filter  format  hist  id  trigger
 
+A histogram can now be defined for the new synthetic event::
+
+  # echo 'hist:keys=pid,prio,lat.log2:sort=lat' >> \
+        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+
+The above shows the latency "lat" in a power of 2 grouping.
+
 Like any other event, once a histogram is enabled for the event, the
 output can be displayed by reading the event's 'hist' file.
 
+  # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
+
+  # event histogram
+  #
+  # trigger info: hist:keys=pid,prio,lat.log2:vals=hitcount:sort=lat.log2:size=2048 [active]
+  #
+
+  { pid:       2035, prio:          9, lat: ~ 2^2  } hitcount:         43
+  { pid:       2034, prio:          9, lat: ~ 2^2  } hitcount:         60
+  { pid:       2029, prio:          9, lat: ~ 2^2  } hitcount:        965
+  { pid:       2034, prio:        120, lat: ~ 2^2  } hitcount:          9
+  { pid:       2033, prio:        120, lat: ~ 2^2  } hitcount:          5
+  { pid:       2030, prio:          9, lat: ~ 2^2  } hitcount:        335
+  { pid:       2030, prio:        120, lat: ~ 2^2  } hitcount:         10
+  { pid:       2032, prio:        120, lat: ~ 2^2  } hitcount:          1
+  { pid:       2035, prio:        120, lat: ~ 2^2  } hitcount:          2
+  { pid:       2031, prio:          9, lat: ~ 2^2  } hitcount:        176
+  { pid:       2028, prio:        120, lat: ~ 2^2  } hitcount:         15
+  { pid:       2033, prio:          9, lat: ~ 2^2  } hitcount:         91
+  { pid:       2032, prio:          9, lat: ~ 2^2  } hitcount:        125
+  { pid:       2029, prio:        120, lat: ~ 2^2  } hitcount:          4
+  { pid:       2031, prio:        120, lat: ~ 2^2  } hitcount:          3
+  { pid:       2029, prio:        120, lat: ~ 2^3  } hitcount:          2
+  { pid:       2035, prio:          9, lat: ~ 2^3  } hitcount:         41
+  { pid:       2030, prio:        120, lat: ~ 2^3  } hitcount:          1
+  { pid:       2032, prio:          9, lat: ~ 2^3  } hitcount:         32
+  { pid:       2031, prio:          9, lat: ~ 2^3  } hitcount:         44
+  { pid:       2034, prio:          9, lat: ~ 2^3  } hitcount:         40
+  { pid:       2030, prio:          9, lat: ~ 2^3  } hitcount:         29
+  { pid:       2033, prio:          9, lat: ~ 2^3  } hitcount:         31
+  { pid:       2029, prio:          9, lat: ~ 2^3  } hitcount:         31
+  { pid:       2028, prio:        120, lat: ~ 2^3  } hitcount:         18
+  { pid:       2031, prio:        120, lat: ~ 2^3  } hitcount:          2
+  { pid:       2028, prio:        120, lat: ~ 2^4  } hitcount:          1
+  { pid:       2029, prio:          9, lat: ~ 2^4  } hitcount:          4
+  { pid:       2031, prio:        120, lat: ~ 2^7  } hitcount:          1
+  { pid:       2032, prio:        120, lat: ~ 2^7  } hitcount:          1
+
+  Totals:
+      Hits: 2122
+      Entries: 30
+      Dropped: 0
+
+
+The latency values can also be grouped linearly by a given size with
+the ".buckets" modifier and specify a size (in this case groups of 10).
+
+  # echo 'hist:keys=pid,prio,lat.buckets=10:sort=lat' >> \
+        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+
+  # event histogram
+  #
+  # trigger info: hist:keys=pid,prio,lat.buckets=10:vals=hitcount:sort=lat.buckets=10:size=2048 [active]
+  #
+
+  { pid:       2067, prio:          9, lat: ~ 0-9 } hitcount:        220
+  { pid:       2068, prio:          9, lat: ~ 0-9 } hitcount:        157
+  { pid:       2070, prio:          9, lat: ~ 0-9 } hitcount:        100
+  { pid:       2067, prio:        120, lat: ~ 0-9 } hitcount:          6
+  { pid:       2065, prio:        120, lat: ~ 0-9 } hitcount:          2
+  { pid:       2066, prio:        120, lat: ~ 0-9 } hitcount:          2
+  { pid:       2069, prio:          9, lat: ~ 0-9 } hitcount:        122
+  { pid:       2069, prio:        120, lat: ~ 0-9 } hitcount:          8
+  { pid:       2070, prio:        120, lat: ~ 0-9 } hitcount:          1
+  { pid:       2068, prio:        120, lat: ~ 0-9 } hitcount:          7
+  { pid:       2066, prio:          9, lat: ~ 0-9 } hitcount:        365
+  { pid:       2064, prio:        120, lat: ~ 0-9 } hitcount:         35
+  { pid:       2065, prio:          9, lat: ~ 0-9 } hitcount:        998
+  { pid:       2071, prio:          9, lat: ~ 0-9 } hitcount:         85
+  { pid:       2065, prio:          9, lat: ~ 10-19 } hitcount:          2
+  { pid:       2064, prio:        120, lat: ~ 10-19 } hitcount:          2
+
+  Totals:
+      Hits: 2112
+      Entries: 16
+      Dropped: 0
+
 2.2.3 Hist trigger 'handlers' and 'actions'
 -------------------------------------------
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 14f56e9fa001..8097d5aa8627 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5648,6 +5648,7 @@ static const char readme_msg[] =
 	"\t            .execname   display a common_pid as a program name\n"
 	"\t            .syscall    display a syscall id as a syscall name\n"
 	"\t            .log2       display log2 value rather than raw number\n"
+	"\t            .buckets=size  display values in groups of size rather than raw number\n"
 	"\t            .usecs      display a common_timestamp in microseconds\n\n"
 	"\t    The 'pause' parameter can be used to pause an existing hist\n"
 	"\t    trigger or to start a hist trigger but not log any events\n"
-- 
2.30.2
