Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C026F30DF44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbhBCQJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234820AbhBCQH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:07:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305C164FA8;
        Wed,  3 Feb 2021 16:05:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf8-009J9V-2x; Wed, 03 Feb 2021 11:05:50 -0500
Message-ID: <20210203160549.967055418@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 09/15] tracing: Remove NULL check from current in
 tracing_generic_entry_update().
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I can't imagine when or why `current' would return a NULL pointer. This
check was added in commit
      72829bc3d63cd ("ftrace: move enums to ftrace.h and make helper function global")

but it doesn't give me hint why it was needed.

Assume `current' never returns a NULL pointer and remove the check.

Link: https://lkml.kernel.org/r/20210125194511.3924915-5-bigeasy@linutronix.de

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 67ae708de40d..5d1eeac4bfbe 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -152,10 +152,8 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 						unsigned short type,
 						unsigned int trace_ctx)
 {
-	struct task_struct *tsk = current;
-
 	entry->preempt_count		= trace_ctx & 0xff;
-	entry->pid			= (tsk) ? tsk->pid : 0;
+	entry->pid			= current->pid;
 	entry->type			= type;
 	entry->flags =			trace_ctx >> 16;
 }
-- 
2.29.2


