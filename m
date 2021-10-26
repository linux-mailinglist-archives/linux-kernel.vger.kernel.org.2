Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC143B708
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhJZQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234204AbhJZQ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335D960EB4;
        Tue, 26 Oct 2021 16:23:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEp-000qNp-LW;
        Tue, 26 Oct 2021 12:23:47 -0400
Message-ID: <20211026162347.502580346@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>
Subject: [for-next][PATCH 01/12] ftrace: Make ftrace_profile_pages_init static
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

This symbol is not used outside of ftrace.c, so marks it static.

Fixes the following sparse warning:

kernel/trace/ftrace.c:579:5: warning: symbol 'ftrace_profile_pages_init'
was not declared. Should it be static?

Link: https://lkml.kernel.org/r/1634640534-18280-1-git-send-email-jiapeng.chong@linux.alibaba.com

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: cafb168a1c92 ("tracing: make the function profiler per cpu")
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f90ed00a6d5b..2057ad363772 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -576,7 +576,7 @@ static void ftrace_profile_reset(struct ftrace_profile_stat *stat)
 	       FTRACE_PROFILE_HASH_SIZE * sizeof(struct hlist_head));
 }
 
-int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
+static int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
 {
 	struct ftrace_profile_page *pg;
 	int functions;
-- 
2.33.0
