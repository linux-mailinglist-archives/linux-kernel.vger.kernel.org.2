Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1745460717
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358034AbhK1PYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:24:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41754 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358010AbhK1PWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:22:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9765DB80D1D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 15:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37366C004E1;
        Sun, 28 Nov 2021 15:18:44 +0000 (UTC)
Date:   Sun, 28 Nov 2021 10:18:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [for-linus][PATCH] tracing: Test the 'Do not trace this pid' case
 in create event
Message-ID: <20211128101842.11a34490@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the fix of pid filtering

- The setting of the pid filtering flag tested the "trace only this
  pid" case twice, and ignored the "trace everything but this pid" case.

  Note, the 5.15 kernel does things a little differently due to the new
  sparse pid mask introduced in 5.16, and as the bug was discovered
  running the 5.15 kernel, and the first fix was initially done for
  that kernel, that fix handled both cases (only pid and all but pid),
  but the forward port to 5.16 added the bug.


Steven Rostedt (VMware) (1):
      tracing: Test the 'Do not trace this pid' case in create event

----
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 27ff768fa21ca3286fcc87c3f38ac67d1a2cbe2d
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Sat Nov 27 16:45:26 2021 -0500

    tracing: Test the 'Do not trace this pid' case in create event
    
    When creating a new event (via a module, kprobe, eprobe, etc), the
    descriptors that are created must add flags for pid filtering if an
    instance has pid filtering enabled, as the flags are used at the time the
    event is executed to know if pid filtering should be done or not.
    
    The "Only trace this pid" case was added, but a cut and paste error made
    that case checked twice, instead of checking the "Trace all but this pid"
    case.
    
    Link: https://lore.kernel.org/all/202111280401.qC0z99JB-lkp@intel.com/
    
    Fixes: 6cb206508b62 ("tracing: Check pid filtering when creating events")
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f8965fd50d3b..92be9cb1d7d4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2693,7 +2693,7 @@ trace_create_new_event(struct trace_event_call *call,
 					     lockdep_is_held(&event_mutex));
 
 	if (!trace_pid_list_first(pid_list, &first) ||
-	    !trace_pid_list_first(pid_list, &first))
+	    !trace_pid_list_first(no_pid_list, &first))
 		file->flags |= EVENT_FILE_FL_PID_FILTER;
 
 	file->event_call = call;
