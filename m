Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4336CDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhD0Vuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:50:32 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35814 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhD0Vu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:50:29 -0400
Received: by mail-ot1-f41.google.com with SMTP id 35-20020a9d05260000b029029c82502d7bso25240135otw.2;
        Tue, 27 Apr 2021 14:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FyZLABxiqE9r2Uj3GnTyY1wpC9083+fxxrpzE2s3bXA=;
        b=KcLco9RkqVVGpAXYq205Co60e5LGWaHoIcEoOWSnO9OrYTB8qzdWAYs3sry1e7jMWC
         sOAkwa40j3bLiX0+sNWO9GTYY3WBh4o4QqmyWhKgcz7XfMRkBNKcuZ66ElQctZoPFP4B
         t8pewi6vQh/+GSMJxHsS3d3Ydzm7Z376F4cgVgApp+nbaBLlxjXyMS8BiPZSfqVaFH51
         EUjkyfP3gBO6Q+8XjhSrIiSV3ChtM7xBYLSjDcqTdtMn81fZUcAWiuTwGGyf8DM3k/Rn
         QXCB5qtEenk5i7QsJ8A/jCxI7Yn3l0Nsut2r2bNh0EzhRTBDKb63j5G9Sgp4rC7EAJ51
         GHMQ==
X-Gm-Message-State: AOAM532UwWzrKF+9ARdIB1B/XudPNuqADIb/wkjrYXqty30ozUHNKent
        jHJYf0YAQrYcnTGwYcnp7A==
X-Google-Smtp-Source: ABdhPJxIwFX5Lkc0RuBboq1RthPfRn49HVTbOibI1nxW87+w5dFyVv9XcHPdr983jmuoThIQ0n2RWQ==
X-Received: by 2002:a05:6830:90c:: with SMTP id v12mr21084779ott.179.1619560185563;
        Tue, 27 Apr 2021 14:49:45 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm244346otx.2.2021.04.27.14.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 14:49:45 -0700 (PDT)
Received: (nullmailer pid 2065068 invoked by uid 1000);
        Tue, 27 Apr 2021 21:49:44 -0000
Date:   Tue, 27 Apr 2021 16:49:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.13
Message-ID: <20210427214944.GA2052002@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v5.13. A few arch bits this time due to 
moving some kexec DT related bits out of arm64 and powerpc. A win for 
duplication, but goes against my goal of eliminating drivers/of/. ;)

There's one conflict with your tree in drivers/of/property.c kerneldoc 
comments. Looking at it closer, I think the linux-next resolution is the 
wrong one. Take what's in your tree instead. It makes more sense to 
take the code author's comment than what's part of treewide fixes.

Rob

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.13

for you to fetch changes up to 031cc263c037a95e5d1249cbd3d55b77021f1eb8:

  powerpc: If kexec_build_elf_info() fails return immediately from elf64_load() (2021-04-26 16:28:26 -0500)

----------------------------------------------------------------
Devicetree updates for v5.13:

- Refactoring powerpc and arm64 kexec DT handling to common code. This
  enables IMA on arm64.

- Add kbuild support for applying DT overlays at build time. The first
  user are the DT unittests.

- Fix kerneldoc formatting and W=1 warnings in drivers/of/

- Fix handling 64-bit flag on PCI resources

- Bump dtschema version required to v2021.2.1

- Enable undocumented compatible checks for dtbs_check. This allows
  tracking of missing binding schemas.

- DT docs improvements. Regroup the DT docs and add the example schema
  and DT kernel ABI docs to the doc build.

- Convert Broadcom Bluetooth and video-mux bindings to schema

- Add QCom sm8250 Venus video codec binding schema

- Add vendor prefixes for AESOP, YIC System Co., Ltd, and Siliconfile
  Technologies Inc.

- Cleanup of DT schema type references on common properties and
  standard unit properties

----------------------------------------------------------------
Bhaskar Chowdhury (2):
      dt-bindings: msm: Couple of spelling fixes
      devicetree: bindings: clock: Minor typo fix in the file armada3700-tbg-clock.txt

Bryan O'Donoghue (1):
      dt-bindings: media: venus: Add sm8250 dt schema

Julius Werner (1):
      dt-bindings: ddr: Add optional manufacturer and revision ID to LPDDR3

Krzysztof Kozlowski (3):
      dt-bindings: add vendor prefix for Siliconfile Technologies lnc.
      dt-bindings: add vendor prefix for YIC System Co., Ltd
      dt-bindings: add vendor prefix for AESOP

Lakshmi Ramasubramanian (12):
      kexec: Move ELF fields to struct kimage
      arm64: Use ELF fields defined in 'struct kimage'
      powerpc: Use ELF fields defined in 'struct kimage'
      x86: Use ELF fields defined in 'struct kimage'
      powerpc: Move ima buffer fields to struct kimage
      powerpc: Enable passing IMA log to next kernel on kexec
      powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c
      kexec: Use fdt_appendprop_addrrange() to add ima buffer to FDT
      powerpc: Delete unused function delete_fdt_mem_rsv()
      arm64: Enable passing IMA log to next kernel on kexec
      powerpc: Free fdt on error in elf64_load()
      powerpc: If kexec_build_elf_info() fails return immediately from elf64_load()

Lee Jones (11):
      of: device: Fix function name in header and provide missing descriptions
      of: dynamic: Fix incorrect parameter name and provide missing descriptions
      of: platform: Demote kernel-doc abuse
      of: base: Fix some formatting issues and provide missing descriptions
      of: property: Provide missing member description and remove excess param
      of: address: Provide descriptions for 'of_address_to_resource's params
      of: fdt: Demote kernel-doc abuses and fix function naming
      of: of_net: Provide function name and param description
      of: overlay: Fix function name disparity
      of: of_reserved_mem: Demote kernel-doc abuses
      of: base: Fix spelling issue with function param 'prop'

Leonardo Bras (1):
      of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses

Linus Walleij (1):
      dt-bindings: Convert the BCM4329 bindings to YAML and extend

Mauro Carvalho Chehab (1):
      docs: dt: update writing-schema.rst references

Randy Dunlap (1):
      of: linux/of.h: fix kernel-doc warnings

Rob Herring (22):
      of: Add a common kexec FDT setup function
      arm64: Use common of_kexec_alloc_and_setup_fdt()
      powerpc: Use common of_kexec_alloc_and_setup_fdt()
      dt-bindings: Bump dtschema version required to v2021.2.1
      kbuild: Enable DT undocumented compatible checks
      dt-bindings: media: Convert video-mux to DT schema
      kbuild: Add generic rule to apply fdtoverlay
      dt-bindings: More cleanup of standard unit properties
      dt-bindings: trivial-devices: Allow 'spi-max-frequency' property
      dt-bindings: nvmem: use base meta-schema for consumer schema
      dt-bindings: Clean-up undocumented compatible strings
      dt-bindings: Drop type references on common properties
      dt-bindings: media: video-interfaces: Drop the example
      dt-bindings: Fix reference in submitting-patches.rst to the DT ABI doc
      docs: dt: writing-schema: Remove spurious indentation
      docs: dt: writing-schema: Include the example schema in the doc build
      docs: dt: Make 'Devicetree' wording more consistent
      docs: dt: Group DT docs into relevant sub-sections
      of: Fix kerneldoc output formatting
      of: Add missing 'Return' section in kerneldoc comments
      docs: dt: Add DT API documentation
      of: overlay: Fix kerneldoc warning in of_overlay_remove()

Shawn Guo (1):
      dt-bindings: bcm4329-fmac: add optional brcm,ccode-map

Shubhrajyoti Datta (1):
      dt-bindings: i2c: xiic: Fix a typo

Thiago Jung Bauermann (1):
      powerpc/kexec_file: Restore FDT size estimation for kdump kernel

Viresh Kumar (3):
      kbuild: Simplify builds with CONFIG_OF_ALL_DTBS
      of: unittest: Create overlay_common.dtsi and testcases_common.dtsi
      of: unittest: Statically apply overlays using fdtoverlay

Yang Li (1):
      of: property: Remove unneeded return variable

kernel test robot (1):
      of: overlay: fix for_each_child.cocci warnings

 Documentation/devicetree/bindings/Makefile         |   5 +-
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |   5 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 -
 .../clock/allwinner,sun4i-a10-pll1-clk.yaml        |   2 +-
 .../bindings/clock/armada3700-tbg-clock.txt        |   2 +-
 .../devicetree/bindings/clock/milbeaut-clock.yaml  |  12 +-
 Documentation/devicetree/bindings/ddr/lpddr3.txt   |   5 +
 .../bindings/display/allwinner,sun4i-a10-tcon.yaml |   1 -
 .../bindings/display/brcm,bcm2835-dsi0.yaml        |   6 -
 .../devicetree/bindings/display/msm/dpu.txt        |   4 +-
 .../bindings/display/panel/panel-dpi.yaml          |   2 +-
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   2 +-
 .../bindings/gpio/socionext,uniphier-gpio.yaml     |   3 +-
 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml          |   2 +-
 Documentation/devicetree/bindings/i3c/i3c.yaml     |   7 +-
 .../bindings/iio/adc/brcm,iproc-static-adc.yaml    |   5 -
 .../bindings/iio/gyroscope/nxp,fxas21002c.yaml     |   2 +-
 .../bindings/iio/light/capella,cm3605.yaml         |   1 -
 .../bindings/iio/light/upisemi,us5182.yaml         |   4 +-
 Documentation/devicetree/bindings/index.rst        |   7 +-
 Documentation/devicetree/bindings/input/input.yaml |   1 -
 .../interrupt-controller/loongson,htpic.yaml       |   2 +-
 .../devicetree/bindings/leds/leds-lgm.yaml         |  26 +-
 .../bindings/media/qcom,sm8250-venus.yaml          | 167 ++++++++
 .../bindings/media/video-interfaces.yaml           | 127 ------
 .../devicetree/bindings/media/video-mux.txt        |  60 ---
 .../devicetree/bindings/media/video-mux.yaml       | 106 +++++
 .../memory-controllers/nvidia,tegra210-emc.yaml    |   2 +-
 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |   1 -
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   | 109 +++++
 .../bindings/net/wireless/brcm,bcm43xx-fmac.txt    |  38 --
 .../devicetree/bindings/nvmem/nvmem-consumer.yaml  |   4 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq256xx.yaml  |   1 -
 .../bindings/power/supply/cw2015_battery.yaml      |   2 +-
 .../bindings/power/supply/ltc4162-l.yaml           |   2 -
 .../bindings/power/supply/power-supply.yaml        |  22 -
 .../bindings/regulator/qcom-labibb-regulator.yaml  |   1 -
 .../bindings/remoteproc/ti,omap-remoteproc.yaml    |   2 +-
 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 .../devicetree/bindings/sound/ak4642.yaml          |   2 -
 .../bindings/sound/google,cros-ec-codec.yaml       |   2 +-
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   1 -
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |   4 +-
 .../devicetree/bindings/spi/spi-controller.yaml    |  21 +-
 Documentation/devicetree/bindings/spi/spi-mux.yaml |   8 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |   6 -
 .../devicetree/bindings/submitting-patches.rst     |   6 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |   2 -
 .../devicetree/bindings/trivial-devices.yaml       |   3 +
 Documentation/devicetree/bindings/usb/usb.yaml     |   1 -
 .../devicetree/bindings/vendor-prefixes.yaml       |   6 +
 .../devicetree/{ => bindings}/writing-schema.rst   |  17 +-
 Documentation/devicetree/changesets.rst            |   8 +-
 .../devicetree/dynamic-resolution-notes.rst        |   8 +-
 Documentation/devicetree/index.rst                 |  19 +-
 Documentation/devicetree/kernel-api.rst            |  57 +++
 Documentation/devicetree/of_unittest.rst           |   6 +-
 Documentation/devicetree/overlay-notes.rst         |   8 +-
 Documentation/devicetree/usage-model.rst           |   8 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/kexec.h                     |   4 -
 arch/arm64/kernel/machine_kexec_file.c             | 196 +--------
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/include/asm/ima.h                     |  30 --
 arch/powerpc/include/asm/kexec.h                   |  16 +-
 arch/powerpc/kexec/Makefile                        |   7 -
 arch/powerpc/kexec/elf_64.c                        |  32 +-
 arch/powerpc/kexec/file_load.c                     | 183 +-------
 arch/powerpc/kexec/file_load_64.c                  |  47 +--
 arch/powerpc/kexec/ima.c                           | 219 ----------
 arch/x86/include/asm/kexec.h                       |   5 -
 arch/x86/kernel/crash.c                            |  14 +-
 arch/x86/kernel/kexec-bzimage64.c                  |   2 +-
 arch/x86/kernel/machine_kexec_64.c                 |   4 +-
 drivers/of/Makefile                                |   6 +
 drivers/of/address.c                               |   8 +-
 drivers/of/base.c                                  | 328 ++++++++-------
 drivers/of/device.c                                |   7 +-
 drivers/of/dynamic.c                               |  23 +-
 drivers/of/fdt.c                                   |  40 +-
 drivers/of/irq.c                                   |  14 +-
 drivers/of/kexec.c                                 | 458 +++++++++++++++++++++
 drivers/of/of_net.c                                |   3 +
 drivers/of/of_reserved_mem.c                       |   6 +-
 drivers/of/overlay.c                               |  19 +-
 drivers/of/platform.c                              |  12 +-
 drivers/of/property.c                              |  71 ++--
 drivers/of/unittest-data/Makefile                  |  48 +++
 drivers/of/unittest-data/overlay_base.dts          |  90 +---
 drivers/of/unittest-data/overlay_common.dtsi       |  91 ++++
 drivers/of/unittest-data/static_base_1.dts         |   4 +
 drivers/of/unittest-data/static_base_2.dts         |   4 +
 drivers/of/unittest-data/testcases.dts             |  23 +-
 drivers/of/unittest-data/testcases_common.dtsi     |  19 +
 drivers/of/unittest-data/tests-interrupts.dtsi     |  11 +-
 include/linux/kexec.h                              |   8 +
 include/linux/of.h                                 |  74 ++--
 scripts/Makefile.lib                               |  34 +-
 scripts/checkpatch.pl                              |   2 +-
 security/integrity/ima/ima.h                       |   4 -
 security/integrity/ima/ima_kexec.c                 |   9 +-
 102 files changed, 1671 insertions(+), 1456 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/video-mux.txt
 create mode 100644 Documentation/devicetree/bindings/media/video-mux.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
 rename Documentation/devicetree/{ => bindings}/writing-schema.rst (95%)
 create mode 100644 Documentation/devicetree/kernel-api.rst
 delete mode 100644 arch/powerpc/include/asm/ima.h
 delete mode 100644 arch/powerpc/kexec/ima.c
 create mode 100644 drivers/of/kexec.c
 create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
 create mode 100644 drivers/of/unittest-data/static_base_1.dts
 create mode 100644 drivers/of/unittest-data/static_base_2.dts
 create mode 100644 drivers/of/unittest-data/testcases_common.dtsi
