Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B714241DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhJFPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhJFPzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:55:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B3BA60F11;
        Wed,  6 Oct 2021 15:53:19 +0000 (UTC)
Date:   Wed, 6 Oct 2021 11:53:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing/synthetic_events: Fix use when created by
 dynamic_events file
Message-ID: <20211006115317.2cfcc742@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The dynamic_events file can create kprobe, uprobe, event probes as well as
synthetic events. New dynamic events will also be created by this file.
Each of these kinds of events register a "create" function, that gets
called, and if the prefix does not match the type of event, the create
function is to return -ECANCELED to tell the dynamic event code that the
command does not belong to it, and other events should be tried.

The synthetic event does some format checking before it determines that it
is the event that should be created, and if that format check does not
match, it will return an error, telling the dynamic event code that it was
the expected event to be created and that the input had an error. This
returns an error code back to the user. But unfortunately, because it does
the check before it determines that it is indeed the proper event to parse
the input, it may fail the call even though the input is a proper syntax
for another event type.

Have it confirm that the input is for the synthetic event before it
returns an error due to parsing failure.

Fixes: c9e759b1e8456 ("tracing: Rework synthetic event command parsing")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d54094b7a9d7..feb87e5817e9 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -2045,11 +2045,17 @@ static int create_synth_event(const char *raw_command)
 {
 	char *fields, *p;
 	const char *name;
-	int len, ret = 0;
+	int len, ret;
 
 	raw_command = skip_spaces(raw_command);
 	if (raw_command[0] == '\0')
-		return ret;
+		return -ECANCELED;
+
+	name = raw_command;
+
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
+	name += 2;
 
 	last_cmd_set(raw_command);
 
@@ -2061,12 +2067,6 @@ static int create_synth_event(const char *raw_command)
 
 	fields = skip_spaces(p);
 
-	name = raw_command;
-
-	if (name[0] != 's' || name[1] != ':')
-		return -ECANCELED;
-	name += 2;
-
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
-- 
2.31.1

