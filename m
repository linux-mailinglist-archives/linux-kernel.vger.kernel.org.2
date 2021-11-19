Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6093D456936
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhKSEiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:38:50 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:41669 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232711AbhKSEit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:38:49 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 6A2482B01172;
        Thu, 18 Nov 2021 23:35:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Nov 2021 23:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=Zvs4MCJ98Fz17uPtCXjFsuRAA9
        39RHkh+WYtVtWQ9+8=; b=VWpDU9gwj6NFr/5Z20MLEj27itZGsiFBKvQxytHaRE
        TfPVltN26ApVfHWTFsgM9x2tc3P6/p1ASWwwiZEK6/cCTgCvFxVe10LrigLrBenL
        DhWJ2IweVx/Ce4vivU8vI+iCGD5wcRkPuleWKFwuBVZSyrPRnCzbTWdB1oW9yP03
        JgMf+6cFufwiIZOEQW7+UMsYG8QRZGum8IS3yYpHyl37WuefJo6d87PbvUgWrBqH
        nVGC7/MOS3ni0Jvwb2l+mIe9k2QNjRa/M5RQHq2F61C35OGM9leVBFLCUyk2wuik
        DMTUuQ3J6w9axTojmv3B3wsQu2MTp/y5e15rk6gX6eOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Zvs4MCJ98Fz17uPtC
        XjFsuRAA939RHkh+WYtVtWQ9+8=; b=msbNmSG5DOazfdADWSXqOArLjd++n8tyb
        D965eVstvyPZmzOudi0eWz5qNvUuQURTf1xZaspGpC2Oy3CwYNIDlRUOfa4yS4wi
        LUNUz8pVROt6LMvESVEngA93E93a8JLYc1qkhvybUqHJUEOIBhwBoKsaU0SQWlcp
        iEe3K0xpGcD7mCQ5muInI6TK4eVke9TjXkwT0e8g9GoKMxFIeNlIR/fnr0YWUi+E
        7fwVAggZpUSzWjQQTXTEM0GXBlWIc6HRz6wafHwfXMXy0vQX5CXGa1KOqmKgnczX
        G3H8s0GffkgqhoE58AOq1+rfiir6GYSzose4Uc76jtT6KjLoDTQ0A==
X-ME-Sender: <xms:oimXYZ-odGd0jYgpHl-q_TBcdku-FMsNoXnYMsIHHyI0WaZhnu4_lw>
    <xme:oimXYdvBtHgHU7snPcghrRJHTiW1z49TG13Sx-UMsNDAEbZFGAaG5wQtt6LctJTZG
    qiUVgFno9_PGIQBJQ>
X-ME-Received: <xmr:oimXYXCkZWLQpXHoM6P-eaM8F7XLHxQdGt5gElwMxFesUpAGLY-nu3_Rnb8VXA4j9Ue9VQKgrnRrxXf2CwRgzhv-RDDrqRx82X7hxOIb7boW2qebD-TkucTjiyGoa5Qos4inrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:oimXYdcPJzOMWtJzEWdtnt_6i6xA9mAX2PcgjskIjSsBZcxXdlKT2w>
    <xmx:oimXYeOsVCgDVRO-8rYoahigvkjBFBouJzrghnnJ2bgR_Jsgeys3mA>
    <xmx:oimXYfkqjPtd5Gb-W_PppooZhc45wf6DGGA8lIUBI-41TAHZxFtThQ>
    <xmx:oymXYfE9HO5CrZn8zu2osOsC1CXLw0MsYc9XbRbzSCW4-jepGgaRXc4ELhc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 23:35:46 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 0/6] clk: sunxi-ng: Allwinner D1 clock support
Date:   Thu, 18 Nov 2021 22:35:38 -0600
Message-Id: <20211119043545.4010-1-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the D1's CCU and R_CCU.

I attempted to hook up clock parents the "right" way, not using global
names. To accomplish that, I added several new macros. I am open to
comments on this approach. It looks a bit messier, but seems like it
could be less prone to errors.


Samuel Holland (6):
  dt-bindings: clk: Add compatibles for D1 CCUs
  clk: sunxi-ng: div: Add macros using clk_parent_data and clk_hw
  clk: sunxi-ng: mp: Add macros using clk_parent_data and clk_hw
  clk: sunxi-ng: mux: Add macros using clk_parent_data and clk_hw
  clk: sunxi-ng: gate: Add macros for gates with fixed dividers
  clk: sunxi-ng: Add support for the D1 SoC clocks

 .../clock/allwinner,sun4i-a10-ccu.yaml        |    4 +
 drivers/clk/sunxi-ng/Kconfig                  |   10 +
 drivers/clk/sunxi-ng/Makefile                 |    4 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c        |  140 ++
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.h        |   17 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c          | 1390 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun20i-d1.h          |   15 +
 drivers/clk/sunxi-ng/ccu_div.h                |   78 +
 drivers/clk/sunxi-ng/ccu_gate.h               |   32 +-
 drivers/clk/sunxi-ng/ccu_mp.h                 |   49 +
 drivers/clk/sunxi-ng/ccu_mux.h                |   33 +
 include/dt-bindings/clock/sun20i-d1-ccu.h     |  156 ++
 include/dt-bindings/clock/sun20i-d1-r-ccu.h   |   19 +
 include/dt-bindings/reset/sun20i-d1-ccu.h     |   77 +
 include/dt-bindings/reset/sun20i-d1-r-ccu.h   |   16 +
 15 files changed, 2039 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun20i-d1.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/clock/sun20i-d1-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-r-ccu.h

-- 
2.32.0

