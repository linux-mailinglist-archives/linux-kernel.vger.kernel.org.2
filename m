Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16343FCD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbhHaSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:46:10 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36486 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHaSqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:46:09 -0400
Received: by mail-ot1-f48.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso350208otv.3;
        Tue, 31 Aug 2021 11:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=k+2KiccdkoVjcxLydJ6E+iIcM/RpsTpPl9Y9OWnKnbw=;
        b=JdYGtYolN6047Qt95ty2JuTffFmHtyv4yPkmX6OIPHKCA+h7xkGJOjHZfq06fUaCB7
         a7PtynsvzhGDxO33KX0udu43rIUj4HcpPIqibGsYLCa6MDhKzPuuLD4OA4AJ7ewibNQZ
         AdZX9WR2o/9lsYM0PvqJ8nnaVZ38ivyqtDcLNlFXQiwfN4z/k+K0BPIN9Og2bl434ZMO
         tLv9YwH9Z+WrT6BvWq0xPp43ie+jQiBcEzVnEiS55j95LRXvpozYxB1u+ut+V4NHnL58
         MCn27i1OXlTC7efdKcr4JiYG4VrUByCY5nENPgDgI1b4ppC8wk38NmXzB91yuTdHGxsI
         lcOg==
X-Gm-Message-State: AOAM531f4jv46OflXqVxXifJm8k/r/QdJ9yG4lSQJl0ygeK0GzL/bmNI
        mbqlgGDAYFqKUkKujwCVxvgkT7KA2g==
X-Google-Smtp-Source: ABdhPJykA3+rWHa+gznCjTPXMI7xXyiRxXn+VjRrA1OTNWBrJtV0DykpY09nFaTKHtEtClhyzS9ndQ==
X-Received: by 2002:a9d:6f94:: with SMTP id h20mr25654548otq.168.1630435513163;
        Tue, 31 Aug 2021 11:45:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s22sm3696709ooh.27.2021.08.31.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:45:12 -0700 (PDT)
Received: (nullmailer pid 455799 invoked by uid 1000);
        Tue, 31 Aug 2021 18:45:11 -0000
Date:   Tue, 31 Aug 2021 13:45:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [GIT PULL] Devicetree updates for v5.15
Message-ID: <YS54t3gfZYdE3WPj@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v5.15.

There's one conflict with the clock tree in 
Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt which 
got converted to schema. The correct fix is in linux-next (add 
'mediatek,mt8192-mmsys' to the list of compatible strings).

Rob


The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.15

for you to fetch changes up to b1e202503508d5b66bf1532bea36b5776b00d869:

  dt-bindings: display: remove zte,vou.txt binding doc (2021-08-31 10:21:36 -0500)

----------------------------------------------------------------
Devicetree updates for v5.15:

- Refactor arch kdump DT related code to a common implementation

- Add fw_devlink tracking for 'phy-handle', 'leds', 'backlight',
  'resets', and 'pwm' properties

- Various clean-ups to DT FDT code

- Fix a runtime error for !CONFIG_SYSFS

- Convert Synopsys DW PCI and derivative binding docs to schemas. Add
  Toshiba Visconti PCIe binding.

- Convert a bunch of memory controller bindings to schemas

- Covert eeprom-93xx46, Samsung Exynos TRNG, Samsung Exynos IRQ
  combiner, arm-charlcd, img-ascii-lcd, UniPhier eFuse, Xilinx Zynq
  MPSoC FPGA, Xilinx Zynq MPSoC reset, Mediatek mmsys, Gemini boards,
  brcm,iproc-i2c, faraday,ftpci100, and ks8851 net to DT schema.

- Extend nvmem bindings to handle bit offsets in unit-addresses

- Add DT schemas for HiKey 970 PCIe PHY

- Remove unused ZTE, energymicro,efm32-timer, and Exynos SATA bindings

- Enable dtc pci_device_reg warning by default

- Fixes for handling 'unevaluatedProperties' in preparation to enable
  pending support in the tooling for jsonschema 2020-12 draft

----------------------------------------------------------------
Aswath Govindraju (1):
      dt-bindings: eeprom-93xx46: Convert to json schema

Baisheng Gao (1):
      Documentation: fix incorrect macro referencing in mscc-phy-vsc8531.txt

Biju Das (2):
      dt-bindings: net: renesas,etheravb: Document Gigabit Ethernet IP
      dt-bindings: net: renesas,etheravb: Drop "int_" prefix and "_n" suffix from interrupt names

Corentin Labbe (1):
      dt-bindings: PCI: ftpci100: convert faraday,ftpci100 to YAML

Ezequiel Garcia (1):
      dt-bindings: gpu: mali-bifrost: Add RK3568 compatible

Fabien Parent (2):
      dt-bindings: arm: mediatek: mmsys: convert to YAML format
      dt-bindings: arm: mediatek: mmsys: add MT8365 SoC binding

Geert Uytterhoeven (14):
      of: kexec: Remove FDT_PROP_* definitions
      dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements
      dt-bindings: auxdisplay: img-ascii-lcd: Convert to json-schema
      dt-bindings: auxdisplay: arm-charlcd: Convert to json-schema
      of: fdt: Remove early_init_dt_reserve_memory_arch() override capability
      of: fdt: Remove weak early_init_dt_mark_hotplug_memory_arch()
      crash_dump: Make elfcorehdr address/size symbols always visible
      of: fdt: Add generic support for handling elf core headers property
      of: fdt: Add generic support for handling usable memory range property
      of: fdt: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD) instead of #ifdef
      riscv: Remove non-standard linux,elfcorehdr handling
      arm64: kdump: Remove custom linux,elfcorehdr handling
      arm64: kdump: Remove custom linux,usable-memory-range handling
      of: fdt: Rename reserve_elfcorehdr() to fdt_reserve_elfcorehdr()

Krzysztof Kozlowski (14):
      dt-bindings: ata: drop unused Exynos SATA bindings
      dt-bindings: irqchip: convert Samsung Exynos IRQ combiner to dtschema
      dt-bindings: rng: convert Samsung Exynos TRNG to dtschema
      dt-bindings: memory: convert Qualcomm Atheros DDR to dtschema
      dt-bindings: memory: convert Broadcom DPFE to dtschema
      dt-bindings: memory: convert Marvell MVEBU SDRAM controller to dtschema
      MAINTAINERS: EDAC/armada_xp: include dt-bindings
      dt-bindings: memory: convert Synopsys IntelliDDR memory controller to dtschema
      dt-bindings: memory: convert TI a8xx DDR2/mDDR memory controller to dtschema
      dt-bindings: memory: convert H8/300 bus controller to dtschema
      dt-bindings: devfreq: event: convert Samsung Exynos NoCP to dtschema
      dt-bindings: devfreq: event: convert Samsung Exynos PPMU to dtschema
      dt-bindings: memory: convert Samsung Exynos DMC to dtschema
      dt-bindings: hwmon: merge max1619 into trivial devices

Kunihiko Hayashi (2):
      dt-bindings: nvmem: Extend patternProperties to optionally indicate bit position
      dt-bindings: nvmem: Convert UniPhier eFuse bindings to json-schema

Linus Walleij (1):
      dt-bindings: arm: Convert Gemini boards to YAML

Marc Zyngier (1):
      of: Don't allow __of_attached_node_sysfs() without CONFIG_SYSFS

Marek Vasut (2):
      dt-bindings: net: ks8851: Convert to YAML schema
      dt-bindings: mxsfb: Add compatible for i.MX8MN

Mauro Carvalho Chehab (9):
      dt-bindings: PCI: add snps,dw-pcie.yaml
      dt-bindings: PCI: add snps,dw-pcie-ep.yaml
      dt-bindings: PCI: update references to Designware schema
      dt-bindings: PCI: remove designware-pcie.txt
      dt-bindings: mtd: update mtd-physmap.yaml reference
      dt-bindings: PCI: kirin: Fix compatible string
      dt-bindings: PCI: kirin: Convert kirin-pcie.txt to yaml
      dt-bindings: PCI: kirin: Add support for Kirin970
      dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY

Michal Simek (2):
      dt-bindings: timer: Remove binding for energymicro,efm32-timer.txt
      dt-bindings: Add vendor prefix for Topic Embedded Systems

Nobuhiro Iwamatsu (3):
      dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
      dt-bindings: power: reset: convert Xilinx Zynq MPSoC bindings to YAML
      dt-bindings: fpga: convert Xilinx Zynq MPSoC bindings to YAML

Ohhoon Kwon (1):
      of: fdt: do not update local variable after use

Rafał Miłecki (1):
      dt-bindings: i2c: brcm,iproc-i2c: convert to the json-schema

Richard Zhu (1):
      dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema

Rob Herring (9):
      dt-bindings: PCI: intel,lgm-pcie: Add reference to common schemas
      dt-bindings: media: Fix graph 'unevaluatedProperties' related warnings
      dt-bindings: display: Fix graph 'unevaluatedProperties' related warnings
      dt-bindings: Remove "status" from schema examples
      dt-bindings: PCI: faraday,ftpci100: Fix 'contains' schema usage
      dt-bindings: Output yamllint warnings to stderr
      kbuild: Enable dtc 'pci_device_reg' warning by default
      dt-bindings: Use 'enum' instead of 'oneOf' plus 'const' entries
      dt-bindings: mtd-physmap: Add 'arm,vexpress-flash' compatible

Sam Shih (1):
      dt-bindings: rng: mediatek: add mt7986 to mtk rng binding

Saravana Kannan (3):
      of: property: fw_devlink: Add support for "resets" and "pwms"
      of: property: fw_devlink: Add support for "leds" and "backlight"
      of: property: fw_devlink: Add support for "phy-handle" property

Suman Anna (1):
      dt-bindings: irqchip: Update pruss-intc binding for K3 AM64x SoCs

Zenghui Yu (3):
      dt-bindings: clock: remove obsolete zte zx header
      dt-bindings: soc: remove obsolete zte zx header
      dt-bindings: display: remove zte,vou.txt binding doc

권오훈 (2):
      of: base: remove unnecessary for loop
      of: fdt: remove unnecessary codes

 Documentation/devicetree/bindings/Makefile         |   2 +-
 Documentation/devicetree/bindings/arm/gemini.txt   | 108 -----------
 Documentation/devicetree/bindings/arm/gemini.yaml  |  95 ++++++++++
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  31 ----
 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |  58 ++++++
 .../devicetree/bindings/ata/exynos-sata.txt        |  30 ---
 .../bindings/auxdisplay/arm,versatile-lcd.yaml     |  44 +++++
 .../devicetree/bindings/auxdisplay/arm-charlcd.txt |  18 --
 .../bindings/auxdisplay/img,ascii-lcd.yaml         |  55 ++++++
 .../bindings/auxdisplay/img-ascii-lcd.txt          |  17 --
 Documentation/devicetree/bindings/chosen.txt       |  12 +-
 .../bindings/devfreq/event/exynos-nocp.txt         |  26 ---
 .../bindings/devfreq/event/exynos-ppmu.txt         | 169 -----------------
 .../devfreq/event/samsung,exynos-nocp.yaml         |  48 +++++
 .../devfreq/event/samsung,exynos-ppmu.yaml         | 169 +++++++++++++++++
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml      |   2 -
 .../bindings/display/bridge/ti,sn65dsi83.yaml      |   6 +-
 .../devicetree/bindings/display/fsl,lcdif.yaml     |   1 +
 .../bindings/display/msm/dsi-controller-main.yaml  |   6 +-
 .../bindings/display/msm/dsi-phy-10nm.yaml         |   6 +-
 .../bindings/display/msm/dsi-phy-14nm.yaml         |   6 +-
 .../bindings/display/msm/dsi-phy-20nm.yaml         |   3 +-
 .../bindings/display/msm/dsi-phy-28nm.yaml         |   8 +-
 .../bindings/display/panel/boe,tv101wum-nl6.yaml   |   1 -
 .../devicetree/bindings/display/zte,vou.txt        | 120 ------------
 .../bindings/dma/allwinner,sun6i-a31-dma.yaml      |  12 +-
 .../devicetree/bindings/firmware/arm,scpi.yaml     |   6 +-
 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt        |  25 ---
 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml       |  36 ++++
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   1 +
 .../devicetree/bindings/hwmon/max1619.txt          |  12 --
 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  46 -----
 .../devicetree/bindings/i2c/brcm,iproc-i2c.yaml    |  71 ++++++++
 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml      |  10 +-
 .../interrupt-controller/loongson,liointc.yaml     |   8 +-
 .../samsung,exynos4210-combiner.txt                |  50 -----
 .../samsung,exynos4210-combiner.yaml               |  96 ++++++++++
 .../interrupt-controller/ti,pruss-intc.yaml        |   4 +-
 .../devicetree/bindings/media/atmel,isc.yaml       |   3 +-
 .../devicetree/bindings/media/i2c/mipi-ccs.yaml    |   8 +-
 .../devicetree/bindings/media/microchip,xisc.yaml  |   2 +-
 .../bindings/media/nxp,imx7-mipi-csi2.yaml         |   2 -
 .../devicetree/bindings/media/renesas,drif.yaml    |   3 +-
 .../memory-controllers/ath79-ddr-controller.txt    |  35 ----
 .../bindings/memory-controllers/brcm,dpfe-cpu.txt  |  27 ---
 .../bindings/memory-controllers/brcm,dpfe-cpu.yaml |  48 +++++
 .../bindings/memory-controllers/exynos5422-dmc.txt |  84 ---------
 .../marvell,mvebu-sdram-controller.yaml            |  31 ++++
 .../memory-controllers/mvebu-sdram-controller.txt  |  21 ---
 .../qca,ath79-ddr-controller.yaml                  |  61 +++++++
 .../memory-controllers/renesas,h8300-bsc.txt       |  12 --
 .../memory-controllers/renesas,h8300-bsc.yaml      |  35 ++++
 .../memory-controllers/renesas,rpc-if.yaml         |  17 +-
 .../memory-controllers/samsung,exynos5422-dmc.yaml | 137 ++++++++++++++
 .../memory-controllers/synopsys,ddrc-ecc.yaml      |  73 ++++++++
 .../bindings/memory-controllers/synopsys.txt       |  32 ----
 .../memory-controllers/ti,da8xx-ddrctl.yaml        |  35 ++++
 .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 --
 .../devicetree/bindings/mfd/ti,lp87565-q1.yaml     |   6 +-
 .../devicetree/bindings/misc/eeprom-93xx46.txt     |  29 ---
 .../devicetree/bindings/misc/eeprom-93xx46.yaml    |  70 +++++++
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt |   4 +-
 .../devicetree/bindings/mtd/mtd-physmap.yaml       |   1 +
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |   1 -
 .../bindings/net/intel,ixp4xx-ethernet.yaml        |   2 -
 .../devicetree/bindings/net/micrel,ks8851.yaml     |  96 ++++++++++
 .../devicetree/bindings/net/micrel-ks8851.txt      |  18 --
 .../devicetree/bindings/net/mscc-phy-vsc8531.txt   |   4 +-
 .../bindings/net/nfc/samsung,s3fwrn5.yaml          |   3 -
 .../devicetree/bindings/net/qca,ar71xx.yaml        |  25 +--
 .../devicetree/bindings/net/realtek-bluetooth.yaml |   8 +-
 .../devicetree/bindings/net/renesas,etheravb.yaml  |  57 ++++--
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   8 +-
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |   6 +-
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |   2 +-
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   |  95 ++++++++++
 .../devicetree/bindings/nvmem/uniphier-efuse.txt   |  49 -----
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |   4 +-
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   2 +-
 .../devicetree/bindings/pci/designware-pcie.txt    |  77 --------
 .../devicetree/bindings/pci/faraday,ftpci100.txt   | 135 --------------
 .../devicetree/bindings/pci/faraday,ftpci100.yaml  | 174 ++++++++++++++++++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 100 ----------
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    | 202 +++++++++++++++++++++
 .../bindings/pci/hisilicon,kirin-pcie.yaml         | 167 +++++++++++++++++
 .../bindings/pci/hisilicon-histb-pcie.txt          |   2 +-
 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |  36 +---
 .../devicetree/bindings/pci/kirin-pcie.txt         |  50 -----
 .../devicetree/bindings/pci/layerscape-pci.txt     |   2 +-
 .../devicetree/bindings/pci/loongson.yaml          |   8 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt          |   5 +-
 .../devicetree/bindings/pci/pci-armada8k.txt       |   2 +-
 Documentation/devicetree/bindings/pci/pcie-al.txt  |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          |  14 +-
 .../bindings/pci/samsung,exynos-pcie.yaml          |   4 +-
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |   4 +-
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |  90 +++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      | 102 +++++++++++
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |   4 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   4 +-
 .../bindings/pci/toshiba,visconti-pcie.yaml        | 110 +++++++++++
 .../devicetree/bindings/pci/uniphier-pcie.txt      |   2 +-
 .../bindings/phy/hisilicon,phy-hi3670-pcie.yaml    |  82 +++++++++
 .../bindings/phy/intel,lgm-emmc-phy.yaml           |   6 +-
 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  61 -------
 .../bindings/power/reset/xlnx,zynqmp-power.yaml    |  83 +++++++++
 .../regulator/richtek,rt6245-regulator.yaml        |   1 -
 .../regulator/vqmmc-ipq4019-regulator.yaml         |   1 -
 .../bindings/reset/hisilicon,hi3660-reset.yaml     |   1 -
 .../devicetree/bindings/reset/intel,rcu-gw.yaml    |   1 -
 Documentation/devicetree/bindings/rng/mtk-rng.yaml |   1 +
 .../bindings/rng/samsung,exynos5250-trng.txt       |  17 --
 .../bindings/rng/samsung,exynos5250-trng.yaml      |  44 +++++
 .../bindings/rtc/microcrystal,rv3032.yaml          |   1 -
 .../devicetree/bindings/serial/8250_omap.yaml      |   9 +-
 .../bindings/soc/litex/litex,soc-controller.yaml   |   1 -
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |   6 +-
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   2 -
 .../bindings/sound/ti,j721e-cpb-audio.yaml         |   2 -
 .../bindings/sound/ti,j721e-cpb-ivi-audio.yaml     |   2 -
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |   8 +-
 .../devicetree/bindings/spi/realtek,rtl-spi.yaml   |  12 +-
 .../devicetree/bindings/timer/arm,sp804.yaml       |   6 +-
 .../bindings/timer/energymicro,efm32-timer.txt     |  23 ---
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |  12 ++
 MAINTAINERS                                        |  18 +-
 arch/arm64/mm/init.c                               |  88 ---------
 arch/riscv/mm/init.c                               |  20 --
 drivers/of/base.c                                  |   4 +-
 drivers/of/fdt.c                                   | 137 ++++++++++----
 drivers/of/kexec.c                                 |  40 ++--
 drivers/of/kobj.c                                  |   2 +-
 drivers/of/property.c                              |  10 +
 include/dt-bindings/clock/zx296718-clock.h         | 164 -----------------
 include/dt-bindings/soc/zte,pm_domains.h           |  24 ---
 include/linux/crash_dump.h                         |   3 +-
 include/linux/of_fdt.h                             |   3 -
 scripts/Makefile.lib                               |   3 +-
 139 files changed, 2766 insertions(+), 2024 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/gemini.txt
 create mode 100644 Documentation/devicetree/bindings/arm/gemini.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/exynos-sata.txt
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
 delete mode 100644 Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/img,ascii-lcd.yaml
 delete mode 100644 Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
 delete mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
 delete mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/samsung,exynos-nocp.yaml
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max1619.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/qca,ath79-ddr-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti,da8xx-ddrctl.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 delete mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
 create mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
 create mode 100644 Documentation/devicetree/bindings/net/micrel,ks8851.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/micrel-ks8851.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
 create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/energymicro,efm32-timer.txt
 delete mode 100644 include/dt-bindings/clock/zx296718-clock.h
 delete mode 100644 include/dt-bindings/soc/zte,pm_domains.h
