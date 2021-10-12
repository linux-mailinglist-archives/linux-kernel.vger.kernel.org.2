Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1142A43C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhJLMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236196AbhJLMV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:21:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1923960E78;
        Tue, 12 Oct 2021 12:19:27 +0000 (UTC)
Date:   Tue, 12 Oct 2021 08:19:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-ID: <20211012081925.0e19cc4f@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

Link: https://lkml.kernel.org/r/20211011211105.48b6a5fd@oasis.local.home

Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1:
   - amended the commit with the definition of "slash"

 kernel/trace/trace_eprobe.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 570d081929fb..2bcfa8da5cef 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -119,6 +119,26 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_eprobe *ep = to_trace_eprobe(ev);
+	const char *slash;
+
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
 
 	return strcmp(trace_probe_name(&ep->tp), event) == 0 &&
 	    (!system || strcmp(trace_probe_group_name(&ep->tp), system) == 0) &&
-- 
2.31.1

