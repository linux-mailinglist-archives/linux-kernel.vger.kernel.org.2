Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77543B713
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhJZQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234516AbhJZQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A516109E;
        Tue, 26 Oct 2021 16:23:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEq-000qQ6-Di;
        Tue, 26 Oct 2021 12:23:48 -0400
Message-ID: <20211026162348.251960008@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: [for-next][PATCH 05/12] tracing/doc: Fix typos on the timerlat tracer documentation
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Fixes a series of typos in the timerlat doc.

Link: https://lkml.kernel.org/r/d3763eb376603890baab908141de6660ba18fff8.1634308385.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: a955d7eac177 ("trace: Add timerlat tracer")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/timerlat-tracer.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index c7cbb557aee7..64d1fe6e9b93 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -3,7 +3,7 @@ Timerlat tracer
 ###############
 
 The timerlat tracer aims to help the preemptive kernel developers to
-find souces of wakeup latencies of real-time threads. Like cyclictest,
+find sources of wakeup latencies of real-time threads. Like cyclictest,
 the tracer sets a periodic timer that wakes up a thread. The thread then
 computes a *wakeup latency* value as the difference between the *current
 time* and the *absolute time* that the timer was set to expire. The main
@@ -50,14 +50,14 @@ The second is the *timer latency* observed by the thread. The ACTIVATION
 ID field serves to relate the *irq* execution to its respective *thread*
 execution.
 
-The *irq*/*thread* splitting is important to clarify at which context
+The *irq*/*thread* splitting is important to clarify in which context
 the unexpected high value is coming from. The *irq* context can be
-delayed by hardware related actions, such as SMIs, NMIs, IRQs
-or by a thread masking interrupts. Once the timer happens, the delay
+delayed by hardware-related actions, such as SMIs, NMIs, IRQs,
+or by thread masking interrupts. Once the timer happens, the delay
 can also be influenced by blocking caused by threads. For example, by
-postponing the scheduler execution via preempt_disable(), by the
-scheduler execution, or by masking interrupts. Threads can
-also be delayed by the interference from other threads and IRQs.
+postponing the scheduler execution via preempt_disable(), scheduler
+execution, or masking interrupts. Threads can also be delayed by the
+interference from other threads and IRQs.
 
 Tracer options
 ---------------------
@@ -68,14 +68,14 @@ directory. The timerlat configs are:
 
  - cpus: CPUs at which a timerlat thread will execute.
  - timerlat_period_us: the period of the timerlat thread.
- - osnoise/stop_tracing_us: stop the system tracing if a
+ - stop_tracing_us: stop the system tracing if a
    timer latency at the *irq* context higher than the configured
    value happens. Writing 0 disables this option.
  - stop_tracing_total_us: stop the system tracing if a
-   timer latency at the *thread* context higher than the configured
+   timer latency at the *thread* context is higher than the configured
    value happens. Writing 0 disables this option.
- - print_stack: save the stack of the IRQ ocurrence, and print
-   it afte the *thread context* event".
+ - print_stack: save the stack of the IRQ occurrence, and print
+   it after the *thread context* event".
 
 timerlat and osnoise
 ----------------------------
@@ -95,7 +95,7 @@ For example::
       timerlat/5-1035    [005] .......   548.771104: #402268 context thread timer_latency     39960 ns
 
 In this case, the root cause of the timer latency does not point to a
-single cause, but to multiple ones. Firstly, the timer IRQ was delayed
+single cause but to multiple ones. Firstly, the timer IRQ was delayed
 for 13 us, which may point to a long IRQ disabled section (see IRQ
 stacktrace section). Then the timer interrupt that wakes up the timerlat
 thread took 7597 ns, and the qxl:21 device IRQ took 7139 ns. Finally,
-- 
2.33.0
