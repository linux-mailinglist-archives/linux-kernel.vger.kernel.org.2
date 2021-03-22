Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF99E34396A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVGZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:25:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45129 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229973AbhCVGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:25:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 57ABC5C0118;
        Mon, 22 Mar 2021 02:25:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 02:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=LbSz8xBygXKTCdeOMKMXzbE5e+
        fC7NuD9Kd2GdRF/ik=; b=DQt9/q6Guj/oyGANKpQU8DcYByDbzdZw+7idM/UF+z
        cF0KIflBHaLwKJM99gXnw4brVwesKZ9NH+jtdhQ+0rrm9NPVLZjwgUvzLfp7s/is
        xcwdMPZSSW2xYvLGrNDzQVRdRGCAA75FywHSBo1YZXhYUxJCsltMRG1VITt8UW+/
        21axwk7Th9f6mvT1dS1JGVSfmVompgvjw8uz1o+SHwfPNMrQ4x++atTNNqu0BANT
        jNpZ7K4VsxzrlE2QjCi4alg8lPvGhw7GeQOfTqC4sE/5OpAXrP3e2NDH3pr9CF0f
        T/FXAFOgkoMpMhC71/ZA8WlQudk1RbC7qJueSZDAfDdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LbSz8xBygXKTCdeOM
        KMXzbE5e+fC7NuD9Kd2GdRF/ik=; b=o+vIMXf2QINud1pM+N6tsd4mz80mRRYHj
        CjC8tfmq1TmDbYvCkse2hlK1uXrpJnhfgAGwMOQJp9NQiRwRYtATTgGVGksj5t8C
        +uvcrmhj8IHNw5XfdXe3KP+LgGuNtsralAjdXz9W1SQuEdMQuvuMMitlbnc2TJGQ
        23wA6x9scxxijUFDSteGk0wXXM2zaEBf9gUlo4i3udhQNMN2lNwL9GzMAsXU5QgS
        9p1xRLttU72W5w0rMBaJ881xMHINjxS59TRw8XQztmSnAPpsoUbxJ26m3dFj9T9P
        /346+0K+nw9DRAnbQ0rHmToIBs47k3UptLzuITSjOJhf5+ywbviwg==
X-ME-Sender: <xms:SzhYYEtdfUSIkrSCA891d6B7fkhYFdcbsAXJNr3DeBfvMPYfbbubEQ>
    <xme:SzhYYBc3TB4Sqslf9ZCGxhIW1qhH38hWAZC4O0WravGntrp8382f_W2GeIPshpqNm
    jUWjv2BOasQc6dE7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegfedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpedtudekhfdvgefgudejhedtffduhfehueejvdehvefggfehfeetuddvveej
    leetjeenucffohhmrghinhepthhruhhsthgvughfihhrmhifrghrvgdrohhrghdpghhith
    hhuhgsrdgtohhmnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllh
    grnhgurdhorhhg
X-ME-Proxy: <xmx:SzhYYPx2hhJmRnu5b7DNsjfapfPfeSDr4yICcoCcywsd3KnPX-zm3w>
    <xmx:SzhYYHN9Wi8drxb4DTSLuUWCubpxjBg5GYqjDXECLLZ5X2YcylocHQ>
    <xmx:SzhYYE-AhBJVF6SdMvAXbavRLIf1sSCpZktcJIgB6M1LB9ftP7pYMw>
    <xmx:TThYYBO1ndJGaPlp_nu7eRJ_VQdKRYF4PK_O6rjGV46b6swWPEr3iw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 29042108005C;
        Mon, 22 Mar 2021 02:25:15 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH] arm64: dts: allwinner: a64/h5: Add CPU idle states
Date:   Mon, 22 Mar 2021 01:25:14 -0500
Message-Id: <20210322062514.40747-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powering off idle CPUs saves about 33 mW compared to using WFI only.
Additional power savings are possible by idling the L2 and downclocking
the cluster when all CPUs are idle.

Entry and exit latency were measured using a logic analyzer, with GPIO
pins toggled in Linux after the calls to trace_cpu_idle() in
cpuidle_enter_state(), and in the power management firmware after CPU
power-off completes and immediately after detecting an interrupt.

800 us and 1500 us are worst-case values, largely driven by the fact
that the power management firmware is single threaded. It can only
handle commands to power off CPUs one at a time, and it cannot process
any commands while powering on a CPU in response to an interrupt.

The cluster suspend process reliably takes 36 us; I rounded this up to
50 us. If all CPUs enter the cluster idle state at the same time, exit
latency is actually reduced, because there is no contention in that
case. However, if only some CPUs enter the cluster idle state, behavior
is the same as for CPU idle.

Polling delay for the power management firmware to detect a pending
interrupt is insignificant; it is less than 20 us.

min-residency was chosen as the point where enabling the idle state
consumed no more average power than disabling the idle state at a
variety of interrupt rates.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

I'm sending this patch as an RFC because it raises questions about how
we handle firmware versioning. How far back does (or should) our support
for old TF-A and Crust versions go?

cpuidle has a problem that without working firmware support, CPUs will
enter idle states and be unable to wake up. As a result, the system will
hang at some point during boot, usually before getting to userspace.

For over a year[0], TF-A has exposed the PSCI CPU_SUSPEND function when
a SCPI implementation is present[1]. Implementing CPU_SUSPEND is
required for implementing SYSTEM_SUSPEND[2], even if CPU_SUSPEND is not
itself used for anything. 

However, there was no code to actually wake up a CPU once it called the
CPU_SUSPEND function, because I could not find the register providing
the necessary information. The fact that CPU_SUSPEND was broken affected
nobody, because nothing ever called it -- there were no idle states in
the DTS. In hindsight, what I should have done was always return failure
from sunxi_validate_power_state(), but that ship has long sailed.

I finally found the elusive register and implemented the wakeup code
earlier this month[3]. So now, CPU_SUSPEND actually works, if all of
your firmware is up to date, and cpuidle works if you add the states in
your device tree.

Unfortunately, there is currently nothing verifying that compatibility.
So you can get into four possible scenarios:
  1) No idle states in DTS, any firmware => Linux works, with baseline
     power consumption.
  2) Idle states added to DTS, no Crust/SCPI => Linux works, but every
     attempt to enter an idle state is rejected because CPU_SUSPEND is
     not hooked up. So power consumption increases by a sizable amount.
  3) Idle states added to DTS, "old" Crust/SCPI (before [3]) => Linux
     fails to boot, because CPUs never return from idle states.
  4) Idle states added to DTS, "new" Crust/SCPI (after [3]) => Linux
     works, with improved power consumption compared to the baseline.

Obviously, we want to prevent scenario 3 if possible.

Enter the current patch: I chose the arm,psci-suspend-param values
specifically so they would be _rejected_ by the current TF-A code. This
makes scenario 3 behave like scenario 2. I then have some follow-up TF-A
patches (not yet submitted) to switch to the new parameter encoding[4].

This brings me back to my original question. Once the TF-A patches in
[4] are merged, scenario 3 (with an updated TF-A but an old Crust) would
fail to boot again. Do we care?

Should I implement some kind of runtime version checking, so TF-A can
disable CPU_SUSPEND if it would be broken? Or instead, should we wait
some amount of time to merge this patch (or the patches at [4]) and
assume people have upgraded?

Where would people expect this sort of possibly-breaking change to be
documented?

Separately, since I assume most A64/H5 users (outside of LibreELEC and
the PinePhone) are not using Crust, scenario 2 would be very common. If
merging this patch increases their idle power draw by 500 mW, is that an
acceptable cost for decreasing other users' idle power draw by 50 mW?

Sorry for the wall of text,
Samuel

[0]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/plat/allwinner/common/sunxi_pm.c?id=e382c88e2a26995099bb931d49e754dcaebc5593
[1]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/allwinner/common/sunxi_scpi_pm.c?id=2e0e51f42586826a1f6f6c1e532f90e6df642cf5#n190
[2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/lib/psci/psci_setup.c?id=2e0e51f42586826a1f6f6c1e532f90e6df642cf5#n251
[3]: https://github.com/crust-firmware/crust/commits/85944467c804
[4]: https://github.com/crust-firmware/arm-trusted-firmware/commits/d6ebf5dab2da

---

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 26 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57786fc120c3..2b1b5b36098c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -54,6 +54,7 @@ cpu0: cpu@0 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +66,7 @@ cpu1: cpu@1 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
 		};
 
 		cpu2: cpu@2 {
@@ -76,6 +78,7 @@ cpu2: cpu@2 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
 		};
 
 		cpu3: cpu@3 {
@@ -87,6 +90,29 @@ cpu3: cpu@3 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <800>;
+				exit-latency-us = <1500>;
+				min-residency-us = <25000>;
+				arm,psci-suspend-param = <0x00010003>;
+			};
+
+			cluster_sleep: cluster-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <850>;
+				exit-latency-us = <1500>;
+				min-residency-us = <50000>;
+				arm,psci-suspend-param = <0x01010013>;
+			};
 		};
 
 		L2: l2-cache {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 578a63dedf46..1c416f648c58 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -18,6 +18,7 @@ cpu0: cpu@0 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
 		};
 
 		cpu1: cpu@1 {
@@ -28,6 +29,7 @@ cpu1: cpu@1 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
 		};
 
 		cpu2: cpu@2 {
@@ -38,6 +40,7 @@ cpu2: cpu@2 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
 		};
 
 		cpu3: cpu@3 {
@@ -48,6 +51,29 @@ cpu3: cpu@3 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_sleep>, <&cluster_sleep>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <800>;
+				exit-latency-us = <1500>;
+				min-residency-us = <25000>;
+				arm,psci-suspend-param = <0x00010003>;
+			};
+
+			cluster_sleep: cluster-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <850>;
+				exit-latency-us = <1500>;
+				min-residency-us = <50000>;
+				arm,psci-suspend-param = <0x01010013>;
+			};
 		};
 	};
 
-- 
2.26.2

