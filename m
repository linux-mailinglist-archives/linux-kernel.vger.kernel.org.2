Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58032DE9E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhCEAwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhCEAw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A69F26500F;
        Fri,  5 Mar 2021 00:52:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHyhe-001sUm-K3; Thu, 04 Mar 2021 19:52:26 -0500
Message-ID: <20210305005226.493367442@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 19:52:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 2/3] tracing: Skip selftests if tracing is disabled
References: <20210305005201.588505771@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If tracing is disabled for some reason (traceoff_on_warning, command line,
etc), the ftrace selftests are guaranteed to fail, as their results are
defined by trace data in the ring buffers. If the ring buffers are turned
off, the tests will fail, due to lack of data.

Because tracing being disabled is for a specific reason (warning, user
decided to, etc), it does not make sense to enable tracing to run the self
tests, as the test output may corrupt the reason for the tracing to be
disabled.

Instead, simply skip the self tests and report that they are being skipped
due to tracing being disabled.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e295c413580e..eccb4e1187cc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1929,6 +1929,12 @@ static int run_tracer_selftest(struct tracer *type)
 	if (!selftests_can_run)
 		return save_selftest(type);
 
+	if (!tracing_is_on()) {
+		pr_warn("Selftest for tracer %s skipped due to tracing disabled\n",
+			type->name);
+		return 0;
+	}
+
 	/*
 	 * Run a selftest on this tracer.
 	 * Here we reset the trace buffer, and set the current
-- 
2.30.0


