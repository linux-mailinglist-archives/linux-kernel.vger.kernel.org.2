Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6C3EF2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhHQToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233618AbhHQTnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1450A6108E;
        Tue, 17 Aug 2021 19:43:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zJ-004TSM-4t; Tue, 17 Aug 2021 15:43:05 -0400
Message-ID: <20210817194304.983832176@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 13/19] Documentation: tracing: Add histogram syntax to boot-time tracing
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add the documentation about histogram syntax in boot-time tracing.
This will allow user to write the histogram setting in a structured
parameters.

Link: https://lkml.kernel.org/r/162856127129.203126.15551542847575916525.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/boottime-trace.rst | 85 ++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 8053898cfeb4..6dcfbc64014d 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -125,6 +125,71 @@ Note that kprobe and synthetic event definitions can be written under
 instance node, but those are also visible from other instances. So please
 take care for event name conflict.
 
+Ftrace Histogram Options
+------------------------
+
+Since it is too long to write a histogram action as a string for per-event
+action option, there are tree-style options under per-event 'hist' subkey
+for the histogram actions. For the detail of the each parameter,
+please read the event histogram document [3]_.
+
+.. [3] See :ref:`Documentation/trace/histogram.rst <histogram>`
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]keys = KEY1[, KEY2[...]]
+  Set histogram key parameters. (Mandatory)
+  The 'N' is a digit string for the multiple histogram. You can omit it
+  if there is one histogram on the event.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]values = VAL1[, VAL2[...]]
+  Set histogram value parameters.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]sort = SORT1[, SORT2[...]]
+  Set histogram sort parameter options.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]size = NR_ENTRIES
+  Set histogram size (number of entries).
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]name = NAME
+  Set histogram name.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]var.VARIABLE = EXPR
+  Define a new VARIABLE by EXPR expression.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]<pause|continue|clear>
+  Set histogram control parameter. You can set one of them.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]onmatch.[M.]event = GROUP.EVENT
+  Set histogram 'onmatch' handler matching event parameter.
+  The 'M' is a digit string for the multiple 'onmatch' handler. You can omit it
+  if there is one 'onmatch' handler on this histogram.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]onmatch.[M.]trace = EVENT[, ARG1[...]]
+  Set histogram 'trace' action for 'onmatch'.
+  EVENT must be a synthetic event name, and ARG1... are parameters
+  for that event. Mandatory if 'onmatch.event' option is set.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]onmax.[M.]var = VAR
+  Set histogram 'onmax' handler variable parameter.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]onchange.[M.]var = VAR
+  Set histogram 'onchange' handler variable parameter.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]<onmax|onchange>.[M.]save = ARG1[, ARG2[...]]
+  Set histogram 'save' action parameters for 'onmax' or 'onchange' handler.
+  This option or below 'snapshot' option is mandatory if 'onmax.var' or
+  'onchange.var' option is set.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.[N.]<onmax|onchange>.[M.]snapshot
+  Set histogram 'snapshot' action for 'onmax' or 'onchange' handler.
+  This option or above 'save' option is mandatory if 'onmax.var' or
+  'onchange.var' option is set.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.filter = FILTER_EXPR
+  Set histogram filter expression. You don't need 'if' in the FILTER_EXPR.
+
+Note that this 'hist' option can conflict with the per-event 'actions'
+option if the 'actions' option has a histogram action.
+
 
 When to Start
 =============
@@ -159,13 +224,23 @@ below::
         }
         synthetic.initcall_latency {
                 fields = "unsigned long func", "u64 lat"
-                actions = "hist:keys=func.sym,lat:vals=lat:sort=lat"
+                hist {
+                        keys = func.sym, lat
+                        values = lat
+                        sort = lat
+                }
         }
-        initcall.initcall_start {
-                actions = "hist:keys=func:ts0=common_timestamp.usecs"
+        initcall.initcall_start.hist {
+                keys = func
+                var.ts0 = common_timestamp.usecs
         }
-        initcall.initcall_finish {
-                actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)"
+        initcall.initcall_finish.hist {
+                keys = func
+                var.lat = common_timestamp.usecs - $ts0
+                onmatch {
+                        event = initcall.initcall_start
+                        trace = initcall_latency, func, $lat
+                }
         }
   }
 
-- 
2.30.2
