Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A497C4436FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhKBUOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhKBUOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:14:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BC361053;
        Tue,  2 Nov 2021 20:11:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mi08S-001jIH-L6;
        Tue, 02 Nov 2021 16:11:56 -0400
Message-ID: <20211102201126.559641540@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Nov 2021 16:11:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/14] tracing: Updates for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

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
