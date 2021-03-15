Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC833AA7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCOEdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:33:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46419 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhCOEcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:32:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 43E24580804;
        Mon, 15 Mar 2021 00:32:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Mar 2021 00:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7mMCgOzVk1VRf
        7k85AEAzifdmxeEa3WAqFUUcfBk/Sw=; b=Is/j1v+zbr8tb0aWRaWBg6mBt+VFP
        1xOlOEZLv60MNR6RLVwHBTz68tliB+UBU69qynYu3LFGGqMsX05aSWZ8jCvAUyEV
        /lb+s9peK9ZXbczlZrPSlwu8yole7AzWovPgf5vazjzL0fCBPDmHC+jvka2GLA3f
        esFrfliy4XuQ0Yim2qjkV4zJCcmKLp5tXcwBt4eWoSYdgjWntslaEzMY0MevLXhN
        e4o2kyVM6E8NCiAkFz2HDtS4Scmhg1ths4sOUdrjG3UogVxCjyO0c5b5jOTd6zCD
        eHNcbR4pwQQ/yLLfWyLXk6HSJiFlw8n3Ywib6Dc1qgeQaQCU1Jn1iJ9Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=7mMCgOzVk1VRf7k85AEAzifdmxeEa3WAqFUUcfBk/Sw=; b=NW/HVdoJ
        6AdKugo04FNeDFncrF2ZtcO/Z62Dr2xG5jbx5P0NxgPFzPR6wIxuUKjlw374KOxp
        AVlncY5/ec83xtYOOQF8zi4l5MlFCeX/l3192V1I1YcCZfprVyYbG6LraCiHzfco
        HIWabLOGyGTxspBlLPhiYVcfcHJlP2i7d2halcPLnLC+jgnRa5Py03GJPWRYwzU5
        TayTWjmOetbzDDVSCyc3UHUQ6zCntLcjWOmWDdQ/bzl38KAuf+C3Vlt09vaEkPHc
        Hyy/t5AlZw2Bg3QyFowx+BoZ0KU9+TZgDUYS8afF+xl6UezqSHcoDOXA4AGL5+ju
        i8Fxsnr67aQnJQ==
X-ME-Sender: <xms:duNOYOUKKXT45iS-jwZjxzzhXQl2ox6wNaV1RKyc6uiz9h-RyJAE-A>
    <xme:duNOYKl9VT7OOoEW-qUkYoAFB8G3UhzMfgdfqIv6FCMAEA-QhriAXFbKywxmTH63a
    eai2b1AO9iobIrQYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:duNOYCaveLZ2vAScBlrZnEpVAz1Eh5Wt0kQHJsPO_BZzwl7ThAj1xg>
    <xmx:duNOYFUjqs5qvwHHhutfg8WZgQH5dp0f5KbG9qqY8rCAcu2K166xOg>
    <xmx:duNOYIktz14sz8eSqSIPplDc9RTzuNeSGOHRAHmf5QBJu1DbHhuZVg>
    <xmx:duNOYFjDEs1711GiI9_EunYmCma2rU1KhurzdNGpv9dANv8VdiMm9g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D9751080063;
        Mon, 15 Mar 2021 00:32:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/5] arm64: dts: allwinner: Add sun4i MMIO timer nodes
Date:   Sun, 14 Mar 2021 23:32:49 -0500
Message-Id: <20210315043250.45095-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315043250.45095-1-samuel@sholland.org>
References: <20210315043250.45095-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a CPU to enter an idle state, there must be some timer which can
trigger an IRQ to wake it back up. The local ARM architectural timer is
not sufficient, because that timer stops when the CPU is powered down.
Some other CPU's ARM architectural timer can be used, but this prevents
that other CPU from entering an idle state. So to allow all CPUs to
enter an idle state at the same time, some MMIO timer must be available
that is not tied to any CPU.

The basic "sun4i" timer seems most appropriate for this purpose due to
its moderate rate, balancing precision and power consumption.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi  | 9 +++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 33df866f6ea9..64e8b4a372cc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -905,6 +905,15 @@ uart4_rts_cts_pins: uart4-rts-cts-pins {
 			};
 		};
 
+		timer@1c20c00 {
+			compatible = "allwinner,sun50i-a64-timer",
+				     "allwinner,sun8i-a23-timer";
+			reg = <0x01c20c00 0xa0>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
 		wdt0: watchdog@1c20ca0 {
 			compatible = "allwinner,sun50i-a64-wdt",
 				     "allwinner,sun6i-a31-wdt";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 62334054c710..9ba3b30e11fa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -332,6 +332,15 @@ cpu_speed_grade: cpu-speed-grade@1c {
 			};
 		};
 
+		timer@3009000 {
+			compatible = "allwinner,sun50i-h6-timer",
+				     "allwinner,sun8i-a23-timer";
+			reg = <0x03009000 0xa0>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
 		watchdog: watchdog@30090a0 {
 			compatible = "allwinner,sun50i-h6-wdt",
 				     "allwinner,sun6i-a31-wdt";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index c277b53f94ea..ff55712ce96e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -128,6 +128,15 @@ ccu: clock@3001000 {
 			#reset-cells = <1>;
 		};
 
+		timer@3009000 {
+			compatible = "allwinner,sun50i-h616-timer",
+				     "allwinner,sun8i-a23-timer";
+			reg = <0x03009000 0xa0>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
 		watchdog: watchdog@30090a0 {
 			compatible = "allwinner,sun50i-h616-wdt",
 				     "allwinner,sun6i-a31-wdt";
-- 
2.26.2

