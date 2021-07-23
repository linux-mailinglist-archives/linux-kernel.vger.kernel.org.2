Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F593D3AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhGWMQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhGWMQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:16:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3F460ED7;
        Fri, 23 Jul 2021 12:56:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m6ujC-001hiZ-CG; Fri, 23 Jul 2021 08:56:34 -0400
Message-ID: <20210723125634.213430293@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Jul 2021 08:54:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [for-linus][PATCH 5/7] ftrace: Avoid synchronize_rcu_tasks_rude() call when not necessary
References: <20210723125454.570472450@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzju@redhat.com>

synchronize_rcu_tasks_rude() triggers IPIs and forces rescheduling on
all CPUs. It is a costly operation and, when targeting nohz_full CPUs,
very disrupting (hence the name). So avoid calling it when 'old_hash'
doesn't need to be freed.

Link: https://lkml.kernel.org/r/20210721114726.1545103-1-nsaenzju@redhat.com

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e6fb3e6e1ffc..4fbcf560dd03 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5985,7 +5985,8 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		 * infrastructure to do the synchronization, thus we must do it
 		 * ourselves.
 		 */
-		synchronize_rcu_tasks_rude();
+		if (old_hash != EMPTY_HASH)
+			synchronize_rcu_tasks_rude();
 
 		free_ftrace_hash(old_hash);
 	}
-- 
2.30.2
