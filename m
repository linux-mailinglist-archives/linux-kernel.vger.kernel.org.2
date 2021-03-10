Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090223345D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhCJR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:57:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60148 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233354AbhCJR5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:57:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwfsp6CwJz9v04R;
        Wed, 10 Mar 2021 18:57:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RSmSeYYwqfjB; Wed, 10 Mar 2021 18:57:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwfsp5Cthz9tytT;
        Wed, 10 Mar 2021 18:57:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 90B508B78D;
        Wed, 10 Mar 2021 18:57:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C2GPI0QuFZJi; Wed, 10 Mar 2021 18:57:04 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 239268B77E;
        Wed, 10 Mar 2021 18:57:04 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8CFDD6756B; Wed, 10 Mar 2021 17:57:03 +0000 (UTC)
Message-Id: <4de983ad254739da1fe6e9f273baf387b7043ae0.1615398498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398498.git.christophe.leroy@csgroup.eu>
References: <cover.1615398498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/8] powerpc/syscalls: Use sys_old_select() in ppc_select()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:57:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of opencodying the copy of parameters, use
the generic sys_old_select().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/unistd.h |  1 +
 arch/powerpc/kernel/syscalls.c    | 12 ++----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 700fcdac2e3c..b541c690a31c 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -40,6 +40,7 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #ifdef CONFIG_PPC32
 #define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_SYS_OLD_SELECT
 #endif
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_SYS_TIME
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 078608ec2e92..a552c9e68d7e 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -82,16 +82,8 @@ int
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
 {
 	if ( (unsigned long)n >= 4096 )
-	{
-		unsigned long __user *buffer = (unsigned long __user *)n;
-		if (!access_ok(buffer, 5*sizeof(unsigned long))
-		    || __get_user(n, buffer)
-		    || __get_user(inp, ((fd_set __user * __user *)(buffer+1)))
-		    || __get_user(outp, ((fd_set  __user * __user *)(buffer+2)))
-		    || __get_user(exp, ((fd_set  __user * __user *)(buffer+3)))
-		    || __get_user(tvp, ((struct __kernel_old_timeval  __user * __user *)(buffer+4))))
-			return -EFAULT;
-	}
+		return sys_old_select((void __user *)n);
+
 	return sys_select(n, inp, outp, exp, tvp);
 }
 #endif
-- 
2.25.0

