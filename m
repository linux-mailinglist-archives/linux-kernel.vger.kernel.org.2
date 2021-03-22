Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA4343806
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhCVErv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:47:51 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56825 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhCVErL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:47:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 52381581B0E;
        Mon, 22 Mar 2021 00:47:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 00:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=zVvRScYqkYw0i
        iQoV9fFJJZCE1ioY/h9YnzWp/1T1Jg=; b=pZslr0lKkydtv0S2keiG8Yvbbf6Td
        XfNeSN2Mt68zhxQ556O1GJTy3NdGrQCQbeODEc3V4Uw2LV655d083rnp+XZ/Q9cm
        7D4F1T4ko+1UIO4ARnoL0l5QQcrxZCTxVbpc3uKKMJ/ADhCawfJu4g0THG6B9hR/
        ZSFpc2b1/P/ODGMqb+9dZvtNMmxSzb3+xIv/P/Pw4YRKaYOFvcoaX9zZ/BcWyp6L
        CPvxU5ZVLgruNB+TbGjjYAEcNLQVtMHHFaG5BiqabNShbMZ/Wqzfxv0OiZtnmzh4
        qfcBk5e+lt3aaDEbuHfHzS/WYge5XstQUC6DQ4o1WHvbFnmQ9Y3epO54A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zVvRScYqkYw0iiQoV9fFJJZCE1ioY/h9YnzWp/1T1Jg=; b=uGkqQXs6
        OD4q15+TcNuFZUPQJT5G3L4LBLlwnWIBwiXjYwhUA8s+NBozmT5EYJXKzwXlSspj
        ysaIhoyW8ACY3u4g4Dg6bFBvW+1Cc1FKholemx81iPDYg+2Bs0+rYjaOwusXSbWE
        SIC7HLR913/tpIWDRn4uKt88qD6zQu77Zka8nNZHqyXvX/C9tqZ+jHoyYp/tyVPb
        8WP3RZxYOk7b0SMzPBFSxpbmnDouBSCywV8ttvz4d4EEBc0B9QHrYZgvq7QHRTDc
        oqHEEs27aIvQh8LQ8OmIX9OqZdg+enySK+VRVf2Pnp5nkLpVfPRZj6WkVLqt2Vbw
        B5sgP6AfR60J+A==
X-ME-Sender: <xms:TyFYYCNvov4mbW6mUuA_FAwY1hsLtNAF1AxXLRfYxE26BkpY2bH8ew>
    <xme:TyFYYA_gPHFRHIl9hAJyLDSEAlDLBighLYTDeEhGXShDDg9v8yLt1kUiRQmCj3t4n
    q9uUJ_bgRl7idaFJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:TyFYYJQ4bW986eBMGAI9v7RFyjbql0nOKlRdhLZD6MdN3v9FpRW6yg>
    <xmx:TyFYYCt7qVecwLVXn8eOPgdOmO-kgv0FIQjzmGOSkocsXdFNopAEVA>
    <xmx:TyFYYKfXuamZsiFVutlCDeqZ_4LvP_Bw-QevNE7fG5cgzl5nUcMJPA>
    <xmx:TyFYYLWh8XN3k722Kvfa7om3NquR9v6x092CPPlSrX_rpkUKudew7w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 97FBF1080068;
        Mon, 22 Mar 2021 00:47:10 -0400 (EDT)
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
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 4/5] arm64: dts: allwinner: Add sun4i MMIO timer nodes
Date:   Sun, 21 Mar 2021 23:47:06 -0500
Message-Id: <20210322044707.19479-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322044707.19479-1-samuel@sholland.org>
References: <20210322044707.19479-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a CPU to enter an idle state, some timer must be available to
trigger an IRQ and wake it back up. The local ARM architectural timer is
not sufficient, because that timer stops when the CPU is powered down.
The ARM architectural timer from some other CPU can be used, but doing
so prevents that other CPU from entering an idle state. For all CPUs to
power down at the same time, Linux needs a timer which is not tied to
any CPU.

Hook up the "sun4i" timer so it can be used for this purpose. It runs at
24 MHz, which balances resolution and power consumption.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 9cac88576975..c89032dfb316 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -798,6 +798,15 @@ uart4_rts_cts_pins: uart4-rts-cts-pins {
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
index 49e979794094..01884b32390d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -271,6 +271,15 @@ cpu_speed_grade: cpu-speed-grade@1c {
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
-- 
2.26.2

