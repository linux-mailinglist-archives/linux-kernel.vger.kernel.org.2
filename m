Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4B43CE57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbhJ0QM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237855AbhJ0QM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6E860FBF;
        Wed, 27 Oct 2021 16:10:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV2-000xm8-2E;
        Wed, 27 Oct 2021 12:10:00 -0400
Message-ID: <20211027160959.906811049@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 01/15] lib/bootconfig: Fix the xbc_get_info kerneldoc
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix the kernel doc of xbc_get_info() to add '@' to the parameters.

Link: https://lkml.kernel.org/r/163525086738.676803.15352231787913236933.stgit@devnote2

Fixes: e306220cb7b7 ("bootconfig: Add xbc_get_info() for the node information")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 3276675b25e1..a10ab25f6fcc 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -67,8 +67,8 @@ static inline void xbc_free_mem(void *addr, size_t size)
 #endif
 /**
  * xbc_get_info() - Get the information of loaded boot config
- * node_size: A pointer to store the number of nodes.
- * data_size: A pointer to store the size of bootconfig data.
+ * @node_size: A pointer to store the number of nodes.
+ * @data_size: A pointer to store the size of bootconfig data.
  *
  * Get the number of used nodes in @node_size if it is not NULL,
  * and the size of bootconfig data in @data_size if it is not NULL.
-- 
2.33.0
