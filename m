Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E93F2DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhHTOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240739AbhHTOMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:12:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F8961106;
        Fri, 20 Aug 2021 14:12:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mH5Fa-004oLm-2J; Fri, 20 Aug 2021 10:12:02 -0400
Message-ID: <20210820141201.906161785@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 10:11:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 5/9] tracing/probes: Allow for dot delimiter as well as slash for system
 names
References: <20210820141109.993445617@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Kprobe and uprobe events can add a "system" to the events that are created
via the kprobe_events and uprobe_events files respectively. If they do not
include a "system" in the name, then the default "kprobes" or "uprobes" is
used. The current notation to specify a system for one of these probe
events is to add a '/' delimiter in the name, where the content before the
'/' will be the system to use, and the content after will be the event
name.

 echo 'p:my_system/my_event' > kprobe_events

But this is inconsistent with the way histogram triggers separate their
system / event names. The histogram triggers use a '.' delimiter, which
can be confusing.

To allow this to be more consistent, as well as keep backward
compatibility, allow the kprobe and uprobe events to denote a system name
with either a '/' or a '.'.

That is:

  echo 'p:my_system/my_event' > kprobe_events

is equivalent to:

  echo 'p:my_system.my_event' > kprobe_events

Link: https://lore.kernel.org/linux-trace-devel/20210813004448.51c7de69ce432d338f4d226b@kernel.org/
Link: https://lkml.kernel.org/r/20210817035027.580493202@goodmis.org

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ef717b373443..0916a9964719 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -233,6 +233,9 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 	int len;
 
 	slash = strchr(event, '/');
+	if (!slash)
+		slash = strchr(event, '.');
+
 	if (slash) {
 		if (slash == event) {
 			trace_probe_log_err(offset, NO_GROUP_NAME);
-- 
2.30.2
