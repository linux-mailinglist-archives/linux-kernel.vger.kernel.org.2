Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292663C2409
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhGINNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231545AbhGINN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:13:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA60613C5;
        Fri,  9 Jul 2021 13:10:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1qHD-00098L-A0; Fri, 09 Jul 2021 09:10:43 -0400
Message-ID: <20210709131043.155471135@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 09:09:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hulk Robot <hulkci@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
Subject: [for-linus][PATCH 3/3] ftrace: Use list_move instead of list_del/list_add
References: <20210709130949.717206727@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baokun Li <libaokun1@huawei.com>

Using list_move() instead of list_del() + list_add().

Link: https://lkml.kernel.org/r/20210608031108.2820996-1-libaokun1@huawei.com

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 72ef4dccbcc4..e6fb3e6e1ffc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4212,8 +4212,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 		if (!func) /* warn? */
 			continue;
 
-		list_del(&ftrace_mod->list);
-		list_add(&ftrace_mod->list, &process_mods);
+		list_move(&ftrace_mod->list, &process_mods);
 
 		/* Use the newly allocated func, as it may be "*" */
 		kfree(ftrace_mod->func);
-- 
2.30.2
