Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81152433567
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhJSMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:09:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhJSMJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:09:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E762F;
        Tue, 19 Oct 2021 05:06:46 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E93F33F70D;
        Tue, 19 Oct 2021 05:06:44 -0700 (PDT)
Subject: Re: [PATCH v5 03/15] arm64: errata: Add workaround for TSB flush
 failures
To:     Will Deacon <will@kernel.org>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-4-suzuki.poulose@arm.com>
 <20211019110233.GD13251@willie-the-truck>
 <850c67de-a656-7515-e575-d47d2af78200@arm.com>
 <20211019114234.GH13251@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <390f8d9b-d5b3-50de-74c1-df16572dd589@arm.com>
Date:   Tue, 19 Oct 2021 13:06:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019114234.GH13251@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 12:42, Will Deacon wrote:
> On Tue, Oct 19, 2021 at 12:36:48PM +0100, Suzuki K Poulose wrote:
>> On 19/10/2021 12:02, Will Deacon wrote:
>>> On Thu, Oct 14, 2021 at 11:31:13PM +0100, Suzuki K Poulose wrote:
>>>> @@ -558,6 +570,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>>>    		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>>>>    		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
>>>>    	},
>>>> +#endif
>>>> +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE
>>>
>>> You still haven't fixed this typo...
>>>
>>
>> Sorry about that. I thought it was about selecting the
>> Kconfig entries, which was fixed. I will fix this.
> 
> Sorry, I thought it was such a howler that it would've jumped out ;)
> That's what made me think we should make sure the series compiles without
> the coresight changes, so we can catch these problems early.
> 
>>> Seriously, I get compile warnings from this -- are you not seeing them?
>>
>> No, I don't get any warnings. Is there something that I am missing ?
> 
> Interesting. I see the warning below in my bisection testing, since the typo
> means that the midr lookup table isn't used. Maybe you're only compiling the
> end result?

No, I was compiling this at the commit. Also, please note that the
TSB flush failure config is enabled with the patch, unlike the TRBE
errata ones.

My GCC is :

gcc version 9.3.1 20200408 (Red Hat 9.3.1-2) (GCC)


$ grep TSB arch/arm64/Kconfig arch/arm64/kernel/cpu_errata.c .config
arch/arm64/Kconfig:config ARM64_WORKAROUND_TSB_FLUSH_FAILURE
arch/arm64/Kconfig:     bool "Cortex-A710: 2054223: workaround TSB 
instruction failing to flush trace"
arch/arm64/Kconfig:     select ARM64_WORKAROUND_TSB_FLUSH_FAILURE
arch/arm64/Kconfig:       Affected cores may fail to flush the trace 
data on a TSB instruction, when
arch/arm64/Kconfig:       Workaround is to issue two TSB consecutively 
on affected cores.
arch/arm64/Kconfig:     bool "Neoverse-N2: 2067961: workaround TSB 
instruction failing to flush trace"
arch/arm64/Kconfig:     select ARM64_WORKAROUND_TSB_FLUSH_FAILURE
arch/arm64/Kconfig:       Affected cores may fail to flush the trace 
data on a TSB instruction, when
arch/arm64/Kconfig:       Workaround is to issue two TSB consecutively 
on affected cores.
arch/arm64/kernel/cpu_errata.c:#ifdef 
CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
arch/arm64/kernel/cpu_errata.c:#endif   /* 
CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
arch/arm64/kernel/cpu_errata.c:#ifdef 
CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE
arch/arm64/kernel/cpu_errata.c:         .capability = 
ARM64_WORKAROUND_TSB_FLUSH_FAILURE,
.config:CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE=y
suzuki@ewhatever:coresight$ git log --oneline -1
89e0c94bd734 (HEAD) arm64: errata: Add workaround for TSB flush failures


> 
> Will
> 
> --->8
> 
> +arch/arm64/kernel/cpu_errata.c:356:32: warning: ‘tsb_flush_fail_cpus’ defined but not used [-Wunused-const-variable=]
> +  356 | static const struct midr_range tsb_flush_fail_cpus[] = {
> +      |                                ^~~~~~~~~~~~~~~~~~~
> 

That looks a valid warning. Hmm, strange.

It does complain for an unused function though.

$ make -j16
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CC      arch/arm64/kernel/cpu_errata.o
arch/arm64/kernel/cpu_errata.c:90:13: error: 
‘here_is_an_unused_function’ defined but not used [-Werror=unused-function]
  static void here_is_an_unused_function(void)
              ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:277: 
arch/arm64/kernel/cpu_errata.o] Error 1
make[1]: *** [scripts/Makefile.build:540: arch/arm64/kernel] Error 2
make: *** [Makefile:1874: arch/arm64] Error 2
make: *** Waiting for unfinished jobs....

--8>--

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index aaa66c9eee24..57c83e84b274 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -87,12 +87,20 @@ has_mismatched_cache_type(const struct 
arm64_cpu_capabilities *entry,
         return (ctr_real != sys) && (ctr_raw != sys);
  }

+static void here_is_an_unused_function(void)
+{
+       pr_crit("I am unused\n");
+}
+
  static void
  cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *cap)
  {
         u64 mask = arm64_ftr_reg_ctrel0.strict_mask;
         bool enable_uct_trap = false;

+#ifdef CONFIG_UNUSED_FUNCTION
+       here_is_an_unused_function();
+#endif

Cheers
Suzuki
