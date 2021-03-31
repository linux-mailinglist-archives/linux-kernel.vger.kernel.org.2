Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57D734FC40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhCaJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:12:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11184 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhCaJMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:12:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9LDf6FVrz9v077;
        Wed, 31 Mar 2021 11:12:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FLi6KVY5Vd5c; Wed, 31 Mar 2021 11:12:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9LDf5PXTz9v076;
        Wed, 31 Mar 2021 11:12:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A57BF8B7F8;
        Wed, 31 Mar 2021 11:12:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7CojbRHYE_Jc; Wed, 31 Mar 2021 11:12:19 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 63D5C8B7FB;
        Wed, 31 Mar 2021 11:12:19 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 28D8D67624; Wed, 31 Mar 2021 09:12:19 +0000 (UTC)
Message-Id: <8bb015bc98c51d8ced581415b7e3d157e18da7c9.1617181918.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/vdso: Make sure vdso_wrapper.o is rebuilt everytime
 vdso.so is rebuilt
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 31 Mar 2021 09:12:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of
vgettimeofday.o") moved vdso32_wrapper.o and vdso64_wrapper.o out
of arch/powerpc/kernel/vdso[32/64]/ and removed the dependencies in
the Makefile. This leads to the wrappers not being re-build hence the
kernel embedding the old vdso library.

Add back missing dependencies to ensure vdso32_wrapper.o and vdso64_wrapper.o
are rebuilt when vdso32.so.dbg and vdso64.so.dbg are changed.

Fixes: bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of vgettimeofday.o")
Cc: stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 6084fa499aa3..f66b63e81c3b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -191,3 +191,7 @@ $(obj)/prom_init_check: $(src)/prom_init_check.sh $(obj)/prom_init.o FORCE
 targets += prom_init_check
 
 clean-files := vmlinux.lds
+
+# Force dependency (incbin is bad)
+$(obj)/vdso32_wrapper.o : $(obj)/vdso32/vdso32.so.dbg
+$(obj)/vdso64_wrapper.o : $(obj)/vdso64/vdso64.so.dbg
-- 
2.25.0

