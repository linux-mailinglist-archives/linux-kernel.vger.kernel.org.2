Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFDA3E50F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhHJCIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237375AbhHJCIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:08:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95DA260200;
        Tue, 10 Aug 2021 02:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561304;
        bh=pOYHWN+WeevHracHh/+8MHauEqLmuIrCZfnbgTIkeGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRdA8mqiz8F1SNjVlzv6lxarcAhEo4bEJCrfXhMSJ1IuxKGU2uK0Fdc5vOQeAdxsB
         rKX3HuPVkt3R8elmZ1tQN215HER/o74qhSn6QWxuOpKqOOV6cPvRdBaZwuJr3lEx/T
         k6cba7fBlZizQgBvYV71Vcbb2s9TWcFYYmYroA6vdQiRpjJ3RfKWnvnBXdfC8Ge7A5
         iKkBhpOiBIH5nA1MPDN4vdEP9QnMDKlA0GM5mx2BGt/fVN4huCfsY28/p+RnY+rkYs
         rST4sLSZq+4u5NW394H+1Ghv7mOjy1xx0/Kkg6b7Zf/46TW1wOLpZimZvFby16dQmg
         Chr8xvdrJw5DA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 10/10] bootconfig/tracing/ktest: Update ktest example for boot-time tracing
Date:   Tue, 10 Aug 2021 11:08:22 +0900
Message-Id: <162856130208.203126.4458319094852152589.stgit@devnote2>
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

Update ktest example for the boot-time tracing with histogram
options. Note that since the histogram option uses "trace()" action
instead of "EVENT()", this updates the matching pattern too.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ktest/examples/bootconfigs/boottrace.bconf     |   20 +++++++++++++++-----
 .../ktest/examples/bootconfigs/verify-boottrace.sh |    2 +-
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

