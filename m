Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA1380364
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhENFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 01:35:21 -0400
Received: from ozlabs.ru ([107.174.27.60]:54794 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhENFfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 01:35:20 -0400
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id DADC4AE80046;
        Fri, 14 May 2021 01:33:36 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH kernel] powerpc/makefile: Remove flag duplicates when generating vdso linker scripts
Date:   Fri, 14 May 2021 15:33:34 +1000
Message-Id: <20210514053334.653596-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmd_cpp_lds_S rule already has -P and -U$(ARCH) so there is no need
in duplicating these, clean that up. Since only -C is left and
scripts/Makefile.build have -C removed since
commit 5cb0512c02ec ("Kbuild: don't pass "-C" to preprocessor when processing linker scripts")
this follows the lead and removes CPPFLAGS_vdso(32|64).lds altogether.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

scripts/checkpatch.pl complains as it does not handle quotes in
the commit subject line well. oh well.

---
 arch/powerpc/kernel/vdso32/Makefile | 1 -
 arch/powerpc/kernel/vdso64/Makefile | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 7d9a6fee0e3d..7420e88d5aa3 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -44,7 +44,6 @@ asflags-y := -D__VDSO32__ -s
 
 obj-y += vdso32_wrapper.o
 targets += vdso32.lds
-CPPFLAGS_vdso32.lds += -P -C -Upowerpc
 
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday.o FORCE
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 2813e3f98db6..fb118630c334 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -30,7 +30,6 @@ ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
 asflags-y := -D__VDSO64__ -s
 
 targets += vdso64.lds
-CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday.o FORCE
-- 
2.30.2

