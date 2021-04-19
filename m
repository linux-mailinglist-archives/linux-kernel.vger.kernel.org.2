Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D969363986
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhDSCx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:53:26 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46837 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233117AbhDSCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:53:19 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DAD8122DC;
        Sun, 18 Apr 2021 22:52:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 18 Apr 2021 22:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=ZSwc/xCZvaeAVu3WuRRMOZasHK
        iHtAPWRkPgguSoPCk=; b=HgeitUikCRe/M+RZedAxU5CwFWoNBH5yty/6dAVhhg
        7WdZp/VBgtfMH455GCN8oNget7zvyXD5DYNYs2q1YmroOK1C02QaKXKziKaKgwkk
        y/o2pVNuK0aUAvWqHFOxkycQDVaWc98VrhdjtCycHke2Y2Qmjh6V/fjZLug40aSF
        gZcOCHiy4tzBdRhodb8p8fLSRUkG5nFIchslI9xVFr8+W/t6XFr++7QH8q1fdNDJ
        GKvBgE6WVVaneylx0K/OQLXYEgk2p9djFNFTe58CPLTDtrHbYED5yc4FHdoeGaQx
        R9aNfrGhFPrDMgHNaAPhRuHy78GnhAwlhD9V+cJT4fTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZSwc/xCZvaeAVu3Wu
        RRMOZasHKiHtAPWRkPgguSoPCk=; b=iJvpTIkXH7xtoHZpjac3yTq1SMoYVQFKy
        IUtxwGcWiBf21JqLWgQ7UKvoLlTodLFd6umAazZGAlFlSIISLv54sUpdl0ag+fr5
        6Di+aXxoXNjNW2W6qI5C1wtvPNBr3BTJOvYj6G9dDVFd4uRfUQguvMMLvJ8R9Ph1
        SXM6kVqkls0sEVFW0AXHud6FGwOdguDa9b5mQUBuBbVnfNPPDR5FqWwiekUgxZcN
        094FJFjLe0pODu7MexiRs2vAKNUTFuRVnL30F5cOfuURVgClaiTEqJfM3vebGJ8r
        kEfuWYZfICz1JfoTRrYNIVhiI/1YedvbeQBay2Z88V+jmHtnkZ1kA==
X-ME-Sender: <xms:f_B8YP5PlJ02rqXuAA-miTncXWFwbebngWs0yolY6evpzxinyizQ8A>
    <xme:f_B8YE5fIqJjGIjNl-rCe-COpJtEiKtS_XfIuX7yBGhZsfrjFhEGrMZuPpXhgGgtS
    u2eCCk5HuLOTKI-Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:f_B8YGcAi2GQqv2Z4foI4TbxHw-DLFNzJVTaq24jNnPfsCXz5qnQlA>
    <xmx:f_B8YAIiY2DefeXJBbYoNo_94HIs1VSblYyKz6xo7zg4oRX96CV3rw>
    <xmx:f_B8YDIL32yBoaNRxnflAgV6F7fYINV9i4XkqnUf8Dutqzi0QJ3vAA>
    <xmx:gfB8YJiTotjJH5zNmJ91y5nV8S0JAggMzjildfJXyGh8JxM82X1Dyw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52770240054;
        Sun, 18 Apr 2021 22:52:47 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/2] sunxi: Enforce consistent MMC numbering
Date:   Sun, 18 Apr 2021 21:52:44 -0500
Message-Id: <20210419025246.21722-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dealing with the inconsistent numbering has been a major pain, and
there is a solution with (as far as I can tell) no tangible downsides.
So let's use it.

Yes, I know the kernel supports UUIDs for root=. But UUIDs do not help
when referencing the whole, unpartitioned device, like is needed for
updating the bootloader and firmware. So for the use case of "write a
bootloader to the SD card, regardless of where the board is currently
booted from", I know of two options:
  - Dig around in sysfs to find the mmc number from the MMIO address,
    which means I have to know the MMIO addresses for every SoC, or
  - Apply patches like these.

Samuel Holland (2):
  ARM: dts: sunxi: h3/h5: Enforce consistent MMC numbering
  arm64: dts: allwinner: Enforce consistent MMC numbering

 arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 6 ++++++
 3 files changed, 18 insertions(+)

-- 
2.26.3

