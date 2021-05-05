Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08DE3733F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEEDkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:40:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:63184 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhEEDks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:40:48 -0400
IronPort-SDR: /6qGUObCmQUh7Ym8pk+jcRZc2jKLjXLhj9U+pLMU/U1kxBTP3RaaEypW4Mm7N7D6M48Lo7sh5w
 BgXLRJYfGJgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="283543173"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="283543173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 20:39:49 -0700
IronPort-SDR: vnskNKp8kJx1esrd37lTsXOUZCgMVC09G5383Kgk3X3E8Bfgr+45mUBIgIoErym1BDD3/XpvCl
 h6OopRC+yTjQ==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="433602351"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 20:39:49 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] sched: Work around undefined behavior in sched class checking
Date:   Tue,  4 May 2021 20:39:45 -0700
Message-Id: <20210505033945.1282851-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

The scheduler initialization code checks that the scheduling
classes are consecutive in memory by comparing the end
addresses with the next address.

Technically in ISO C comparing symbol addresseses outside different objects
is undefined. With LTO gcc 10 tries to exploits this and creates an
unconditional BUG_ON in the scheduler initialization, resulting
in a boot hang.

Use RELOC_HIDE to make this work. This hides the symbols from gcc,
so the optimizer won't make these assumption. I also split
the BUG_ONs in multiple.

Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 kernel/sched/core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..272a654f5293 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8086,12 +8086,20 @@ void __init sched_init(void)
 	unsigned long ptr = 0;
 	int i;
 
-	/* Make sure the linker didn't screw up */
-	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
-	       &fair_sched_class + 1 != &rt_sched_class ||
-	       &rt_sched_class + 1   != &dl_sched_class);
+	/*
+	 * Make sure the linker didn't screw up.
+	 * We have to use RELOC_HIDE to prevent gcc from optimizing
+	 * them to true because they're technically undefined in ISO-C.
+	 */
+	BUG_ON(RELOC_HIDE(&idle_sched_class, 0) + 1 !=
+			RELOC_HIDE(&fair_sched_class, 0));
+	BUG_ON(RELOC_HIDE(&fair_sched_class, 0) + 1 !=
+			RELOC_HIDE(&rt_sched_class, 0));
+	BUG_ON(RELOC_HIDE(&rt_sched_class, 0) + 1 !=
+			RELOC_HIDE(&dl_sched_class, 0));
 #ifdef CONFIG_SMP
-	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
+	BUG_ON(RELOC_HIDE(&dl_sched_class, 0) + 1 !=
+			RELOC_HIDE(&stop_sched_class, 0));
 #endif
 
 	wait_bit_init();
-- 
2.25.4

