Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057F344C01C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhKJL1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:27:43 -0500
Received: from foss.arm.com ([217.140.110.172]:45150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhKJL1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:27:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED23B101E;
        Wed, 10 Nov 2021 03:24:54 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C92E3F718;
        Wed, 10 Nov 2021 03:24:54 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mike Galbraith <efault@gmx.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: Split preemption model selection between DYNAMIC & !DYNAMIC
In-Reply-To: <beec14cee84de7a4bedd7a63c2acdf150a82bc09.camel@gmx.de>
References: <20211109151057.3489223-1-valentin.schneider@arm.com> <20211110011738.GD288354@lothringen> <beec14cee84de7a4bedd7a63c2acdf150a82bc09.camel@gmx.de>
Date:   Wed, 10 Nov 2021 11:24:48 +0000
Message-ID: <87h7cks16n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 05:37, Mike Galbraith wrote:
> On Wed, 2021-11-10 at 02:17 +0100, Frederic Weisbecker wrote:
>> The problem here is that you're duplicating the existing titles
>> for the static entries and you're losing all the help that text that used to come
>> along. The point of the BEHAVIOUR thing, further mapping to either
>> static or dynamic preemption, was to avoid that duplication and keep the
>> same titles and help for the three behaviour, whether static or dynamic.
>
> Adding "depends on !PREEMPT_DYNAMIC" to the first (legacy?) choice made
> it appear/disappear at the appropriate time as well, but I have no idea
> how duplication of help text can be avoided.
>
>       -Mike

Following Frederic's _STATIC suggestion, I got to the below. The nice thing
is if a defconfig picks say PREEMPT_VOLUNTARY and the arch supports
PREEMPT_DYNAMIC, then it'll pick PREEMPT_VOLUNTARY_BEHAVIOUR. The less nice
thing is that we end up selecting PREEMPT_STATIC for PREEMPT_DYNAMIC
kernels, naming's hard... Maybe _BUILD rather than _STATIC?

---
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2776423a587e..1fa8f6fb3c55 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -88,7 +88,7 @@
 struct completion;
 struct user;
 
-#ifdef CONFIG_PREEMPT_VOLUNTARY
+#ifdef CONFIG_PREEMPT_VOLUNTARY_STATIC
 
 extern int __cond_resched(void);
 # define might_resched() __cond_resched()
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index 1eaaa93c37bf..0a311d7aab62 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -15,7 +15,7 @@
 #else
 #define MODULE_VERMAGIC_SMP ""
 #endif
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT_STATIC
 #define MODULE_VERMAGIC_PREEMPT "preempt "
 #elif defined(CONFIG_PREEMPT_RT)
 #define MODULE_VERMAGIC_PREEMPT "preempt_rt "
@@ -39,9 +39,9 @@
 #define MODULE_RANDSTRUCT_PLUGIN
 #endif
 
-#define VERMAGIC_STRING 						\
+#define VERMAGIC_STRING							\
 	UTS_RELEASE " "							\
-	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT 			\
+	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT			\
 	MODULE_VERMAGIC_MODULE_UNLOAD MODULE_VERMAGIC_MODVERSIONS	\
 	MODULE_ARCH_VERMAGIC						\
 	MODULE_RANDSTRUCT_PLUGIN
diff --git a/init/Makefile b/init/Makefile
index 2846113677ee..989f43d23b83 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -30,7 +30,7 @@ $(obj)/version.o: include/generated/compile.h
 quiet_cmd_compile.h = CHK     $@
       cmd_compile.h = \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
-	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"	\
+	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_STATIC)"	\
 	"$(CONFIG_PREEMPT_RT)" $(CONFIG_CC_VERSION_TEXT) "$(LD)"
 
 include/generated/compile.h: FORCE
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 60f1bfc3c7b2..1761966c815e 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -1,12 +1,40 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+
+choice
+	prompt "[Legacy compatibility] Preemption Model"
+
+config PREEMPT_NONE
+	bool "No Forced Preemption (Server)"
+
+config PREEMPT_VOLUNTARY
+	bool "Voluntary Kernel Preemption (Desktop)"
+
+config PREEMPT
+	bool "Preemptible Kernel (Low-Latency Desktop)"
+
+endchoice
+
+config PREEMPT_NONE_STATIC
+	bool
+
+config PREEMPT_VOLUNTARY_STATIC
+	bool
+
+config PREEMPT_STATIC
+	bool
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+
 choice
 	prompt "Preemption Model"
+	default PREEMPT_BEHAVIOUR if PREEMPT
+	default PREEMPT_VOLUNTARY_BEHAVIOUR if PREEMPT_VOLUNTARY
 	default PREEMPT_NONE_BEHAVIOUR
 
 config PREEMPT_NONE_BEHAVIOUR
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE if !PREEMPT_DYNAMIC
+	select PREEMPT_NONE_STATIC if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -21,7 +49,7 @@ config PREEMPT_NONE_BEHAVIOUR
 config PREEMPT_VOLUNTARY_BEHAVIOUR
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
+	select PREEMPT_VOLUNTARY_STATIC if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -40,7 +68,7 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
 config PREEMPT_BEHAVIOUR
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT
+	select PREEMPT_STATIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -58,7 +86,7 @@ config PREEMPT_BEHAVIOUR
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
+	depends on EXPERT && ARCH_SUPPORTS_RT
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -75,17 +103,6 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_NONE
-	bool
-
-config PREEMPT_VOLUNTARY
-	bool
-
-config PREEMPT
-	bool
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-
 config PREEMPT_COUNT
        bool
 
@@ -95,8 +112,8 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC
-	select PREEMPT
+	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	select PREEMPT_STATIC
 	default y
 	help
 	  This option allows to define the preemption model on the kernel
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index dc55fd5a36fc..83dd9e6a8235 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1005,13 +1005,13 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
 	else
 		nthreads *= 2;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
+	if (!IS_ENABLED(CONFIG_PREEMPTION) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
 		/*
 		 * Without any preemption, keep 2 CPUs free for other tasks, one
 		 * of which is the main test case function checking for
 		 * completion or failure.
 		 */
-		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
+		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE_STATIC) ? 2 : 0;
 		const long min_required_cpus = 2 + min_unused_cpus;
 
 		if (num_online_cpus() < min_required_cpus) {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7896d30d90f7..67413be56f22 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4271,11 +4271,11 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   entries,
 		   total,
 		   buf->cpu,
-#if defined(CONFIG_PREEMPT_NONE)
+#if defined(CONFIG_PREEMPT_NONE_STATIC)
 		   "server",
-#elif defined(CONFIG_PREEMPT_VOLUNTARY)
+#elif defined(CONFIG_PREEMPT_VOLUNTARY_STATIC)
 		   "desktop",
-#elif defined(CONFIG_PREEMPT)
+#elif defined(CONFIG_PREEMPT_STATIC)
 		   "preempt",
 #elif defined(CONFIG_PREEMPT_RT)
 		   "preempt_rt",

