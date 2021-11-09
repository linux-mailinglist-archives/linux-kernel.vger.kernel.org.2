Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431D844B015
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhKIPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:13:56 -0500
Received: from foss.arm.com ([217.140.110.172]:35046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhKIPNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:13:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9244CED1;
        Tue,  9 Nov 2021 07:11:09 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A8F1B3F800;
        Tue,  9 Nov 2021 07:11:08 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] sched: Split preemption model selection between DYNAMIC & !DYNAMIC
Date:   Tue,  9 Nov 2021 15:10:57 +0000
Message-Id: <20211109151057.3489223-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Galbraith <efault@gmx.de>

Commit c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic
preempt mode") changed the selectable config names for the preemption
model. This means a config file must now select

  CONFIG_PREEMPT_BEHAVIOUR=y

rather than

  CONFIG_PREEMPT=y

to get a preemptible kernel. This means all arch config files would need to
be updated - right now they'll all end up with the default
CONFIG_PREEMPT_NONE_BEHAVIOUR.

Rather than touch a good hundred of config files, split the preemption
model selection based on PREEMPT_DYNAMIC. !PREEMPT_DYNAMIC reverts to the
old behaviour with CONFIG_PREEMPT & friends being the user-visible config,
while PREEMPT_DYNAMIC exposes the _BEHAVIOUR counterparts.

Signed-off-by: Mike Galbraith <efault@gmx.de>
[Changelog; deduplicated some config logic]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/Kconfig.preempt | 80 +++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 60f1bfc3c7b2..4e60afae248e 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -1,12 +1,32 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config PREEMPT_DYNAMIC
+	bool "Preemption behaviour defined on boot"
+	depends on HAVE_PREEMPT_DYNAMIC && !ARCH_NO_PREEMPT
+	select PREEMPT
+	help
+	  This option allows to define the preemption model on the kernel
+	  command line parameter and thus override the default preemption
+	  model defined during compile time.
+
+	  The feature is primarily interesting for Linux distributions which
+	  provide a pre-built kernel binary to reduce the number of kernel
+	  flavors they offer while still offering different usecases.
+
+	  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enabled
+	  but if runtime patching is not available for the specific architecture
+	  then the potential overhead should be considered.
+
+	  Interesting if you want the same pre-built kernel should be used for
+	  both Server and Desktop workloads.
+
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE_BEHAVIOUR
+	default PREEMPT_NONE
 
-config PREEMPT_NONE_BEHAVIOUR
+config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE if !PREEMPT_DYNAMIC
+	depends on !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -18,10 +38,9 @@ config PREEMPT_NONE_BEHAVIOUR
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
 
-config PREEMPT_VOLUNTARY_BEHAVIOUR
+config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
-	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
+	depends on !ARCH_NO_PREEMPT && !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -37,10 +56,11 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT_BEHAVIOUR
+config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -75,16 +95,23 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_NONE
-	bool
+choice
+	prompt "Default boot-time Preemption Model"
+	depends on PREEMPT_DYNAMIC
+	default PREEMPT_NONE_BEHAVIOUR
+	help
+	  This option defines the default preemption model of the kernel
+	  if it hasn't been specified by the "preempt=" command line parameter.
 
-config PREEMPT_VOLUNTARY
-	bool
+config PREEMPT_NONE_BEHAVIOUR
+	bool "No Forced Preemption (Server)"
 
-config PREEMPT
-	bool
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+config PREEMPT_VOLUNTARY_BEHAVIOUR
+	bool "Voluntary Kernel Preemption (Desktop)"
+
+config PREEMPT_BEHAVIOUR
+	bool "Preemptible Kernel (Low-Latency Desktop)"
+endchoice
 
 config PREEMPT_COUNT
        bool
@@ -93,27 +120,6 @@ config PREEMPTION
        bool
        select PREEMPT_COUNT
 
-config PREEMPT_DYNAMIC
-	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC
-	select PREEMPT
-	default y
-	help
-	  This option allows to define the preemption model on the kernel
-	  command line parameter and thus override the default preemption
-	  model defined during compile time.
-
-	  The feature is primarily interesting for Linux distributions which
-	  provide a pre-built kernel binary to reduce the number of kernel
-	  flavors they offer while still offering different usecases.
-
-	  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enabled
-	  but if runtime patching is not available for the specific architecture
-	  then the potential overhead should be considered.
-
-	  Interesting if you want the same pre-built kernel should be used for
-	  both Server and Desktop workloads.
-
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	depends on SCHED_SMT
-- 
2.25.1

