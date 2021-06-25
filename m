Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C23B4202
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFYLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:00:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22095 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYLAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:00:55 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GBDWZ3QW7zBBQx;
        Fri, 25 Jun 2021 12:58:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YKKOMRpzcYAA; Fri, 25 Jun 2021 12:58:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GBDWZ2XD5zBBQK;
        Fri, 25 Jun 2021 12:58:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46F458B802;
        Fri, 25 Jun 2021 12:58:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id boX5p_mQhbqJ; Fri, 25 Jun 2021 12:58:34 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 145158B7FF;
        Fri, 25 Jun 2021 12:58:34 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 93CBC66377; Fri, 25 Jun 2021 10:58:33 +0000 (UTC)
Message-Id: <373ec500f386374bc5735007df3d3869eac47be1.1624618701.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/syscalls: Simplify do_mmap2()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jun 2021 10:58:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shift is nul, operations remain valid so no test needed.

And 'ret' is unnecessary.

And use IS_ALIGNED() to check alignment, that's more clear.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/syscalls.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index bf4ae0f0e36c..825931e400df 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -41,20 +41,13 @@ static inline long do_mmap2(unsigned long addr, size_t len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long off, int shift)
 {
-	long ret = -EINVAL;
-
 	if (!arch_validate_prot(prot, addr))
-		goto out;
+		return -EINVAL;
 
-	if (shift) {
-		if (off & ((1 << shift) - 1))
-			goto out;
-		off >>= shift;
-	}
+	if (!IS_ALIGNED(off, 1 << shift))
+		return -EINVAL;
 
-	ret = ksys_mmap_pgoff(addr, len, prot, flags, fd, off);
-out:
-	return ret;
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> shift);
 }
 
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
-- 
2.25.0

