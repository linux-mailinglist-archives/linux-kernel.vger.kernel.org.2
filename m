Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C403D3782
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhGWIft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhGWIfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:35:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C69D60EC0;
        Fri, 23 Jul 2021 09:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627031782;
        bh=c6UxR2OHHZll1trbCSFWnnbvEGuBZe5cc3iYlJgBzJM=;
        h=From:To:Cc:Subject:Date:From;
        b=CnQFfD7WJCSzQ1j7aAuujYjlTN+x478CUI4n7HWH2klYxB/evTOFEtPwAx41rqI11
         7BaCHggTBbC9j53kzSXm4uOO4X74Y4CI1exYlcE8Ah1Y3p5P/QX8ZZKTS136y7KLrX
         nteP740ceWczpQUANFcVvU5Z/qkLgmgMdt1GyUu87vl9ouPwXWZmg6jr9O4q9HOout
         ZOISPBUSYV4w/tZ5bnJ95VUsUuqJBz7h1ucbuxZCrQTmDizxVWLx8xa5s4STIJ1fd/
         XtEPK9/BwoDY91e9pyk48svuoBhPc+PZybtceo6wAVqRxZl+159JujH6+U26h67aNg
         2fuuuFcll56cg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] smpboot: remove duplicate inline keyword
Date:   Fri, 23 Jul 2021 11:16:13 +0200
Message-Id: <20210723091618.1750551-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

'static inline void __always_inline' is one more 'inline' than needed,
and it's in the wrong place as gcc points out when extra warnings
are enabled:

kernel/smpboot.c:50:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
   50 | static inline void __always_inline idle_init(unsigned int cpu)

Move it to the right place instead.

Fixes: e9ba16e68cce ("smpboot: Mark idle_init() as __always_inlined to work around aggressive compiler un-inlining")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 21b7953f8242..cf6acab78538 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -47,7 +47,7 @@ void __init idle_thread_set_boot_cpu(void)
  *
  * Creates the thread if it does not exist.
  */
-static inline void __always_inline idle_init(unsigned int cpu)
+static __always_inline void idle_init(unsigned int cpu)
 {
 	struct task_struct *tsk = per_cpu(idle_threads, cpu);
 
-- 
2.29.2

