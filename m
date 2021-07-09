Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5926F3C2407
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhGINNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhGINN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:13:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3883A61377;
        Fri,  9 Jul 2021 13:10:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1qHD-00097n-4F; Fri, 09 Jul 2021 09:10:43 -0400
Message-ID: <20210709131042.976521644@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 09:09:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 2/3] tracing/selftests: Add tests to test histogram sym and sym-offset
 modifiers
References: <20210709130949.717206727@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a test to the tracing selftests that will catch if the .sym or
.sym-offset modifiers break in the future.

Link: https://lkml.kernel.org/r/20210707121451.101a1002@oasis.local.home

Acked-by: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/trigger/trigger-hist.tc      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
index 2950bfbc6fce..adae72665500 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
@@ -39,6 +39,24 @@ grep "parent_comm: $COMM" events/sched/sched_process_fork/hist > /dev/null || \
 
 reset_trigger
 
+echo "Test histogram with sym modifier"
+
+echo 'hist:keys=call_site.sym' > events/kmem/kmalloc/trigger
+for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]* *}' events/kmem/kmalloc/hist > /dev/null || \
+    fail "sym modifier on kmalloc call_site did not work"
+
+reset_trigger
+
+echo "Test histogram with sym-offset modifier"
+
+echo 'hist:keys=call_site.sym-offset' > events/kmem/kmalloc/trigger
+for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]*+0x[0-9a-f][0-9a-f]*' events/kmem/kmalloc/hist > /dev/null || \
+    fail "sym-offset modifier on kmalloc call_site did not work"
+
+reset_trigger
+
 echo "Test histogram with sort key"
 
 echo 'hist:keys=parent_pid,child_pid:sort=child_pid.ascending' > events/sched/sched_process_fork/trigger
-- 
2.30.2
