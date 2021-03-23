Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D234552E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCWB5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:57:01 -0400
Received: from foss.arm.com ([217.140.110.172]:39774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCWB4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:56:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73BB71042;
        Mon, 22 Mar 2021 18:56:35 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CCC23F719;
        Mon, 22 Mar 2021 18:56:33 -0700 (PDT)
Date:   Tue, 23 Mar 2021 01:56:27 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH] arm64: dts: allwinner: a64/h5: Add CPU idle states
Message-ID: <20210323015627.08f9afd6@slackpad.fritz.box>
In-Reply-To: <20210322062514.40747-1-samuel@sholland.org>
References: <20210322062514.40747-1-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 01:25:14 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> Powering off idle CPUs saves about 33 mW compared to using WFI only.
> Additional power savings are possible by idling the L2 and downclocking
> the cluster when all CPUs are idle.
> 
> Entry and exit latency were measured using a logic analyzer, with GPIO
> pins toggled in Linux after the calls to trace_cpu_idle() in
> cpuidle_enter_state(), and in the power management firmware after CPU
> power-off completes and immediately after detecting an interrupt.
> 
> 800 us and 1500 us are worst-case values, largely driven by the fact
> that the power management firmware is single threaded. It can only
> handle commands to power off CPUs one at a time, and it cannot process
> any commands while powering on a CPU in response to an interrupt.
> 
> The cluster suspend process reliably takes 36 us; I rounded this up to
> 50 us. If all CPUs enter the cluster idle state at the same time, exit
> latency is actually reduced, because there is no contention in that
> case. However, if only some CPUs enter the cluster idle state, behavior
> is the same as for CPU idle.
> 
> Polling delay for the power management firmware to detect a pending
> interrupt is insignificant; it is less than 20 us.
> 
> min-residency was chosen as the point where enabling the idle state
> consumed no more average power than disabling the idle state at a
> variety of interrupt rates.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> I'm sending this patch as an RFC because it raises questions about how
> we handle firmware versioning. How far back does (or should) our support
> for old TF-A and Crust versions go?
> 
> cpuidle has a problem that without working firmware support, CPUs will
> enter idle states and be unable to wake up. As a result, the system will
> hang at some point during boot, usually before getting to userspace.
> 
> For over a year[0], TF-A has exposed the PSCI CPU_SUSPEND function when
> a SCPI implementation is present[1]. Implementing CPU_SUSPEND is
> required for implementing SYSTEM_SUSPEND[2], even if CPU_SUSPEND is not
> itself used for anything. 
> 
> However, there was no code to actually wake up a CPU once it called the
> CPU_SUSPEND function, because I could not find the register providing
> the necessary information. The fact that CPU_SUSPEND was broken affected
> nobody, because nothing ever called it -- there were no idle states in
> the DTS. In hindsight, what I should have done was always return failure
> from sunxi_validate_power_state(), but that ship has long sailed.
> 
> I finally found the elusive register and implemented the wakeup code
> earlier this month[3]. So now, CPU_SUSPEND actually works, if all of
> your firmware is up to date, and cpuidle works if you add the states in
> your device tree.
> 
> Unfortunately, there is currently nothing verifying that compatibility.
> So you can get into four possible scenarios:
>   1) No idle states in DTS, any firmware => Linux works, with baseline
>      power consumption.
>   2) Idle states added to DTS, no Crust/SCPI => Linux works, but every
>      attempt to enter an idle state is rejected because CPU_SUSPEND is
>      not hooked up. So power consumption increases by a sizable amount.
>   3) Idle states added to DTS, "old" Crust/SCPI (before [3]) => Linux
>      fails to boot, because CPUs never return from idle states.
>   4) Idle states added to DTS, "new" Crust/SCPI (after [3]) => Linux
>      works, with improved power consumption compared to the baseline.
> 
> Obviously, we want to prevent scenario 3 if possible.

So I think the core of the problem is that the DT describes some
firmware feature, but we have the DT bundled with the kernel, not the
firmware.
So is there any way we can detect an older crust version in U-Boot,
then remove any potential idle states from the DT?
Granted, this requires recent U-Boot as well, but at least we could try
to mitigate the worst case a bit?

A better solution could be to only *add* the idle states if the rest of
the firmware is deemed worthy. So the mainline DTs would not carry the
properties in the first place, and only U-Boot adds them, on detecting
a capable firmware?
Admittedly this changes the "flow" of the DT, where the kernel is the
authority, but it might help to solve this problem?

Or any other way, which involves U-Boot patching the DTB? (This would
apply to the DTB passed to the kernel, regardless of where and when
it's loaded from)

Any opinions?

Cheers,
Andre

> Enter the current patch: I chose the arm,psci-suspend-param values
> specifically so they would be _rejected_ by the current TF-A code. This
> makes scenario 3 behave like scenario 2. I then have some follow-up TF-A
> patches (not yet submitted) to switch to the new parameter encoding[4].
> 
> This brings me back to my original question. Once the TF-A patches in
> [4] are merged, scenario 3 (with an updated TF-A but an old Crust) would
> fail to boot again. Do we care?
> 
> Should I implement some kind of runtime version checking, so TF-A can
> disable CPU_SUSPEND if it would be broken? Or instead, should we wait
> some amount of time to merge this patch (or the patches at [4]) and
> assume people have upgraded?
> 
> Where would people expect this sort of possibly-breaking change to be
> documented?
> 
> Separately, since I assume most A64/H5 users (outside of LibreELEC and
> the PinePhone) are not using Crust, scenario 2 would be very common. If
> merging this patch increases their idle power draw by 500 mW, is that an
> acceptable cost for decreasing other users' idle power draw by 50 mW?
> 
> Sorry for the wall of text,
> Samuel
> 
> [0]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/plat/allwinner/common/sunxi_pm.c?id=e382c88e2a26995099bb931d49e754dcaebc5593
> [1]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/allwinner/common/sunxi_scpi_pm.c?id=2e0e51f42586826a1f6f6c1e532f90e6df642cf5#n190
> [2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/lib/psci/psci_setup.c?id=2e0e51f42586826a1f6f6c1e532f90e6df642cf5#n251
> [3]: https://github.com/crust-firmware/crust/commits/85944467c804
> [4]: https://github.com/crust-firmware/arm-trusted-firmware/commits/d6ebf5dab2da
> 
> ---
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 +++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 26 +++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 57786fc120c3..2b1b5b36098c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -54,6 +54,7 @@ cpu0: cpu@0 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -65,6 +66,7 @@ cpu1: cpu@1 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -76,6 +78,7 @@ cpu2: cpu@2 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -87,6 +90,29 @@ cpu3: cpu@3 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-names = "cpu";
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_sleep: cpu-sleep {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <1500>;
> +				min-residency-us = <25000>;
> +				arm,psci-suspend-param = <0x00010003>;
> +			};
> +
> +			cluster_sleep: cluster-sleep {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				entry-latency-us = <850>;
> +				exit-latency-us = <1500>;
> +				min-residency-us = <50000>;
> +				arm,psci-suspend-param = <0x01010013>;
> +			};
>  		};
>  
>  		L2: l2-cache {
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> index 578a63dedf46..1c416f648c58 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -18,6 +18,7 @@ cpu0: cpu@0 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -28,6 +29,7 @@ cpu1: cpu@1 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -38,6 +40,7 @@ cpu2: cpu@2 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -48,6 +51,29 @@ cpu3: cpu@3 {
>  			clocks = <&ccu CLK_CPUX>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_sleep: cpu-sleep {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <1500>;
> +				min-residency-us = <25000>;
> +				arm,psci-suspend-param = <0x00010003>;
> +			};
> +
> +			cluster_sleep: cluster-sleep {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				entry-latency-us = <850>;
> +				exit-latency-us = <1500>;
> +				min-residency-us = <50000>;
> +				arm,psci-suspend-param = <0x01010013>;
> +			};
>  		};
>  	};
>  

