Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2464229D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhJEOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235196AbhJEOB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:01:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84425615A4;
        Tue,  5 Oct 2021 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxe-0055fl-IT; Tue, 05 Oct 2021 09:58:26 -0400
Message-ID: <20211005135826.411167205@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 05/27] kprobes: Make arch_check_ftrace_location static
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punitagrawal@gmail.com>

arch_check_ftrace_location() was introduced as a weak function in
commit f7f242ff004499 ("kprobes: introduce weak
arch_check_ftrace_location() helper function") to allow architectures
to handle kprobes call site on their own.

Recently, the only architecture (csky) to implement
arch_check_ftrace_location() was migrated to using the common
version.

As a result, further cleanup the code to drop the weak attribute and
rename the function to remove the architecture specific
implementation.

Link: https://lkml.kernel.org/r/163163035673.489837.2367816318195254104.stgit@devnote2

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/kprobes.h | 2 --
 kernel/kprobes.c        | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0b75549b2815..8a9412bb0d5e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -361,8 +361,6 @@ static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
-int arch_check_ftrace_location(struct kprobe *p);
-
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cfa9d3c263eb..30199bfcc74a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1524,7 +1524,7 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 	return ret;
 }
 
-int __weak arch_check_ftrace_location(struct kprobe *p)
+static int check_ftrace_location(struct kprobe *p)
 {
 	unsigned long ftrace_addr;
 
@@ -1547,7 +1547,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 {
 	int ret;
 
-	ret = arch_check_ftrace_location(p);
+	ret = check_ftrace_location(p);
 	if (ret)
 		return ret;
 	jump_label_lock();
-- 
2.32.0
