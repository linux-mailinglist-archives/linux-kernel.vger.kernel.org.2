Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB973FF08E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345981AbhIBP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:56:13 -0400
Received: from home.keithp.com ([63.227.221.253]:52850 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345970AbhIBP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:56:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 5D2893F30806;
        Thu,  2 Sep 2021 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630598089; bh=sKaMNUHjQ3yEirvOb9Xh+Di4q4WBqN5Br/NOaG4o3yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQhsJjM9AK0StdMYmrOSg9L+I9AbakkSLxsMf8uqclHOllqgQ6WvYo3WjLQZg//N6
         H38znQ2Shov5w6W9Czsp6M4J/cBj1hzbIVg2eGuu96/W6WxETret0FWCJRlGzh1grh
         tJVDjFlGNrBCPieybEYtmDAuNAP8Sx7FLVPINpqzMTq+MBQGUvbsm0MVeDV3uvPmPw
         emCJzJByZ4vIsaH14jJxhac9I9VQQrte675X7o92yaSb++RvTcxzJoODe0j+kgBBU4
         ExK8gDr7ysbOnPfP764psSwOwZ8oFCWI3b1/74iDmJN4aYmhECZaOzsh295usVzrbA
         F766rSrfvbRcw==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Dk0ic6zy8LHw; Thu,  2 Sep 2021 08:54:44 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 6F9B33F30803;
        Thu,  2 Sep 2021 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630598084; bh=sKaMNUHjQ3yEirvOb9Xh+Di4q4WBqN5Br/NOaG4o3yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkLO9pbUhAr0o/4eaRHQY+AnJgnxrB4nQh3ukE+15Ut/2DmKwgvkR8gfv3/dWkoRy
         Y7i3QNHSxOr7ip2YdFx2rpMR3pt585hvsIOHqGgaKQy0cxfllwFEfedcnpGzviJ2DO
         OW7ZEFrVqEVod2gOTdmC1rd73tvvthjZHYMqMB9faj0TSeKIBxhuDiCZjoChCB+oO2
         W3MxZBHa9JuFi/6Sd7Kmosmydl2RPLmy6U027cONLEQEPSpM3b27wKh9VUv8JRJf5/
         GZdjw5cQVxc6kCHWbPY8RCChR2/U28J3+7faYlXkf2BjAISbfwwxdjLyRv9MENjiZm
         B95ED2a2WGYsg==
Received: by keithp.com (Postfix, from userid 1000)
        id 9B42C1E60119; Thu,  2 Sep 2021 08:55:06 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Keith Packard <keithp@keithp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Subject: [PATCH 1/2] ARM: Add per-cpu variable holding cpu number
Date:   Thu,  2 Sep 2021 08:54:27 -0700
Message-Id: <20210902155429.3987201-2-keithp@keithp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902155429.3987201-1-keithp@keithp.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help move thread_info into task_struct, stop using the cpu number
contained in the thread_info block in C code and use a per-cpu
variable instead. This value will be initialized long before the
task_struct cpu value for the various idle threads are set, which
avoids ordering issues during CPU startup.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/include/asm/smp.h |  5 ++++-
 arch/arm/kernel/smp.c      | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 5d508f5d56c4..3aca2c2089bc 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -15,7 +15,10 @@
 # error "<asm/smp.h> included in non-SMP build"
 #endif
 
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() this_cpu_read(cpu_number)
+#define __smp_processor_id() __this_cpu_read(cpu_number)
+
+DECLARE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);
 
 struct seq_file;
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 74679240a9d8..0457e25109c6 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -51,6 +51,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
+DEFINE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);
+EXPORT_PER_CPU_SYMBOL(cpu_number);
+
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -495,6 +498,7 @@ void __init smp_prepare_boot_cpu(void)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int ncores = num_possible_cpus();
+	unsigned int cpu;
 
 	init_cpu_topology();
 
@@ -505,6 +509,16 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	if (max_cpus > ncores)
 		max_cpus = ncores;
+
+	/*
+	 * Initialize the cpu_number value for each cpu before we
+	 * start it. This ensures that the value is valid during cpu
+	 * initialization, even before the idle task_struct cpu member
+	 * is set
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(cpu_number, cpu) = cpu;
+
 	if (ncores > 1 && max_cpus) {
 		/*
 		 * Initialise the present map, which describes the set of CPUs
-- 
2.33.0

