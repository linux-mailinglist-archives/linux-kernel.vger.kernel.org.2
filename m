Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFD403FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352040AbhIHTVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350507AbhIHTVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96981611C0;
        Wed,  8 Sep 2021 19:20:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36v-0014WF-9E; Wed, 08 Sep 2021 15:19:53 -0400
Message-ID: <20210908191851.381347939@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:18:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Julio Faracco <jcfaracco@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Qiang.Zhang" <qiang.zhang@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 00/12] tracing: More updates for 5.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


More tracing updates for 5.15:

 - Add migrate-disable counter to tracing header

 - Fix error handling in event probes

 - Fix missed unlock in osnoise in error path

 - Fix merge issue with tools/bootconfig

 - Clean up bootconfig data when init memory is removed

 - Have kernel command lines override bootconfig options

 - Increase field counts for synthetic events

 - Have histograms dynamic allocate event elements to save space

 - Fixes in testing and documentation


Artem Bityutskiy (1):
      tracing: synth events: increase max fields count

Dan Carpenter (1):
      tracing: Fix some alloc_event_probe() error handling bugs

Julio Faracco (1):
      bootconfig: Fix missing return check of xbc_node_compose_key function

Masami Hiramatsu (5):
      init: bootconfig: Remove all bootconfig data when the init memory is removed
      init/bootconfig: Reorder init parameter from bootconfig and cmdline
      docs: bootconfig: Add how to use bootconfig for kernel parameters
      tools/bootconfig: Fix tracing_on option checking in ftrace2bconf.sh
      tools/bootconfig: Show whole test command for each test case

Qiang.Zhang (1):
      tracing/osnoise: Fix missed cpus_read_unlock() in start_per_cpu_kthreads()

Steven Rostedt (VMware) (1):
      selftests/ftrace: Exclude "(fault)" in testing add/remove eprobe events

Thomas Gleixner (1):
      tracing: Add migrate-disabled counter to tracing output.

Tom Zanussi (1):
      tracing: Dynamically allocate the per-elt hist_elt_data array

----
 Documentation/admin-guide/bootconfig.rst           | 39 +++++++++++++++++++++-
 init/main.c                                        | 37 ++++++++++++++------
 kernel/trace/trace.c                               | 26 +++++++++++----
 kernel/trace/trace_eprobe.c                        |  5 +--
 kernel/trace/trace_events.c                        |  1 +
 kernel/trace/trace_events_hist.c                   | 14 ++++++--
 kernel/trace/trace_osnoise.c                       |  6 ++--
 kernel/trace/trace_output.c                        | 11 ++++--
 kernel/trace/trace_synth.h                         |  2 +-
 tools/bootconfig/main.c                            |  4 ++-
 tools/bootconfig/scripts/ftrace2bconf.sh           |  4 +--
 tools/bootconfig/test-bootconfig.sh                |  4 +--
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    |  2 +-
 13 files changed, 119 insertions(+), 36 deletions(-)
