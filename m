Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462CC35EA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348843AbhDNAhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348287AbhDNAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:37:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1DDC6113E;
        Wed, 14 Apr 2021 00:37:17 +0000 (UTC)
Date:   Tue, 13 Apr 2021 20:37:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing/dynevent: Fix a memory leak in an error handling
 path
Message-ID: <20210413203716.339a87ee@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Linus,

tracing/dynevent: Fix a memory link in dyn_event_release()

An error path exited the function before freeing the allocated
"argv" variable.


Please pull the latest trace-v5.12-rc7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.12-rc7

Tag SHA1: 682c26c6e8cf02be8c898a712bbd5ffd75c83616
Head SHA1: 8db403b9631331ef1d5e302cdf353c48849ca9d5


Christophe JAILLET (1):
      tracing/dynevent: Fix a memory leak in an error handling path

----
 kernel/trace/trace_dynevent.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---------------------------
commit 8db403b9631331ef1d5e302cdf353c48849ca9d5
Author: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date:   Sun Apr 11 12:21:54 2021 +0200

    tracing/dynevent: Fix a memory leak in an error handling path
    
    We must free 'argv' before returning, as already done in all the other
    paths of this function.
    
    Link: https://lkml.kernel.org/r/21e3594ccd7fc88c5c162c98450409190f304327.1618136448.git.christophe.jaillet@wanadoo.fr
    
    Fixes: d262271d0483 ("tracing/dynevent: Delegate parsing to create function")
    Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index dc971a68dda4..e57cc0870892 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -63,8 +63,10 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (event[0] == '\0')
-		return -EINVAL;
+	if (event[0] == '\0') {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	mutex_lock(&event_mutex);
 	for_each_dyn_event_safe(pos, n) {
