Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2798C43D940
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ1CSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhJ1CSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:18:39 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27AE160F56;
        Thu, 28 Oct 2021 02:16:13 +0000 (UTC)
Date:   Wed, 27 Oct 2021 22:16:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [GIT PULL] tracing: Do not warn when connecting eprobe to non
 existing event
Message-ID: <20211027221611.23d9c3af@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Do not WARN when attaching event probe to non-existent event

If the user tries to attach an event probe (eprobe) to an event that does
not exist, it will trigger a warning. There's an error check that only
expects memory issues otherwise it is considered a bug. But changes in the
code to move around the locking made it that it can error out if the user
attempts to attach to an event that does not exist, returning an -ENODEV.
As this path can be caused by user space putting in a bad value, do not
trigger a WARN.


Please pull the latest trace-v5.15-rc6-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-rc6-2

Tag SHA1: 9fae737f622d42e0b9469ff6f481eed539363d90
Head SHA1: 7fa598f9706d40bd16f2ab286bdf5808e1393d35


Steven Rostedt (VMware) (1):
      tracing: Do not warn when connecting eprobe to non existing event

----
 kernel/trace/trace_eprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit 7fa598f9706d40bd16f2ab286bdf5808e1393d35
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed Oct 27 12:08:54 2021 -0400

    tracing: Do not warn when connecting eprobe to non existing event
    
    When the syscall trace points are not configured in, the kselftests for
    ftrace will try to attach an event probe (eprobe) to one of the system
    call trace points. This triggered a WARNING, because the failure only
    expects to see memory issues. But this is not the only failure. The user
    may attempt to attach to a non existent event, and the kernel must not
    warn about it.
    
    Link: https://lkml.kernel.org/r/20211027120854.0680aa0f@gandalf.local.home
    
    Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index c4a15aef36af..5c5f208c15d3 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -904,8 +904,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	if (IS_ERR(ep)) {
 		ret = PTR_ERR(ep);
-		/* This must return -ENOMEM, else there is a bug */
-		WARN_ON_ONCE(ret != -ENOMEM);
+		/* This must return -ENOMEM or misssing event, else there is a bug */
+		WARN_ON_ONCE(ret != -ENOMEM && ret != -ENODEV);
 		ep = NULL;
 		goto error;
 	}
