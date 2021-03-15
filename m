Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72233AA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhCOEdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:33:19 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56595 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhCOEcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:32:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B6A9D5807EA;
        Mon, 15 Mar 2021 00:32:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Mar 2021 00:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=SF9IU2RVsueqQ
        aPsp71TscQ9XCUTFLqI/yko/XtJYbQ=; b=qR3R85uqjeJmF4ATRd58nHRPLHT/X
        czI7Bnx1JhhQfe/hX3NZpUHWnOOIPaZ0nAHxmPZFhK+6hqZqRRNmJWkn7Sk8yLyr
        0jf+kx0NyHgDDvXUluCCQWhoaVNoxrMXwd4p2GTVhg7kuar3DleXgNFQ01fzur89
        zGwLLgY24CBEjPDtTFOxT4y5CLdJJizS6p+XaIfGXFNYHYJZVsaMmxtwF9Vn7y59
        921FeKpepxZpVUlILy7wut3xB5YuhevFJzNmpPNxo+vGE5IpdnISsg/tLeJGXGfW
        tv1uRlea8b0Fxq0Z2jC/zhbUNUYYUMYHOxIsvXz7EH7O1pzTYsiTLasOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=SF9IU2RVsueqQaPsp71TscQ9XCUTFLqI/yko/XtJYbQ=; b=T1rfS1fP
        zj6z7MTBgkzaAZurBpcg93n1g4DhssMguREt8b8i0jpXMMXk/Zc6KFuaW5jk24QS
        RJ5AFrPFqGuzhSrKS0PhzA9uX3yk4VblacdUCxaHQQx3tCnDBQnkqRDqgJDfs1fU
        MVgY0N5BpAok82193VmyBNpnkLGm06rnjgPIqQsSxUpXFNruRAc5DcdJSLjkpJAf
        PI5cTvGmzQilQT0qy0/4wDN9a0IzuAsPI2AqEBjfyrcQgg4o8bFIadebj4Pyjn0f
        7Dj5/BJ6ZgI8AdLJfYH4Oin7acA85ILpenk6E6yZ8b0vR26S8ZHvkiRnQu5YN6gy
        PzMuWx9VbE3Vww==
X-ME-Sender: <xms:deNOYAXKTQFHP0lQC4BYpm9aj_8vhFeDN9KjosCSJOAgW-cutDQhrA>
    <xme:deNOYEmeMUzPapMer9bVsmmCvQLDSNW9HLVshM0Q1klSOpH6vbXIlAjW094iz0EvY
    DhN283J8N3J1qqMQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:deNOYEZTAjZdr4fFzt4EiIoo8SUj1lKRj27B7zt_PkJh02TbPRj7Wg>
    <xmx:deNOYPXEOdNEuhV4KVCfIWp-P8e_kcy7Ey9oVcXgzT_EQf3q8EFsUQ>
    <xmx:deNOYKm-rBpADlIG0iD8iN-fTpn96nFPKK2e20h6VvSjXxqawcaHbw>
    <xmx:deNOYPgMTlFtbHUiqSfWKjAFBO_FOxMTvyZzhjvyLCw5PtfhwAessw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14A981080064;
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
Subject: [PATCH 3/5] arm64: dts: allwinner: a64: Sort watchdog node
Date:   Sun, 14 Mar 2021 23:32:48 -0500
Message-Id: <20210315043250.45095-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315043250.45095-1-samuel@sholland.org>
References: <20210315043250.45095-1-samuel@sholland.org>
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
index 206693423aa6..33df866f6ea9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -905,6 +905,14 @@ uart4_rts_cts_pins: uart4-rts-cts-pins {
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
@@ -1436,13 +1444,5 @@ r_rsb: rsb@1f03400 {
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

