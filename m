Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3A3A4950
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFKTNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:13:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55864 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhFKTNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:13:00 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G1r6C5cbXzBBDy;
        Fri, 11 Jun 2021 21:10:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HBHONLCMYOwG; Fri, 11 Jun 2021 21:10:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G1r6B64bHzBB8B;
        Fri, 11 Jun 2021 21:10:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C7E3C8B84C;
        Fri, 11 Jun 2021 21:10:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pNT4urDfuzpd; Fri, 11 Jun 2021 21:10:58 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9414B8B848;
        Fri, 11 Jun 2021 21:10:58 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 53A7B66132; Fri, 11 Jun 2021 19:10:58 +0000 (UTC)
Message-Id: <5e8d2d50f301a346040362028c2ecba40685de9e.1623438544.git.christophe.leroy@csgroup.eu>
In-Reply-To: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
References: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc/watchdog: include linux/processor.h for
 spin_until_cond
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 11 Jun 2021 19:10:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

This implementation uses spin_until_cond in wd_smp_lock including
neither linux/processor.h nor asm/processor.h

This patch includes linux/processor.h here for spin_until_cond usage.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/watchdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c9a8f4781a10..a165635fd214 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -24,6 +24,7 @@
 #include <linux/kdebug.h>
 #include <linux/sched/debug.h>
 #include <linux/delay.h>
+#include <linux/processor.h>
 #include <linux/smp.h>
 
 #include <asm/interrupt.h>
-- 
2.25.0

