Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24640B211
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhINOvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233748AbhINOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:51:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6A3610A6;
        Tue, 14 Sep 2021 14:50:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mQ9lZ-001oP3-G9; Tue, 14 Sep 2021 10:50:33 -0400
Message-ID: <20210914145033.337080566@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 14 Sep 2021 10:48:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 1/2] bootconfig: Fix to check the xbc_node is used before free it
References: <20210914144809.297030763@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix to check the xbc_node is used before calling memblock_free()
because passing NULL to phys_addr() will cause a panic.
This will happen if user doesn't pass any bootconfig to the
kernel, because kernel will call xbc_destroy_all() after
booting.

Link: https://lkml.kernel.org/r/163149460533.291098.7342418455457691240.stgit@devnote2

Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f8419cff1147..4f8849706ef6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -792,7 +792,8 @@ void __init xbc_destroy_all(void)
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
+	if (xbc_nodes)
+		memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
-- 
2.32.0
