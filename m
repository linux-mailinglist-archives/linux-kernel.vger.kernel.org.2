Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7B40BCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhIOAya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhIOAy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E3061165;
        Wed, 15 Sep 2021 00:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667188;
        bh=sKvjf2fiiYwNnsu3EWnRbm2IWieh3kqYhZMnjiu1GMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J2qweMngdGf7vLP9t+edQUOaQ/BYkkuPzneCCroClzxX0lLigowVrMrWTS1OQcV0F
         aO+HeHOiF31fbPlISjgAla6TwpGuMswVe13wGRfrsri3exSHoN/680zOpTMtNy/kdI
         OZZVBIMgjNAMbtmvBwIAc5PNn3o2SrA0AizZ/+Y5wzJz3GTwDgyuXwn68TRFSOABlX
         cUij6FGxgSaZH4JL/YB2BBAn7jOLwWmw4mHevSNAIbxZXzpsw5IjgCmOhfafrLgAhK
         q4+CFPGFIZgcfB6MmQI+VeobecggDh5aNboGvA0RR5go7jlMAWDEK8saSSwpTNe6Aq
         XZ/N0LwrmTEFQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 1/5] bootconfig: Fix to check the xbc_node is used before free it
Date:   Wed, 15 Sep 2021 09:53:06 +0900
Message-Id: <163166718582.510331.11732633028925882626.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163166717752.510331.12843735095061762373.stgit@devnote2>
References: <163166717752.510331.12843735095061762373.stgit@devnote2>
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
 Changes in v2:
   - Rebase on top of Linus tree.
---
 lib/bootconfig.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 5ae248b29373..bee691ea8213 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -792,7 +792,8 @@ void __init xbc_destroy_all(void)
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memblock_free_ptr(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
+	if (xbc_nodes)
+		memblock_free_ptr(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }

