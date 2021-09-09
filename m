Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254B0405735
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245482AbhIINcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357722AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5015661186;
        Thu,  9 Sep 2021 13:06:03 +0000 (UTC)
Date:   Thu, 9 Sep 2021 09:06:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Julio Faracco <jcfaracco@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Qiang.Zhang" <qiang.zhang@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [GIT PULL] tracing: More updates for 5.15
Message-ID: <20210909090601.43810362@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

More tracing updates for 5.15:

 - Add migrate-disable counter to tracing header

 - Fix error handling in event probes

 - Fix missed unlock in osnoise in error path

 - Fix merge issue with tools/bootconfig

 - Clean up bootconfig data when init memory is removed

 - Fix bootconfig to loop only on subkeys

 - Have kernel command lines override bootconfig options

 - Increase field counts for synthetic events

 - Have histograms dynamic allocate event elements to save space

 - Fixes in testing and documentation


Please pull the latest trace-v5.15-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-2

Tag SHA1: 44f8e867f9af1f79c16e74557077927462bb0ab3
Head SHA1: cfd799837dbc48499abb05d1891b3d9992354d3a


Artem Bityutskiy (1):
      tracing: synth events: increase max fields count

Dan Carpenter (1):
      tracing: Fix some alloc_event_probe() error handling bugs

Julio Faracco (1):
      bootconfig: Fix missing return check of xbc_node_compose_key function

Masami Hiramatsu (6):
      init: bootconfig: Remove all bootconfig data when the init memory is removed
      init/bootconfig: Reorder init parameter from bootconfig and cmdline
      docs: bootconfig: Add how to use bootconfig for kernel parameters
      tools/bootconfig: Fix tracing_on option checking in ftrace2bconf.sh
      tools/bootconfig: Show whole test command for each test case
      tracing/boot: Fix to loop on only subkeys

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
 kernel/trace/trace_boot.c                          |  6 ++--
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
 14 files changed, 122 insertions(+), 39 deletions(-)
---------------------------
