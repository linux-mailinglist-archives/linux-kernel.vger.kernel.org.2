Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC733E9BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhHLBOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhHLBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:14:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C756104F;
        Thu, 12 Aug 2021 01:13:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mDzIA-003pEe-FA; Wed, 11 Aug 2021 21:13:54 -0400
Message-ID: <20210812011250.954353252@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Aug 2021 21:12:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 0/7] tracing: More fixes for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes and clean ups to tracing:

- Fix warning for use of "main" variable in osnoise tracer

- Fix header alignment when PREEMPT_RT is enabled for osnoise tracer

- Inject "stop" event to see where osnoise stopped the trace

- Define DYNAMIC_FTRACE_WITH_ARGS as some code had an #ifdef for it

- Fix erroneous message for bootconfig cmdline parameter

- Fix crash caused by not found variable in histograms


Daniel Bristot de Oliveira (4):
      trace/osnoise: Rename main variable to tracer_main
      trace/osnoise: Add a header with PREEMPT_RT additional fields
      trace/timerlat: Add a header with PREEMPT_RT additional fields
      trace/osnoise: Print a stop tracing message

Lukas Bulwahn (1):
      tracing: define needed config DYNAMIC_FTRACE_WITH_ARGS

Masami Hiramatsu (1):
      init: Suppress wrong warning for bootconfig cmdline parameter

Steven Rostedt (VMware) (1):
      tracing / histogram: Fix NULL pointer dereference on strcmp() on NULL event name

----
 init/main.c                      |  9 ++++--
 kernel/trace/Kconfig             |  5 ++++
 kernel/trace/trace_events_hist.c |  2 ++
 kernel/trace/trace_osnoise.c     | 62 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 72 insertions(+), 6 deletions(-)
