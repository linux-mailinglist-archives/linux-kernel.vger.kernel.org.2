Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D0F318373
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBKCKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhBKCKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:10:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C0064EBC;
        Thu, 11 Feb 2021 02:09:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QS-00BATi-MO; Wed, 10 Feb 2021 21:09:48 -0500
Message-ID: <20210211020948.561318913@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 01/12] tracing: Do not create "enable" or "filter" files for ftrace event
 subsystem
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ftrace event subsystem is only created for showing the format files of
events created by the ftrace tracers, and are not trace events. The ftrace
subsystem currently has both the "enable" and "filter" files that in other
subsystems are used to enable/disable all events within the subsystem or set
a filter for all the subsystem events.

As ftrace subsystem events do not use enable or filter operations, these
files are useless in the ftrace subsystem. Remove them.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 20ccce3e4ffb..c1e90611fe22 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2097,16 +2097,20 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	dir->subsystem = system;
 	file->system = dir;
 
-	entry = tracefs_create_file("filter", 0644, dir->entry, dir,
-				    &ftrace_subsystem_filter_fops);
-	if (!entry) {
-		kfree(system->filter);
-		system->filter = NULL;
-		pr_warn("Could not create tracefs '%s/filter' entry\n", name);
-	}
+	/* the ftrace system is special, do not create enable or filter files */
+	if (strcmp(name, "ftrace") != 0) {
+
+		entry = tracefs_create_file("filter", 0644, dir->entry, dir,
+					    &ftrace_subsystem_filter_fops);
+		if (!entry) {
+			kfree(system->filter);
+			system->filter = NULL;
+			pr_warn("Could not create tracefs '%s/filter' entry\n", name);
+		}
 
-	trace_create_file("enable", 0644, dir->entry, dir,
-			  &ftrace_system_enable_fops);
+		trace_create_file("enable", 0644, dir->entry, dir,
+				  &ftrace_system_enable_fops);
+	}
 
 	list_add(&dir->list, &tr->systems);
 
-- 
2.29.2


