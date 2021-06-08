Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0139F830
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhFHN5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhFHN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:57:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A03C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9htYwKiUry59OYqli/BjJfSEDIYyPsV25NtHx7S1s5Q=; b=ecT21cBTEdzbofGl/ursvwdwzx
        T0urT7LFTFqIq+NQVAJRx9tMJlaEuZokk+iJsc+jefndHtJLtMnfmjdLLahSoq5jIbd62+Y2bgDNj
        mZkDRLvgtM6H/Yglh8HMRSx7YJWAvvWPDFJIBQ81VwUblDmg8I6JRi6cevtHkC2dbshZpuOXOXo9j
        9airNNnZRoawoPT5fTkesUn3iXC9EoNcI1guSGQykEtt9kZbd6ggpTQJ8YJ1ErDRRMnvoa/esvuA2
        U0ZFTHWVtJtM4FcyYB67IKZzDNrPbPAF2FFObXT0HNpvqMSkGYvMYSvVDibCcbbqYMo+9JWDbIZS/
        3mIvbTSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqcC7-004lf9-8d; Tue, 08 Jun 2021 13:55:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75A4B30018A;
        Tue,  8 Jun 2021 15:55:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C5E6201E7ED1; Tue,  8 Jun 2021 15:55:09 +0200 (CEST)
Date:   Tue, 8 Jun 2021 15:55:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched: Add default dynamic preempt mode Kconfig
Message-ID: <YL92vbcw3ozRLycU@hirez.programming.kicks-ass.net>
References: <20210608120442.93587-1-frederic@kernel.org>
 <20210608120442.93587-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608120442.93587-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:04:41PM +0200, Frederic Weisbecker wrote:
> Currently the default behaviour for CONFIG_PREEMPT_DYNAMIC is
> preempt=full. So distros always have to override that with the boot
> option if it's not their default choice.
> 
> Make things more convenient for them with providing that choice at
> Kconfig time.
> 
> This should also encourage automatic testing robots relying on randconfig
> to run through all the various preempt dynamic flavours.
> 
> (Unfortunately this involved copy-pasting help text for static PREEMPT
> Kconfig entries. Perhaps referring to them would be enough?)
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/Kconfig.preempt | 53 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c    | 23 +++++++++++++++++-
>  2 files changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index bd7c4147b9a8..384110d1a215 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -100,6 +100,59 @@ config PREEMPT_DYNAMIC
>  	  Interesting if you want the same pre-built kernel should be used for
>  	  both Server and Desktop workloads.
>  
> +choice
> +	prompt "Preemption dynamic default boot mode"
> +	default PREEMPT_DYNAMIC_FULL
> +	depends on PREEMPT_DYNAMIC
> +
> +config PREEMPT_DYNAMIC_NONE
> +	bool "Default boot with no Forced Preemption (Server)"
> +	help
> +	  This is the traditional Linux preemption model, geared towards
> +	  throughput. It will still provide good latencies most of the
> +	  time, but there are no guarantees and occasional longer delays
> +	  are possible.
> +
> +	  Select this option if you are building a kernel for a server or
> +	  scientific/computation system, or if you want to maximize the
> +	  raw processing power of the kernel, irrespective of scheduling
> +	  latencies.
> +
> +config PREEMPT_DYNAMIC_VOLUNTARY
> +	bool "Default boot with Voluntary Kernel Preemption (Desktop)"
> +	help
> +	  This option reduces the latency of the kernel by adding more
> +	  "explicit preemption points" to the kernel code. These new
> +	  preemption points have been selected to reduce the maximum
> +	  latency of rescheduling, providing faster application reactions,
> +	  at the cost of slightly lower throughput.
> +
> +	  This allows reaction to interactive events by allowing a
> +	  low priority process to voluntarily preempt itself even if it
> +	  is in kernel mode executing a system call. This allows
> +	  applications to run more 'smoothly' even when the system is
> +	  under load.
> +
> +	  Select this if you are building a kernel for a desktop system.
> +
> +config PREEMPT_DYNAMIC_FULL
> +	bool "Default boot with Preemptible Kernel (Low-Latency Desktop)"
> +	help
> +	  This option reduces the latency of the kernel by making
> +	  all kernel code (that is not executing in a critical section)
> +	  preemptible.  This allows reaction to interactive events by
> +	  permitting a low priority process to be preempted involuntarily
> +	  even if it is in kernel mode executing a system call and would
> +	  otherwise not be about to reach a natural preemption point.
> +	  This allows applications to run more 'smoothly' even when the
> +	  system is under load, at the cost of slightly lower throughput
> +	  and a slight runtime overhead to kernel code.
> +
> +	  Select this if you are building a kernel for a desktop or
> +	  embedded system with latency requirements in the milliseconds
> +	  range.
> +endchoice
> +
>  config SCHED_CORE
>  	bool "Core Scheduling for SMT"
>  	default y

Urgh, would something like this work?

---
 kernel/Kconfig.preempt | 64 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c4147b9a8..43c68a806e4e 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -1,11 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config PREEMPT_COUNT
+       bool
+
+config PREEMPTION
+       bool
+       select PREEMPT_COUNT
+
+config PREEMPT_DYNAMIC_OPTION
+	bool
+	help
+	  Symbol that gates availablility of PREEMPT_DYNAMIC, selected
+	  by preemption models that can be dynamically selected.
+
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
+	default PREEMPT_TYPE_NONE
 
-config PREEMPT_NONE
+config PREEMPT_TYPE_NONE
 	bool "No Forced Preemption (Server)"
+	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -17,9 +31,10 @@ config PREEMPT_NONE
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
 
-config PREEMPT_VOLUNTARY
+config PREEMPT_TYPE_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -35,12 +50,10 @@ config PREEMPT_VOLUNTARY
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT
+config PREEMPT_TYPE_FULL
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
+	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -75,15 +88,24 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_COUNT
-       bool
+# default model for PREEMPT_DYNAMIC
 
-config PREEMPTION
-       bool
-       select PREEMPT_COUNT
+config PREEMPT_DYNAMIC_NONE
+	bool
 
-config PREEMPT_DYNAMIC
+config PREEMPT_DYNAMIC_VOLUNTARY
+	bool
+
+config PREEMPT_DYNAMIC_FULL
 	bool
+
+config PREEMPT_DYNAMIC
+	bool "Dynamic Preemption Mode"
+	depends on PREEMPT_DYNAMIC_OPTION
+	select PREEMPT
+	select PREEMPT_DYNAMIC_NONE if PREEMPT_TYPE_NONE
+	select PREEMPT_DYNAMIC_VOLUNTARY if PREEMPT_TYPE_VOLUNTARY
+	select PREEMPT_DYNAMIC_FULL if PREEMPT_TYPE_FULL
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
@@ -100,6 +122,22 @@ config PREEMPT_DYNAMIC
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
 
+# actual preemption model
+
+config PREEMPT_NONE
+	bool
+	default y if !PREEMPT_DYNAMIC && PREEMPT_TYPE_NONE
+
+config PREEMPT_VOLUNTARY
+	bool
+	default y if !PREEMPT_DYNAMIC && PREEMPT_TYPE_VOLUNTARY
+
+config PREEMPT
+	bool
+	default y if !PREEMPT_DYNAMIC && PREEMPT_TYPE_FULL
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	default y
