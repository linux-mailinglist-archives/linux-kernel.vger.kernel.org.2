Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04EC30FEA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBDUlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:41:06 -0500
Received: from marcansoft.com ([212.63.210.85]:33002 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhBDUk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:40:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 88EF3425B6;
        Thu,  4 Feb 2021 20:40:06 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 00/18] Apple M1 SoC platform bring-up
Date:   Fri,  5 Feb 2021 05:39:33 +0900
Message-Id: <20210204203951.52105-1-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings up initial support for the Apple M1 SoC, used in the
2020 Mac Mini, MacBook Pro, and MacBook Air models.

The following features are supported in this initial port:

- UART (samsung-style) with earlycon support
- Interrupts, including affinity and IPIs (Apple Interrupt Controller)
- SMP (through standard spin-table support)
- simplefb-based framebuffer
- Devicetree for the Mac Mini (should work for the others too at this
  stage)

The primary pain points of this port are:

- Apple SoCs require FIQs, as the timers and "fast" IPIs are hardwired
  to the FIQ interrupt line. This patchset introduces FIQ support through
  the alternatives mechanism, so as to not affect other platforms,
  implemented as simply merging IRQs and FIQs. The AIC driver takes care
  of discriminating and routing IRQs to the right users.

- These SoCs blackhole nGnRE writes to internal MMIO ranges, and require
  nGnRnE. There is no obvious right solution to solve this. I do not
  expect the two patches for that in this series to be merged as-is, but
  the commit messages describe the problem and potential solutions. I
  hope we can have a discussion and converge on the right approach to
  solve this problem in the sanest way.

These machines officially support booting unsigned/user-provided
XNU-like kernels, with a very different boot protocol and devicetree
format. We are developing an initial bootloader, m1n1 [1], to take care
of as many hardware peculiarities as possible and present a standard
Linux arm64 boot protocol and device tree. In the future, I expect that
production setups will add U-Boot and perhaps GRUB into the boot chain,
to make the boot process similar to other ARM64 platforms.

The machines expose their debug UART over USB Type C, triggered with
vendor-specific USB-PD commands. Currently, the easiest way to get a
serial console on these machines is to use a second M1 box and a simple
USB C cable [2]. You can also build a DIY interface using an Arduino, a
FUSB302 chip or board, and a 1.2V UART-TTL adapter [3]. In the coming
weeks we will be designing an open hardware project to provide
serial/debug connectivity to these machines (and, hopefully, also
support other UART-over-Type C setups from other vendors). Please
contact me privately if you are interested in getting an early prototype
version of one of these devices.

A quickstart guide to booting Linux kernels on these machines is
available at [4], and we are documenting the hardware at [5].

[1] https://github.com/AsahiLinux/m1n1/
[2] https://github.com/AsahiLinux/macvdmtool/
[3] https://github.com/AsahiLinux/vdmtool/
[4] https://github.com/AsahiLinux/docs/wiki/Developer-Quickstart
[5] https://github.com/AsahiLinux/docs/wiki

== Project Blurb ==

Asahi Linux is an open community project dedicated to developing and
maintaining mainline support for Apple Silicon on Linux. Feel free to
drop by #asahi on freenode to chat with us, or check our website for
more information on the project:

https://asahilinux.org/


Hector Martin (18):
  dt-bindings: vendor-prefixes: add AAPL prefix
  dt-bindings: arm: cpus: Add AAPL,firestorm & icestorm compatibles
  dt-bindings: arm: AAPL: Add bindings for Apple ARM platforms
  arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
  tty: serial: samsung_tty: add support for Apple UARTs
  dt-bindings: serial: samsung: Add AAPL,s5l-uart compatible
  tty: serial: samsung_tty: enable for ARCH_APPLE
  arm64: cpufeature: Add a feature for FIQ support
  arm64: cputype: Add CPU types for the Apple M1 big/little cores
  arm64: Introduce FIQ support
  arm64: Kconfig: Require FIQ support for ARCH_APPLE
  arm64: setup: Use nGnRnE IO mappings for fixmap on Apple platforms
  arm64: ioremap: use nGnRnE mappings on platforms that require it
  dt-bindings: interrupt-controller: Add DT bindings for apple-aic
  irqchip/apple-aic: Add support for the Apple Interrupt Controller
  irqchip/apple-aic: Add SMP / IPI support
  dt-bindings: display: add AAPL,simple-framebuffer
  arm64: apple: Add initial Mac Mini 2020 (M1) devicetree

 .../devicetree/bindings/arm/AAPL.yaml         |  36 ++
 .../devicetree/bindings/arm/cpus.yaml         |   2 +
 .../bindings/display/simple-framebuffer.yaml  |   5 +
 .../interrupt-controller/AAPL,aic.yaml        |  88 +++
 .../bindings/serial/samsung_uart.yaml         |   4 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  14 +
 arch/arm64/Kconfig                            |  10 +
 arch/arm64/Kconfig.platforms                  |   8 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/apple/Makefile            |   2 +
 arch/arm64/boot/dts/apple/apple-j274.dts      | 143 +++++
 arch/arm64/include/asm/assembler.h            |   4 +
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/cputype.h              |   6 +
 arch/arm64/include/asm/daifflags.h            |   7 +
 arch/arm64/include/asm/fixmap.h               |  10 +-
 arch/arm64/include/asm/io.h                   |   9 +-
 arch/arm64/include/asm/irqflags.h             |  17 +-
 arch/arm64/kernel/cpufeature.c                |  32 ++
 arch/arm64/kernel/entry.S                     |  27 +-
 arch/arm64/kernel/setup.c                     |  12 +
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-apple-aic.c               | 501 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/tty/serial/samsung_tty.c              | 297 +++++++++--
 .../interrupt-controller/apple-aic.h          |  14 +
 include/linux/serial_s3c.h                    |  16 +
 include/uapi/linux/serial_core.h              |   3 +
 31 files changed, 1243 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/AAPL.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
 create mode 100644 arch/arm64/boot/dts/apple/Makefile
 create mode 100644 arch/arm64/boot/dts/apple/apple-j274.dts
 create mode 100644 drivers/irqchip/irq-apple-aic.c
 create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h

--
2.30.0

