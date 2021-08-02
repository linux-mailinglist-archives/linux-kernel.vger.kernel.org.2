Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F543DD099
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhHBGcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:32:02 -0400
Received: from smtpbg127.qq.com ([109.244.180.96]:27916 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232437AbhHBGby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:54 -0400
X-QQ-mid: bizesmtp41t1627885335t6snh1mb
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:15 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: tC2PljDBqdOnSOAMdfK8/oTKxZqOlTXJ/nzFj4aElef7BKEDnL9OqCXepP4ZR
        wII5p+HPpxxMunVvTwyx2FgZWE9tJPFdxfiJKqw2X+4a2F4eNrAFaTcHPVXmgCkrukzzGp3
        KwtTDKS/Ekha4OKV1kXsPOb8bHUS5C/tQkx3/HFozgD6ZVsigAYEmcALc4K7clp876XircB
        KCsWzpvLQIa5eaTiH24TTCcE6/P5hN+l9lekbwINEOXTv1yQ0mFF0NbiODLpM/QF3JNSqaR
        RaqTi0RdpOPU8jqUwuJIMzVr6/FvTSiRxnVIOah6bmkn/0vOl4GdXy10eXuYpMslPpkA==
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 00/17] Basical Allwinner R329 support
Date:   Mon,  2 Aug 2021 14:21:55 +0800
Message-Id: <20210802062212.73220-1-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to add basical support for Allwinner R329 SoC to the
Linux kernel, including clock/pintrl driver and MMC support.

Three patches from the H616 patchset, which are used to support the RTC
with linear day, are attached into this patchset. Other RTC-related
patches of that patchset is not included, because the binding of the
clock part there is still under discussion.

Then I added RTC binding and support (which is now only a struct
addition). I added RTC into this patchset, with the same reason that
H616 patchset contains RTC, which is to make the clock tree correct at
the first inclusion.

After RTC, main basical SoC-specific part, pinctrl and CCU, come. The
R329 CCU is something special because PLLs are in R-CCU, no main CCU.

MMC support is added here because it's also a simple struct addition
work, no main driver code change needed.

Finally it comes the DT part. The DT binding of MaixSense, the device
that I am working on now, is added. Then the DTSI for R329 SoC, the DTSI
file for Sipeed Maix IIA SoM (which is utilized on MaixSense) and the
main DT file for MaixSense are added.

Andre Przywara (3):
  rtc: sun6i: Fix time overflow handling
  rtc: sun6i: Add support for linear day storage
  rtc: sun6i: Add support for broken-down alarm registers

Icenowy Zheng (14):
  dt-bindings: rtc: sun6i: add compatible string for R329 RTC
  rtc: sun6i: add support for R329 RTC
  dt-bindings: pinctrl: document Allwinner R329 PIO and R-PIO
  pinctrl: sunxi: add support for R329 CPUX pin controller
  pinctrl: sunxi: add support for R329 R-PIO pin controller
  dt-bindings: clock: sunxi-ng: add compatibles for R329 CCUs
  clk: sunxi=ng: add support for R329 R-CCU
  clk: sunxi-ng: add support for Allwinner R329 CCU
  dt-bindings: mmc: sunxi-mmc: add R329 MMC compatible string
  mmc: sunxi: add support for R329 MMC controllers
  dt-bindings: arm: sunxi: add compatible strings for Sipeed MaixSense
  arm64: allwinner: dts: add DTSI file for R329 SoC
  arm64: allwinner: dts: r329: add DTSI file for Sipeed Maix IIA
  arm64: allwinner: dts: r329: add support for Sipeed MaixSense

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 .../clock/allwinner,sun4i-a10-ccu.yaml        |   4 +
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |   1 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |   4 +
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |   6 +-
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-r329-maix-iia.dtsi   |  34 ++
 .../dts/allwinner/sun50i-r329-maixsense.dts   |  37 ++
 .../arm64/boot/dts/allwinner/sun50i-r329.dtsi | 244 ++++++++
 drivers/clk/sunxi-ng/Kconfig                  |  10 +
 drivers/clk/sunxi-ng/Makefile                 |   2 +
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c      | 374 +++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h      |  33 ++
 drivers/clk/sunxi-ng/ccu-sun50i-r329.c        | 526 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-r329.h        |  32 ++
 drivers/mmc/host/sunxi-mmc.c                  |  10 +
 drivers/pinctrl/sunxi/Kconfig                 |  10 +
 drivers/pinctrl/sunxi/Makefile                |   2 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c | 292 ++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c   | 410 ++++++++++++++
 drivers/rtc/rtc-sun6i.c                       | 154 +++--
 include/dt-bindings/clock/sun50i-r329-ccu.h   |  73 +++
 include/dt-bindings/clock/sun50i-r329-r-ccu.h |  33 ++
 include/dt-bindings/reset/sun50i-r329-ccu.h   |  45 ++
 include/dt-bindings/reset/sun50i-r329-r-ccu.h |  24 +
 25 files changed, 2320 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
 create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
 create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h

-- 
2.30.2

