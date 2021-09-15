Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D822740BCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhIOAzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233197AbhIOAy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:54:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE6276103B;
        Wed, 15 Sep 2021 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667220;
        bh=QfAiGsW60lLRZ4WZ3voUQCHotfWarlUyocpqA9j3zHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjyDzkqNUP4Dpo0RbzbUhYtTFDIgmyJBQ8lmQsggtTEPYYmE8O5I++FysDZd/oa24
         UfvE8wlpv8BOPrMAnYv9bUWaT6QAUWQahihDqZPD9EehDLeuRHOpqfc8ceRkqjygep
         XODdfm8SmtzqQvwp/bLcD+ZQl6Ve/jhfYmlHunUM9JUOaUVd4bDtL87hBJSHRskMgp
         FfIkqxSm63j2Eix7oM+J9NO+0YF2BgeGNUS7jXX6g970OKfg1fFz4dDqgGR+AOv7bb
         +1CuZgR+ujEt6Vahp5MN75C6soVVNAxX3N4VmTi5gZxnKnpUETHNYq30Coe+aaOFxA
         HxyLYiXznP/fA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 5/5] tools/bootconfig: Define memblock_free_ptr() to fix build error
Date:   Wed, 15 Sep 2021 09:53:38 +0900
Message-Id: <163166721835.510331.4931010992364519157.stgit@devnote2>
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

Since commit 77e02cf57b6c ("memblock: introduce saner
'memblock_free_ptr()' interface") introduced memblock_free_ptr()
to lib/bootconfig.c, bootconfig tool also has to define
memblock_free_ptr() wrapper, and remove unused __pa() and
memblock_free().

Fixes: 77e02cf57b6c ("memblock: introduce saner 'memblock_free_ptr()' interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/include/linux/memblock.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/bootconfig/include/linux/memblock.h b/tools/bootconfig/include/linux/memblock.h
index 7862f217d85d..f2e506f7d57f 100644
--- a/tools/bootconfig/include/linux/memblock.h
+++ b/tools/bootconfig/include/linux/memblock.h
@@ -4,9 +4,8 @@
 
 #include <stdlib.h>
 
-#define __pa(addr)	(addr)
 #define SMP_CACHE_BYTES	0
 #define memblock_alloc(size, align)	malloc(size)
-#define memblock_free(paddr, size)	free(paddr)
+#define memblock_free_ptr(paddr, size)	free(paddr)
 
 #endif

