Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9AB3663CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhDUC5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhDUC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:57:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D207C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2JiDXZbZ8SpO8qTm6wyXrlDCXFtOPxAEjErfi1c1/oo=; b=uvgAT6XN0ZrFg41CpUOqjPXHb5
        3ueC2vMYlqKjNR6tcaD5tTiDzqPLmtk5CII2rk/RlEfhm5KRWJ9YqE2l7N3tk2aY9C+K7FE37c1PH
        MXAUBjrnPltedssHCpKJihqgRsb4EB7eQzH4ae5x9jBWEhvnbaAD7qaWZIgIjr1TeRB00JTKUjUN8
        iML6vLFkQ7zL03L+jvM11P6xZClOxC3LhV6EDtGO27RONvzcb6tvdzWflxp7UWemSrkVruD2yTUgf
        uMmTJty2q+T88WgqsnL8SkGi+5yj+c+oq1FJM5YEXJAGfMafnhirKqs0918KBh1Jd3mV2Xi3mcPp6
        QYIKDqAA==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ328-00FyMS-Pj; Wed, 21 Apr 2021 02:56:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v2] powerpc: make ALTIVEC select PPC_FPU
Date:   Tue, 20 Apr 2021 19:56:05 -0700
Message-Id: <20210421025605.10868-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a kernel config with ALTIVEC=y and PPC_FPU not set/enabled,
there are build errors:

drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
           enable_kernel_fp();
../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
  637 |   put_vr(rn, &u.v);
      |   ^~~~~~
../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
  660 |   get_vr(rn, &u.v);
      |   ^~~~~~

In theory ALTIVEC is independent of PPC_FPU but in practice nobody
is going to build such a machine, so make ALTIVEC require PPC_FPU
by selecting it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: lkp@intel.com
---
v2: change ALTIVEC depends on PPC_FPU to select (Christophe and Michael)

 arch/powerpc/platforms/86xx/Kconfig    |    1 +
 arch/powerpc/platforms/Kconfig.cputype |    2 ++
 2 files changed, 3 insertions(+)

--- linux-next-20210416.orig/arch/powerpc/platforms/86xx/Kconfig
+++ linux-next-20210416/arch/powerpc/platforms/86xx/Kconfig
@@ -4,6 +4,7 @@ menuconfig PPC_86xx
 	bool "86xx-based boards"
 	depends on PPC_BOOK3S_32
 	select FSL_SOC
+	select PPC_FPU
 	select ALTIVEC
 	help
 	  The Freescale E600 SoCs have 74xx cores.
--- linux-next-20210416.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-next-20210416/arch/powerpc/platforms/Kconfig.cputype
@@ -186,6 +186,7 @@ config E300C3_CPU
 config G4_CPU
 	bool "G4 (74xx)"
 	depends on PPC_BOOK3S_32
+	select PPC_FPU
 	select ALTIVEC
 
 endchoice
@@ -310,6 +311,7 @@ config PHYS_64BIT
 config ALTIVEC
 	bool "AltiVec Support"
 	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
+	select PPC_FPU
 	help
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
