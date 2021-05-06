Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622C375350
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhEFL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:57:33 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39081 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhEFL5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:57:32 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FbX9Y2qY2z9sYT;
        Thu,  6 May 2021 13:56:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cK5fxFFitLtq; Thu,  6 May 2021 13:56:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FbX9W6kwdz9sYW;
        Thu,  6 May 2021 13:56:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B34638B7FB;
        Thu,  6 May 2021 13:56:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ttLDyMgLHjqb; Thu,  6 May 2021 13:56:31 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FF448B7F8;
        Thu,  6 May 2021 13:56:31 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4402A64885; Thu,  6 May 2021 11:56:31 +0000 (UTC)
Message-Id: <332773775cf24a422105dee2d383fb8f04589045.1620302182.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/syscall: Calling kuap_save_and_lock() is wrong
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 May 2021 11:56:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kuap_save_and_lock() is only for interrupts inside kernel.

system call are only from user, calling kuap_save_and_lock()
is wrong.

Fixes: c16728835eec ("powerpc/32: Manage KUAP in C")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/interrupt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index e4559f8914eb..30a596182baa 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -34,9 +34,6 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	syscall_fn f;
 
 	kuep_lock();
-#ifdef CONFIG_PPC32
-	kuap_save_and_lock(regs);
-#endif
 
 	regs->orig_gpr3 = r3;
 
-- 
2.25.0

