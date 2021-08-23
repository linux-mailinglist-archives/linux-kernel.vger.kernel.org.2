Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532CC3F4632
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhHWH5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:57:32 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:54453 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235100AbhHWH5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:57:30 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GtPhZ18Dnz9sh6;
        Mon, 23 Aug 2021 09:56:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BW8ee6j24zPd; Mon, 23 Aug 2021 09:56:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GtPgr62mKz9shw;
        Mon, 23 Aug 2021 09:56:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B66198B780;
        Mon, 23 Aug 2021 09:56:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id g5F9dprrNvfB; Mon, 23 Aug 2021 09:56:08 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 439AA8B796;
        Mon, 23 Aug 2021 09:56:08 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A8EF36BB19; Mon, 23 Aug 2021 06:45:20 +0000 (UTC)
Message-Id: <6457eb4f327313323ed1f70e540bbb4ddc9178fa.1629701106.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/syscalls: Remove __NR__exit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Aug 2021 06:45:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_exit is nowhere used. On most architectures it was removed by
commit 135ab6ec8fda ("[PATCH] remove remaining errno and
__KERNEL_SYSCALLS__ references") but not on powerpc.

powerpc removed __KERNEL_SYSCALLS__ in commit 3db03b4afb3e ("[PATCH]
rename the provided execve functions to kernel_execve"), but __NR_exit
was left over.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/unistd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index b541c690a31c..5eb462af6766 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -9,8 +9,6 @@
 
 #define NR_syscalls	__NR_syscalls
 
-#define __NR__exit __NR_exit
-
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
-- 
2.25.0

