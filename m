Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A369734C1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC2C1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:27:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14504 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhC2C1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:27:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F7xHl4PXrzwPW0;
        Mon, 29 Mar 2021 10:25:07 +0800 (CST)
Received: from [10.174.177.134] (10.174.177.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 10:27:01 +0800
Subject: [PATCH v2] powerpc: Fix HAVE_HARDLOCKUP_DETECTOR_ARCH build
 configuration
From:   Chen Huang <chenhuang5@huawei.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>
CC:     Don Zickus <dzickus@redhat.com>, <linux-kernel@vger.kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Hulk Robot <hulkci@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linuxppc-dev@lists.ozlabs.org>
References: <20210327094900.938555-1-chenhuang5@huawei.com>
 <dd6b25d3-006b-be1e-9c4f-89e66aefb519@csgroup.eu>
 <e8eddfd4-ca07-f2ba-42de-19e636dc2ce9@huawei.com>
Message-ID: <4b8f8335-0a29-93fc-7943-b4dc16efb908@huawei.com>
Date:   Mon, 29 Mar 2021 10:27:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e8eddfd4-ca07-f2ba-42de-19e636dc2ce9@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the powerpc with the SMP disabled, it shows the issue:

arch/powerpc/kernel/watchdog.c: In function ‘watchdog_smp_panic’:
arch/powerpc/kernel/watchdog.c:177:4: error: implicit declaration of function ‘smp_send_nmi_ipi’; did you mean ‘smp_send_stop’? [-Werror=implicit-function-declaration]
  177 |    smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
      |    ^~~~~~~~~~~~~~~~
      |    smp_send_stop
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:273: arch/powerpc/kernel/watchdog.o] Error 1
make[1]: *** [scripts/Makefile.build:534: arch/powerpc/kernel] Error 2
make: *** [Makefile:1980: arch/powerpc] Error 2
make: *** Waiting for unfinished jobs....

We found that powerpc used ipi to implement hardlockup watchdog, so the
HAVE_HARDLOCKUP_DETECTOR_ARCH should depend on the SMP.

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 764df010baee..a5196e1a1281 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -210,6 +210,7 @@ config PPC
    select HAVE_FUNCTION_TRACER
    select HAVE_GCC_PLUGINS         if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
    select HAVE_GENERIC_VDSO
+   select HAVE_HARDLOCKUP_DETECTOR_ARCH    if PPC_BOOK3S_64 && SMP
    select HAVE_HW_BREAKPOINT       if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
    select HAVE_IDE
    select HAVE_IOREMAP_PROT
@@ -225,7 +226,6 @@ config PPC
    select HAVE_LIVEPATCH           if HAVE_DYNAMIC_FTRACE_WITH_REGS
    select HAVE_MOD_ARCH_SPECIFIC
    select HAVE_NMI             if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
-   select HAVE_HARDLOCKUP_DETECTOR_ARCH    if (PPC64 && PPC_BOOK3S)
    select HAVE_OPTPROBES           if PPC64
    select HAVE_PERF_EVENTS
    select HAVE_PERF_EVENTS_NMI     if PPC64
--
2.17.1


