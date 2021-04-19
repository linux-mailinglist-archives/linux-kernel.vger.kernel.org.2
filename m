Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB5363B50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhDSGNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:13:48 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:40264 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDSGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:13:40 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8FAA9D1682;
        Mon, 19 Apr 2021 14:13:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P31921T139684376160000S1618812788714406_;
        Mon, 19 Apr 2021 14:13:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <84122d38d400c439bdc987e3e8f738b2>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: tglx@linutronix.de
X-RCPT-COUNT: 16
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, nivedita@alum.mit.edu, clin@suse.com,
        andriy.shevchenko@linux.intel.com, ndesaulniers@google.com,
        dan.j.williams@intel.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jroedel@suse.de, peterz@infradead.org, jpoimboe@redhat.com,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v3] X86: Makefile: Replace -pg with CC_FLAGS_FTRACE
Date:   Mon, 19 Apr 2021 14:13:07 +0800
Message-Id: <20210419061307.29583-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for x86 supporting ftrace built on other compiler
options, let's have the x86 Makefiles remove the $(CC_FLAGS_FTRACE)
flags, whatever these may be, rather than assuming '-pg'.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
v3:add the same change in the arch/x86/um/vdso/Makefile.
 arch/x86/entry/vdso/Makefile |  8 ++++----
 arch/x86/kernel/Makefile     | 16 ++++++++--------
 arch/x86/kernel/cpu/Makefile |  4 ++--
 arch/x86/lib/Makefile        |  2 +-
 arch/x86/mm/Makefile         |  4 ++--
 arch/x86/um/vdso/Makefile    |  4 ++--
 arch/x86/xen/Makefile        |  6 +++---
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 05c4abc2fdfd..c5bd91bf9f93 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -96,10 +96,10 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-CFLAGS_REMOVE_vclock_gettime.o = -pg
-CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
-CFLAGS_REMOVE_vgetcpu.o = -pg
-CFLAGS_REMOVE_vsgx.o = -pg
+CFLAGS_REMOVE_vclock_gettime.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_vdso32/vclock_gettime.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_vgetcpu.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_vsgx.o = $(CC_FLAGS_FTRACE)
 
 #
 # X32 processes use x32 vDSO to access 64bit kernel data.
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ddf08351f0b..2811fc6a17ba 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -13,14 +13,14 @@ CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
-CFLAGS_REMOVE_tsc.o = -pg
-CFLAGS_REMOVE_paravirt-spinlocks.o = -pg
-CFLAGS_REMOVE_pvclock.o = -pg
-CFLAGS_REMOVE_kvmclock.o = -pg
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_early_printk.o = -pg
-CFLAGS_REMOVE_head64.o = -pg
-CFLAGS_REMOVE_sev-es.o = -pg
+CFLAGS_REMOVE_tsc.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_paravirt-spinlocks.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_pvclock.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_kvmclock.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_head64.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sev-es.o = $(CC_FLAGS_FTRACE)
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 637b499450d1..4435c6de9145 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -5,8 +5,8 @@
 
 # Don't trace early stages of a secondary CPU boot
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_common.o = -pg
-CFLAGS_REMOVE_perf_event.o = -pg
+CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
 endif
 
 # If these files are instrumented, boot hangs during the first second.
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index bad4dee4f0e4..0aa71b8a5bc1 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -21,7 +21,7 @@ KASAN_SANITIZE_cmdline.o  := n
 KCSAN_SANITIZE_cmdline.o  := n
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_cmdline.o = -pg
+CFLAGS_REMOVE_cmdline.o = $(CC_FLAGS_FTRACE)
 endif
 
 CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219221ca..91883d5a0293 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -12,8 +12,8 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KCSAN_SANITIZE := n
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_mem_encrypt.o		= -pg
-CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
+CFLAGS_REMOVE_mem_encrypt.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_mem_encrypt_identity.o	= $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 5943387e3f35..f4ddec8aa1ca 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -50,8 +50,8 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
-CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
+CFLAGS_REMOVE_vdso-note.o = $(CC_FLAGS_FTRACE) -fprofile-arcs -ftest-coverage
+CFLAGS_REMOVE_um_vdso.o = $(CC_FLAGS_FTRACE)  -fprofile-arcs -ftest-coverage
 
 #
 # The DSO images are built using a special linker script.
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 40b5779fce21..179dfc124c94 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -2,9 +2,9 @@
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
-CFLAGS_REMOVE_spinlock.o = -pg
-CFLAGS_REMOVE_time.o = -pg
-CFLAGS_REMOVE_irq.o = -pg
+CFLAGS_REMOVE_spinlock.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_irq.o = $(CC_FLAGS_FTRACE)
 endif
 
 # Make sure early boot has no stackprotector
-- 
2.20.1



