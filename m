Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65BC44381D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKBV7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:59:38 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44686 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhKBV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:59:37 -0400
Received: by mail-oi1-f177.google.com with SMTP id t38so845234oiw.11;
        Tue, 02 Nov 2021 14:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r9qyPwrxgWq3htJAHMynlZA3DwkE8o0Q2Q1os9eH06s=;
        b=7hTDuVAwEmrZRiUFxcIC9c9GNhHTIn0sTQAieZxUukRpYir7xDbyQfG7Vx5o23hPGh
         HH0halfPNZsqyTjExqsXLuNgsANiqSEz9NZWVzLVfUeRtRa8NSIsOtQNl/XSD5m3wb63
         5ld+8l5hgvL9hXIQhePJ7y907Zb63GNd7b7+2JvOgC+qXzU+/z1roIV1YKBCilNcRLe3
         9vgM1jfMce5/8NnYk0Q2mcRq7CB5BasH8Fzs/HVxcHjYdzRasokv2/3+kgpkTzbQS5wX
         AmPnLR6IvAbiJ6Dzuc0T687L+VoPRl7cnux+ei6xc3h7Xhhh2KCAWGjv84WYCc1R7a3a
         oGpQ==
X-Gm-Message-State: AOAM533bLzcNomo3Nq8Dqe0TQm6TxKNCfA9OJ5Y8b2CnobPDH505+oG7
        IArgRXxRUXv00lcxeE9e2w==
X-Google-Smtp-Source: ABdhPJzvtBkci7Lth9pGn+n2Hse77MtvmSunyehoYYTGBgr2ToP/oPL/xSB02gcTxMMoSF2b/4Z8dQ==
X-Received: by 2002:a05:6808:348:: with SMTP id j8mr7281204oie.45.1635890221364;
        Tue, 02 Nov 2021 14:57:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e28sm66822oiy.10.2021.11.02.14.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 14:57:00 -0700 (PDT)
Received: (nullmailer pid 3584008 invoked by uid 1000);
        Tue, 02 Nov 2021 21:56:59 -0000
Date:   Tue, 2 Nov 2021 16:56:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.16
Message-ID: <YYG0KwuwSyH2uSqz@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DeviceTree updates for 5.16. Note there's a trivial conflict 
amongst several trees in MAINTAINERS for the Apple M1 stuff as there's 
lots of Apple bits (or bites?) landing this cycle.

Rob


The following changes since commit b2d70c0dbf2731a37d1c7bcc86ab2387954d5f56:

  dt-bindings: drm/bridge: ti-sn65dsi86: Fix reg value (2021-10-04 12:01:59 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.16

for you to fetch changes up to 4c7a7d5086cd0f9ce22bb3df86604576d0604db5:

  dt-bindings: net: ti,bluetooth: Document default max-speed (2021-11-01 20:33:57 -0500)

----------------------------------------------------------------
Devicetree updates for v5.16:

- Convert /reserved-memory bindings to schemas

- Convert a bunch of NFC bindings to schemas

- Convert bindings to schema: Xilinx USB, Freescale DDR controller, Arm
  CCI-400, UBlox Neo-6M, 1-Wire GPIO, MSI controller, ASpeed LPC, OMAP
  and Inside-Secure HWRNG, register-bit-led, OV5640, Silead GSL1680,
  Elan ekth3000, Marvell bluetooth, TI wlcore, TI bluetooth, ESP ESP8089,
  tlm,trusted-foundations, Microchip cap11xx, Ralink SoCs and boards,
  and TI sysc

- New binding schemas for: msi-ranges, Aspeed UART routing controller,
  palmbus, Xylon LogiCVC display controller, Mediatek's MT7621 SDRAM
  memory controller, and Apple M1 PCIe host

- Run schema checks for %.dtb targets

- Improve build time when using DT_SCHEMA_FILES

- Improve error message when dtschema is not found

- Various doc reference fixes in MAINTAINERS

- Convert architectures to common CPU h/w ID parsing function
  of_get_cpu_hwid().

- Allow for empty NUMA node IDs which may be hotplugged

- Cleanup of __fdt_scan_reserved_mem()

- Constify device_node parameters

- Update dtc to upstream v1.6.1-19-g0a3a9d3449c8. Adds new checks
  'node_name_vs_property_name' and 'interrupt_map'.

- Enable dtc 'unit_address_format' warning by default

- Fix unittest EXPECT text for gpio hog errors

----------------------------------------------------------------
Chanho Park (2):
      dt-bindings: ufs: exynos-ufs: add io-coherency property
      dt-bindings: ufs: exynos-ufs: add exynosautov9 compatible

Chia-Wei Wang (2):
      dt-bindings: mfd: aspeed-lpc: Convert to YAML schema
      dt-bindings: aspeed: Add UART routing controller

Chukun Pan (1):
      dt-bindings: devfreq: rk3399_dmc: fix clocks in example

David Heidelberg (7):
      dt-bindings: reserved-memory: ramoops: Convert txt bindings to yaml
      dt-bindings: input: elan,ekth3000: Convert txt bindings to yaml
      dt-bindings: net: marvell-bluetooth: Convert txt bindings to yaml
      dt-bindings: net: nfc: nxp,pn544: Convert txt bindings to yaml
      dt-bindings: input: microchip,cap11xx: Convert txt bindings to yaml
      dt-bindings: arm: firmware: tlm,trusted-foundations: Convert txt bindings to yaml
      dt-bindings: net: qcom,ipa: IPA does support up to two iommus

Frank Rowand (2):
      of: unittest: fix EXPECT text for gpio hog errors
      of: unittest: document intentional interrupt-map provider build warning

Gavin Shan (2):
      Documentation, dt, numa: Add note to empty NUMA node
      of, numa: Fetch empty NUMA node ID from distance map

Geert Uytterhoeven (6):
      dt-bindings: net: wireless: ti,wlcore: Convert to json-schema
      dt-bindings: net: ti,bluetooth: Convert to json-schema
      dt-bindings: Parallelize yamllint
      dt-bindings: Consider DT_SCHEMA_FILES when finding all json-schema
      dt-bindings: display: tilcd: Fix endpoint addressing in example
      dt-bindings: net: ti,bluetooth: Document default max-speed

Jayesh Choudhary (1):
      dt-bindings: rng: convert OMAP and Inside-Secure HWRNG to yaml schema

Krzysztof Kozlowski (10):
      dt-bindings: memory: fsl: convert DDR controller to dtschema
      dt-bindings: riscv: correct e51 and u54-mc CPU bindings
      dt-bindings: nfc: nxp,nci: convert to dtschema
      dt-bindings: nfc: nxp,nci: document NXP PN547 binding
      dt-bindings: nfc: nxp,pn532: convert to dtschema
      dt-bindings: nfc: st,st21nfca: convert to dtschema
      dt-bindings: nfc: st,st95hf: convert to dtschema
      dt-bindings: nfc: st,nci: convert to dtschema
      dt-bindings: nfc: ti,trf7970a: convert to dtschema
      dt-bindings: nfc: marvell,nci: convert to dtschema

Mark Kettenis (3):
      dt-bindings: interrupt-controller: Convert MSI controller to json-schema
      dt-bindings: interrupt-controller: msi: Add msi-ranges property
      dt-bindings: pci: Add DT bindings for apple,pcie

Mauro Carvalho Chehab (11):
      dt-bindings: w1: update w1-gpio.yaml reference
      dt-bindings: reserved-memory: ramoops: update ramoops.yaml references
      MAINTAINERS: update arm,vic.yaml reference
      MAINTAINERS: update aspeed,i2c.yaml reference
      MAINTAINERS: update faraday,ftrtc010.yaml reference
      MAINTAINERS: update ti,sci.yaml reference
      MAINTAINERS: update intel,ixp46x-rng.yaml reference
      MAINTAINERS: update nxp,imx8-jpeg.yaml reference
      MAINTAINERS: update gemini.yaml reference
      MAINTAINERS: update brcm,unimac-mdio.yaml reference
      MAINTAINERS: update mtd-physmap.yaml reference

Maxime Ripard (11):
      dt-bindings: Convert Reserved Memory binding to a schema
      dt-bindings: arm: Convert ARM CCI-400 binding to a schema
      dt-bindings: gnss: Convert UBlox Neo-6M binding to a schema
      dt-bindings: media: ti,cal: Fix example
      dt-bindings: w1: Convert 1-Wire GPIO binding to a schema
      dt-bindings: bluetooth: broadcom: Fix clocks check
      dt-bindings: bluetooth: realtek: Add missing max-speed
      dt-bindings: net: dwmac: Fix typo in the R40 compatible
      dt-bindings: net: wireless: Convert ESP ESP8089 binding to a schema
      dt-bindings: media: Convert OV5640 binding to a schema
      dt-bindings: input: Convert Silead GSL1680 binding to a schema

Michal Simek (1):
      dt-bindings: display: xilinx: Fix example with psgtr

Miles Chen (1):
      dt-bindings: mailbox: fix incorrect gce.h file paths

Nathan Lynch (2):
      of: kobj: make of_node_is_(initialized|attached) parameters const
      of: make of_node_check_flag() device_node parameter const

Nishanth Menon (1):
      dt-bindings: sram: Allow numbers in sram region node name

Paul Kocialkowski (1):
      dt-bindings: display: Document the Xylon LogiCVC display controller

Rob Herring (22):
      kbuild: Enable DT schema checks for %.dtb targets
      dt-bindings: arm,vexpress-juno: Fix 'motherboard' node name
      dt-bindings: arm,vexpress-juno: Add missing motherboard properties
      kbuild: Enable dtc 'unit_address_format' warning by default
      dt-bindings: w1-gpio: Drop redundant 'maxItems'
      Merge branch 'dt/linus' into dt/next
      dt-bindings: leds: Convert register-bit-led binding to DT schema
      dt-bindings: leds: register-bit-led: Use 'reg' instead of 'offset'
      of: Add of_get_cpu_hwid() to read hardware ID from CPU nodes
      ARM: Use of_get_cpu_hwid()
      ARM: broadcom: Use of_get_cpu_hwid()
      arm64: Use of_get_cpu_hwid()
      csky: Use of_get_cpu_hwid()
      openrisc: Use of_get_cpu_hwid()
      powerpc: Use of_get_cpu_hwid()
      riscv: Use of_get_cpu_hwid()
      sh: Use of_get_cpu_hwid()
      x86: dt: Use of_get_cpu_hwid()
      dt-bindings: Add a help message when dtschema tools are missing
      scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8
      of/unittest: Disable new dtc node_name_vs_property_name and interrupt_map warnings
      of/fdt: Remove of_scan_flat_dt() usage for __fdt_scan_reserved_mem()

Sebastien Van Cauwenberghe (1):
      dt-bindings: Add SpinalHDL vendor

Sergio Paracuellos (3):
      dt-bindings: memory: add binding for Mediatek's MT7621 SDRAM memory controller
      dt-bindings: bus: add palmbus device tree bindings
      dt-bindings: mips: convert Ralink SoCs and boards to schema

Shubhrajyoti Datta (2):
      dt-binding: usb: xilinx: Convert binding to YAML
      dt-binding: usb: xilinx: Add clocking node

Simon Glass (1):
      docs: dt: Fix a few grammar nits in the binding/schema docs

Tom Rini (1):
      docs: dt: submitting-patches: Add note about other project usage

Tony Lindgren (1):
      dt-bindings: bus: ti-sysc: Update to use yaml binding

Wan Jiabing (1):
      of/unittest: Add of_node_put() before return

Yuya Hamamachi (1):
      dt-bindings: pci: rcar-pci-ep: Document r8a7795

Zev Weiss (1):
      of: remove duplicate declarations of __of_*_sysfs() functions

 Documentation/admin-guide/ramoops.rst              |   2 +-
 Documentation/devicetree/bindings/Makefile         |  20 +-
 .../devicetree/bindings/arm/arm,cci-400.yaml       | 216 +++++++++++++++
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |  46 ++--
 .../devicetree/bindings/arm/cci-control-port.yaml  |  38 +++
 Documentation/devicetree/bindings/arm/cci.txt      | 224 ---------------
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
 .../arm/firmware/tlm,trusted-foundations.txt       |  20 --
 .../arm/firmware/tlm,trusted-foundations.yaml      |  46 ++++
 Documentation/devicetree/bindings/bus/palmbus.yaml |  79 ++++++
 Documentation/devicetree/bindings/bus/ti-sysc.txt  | 139 ----------
 Documentation/devicetree/bindings/bus/ti-sysc.yaml | 216 +++++++++++++++
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |   2 +-
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |   4 +-
 .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   |   4 +-
 .../bindings/display/xylon,logicvc-display.yaml    | 301 +++++++++++++++++++++
 .../devicetree/bindings/example-schema.yaml        |  14 +-
 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    |  62 +++++
 Documentation/devicetree/bindings/gnss/u-blox.txt  |  45 ---
 .../devicetree/bindings/input/cap11xx.txt          |  78 ------
 .../devicetree/bindings/input/elan,ekth3000.yaml   |  81 ++++++
 .../devicetree/bindings/input/elan_i2c.txt         |  44 ---
 .../bindings/input/microchip,cap11xx.yaml          | 148 ++++++++++
 .../bindings/input/touchscreen/silead,gsl1680.yaml |  91 +++++++
 .../bindings/input/touchscreen/silead_gsl1680.txt  |  44 ---
 .../interrupt-controller/msi-controller.yaml       |  46 ++++
 .../devicetree/bindings/leds/register-bit-led.txt  |  94 -------
 .../devicetree/bindings/leds/register-bit-led.yaml |  95 +++++++
 .../devicetree/bindings/mailbox/mtk-gce.txt        |   4 +-
 .../devicetree/bindings/media/i2c/ov5640.txt       |  92 -------
 .../devicetree/bindings/media/i2c/ovti,ov5640.yaml | 154 +++++++++++
 .../devicetree/bindings/media/ti,cal.yaml          |   4 +-
 .../bindings/memory-controllers/fsl/ddr.txt        |  29 --
 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  83 ++++++
 .../memory-controllers/mediatek,mt7621-memc.yaml   |  30 ++
 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 157 -----------
 .../devicetree/bindings/mfd/aspeed-lpc.yaml        | 199 ++++++++++++++
 Documentation/devicetree/bindings/mips/ralink.txt  |  32 ---
 Documentation/devicetree/bindings/mips/ralink.yaml |  87 ++++++
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |   4 +-
 .../bindings/net/broadcom-bluetooth.yaml           |  17 +-
 .../devicetree/bindings/net/marvell-bluetooth.txt  |  25 --
 .../devicetree/bindings/net/marvell-bluetooth.yaml |  31 +++
 .../devicetree/bindings/net/nfc/marvell,nci.yaml   | 170 ++++++++++++
 .../devicetree/bindings/net/nfc/nfcmrvl.txt        |  84 ------
 .../devicetree/bindings/net/nfc/nxp,nci.yaml       |  61 +++++
 .../devicetree/bindings/net/nfc/nxp,pn532.yaml     |  65 +++++
 .../devicetree/bindings/net/nfc/nxp,pn544.yaml     |  58 ++++
 .../devicetree/bindings/net/nfc/nxp-nci.txt        |  33 ---
 .../devicetree/bindings/net/nfc/pn532.txt          |  46 ----
 .../devicetree/bindings/net/nfc/pn544.txt          |  33 ---
 .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 106 ++++++++
 .../devicetree/bindings/net/nfc/st,st21nfca.yaml   |  64 +++++
 .../devicetree/bindings/net/nfc/st,st95hf.yaml     |  57 ++++
 .../devicetree/bindings/net/nfc/st-nci-i2c.txt     |  38 ---
 .../devicetree/bindings/net/nfc/st-nci-spi.txt     |  36 ---
 .../devicetree/bindings/net/nfc/st21nfca.txt       |  37 ---
 .../devicetree/bindings/net/nfc/st95hf.txt         |  45 ---
 .../devicetree/bindings/net/nfc/ti,trf7970a.yaml   |  98 +++++++
 .../devicetree/bindings/net/nfc/trf7970a.txt       |  43 ---
 .../devicetree/bindings/net/qcom,ipa.yaml          |   3 +-
 .../devicetree/bindings/net/realtek-bluetooth.yaml |   2 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |   6 +-
 .../devicetree/bindings/net/ti,bluetooth.yaml      |  92 +++++++
 .../devicetree/bindings/net/ti-bluetooth.txt       |  60 ----
 .../bindings/net/wireless/esp,esp8089.txt          |  30 --
 .../bindings/net/wireless/esp,esp8089.yaml         |  43 +++
 .../bindings/net/wireless/ti,wlcore,spi.txt        |  57 ----
 .../devicetree/bindings/net/wireless/ti,wlcore.txt |  45 ---
 .../bindings/net/wireless/ti,wlcore.yaml           | 134 +++++++++
 Documentation/devicetree/bindings/numa.txt         |  46 +++-
 .../devicetree/bindings/pci/apple,pcie.yaml        | 160 +++++++++++
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   1 +
 .../bindings/pci/microchip,pcie-host.yaml          |   1 +
 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |   1 +
 .../bindings/reserved-memory/memory-region.yaml    |  40 +++
 .../bindings/reserved-memory/ramoops.txt           |  66 -----
 .../bindings/reserved-memory/ramoops.yaml          | 145 ++++++++++
 .../bindings/reserved-memory/reserved-memory.txt   | 172 +-----------
 .../bindings/reserved-memory/reserved-memory.yaml  | 100 +++++++
 .../bindings/reserved-memory/shared-dma-pool.yaml  |  87 ++++++
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   8 +-
 Documentation/devicetree/bindings/rng/omap_rng.txt |  38 ---
 .../devicetree/bindings/rng/omap_rng.yaml          |  92 +++++++
 .../bindings/soc/aspeed/uart-routing.yaml          |  56 ++++
 Documentation/devicetree/bindings/sram/sram.yaml   |   2 +-
 .../devicetree/bindings/submitting-patches.rst     |   3 +
 .../bindings/ufs/samsung,exynos-ufs.yaml           |  10 +
 .../devicetree/bindings/usb/udc-xilinx.txt         |  18 --
 .../devicetree/bindings/usb/xlnx,usb2.yaml         |  47 ++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/devicetree/bindings/w1/w1-gpio.txt   |  27 --
 Documentation/devicetree/bindings/w1/w1-gpio.yaml  |  43 +++
 .../devicetree/bindings/writing-bindings.rst       |   2 +-
 .../devicetree/bindings/writing-schema.rst         |  29 +-
 Documentation/w1/masters/w1-gpio.rst               |   2 +-
 MAINTAINERS                                        |  24 +-
 Makefile                                           |  10 +-
 arch/arm/boot/dts/omap3-gta04a5.dts                |   2 +-
 arch/arm/kernel/devtree.c                          |  22 +-
 arch/arm/mach-bcm/bcm63xx_pmb.c                    |   6 +-
 arch/arm64/kernel/smp.c                            |  31 +--
 arch/csky/kernel/smp.c                             |   6 +-
 arch/openrisc/kernel/smp.c                         |   6 +-
 arch/powerpc/kernel/smp.c                          |   7 +-
 arch/riscv/kernel/cpu.c                            |   3 +-
 arch/sh/boards/of-generic.c                        |   5 +-
 arch/x86/kernel/devicetree.c                       |   5 +-
 drivers/of/base.c                                  |  22 ++
 drivers/of/fdt.c                                   |  52 ++--
 drivers/of/kobj.c                                  |   4 +-
 drivers/of/of_numa.c                               |   2 +
 drivers/of/of_private.h                            |  10 +-
 drivers/of/unittest-data/Makefile                  |   8 +-
 drivers/of/unittest-data/tests-interrupts.dtsi     |  19 ++
 drivers/of/unittest.c                              |  24 +-
 include/linux/of.h                                 |   3 +-
 scripts/Makefile.lib                               |   1 -
 scripts/dtc/checks.c                               | 222 +++++++++++----
 scripts/dtc/dtc-lexer.l                            |   2 +-
 scripts/dtc/dtc.c                                  |   6 +-
 scripts/dtc/dtc.h                                  |  40 ++-
 scripts/dtc/flattree.c                             |  11 +-
 scripts/dtc/libfdt/fdt.c                           |   4 +
 scripts/dtc/libfdt/fdt_rw.c                        |  18 +-
 scripts/dtc/libfdt/fdt_strerror.c                  |   1 +
 scripts/dtc/libfdt/libfdt.h                        |   7 +
 scripts/dtc/livetree.c                             |   6 +-
 scripts/dtc/treesource.c                           |  48 ++--
 scripts/dtc/util.h                                 |   6 +-
 scripts/dtc/version_gen.h                          |   2 +-
 scripts/dtc/yamltree.c                             |  16 +-
 132 files changed, 4302 insertions(+), 2252 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,cci-400.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/cci-control-port.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/cci.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
 create mode 100644 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
 delete mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
 delete mode 100644 Documentation/devicetree/bindings/input/cap11xx.txt
 create mode 100644 Documentation/devicetree/bindings/input/elan,ekth3000.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/elan_i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/silead,gsl1680.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/register-bit-led.txt
 create mode 100644 Documentation/devicetree/bindings/leds/register-bit-led.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5640.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ddr.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,mt7621-memc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mips/ralink.txt
 create mode 100644 Documentation/devicetree/bindings/mips/ralink.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-bluetooth.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell-bluetooth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nfcmrvl.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn532.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn544.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn532.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn544.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st21nfca.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st21nfca.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st95hf.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/trf7970a.txt
 create mode 100644 Documentation/devicetree/bindings/net/ti,bluetooth.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/ti-bluetooth.txt
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/esp,esp8089.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/esp,esp8089.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/memory-region.yaml
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/omap_rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/omap_rng.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/udc-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
 delete mode 100644 Documentation/devicetree/bindings/w1/w1-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1-gpio.yaml
