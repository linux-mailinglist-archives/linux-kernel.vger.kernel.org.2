Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3F34708D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhCXEpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:45:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36569 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232732AbhCXEo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:44:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 202935C00A4;
        Wed, 24 Mar 2021 00:44:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 24 Mar 2021 00:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=U
        +jLtGZ3crKCzzHyYT7e7iwoSBlJkEHjIPEjgBND7zs=; b=aHC7zMhxosK5ztkEe
        gGJMPa3bUrJNJ0ds7WjxP4jV5FPHH6Jqa/y8kf67D3KhXnSzQmKoYzy6ZofVLpUZ
        ktp5kXTJr1X1snbbJoh/gtFJgMKZhW6v89fXKN2ZLMVSDLwnSdsJQ9HkWecMsFSi
        c9fZ+APfiWPzTWs5b2eV+Bt878Ur3AIFd1iRmwBlG1A3yFGzVHi84O5LAheScg/f
        jaOeCPRt7RDQGa6CvGSt5gjWryWuKO5xZ6rg2ew0LBx2Sxncbb7eOxCv4QFHqJ2Y
        q6jNkmW4XpbecKt17yezvmvr25hX4e4EN2g8irrCAgCq5cLGYh3LPXwivJYE5K49
        j5H0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=U+jLtGZ3crKCzzHyYT7e7iwoSBlJkEHjIPEjgBND7
        zs=; b=sI08tU7ZinIjomd1VIiHq8Dkzj6kDrcBlzEJmwXXz3FywmjsR2+d69YeY
        lcZPcZdtKtHLOT6eUVtyEHIbYuWtdP7LFCbqKFJSZvkncj7wiZypWfSKDzetFZsR
        WRehYECK/79qjqAqrmLw/NOf77voZDw/WnzWjWywJ35ylDIGrwrxHL1ptu8Obtqv
        QgChvrHNtbnsem06gUWfpUnCyNv92zMIKJkGMCkfY+HbvjhwxtELnWtHCTbIdBel
        Cau1Och/0oB1DlifdDJttcTF3dXLBBB6rNxUwYTU7qsH6AkzI1Lyhxxuzwc5mEZ4
        tfyziyjbtk7FngDE3/Yj7Z2prhkew==
X-ME-Sender: <xms:xMNaYEBpasAlFOdXd_hUwGMZHbpGW1G9GyaaiRIY67Sc04TM_kYo9g>
    <xme:xMNaYGhs1Fad21BeneJzEY9eNk9Lt8SQNM1tt0sMliKBRnq-YVhoOLWE29uuDne4Q
    cjgIZ5JyUgWZmXUJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtgeeuueeuueekueeiveejtedvtdfhheduteduueeigffftdev
    tdeffeevhfdunecuffhomhgrihhnpehtrhhushhtvggufhhirhhmfigrrhgvrdhorhhgpd
    hgihhthhhusgdrtghomhenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshh
    holhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:xMNaYHnwF-k4E9fQROPeOi6Zz8le7p8PXXaNDcoV-3wnrS3NGehdrg>
    <xmx:xMNaYKyFraNeGDC6x4i2lSm7c7UcfGfdCSrhcZ3P2DzQT0xVa7ELEQ>
    <xmx:xMNaYJQ2zjX9HtKAh-zZToUyfGB_exGUv7gs-iwxQZTMJahucCknEA>
    <xmx:xsNaYIGeRAzxeOcqZCY5MJoH8vrgOcxU5vnQW2fvfNWdvq3sdHdg-A>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A9263240356;
        Wed, 24 Mar 2021 00:44:51 -0400 (EDT)
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
References: <20210322062514.40747-1-samuel@sholland.org>
 <20210323015627.08f9afd6@slackpad.fritz.box>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH] arm64: dts: allwinner: a64/h5: Add CPU idle states
Message-ID: <ca26bade-abab-8e01-8014-bc7c72ea13fc@sholland.org>
Date:   Tue, 23 Mar 2021 23:44:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210323015627.08f9afd6@slackpad.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 8:56 PM, Andre Przywara wrote:
>> I'm sending this patch as an RFC because it raises questions about how
>> we handle firmware versioning. How far back does (or should) our support
>> for old TF-A and Crust versions go?
>>
>> cpuidle has a problem that without working firmware support, CPUs will
>> enter idle states and be unable to wake up. As a result, the system will
>> hang at some point during boot, usually before getting to userspace.
>>
>> For over a year[0], TF-A has exposed the PSCI CPU_SUSPEND function when
>> a SCPI implementation is present[1]. Implementing CPU_SUSPEND is
>> required for implementing SYSTEM_SUSPEND[2], even if CPU_SUSPEND is not
>> itself used for anything. 
>>
>> However, there was no code to actually wake up a CPU once it called the
>> CPU_SUSPEND function, because I could not find the register providing
>> the necessary information. The fact that CPU_SUSPEND was broken affected
>> nobody, because nothing ever called it -- there were no idle states in
>> the DTS. In hindsight, what I should have done was always return failure
>> from sunxi_validate_power_state(), but that ship has long sailed.
>>
>> I finally found the elusive register and implemented the wakeup code
>> earlier this month[3]. So now, CPU_SUSPEND actually works, if all of
>> your firmware is up to date, and cpuidle works if you add the states in
>> your device tree.
>>
>> Unfortunately, there is currently nothing verifying that compatibility.
>> So you can get into four possible scenarios:
>>   1) No idle states in DTS, any firmware => Linux works, with baseline
>>      power consumption.
>>   2) Idle states added to DTS, no Crust/SCPI => Linux works, but every
>>      attempt to enter an idle state is rejected because CPU_SUSPEND is
>>      not hooked up. So power consumption increases by a sizable amount.
>>   3) Idle states added to DTS, "old" Crust/SCPI (before [3]) => Linux
>>      fails to boot, because CPUs never return from idle states.
>>   4) Idle states added to DTS, "new" Crust/SCPI (after [3]) => Linux
>>      works, with improved power consumption compared to the baseline.
>>
>> Obviously, we want to prevent scenario 3 if possible.
> 
> So I think the core of the problem is that the DT describes some
> firmware feature, but we have the DT bundled with the kernel, not the
> firmware.

I would say the core problem is that the firmware lies about supporting
PSCI CPU_SUSPEND. Linux shouldn't be calling CPU_SUSPEND if the firmware
declares it as unavailable, regardless of what is in the DTS.
(Technically, per the PSCI standard, CPU_SUSPEND is a mandatory
function, but a quick survey of the TF-A platforms shows it is far from
universally implemented.)

> So is there any way we can detect an older crust version in U-Boot,
> then remove any potential idle states from the DT?

Let's assume that we are using a functioning SoC (H3) or the secure fuse
is blown (A64) and therefore U-Boot cannot access SRAM A2. I can think
of three ways it can learn about crust:

a) PSCI_FEATURES (e.g. is CPU_SUSPEND supported)
b) Metadata in the FIT image
c) Custom SMCs

TF-A has some additional methods available:

d) The SCPI-reported firmware version
e) The magic number at the beginning of the firmware binary

> Granted, this requires recent U-Boot as well, but at least we could try
> to mitigate the worst case a bit?

If we're okay with modifying firmware to solve this problem, then I
propose the following solution:

1) Version bump crust or change its magic number.
2) Modify TF-A to only report CPU_SUSPEND as available if it detects the
   new crust version. This would involve conditionally setting
   sunxi_scpi_psci_ops.validate_power_state, and updating psci_setup.c
   to also check for .validate_power_state when setting psci_caps.
3) Modify the Linux PSCI client to respect PSCI_FEATURES when setting
   psci_ops.cpu_suspend. cpuidle-psci checks for this function before
   setting up idle states.
4) Finally, after some time, add the idle states to the DTS.

In fact, this solution solves both scenarios 2 and 3, because it also
takes care of the native PM implementation, which doesn't implement
CPU_SUSPEND at all.

Does that sound workable?

Regards,
Samuel

> A better solution could be to only *add* the idle states if the rest of
> the firmware is deemed worthy. So the mainline DTs would not carry the
> properties in the first place, and only U-Boot adds them, on detecting
> a capable firmware?
> Admittedly this changes the "flow" of the DT, where the kernel is the
> authority, but it might help to solve this problem?
> 
> Or any other way, which involves U-Boot patching the DTB? (This would
> apply to the DTB passed to the kernel, regardless of where and when
> it's loaded from)
> 
> Any opinions?
> 
> Cheers,
> Andre
> 
>> Enter the current patch: I chose the arm,psci-suspend-param values
>> specifically so they would be _rejected_ by the current TF-A code. This
>> makes scenario 3 behave like scenario 2. I then have some follow-up TF-A
>> patches (not yet submitted) to switch to the new parameter encoding[4].
>>
>> This brings me back to my original question. Once the TF-A patches in
>> [4] are merged, scenario 3 (with an updated TF-A but an old Crust) would
>> fail to boot again. Do we care?
>>
>> Should I implement some kind of runtime version checking, so TF-A can
>> disable CPU_SUSPEND if it would be broken? Or instead, should we wait
>> some amount of time to merge this patch (or the patches at [4]) and
>> assume people have upgraded?
>>
>> Where would people expect this sort of possibly-breaking change to be
>> documented?
>>
>> Separately, since I assume most A64/H5 users (outside of LibreELEC and
>> the PinePhone) are not using Crust, scenario 2 would be very common. If
>> merging this patch increases their idle power draw by 500 mW, is that an
>> acceptable cost for decreasing other users' idle power draw by 50 mW?
>>
>> Sorry for the wall of text,
>> Samuel
>>
>> [0]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/plat/allwinner/common/sunxi_pm.c?id=e382c88e2a26995099bb931d49e754dcaebc5593
>> [1]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/allwinner/common/sunxi_scpi_pm.c?id=2e0e51f42586826a1f6f6c1e532f90e6df642cf5#n190
>> [2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/lib/psci/psci_setup.c?id=2e0e51f42586826a1f6f6c1e532f90e6df642cf5#n251
>> [3]: https://github.com/crust-firmware/crust/commits/85944467c804
>> [4]: https://github.com/crust-firmware/arm-trusted-firmware/commits/d6ebf5dab2da
>>
>> ---
>>
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 +++++++++++++++++++
>>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 26 +++++++++++++++++++
>>  2 files changed, 52 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index 57786fc120c3..2b1b5b36098c 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -54,6 +54,7 @@ cpu0: cpu@0 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>>  		};
>>  
>>  		cpu1: cpu@1 {
>> @@ -65,6 +66,7 @@ cpu1: cpu@1 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>>  		};
>>  
>>  		cpu2: cpu@2 {
>> @@ -76,6 +78,7 @@ cpu2: cpu@2 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>>  		};
>>  
>>  		cpu3: cpu@3 {
>> @@ -87,6 +90,29 @@ cpu3: cpu@3 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>> +		};
>> +
>> +		idle-states {
>> +			entry-method = "psci";
>> +
>> +			cpu_sleep: cpu-sleep {
>> +				compatible = "arm,idle-state";
>> +				local-timer-stop;
>> +				entry-latency-us = <800>;
>> +				exit-latency-us = <1500>;
>> +				min-residency-us = <25000>;
>> +				arm,psci-suspend-param = <0x00010003>;
>> +			};
>> +
>> +			cluster_sleep: cluster-sleep {
>> +				compatible = "arm,idle-state";
>> +				local-timer-stop;
>> +				entry-latency-us = <850>;
>> +				exit-latency-us = <1500>;
>> +				min-residency-us = <50000>;
>> +				arm,psci-suspend-param = <0x01010013>;
>> +			};
>>  		};
>>  
>>  		L2: l2-cache {
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
>> index 578a63dedf46..1c416f648c58 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
>> @@ -18,6 +18,7 @@ cpu0: cpu@0 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>>  		};
>>  
>>  		cpu1: cpu@1 {
>> @@ -28,6 +29,7 @@ cpu1: cpu@1 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>>  		};
>>  
>>  		cpu2: cpu@2 {
>> @@ -38,6 +40,7 @@ cpu2: cpu@2 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>>  		};
>>  
>>  		cpu3: cpu@3 {
>> @@ -48,6 +51,29 @@ cpu3: cpu@3 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
>>  			#cooling-cells = <2>;
>> +			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
>> +		};
>> +
>> +		idle-states {
>> +			entry-method = "psci";
>> +
>> +			cpu_sleep: cpu-sleep {
>> +				compatible = "arm,idle-state";
>> +				local-timer-stop;
>> +				entry-latency-us = <800>;
>> +				exit-latency-us = <1500>;
>> +				min-residency-us = <25000>;
>> +				arm,psci-suspend-param = <0x00010003>;
>> +			};
>> +
>> +			cluster_sleep: cluster-sleep {
>> +				compatible = "arm,idle-state";
>> +				local-timer-stop;
>> +				entry-latency-us = <850>;
>> +				exit-latency-us = <1500>;
>> +				min-residency-us = <50000>;
>> +				arm,psci-suspend-param = <0x01010013>;
>> +			};
>>  		};
>>  	};
>>  
> 

