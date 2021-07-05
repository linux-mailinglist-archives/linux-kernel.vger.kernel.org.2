Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77543BB9E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhGEJKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:10:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhGEJKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:10:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0E011063;
        Mon,  5 Jul 2021 02:08:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.8.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162F43F5A1;
        Mon,  5 Jul 2021 02:07:57 -0700 (PDT)
Date:   Mon, 5 Jul 2021 10:07:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        daniel.lezcano@linaro.org, maz@kernel.org,
        konrad.dybcio@somainline.org, saiprakash.ranjan@codeaurora.org,
        robh@kernel.org, marcan@marcan.st, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linu Cherian <lcherian@marvell.com>
Subject: Re: [PATCH] clocksource: Add Marvell Errata-38627 workaround
Message-ID: <20210705090753.GD38629@C02TD0UTHF1T.local>
References: <20210705060843.3150-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705060843.3150-1-bbhushan2@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

On Mon, Jul 05, 2021 at 11:38:43AM +0530, Bharat Bhushan wrote:
> CPU pipeline have unpredicted behavior when timer
> interrupt appears and then disappears prior to the
> exception happening. Time interrupt appears on timer
> expiry and disappears when timer programming or timer
> disable. This typically can happen when a load
> instruction misses in the cache,  which can take
> few hundreds of cycles, and an interrupt appears
> after the load instruction starts executing but
> disappears before the load instruction completes.

Could you elaborate on the scenario? What sort of unpredictable
behaviour can occur? e.g:

* Does the CPU lockup?
* Does the CPU take the exception at all?
* Does the load behave erroneously?
* Does any CPU state (e.g. GPRs, PC, PSTATE) become corrupted?

Does the problem manifest when IRQs are masked by DAIF.I, or by
CNT8_CTL_EL0.{IMASK,ENABLE} ?

> Workaround of this is to ensure maximum 2us of time
> gap between timer interrupt and timer programming
> which can de-assert timer interrupt.

The code below seems to try to enforce a 2us *minimum*. Which is it
supposed to be?

Can you explain *why* this is supposed to help?

I don't see how we can guarantee this in a VM, or if the CPU misses on
an instruction fetch.

> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  arch/arm64/include/asm/cputype.h     | 13 +++++++
>  arch/arm64/kernel/cpu_errata.c       | 24 +++++++++++++
>  arch/arm64/tools/cpucaps             |  1 +
>  drivers/clocksource/Kconfig          | 13 +++++++
>  drivers/clocksource/arm_arch_timer.c | 54 ++++++++++++++++++++++++++++
>  5 files changed, 105 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 6231e1f0abe7..e9a76935ee0f 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -81,6 +81,13 @@
>  #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
>  #define CAVIUM_CPU_PART_THUNDERX2	0x0AF
>  
> +#define MRVL_CPU_PART_OCTEONTX2_98XX    0x0B1
> +#define MRVL_CPU_PART_OCTEONTX2_96XX    0x0B2
> +#define MRVL_CPU_PART_OCTEONTX2_95XX    0x0B3
> +#define MRVL_CPU_PART_OCTEONTX2_LOKI    0x0B4
> +#define MRVL_CPU_PART_OCTEONTX2_95MM    0x0B5
> +#define MRVL_CPU_PART_OCTEONTX2_95O     0x0B6
> +
>  #define BRCM_CPU_PART_BRAHMA_B53	0x100
>  #define BRCM_CPU_PART_VULCAN		0x516
>  
> @@ -117,6 +124,12 @@
>  #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
>  #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
>  #define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
> +#define MIDR_MRVL_OCTEONTX2_98XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_98XX)
> +#define MIDR_MRVL_OCTEONTX2_96XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_96XX)
> +#define MIDR_MRVL_OCTEONTX2_95XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_95XX)
> +#define MIDR_MRVL_OCTEONTX2_LOKI MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_LOKI)
> +#define MIDR_MRVL_OCTEONTX2_95MM MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_95MM)
> +#define MIDR_MRVL_OCTEONTX2_95O MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_95O)
>  #define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_BRAHMA_B53)
>  #define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
>  #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index e2c20c036442..363f83adb333 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -339,6 +339,23 @@ static const struct midr_range erratum_1463225[] = {
>  	{},
>  };
>  #endif
> +#ifdef CONFIG_MARVELL_ERRATUM_38627
> +static const struct midr_range marvell_erratum_38627_cpus[] = {
> +	/* Marvell OcteonTX 2, 95xx all passes */
> +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_95XX),
> +	/* Marvell OcteonTX 2, 95MM all passes */
> +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_95MM),
> +	/* Marvell OcteonTX 2, LOKI all passes */
> +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_LOKI),
> +	/* Marvell OcteonTX 2, 96xx all passes */
> +	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_96XX),
> +	/* Marvell OcteonTX 2, 98xx pass 1.0 */
> +	MIDR_REV(MIDR_MRVL_OCTEONTX2_98XX, 0, 0),
> +	/* Marvell OcteonTX 2, 95O pass 1.0 */
> +	MIDR_REV(MIDR_MRVL_OCTEONTX2_95O, 0, 0),
> +	{},
> +};
> +#endif
>  
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
> @@ -439,6 +456,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.capability = ARM64_WORKAROUND_858921,
>  		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>  	},
> +#endif
> +#ifdef CONFIG_MARVELL_ERRATUM_38627
> +	{
> +		.desc = "MARVELL erratum 38627",
> +		.capability = ARM64_WORKAROUND_MRVL_38627,
> +		ERRATA_MIDR_RANGE_LIST(marvell_erratum_38627_cpus),
> +	},
>  #endif
>  	{
>  		.desc = "Spectre-v2",
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 49305c2e6dfd..99dbe80445ef 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -60,6 +60,7 @@ WORKAROUND_CAVIUM_TX2_219_PRFM
>  WORKAROUND_CAVIUM_TX2_219_TVM
>  WORKAROUND_CLEAN_CACHE
>  WORKAROUND_DEVICE_LOAD_ACQUIRE
> +WORKAROUND_MRVL_38627
>  WORKAROUND_NVIDIA_CARMEL_CNP
>  WORKAROUND_QCOM_FALKOR_E1003
>  WORKAROUND_REPEAT_TLBI
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index eb661b539a3e..83feb502cf02 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -309,6 +309,19 @@ config ARM_ARCH_TIMER_EVTSTREAM
>  config ARM_ARCH_TIMER_OOL_WORKAROUND
>  	bool
>  
> +config MARVELL_ERRATUM_38627
> +	bool "Workaround for Marvell Erratum 38627"
> +	default y
> +	depends on ARM_ARCH_TIMER && ARM64
> +	select ARM_ARCH_TIMER_OOL_WORKAROUND
> +	help
> +	  This option enables a workaround for Marvell Erratum
> +	  38627. According to this errata CPU pipeline have
> +	  unpredicted behavior when timer interrupt appears and
> +	  then disappears prior to the exception happening.
> +	  This Errata workaround is applicable only to some Marvell
> +	  OcteonTX2 series of processors.
> +
>  config FSL_ERRATUM_A008585
>  	bool "Workaround for Freescale/NXP Erratum A-008585"
>  	default y
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index be6d741d404c..d1c5e2aa2e7c 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -27,6 +27,7 @@
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/ptp_kvm.h>
> +#include <linux/delay.h>
>  
>  #include <asm/arch_timer.h>
>  #include <asm/virt.h>
> @@ -88,6 +89,8 @@ static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
>  
>  static cpumask_t evtstrm_available = CPU_MASK_NONE;
>  static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
> +static __always_inline void set_next_event(const int access, unsigned long evt,
> +					   struct clock_event_device *clk);
>  
>  static int __init early_evtstrm_cfg(char *buf)
>  {
> @@ -432,6 +435,48 @@ static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_MARVELL_ERRATUM_38627
> +/* Workaround is to ensure maximum 2us of time gap between timer expiry
> + * and timer programming which can de-assert timer interrupt.
> + * Time calculation below is based on 100MHz as timer frequency is fixed
> + * to 100MHz on all affected parts.
> + */
> +static __always_inline
> +void erratum_38627_set_next_event(const int access, unsigned long evt,
> +				  struct clock_event_device *clk)
> +{
> +	int32_t tval;
> +
> +	tval = arch_timer_reg_read(access, ARCH_TIMER_REG_TVAL, clk);
> +
> +	/* Timer already expired, wait for (2 - expired time)us */
> +	if ((tval > -200) && (tval < 0))
> +		udelay(2 + tval/100);

Isn't this ensuring a 2us *minimum* rather than *maximum* ?

> +
> +	/* Timer is about to expire, wait for 2us + time to expire */
> +	if (tval >= 0 && tval < 200)
> +		udelay(3 + tval/100);

Again, this appears to be waiting for 2us *minimum*.

What if when we did the read we have 2.01 us to go? Is the expectation
that we'll manage to execute this code and set the next event in less
that 2us?

Thanks,
Mark.

> +
> +	set_next_event(access, evt, clk);
> +}
> +
> +static __maybe_unused
> +int erratum_38627_set_next_event_tval_virt(unsigned long evt,
> +					   struct clock_event_device *clk)
> +{
> +	erratum_38627_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
> +	return 0;
> +}
> +
> +static __maybe_unused
> +int erratum_38627_set_next_event_tval_phys(unsigned long evt,
> +					   struct clock_event_device *clk)
> +{
> +	erratum_38627_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
> +	return 0;
> +}
> +#endif
> +
>  static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  #ifdef CONFIG_FSL_ERRATUM_A008585
>  	{
> @@ -479,6 +524,15 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
>  	},
>  #endif
> +#ifdef CONFIG_MARVELL_ERRATUM_38627
> +	{
> +		.match_type = ate_match_local_cap_id,
> +		.id = (void *)ARM64_WORKAROUND_MRVL_38627,
> +		.desc = "Marvell erratum 38627",
> +		.set_next_event_phys = erratum_38627_set_next_event_tval_phys,
> +		.set_next_event_virt = erratum_38627_set_next_event_tval_virt,
> +	},
> +#endif
>  #ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
>  	{
>  		.match_type = ate_match_dt,
> -- 
> 2.17.1
> 
