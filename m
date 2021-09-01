Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9713FD30A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242058AbhIAFkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:40:53 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55495 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231289AbhIAFkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1148B5804D0;
        Wed,  1 Sep 2021 01:39:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Sep 2021 01:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=FxqtVW/6YN0SWpyFPqpwdZXDT4
        Lx8JTld/yop8M1eVk=; b=c5S99uPolT1QGQOPkl+t6WAnU8OzVjm+Fsh7w50Zdd
        HuvdE46+SnP53Vkkx3loVfCVE8qjdOqGxCm3JeRBrkriP0/rETP9wHXuuDWI0gdn
        lh1dLYyFpp1N8WF75GAv8GTIC4CX/qSsgXSmJw1wq5WSsmt3tDUejFmDIF2vIMEo
        qEWOQnIA1aIf2cQRXAc6j5i5gAjDF3ZIvAaHR17cSplTR6RQI1ItS5saYjI+IaoV
        LgUcGJy7UWDigdcBj1tbS65NkoOOxpE1FFhYA/8TheuNpcY/Ju2c6towgHWYG594
        cNFgGF0/d2UWGJw5TJ2N4u8Ykn30DeKidFbJpk9IBLdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FxqtVW/6YN0SWpyFP
        qpwdZXDT4Lx8JTld/yop8M1eVk=; b=hQ6RzpkcQvPchmp1cegqFLCMUihgHX73M
        AB0maHQAsNxhoDHV2OSuU6JEUPD6KL6+33wL2BH/sIBi5ayzBhdOXwbMTjFO0Gcu
        NRBQBPT7h+SQPT+9R+alZvXm/bp7xVaUXRQeNPWfCLlTbaKy2ZPnibi9kSL3WN6C
        azZH1PfsrEhQd6OIYy6GNmDMF3fAn1kZLXK9MBOX1AEKcHbzS4F1A0GVnrxe2891
        YpNJSzRtwU/kkgB0maDVgoF1CHVozps3a+t/ejn+yMYunrzX7DGaTfSbyvZ8cXd0
        3EXDymATABxNTGrBeNLV/m1VudxdL3EIT/hr1XOXsVp5pvto/uFsA==
X-ME-Sender: <xms:KRIvYezNrovaJISZJ2CKg9pIHyQm__E9e3E4izMg0b8KK14EwyA4vg>
    <xme:KRIvYaTR9UsczZctL6Prrsi4MQFalcP1irqPgDuDdH_6g8ZfRMd72ui7yR9VDre3I
    0nIBLyCPvmNcqfcRA>
X-ME-Received: <xmr:KRIvYQXzk6TSwbVJpmYcUZNZonG-vzWS967znzykBHpJly1OcXmcQrnCJq3tE5T7DaYMcO3FKVzei2OQpQ1I4Ij4du0rpSUl7YFlT8KglP_EJZWHijJfJPA2N77HXlNiYXsE1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:KRIvYUhj1KLnx0cS7ntGY_Xr-oQDjX0ZY1BzeXt1W29fmI9mzoxTJQ>
    <xmx:KRIvYQC6RFjyEqCRg3duALsqntEAH7gnKcLhWxM8Hbs8OtXbYpvPGQ>
    <xmx:KRIvYVLORU2Y1fsYQ2ujnWF-cuELVxQKECvDLdfeL3uXXG8aL1EaNg>
    <xmx:KxIvYU7MTcv-9ANF1oEkMNlXwsvxv_v980y03yydOKLru9D857D-1Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:39:52 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 0/7] clk: sunxi-ng: Add a RTC CCU driver
Date:   Wed,  1 Sep 2021 00:39:44 -0500
Message-Id: <20210901053951.60952-1-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a CCU driver for the RTC in the H616 and R329.
The extra patches at the end of this series show how it would be
explanded to additional hardware variants.

The driver is intended to support the existing binding used for the H6,
but also an updated binding which includes all RTC input clocks. I do
not know how to best represent that binding -- that is a major reason
why this series is an RFC.

A future patch series could add functionality to the driver to manage
IOSC calibration at boot and during suspend/resume.

It may be possible to support all of these hardware variants in the
existing RTC clock driver and avoid some duplicate code, but I'm
concerned about the complexity there, without any of the CCU
abstraction.

This series is currently based on top of the other series I just sent
(clk: sunxi-ng: Lifetime fixes and module support), but I can rebase it
elsewhere.

Samuel Holland (7):
  dt-bindings: rtc: sun6i: Add H616 and R329 compatibles
  clk: sunxi-ng: div: Add macro using CLK_HW_INIT_FW_NAME
  clk: sunxi-ng: mux: Add macro using CLK_HW_INIT_PARENTS_DATA
  clk: sunxi-ng: mux: Allow muxes to have keys
  clk: sunxi-ng: Add support for the sun50i RTC clocks
  [DO NOT MERGE] clk: sunxi-ng: Add support for H6
  [DO NOT MERGE] clk: sunxi-ng: Add support for T5

 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |  55 ++-
 drivers/clk/sunxi-ng/Kconfig                  |   6 +
 drivers/clk/sunxi-ng/Makefile                 |   1 +
 drivers/clk/sunxi-ng/ccu_common.h             |   1 +
 drivers/clk/sunxi-ng/ccu_div.h                |  14 +
 drivers/clk/sunxi-ng/ccu_mux.c                |   7 +
 drivers/clk/sunxi-ng/ccu_mux.h                |  28 ++
 drivers/clk/sunxi-ng/sun50i-rtc-ccu.c         | 433 ++++++++++++++++++
 drivers/clk/sunxi-ng/sun50i-rtc-ccu.h         |  15 +
 drivers/rtc/rtc-sun6i.c                       |  17 -
 include/dt-bindings/clock/sun50i-rtc.h        |  12 +
 11 files changed, 566 insertions(+), 23 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
 create mode 100644 drivers/clk/sunxi-ng/sun50i-rtc-ccu.h
 create mode 100644 include/dt-bindings/clock/sun50i-rtc.h

-- 
2.31.1

