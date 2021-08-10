Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626AF3E50EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhHJCIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237482AbhHJCIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:08:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B281D61051;
        Tue, 10 Aug 2021 02:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561273;
        bh=9TOfkpbxFzhvz7VLTK2Qa5HlNBwwVGQhLwDRJX9dawo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgLoARhoo5t19g0myhwHbXbell8S1B7bIomkGLUKYnSHpsbQ6UPHoGgS8WuRcwjH7
         DVi4xp/FxGnhj36+w6xiC+BfAaWLo82NYzWt9o6uI1QsqIps1MMvxDqUD1uCNAMkJe
         NoZYBlFZVaMcS4o/totXKtbHlhN2y7eWtWaI9/fnixYbqaJiSn5RTPM5wRIAPMdsvc
         /acbRii1fVh1QJCTEXH4lERgQxuxU0vaZWTsAwA4111vQtAmga5WiEnzt0khhtPrH2
         68XTGecPHuuVVFvZgUdIlLbXVNShfOy7LhEnQa1hY86iDdj3YwdBjNBF+OgQa2zNiL
         N8a/lK1xLFQYA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 06/10] Documentation: tracing: Add histogram syntax to boot-time tracing
Date:   Tue, 10 Aug 2021 11:07:51 +0900
Message-Id: <162856127129.203126.15551542847575916525.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162856122550.203126.17607127017097781682.stgit@devnote2>
References: <162856122550.203126.17607127017097781682.stgit@devnote2>
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
 Changes in v2:
  - Update for the multiple histogram and the multiple handler.
---
 Documentation/trace/boottime-trace.rst |   85 ++++++++++++++++++++++++++++++--
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
 

