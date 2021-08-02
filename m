Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3163DDC79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhHBPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235187AbhHBPar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C99CB610FE;
        Mon,  2 Aug 2021 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627918237;
        bh=Iy/BmkmhlJl7mDgQU32Sx67+sfpChTNXc5nj/JZFA3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWgOnRyAIqzBRUkWsQztNvtjNzv3u0T/YFHFmtJiYXZs25IRWAj+0Zd+ONdAEc3ZT
         1/JTl4qaxfOwmTQk02TpfR+rKoST32fL7ICXYS3o1+kgY/4WsP9NSyTnj4YqHUghcd
         70OnZwsLYCL28wetI8fEiers9/zK0EMn9NxZFM1AKiuD/VBu+VQLehB8YW4G8C6Ist
         jNHOFwutof1UNGNki65dUujUgGOQXgzkcpXW1xWnOu6giZQ9v9EBE+H9qnAbtyZFhW
         9LoAXbvPNRjcV3qW/jD96GSTjoXKOOn9FJkq06CHlzYo20F+YhoYgo2A+aGNeFvUgD
         Z6MlsqCUscwvg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 3/3] Documentation: tracing: Add histogram syntax to boot-time tracing
Date:   Tue,  3 Aug 2021 00:30:35 +0900
Message-Id: <162791823531.552329.5220785878335031348.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162791821009.552329.4358174280895732459.stgit@devnote2>
References: <162791821009.552329.4358174280895732459.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation about histogram syntax in boot-time tracing.
This will allow user to write the histogram setting in a structured
parameters.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/boottime-trace.rst |   81 ++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 8053898cfeb4..8c36785b57e9 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -125,6 +125,67 @@ Note that kprobe and synthetic event definitions can be written under
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
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.keys = KEY1[, KEY2[...]]
+  Set histogram key parameters. (Mandatory)
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.values = VAL1[, VAL2[...]]
+  Set histogram value parameters.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.sort = SORT1[, SORT2[...]]
+  Set histogram sort parameter options.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.size = NR_ENTRIES
+  Set histogram size (number of entries).
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.name = NAME
+  Set histogram name.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.var.VARIABLE = EXPR
+  Define a new VARIABLE by EXPR expression.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.<pause|continue|clear>
+  Set histogram control parameter.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.onmatch.event = GROUP.EVENT
+  Set histogram 'onmatch' handler matching event parameter.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.onmatch.trace = EVENT[, ARG1[...]]
+  Set histogram 'trace' action for 'onmatch'.
+  EVENT must be a synthetic event name, and ARG1... are parameters
+  for that event. Mandatory if 'onmatch.event' option is set.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.onmax.var = VAR
+  Set histogram 'onmax' handler variable parameter.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.onchange.var = VAR
+  Set histogram 'onchange' handler variable parameter.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.<onmax|onchange>.save = ARG1[, ARG2[...]]
+  Set histogram 'save' action parameters for 'onmax' or 'onchange' handler.
+  This option or below 'snapshot' option is mandatory if 'onmax.var' or
+  'onchange.var' option is set.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.<onmax|onchange>.snapshot
+  Set histogram 'snapshot' action for 'onmax' or 'onchange' handler.
+  This option or above 'save' option is mandatory if 'onmax.var' or
+  'onchange.var' option is set.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist.filter = FILTER_EXPR
+  Set histogram filter expression.
+
+Note that this 'hist' option can conflict with the per-event 'actions'
+option if the 'actions' option has a histogram action.
+
 
 When to Start
 =============
@@ -159,13 +220,23 @@ below::
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
+                var.lat = common_timestamp.usecs-$ts0
+                onmatch {
+                        event = initcall.initcall_start
+                        trace = initcall_latency, func, $lat
+                }
         }
   }
 

