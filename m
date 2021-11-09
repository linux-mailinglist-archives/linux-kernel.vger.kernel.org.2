Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6944AD68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbhKIMW0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Nov 2021 07:22:26 -0500
Received: from foss.arm.com ([217.140.110.172]:33028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhKIMWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:22:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44463ED1;
        Tue,  9 Nov 2021 04:19:38 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05A2F3F7F5;
        Tue,  9 Nov 2021 04:19:36 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
In-Reply-To: <1905cf613576d04f585d752d85ce21a3504a40d6.camel@gmx.de>
References: <20211105104035.3112162-1-valentin.schneider@arm.com> <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de> <8735o6uca5.mognet@arm.com> <5543627ee8ac5337a74de4b9671240d617273607.camel@gmx.de> <87zgqesmej.mognet@arm.com> <a8540176424035960b12529c06d5a3dcedd57c77.camel@gmx.de> <87wnlhsljd.mognet@arm.com> <1905cf613576d04f585d752d85ce21a3504a40d6.camel@gmx.de>
Date:   Tue, 09 Nov 2021 12:19:30 +0000
Message-ID: <87pmr9ser1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/21 12:00, Mike Galbraith wrote:
> On Tue, 2021-11-09 at 09:52 +0000, Valentin Schneider wrote:
>> On 09/11/21 06:30, Mike Galbraith wrote:
>> > Not seeing your v2 land yet, I grabbed my mallet and had a go at goal
>> > reconciliation over morning java.  Non-lovely result seems to work.
>> >
>>
>> Yeah so I went down a debatable path, gave up on that and started something
>> different, and gave up on that because it was late :-)
>>
>> Now interestingly my second attempt is pretty close to what you have
>> below.
>
> Well that's a shame, because while it seems to function, it also puts
> PREEMPT_DYNAMIC in a pretty darn similar spot to the one PREEMPT_RT was
> in.  Drat.
>

Yep...

>> > sched, Kconfig: Fix preemption model selection
>> >
>> > Switch PREEMPT_DYNAMIC/PREEMPT_RT dependency around so PREEMPT_RT
>> > can be selected during the initial preemption model selection.
>> > Further, since PREEMPT_DYNAMIC requires PREEMPT, make it depend
>> > upon it instead of selecting it, and add a menu to allow selection
>> > of the boot time behavior, this to allow arches that do not support
>> > PREEMPT_DYNAMIC to retain their various configs untouched.
>> >
>>
>> Have some nits below, but otherwise where I stand right now I think it's
>> the least ugly way of tackling this :)
>
> We're supposed to be going for _least_ ugly?  Oh ;)  This is really a
> job for someone who knows their way around Kconfig-land, but since I'm
> not hearing "Yawn, here ya go", it gets whacked with a mallet until one
> of us gives up.
>

:)

> -config PREEMPT_NONE
> +if PREEMPT_DYNAMIC
> +config PREEMPT
>       bool
>

On my end this doesn't let PREEMPT_DYNAMIC select PREEMPT, which I came to
realize we need (places like vermagic.h and ftrace's print_trace_header();
also it avoids a lot of headaches).

AIUI this is because the 'if <expr>' is equivalent to appending
  depends on <expr>
to every choice item.

The below lets me have PREEMPT w/ PREEMPT_DYNAMIC. The one annoying thing
is the Preemption Model prompt remains visible in menuconfig when
PREEMPT_DYNAMIC is selected, but eh...

---
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 12ac42a3415f..e01588f9de1f 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -1,18 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-choice
-	prompt "Preemption Model"
-	default PREEMPT_STATIC
-
-config PREEMPT_STATIC
-	bool "Preemption behaviour defined at build"
-
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
 	depends on HAVE_PREEMPT_DYNAMIC && !ARCH_NO_PREEMPT
 	select PREEMPT
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
@@ -28,15 +19,14 @@ config PREEMPT_DYNAMIC
 
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
-endchoice
 
-if PREEMPT_STATIC
 choice
-	prompt "Preemption Flavor"
+	prompt "Preemption Model"
 	default PREEMPT_NONE
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
+	depends on !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -50,7 +40,7 @@ config PREEMPT_NONE
 
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
-	depends on !ARCH_NO_PREEMPT
+	depends on !ARCH_NO_PREEMPT && !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -88,7 +78,7 @@ config PREEMPT
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT
+	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -104,14 +94,10 @@ config PREEMPT_RT
 	  require real-time guarantees.
 
 endchoice
-endif # PREEMPT_STATIC
-
-if PREEMPT_DYNAMIC
-config PREEMPT
-	bool
 
 choice
-	prompt "Boot Time Preemption Flavor"
+	prompt "Boot Time Preemption Model"
+	depends on PREEMPT_DYNAMIC
 	default PREEMPT_NONE_BEHAVIOR
 
 config PREEMPT_NONE_BEHAVIOR
@@ -123,7 +109,6 @@ config PREEMPT_VOLUNTARY_BEHAVIOR
 config PREEMPT_BEHAVIOR
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 endchoice
-endif # PREEMPT_DYNAMIC
 
 config PREEMPT_COUNT
        bool
@@ -149,5 +134,3 @@ config SCHED_CORE
 	  SCHED_CORE is default disabled. When it is enabled and unused,
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
-
-
