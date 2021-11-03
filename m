Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4C444303
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhKCOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbhKCOHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:07:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB7F61106;
        Wed,  3 Nov 2021 14:05:09 +0000 (UTC)
Date:   Wed, 3 Nov 2021 10:05:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [GIT PULL] tracing: Set two for 5.16
Message-ID: <20211103100507.368812ee@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This code was still under testing when I pushed my first set, as people
depended on it. This set has now satisfactorily passed my test suite.

Second set of tracing updates for 5.16:

- osnoise and timerlat updates that will work with the RTLA tool (Real-Time
  Linux Analysis). Specifically it disconnects the work load (threads
  that look for latency) from the tracing instances attached to them,
  allowing for more than one instance to retrieve data from the work load.

- Optimization on division in the trace histogram trigger code to use shift
  and multiply when possible. Also added documentation.

- Fix prototype to my_direct_func in direct ftrace trampoline sample code.


Please pull the latest trace-v5.16-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-2

Tag SHA1: d17edd07178249c50f80305c507626f15fbf363a
Head SHA1: 67d4f6e3bf5dddced226fbf19704cdbbb0c98847


Daniel Bristot de Oliveira (9):
      tracing/osnoise: Do not follow tracing_cpumask
      tracing/osnoise: Improve comments about barrier need for NMI callbacks
      tracing/osnoise: Split workload start from the tracer start
      tracing/osnoise: Use start/stop_per_cpu_kthreads() on osnoise_cpus_write()
      tracing/osnoise: Support a list of trace_array *tr
      tracing/osnoise: Remove TIMERLAT ifdefs from inside functions
      tracing/osnoise: Allow multiple instances of the same tracer
      tracing/osnoise: Remove STACKTRACE ifdefs from inside functions
      tracing/osnoise: Remove PREEMPT_RT ifdefs from inside functions

Jiri Olsa (1):
      ftrace/samples: Add missing prototype for my_direct_func

Kalesh Singh (4):
      tracing/histogram: Optimize division by constants
      tracing/histogram: Update division by 0 documentation
      tracing/histogram: Document hist trigger variables
      tracing/selftests: Add tests for hist trigger expression parsing

----
 Documentation/trace/histogram.rst                  |   3 +-
 kernel/trace/trace.c                               |  11 +
 kernel/trace/trace_events_hist.c                   | 105 +++-
 kernel/trace/trace_osnoise.c                       | 615 +++++++++++++++------
 samples/ftrace/ftrace-direct-multi.c               |   2 +
 .../test.d/trigger/trigger-hist-expressions.tc     |  63 +++
 6 files changed, 616 insertions(+), 183 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
---------------------------
