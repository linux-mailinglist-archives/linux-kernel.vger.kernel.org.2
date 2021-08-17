Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125863EF2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhHQToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233658AbhHQTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD70610A0;
        Tue, 17 Aug 2021 19:43:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zJ-004TUc-T7; Tue, 17 Aug 2021 15:43:05 -0400
Message-ID: <20210817194305.742530204@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 17/19] bootconfig/tracing/ktest: Update ktest example for boot-time tracing
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Update ktest example for the boot-time tracing with histogram
options. Note that since the histogram option uses "trace()" action
instead of "EVENT()", this updates the matching pattern too.

Link: https://lkml.kernel.org/r/162856130208.203126.4458319094852152589.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../examples/bootconfigs/boottrace.bconf      | 20 ++++++++++++++-----
 .../examples/bootconfigs/verify-boottrace.sh  |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/ktest/examples/bootconfigs/boottrace.bconf b/tools/testing/ktest/examples/bootconfigs/boottrace.bconf
index 9db64ec589d5..7aa706cccb3b 100644
--- a/tools/testing/ktest/examples/bootconfigs/boottrace.bconf
+++ b/tools/testing/ktest/examples/bootconfigs/boottrace.bconf
@@ -10,13 +10,23 @@ ftrace.event {
 	}
 	synthetic.initcall_latency {
 		fields = "unsigned long func", "u64 lat"
-		actions = "hist:keys=func.sym,lat:vals=lat:sort=lat"
+		hist {
+			keys = func.sym,lat
+			values = lat
+			sort = lat
+		}
 	}
-	initcall.initcall_start {
-		actions = "hist:keys=func:ts0=common_timestamp.usecs"
+	initcall.initcall_start.hist {
+		keys = func;
+		var.ts0 = common_timestamp.usecs
 	}
-	initcall.initcall_finish {
-		actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)"
+	initcall.initcall_finish.hist {
+		keys = func
+		var.lat = common_timestamp.usecs - $ts0
+		onmatch {
+			event = initcall.initcall_start
+			trace = initcall_latency, func, $lat
+		}
 	}
 }
 
diff --git a/tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh b/tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh
index f271940ce7fb..233e95cfcf20 100755
--- a/tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh
+++ b/tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh
@@ -58,7 +58,7 @@ compare_file_partial "events/synthetic/initcall_latency/enable" "0"
 compare_file_partial "events/initcall/initcall_start/trigger" "hist:keys=func:vals=hitcount:ts0=common_timestamp.usecs"
 compare_file_partial "events/initcall/initcall_start/enable" "1"
 
-compare_file_partial "events/initcall/initcall_finish/trigger" 'hist:keys=func:vals=hitcount:lat=common_timestamp.usecs-\$ts0:sort=hitcount:size=2048:clock=global:onmatch(initcall.initcall_start).initcall_latency(func,\$lat)'
+compare_file_partial "events/initcall/initcall_finish/trigger" 'hist:keys=func:vals=hitcount:lat=common_timestamp.usecs-\$ts0:sort=hitcount:size=2048:clock=global:onmatch(initcall.initcall_start).trace(initcall_latency,func,\$lat)'
 compare_file_partial "events/initcall/initcall_finish/enable" "1"
 
 compare_file "instances/foo/current_tracer" "function"
-- 
2.30.2
