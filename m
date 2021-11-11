Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2744D7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhKKOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhKKOLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:11:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4246112F;
        Thu, 11 Nov 2021 14:09:01 +0000 (UTC)
Date:   Thu, 11 Nov 2021 09:08:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] tracing: Two locking fixes
Message-ID: <20211111090859.16098063@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Two tracing fixes:

- Add mutex protection to ring_buffer_reset()

- Fix deadlock in modify_ftrace_direct_multi()


Please pull the latest trace-v5.16-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-3

Tag SHA1: 04b4f472203407d85d8ca937f8f2dbe265f87d84
Head SHA1: 2e6e9058d13a22a6fdd36a8c444ac71d9656003a


Jiri Olsa (1):
      ftrace/direct: Fix lockup in modify_ftrace_direct_multi

Steven Rostedt (VMware) (1):
      ring-buffer: Protect ring_buffer_reset() from reentrancy

----
 kernel/trace/ftrace.c      | 3 ++-
 kernel/trace/ring_buffer.c | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b4ed1a301232..fc49e8809a56 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5602,10 +5602,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
+	mutex_unlock(&ftrace_lock);
+
 	/* Removing the tmp_ops will add the updated direct callers to the functions */
 	unregister_ftrace_function(&tmp_ops);
 
-	mutex_unlock(&ftrace_lock);
  out_direct:
 	mutex_unlock(&direct_mutex);
 	return err;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f6520d0a4c8c..2699e9e562b1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5228,6 +5228,9 @@ void ring_buffer_reset(struct trace_buffer *buffer)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	int cpu;
 
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
@@ -5246,6 +5249,8 @@ void ring_buffer_reset(struct trace_buffer *buffer)
 		atomic_dec(&cpu_buffer->record_disabled);
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
+
+	mutex_unlock(&buffer->mutex);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset);
 
