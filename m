Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ECA42CC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhJMU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhJMU5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:57:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01E461165;
        Wed, 13 Oct 2021 20:55:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1malHh-0069mH-Q6; Wed, 13 Oct 2021 16:55:33 -0400
Message-ID: <20211013205533.630722129@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 16:51:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [PATCH v2 1/2] tracing: Fix event probe removal from dynamic events
References: <20211013205111.587708359@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When an event probe is to be removed via the API that created it via the
dynamic events, an -ENOENT error is returned.

This is because the removal of the event probe does not expect to see the
event system and name that the event probe is attached to, even though
that's part of the API to create it. As the removal of probes is to use
the same API as they are created.

In fact, the removal is not consistent with the kprobes and uprobes
removal. Fix that by allowing various ways to remove the eprobe.

The eprobe is created with:

 e:[GROUP/]NAME SYSTEM/EVENT [OPTIONS]

Have it get removed by echoing in the following into dynamic_events:

 # Remove all eprobes with NAME
 echo '-:NAME' >> dynamic_events

 # Remove a specific eprobe
 echo '-:GROUP/NAME' >> dynamic_events
 echo '-:GROUP/NAME SYSTEM/EVENT' >> dynamic_events
 echo '-:NAME SYSTEM/EVENT' >> dynamic_events
 echo '-:GROUP/NAME SYSTEM/EVENT OPTIONS' >> dynamic_events
 echo '-:NAME SYSTEM/EVENT OPTIONS' >> dynamic_events

Link: https://lkml.kernel.org/r/20211012081925.0e19cc4f@gandalf.local.home

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 54 ++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 570d081929fb..c4a15aef36af 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -119,10 +119,58 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_eprobe *ep = to_trace_eprobe(ev);
+	const char *slash;
 
-	return strcmp(trace_probe_name(&ep->tp), event) == 0 &&
-	    (!system || strcmp(trace_probe_group_name(&ep->tp), system) == 0) &&
-	    trace_probe_match_command_args(&ep->tp, argc, argv);
+	/*
+	 * We match the following:
+	 *  event only			- match all eprobes with event name
+	 *  system and event only	- match all system/event probes
+	 *
+	 * The below has the above satisfied with more arguments:
+	 *
+	 *  attached system/event	- If the arg has the system and event
+	 *				  the probe is attached to, match
+	 *				  probes with the attachment.
+	 *
+	 *  If any more args are given, then it requires a full match.
+	 */
+
+	/*
+	 * If system exists, but this probe is not part of that system
+	 * do not match.
+	 */
+	if (system && strcmp(trace_probe_group_name(&ep->tp), system) != 0)
+		return false;
+
+	/* Must match the event name */
+	if (strcmp(trace_probe_name(&ep->tp), event) != 0)
+		return false;
+
+	/* No arguments match all */
+	if (argc < 1)
+		return true;
+
+	/* First argument is the system/event the probe is attached to */
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
+	/* If there are no other args, then match */
+	if (argc < 1)
+		return true;
+
+	return trace_probe_match_command_args(&ep->tp, argc, argv);
 }
 
 static struct dyn_event_operations eprobe_dyn_event_ops = {
-- 
2.32.0
