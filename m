Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4256C343807
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVEry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:47:54 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47031 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhCVErL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:47:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 32AC2581B0D;
        Mon, 22 Mar 2021 00:47:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Mar 2021 00:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=LfE/ugdalA0RX2yyD9H37azMsf
        8cwA7ptPgiuuL5JmU=; b=lQarjjN2wgFdPqezoGm7BLBnmDIEyNbWmDI9JIC58j
        cHbRs9/OFy6fZBcmod+5881f1xGWEhftM3YEvIycByw9fKOZmqxPxkQic+6/rvJT
        Pmp4UwuONtgjksENwFuU2lMHSYGn7llqI8lyERHqt6r45h2KRCNZ5J+3ynBA9Ip/
        8eqPZOpyeEzCIWKC6KWvBozyUGrVbU1uWj9bdta5eVrMag8TsUuSQbJftUHqIBPx
        v7C8+iPnenJr/epuBt09vI7eestaBBwNh55eqxaRYknIPUm3iAolJFe/9Mfydgcy
        iimUDDAzpASBiM28I70aOioBx1Njcosv+Hv/S8Ta24LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LfE/ugdalA0RX2yyD
        9H37azMsf8cwA7ptPgiuuL5JmU=; b=XtbmemrvCrQK8I1GXs4aoWkjh43mXkGuJ
        FI13sqKj+CQ1RjMF/r6dIrVqXQV9BGclBoRFwQ2pNEeYYsmhXU57gZHR+aLK7Ei4
        TqdLSGFFfd+7WuUc7ahobNGpMIVqV9103+UIVv63TYJMWvIhwa+AjTSvj6jjd/Xb
        X70WwQFvC/ISrYWOCgEyJCQBgPerbifO+k2D028FQOWhEF/uoBUcVIj43INNrIVQ
        0l+tMfRhfl/Tb9uBSEVdgkdlqinDcaXBl6xHtLca7nSLEnijUua5Ba1cpRc1ElMQ
        AoWlJAQdpHr8u5jKkHoLJw8zCVtueyCnck5He0LBRfsGZOA12BLwQ==
X-ME-Sender: <xms:TCFYYEGOSmNfc7Drb0scRZDPEgOA0Rl1hVKMaeDzmvUe1BAyOGv7fA>
    <xme:TCFYYNUTbwzKv3H5NUy3HOhQeb4GIPFJAtdJuZnyK6B7dt-PH9t1RZ13hBmOaDO90
    JRRkuyy_2vtBI7hdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:TSFYYOIn2Qwf2C0SRfRxW6-yHINC7C-XwH-AzEjYg1FA_Brapm0JiQ>
    <xmx:TSFYYGFzhpdCbPNv1Bwga-FyIJcpORiinXDKie9VvADkTXwP4P-kbA>
    <xmx:TSFYYKUKmAdPTmXJibUaeTYX0zRkwK4aYbrksxqQG39SIb7e7pyjyQ>
    <xmx:TyFYYDOQ2mDG8orsI_TeJtgSBsQzef6HW7ssl7-tEbA7Mh6Igy67GA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77899108005C;
        Mon, 22 Mar 2021 00:47:08 -0400 (EDT)
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
Subject: [PATCH v2 0/5] arm64: sunxi: Enable the sun4i timer
Date:   Sun, 21 Mar 2021 23:47:02 -0500
Message-Id: <20210322044707.19479-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding CPU idle states, hook up the sun4i timer.
Having a non-c3stop clockevent source available is necessary for all
CPUs to simultaneously enter a local-timer-stop idle state.

Changes from v1:
  - Removed H616 changes (depends on an unmerged patch set)
  - Reworded the patch 4-5 commit messages for clarity
  - Added Acked-by tags

Samuel Holland (5):
  dt-bindings: timer: Simplify conditional expressions
  dt-bindings: timer: Add compatibles for sun50i timers
  arm64: dts: allwinner: a64: Sort watchdog node
  arm64: dts: allwinner: Add sun4i MMIO timer nodes
  arm64: sunxi: Build the sun4i timer driver

 .../timer/allwinner,sun4i-a10-timer.yaml      | 42 +++++++++----------
 arch/arm64/Kconfig.platforms                  |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++----
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  9 ++++
 4 files changed, 46 insertions(+), 31 deletions(-)

-- 
2.26.2

