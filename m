Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49573EE537
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhHQDvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237064AbhHQDvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:51:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A7861052;
        Tue, 17 Aug 2021 03:50:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mFq7P-004OLr-Oq; Mon, 16 Aug 2021 23:50:27 -0400
Message-ID: <20210817035027.580493202@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Aug 2021 23:42:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH v6 4/7] tracing/probes: Allow for dot delimiter as well as slash for system
 names
References: <20210817034255.421910614@goodmis.org>
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

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
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
