Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B7A40309F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbhIGWBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:01:52 -0400
Received: from home.keithp.com ([63.227.221.253]:56072 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347380AbhIGWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:01:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 136533F30867;
        Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id LYoWbEmDiZX3; Tue,  7 Sep 2021 15:00:18 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id A3F673F30861;
        Tue,  7 Sep 2021 15:00:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
        id D854B1E6013A; Tue,  7 Sep 2021 15:00:40 -0700 (PDT)
From:   Keith Packard <keithpac@amazon.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: [PATCH 4/7] ARM: Use hack from powerpc to get current cpu number
Date:   Tue,  7 Sep 2021 15:00:35 -0700
Message-Id: <20210907220038.91021-5-keithpac@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907220038.91021-1-keithpac@amazon.com>
References: <20210904060908.1310204-1-keithp@keithp.com>
 <20210907220038.91021-1-keithpac@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we enable THREAD_INFO_IN_TASK, the cpu number will disappear from
thread_info and reappear in task_struct. As we cannot include
linux/sched.h in asm/smp.h, there's no way to use that struct type in
the raw_smp_processor_id macro. Instead, a hack from the powerpc code
is used. This pulls the TI_CPU offset out of asm-offsets.h and uses
that to find the cpu value.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/Makefile          |  8 ++++++++
 arch/arm/include/asm/smp.h | 18 +++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 415c3514573a..6752995d2914 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -284,6 +284,14 @@ stack_protector_prepare: prepare0
 	$(eval GCC_PLUGINS_CFLAGS += $(SSP_PLUGIN_CFLAGS))
 endif
 
+ifdef CONFIG_SMP
+prepare: task_cpu_prepare
+
+PHONY += task_cpu_prepare
+task_cpu_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -D_TI_CPU=$(shell awk '{if ($$2 == "TI_CPU") print $$3;}' include/generated/asm-offsets.h))
+endif
+
 all:	$(notdir $(KBUILD_IMAGE))
 
 
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index d43b64635d77..f77ba3753bc4 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -15,7 +15,23 @@
 # error "<asm/smp.h> included in non-SMP build"
 #endif
 
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+/*
+ * This is particularly ugly: it appears we can't actually get the
+ * definition of task_struct here, but we need access to the CPU this
+ * task is running on, which is stored in task_struct when
+ * THREAD_INFO_IN_TASK is set.  Instead of using task_struct we're
+ * using TI_CPU which is extracted from asm-offsets.h by kbuild to get
+ * the current processor ID.
+ *
+ * This also needs to be safeguarded when building asm-offsets.s
+ * because at that time TI_CPU is not defined yet.
+ */
+#ifndef _TI_CPU
+#define raw_smp_processor_id()		(0)
+#else
+#define raw_smp_processor_id()	\
+	(*(unsigned int *)((void *)current_thread_info() + _TI_CPU))
+#endif
 
 struct seq_file;
 
-- 
2.33.0

