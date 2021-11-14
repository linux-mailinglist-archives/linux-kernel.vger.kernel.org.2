Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAE44F82B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhKNNst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:48:49 -0500
Received: from rosenzweig.io ([138.197.143.207]:48438 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234703AbhKNNsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:48:37 -0500
Date:   Sun, 14 Nov 2021 08:45:30 -0500
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/8] drivers/perf: Add Apple icestorm/firestorm CPU PMU
 driver
Message-ID: <YZES+gF7WdCiCwAe@sunset>
References: <20211113115429.4027571-1-maz@kernel.org>
 <20211113115429.4027571-9-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113115429.4027571-9-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Counters */
> +#define SYS_IMP_APL_PMC0_EL1	sys_reg(3, 2, 15, 0, 0)
> +#define SYS_IMP_APL_PMC1_EL1	sys_reg(3, 2, 15, 1, 0)
> +#define SYS_IMP_APL_PMC2_EL1	sys_reg(3, 2, 15, 2, 0)
> +#define SYS_IMP_APL_PMC3_EL1	sys_reg(3, 2, 15, 3, 0)
> +#define SYS_IMP_APL_PMC4_EL1	sys_reg(3, 2, 15, 4, 0)
> +#define SYS_IMP_APL_PMC5_EL1	sys_reg(3, 2, 15, 5, 0)
> +#define SYS_IMP_APL_PMC6_EL1	sys_reg(3, 2, 15, 6, 0)
> +#define SYS_IMP_APL_PMC7_EL1	sys_reg(3, 2, 15, 7, 0)
--gap--
> +#define SYS_IMP_APL_PMC8_EL1	sys_reg(3, 2, 15, 9, 0)
> +#define SYS_IMP_APL_PMC9_EL1	sys_reg(3, 2, 15, 10, 0)

Do we know what the gap is?

> +/*
> + * Description of the events we actually know about, as well as those with
> + * a specific counter affinity. Yes, this is a grand total of two known
> + * counters, and the rest is anybody's guess.
> + *
> + * Not all counters can count all events. Counters #0 and #1 are wired to
> + * count cycles and instructions respectively, and some events have
> + * bizarre mappings (every other counter, or even *one* counter). These
> + * restrictins equally apply to both P and E cores.

restrictions

> +/* Low level accessors. No synchronisation. */
> +#define PMU_READ_COUNTER(_idx)						\
> +	case _idx:	return read_sysreg_s(SYS_IMP_APL_PMC## _idx ##_EL1)
> +
> +#define PMU_WRITE_COUNTER(_val, _idx)					\
> +	case _idx:							\
> +		write_sysreg_s(_val, SYS_IMP_APL_PMC## _idx ##_EL1);	\
> +		return
> +
> +static u64 m1_pmu_read_hw_counter(unsigned int index)
> +{
> +	switch (index) {
> +		PMU_READ_COUNTER(0);
> +		PMU_READ_COUNTER(1);
> +		PMU_READ_COUNTER(2);
> +		PMU_READ_COUNTER(3);
> +		PMU_READ_COUNTER(4);
> +		PMU_READ_COUNTER(5);
> +		PMU_READ_COUNTER(6);
> +		PMU_READ_COUNTER(7);
> +		PMU_READ_COUNTER(8);
> +		PMU_READ_COUNTER(9);
> +	}
> +
> +	BUG();
> +}
> +
> +static void m1_pmu_write_hw_counter(u64 val, unsigned int index)
> +{
> +	switch (index) {
> +		PMU_WRITE_COUNTER(val, 0);
> +		PMU_WRITE_COUNTER(val, 1);
> +		PMU_WRITE_COUNTER(val, 2);
> +		PMU_WRITE_COUNTER(val, 3);
> +		PMU_WRITE_COUNTER(val, 4);
> +		PMU_WRITE_COUNTER(val, 5);
> +		PMU_WRITE_COUNTER(val, 6);
> +		PMU_WRITE_COUNTER(val, 7);
> +		PMU_WRITE_COUNTER(val, 8);
> +		PMU_WRITE_COUNTER(val, 9);
> +	}
> +
> +	BUG();
> +}

Probbaly cleaner to use a single switch and no macros, registers become
greppable and the code is shorter too. Caveat: didn't check if it
compiles.

	static inline u64 m1_pmu_hw_counter(unsigned int index)
	{
		switch (index) {
		case 0: return SYS_IMP_APL_PMC0_EL1;
		case 1: return SYS_IMP_APL_PMC1_EL1;
		case 2: return SYS_IMP_APL_PMC2_EL1;
		case 3: return SYS_IMP_APL_PMC3_EL1;
		case 4: return SYS_IMP_APL_PMC4_EL1;
		case 5: return SYS_IMP_APL_PMC5_EL1;
		case 6: return SYS_IMP_APL_PMC6_EL1;
		case 7: return SYS_IMP_APL_PMC7_EL1;
		case 8: return SYS_IMP_APL_PMC8_EL1;
		case 9: return SYS_IMP_APL_PMC9_EL1;
		}

		BUG();
	}

	static u64 m1_pmu_read_hw_counter(unsigned int index) {
		return read_sysreg_s(m1_pmu_hw_counter(index));
	}


	static void m1_pmu_write_hw_counter(u64 val, unsigned int index)
	{
		write_sysreg_s(val, m1_pmu_hw_counter(index));
	}

> +static void __m1_pmu_enable_counter(unsigned int index, bool en)
> +{
> +	u64 val, bit;
> +
> +	switch (index) {
> +	case 0 ... 7:
> +		bit = BIT(get_bit_offset(index, PMCR0_CNT_ENABLE_0_7));
> +		break;
> +	case 8 ... 9:
> +		bit = BIT(get_bit_offset(index - 8, PMCR0_CNT_ENABLE_8_9));
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	val = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
> +
> +	if (en)
> +		val |= bit;
> +	else
> +		val &= ~bit;
> +
> +	write_sysreg_s(val, SYS_IMP_APL_PMCR0_EL1);
> +}
...
> +static void __m1_pmu_enable_counter_interrupt(unsigned int index, bool en)
> +{
> +	u64 val, bit;
> +
> +	switch (index) {
> +	case 0 ... 7:
> +		bit = BIT(get_bit_offset(index, PMCR0_PMI_ENABLE_0_7));
> +		break;
> +	case 8 ... 9:
> +		bit = BIT(get_bit_offset(index - 8, PMCR0_PMI_ENABLE_8_9));
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	val = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
> +
> +	if (en)
> +		val |= bit;
> +	else
> +		val &= ~bit;
> +
> +	write_sysreg_s(val, SYS_IMP_APL_PMCR0_EL1);
> +}

These two helper functions have basically the same logic -- maybe worth combining?

> +static void m1_pmu_configure_counter(unsigned int index, u8 event,
> +				     bool user, bool kernel)
> +{
....
> +	switch (index) {
> +	case 0 ... 1:
> +		/* 0 and 1 have fixed events */
> +		break;
> +	case 2 ... 5:
> +		shift = (index - 2) * 8;
> +		val = read_sysreg_s(SYS_IMP_APL_PMESR0_EL1);
> +		val &= ~((u64)0xff << shift);
> +		val |= (u64)event << shift;
> +		write_sysreg_s(val, SYS_IMP_APL_PMESR0_EL1);
> +		break;
> +	case 6 ... 9:
> +		shift = (index - 6) * 8;
> +		val = read_sysreg_s(SYS_IMP_APL_PMESR1_EL1);
> +		val &= ~((u64)0xff << shift);
> +		val |= (u64)event << shift;
> +		write_sysreg_s(val, SYS_IMP_APL_PMESR1_EL1);
> +		break;
> +	}
> +}

I'd love an explanation what's happening here.

> +	/*
> +	 * Place the event on the first free counter that can count
> +	 * this event.
> +	 *
> +	 * We could do a better job if we had a view of all the events
> +	 * counting on the PMU at any given time, and by placing the
> +	 * most constraint events first.
> +	 */

constraining

> +static int m1_pmu_device_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = arm_pmu_device_probe(pdev, m1_pmu_of_device_ids, NULL);
> +	if (!ret) {
> +		/*
> +		 * If probe succeeds, taint the kernel as this is all
> +		 * undocumented, implementation defined black magic.
> +		 */
> +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +	}
> +
> +	return ret;
> +}

What are the implications of this taint? You could say that about every
driver we've written for the M1, but...
