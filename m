Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC033AA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCOEdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:33:21 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45015 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhCOEcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:32:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id BB495580806;
        Mon, 15 Mar 2021 00:32:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Mar 2021 00:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=dGOSu91ccRc7/
        g9NBATCWczOqGj+KwM6uf+lTMCJph0=; b=INsffJjTtAvcvikujjQ5lK8GO9146
        bs5PsjTVuym7m44yXHZJCUur4UXkpFQqRkFb0yFLLb5tjt0M/vm5EmgEKnD76khz
        bAJ2bJ2SUU/ikYW/PFUq8E3LjfGSTEiGOAYATLkM3w6f1YcmS4jB8+9OwKm+THAA
        Yxz/NxbrER6jjAbjHS0pKXZk4G/GfgSt+QITwU/obhjXUdioSLGFkAP88mLBW91z
        8og8G5soRH/HhVSk3w6Q0ndsELpnxSm6OnYJMk7jS/uYbInccKS0MwU1ppfQPXJK
        1GOIGAe2NwfgQLFfnIR0DyfIeRtJ6AMvGsUD2kH2AAwrBnNjq3s4lNZrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=dGOSu91ccRc7/g9NBATCWczOqGj+KwM6uf+lTMCJph0=; b=bz1M8pU8
        blQl6shGSjymIeQw26uJa0fEEVLv47ptsZCpo72/28j3CovvKOFJWAl98O+nPOAw
        mjHHAkqts475qNmd5+9NXOzPkmSUBDqwbzbJXKqnfAf+neFijnSl0dHXbTOh+1A9
        FtBFNHWByzGSjeWmV2s52I5DUheWcTxhcii6znH+7nDSiJYuOoSBcL0ImQ0qdxxK
        uiDf37lsRiDH+d2WD0Rj50noyhmV0ClBLYlObhPbOKM4AsGkObyIAoVK0gZrsafa
        5r+XXgXLXEnSuDBJJ8SWcWMv575VLaxc9MCwuxeJpkac1tTMi/gH7AgJWzq6f32w
        g28TGrh/xjBfBA==
X-ME-Sender: <xms:duNOYKC71YcZdKRuUsXYh5ESGA7XTzNM-RWP030b6bJWnXPM4VlHCg>
    <xme:duNOYEi_CNzrKQY3JYutB07o8U7dVjjF7LOijFBuB7WPW6LQjC7oYp4ikDeOc4uwA
    Hlz6z6UDqs-wJcLFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:duNOYNl5VEn4sFxe9044vjksbxZsli6UFvncYI8fNlQhhxZsb3iF7w>
    <xmx:duNOYIxDYOVNXV5eGopsP49dYkssNNyQT51Q_muPnqLTACz9JbuKVQ>
    <xmx:duNOYPROABD6I6Q-RKAnnYxZqAP2Mbm_t8eEsXvsj7b598LbHGN74Q>
    <xmx:duNOYE9ffTZ9qZxKwQsjEQBU71En25CXTNObKptlzhfvESaFDjPoqA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 116001080054;
        Mon, 15 Mar 2021 00:32:54 -0400 (EDT)
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
Subject: [PATCH 5/5] arm64: sunxi: Build the sun4i timer driver
Date:   Sun, 14 Mar 2021 23:32:50 -0500
Message-Id: <20210315043250.45095-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315043250.45095-1-samuel@sholland.org>
References: <20210315043250.45095-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the ARM architectural timer is generatlly the best timer to use,
a non-c3stop timer is needed for cpuidle. Use the sun4i timer for this
purpose, which is present on all 64-bit sunxi SoCs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cdfd5fed457f..7f6a66431fa7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -26,6 +26,7 @@ config ARCH_SUNXI
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select RESET_CONTROLLER
+	select SUN4I_TIMER
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
-- 
2.26.2

