Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBED3E4937
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhHIPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235853AbhHIPt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B36766101D;
        Mon,  9 Aug 2021 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524146;
        bh=pOYHWN+WeevHracHh/+8MHauEqLmuIrCZfnbgTIkeGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnJSJLm0/d8ZPAq7H1LrvxSpEYcg0RvG/u6YndZhLqv9Vxk6PsZ3am/GT2u/j21LL
         Zata7rVUxZxC9apO/YS/pbb1/9bFheQCgM5fO1R5/CV0r0LsSOowgcLQlkLUkLdWUc
         xI3jbIFyUoYCRpq72m8HeHxUI/QYOlrqWt0I6ByFP3TBWnj/WAkYSVeMbjTXOX1xFZ
         C/zAQTrHKU9VSdXOBlUrZ/3thH6bGSQWeN3VwB1Zrqarxc8isom3a/ToKNYAinPr4Z
         J6PK62McSsvgDw9dYVidgnjm+7xAtZQUDVM78EsyHV1GNh3hiE9YIklFZ5vKNsYGSl
         Zf8LSrw3wthEA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 10/10] bootconfig/tracing/ktest: Update ktest example for boot-time tracing
Date:   Tue, 10 Aug 2021 00:49:04 +0900
Message-Id: <162852414399.143877.715796910618446725.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162852406891.143877.12110677006587392853.stgit@devnote2>
References: <162852406891.143877.12110677006587392853.stgit@devnote2>
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

