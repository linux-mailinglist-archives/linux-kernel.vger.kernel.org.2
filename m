Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1F34B157
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCZV34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhCZV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:29:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DBF61A42;
        Fri, 26 Mar 2021 21:29:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lPu1G-002DSL-D0; Fri, 26 Mar 2021 17:29:26 -0400
Message-ID: <20210326212926.281197902@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 17:28:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 5/6] tracing: A minor cleanup for create_system_filter()
References: <20210326212848.385566448@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

The first two parameters should be reduced to one, as @tr is simply
@dir->tr.

Link: https://lkml.kernel.org/r/20210324205642.65e03248@oasis.local.home
Link: https://lkml.kernel.org/r/20210325163752.128407-1-hqjagain@gmail.com

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 49de3e21e9bc..c2dd697cc9c0 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1750,7 +1750,6 @@ int create_event_filter(struct trace_array *tr,
  * and always remembers @filter_str.
  */
 static int create_system_filter(struct trace_subsystem_dir *dir,
-				struct trace_array *tr,
 				char *filter_str, struct event_filter **filterp)
 {
 	struct filter_parse_error *pe = NULL;
@@ -1758,13 +1757,13 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 
 	err = create_filter_start(filter_str, true, &pe, filterp);
 	if (!err) {
-		err = process_system_preds(dir, tr, pe, filter_str);
+		err = process_system_preds(dir, dir->tr, pe, filter_str);
 		if (!err) {
 			/* System filters just show a default message */
 			kfree((*filterp)->filter_string);
 			(*filterp)->filter_string = NULL;
 		} else {
-			append_filter_err(tr, pe, *filterp);
+			append_filter_err(dir->tr, pe, *filterp);
 		}
 	}
 	create_filter_finish(pe);
@@ -1852,7 +1851,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		goto out_unlock;
 	}
 
-	err = create_system_filter(dir, tr, filter_string, &filter);
+	err = create_system_filter(dir, filter_string, &filter);
 	if (filter) {
 		/*
 		 * No event actually uses the system filter
-- 
2.30.1


