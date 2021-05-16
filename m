Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFA3820B0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhEPTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 15:53:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:32884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhEPTxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 15:53:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C7ABAFC6;
        Sun, 16 May 2021 19:52:19 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     glittao@gmail.com
Cc:     akpm@linux-foundation.org, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        paulmck@kernel.org, oliver.sang@intel.com
Subject: [PATCH] mm/slub: use stackdepot to save stack trace in objects-fix
Date:   Sun, 16 May 2021 21:51:50 +0200
Message-Id: <20210516195150.26740-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210414163434.4376-1-glittao@gmail.com>
References: <20210414163434.4376-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul reports [1] lockdep splat HARDIRQ-safe -> HARDIRQ-unsafe lock order detected.
Kernel test robot reports [2] BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c

The stack trace might be saved from contexts where we can't block so GFP_KERNEL
is unsafe. So Use GFP_NOWAIT. Under memory pressure we might thus fail to save
some new unique stack, but that should be extremely rare.

[1] https://lore.kernel.org/linux-mm/20210515204622.GA2672367@paulmck-ThinkPad-P17-Gen-1/
[2] https://lore.kernel.org/linux-mm/20210516144152.GA25903@xsang-OptiPlex-9020/

Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6b896b8c36f0..04824dae2e32 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -623,7 +623,7 @@ static void set_track(struct kmem_cache *s, void *object,
 
 	if (addr) {
 #ifdef CONFIG_STACKDEPOT
-		p->handle = save_stack_depot_trace(GFP_KERNEL);
+		p->handle = save_stack_depot_trace(GFP_NOWAIT);
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
-- 
2.31.1

