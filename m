Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1F31B8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBOMSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:18:25 -0500
Received: from marcansoft.com ([212.63.210.85]:42250 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhBOMSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:18:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A15B741E96;
        Mon, 15 Feb 2021 12:17:33 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Date:   Mon, 15 Feb 2021 21:16:48 +0900
Message-Id: <20210215121713.57687-1-marcan@marcan.st>
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

See below for an overview of changes since v1.

== Patch overview ==

- 01-02 Core platform DT bindings
- 03-04 CPU DT bindings and MIDR defines
- 05-06 Add interrupt-names support to the ARM timer driver
        This is used to cleanly express the lack of a secure timer;
        platforms in the past have used various hacks like dummy
        IRQs here.
- 07-09 FIQ support
        These platforms require FIQ support, as some interrupt sources
        are hard-wired to FIQ. We settled on always keeping the FIQ/IRQ
        mask state synced, and only redirecting the vectors using
        alternatives on these CPUs. Other platforms retain the existing
        panic-on-FIQ behavior.
- 10-12 ioremap_np() (nGnRnE) support
        The fabric in these SoCs only supports nGnRnE accesses for
        standard MMIO, except for PCI ranges which use nGnRE. Linux
        currently defaults to the latter on ARM64, so this adds a new
        ioremap type and DT properties to automatically select it for
        drivers using OF and devm abstractions, under buses specified
        in DT.
- 13-15 AIC (Apple Interrupt Controller) driver and support defines
        This also embeds FIQ handling for this platform.
- 16    Introduce CONFIG_ARCH_APPLE & add it to defconfig
- 17-23 Add Apple SoC support to the samsung_tty driver
        This includes several refactoring patches to be able to more
        cleanly introduce this, as well as a switch to
        devm_ioremap_resource to be able to use the nGnRnE support
        introduced above. Earlycon support is included with a
        special-case nGnRnE hack, as earlycon is too early to use the
        generic infrastructure.
- 24    simple-framebuffer bindings for Apple (trivial)
- 25    Add the initial M1 Mac Mini (j274) devicetree

== About the hardware ==

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
drop by #asahi and #asahi-dev on freenode to chat with us, or check
our website for more information on the project:

https://asahilinux.org/

== Changes since v1 ==

* DT vendor prefix AAPL -> apple
* Added interrupt-names support to the ARMv8 timer driver, to better
  represent the lack of secure timer
* Added sysreg_apple.h to define Apple vendor specific CPU system
  registers
* No longer gating the DAIF.F bit handling via alternatives; now we
  always keep it in sync with DAIF.I on all platforms.
* ARCH_APPLE selects APPLE_AIC
* Fixed copyright of DT (GPL-2.0+ OR MIT)
* Made all the copyright lines for new files
  `Copyright The Asahi Linux Contributors`
* Split DT into apple-m1.dtsi and apple-j274.dts
* Cleaner solution for FIQ alternatives in entry.S from Marc
* Implemented proper nGnRnE solution using the `[non]posted-mmio`
  DT properties and ioremap_np()
* Added (tentative) support for guest timer FIQs in AIC
* Added masked initialization and basic fallback handling for other FIQs
* Reworked AIC to not use chained IRQ domains, and split up FIQ irqchip
* More refactoring of the samsung_tty driver to cleanly introduce Apple
  support
* Fixed many style issues, bugs, and other nits

Note: this keeps the `apple,arm-platform` compatible, which is now used
to gate the OF nonposted-mmio logic to Apple platforms only.

Hector Martin (24):
  dt-bindings: vendor-prefixes: Add apple prefix
  dt-bindings: arm: apple: Add bindings for Apple ARM platforms
  dt-bindings: arm: cpus: Add apple,firestorm & icestorm compatibles
  arm64: cputype: Add CPU implementor & types for the Apple M1 cores
  dt-bindings: timer: arm,arch_timer: Add interrupt-names support
  arm64: arch_timer: implement support for interrupt-names
  arm64: cpufeature: Add a feature for FIQ support
  arm64: Always keep DAIF.[IF] in sync
  asm-generic/io.h:  Add a non-posted variant of ioremap()
  arm64: Implement ioremap_np() to map MMIO as nGnRnE
  of/address: Add infrastructure to declare MMIO as non-posted
  arm64: Add Apple vendor-specific system registers
  dt-bindings: interrupt-controller: Add DT bindings for apple-aic
  irqchip/apple-aic: Add support for the Apple Interrupt Controller
  arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
  tty: serial: samsung_tty: Separate S3C64XX ops structure
  tty: serial: samsung_tty: add s3c24xx_port_type
  tty: serial: samsung_tty: IRQ rework
  tty: serial: samsung_tty: Use devm_ioremap_resource
  dt-bindings: serial: samsung: Add apple,s5l-uart compatible
  tty: serial: samsung_tty: Add support for Apple UARTs
  tty: serial: samsung_tty: Add earlycon support for Apple UARTs
  dt-bindings: display: Add apple,simple-framebuffer
  arm64: apple: Add initial Mac Mini 2020 (M1) devicetree

Marc Zyngier (1):
  arm64: entry: Map the FIQ vector to IRQ on NEEDS_FIQ platforms

 .../devicetree/bindings/arm/apple.yaml        |  36 +
 .../devicetree/bindings/arm/cpus.yaml         |   2 +
 .../bindings/display/simple-framebuffer.yaml  |   5 +
 .../interrupt-controller/apple,aic.yaml       |  88 +++
 .../bindings/serial/samsung_uart.yaml         |   4 +-
 .../bindings/timer/arm,arch_timer.yaml        |  14 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  15 +
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/Kconfig.platforms                  |   8 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/apple/Makefile            |   2 +
 arch/arm64/boot/dts/apple/apple-j274.dts      |  41 ++
 arch/arm64/boot/dts/apple/apple-m1.dtsi       | 124 ++++
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/assembler.h            |   6 +-
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cputype.h              |   6 +
 arch/arm64/include/asm/daifflags.h            |   4 +-
 arch/arm64/include/asm/io.h                   |   1 +
 arch/arm64/include/asm/irqflags.h             |  19 +-
 arch/arm64/include/asm/sysreg_apple.h         |  69 ++
 arch/arm64/kernel/cpufeature.c                |  14 +
 arch/arm64/kernel/entry.S                     |  27 +-
 drivers/clocksource/arm_arch_timer.c          |  25 +-
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-apple-aic.c               | 647 ++++++++++++++++++
 drivers/of/address.c                          |  72 +-
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/tty/serial/samsung_tty.c              | 499 +++++++++++---
 include/asm-generic/io.h                      |   8 +-
 include/clocksource/arm_arch_timer.h          |   1 +
 .../interrupt-controller/apple-aic.h          |  15 +
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/io.h                            |   2 +
 include/linux/ioport.h                        |   1 +
 include/linux/of_address.h                    |   1 +
 include/linux/serial_s3c.h                    |  16 +
 lib/devres.c                                  |  22 +
 40 files changed, 1685 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 create mode 100644 arch/arm64/boot/dts/apple/Makefile
 create mode 100644 arch/arm64/boot/dts/apple/apple-j274.dts
 create mode 100644 arch/arm64/boot/dts/apple/apple-m1.dtsi
 create mode 100644 arch/arm64/include/asm/sysreg_apple.h
 create mode 100644 drivers/irqchip/irq-apple-aic.c
 create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h

--
2.30.0

