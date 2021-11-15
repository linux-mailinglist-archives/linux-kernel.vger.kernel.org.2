Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E83450244
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhKOKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237556AbhKOKW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:22:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 046F461B4D;
        Mon, 15 Nov 2021 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636971603;
        bh=3TBXQjRrkyPfVWIL3nG9LISDqGO8K9tJRnSraEB9QIA=;
        h=From:To:Cc:Subject:Date:From;
        b=har91j3g+0DNjOg5LcjvOge1FU6JNgE5NaUXPnzzcC8C0fz7ZKEvlO3hC6CUjDKTg
         tJcMxc2PJWINq2hberwKwzssihcYrke2/cF/o2kj71kvmucDJlfiTgreFG9aBxVWfw
         v7bXwZLjFvWVM7N/eAZK5l870bEpH0pLrgzry/PybsB1rtKUr+rpiN8OUeb5balu1L
         P4c8tq0nsvibH66mtDnXn5pW09lPDkhvX1OMjDa808NhmNUzxVgLsC0XrPhiZPYYFT
         XTGgHGksx9Y0hAUiruEYsP0OY+rYAd9wa+JSJblCKMUfwo8eKPTj/KcSpqLsPXvPDF
         I61ygPCKus6Lw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/5] tracing: Add __rel_loc support
Date:   Mon, 15 Nov 2021 19:19:59 +0900
Message-Id: <163697159970.131454.2661507704362599471.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Beau,

(Sorry, if you get the same copy. I resend this because I made a typo
 on the mail address.)

Here is a series of patches to add support of '__rel_loc' relative
dynamic array attribute support. Note that this is only for the
kernel side code, user space tools might need to be updated for
decoding '__rel_loc' too.
There are 2 patches for libtraceevent and perftools, but not those
are not tested yet. I added it for review.

Here are 3 patches, [1/5] is the main and required patch, which
updates the event filter, histogram, and inject for __rel_loc.

[2/5] and [3/5] are for testing. I think those are no needed to
be merged. I just made it for the testing. [4/5] is updating
libtraceevent, which allows libtraceevent user to decode the
__rel_loc via libtraceevent API. Since perf-tools decodes the
event by itself, it needs [5/5]. (Note that I haven't tested
fully yet)

Steve, please tell me if I missed some parts or features which
need to decode the dynamic string or data.


The __rel_loc
-----

The '__data_loc' is used for encoding the dynamic data location on
the trace event record. But '__data_loc' is not useful if the writer
doesn't know the event header (e.g. user event), because it records
the dynamic data offset from the entry of the record, not the field
itself.

This new '__rel_loc' attribute encodes the data location relatively
from the next of the field. For example, when there is a record like
below (the number in the parentheses is the size of fields)

 |header(N)|common(M)|fields(K)|__data_loc(4)|fields(L)|data(G)|

In this case, '__data_loc' field will be

 __data_loc = (G << 16) | (N+M+K+4+L)

If '__rel_loc' is used, this will be

 |header(N)|common(M)|fields(K)|__rel_loc(4)|fields(L)|data(G)|

where

 __rel_loc = (G << 16) | (L)

(Because there is L bytes after the '__rel_loc' attribute field)

This is relatively easy (and no need to consider the kernel header
change) when the event data fields are composed by user who doesn't
know header and common fields.


Test Event Injection
----
/ # modprobe trace-events-sample.ko
/ # cd /sys/kernel/tracing/
/sys/kernel/tracing # echo 'foo="test" bar=0' >> events/sample-trace/foo_rel_loc
/inject 
/sys/kernel/tracing # cat trace 
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
           <...>-135     [002] .....   153.998779: foo_rel_loc: foo_rel_loc test, 0


Test Event Histogram
----

/sys/kernel/tracing # echo 'hist:key=foo' >> events/sample-trace/foo_rel_loc/trigger 
/sys/kernel/tracing # cat events/sample-trace/foo_rel_loc/hist 
# event histogram
#
# trigger info: hist:keys=foo:vals=hitcount:sort=hitcount:size=2048 [active]
#

{ foo: Hello __rel_loc                                    } hitcount:         11

Totals:
    Hits: 11
    Entries: 1
    Dropped: 0


Test Event Filter
----
/sys/kernel/tracing # echo 'foo == "Hello __rel_loc"' >> events/sample-trace/foo_rel_loc/filter
/sys/kernel/tracing # echo > trace
/sys/kernel/tracing # echo 1 >  events/sample-trace/foo_rel_loc/enable 
/sys/kernel/tracing # cat trace 
# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    event-sample-142     [005] .....   665.801471: foo_rel_loc: foo_rel_loc Hello __rel_loc, 631
    event-sample-142     [005] .....   666.825611: foo_rel_loc: foo_rel_loc Hello __rel_loc, 632


Thank you,

---

Masami Hiramatsu (5):
      tracing: Support __rel_loc relative dynamic data location attribute
      tracing: Add '__rel_loc' using trace event macros
      samples/trace_event: Add '__rel_loc' using sample event
      libtraceevent: Add __rel_loc relative location attribute support
      tools/perf: Add __rel_loc support


 include/linux/trace_events.h                       |    1 
 include/trace/bpf_probe.h                          |   13 +++
 include/trace/perf.h                               |   13 +++
 include/trace/trace_events.h                       |   83 ++++++++++++++++++++
 kernel/trace/trace.h                               |    4 +
 kernel/trace/trace_events_filter.c                 |   32 +++++++-
 kernel/trace/trace_events_hist.c                   |   21 +++++
 kernel/trace/trace_events_inject.c                 |   11 ++-
 samples/trace_events/trace-events-sample.c         |    2 
 samples/trace_events/trace-events-sample.h         |   28 +++++++
 tools/lib/traceevent/event-parse.c                 |   14 +++
 tools/lib/traceevent/event-parse.h                 |    1 
 tools/lib/traceevent/parse-filter.c                |    5 +
 tools/perf/builtin-trace.c                         |    2 
 tools/perf/util/data-convert-bt.c                  |    2 
 tools/perf/util/evsel.c                            |    2 
 tools/perf/util/python.c                           |    2 
 .../perf/util/scripting-engines/trace-event-perl.c |    2 
 .../util/scripting-engines/trace-event-python.c    |    2 
 tools/perf/util/sort.c                             |    2 
 20 files changed, 235 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
