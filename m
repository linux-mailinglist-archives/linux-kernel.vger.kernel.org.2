Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A281343805
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCVErs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:47:48 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49111 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229872AbhCVErM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:47:12 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B7ED9581B0F;
        Mon, 22 Mar 2021 00:47:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 00:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Ow8+C1n+5nakf
        +x70/1kbyfB9ApJLz6iTJRCy/x/ueU=; b=WYCEJuLEh0BOAC0gqpg7dr4/qhhq8
        83q6nhGABVK9RYpf63J4BqgFr/ynkA3liMWwVuLzAou7f4eEtiKBwa+WDko4LgKA
        7vImUk5efSXhYKuGsOH0RYWycKTIY5uwxUoVp7vpUQgTpigG+3Wy8m259yPuVbdA
        BHESHVrOf2u/w/lzk/aMxKLcle8lBPVecXmvkfa0GKf8/NNz6SoG3bKGPu2fuspW
        GaCevNKJGCjrWXw1oO1giLQU3ZHhrNk/KXdWPZPrfg71mlcmI9TXNkxUPPRWcrm1
        Wxq15qmLUALKEtwpP6v09aTho5xtAPEGyVu/5omYdyuGVbF+2WQT8tK7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Ow8+C1n+5nakf+x70/1kbyfB9ApJLz6iTJRCy/x/ueU=; b=ayhgVyzD
        DoV+/Ya4owz4HbSZGl/3IdG4X5UlGevNtzyQfpCD5OAJWCDbTyLBFuvktt7+szik
        HShW0ToQ3uasa9L8ndzXyxBmjQLEQ2D2rkpwQk6SPKDMUpsO82raKXUSSCBGFmKm
        XEdr2zJlpSyF9RzrOKgG5Ihm4lzUyxRVPPvhpf4hTxJd/G7FrODOXdRQtORE49Vn
        KadxUN6mgUZtLvSlzNeF6o4Ro+CWteaHVG33nG2Vw+emv+B7+uJ8KXrCZ6xQSSl2
        7wawusAJpi3i0Nux4vinrNHSzqQDk1bMvdDZ7dbhZSQKoNuMJfKuW+QPx3CY2v0g
        M5GK2pur0xUJoA==
X-ME-Sender: <xms:TyFYYG2AhLJY47r3RGhaL9C9HVYJZG8zY-gvhOx1neApv_bzlvAzzQ>
    <xme:TyFYYA0gE-F42pQoPGBohupSTnERdkYTYa9zze0-59uBVKHmrx7jiRMZc9LBGgjrZ
    g2WPtzaTXQ6Rtmjug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:TyFYYB_PTUDGPgyWgCEe-BKAGDObZ5y3P656dR-i86-SqH9k2d97Qg>
    <xmx:TyFYYF2LXCYaN-BC_xRn2qMVgkhhr3OqGXMaV3DRkyvVSXSXkkTMMA>
    <xmx:TyFYYG_uKwiIPbFhWRlnhdoqBjdPZgkwP_Hv1XeyXkWPPtajFNeq5w>
    <xmx:TyFYYFYHA62AV0O_D4xErddAgrXj64bYTo8nfS06rVAtXHDO1Dq8aw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 210A8108005F;
        Mon, 22 Mar 2021 00:47:11 -0400 (EDT)
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
Subject: [PATCH v2 5/5] arm64: sunxi: Build the sun4i timer driver
Date:   Sun, 21 Mar 2021 23:47:07 -0500
Message-Id: <20210322044707.19479-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322044707.19479-1-samuel@sholland.org>
References: <20210322044707.19479-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the ARM architectural timer is generatlly the best timer to use,
a non-c3stop timer is needed for cpuidle.

Build the "sun4i" timer driver so it can be used for this purpose.
It is present on all 64-bit sunxi SoCs.

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

