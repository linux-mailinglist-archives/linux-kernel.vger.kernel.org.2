Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2533AA79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhCOEdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:33:18 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50599 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhCOEcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:32:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B8D7B5807FB;
        Mon, 15 Mar 2021 00:32:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Mar 2021 00:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=qeecw1UAGE0975QPTTGaKh4hQs
        yijA7CZvhW4N9uBJ8=; b=EbkHMU0WJzAPe6GrNOWi5OV1RGCd6joeJbQ/6nxx9V
        v8oTJ8Pspq6selpY8Qigj7X6oEFPZmWYYDPqf5ZoncGAZ3QEFvJQ+/3Iqf31s63W
        GzX5WUifMoVHzyIFxtkO9EJ8kWSzJGnugQ03SP8DwKE7XfAOXyCInCJ2m85cxQRv
        wW3Vi9DuXobyM0DRQ7XZjz7zBTDnrR7CF6oGkAu4kmIPNgGiHU8RaqukjCEPETIk
        fvKF2uPrQM0rFdLVngCYl8Thy+rSaNdHMTIZ3G5IrELWBTSagsH8SVc829HRY4RT
        pYyztc6vMOcQdhPB7s75YciZGLYa+Ng9ow/E5Eo6eNcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qeecw1UAGE0975QPT
        TGaKh4hQsyijA7CZvhW4N9uBJ8=; b=TRxHNiu8uSlMQmVFdZDKAGtIDhg+JKmMy
        joaukADsSPEaC8vAbTmoZcq2NDmgle3+Nm1XDpOHPsWqB23pYsrFB1tgbnCeu2FH
        wQoD9rbmBu4iOyx12NT3PjPWp2Vfz4GH15dxhcU7VJgzdfZrPK98970gL6+mbBDz
        OohOcBCXEJtXgzyJxegGw9flueCStW33tvdnBI/ObMBhK2cAuJ4GlKZUak+XP0VA
        mRkIXx+W9Ap/8w7mKzao9r4rfHL2zK0TL/OoDFpcE9WwKTJSZuoB1Rb/ILwJgiUD
        /FmWUXmhy406Eobxllk5lwDumzvDdCp3Saiee2la7giaF3tiyAglA==
X-ME-Sender: <xms:dONOYI5uaqhAzN5HgTsguGtL_CYJVlVf_NWp7ghwM09YgxIEEiGtnQ>
    <xme:dONOYJ7CgqsoyblDWVHKXoYxO54FXBnJpgJ4FOZbSy4N9pbaUzf7zCipBozkN-2-G
    oAQnhJ3SX54s-9zSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:dONOYHcpj-Zy8EgGr3PqoLIKrcQW_PgrQ5QKnv9U6QlKrJmarp-vyQ>
    <xmx:dONOYNL9zHp5EXwojj8CuhoOiJuzAPFKIcWlLgEEP4fvE2HE3eAc5A>
    <xmx:dONOYMKCLsssBB4WXdFAYYcnN58W4UNMc9HDzd99zQ3bGlxUrsV2YQ>
    <xmx:deNOYBU3RahKfBWhrZizwttJ3FVL4vlrM0yPACJGAOTwmVkxINfeSg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89C6D1080057;
        Mon, 15 Mar 2021 00:32:51 -0400 (EDT)
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
Subject: [PATCH 0/5] arm64: sunxi: Enable the sun4i timer
Date:   Sun, 14 Mar 2021 23:32:45 -0500
Message-Id: <20210315043250.45095-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding CPU idle states, hook up the sun4i timer.
Having a non-c3stop clockevent source available is necessary for all
CPUs to simultaneously enter a local-timer-stop idle state.

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
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  9 ++++
 5 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.26.2

