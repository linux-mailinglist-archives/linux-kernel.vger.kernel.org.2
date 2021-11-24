Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00AC45C851
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKXPNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhKXPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:13:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E1D60E98;
        Wed, 24 Nov 2021 15:09:57 +0000 (UTC)
Date:   Wed, 24 Nov 2021 10:09:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing/uprobe: Fix uprobe_perf_open probes iteration
Message-ID: <20211124100956.6905a198@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

tracing: Fix wrong uprobe variable in iterator

uprobe_perf_open() processes a list of probes, but due to a missing
setting of the uprobe to be processed, the loop processes the head probe
instead of the added probes.


Please pull the latest trace-v5.16-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-rc2

Tag SHA1: b035fc0d660c88f1ec940aba668d438c96ea1a5c
Head SHA1: 1880ed71ce863318c1ce93bf324876fb5f92854f


Jiri Olsa (1):
      tracing/uprobe: Fix uprobe_perf_open probes iteration

----
 kernel/trace/trace_uprobe.c | 1 +
 1 file changed, 1 insertion(+)
---------------------------
commit 1880ed71ce863318c1ce93bf324876fb5f92854f
Author: Jiri Olsa <jolsa@redhat.com>
Date:   Tue Nov 23 15:28:01 2021 +0100

    tracing/uprobe: Fix uprobe_perf_open probes iteration
    
    Add missing 'tu' variable initialization in the probes loop,
    otherwise the head 'tu' is used instead of added probes.
    
    Link: https://lkml.kernel.org/r/20211123142801.182530-1-jolsa@kernel.org
    
    Cc: stable@vger.kernel.org
    Fixes: 99c9a923e97a ("tracing/uprobe: Fix double perf_event linking on multiprobe uprobe")
    Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Jiri Olsa <jolsa@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 0a5c0db3137e..f5f0039d31e5 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1313,6 +1313,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		tu = container_of(pos, struct trace_uprobe, tp);
 		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
 		if (err) {
 			uprobe_perf_close(call, event);
