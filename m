Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495AE3821DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhEPXHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:07:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:43948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhEPXHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:07:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 040CCAF28;
        Sun, 16 May 2021 23:06:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/9] arm64: dts: rockchip: Initial Toybrick TB-RK1808M0 support
Date:   Mon, 17 May 2021 01:05:42 +0200
Message-Id: <20210516230551.12469-1-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko et al.,

It seems linux-rockchip list only saw two RK1808 patches for ASoC in 2019.
Following up on a SUSE Hackweek 20 project of mine, here's some patches that
allow me to start booting into the TB-RK1808M0 mPCIe card's eMMC.

Tested using its USB adapter, which allows to connect a serial cable and a
USB storage device that I load kernel+dtb from. It has a reset button, and
Ctrl+C allows to enter a U-Boot prompt (without EBBR/UEFI support though).

Patches are based on the shipping toybrick.dtb file.
http://t.rock-chips.com/en/wiki.php?mod=view&id=110 gives instructions for
compiling sources, but no source download or link is actually provided.

I encountered a hang: earlycon revealed it being related to KVM and vGIC.
Disabling KVM in Kconfig works around it, as does removing the vGIC irq in DT.
I've already tried low and high for the vGIC interrupt, so no clue what might
cause it. On an mPCIe card with 1 GiB of RAM I figured KVM is not going to be
a major use case, so if we find no other solution, we could just delete the
interrupts property in its .dts, as demonstrated here.

The TB-96AIoT 96Boards SoM would be another RK1808 platform someone might
test these patches on. For the TB-RK1808S0 USB stick there's at least no
documented way to access a serial console.

Have a lot of fun!

Cheers,
Andreas

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>

Andreas Färber (9):
  dt-bindings: arm: rockchip: Add Rockchip RK1808 and TB-RK1808M0
  dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK1808
  arm64: dts: rockchip: Prepare Rockchip RK1808
  arm64: dts: rockchip: Add Rockchip TB-RK1808M0
  arm64: dts: rockchip: rk1808k-toybrick-m0: Suppress vGIC interrupt
  dt-bindings: mmc: rockchip-dw-mshc: Add Rockchip RK1808
  arm64: dts: rockchip: rk1808: Prepare eMMC node
  arm64: dts: rockchip: rk1808k-toybrick-m0: Enable eMMC
  arm64: dts: rockchip: rk1808: Add CPU operating points

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../bindings/mmc/rockchip-dw-mshc.yaml        |   1 +
 .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk1808.dtsi      | 276 ++++++++++++++++++
 .../boot/dts/rockchip/rk1808k-toybrick-m0.dts |  97 ++++++
 6 files changed, 381 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk1808.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts

-- 
2.31.1

