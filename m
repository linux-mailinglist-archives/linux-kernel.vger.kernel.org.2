Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1232A37E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378927AbhCBJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:06:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13412 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345045AbhCBItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:49:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DqW2m1B9dzjTLc;
        Tue,  2 Mar 2021 16:46:56 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.44) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 16:48:12 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Barry Song" <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@suse.de>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: [PATCH] Documentation/admin-guide: kernel-parameters: correct the architectures for numa_balancing
Date:   Tue, 2 Mar 2021 21:41:59 +1300
Message-ID: <20210302084159.33688-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.44]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86 isn't the only architecture supporting NUMA_BALANCING. ARM64, PPC,
S390 and RISCV also support it:

arch$ git grep NUMA_BALANCING
arm64/Kconfig:  select ARCH_SUPPORTS_NUMA_BALANCING
arm64/configs/defconfig:CONFIG_NUMA_BALANCING=y
arm64/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
powerpc/configs/powernv_defconfig:CONFIG_NUMA_BALANCING=y
powerpc/configs/ppc64_defconfig:CONFIG_NUMA_BALANCING=y
powerpc/configs/pseries_defconfig:CONFIG_NUMA_BALANCING=y
powerpc/include/asm/book3s/64/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
powerpc/include/asm/book3s/64/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
powerpc/include/asm/book3s/64/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */
powerpc/include/asm/book3s/64/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
powerpc/include/asm/book3s/64/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */
powerpc/include/asm/nohash/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
powerpc/include/asm/nohash/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */
powerpc/platforms/Kconfig.cputype:      select ARCH_SUPPORTS_NUMA_BALANCING
riscv/Kconfig:  select ARCH_SUPPORTS_NUMA_BALANCING
riscv/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
s390/Kconfig:   select ARCH_SUPPORTS_NUMA_BALANCING
s390/configs/debug_defconfig:CONFIG_NUMA_BALANCING=y
s390/configs/defconfig:CONFIG_NUMA_BALANCING=y
s390/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
x86/Kconfig:    select ARCH_SUPPORTS_NUMA_BALANCING     if X86_64
x86/include/asm/pgtable.h:#ifdef CONFIG_NUMA_BALANCING
x86/include/asm/pgtable.h:#endif /* CONFIG_NUMA_BALANCING */

On the other hand, setup_numabalancing() is implemented in mm/mempolicy.c
which doesn't depend on architectures.

Cc: Mel Gorman <mgorman@suse.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 1 +
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 1132796a8d96..24302cad174a 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -140,6 +140,7 @@ parameter is applicable::
 	PPT	Parallel port support is enabled.
 	PS2	Appropriate PS/2 support is enabled.
 	RAM	RAM disk support is enabled.
+	RISCV	RISCV architecture is enabled.
 	RDT	Intel Resource Director Technology.
 	S390	S390 architecture is enabled.
 	SCSI	Appropriate SCSI support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..371a02ae1e21 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3472,7 +3472,8 @@
 
 	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
 
-	numa_balancing=	[KNL,X86] Enable or disable automatic NUMA balancing.
+	numa_balancing=	[KNL,ARM64,PPC,RISCV,S390,X86] Enable or disable automatic
+			NUMA balancing.
 			Allowed values are enable and disable
 
 	numa_zonelist_order= [KNL, BOOT] Select zonelist order for NUMA.
-- 
2.25.1

