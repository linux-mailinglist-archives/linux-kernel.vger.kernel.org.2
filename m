Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5C343804
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVErr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:47:47 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58049 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhCVErL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:47:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C83FE581B0B;
        Mon, 22 Mar 2021 00:47:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 00:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=A9KVfaUr0MHcB
        yVr2yaTwPZZIEIb6Pv5klL7+uwCbgU=; b=TvkgLFJpo7iYX5YhshayJz8hjGKXX
        Vxk26dd9Em18VjtPHEL5ALaJbERvSzbripVuLXQERiGZd01UZ63mZXtUdTACSvXI
        Y4gnQfCN5/MBmoakApfBK2rxBo8Wu2f57yLUqQePrQZ/wKpW/Z6Q5M0qOWZXNgrz
        tbDCSt9hfyPJey4JHQZi/0/5nc27qSyyIa4Q0Sj7S2/XP3/9vhWMYrFgD4oZm4QP
        z1D9fJmi0dLjHPcqW9KP232aj/Twwo2cFX3mRU5BdB9+qIR6TfwL0vXw7HxuYCp4
        vHV4p/vqMmg3k5LOLk/Sj5xbudQ2WugQCqePS7D4uB3t/HeOe5OwgNPjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=A9KVfaUr0MHcByVr2yaTwPZZIEIb6Pv5klL7+uwCbgU=; b=AbsWDHhL
        Op05AX4uiJ8PVJc1MVKxA9lwvJ6FzTNNaVijaQHiz3C0P793VKKPfdYjy83/ao5b
        uikmsX64akshzWRHFAltqd+RpUay67IGxEVwTcuxELyjsfQ4XW1wRe0deFOZhVLu
        7EELUQwrI0nZWXPE9zbW6AYLmejS7iglfTNr8zHMBUbgXaLlNEY1AYaZnXKKwnR2
        sm4xi1UuMAKucUzGeBvfvELK3qM8zxqBx8CkOHf8QrlAt765cQqeqq7TIbjD9sgs
        yIkL0zs+TgHx5ZWgQ2rRDy4sqX1L4p0wYPjYd3/9yFEYnAujvvYs3d0kX6LhudBC
        7tpbdgg8Odphfg==
X-ME-Sender: <xms:TiFYYCf5vUO5MAh_gygYe8xDl6yAn9VGAtDItcnqTLuz4zFO5LaQCQ>
    <xme:TiFYYMM7pk9lzEY5BjgQWAChSozuxXKrOmJ7CIOb2ZGuWvYNcILldIFRtm9R_3A9T
    9dBpydT3XNGUoOVYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:TiFYYDj8nGxp053OdLmbk12l9u0H2H5zy0BWTOtktxZ3C5886EXYmA>
    <xmx:TiFYYP8f9aH3FVsWyTn0cmqbk_6KW2iaH3aHUZUnyao0jHPwuG_35g>
    <xmx:TiFYYOt9dQ1xuRa0qiRPxM6jJ7gUOtdingDuIImvbf5DgPJAPcz26w>
    <xmx:TiFYYPlgsxTwy2SJzqB-_nZrxn75ZfCtUz9TvZ0i1PaQ3xsON0ko5w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C30E1080067;
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
Subject: [PATCH v2 3/5] arm64: dts: allwinner: a64: Sort watchdog node
Date:   Sun, 21 Mar 2021 23:47:05 -0500
Message-Id: <20210322044707.19479-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322044707.19479-1-samuel@sholland.org>
References: <20210322044707.19479-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes should be sorted by unit address. Move the watchdog node to the
correct place, so it will be next to the timer node when that is added.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57786fc120c3..9cac88576975 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -798,6 +798,14 @@ uart4_rts_cts_pins: uart4-rts-cts-pins {
 			};
 		};
 
+		wdt0: watchdog@1c20ca0 {
+			compatible = "allwinner,sun50i-a64-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
 		spdif: spdif@1c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-spdif",
@@ -1321,13 +1329,5 @@ r_rsb: rsb@1f03400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
-
-		wdt0: watchdog@1c20ca0 {
-			compatible = "allwinner,sun50i-a64-wdt",
-				     "allwinner,sun6i-a31-wdt";
-			reg = <0x01c20ca0 0x20>;
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc24M>;
-		};
 	};
 };
-- 
2.26.2

