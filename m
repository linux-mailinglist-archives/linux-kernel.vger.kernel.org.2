Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998083BA38B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhGBRNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:13:37 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:34602 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGBRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:13:35 -0400
Received: by mail-il1-f169.google.com with SMTP id s19so10421986ilj.1;
        Fri, 02 Jul 2021 10:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=3E7cPlb93iMrzn/B/CgeqYPQ00m7yLVjBZbx/cmAN0g=;
        b=lUc/O/zIXPEZRBgbFMB9eZd1FfItPtJF/DmYc5VFgjoLfaakR3r72yuD7MSyLyeSqk
         HW6RZRDcFA9lBSxE1EVy4caszKfYsUabom76WlKDuEja+xMz3x5UOErwXa2g0YSlEShR
         sQZObDKBKnBVATtuddeCIGGs+hk5Elk6GDA4DsNa8rOEXL2tGIMehNGnhPWiQUKvxMdm
         njDE2sui+hL9okxLc9G4sZsGMnYwUpy1BC6sIgfrVCYcxD2rIO+l2jGhwSYAdupYqtlg
         u5g9f78A4ZX/71FlrqyGtpkV5n4YtEQKuUA1405bQr9cZSvjs4a+auUkpwMZl32+aFUG
         zjdA==
X-Gm-Message-State: AOAM531zRZTyS6kYxPN+maxApanb1hnRQjYU6gEeolnttaI2k0m5+Bvm
        m/FvNgrht+oT1Ir8kJWqzQ==
X-Google-Smtp-Source: ABdhPJx+TCVfnPYSNFe08217EQ74GBjOtacg2ZDklk+tOSkrU0HMN9XvsnvCR8H/sCWexxn3juNd1g==
X-Received: by 2002:a05:6e02:c74:: with SMTP id f20mr684686ilj.85.1625245862066;
        Fri, 02 Jul 2021 10:11:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a11sm2126853ioq.12.2021.07.02.10.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 10:11:01 -0700 (PDT)
Received: (nullmailer pid 615791 invoked by uid 1000);
        Fri, 02 Jul 2021 17:10:58 -0000
Date:   Fri, 2 Jul 2021 11:10:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [GIT PULL] Devicetree updates for v5.14
Message-ID: <20210702171058.GA587468@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for 5.14. There's 2 conflicts with your tree 
currently. For renesas,drif.yaml, take the version in your tree. For 
cdns,mhdp8546.yaml, the correct resolution is dropping 'maxItems: 3'. 
linux-next has the correct resolutions.

There will also be a conflict with the GPIO tree. Accept removing 
gpio-davinci.txt. The change in it isn't needed.

Rob


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.14

for you to fetch changes up to 6a9a930dc4415b2e8c0bf2085b2b0b2b291053d5:

  dt-bindings: Fix 'unevaluatedProperties' errors in DT graph users (2021-07-01 08:07:12 -0600)

----------------------------------------------------------------
Devicetree updates for v5.14:

- Refine reserved memory nomap handling

- Merge some PCI and non-PCI address handling implementations

- Simplify of_address.h header ifdefs

- Improve printk handling of some 64-bit types

- Convert Arm ccree, Zynq FPGA, ZynqMP RTC, Arm VIC, adi,adv7511, TI
  AM56 PCI, Aspeed I2C, arm,sbsa-gwdt, MTD physmap, virtio-mmio, Arm
  SCMI, Arm/Amlogic SCPI, TI OMAP mailbox, NXP pcf8563/pcf85263/pcf85363,
  Mediatek RNG, Arm SCU, Arm TWD timer, Broadcom iProc PWM, Renesas TPU,
  Tegra20 EMC, MDIO GPIO, renesas,r9a06g032-sysctrl, renesas,emev2-smu,
  sysc-rmobile, linaro,optee-tz, and TI SCI bindings to DT schema

- Convert mux and mux controller bindings to schema. This includes MDIO
  IIO, and I2C muxes.

- Add Arm PL031 RTC binding schema

- Add vendor prefixes for StarFive Technology Co. Ltd. and Insignal Ltd

- Fix some stale doc references

- Remove stale property-units.txt. Superseded by schema in dt-schema
  repo.

- Fixes for 'unevaluatedProperties' handling (enabled with experimental
  json-schema support)

- Drop redundant usage of minItems and maxItems across the tree

- Update some examples to use bindings with a schema

----------------------------------------------------------------
Corentin Labbe (1):
      dt-bindings: net: Convert mdio-gpio to yaml

Dmitry Osipenko (2):
      dt-bindings: memory: tegra20: emc: Convert to schema
      of: reserved-memory: Add stub for RESERVEDMEM_OF_DECLARE()

Dong Aisheng (2):
      of: of_reserved_mem: only call memblock_free for normal reserved memory
      of: of_reserved_mem: mark nomap memory instead of removing

Drew Fustini (1):
      dt-bindings: add StarFive Technology Co. Ltd.

Fabien Parent (2):
      dt-bindings: rng: mediatek: convert to yaml schema
      dt-bindings: rng: mediatek: add mt8365 to mtk rng binding

Geert Uytterhoeven (14):
      dt-bindings: ata: renesas,rcar-sata: Make power-domains and resets required
      dt-bindings: pwm: renesas,pwm-rcar: Make power-domains and resets required
      dt-bindings: power: sysc-rmobile: Convert to json-schema
      dt-bindings: clk: emev2: Convert to json-schema
      dt-bindings: clock: renesas,r9a06g032-sysctrl: Convert to json-schema
      dt-bindings: pwm: renesas,tpu-pwm: Improve json-schema
      dt-bindings: timer: renesas,tpu: Convert to json-schema
      dt-bindings: timer: arm,twd: Convert to json-schema
      dt-bindings: arm: scu: Convert to json-schema
      dt-bindings: usb: cdns,usb3: Fix interrupts order
      dt-bindings: rtc: nxp,pcf8563: Absorb pcf85263/pcf85363 bindings
      of: Fix truncation of memory sizes on 32-bit platforms
      of: Remove superfluous casts when printing u64 values
      dt-bindings: crypto: ccree: Convert to json-schema

Hao Fang (1):
      dt-bindings: hisilicon: use the correct HiSilicon copyright

Jamin Lin (1):
      dt-bindings: aspeed-i2c: Convert txt to yaml format

Jonathan Cameron (1):
      dt-bindings: iio: multiplexer: Convert io-channel-mux bindings to DT schema

Kishon Vijay Abraham I (1):
      dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint mode dt-bindings to YAML

Krzysztof Kozlowski (2):
      dt-bindings: add vendor prefix for Insignal Ltd
      dt-bindings: arm: intel,keembay: limit the dtschema to root node

Luca Ceresoli (1):
      docs: dt: remove stale property-units.txt, link to current schema

Marek Vasut (1):
      dt-bindings: display: Fix spacing in lvds.yaml

Mauro Carvalho Chehab (5):
      dt-bindings: power: supply: cpcap-battery: update cpcap-battery.yaml reference
      dt-bindings: power: supply: cpcap-charger: update cpcap-charger.yaml reference
      dt-bindings: soc: ti: update sci-pm-domain.yaml references
      dt-bindings: clock: update ti,sci-clk.yaml references
      dt-bindings: reset: update ti,sci-reset.yaml references

Nishanth Menon (5):
      dt-bindings: reset: Convert ti,sci-reset to json schema
      dt-bindings: clock: Convert ti,sci-clk to json schema
      dt-bindings: soc: ti: Convert ti,sci-pm-domain to json schema
      dt-bindings: arm: keystone: Convert ti,sci to json schema
      dt-bindings: arm: firmware: Convert linaro,optee-tz to json schema

Nobuhiro Iwamatsu (2):
      dt-bindings: rtc: zynqmp: convert bindings to YAML
      dt-bindings: fpga: zynq: convert bindings to YAML

Rafał Miłecki (1):
      dt-bindings: pwm: brcm,iproc-pwm: convert to the json-schema

Ricardo Cañuelo (1):
      dt-bindings: drm: bridge: adi,adv7511.txt: convert to yaml

Rob Herring (22):
      dt-bindings: mfd: ti,j721e-system-controller: Fix mux node errors
      dt-bindings: rtc: nxp,pcf8563: Convert to DT schema
      dt-bindings: mux: Convert mux controller bindings to schema
      dt-bindings: i2c: Convert i2c-mux bindings to DT schema
      dt-bindings: i2c: i2c-mux-pca954x: Convert to DT schema
      dt-bindings: i2c: maxim,max9286: Use the i2c-mux.yaml schema
      dt-bindings: net: Convert MDIO mux bindings to DT schema
      of: Drop reserved mem dependency on DMA_DECLARE_COHERENT and DMA_CMA
      of: Move reserved memory private function declarations
      PCI: Add empty stub for pci_register_io_range()
      of: Merge of_get_address() and of_get_pci_address() implementations
      of: address: Use IS_ENABLED() for !CONFIG_PCI
      of: Merge of_address_to_resource() and of_pci_address_to_resource() implementations
      dt-bindings: rtc: Add Arm PL031 schema
      dt-bindings: virtio: Convert virtio-mmio to DT schema
      dt-bindings: mtd: Convert mtd-physmap to DT schema
      dt-bindings: watchdog: Convert arm,sbsa-gwdt to DT schema
      dt-bindings: spmi: Correct 'reg' schema
      dt-bindings: Drop redundant minItems/maxItems
      dt-bindings: media: adv7180: Add missing video-interfaces.yaml reference
      dt-bindings: display: renesas,du: Fix 'ports' reference
      dt-bindings: Fix 'unevaluatedProperties' errors in DT graph users

Sean Anderson (1):
      dt-bindings: clk: vc5: Fix example

Sudeep Holla (13):
      dt-bindings: firmware: arm,scpi: Move arm,scp-shmem to json schema
      dt-bindings: firmware: arm,scmi: Move arm,scmi-shmem to json schema
      dt-bindings: firmware: juno,scpi: Move to sram.yaml json schema
      dt-bindings: firmware: amlogic,scpi: Move arm,scpi-shmem to json schema
      dt-bindings: mailbox : arm,mhu: Fix arm,scpi example used here
      dt-bindings: firmware: arm,scpi: Convert to json schema
      dt-bindings: firmware: amlogic,scpi: Convert to json schema
      dt-bindings: firmware: arm,scmi: Convert to json schema
      dt-bindings: mailbox : arm,mhu: Use examples with matching schema
      dt-bindings: mailbox : arm,mhuv2: Use example with matching schema
      dt-bindings: interrupt-controller: Fix compatible used in ti,pruss-intc
      dt-bindings: pwm: Use examples with documented/matching schema
      dt-bindings: interrupt-controller: Convert ARM VIC to json-schema

Suman Anna (1):
      dt-bindings: mailbox: Convert omap-mailbox.txt binding to YAML

Wolfram Sang (1):
      dt-bindings: timer: renesas,tmu: add r8a779a0 TMU support

Zhen Lei (1):
      of: unittest: Use DEFINE_RES_MEM() to simplify code

 .../devicetree/bindings/arm/amlogic,scpi.txt       |  27 --
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 239 ---------------
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 219 -------------
 Documentation/devicetree/bindings/arm/arm,scu.yaml |  46 +++
 .../bindings/arm/firmware/linaro,optee-tz.txt      |  31 --
 .../bindings/arm/firmware/linaro,optee-tz.yaml     |  58 ++++
 .../devicetree/bindings/arm/intel,keembay.yaml     |   2 +
 .../devicetree/bindings/arm/juno,scpi.txt          |  26 --
 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  86 ------
 .../devicetree/bindings/arm/keystone/ti,sci.yaml   | 129 ++++++++
 Documentation/devicetree/bindings/arm/scu.txt      |  28 --
 .../devicetree/bindings/arm/ux500/boards.txt       |   4 +-
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml |   1 -
 .../devicetree/bindings/ata/renesas,rcar-sata.yaml |  11 +
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |   2 -
 .../devicetree/bindings/clock/idt,versaclock5.yaml |   7 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |   1 -
 .../devicetree/bindings/clock/qcom,gcc-sdx55.yaml  |   2 -
 .../devicetree/bindings/clock/qcom,gcc-sm8350.yaml |   2 -
 .../bindings/clock/renesas,emev2-smu.txt           |  98 ------
 .../bindings/clock/renesas,emev2-smu.yaml          | 140 +++++++++
 .../bindings/clock/renesas,r9a06g032-sysctrl.txt   |  46 ---
 .../bindings/clock/renesas,r9a06g032-sysctrl.yaml  |  62 ++++
 .../bindings/clock/sprd,sc9863a-clk.yaml           |   1 -
 .../devicetree/bindings/clock/ti,sci-clk.txt       |  36 ---
 .../devicetree/bindings/clock/ti,sci-clk.yaml      |  49 +++
 .../bindings/crypto/allwinner,sun8i-ce.yaml        |   2 -
 .../devicetree/bindings/crypto/arm,cryptocell.yaml |  53 ++++
 .../devicetree/bindings/crypto/arm-cryptocell.txt  |  25 --
 .../devicetree/bindings/crypto/fsl-dcp.yaml        |   1 -
 .../allwinner,sun4i-a10-display-backend.yaml       |   6 -
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |   1 -
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml      |   4 -
 .../display/allwinner,sun8i-a83t-hdmi-phy.yaml     |   2 -
 .../display/allwinner,sun8i-r40-tcon-top.yaml      |   2 -
 .../bindings/display/bridge/adi,adv7511.txt        | 143 ---------
 .../bindings/display/bridge/adi,adv7511.yaml       | 240 +++++++++++++++
 .../bindings/display/bridge/adi,adv7533.yaml       | 184 +++++++++++
 .../bindings/display/bridge/cdns,mhdp8546.yaml     |   2 -
 .../bindings/display/bridge/lontium,lt8912b.yaml   |   3 +-
 .../devicetree/bindings/display/panel/lvds.yaml    |  46 +--
 .../devicetree/bindings/display/renesas,du.yaml    |   2 +-
 .../display/rockchip/rockchip,dw-hdmi.yaml         |   2 -
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |   2 -
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |   1 -
 .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   |   4 -
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   1 -
 Documentation/devicetree/bindings/dma/ti-edma.txt  |   4 +-
 .../bindings/edac/amazon,al-mc-edac.yaml           |   2 -
 Documentation/devicetree/bindings/eeprom/at24.yaml |   1 -
 .../devicetree/bindings/example-schema.yaml        |   2 -
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 341 +++++++++++++++++++++
 .../devicetree/bindings/firmware/arm,scpi.yaml     | 247 +++++++++++++++
 .../bindings/fpga/xilinx-zynq-fpga-mgr.txt         |  19 --
 .../bindings/fpga/xilinx-zynq-fpga-mgr.yaml        |  52 ++++
 .../devicetree/bindings/gpio/gpio-davinci.txt      |   2 +-
 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml      |   1 -
 .../devicetree/bindings/gpu/vivante,gc.yaml        |   1 -
 .../devicetree/bindings/i2c/aspeed,i2c.yaml        |  74 +++++
 .../devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml  |   1 -
 .../devicetree/bindings/i2c/i2c-aspeed.txt         |  49 ---
 .../devicetree/bindings/i2c/i2c-davinci.txt        |   4 +-
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |   2 +-
 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   4 +-
 .../devicetree/bindings/i2c/i2c-mux-gpmux.txt      |  99 ------
 .../devicetree/bindings/i2c/i2c-mux-gpmux.yaml     | 124 ++++++++
 .../devicetree/bindings/i2c/i2c-mux-ltc4306.txt    |   4 +-
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  74 -----
 .../devicetree/bindings/i2c/i2c-mux-pca954x.yaml   | 110 +++++++
 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |   4 +-
 .../devicetree/bindings/i2c/i2c-mux-reg.txt        |   4 +-
 Documentation/devicetree/bindings/i2c/i2c-mux.txt  |  73 -----
 Documentation/devicetree/bindings/i2c/i2c-mux.yaml |  87 ++++++
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml          |   2 -
 .../bindings/i2c/mellanox,i2c-mlxbf.yaml           |   1 -
 .../bindings/iio/adc/amlogic,meson-saradc.yaml     |   1 -
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |   2 -
 .../bindings/iio/multiplexer/io-channel-mux.txt    |  39 ---
 .../bindings/iio/multiplexer/io-channel-mux.yaml   |  70 +++++
 .../bindings/interrupt-controller/arm,vic.txt      |  41 ---
 .../bindings/interrupt-controller/arm,vic.yaml     |  81 +++++
 .../interrupt-controller/fsl,irqsteer.yaml         |   1 -
 .../interrupt-controller/loongson,liointc.yaml     |   1 -
 .../interrupt-controller/ti,pruss-intc.yaml        |   2 +-
 .../devicetree/bindings/iommu/arm,smmu-v3.yaml     |   1 -
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   1 -
 .../devicetree/bindings/mailbox/arm,mhu.yaml       |  48 ++-
 .../devicetree/bindings/mailbox/arm,mhuv2.yaml     |  25 +-
 .../devicetree/bindings/mailbox/omap-mailbox.txt   | 184 -----------
 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml |   2 -
 .../bindings/mailbox/ti,omap-mailbox.yaml          | 308 +++++++++++++++++++
 .../devicetree/bindings/media/amlogic,gx-vdec.yaml |   1 -
 .../devicetree/bindings/media/i2c/adv7180.yaml     |   8 +-
 .../devicetree/bindings/media/i2c/adv7604.yaml     |   1 -
 .../devicetree/bindings/media/i2c/imx258.yaml      |   2 +-
 .../bindings/media/i2c/maxim,max9286.yaml          |  23 +-
 .../devicetree/bindings/media/i2c/ovti,ov5648.yaml |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov8865.yaml |   2 +-
 .../devicetree/bindings/media/i2c/sony,imx334.yaml |   2 +-
 .../bindings/media/marvell,mmp2-ccic.yaml          |   1 -
 .../bindings/media/qcom,sc7180-venus.yaml          |   1 -
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |   1 -
 .../bindings/media/qcom,sm8250-venus.yaml          |   1 -
 .../devicetree/bindings/media/renesas,drif.yaml    |   2 -
 .../devicetree/bindings/media/renesas,vin.yaml     |   3 +-
 .../memory-controllers/mediatek,smi-common.yaml    |   6 +-
 .../memory-controllers/mediatek,smi-larb.yaml      |   1 -
 .../memory-controllers/nvidia,tegra20-emc.txt      | 130 --------
 .../memory-controllers/nvidia,tegra20-emc.yaml     | 230 ++++++++++++++
 .../devicetree/bindings/mfd/motorola-cpcap.txt     |   4 +-
 .../bindings/mfd/ti,j721e-system-controller.yaml   |  19 +-
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |   2 -
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 -
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   2 -
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   2 -
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   1 -
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         |   1 -
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   4 +-
 .../devicetree/bindings/mtd/arm-versatile.txt      |  26 --
 .../bindings/mtd/cortina,gemini-flash.txt          |   2 +-
 .../devicetree/bindings/mtd/cypress,hyperflash.txt |  13 -
 .../devicetree/bindings/mtd/intel,ixp4xx-flash.txt |  22 --
 .../devicetree/bindings/mtd/mtd-physmap.txt        | 114 -------
 .../devicetree/bindings/mtd/mtd-physmap.yaml       | 208 +++++++++++++
 .../devicetree/bindings/mtd/ti,am654-hbmc.txt      |   2 +-
 .../devicetree/bindings/mux/adi,adg792a.txt        |   2 +-
 .../devicetree/bindings/mux/adi,adgs1408.txt       |   2 +-
 Documentation/devicetree/bindings/mux/gpio-mux.txt |  69 -----
 .../devicetree/bindings/mux/gpio-mux.yaml          |  92 ++++++
 .../devicetree/bindings/mux/mux-consumer.yaml      |  46 +++
 .../devicetree/bindings/mux/mux-controller.txt     | 157 ----------
 .../devicetree/bindings/mux/mux-controller.yaml    | 182 +++++++++++
 Documentation/devicetree/bindings/mux/reg-mux.txt  | 129 --------
 Documentation/devicetree/bindings/mux/reg-mux.yaml | 143 +++++++++
 .../bindings/net/amlogic,meson-dwmac.yaml          |   2 -
 .../devicetree/bindings/net/brcm,bcm4908-enet.yaml |   2 -
 .../bindings/net/brcm,mdio-mux-iproc.txt           |   2 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |   2 -
 .../devicetree/bindings/net/can/c_can.txt          |   4 +-
 .../devicetree/bindings/net/dsa/brcm,sf2.yaml      |   2 -
 .../devicetree/bindings/net/mdio-gpio.txt          |  27 --
 .../devicetree/bindings/net/mdio-gpio.yaml         |  57 ++++
 .../devicetree/bindings/net/mdio-mux-gpio.txt      | 119 -------
 .../devicetree/bindings/net/mdio-mux-gpio.yaml     | 135 ++++++++
 .../devicetree/bindings/net/mdio-mux-mmioreg.txt   |  75 -----
 .../devicetree/bindings/net/mdio-mux-mmioreg.yaml  |  78 +++++
 .../bindings/net/mdio-mux-multiplexer.txt          |  82 -----
 .../bindings/net/mdio-mux-multiplexer.yaml         |  82 +++++
 Documentation/devicetree/bindings/net/mdio-mux.txt | 129 --------
 .../devicetree/bindings/net/mdio-mux.yaml          |  44 +++
 .../devicetree/bindings/net/snps,dwmac.yaml        |   2 -
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   1 -
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   2 -
 .../devicetree/bindings/pci/loongson.yaml          |   1 -
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   1 -
 .../bindings/pci/microchip,pcie-host.yaml          |   2 -
 .../devicetree/bindings/pci/pci-keystone.txt       | 115 -------
 .../devicetree/bindings/pci/ti,am65-pci-ep.yaml    |  74 +++++
 .../devicetree/bindings/pci/ti,am65-pci-host.yaml  |  96 ++++++
 .../devicetree/bindings/perf/arm,cmn.yaml          |   1 -
 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml        |   1 -
 .../bindings/phy/brcm,brcmstb-usb-phy.yaml         |   3 -
 .../devicetree/bindings/phy/brcm,sata-phy.yaml     |   1 -
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   2 -
 .../bindings/phy/phy-cadence-sierra.yaml           |   2 -
 .../bindings/phy/phy-cadence-torrent.yaml          |   4 -
 .../bindings/phy/qcom,ipq806x-usb-phy-hs.yaml      |   1 -
 .../bindings/phy/qcom,ipq806x-usb-phy-ss.yaml      |   1 -
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   1 -
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   2 -
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   2 -
 .../devicetree/bindings/phy/renesas,usb3-phy.yaml  |   1 -
 .../bindings/pinctrl/actions,s500-pinctrl.yaml     |   1 -
 .../bindings/power/amlogic,meson-ee-pwrc.yaml      |   1 -
 .../bindings/power/renesas,sysc-rmobile.txt        | 100 ------
 .../bindings/power/renesas,sysc-rmobile.yaml       | 121 ++++++++
 .../devicetree/bindings/property-units.txt         |  48 ---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml      |   1 -
 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |  21 --
 .../devicetree/bindings/pwm/brcm,iproc-pwm.yaml    |  45 +++
 Documentation/devicetree/bindings/pwm/pwm.yaml     |   9 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |  13 +
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |  26 ++
 .../bindings/remoteproc/st,stm32-rproc.yaml        |   2 -
 .../bindings/remoteproc/ti,keystone-rproc.txt      |   4 +-
 .../bindings/remoteproc/ti,omap-remoteproc.yaml    |   3 +-
 .../devicetree/bindings/reset/fsl,imx-src.yaml     |   1 -
 .../devicetree/bindings/reset/ti,sci-reset.txt     |  62 ----
 .../devicetree/bindings/reset/ti,sci-reset.yaml    |  51 +++
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml |   1 -
 Documentation/devicetree/bindings/rng/mtk-rng.txt  |  22 --
 Documentation/devicetree/bindings/rng/mtk-rng.yaml |  54 ++++
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml      |   1 -
 .../devicetree/bindings/rtc/arm,pl031.yaml         |  58 ++++
 .../devicetree/bindings/rtc/imxdi-rtc.yaml         |   1 -
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml       |  58 ++++
 Documentation/devicetree/bindings/rtc/pcf85363.txt |  17 -
 Documentation/devicetree/bindings/rtc/pcf8563.txt  |  29 --
 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml   |  65 ++++
 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt |  25 --
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   2 -
 .../devicetree/bindings/serial/samsung_uart.yaml   |   1 -
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   1 -
 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  65 ----
 .../devicetree/bindings/soc/ti/sci-pm-domain.yaml  |  59 ++++
 .../devicetree/bindings/soc/ti/ti,pruss.yaml       |   2 -
 .../sound/nvidia,tegra-audio-graph-card.yaml       |   1 -
 .../bindings/sound/nvidia,tegra210-i2s.yaml        |   2 -
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   3 -
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |   1 -
 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml |   2 -
 .../devicetree/bindings/spi/spi-davinci.txt        |   2 +-
 Documentation/devicetree/bindings/spmi/spmi.yaml   |  15 +-
 Documentation/devicetree/bindings/sram/sram.yaml   |   5 +
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   2 -
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 -
 .../timer/allwinner,sun5i-a13-hstimer.yaml         |   1 -
 .../devicetree/bindings/timer/arm,arch_timer.yaml  |   1 -
 .../bindings/timer/arm,arch_timer_mmio.yaml        |   2 -
 .../devicetree/bindings/timer/arm,twd-timer.yaml   |  56 ++++
 .../devicetree/bindings/timer/arm,twd.txt          |  53 ----
 .../bindings/timer/intel,ixp4xx-timer.yaml         |   1 -
 .../devicetree/bindings/timer/renesas,tmu.yaml     |   1 +
 .../devicetree/bindings/timer/renesas,tpu.txt      |  21 --
 .../devicetree/bindings/timer/renesas,tpu.yaml     |  56 ++++
 .../devicetree/bindings/usb/cdns,usb3.yaml         |   2 +-
 .../devicetree/bindings/usb/maxim,max3420-udc.yaml |   2 -
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   4 -
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   3 -
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   2 +-
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   6 +-
 Documentation/devicetree/bindings/virtio/mmio.txt  |  47 ---
 Documentation/devicetree/bindings/virtio/mmio.yaml |  60 ++++
 .../bindings/watchdog/arm,sbsa-gwdt.yaml           |  51 +++
 .../devicetree/bindings/watchdog/arm,twd-wdt.yaml  |  50 +++
 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  31 --
 .../bindings/watchdog/st,stm32-iwdg.yaml           |   1 -
 .../devicetree/bindings/writing-bindings.rst       |   3 +-
 MAINTAINERS                                        |  10 +-
 drivers/of/Kconfig                                 |   4 +-
 drivers/of/address.c                               | 128 +++-----
 drivers/of/fdt.c                                   |  14 +-
 drivers/of/of_private.h                            |   4 +
 drivers/of/of_reserved_mem.c                       |  17 +-
 drivers/of/unittest.c                              |   6 +-
 include/linux/of.h                                 |  11 +-
 include/linux/of_address.h                         |  54 ++--
 include/linux/of_reserved_mem.h                    |  14 +-
 include/linux/pci.h                                |   4 +
 250 files changed, 5047 insertions(+), 3773 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic,scpi.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scu.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/juno,scpi.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/scu.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,emev2-smu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,emev2-smu.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/arm,cryptocell.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml
 create mode 100644 Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
 create mode 100644 Documentation/devicetree/bindings/firmware/arm,scmi.yaml
 create mode 100644 Documentation/devicetree/bindings/firmware/arm,scpi.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/arm-versatile.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/intel,ixp4xx-flash.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/mtd-physmap.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.yaml
 create mode 100644 Documentation/devicetree/bindings/mux/mux-consumer.yaml
 delete mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mdio-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mdio-mux-mmioreg.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-mmioreg.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mdio-mux-multiplexer.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-multiplexer.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mdio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-keystone.txt
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
 delete mode 100644 Documentation/devicetree/bindings/property-units.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/mtk-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/mtk-rng.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/arm,pl031.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,twd.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml
 delete mode 100644 Documentation/devicetree/bindings/virtio/mmio.txt
 create mode 100644 Documentation/devicetree/bindings/virtio/mmio.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
