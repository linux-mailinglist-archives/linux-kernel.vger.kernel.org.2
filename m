Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8023A3DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFKICp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:02:45 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50454 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhFKICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:02:10 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 8DE6F29C3A; Fri, 11 Jun 2021 04:00:09 -0400 (EDT)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <a1456e8bbd33ef702e3ff6f14b1bf3919241c62b.1623398307.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] powerpc/tau: Remove superfluous parameter in
 alloc_workqueue() call
Date:   Fri, 11 Jun 2021 17:58:27 +1000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids an (optional) compiler warning:

arch/powerpc/kernel/tau_6xx.c: In function 'TAU_init':
arch/powerpc/kernel/tau_6xx.c:204:30: error: too many arguments for format [-Werror=format-extra-args]
  tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: b1c6a0a10bfa ("powerpc/tau: Convert from timer to workqueue")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Improved commit log message.
---
 arch/powerpc/kernel/tau_6xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 6c31af7f4fa8..b9a047d92ec0 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -201,7 +201,7 @@ static int __init TAU_init(void)
 	tau_int_enable = IS_ENABLED(CONFIG_TAU_INT) &&
 			 !strcmp(cur_cpu_spec->platform, "ppc750");
 
-	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
+	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1);
 	if (!tau_workq)
 		return -ENOMEM;
 
-- 
2.26.3

