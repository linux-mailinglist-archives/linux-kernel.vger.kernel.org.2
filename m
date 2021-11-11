Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE56F44CEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhKKB0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhKKB0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:26:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1295A61452;
        Thu, 11 Nov 2021 01:23:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mkyo6-000Afj-Tt;
        Wed, 10 Nov 2021 20:23:14 -0500
Message-ID: <20211111012314.755595288@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 20:22:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 2/2] ftrace/direct: Fix lockup in modify_ftrace_direct_multi
References: <20211111012254.044048524@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

We can't call unregister_ftrace_function under ftrace_lock.

Link: https://lkml.kernel.org/r/20211109114217.1645296-1-jolsa@kernel.org

Fixes: ed29271894aa ("ftrace/direct: Do not disable when switching direct callers")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.33.0
