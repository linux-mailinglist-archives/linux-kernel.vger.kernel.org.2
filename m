Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89D5429AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhJLBNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234475AbhJLBNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:13:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6562360F21;
        Tue, 12 Oct 2021 01:11:07 +0000 (UTC)
Date:   Mon, 11 Oct 2021 21:11:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [PATCH] tracing: Fix event probe removal from dynamic events
Message-ID: <20211011211105.48b6a5fd@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When an event probe is to be removed via the API to remove dynamic events,
an -EBUSY error is returned.

This is because the removal of the event probe does not expect to see the
event system and name that the event probe is attached to, even though
that's part of the API to create it. As the removal of probes is to use
the same API as they are created, fix it by first testing if the first
parameter of the event probe to be removed matches the system and event
that the probe is attached to, and then adjust the argc and argv of the
parameters to match the rest of the syntax.

Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 3044b762cbd7..20ee265f01fd 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -120,6 +120,25 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 {
 	struct trace_eprobe *ep = to_trace_eprobe(ev);
 
+	/* First argument is the system/event the probe is attached to */
+
+	if (argc < 1)
+		return false;
+
+	slash = strchr(argv[0], '/');
+	if (!slash)
+		slash = strchr(argv[0], '.');
+	if (!slash)
+		return false;
+
+	if (strncmp(ep->event_system, argv[0], slash - argv[0]))
+		return false;
+	if (strcmp(ep->event_name, slash + 1))
+		return false;
+
+	argc--;
+	argv++;
+
 	return strcmp(trace_probe_name(&ep->tp), event) == 0 &&
 	    (!system || strcmp(trace_probe_group_name(&ep->tp), system) == 0) &&
 	    trace_probe_match_command_args(&ep->tp, argc, argv);
-- 
2.31.1

