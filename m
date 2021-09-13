Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4275B408270
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 02:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhIMA6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 20:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhIMA6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 20:58:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0672160D42;
        Mon, 13 Sep 2021 00:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631494607;
        bh=SBe2GPgrtzIMcpZywnsegClabFSYgEfpXE7JVxZobiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKsaiJIrVUd/I34h9uK1tpZNYt2hCCBd8nCC9kb4mCAG98SgN7k1TuqZ16PQdfg6x
         S64fQsivYnL/cvNCB4stBB+wT9bWkRjwumny8xaoTDENEA9Sia98BG0t0a4s4H4K9f
         8ZeBpUVloropxOXz7XJT9Wy8+ZKJQdGTuOSxk7NkHv06wYrgiQDEpp3NhEZNlT1sdM
         rKFxU4m9KGKIcnoYKKUWKF5Aw8liYJk5pvlzB0HiMBuaL1j/8ZLLTrnWKDOXAsOQ2f
         FHeu/5BMDMAQ0i19s6rm1/vYwanx3EnDZWjl9+rxsMMmHa9XgNYXVszxDBUQZ2BN13
         aFtzNya2wKiOg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, lkp@lists.01.org,
        lkp@intel.com, oliver.sang@intel.com
Subject: [PATCH] bootconfig: Fix to check the xbc_node is used before free it
Date:   Mon, 13 Sep 2021 09:56:45 +0900
Message-Id: <163149460533.291098.7342418455457691240.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912140820.GD25450@xsang-OptiPlex-9020>
References: <20210912140820.GD25450@xsang-OptiPlex-9020>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to check the xbc_node is used before calling memblock_free()
because passing NULL to phys_addr() will cause a panic.
This will happen if user doesn't pass any bootconfig to the
kernel, because kernel will call xbc_destroy_all() after
booting.

Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c |    3 ++-
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

