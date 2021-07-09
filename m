Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD453C2BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGIXn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhGIXnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:43:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68853C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 16:41:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f5so11478139pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IargoeSBIC3v3pGJW8LraJ/P6nNyyva8I1I4+g933S8=;
        b=KvjcXX0evkvVmk0D71lp7OGNRE/L4pzeMnZdGEPrbtj3jxMkDJn2Jul+UbCeqDNS/0
         I7ejff+Pj3461m9cEy/Sr2gAQeFIf/BNYRvNeBpDCWCVyszzj380Iu5/Dm1Iz9hBeeLt
         RerWaIIkpaJ4lj2IW49JGvdAZl4P4+u8ds8uo6CZiw85eJc8BBjElFOyqyTxGwOUKuHK
         5mtzDTm+ZEEEsgzhMG4h5fVyysFWcjRGYQL3g0abrx16DR2sZRKfBYnf4RFfgH8GFQhl
         /WT9Nj7LW8gYCfYB4Y4jwClZz3CCxjsbf4NOLMVluPGH/yfSkLSdw/gFTuGmCQa9lzHe
         SBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IargoeSBIC3v3pGJW8LraJ/P6nNyyva8I1I4+g933S8=;
        b=SjUcbI0/hOdUXc7uEoxIxbtNF2xK9uhmJLFa9A+j2CZ+JzlZlYsnW+IzqZNu273DB+
         bze98NrJ212CaNniH2Js4/CobVm0/7vbHZVwCPxOMxNJmNsbfjpXS1LEVOGm2VkwHycE
         wJTdbYvvF5ZoP2aAR/PNVo5pvybnaeST1K1DuD9f1sW9VQ3oGTL2UNoN9SGfNZpkjpId
         tnuXFNurXsbC1A3MtxtHBbtSCMYxi1mJRdijCsKKNZFN9yl+HF9escx1S4Kw9pdVKjob
         AKoYbMDzoKnyhuqXg/F243icoiZe5lqPGHCE8M+aWYZPKF+cXKx7Jwi9CLClIa8NXHex
         Flgw==
X-Gm-Message-State: AOAM5335KrMVbyXyct/XIPgupQKi9WJQl+16S3Sp62+Jy4CdAgF5QrPl
        YogeFQHp4jAFt8O7RZsuIsZ2Gg==
X-Google-Smtp-Source: ABdhPJwC1v1IkwJmFKDOD8cmwkk3+UbQ8RPlt4GL5FXZNR5wqrUSBy/LW5y+oY219nv2/6JvhUYtjw==
X-Received: by 2002:a05:6a00:2403:b029:309:8a37:2d51 with SMTP id z3-20020a056a002403b02903098a372d51mr40267433pfh.79.1625874069624;
        Fri, 09 Jul 2021 16:41:09 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id n5sm2036381pfv.29.2021.07.09.16.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 16:41:08 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/4] ARM: Devicetree material for 5.14
Date:   Fri,  9 Jul 2021 16:40:52 -0700
Message-Id: <20210709234054.10288-2-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210709234054.10288-1-olof@lixom.net>
References: <20210709234054.10288-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like always, the DT branch is sizable. There are numerous additions and
fixes to existing platforms, but also a handful of new ones introduced.
Less than some other releases, but there's been significant work on
cleanups, refactorings and device enabling on existing platforms.

A non-exhaustive list of new material:

- Refactoring of BCM2711 dtsi structure to add support for the Raspberry Pi 400
- Rockchip: RK3568 SoC and EVB, video codecs for rk3036/3066/3188/322x
- Qualcomm: SA8155p Automotive platform (SM8150 derivative),
SM8150/8250 enhancements and support for Sony Xperia 1/1II and 5/5II
- TI K3: PCI/USB3 support on AM64-sk boards, R5 remoteproc definitions
- TI OMAP: Various cleanups
- Tegra: Audio support for Jetson Xavier NX, SMMU support on Tegra194
- Qualcomm: lots of additions for peripherals across several SoCs, and
new support for Microsoft Surface Duo (SM8150-based), Huawei Ascend G7.
- i.MX: Numerous additions of features across SoCs and boards.
- Allwinner: More device bindings for V3s, Forlinx OKA40i-C and NanoPi
R1S H5 boards
- MediaTek: More device bindings for mt8167, new Chromebook system
variants for mt8183
- Renesas: RZ/G2L SoC and EVK added
- Amlogic: BananaPi BPI-M5 board added



Merge conflicts:

Documentation/devicetree/bindings/net/stm32-dwmac.yaml:
	Delete/change conflict. Just delete the MaxItems line.

----------------------------------------------------------------

The following changes since commit fed7ef52ec0f448193cd9ac1541a82a9cb782383:

  Merge tag 'arm-soc-5.14' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-dt-5.14

for you to fetch changes up to b62b189f7e2cfd1089b37be57b2e6672d5c3ae14:

  Merge tag 'v5.14-rockchip-dts64-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/dt

----------------------------------------------------------------

Adam Ford (8):
      ARM: dts: renesas: Add fck to etheravb-rcar-gen2 clock-names list
      arm64: dts: renesas: Add fck to etheravb-rcar-gen3 clock-names list
      arm64: dts: renesas: beacon kit: Setup AVB refclk
      arm64: dts: renesas: beacon: Fix USB extal reference
      arm64: dts: renesas: beacon: Fix USB ref clock references
      arm64: dts: imx8mn: Add spba1 bus
      arm64: dts: imx8mm: Add spba1 and spba2 buses
      arm64: dts: imx8mn-beacon-som: Assign PMIC clock

Adrien Grassein (3):
      arm64: dts: imx8mq-nitrogen: add USB OTG support
      arm64: dts: imx8mq-nitrogen: add USB HOST support
      arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI

Alex Bee (8):
      ARM: dts: rockchip: add power controller for RK3036
      ARM: dts: rockchip: add power controller for RK322x
      arm64: dts: rockchip: add ir-receiver for rk3399-roc-pc
      arm64: dts: rockchip: Re-add regulator-boot-on, regulator-always-on for vdd_gpu on rk3399-roc-pc
      arm64: dts: rockchip: Re-add regulator-always-on for vcc_sdio for rk3399-roc-pc
      ARM: dts: rockchip: add vpu node for RK3036
      ARM: dts: rockchip: add vpu nodes for RK3066 and RK3188
      ARM: dts: rockchip: add vpu and vdec node for RK322x

Alex Elder (3):
      arm64: dts: qcom: sm8350: add IPA information
      arm64: dts: qcom: sm8350-mtp: enable IPA
      arm64: dts: qcom: sdm845-mtp: enable IPA

Alexandre Torgue (9):
      ARM: dts: stm32: fix gpio-keys node on STM32 MCU boards
      ARM: dts: stm32: fix RCC node name on stm32f429 MCU
      ARM: dts: stm32: fix timer nodes on STM32 MCU to prevent warnings
      ARM: dts: stm32: update pinctrl node name on STM32 MCU to prevent warnings
      ARM: dts: stm32: fix i2c node name on stm32f746 to prevent warnings
      ARM: dts: stm32: move stmmac axi config in ethernet node on stm32mp15
      dt-bindings: net: document ptp_ref clk in dwmac
      ARM: dts: stm32: fix ltdc pinctrl on microdev2.0-of7
      ARM: dts: stm32: fix stpmic node for stm32mp1 boards

Andreas Rehn (1):
      ARM: dts: sun8i: v3s: enable emac for zero Dock

Arnaud Ferraris (1):
      arm64: dts: allwinner: pinephone: Set audio card name

Aswath Govindraju (10):
      arm64: dts: ti: k3-am64-mcu: Fix the compatible string in GPIO DT node
      arm64: dts: ti: k3-j7200: Remove "#address-cells" property from GPIO DT nodes
      arm64: dts: ti: k3-am65: Add support for UHS-I modes in MMCSD1 subsystem
      ARM: dts: am335x: align ti,pindir-d0-out-d1-in property with dt-shema
      ARM: dts: am437x: align ti,pindir-d0-out-d1-in property with dt-shema
      arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in property with dt-shema
      arm64: dts: ti: k3-am642-evm: align ti,pindir-d0-out-d1-in property with dt-shema
      arm64: dts: ti: k3-am64-main: Update TF-A's maximum size and node name
      arm64: dts: ti: k3-am64-main: Reserve OCMRAM for DMSC-lite and secure proxy communication
      arm64: dts: ti: k3-am64-main: Update TF-A load address to workaround USB DFU limitation

Benjamin Gaignard (3):
      ARM: dts: rockchip: Fix IOMMU nodes properties on rk322x
      ARM: dts: rockchip: Remove useless interrupt-names on IOMMU node on rk3036
      arm64: dts: rockchip: Remove useless interrupt-names properties from px30 IOMMU nodes

Bhupesh Sharma (5):
      dt-bindings: arm: qcom: Add compatible for sm8150-mtp board
      dt-bindings: arm: qcom: Add compatible for SA8155p-adp board
      arm64: dts: qcom: pmm8155au_1: Add base dts file
      arm64: dts: qcom: pmm8155au_2: Add base dts file
      arm64: dts: qcom: sa8155p-adp: Add base dts file

Caleb Connolly (2):
      arm64: dts: qcom: sdm845-oneplus-common: guard rmtfs-mem
      arm64: dts: qcom: sdm845-oneplus-common: enable ipa

Cameron Nemo (1):
      arm64: dts: rockchip: Enable USB3 for rk3328 Rock64

Chen-Yu Tsai (4):
      arm64: dts: rockchip: Enable USB3 for rk3328 ROC-RK3328-CC
      arm64: dts: rockchip: Enable USB3 for rk3328 Rock Pi E
      arm64: dts: rockchip: Enable USB3 Ethernet on rk3328 NanoPi R2S
      arm64: dts: rockchip: Drop fephy pinctrl from gmac2phy on rk3328 rock-pi-e

Chris Morgan (2):
      arm64: dts: rockchip: add rk817 codec to Odroid Go
      arm64: dts: rockchip: Add Rotation Property for OGA Panel

Christian Hewitt (1):
      arm64: dts: meson-sm1-odroid-hc4: add spifc node to ODROID-HC4

Christoph Niedermaier (5):
      ARM: dts: imx6q-dhcom: Fix ethernet reset time properties
      ARM: dts: imx6q-dhcom: Fix ethernet plugin detection problems
      ARM: dts: imx6q-dhcom: Add gpios pinctrl for i2c bus recovery
      ARM: dts: imx6q-dhcom: Add aliases for i2c, serial and rtc
      ARM: dts: imx6q-dhcom: Add ethernet VIO regulator

Chukun Pan (2):
      dt-bindings: arm: Add NanoPi R1S H5
      arm64: dts: allwinner: h5: Add NanoPi R1S H5 support

Corentin Labbe (14):
      MAINTAINERS: gemini: add missing dts pattern
      ARM: dts: gemini: rename mdio to the right name
      ARM: dts: gemini-rut1xx: remove duplicate ethernet node
      ARM: dts: gemini: add device_type on pci
      ARM: dts: gemini: use the right rtc compatible
      ARM: dts: gemini: convert obsolete SPI properties
      ARM: dts: gemini-dlink-dns-313: rename gpio-i2c to i2c
      ARM: dts: gemini-dlink-dir-685: rename gpio-i2c to i2c
      ARM: dts: gemini-dlink-dir-685: Remove address from display port
      ARM: dts: gemini: remove xxx-cells from display
      dt-bindings: add vendor prefix for welltech
      dt-bindings: arm: intel-ixp4xx: add welltech,epbx100
      ARM: dts: add intel-ixp42x-welltech-epbx100
      ARM: dts: gemini: add crypto node

Dario Binacchi (1):
      ARM: dts: osd3358-sm-red: group in the same phandle all its properties

Dillon Min (3):
      dt-bindings: add dasheng vendor prefix
      dt-bindings: arm: imx: Add i.mx6q DaSheng COM-9XX SBC
      ARM: dts: imx: Add i.mx6q DaSheng COM-9XX SBC board support

Dmitry Osipenko (15):
      ARM: tegra: acer-a500: Improve microphone detection
      ARM: tegra: acer-a500: Specify proper voltage for WiFi SDIO bus
      ARM: tegra: acer-a500: Bump thermal trips by 10C
      ARM: tegra: Add reg property to Tegra20 EMC table device-tree nodes
      ARM: tegra: wm8903: Fix polarity of headphones-detection GPIO in device-trees
      ARM: tegra: paz00: Add CPU thermal zone
      ARM: tegra: nexus7: Add i2c-thermtrip node
      ARM: tegra: nexus7: Improve thermal zones
      ARM: tegra: nexus7: Remove monitored-battery property
      ARM: tegra: nexus7: Correct 3v3 regulator GPIO of PM269 variant
      ARM: tegra: Add cooling cells to ACTMON device-tree node
      ARM: tegra: nexus7: Enable memory frequency thermal throttling using ACTMON
      ARM: tegra: ouya: Enable memory frequency thermal throttling using ACTMON
      dt-bindings: clock: tegra: Convert to schema
      dt-bindings: soc: tegra-pmc: Document core power domain

Dong Aisheng (1):
      arm64: dts: imx8: conn: fix enet clock setting

Douglas Anderson (1):
      arm64: dts: qcom: sc7180: Fix sc7180-qmp-usb3-dp-phy reg sizes

Eddie James (1):
      ARM: dts: aspeed: Rainier 4U: Remove fan updates

Elaine Zhang (6):
      ARM: dts: rockchip: Fix power-controller node names for rk3066a
      ARM: dts: rockchip: Fix power-controller node names for rk3188
      ARM: dts: rockchip: Fix power-controller node names for rk3288
      arm64: dts: rockchip: Fix power-controller node names for px30
      arm64: dts: rockchip: Fix power-controller node names for rk3328
      arm64: dts: rockchip: Fix power-controller node names for rk3399

Ezequiel Garcia (3):
      ARM: dts: rockchip: Fix thermal sensor cells o rk322x
      arm64: dts: rockchip: add timer0 clocks on rk3368
      ARM: dts: rockchip: Fix the timer clocks order

Fabien Parent (5):
      arm64: dts: mediatek: mt8167: add power domains
      arm64: dts: mediatek: mt8167: add mmsys node
      arm64: dts: mediatek: mt8167: add smi_common node
      arm64: dts: mediatek: mt8167: add larb nodes
      arm64: dts: mediatek: mt8167: add iommu node

Fabio Estevam (1):
      ARM: dts: imx6qdl-wandboard-revd1: Remove PAD_EIM_D22 from hog group

Felipe Balbi (2):
      arm64: dts: qcom: sm8150: Add DMA nodes
      arm64: dts: qcom: add initial device-tree for Microsoft Surface Duo

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-dt-next-2021-06-08-v2' into devicetree/next

Geert Uytterhoeven (17):
      ARM: dts: i.MX51: digi-connectcore-som: Correct Ethernet node name
      ARM: dts: imx53-ard: Correct Ethernet node name
      ARM: dts: r8a7779, marzen: Fix DU clock names
      ARM: dts: koelsch: Rename sw2 to keyboard
      ARM: dts: rcar-gen1: Correct internal delay for i2c[123]
      ARM: dts: renesas: Move enable-method to CPU nodes
      ARM: dts: dra7x-evm: Align GPIO hog names with dt-schema
      arm64: dts: renesas: Add missing opp-suspend properties
      arm64: dts: renesas: r8a7796[01]: Fix OPP table entry voltages
      ARM: dts: lager: Configure pull-up for SOFT_SW GPIO keys
      ARM: dts: blanche: Configure pull-up for SOFT_SW and SW25 GPIO keys
      ARM: dts: gose: Configure pull-up for SOFT_SW GPIO keys
      ARM: dts: silk: Configure pull-up for SOFT_SW GPIO keys
      arm64: dts: renesas: r8a77961: Add INTC-EX device node
      arm64: dts: renesas: r8a779a0: Drop power-domains property from GIC node
      Merge tag 'renesas-r9a07g044-dt-binding-defs-tag' into renesas-arm-dt-for-v5.14
      ARM: dts: dra7x-evm: Drop "ti,pcf8575"

Gokul Sriram Palanisamy (1):
      arm64: dts: qcom: Add board support for HK10

Grygorii Strashko (9):
      ARM: dts: am335x: align GPIO hog names with dt-schema
      ARM: dts: am437x: align gpio hog names with dt-schema
      ARM: dts: omap3: align gpio hog names with dt-schema
      ARM: dts: omap5-board-common: align gpio hog names with dt-schema
      ARM: dts: am57xx-cl-som-am57x: fix ti,no-reset-on-init flag for gpios
      ARM: dts: am437x-gp-evm: fix ti,no-reset-on-init flag for gpios
      ARM: dts: am335x: fix ti,no-reset-on-init flag for gpios
      arm64: dts: ti: k3-am654x/j721e/j7200-common-proc-board: Fix MCU_RGMII1_TXC direction
      arm64: dts: ti: k3-am642-main: fix ports mac properties

Grzegorz Jaszczyk (1):
      Documentation/bindings: phy: update references to cp11x

Grzegorz Szymaszek (3):
      ARM: dts: stm32: fix stm32mp157c-odyssey card detect pin
      ARM: dts: stm32: add a new DCMI pins group on stm32mp15
      ARM: dts: stm32: fix the Odyssey SoM eMMC VQMMC supply

Hao Fang (2):
      arm64: dts: hisilicon: use the correct HiSilicon copyright
      ARM: dts: hisilicon: use the correct HiSilicon copyright

Harigovindan P (1):
      arm64: dts: qcom: sc7180: add nodes for idp display

Heiko Schocher (2):
      arm64: dts: imx8mp: add flexspi node
      arm64: dts: imx8mp-phycore-som: enable spi nor

Hsin-Yi Wang (12):
      dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kappa
      dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-willow
      dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-burnet
      dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
      dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-fennel
      arm64: dts: mt8183: Add kukui-jacuzzi-kappa board
      arm64: dts: mt8183: Add kukui-jacuzzi-willow board
      arm64: dts: mt8183: Add kukui-jacuzzi-burnet board
      arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
      arm64: dts: mt8183: Add kukui-jacuzzi-fennel board
      arm64: dts: mt8183: remove syscon from smi_common node
      arm64: dts: mt8183: add supply name for eeprom

Ikjoon Jang (1):
      arm64: dts: mt8183: add cbas node under cros_ec

Irui Wang (1):
      arm64: dts: mt8173: Separating mtk-vcodec-enc device node

Ivan Uvarov (5):
      ARM: dts: sun8i: r40: add /omit-if-no-ref/ to pinmux nodes for UARTs 0&3
      ARM: dts: sun8i: r40: add pinmux settings for MMC3 and UARTs 2, 4, 5&7
      dt-bindings: add compatible vendor prefix for Forlinx
      dt-bindings: arm: add compatible for Forlinx OKA40i-C and FETA40i-C
      ARM: dts: sun8i: r40: add devicetree for Forlinx FETA40i-C & OKA40i-C

Jacky Bai (1):
      arm64: dts: imx8mp: Remove the reference to audio ipg clock on imx8mp

Jan Kiszka (1):
      arm64: dts: ti: iot2050: Configure r5f cluster on basic variant in split mode

Jernej Skrabec (1):
      ARM: dts: sun8i: r40: Add timer node

Jerome Brunet (1):
      arm64: dts: meson: vim3: enable hdmi audio loopback

Joakim Zhang (1):
      arm64: dts: imx8mp-evk: enable EQOS ethernet

Joel Selvaraj (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Add audio support

Joel Stanley (2):
      ARM: dts: aspeed: Set earlycon boot argument
      ARM: dts: aspeed-g5: Add SCU phandle to GFX node

Johan Jonker (15):
      ARM: dts: rockchip: fix pinctrl sleep nodename for rk3036-kylin and rk3288
      arm64: dts: rockchip: fix pinctrl sleep nodename for rk3399.dtsi
      ARM: dts: rockchip: add #power-domain-cells to power domain nodes
      arm64: dts: rockchip: add #power-domain-cells to power domain nodes
      arm64: dts: rockchip: fix regulator-gpio states array
      ARM: dts: rockchip: Remove more clock-names from PWM nodes
      ARM: dts: rockchip: rename vcc_stdby node name for rk3066a-rayeager.dts
      arm64: dts: rename grf-gpio nodename in rk3328.dtsi
      ARM: dts: rockchip: move and restyle grf nodes rk3066/rk3188
      ARM: dts: rockchip: move mmc aliases to board dts on rk3066/rk3188
      arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
      ARM: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
      ARM: dts: rockchip: remove #phy-cells from usbphy node rk3066/rk3188
      ARM: dts: rockchip: fix supply properties in io-domains nodes
      ARM: dts: rockchip: add labels to the timer nodes on rk3066a

Jon Hunter (1):
      arm64: tegra: Add PMU node for Tegra194

Jonathan Marek (1):
      arm64: dts: qcom: sm8250: fix display nodes

Jonathan McDowell (5):
      ARM: dts: qcom: Add ADM DMA + NAND definitions to ipq806x
      ARM: dts: qcom: Add tsens details to ipq806x
      ARM: dts: qcom: Add USB port definitions to ipq806x
      ARM: dts: qcom: add L2CC and RPM for IPQ8064
      ARM: dts: qcom: Enable NAND + USB for RB3011

Judy Hsiao (1):
      arm64: dts: qcom: sc7180: add label for secondary mi2s

Kishon Vijay Abraham I (9):
      arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
      arm64: dts: ti: k3-j721e-main: Add #clock-cells property to serdes DT node
      arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for SERDES
      arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as "phy"
      arm64: dts: ti: k3-am64-main: Add SERDES DT node
      arm64: dts: ti: k3-am64-main: Add PCIe DT node
      arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
      arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
      arm64: dts: ti: k3-am642-sk: Disable PCIe

Konrad Dybcio (32):
      arm64: dts: qcom: msm8996: Sanitize pins
      arm64: dts: qcom: msm8996-*: Clean up QUP and UART names
      arm64: dts: qcom: msm8996: Enlarge tcsr_mutex_regs size
      arm64: dts: qcom: msm8996: Add SDHCI1
      arm64: dts: qcom: msm8996: Add BLSP2_I2C5 and BLSP2_I2C6
      arm64: dts: qcom: msm8996: Disable MDSS and Adreno by default
      arm64: dts: qcom: msm8996: Disable Venus by default
      arm64: dts: qcom: pm8994: Add RESIN node
      arm64: dts: qcom: msm8996: Add DSI0 nodes
      arm64: dts: qcom: pmi8994: Add WLED node
      arm64: dts: qcom: msm8996: Clean up the SDHCI2 node
      arm64: dts: qcom: msm8996: Strictly limit USB2 host to USB2 speeds
      arm64: dts: qcom: msm8996: Add DMA to QUPs and UARTs
      arm64: dts: qcom: msm8996: Make CPUCC actually probe (and work)
      arm64: dts: qcom: sm8250: Don't disable MDP explicitly
      arm64: dts: qcom: sm8250: Add size/address-cells to dsi[01]
      arm64: dts: qcom: sm8250: Fix pcie2_lane unit address
      arm64: dts: qcom: sm8250: Add GPI DMA nodes
      arm64: dts: qcom: sm8250: Disable Adreno and Venus by default
      arm64: dts: qcom: sm8150: Disable Adreno and modem by default
      arm64: dts: qcom: sm8150: Add support for SONY Xperia 1 / 5 (Kumano platform)
      arm64: dts: qcom: sm8250: Add SDHCI2 sleep mode pinctrl
      arm64: dts: qcom: sm8250: Move gpio.h inclusion to SoC DTSI
      arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)
      arm64: dts: qcom: sm8[12]50-pm8150: Move RESIN to pm8150 dtsi
      arm64: dts: qcom: sm8250-edo: Fix up double "pinctrl-1"
      arm64: dts: qcom: sm8250-edo: Add hardware keys
      arm64: dts: qcom: sm8250: Commonize PCIe pins
      arm64: dts: qcom: sm8250-edo: Enable PCIe
      arm64: dts: qcom: sm8250-edo: Enable ADSP/CDSP/SLPI
      arm64: dts: qcom: sm8250-edo: Enable GPI DMA
      arm64: dts: qcom: sm8250-edo: Add Samsung touchscreen

Konstantin Porotchkin (1):
      arch/arm64/boot/dts/marvell: fix NAND partitioning scheme

Kornel Duleba (1):
      arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges

Krzysztof Kozlowski (17):
      ARM: dts: exynos: align Broadcom WiFi with dtschema
      ARM: dts: exynos: replace legacy MMS114 touchscreen x/y properties in GT-N7100
      ARM: dts: exynos: fix PWM LED max brightness on Odroid XU/XU3
      ARM: dts: exynos: fix PWM LED max brightness on Odroid HC1
      ARM: dts: exynos: fix PWM LED max brightness on Odroid XU4
      ARM: dts: s5pv210: remove unused Atmel touchscreen properties in Goni
      ARM: dts: exynos: enable PMIC wakeup from suspend on Itop Core
      ARM: dts: exynos: enable PMIC wakeup from suspend on Origen4412
      ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale
      ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU
      ARM: dts: exynos: enable PMIC wakeup from suspend on Midas
      ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid X/U3
      ARM: dts: exynos: enable PMIC wakeup from suspend on P4 Note
      ARM: dts: exynos: enable PMIC wakeup from suspend on Arndale Octa
      ARM: dts: exynos: enable PMIC wakeup from suspend on SMDK5420
      ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU3/XU4 family
      arm64: dts: exynos: enable PMIC wakeup from suspend on TM2

Lad Prabhakar (7):
      dt-bindings: arm: renesas: Document Renesas RZ/G2UL SoC
      dt-bindings: arm: renesas: Document Renesas RZ/G2{L,LC} SoC variants
      dt-bindings: arm: renesas: Document SMARC EVK
      dt-bindings: power: renesas,rzg2l-sysc: Add DT binding documentation for SYSC controller
      arm64: dts: renesas: Add initial DTSI for RZ/G2{L,LC} SoC's
      arm64: dts: renesas: Add initial device tree for RZ/G2L SMARC EVK
      arm64: dts: renesas: r9a07g044: Add SYSC node

Li Jun (2):
      arm64: dts: imx8mm-evk: disable over current for usb1
      arm64: dts: imx8mn-evk: disable over current for usb

Liang Chen (3):
      arm64: dts: rockchip: add generic pinconfig settings used by most Rockchip socs
      arm64: dts: rockchip: add core dtsi for RK3568 SoC
      arm64: dts: rockchip: add basic dts for RK3568 EVB

Linus Walleij (11):
      ARM: dts: ixp4xx: Add ethernet
      ARM: dts: ixp4xx: Add PCI hosts
      ARM: dts: ixp4xx: Create a proper expansion bus
      ARM: dts: ixp4xx: Add beeper to the NSLU2
      ARM: dts: ux500: Fix orientation of accelerometer
      ARM: dts: ux500: Drop drdy pin assignment from magnetometer
      ARM: dts: ux500: Fix some compatible strings
      ARM: dts: href: Mount matrices for TVK R2
      ARM: dts: Fix up the IXP4xx ethernet nodes
      ARM: dts: ux500: Fix orientation of Janice accelerometer
      ARM: dts: ixp4xx: Add crypto engine

Loic Poulain (2):
      arm64: dts: qcom: msm8996: Rename speedbin node
      arm64: dts: qcom: msm8996: Add CPU opps

Lokesh Vutla (4):
      ARM: dts: ti: drop usage of redundant compatible
      ARM: dts: ti: Drop usage of ti,am33xx-ecap from DT nodes
      ARM: dts: ti: Fix node name for all ecap dt nodes
      ARM: dts: am33xx: Drop interrupt property from ecap nodes

Lucas Stach (4):
      dt-bindings: imx: gpcv2: add support for optional resets
      arm64: dts: imx8mm: specify dma-ranges
      arm64: dts: imx8mn: specify dma-ranges
      arm64: dts: imx8mq: assign PCIe clocks

Ludovic Desroches (1):
      ARM: dts: at91: sama5d4: fix pinctrl muxing

Lukasz Majewski (1):
      ARM: dts: imx28: Add DTS description of imx28 based XEA board

Marcin Wojtas (1):
      arm64: dts: ensure backward compatibility of the AP807 Xenon

Marek Vasut (6):
      ARM: dts: stm32: Rework LAN8710Ai PHY reset on DHCOM SoM
      ARM: dts: stm32: Remove extra size-cells on dhcom-pdk2
      ARM: dts: stm32: Fix touchscreen node on dhcom-pdk2
      ARM: dts: stm32: Drop unused linux,wakeup from touchscreen node on DHCOM SoM
      ARM: dts: stm32: Rename eth@N to ethernet@N on DHCOM SoM
      ARM: dts: stm32: Rename spi-flash/mx66l51235l@N to flash@N on DHCOM SoM

Martin Blumenstingl (1):
      ARM: dts: meson: Set the fifo-size of uart_A to 128 bytes

Mateusz Kwiatkowski (1):
      ARM: boot: dts: bcm2711: Add BCM2711 VEC compatible

Matthias Kaehlcke (5):
      arm64: dts: qcom: sc7180: lazor: Simplify disabling of charger thermal zone
      arm64: dts: qcom: sc7180: Add pompom rev3
      arm64: dts: qcom: sc7180: Add CoachZ rev3
      arm64: dts: qcom: sc7180: coachz: Add thermal config for skin temperature
      arm64: dts: qcom: pm6150: Add thermal zone for PMIC on-die temperature

Mian Yousaf Kaukab (2):
      arm64: dts: ls1012a: enable PCIe on freeway board
      arm64: dts: ls208xa: remove bus-num from dspi node

Michael Kao (1):
      arm64: dts: mt8183-kukui: Add tboard thermal zones

Michael Srba (1):
      arm64: dts: qcom: msm8916-samsung-a3u: Add touch key regulators

Michal Vokáč (2):
      ARM: dts: imx6dl-yapp4: Configure the OLED display segment offset
      ARM: dts: imx6dl-yapp4: Use aliases to set custom MMC device indexes

Neil Armstrong (10):
      arm64: dts: meson-sm1: add toacodec node
      dt-bindings: arm: amlogic: add Banana PI M5 bindings
      arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts
      arm64: dts: meson: set 128bytes FIFO size on uart A
      arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator
      arm64: dts: meson-sm1-odroid: set tf_io regulator gpio as open source
      arm64: dts: meson-sm1-odroid: add 5v regulator gpio
      arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0
      arm64: dts: meson-sm1-odroid-hc4: add regulators controlled by GPIOH_8
      arm64: dts: meson-sm1-odroid-c4: remove invalid hub_5v regulator

Nicolas Boichat (1):
      arm64: dts: mt8183: Add node for the Mali GPU

Nicolas Ferre (1):
      dt-bindings: i2c: at91: fix example for scl-gpios

Niklas Söderlund (1):
      arm64: dts: renesas: falcon-csi-dsi: Add GPIO extenders

Nishanth Menon (5):
      ARM: dts: keystone: k2g: Rename message-manager node
      ARM: dts: keystone: k2g: Rename the TI-SCI node
      ARM: dts: keystone: k2g: Rename the TI-SCI clocks node name
      ARM: dts: keystone: k2g-evm: Move audio oscillator assigned clock to mcasp
      Merge tag '20210327143117.1840-2-s-anna@ti.com' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc into ti-k3-dts-next

Nobuhiro Iwamatsu (1):
      arm64: dts: visconti: Add PWM support for TMPV7708 SoC

Odelu Kukatla (1):
      arm64: dts: sc7280: Add interconnect provider DT nodes

Oleksij Rempel (8):
      ARM: dts: imx6: edmqmx6: set phy-mode to RGMII-ID
      ARM: dts: imx6dl-riotboard: configure PHY clock and set proper EEE value
      ARM: dts: imx6dl-prtvt7: add TSC2046 touchscreen node
      ARM: dts: imx6dl-prtvt7: Remove backlight enable gpio
      ARM: dts: imx6dl-prtvt7: fix PWM cell count for the backlight node.
      ARM: dts: imx6dl-plym2m: remove touchscreen-size-* properties
      ARM: dts: imx6dl: enable touchscreen debounce filter on PLYM2M and PRTVT7 boards
      ARM: dts: imx6qdl-vicut1: add interrupt-counter nodes

Olof Johansson (40):
      Merge tag 'ixp4xx-dts-v5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik into arm/dt
      Merge tag 'gemini-dts-v5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.14-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'omap-for-v5.14/dt-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/dt
      Merge tag 'amlogic-arm64-dt-for-v5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into arm/dt
      Merge tag 'aspeed-5.14-devicetree' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc into arm/dt
      Merge tag 'samsung-dt-5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/dt
      Merge tag 'stm32-dt-for-v5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into arm/dt
      Merge tag 'arm-soc/for-5.14/devicetree' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'arm-soc/for-5.14/devicetree-arm64' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'ux500-dts-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik into arm/dt
      Merge tag 'juno-fix-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.14-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.14-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'v5.13-next-dts64' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into arm/dt
      Merge tag 'at91-dt-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/dt
      Merge tag 'sunxi-dt-for-5.14-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/dt
      Merge tag 'keystone_dts_for_5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone into arm/dt
      Merge tag 'imx-bindings-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/dt
      Merge tag 'qcom-arm64-for-5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
      Merge tag 'qcom-dts-for-5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
      Merge tag 'visconti-arm-dt-for-v5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti into arm/dt
      Merge tag 'tegra-for-5.14-dt-bindings' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/dt
      Merge tag 'tegra-for-5.14-arm-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/dt
      Merge tag 'tegra-for-5.14-arm64-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/dt
      Merge tag 'mstar-dt-5.14' of git://github.com/linux-chenxing/linux into arm/dt
      Merge tag 'amlogic-arm64-dt-for-v5.14-v2' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into arm/dt
      Merge tag 'amlogic-arm-dt-for-v5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into arm/dt
      Merge tag 'hisi-arm32-dt-for-5.14' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.14' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'omap-for-v5.14/dt-cleanup-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/dt
      Merge tag 'ti-k3-dt-for-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux into arm/dt
      Merge tag 'mvebu-dt64-5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into arm/dt
      Merge tag 'v5.14-rockchip-dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'v5.14-rockchip-dts64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'qcom-arm64-for-5.14-1' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/dt
      Merge tag 'v5.14-rockchip-dts32-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'v5.14-rockchip-dts64-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/dt

Pali Rohár (1):
      arm64: dts: marvell: armada-37xx: move firmware node to generic dtsi file

Patrice Chotard (1):
      ARM: dts: stm32: Configure qspi's mdma transfer to block for stm32mp151

Peter Robinson (5):
      arm64: dts: rockchip: Use only supported PCIe link speed on rk3399
      arm64: dts: rockchip: add SPDIF node for rk3399-firefly
      arm64: dts: rockchip: add infrared receiver node to RK3399 Firefly
      arm64: dts: rockchip: Sort rk3399 firefly pinmux entries
      arm64: dts: rockchip: Add USB-C port details for rk3399 Firefly

Petr Vorel (1):
      arm64: dts: qcom: msm8994-angler: Fix gpio-reserved-ranges 85-88

Primoz Fiser (1):
      ARM: dts: imx6: phyFLEX: Fix UART hardware flow control

Quan Nguyen (3):
      ARM: dts: aspeed: mtjade: Enable OCP card support via NC-SI
      ARM: dts: aspeed: mtjade: Add PSU support
      ARM: dts: aspeed: mtjade: switch to 64MB flash layout

Rafał Miłecki (9):
      ARM: dts: BCM5301X: Fix NAND nodes names
      ARM: brcmstb: dts: fix NAND nodes names
      ARM: Cygnus: dts: fix NAND nodes names
      ARM: NSP: dts: fix NAND nodes names
      ARM: dts: BCM63xx: Fix NAND nodes names
      ARM: dts: Hurricane 2: Fix NAND nodes names
      ARM: dts: BCM5301X: Fix pinmux subnodes names
      dt-bindings: clock: brcm, iproc-clocks: convert to the json-schema
      ARM: dts: BCM5301X: Fixup SPI binding

Rajendra Nayak (2):
      dt-bindings: arm: qcom: Document google,senor board
      arm64: dts: qcom: sc7280: Add "google,senor" to the compatible

Rajeshwari Ravindra Kamble (2):
      arm64: dts: qcom: SC7280: Add device node support for TSENS
      arm64: dts: qcom: SC7280: Add thermal zone support

Richard Zhu (1):
      arm64: dts: imx8mq-evk: add one regulator used to power up pcie phy

Robert Marko (2):
      arm64: dts: qcom: ipq8074: disable USB phy by default
      arm64: dts: ipq8074: Add QUP6 I2C node

Robin van der Gracht (3):
      ARM: dts: imx6dl-prtvt7: Enable the VPU
      ARM: dts: imx6dl-prtvt7: The sgtl5000 uses i2s not ac97
      ARM: dts: imx6dl-prtvt7: Remove unused 'sound-dai-cells' from ssi1 node

Roger Quadros (2):
      arm64: dts: ti: j7200-main: Enable USB2 PHY RX sensitivity workaround
      arm64: dts: ti: k3-am65-main: Add ICSSG MDIO nodes

Roja Rani Yarubandi (1):
      arm64: dts: qcom: sc7180: Remove QUP-CORE ICC path

Romain Perier (1):
      ARM: dts: mstar: Add watchdog device node

Sahil Malhotra (1):
      arm64: dts: ls1028a-rdb: enable optee node

Sameer Pujar (1):
      arm64: tegra: Audio graph sound card for Jetson Xavier NX

Samuel Holland (10):
      dt-bindings: timer: Simplify conditional expressions
      dt-bindings: timer: Add compatibles for sun50i timers
      arm64: dts: allwinner: a64: Sort watchdog node
      arm64: dts: allwinner: Add sun4i MMIO timer nodes
      ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
      ARM: dts: sun8i-a33: Allow using multiple codec DAIs
      arm64: dts: allwinner: a64: Allow using multiple codec DAIs
      arm64: dts: allwinner: a64: Add pinmux nodes for AIF2/AIF3
      arm64: dts: allwinner: a64: Allow multiple DAI links
      arm64: dts: allwinner: pinephone: Add support for Bluetooth audio

Santosh Puranik (1):
      ARM: dts: aspeed: Everest: Fix cable card PCA chips

Sebastian Reichel (5):
      ARM: dts: ux500: Fix interrupt cells
      ARM: dts: ux500: Rename gpio-controller node
      ARM: dts: imx6: Add GE B1x5v2
      dt-bindings: vendor-prefixes: add congatec
      dt-bindings: arm: fsl: add GE B1x5pv2 boards

Serge Semin (1):
      arm64: dts: qcom: Harmonize DWC USB3 DT nodes name

Sergey Senozhatsky (1):
      arm64: dts: qcom: remove camera_mem region

Shaik Sajida Bhanu (2):
      arm64: dts: qcom: sc7180: Add xo clock for eMMC and Sd card
      arm64: dts: qcom: sc7180: bus votes for eMMC and SD card

Shengjiu Wang (4):
      ARM: dts: imx6ul-14x14-evk: Switch to fsl-asoc-card sound card
      ARM: dts: imx7d-sdb: Add HDMI audio sound card
      ARM: dts: imx6qdl-sabresd: Add asrc support for wm8962 sound card
      ARM: dts: imx6qdl-sabresd: Configure the gpio for hp detect

Sibi Sankar (2):
      dt-bindings: mailbox: Add WPSS client index to IPCC
      arm64: dts: qcom: sc7280: Add nodes to boot WPSS

Srinivasa Rao Mandadapu (1):
      arm64: dts: qcom: sc7180: Add wakeup delay for adau codec

Stefan Wahren (7):
      Revert "ARM: dts: bcm283x: increase dwc2's RX FIFO size"
      ARM: dts: bcm283x: Fix up MMC node names
      ARM: dts: Move BCM2711 RPi specific into separate dtsi
      dt-bindings: arm: bcm2835: Add Raspberry Pi 400 to DT schema
      ARM: dts: bcm283x: Fix up GPIO LED node names
      ARM: dts: Add Raspberry Pi 400 support
      arm64: dts: broadcom: Add reference to RPi 400

Stephan Gerhold (9):
      arm64: dts: qcom: msm8916-samsung-a2015: Add touch key
      arm64: dts: qcom: msm8916-samsung-a5u: Add touch key regulator
      arm64: dts: qcom: msm8916-samsung-a2015: Add rt5033 battery
      arm64: dts: qcom: msm8916-samsung-a2015: Add NFC
      arm64: dts: qcom: msm8916: Add device tree for Huawei Ascend G7
      arm64: dts: qcom: msm8916-huawei-g7: Add touchscreen
      arm64: dts: qcom: msm8916-huawei-g7: Add sensors
      arm64: dts: qcom: msm8916-huawei-g7: Add display regulator
      arm64: dts: qcom: msm8916-huawei-g7: Add NFC

Stephen Boyd (6):
      arm64: dts: qcom: trogdor: Add no-hpd to DSI bridge node
      arm64: dts: qcom: c630: Add no-hpd to DSI bridge node
      arm64: dts: qcom: sc7180: Disable PON on Trogdor
      arm64: dts: qcom: sc7180: Remove cros-pd-update on Trogdor
      arm64: dts: qcom: sdm845: Remove cros-pd-update on Cheza
      arm64: dts: qcom: sc7180-trogdor: Update flash freq to match reality

Steven Lee (4):
      ARM: dts: aspeed: ast2600evb: Add sdhci node and gpio regulator for A2 evb.
      ARM: dts: aspeed: ast2600evb: Add phase correction for emmc controller.
      ARM: dts: aspeed: ast2600evb: Add dts file for A1 and A0
      ARM: dts: aspeed-g6: Add pinctrl settings

Sudeep Holla (1):
      arm64: dts: juno: Update SCPI nodes as per the YAML schema

Sujit Kautkar (3):
      arm64: dts: qcom: sc7180: Move rmtfs memory region
      arm64: dts: qcom: sc7180: Move sdc pinconf to board specific DT files
      arm64: dts: qcom: sc7180: SD-card GPIO pin set bias-pull up

Suman Anna (9):
      arm64: dts: ti: k3-am65-iot2050-common: Disable mailbox nodes
      ARM: dts: OMAP2420: Drop interrupt-names from mailbox node
      ARM: dts: OMAP2/OMAP3: Rename processor sub-mailbox nodes
      ARM: dts: AM33xx/AM43xx: Rename wkup_m3 sub-mailbox node
      ARM: dts: OMAP2+: Replace underscores in sub-mailbox node names
      arm64: dts: ti: k3-j721e-main: Add ICSSG MDIO nodes
      arm64: dts: ti: k3-am64-main: Add MAIN domain R5F cluster nodes
      arm64: dts: ti: k3-am642-evm/sk: Add mailboxes to R5Fs
      arm64: dts: ti: k3-am642-evm/sk: Add DDR carveout memory nodes for R5Fs

Taniya Das (2):
      arm64: dts: qcom: sc7280: Add cpufreq hw node
      arm64: dts: qcom: sc7280: Add clock controller nodes

Thierry Reding (4):
      arm64: tegra: Consolidate audio card names
      arm64: tegra: Use correct compatible string for Tegra186 SMMU
      arm64: tegra: Hook up memory controller to SMMU on Tegra186
      arm64: tegra: Enable SMMU support on Tegra194

Tianling Shen (1):
      arm64: dts: rockchip: rename LED label for NanoPi R4S

Tim Harvey (2):
      dt-bindings: arm: imx: add imx8mm gw7901 support
      arm64: dts: imx: Add i.mx8mm Gateworks gw7901 dts support

Timon Baetz (1):
      ARM: dts: exynos: Disable unused camera input for I9100

Tobias Schramm (10):
      dt-bindings: pwm: allwinner: add v3s pwm compatible
      ARM: dts: sun8i: v3s: add pwm controller to v3s dts
      ARM: dts: sun8i: v3s: add DMA controller to v3s dts
      ARM: dts: sun8i: v3s: add DMA properties to peripherals supporting DMA
      ARM: dts: sun8i: v3s: add analog codec and frontend to v3s dts
      ASoC: dt-bindings: sun8i-a23-codec-analog: add compatible for Allwinner V3
      ARM: dts: sun8i: V3: add codec analog frontend to V3 dts
      dt-bindings: sound: sun4i-i2s: add Allwinner V3 I2S compatible
      ARM: dts: sun8i: V3: add I2S interface to V3 dts
      arm64: dts: rockchip: add USB support to rk3308.dtsi

Tomi Valkeinen (1):
      ARM: dts: dra76-evm: remove ov5640

Troy Lee (1):
      ARM: dts: aspeed: Grow u-boot partition 64MiB OpenBMC flash layout

Uwe Kleine-König (5):
      arm64: dts: imx8mp-evk: Add PMIC device
      ARM: dts: imx25-pinfunc: Fix gpio function name for pads GPIO_[A-F]
      arm64: dts: rockchip: Add support for two PWM fans on helios64
      arm64: dts: rockchip: Add support for PCIe on helios64
      arm64: dts: rockchip: Add support for USB on helios64

Valentine Barshak (2):
      arm64: dts: renesas: v3msk: Fix memory size
      arm64: dts: renesas: eagle: Add x1 clock

Vignesh Raghavendra (4):
      ARM: dts: dra7-l4: Drop ti,omap4-uart entry from UART nodes
      ARM: dts: am437x-l4: Drop ti,omap2-uart entry from UART nodes
      ARM: dts: omap2/3: Drop dmas property from I2C node
      arm64: dts: ti: Drop reg-io-width/reg-shift from UART nodes

Vincent Knecht (1):
      arm64: dts: qcom: msm8916-alcatel-idol347: enable touchscreen

Vinod Koul (2):
      arm64: dts: qcom: sm8350: use interconnect enums
      arm64: dts: qcom: sm8350: fix the node unit addresses

Vishwanatha Subbanna (7):
      ARM: dts: aspeed: Everest: Add directly controlled LEDs
      ARM: dts: aspeed: everest: Add system level indicator leds
      ARM: dts: aspeed: everest: Add nvme and fan indicator leds
      ARM: dts: aspeed: everest: Add pcie slot indicator leds
      ARM: dts: aspeed: everest: Add dimm indicator leds
      ARM: dts: aspeed: everest: Add vrm and other indicator leds
      ARM: dts: aspeed: everest: Add pcie cable card indicator leds

Wenchao Han (1):
      arm64: dts: qcom: sc7180: Modify SPI_CLK voltage level for trogdor

Wolfram Sang (2):
      arm64: dts: renesas: condor: Switch eMMC bus to 1V8
      ARM: dts: alt: Add SW2 as GPIO keys

Yassine Oudjana (2):
      arm64: dts: qcom: msm8996: Disable ADSP and add power domains
      arm64: dts: qcom: msm8996: Add usb3 interrupts

Zhen Lei (2):
      arm64: dts: broadcom: normalize the node name of the UART devices
      arm64: dts: freescale: Separate each group of data in the property 'reg'

satya priya (10):
      arm64: dts: qcom: sm8350: Add label for thermal-zones node
      arm64: dts: qcom: pm7325: Add pm7325 base dts file
      arm64: dts: qcom: pm8350c: Add temp-alarm support
      arm64: dts: qcom: pm8350c: Correct the GPIO node
      arm64: dts: qcom: pmr735a: Add temp-alarm support
      arm64: dts: qcom: pmr735a: Correct the GPIO node
      arm64: dts: qcom: pmk8350: Add peripherals for pmk8350
      arm64: dts: qcom: pmk8350: Correct the GPIO node
      arm64: dts: qcom: sc7280: Include PMIC DT files for sc7280-idp
      arm64: dts: qcom: sc7280: Add ADC channel nodes for PMIC temperatures to sc7280-idp


 .../devicetree/bindings/arm/rockchip/pmu.txt    |   16 -
 .../devicetree/bindings/arm/rockchip/pmu.yaml   |   55 +
 .../devicetree/bindings/firmware/qcom,scm.txt   |    1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml     |   11 +-
 .../bindings/phy/phy-rockchip-inno-usb2.yaml    |   11 +-
 .../bindings/power/fsl,imx-gpcv2.yaml           |    3 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml   |    2 +
 .../power/rockchip,power-controller.yaml        |  248 +++
 .../bindings/reset/microchip,rst.yaml           |   58 +
 .../devicetree/bindings/soc/mediatek/pwrap.txt  |    1 +
 .../bindings/soc/qcom/qcom,smd-rpm.yaml         |    2 +
 .../devicetree/bindings/soc/rockchip/grf.txt    |   61 -
 .../devicetree/bindings/soc/rockchip/grf.yaml   |  261 +++
 .../bindings/soc/rockchip/power_domain.txt      |  136 --
 MAINTAINERS                                     |    8 +
 drivers/bus/qcom-ebi2.c                         |    4 +-
 drivers/firmware/Kconfig                        |    3 +-
 drivers/firmware/Makefile                       |    1 +
 drivers/firmware/arm_ffa/Kconfig                |   21 +
 drivers/firmware/arm_ffa/Makefile               |    6 +
 drivers/firmware/arm_ffa/bus.c                  |  210 +++
 drivers/firmware/arm_ffa/common.h               |   31 +
 drivers/firmware/arm_ffa/driver.c               |  731 ++++++++
 drivers/firmware/arm_ffa/smccc.c                |   39 +
 drivers/firmware/arm_scmi/common.h              |    2 +-
 drivers/firmware/arm_scmi/driver.c              |   24 +-
 drivers/firmware/arm_scmi/mailbox.c             |    3 +
 drivers/firmware/arm_scmi/scmi_pm_domain.c      |   26 +
 drivers/firmware/arm_scmi/smc.c                 |    3 +
 drivers/firmware/arm_scpi.c                     |   11 +
 drivers/firmware/qcom_scm.c                     |    3 +
 drivers/firmware/tegra/Makefile                 |    1 +
 drivers/firmware/tegra/bpmp-private.h           |    3 +-
 drivers/firmware/tegra/bpmp-tegra210.c          |    2 +-
 drivers/firmware/tegra/bpmp.c                   |    3 +-
 drivers/firmware/turris-mox-rwtm.c              |   56 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c      |    3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c    |   90 +-
 drivers/iommu/tegra-smmu.c                      |   16 +-
 drivers/memory/atmel-ebi.c                      |    4 +-
 drivers/memory/emif.c                           |  678 -------
 drivers/memory/fsl_ifc.c                        |    8 +-
 drivers/memory/pl353-smc.c                      |    1 +
 drivers/memory/stm32-fmc2-ebi.c                 |    4 +
 drivers/memory/tegra/Kconfig                    |   18 +-
 drivers/memory/tegra/Makefile                   |    6 +-
 drivers/memory/tegra/mc.c                       |  321 ++--
 drivers/memory/tegra/mc.h                       |   25 +
 drivers/memory/tegra/tegra114.c                 | 1245 +++++++------
 drivers/memory/tegra/tegra124-emc.c             |    8 +-
 drivers/memory/tegra/tegra124.c                 | 1306 ++++++++------
 drivers/memory/tegra/tegra186.c                 | 1679 +++++-------------
 drivers/memory/tegra/tegra194.c                 | 1351 ++++++++++++++
 drivers/memory/tegra/tegra20-emc.c              |   52 +-
 drivers/memory/tegra/tegra20.c                  |  110 +-
 drivers/memory/tegra/tegra210-emc-core.c        |    4 -
 drivers/memory/tegra/tegra210.c                 | 1433 ++++++++-------
 drivers/memory/tegra/tegra30-emc.c              |   56 +-
 drivers/memory/tegra/tegra30.c                  | 1292 ++++++++------
 drivers/reset/Kconfig                           |   17 +-
 drivers/reset/Makefile                          |    1 +
 drivers/reset/core.c                            |   25 +-
 drivers/reset/hisilicon/hi6220_reset.c          |    2 +-
 drivers/reset/reset-a10sr.c                     |    1 +
 drivers/reset/reset-bcm6345.c                   |    2 +-
 drivers/reset/reset-berlin.c                    |   12 +-
 drivers/reset/reset-brcmstb.c                   |    1 +
 drivers/reset/reset-lantiq.c                    |    2 +-
 drivers/reset/reset-microchip-sparx5.c          |  146 ++
 drivers/reset/reset-oxnas.c                     |    2 +-
 drivers/reset/reset-ti-syscon.c                 |    4 +-
 drivers/reset/reset-uniphier.c                  |    2 +-
 drivers/reset/reset-zynqmp.c                    |    4 +-
 drivers/reset/sti/reset-syscfg.c                |    2 +-
 drivers/soc/amlogic/meson-ee-pwrc.c             |   46 +-
 drivers/soc/bcm/brcmstb/common.c                |    5 -
 drivers/soc/imx/gpcv2.c                         |  634 +++++--
 drivers/soc/mediatek/mtk-devapc.c               |    1 +
 drivers/soc/mediatek/mtk-pm-domains.c           |   42 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c            |   35 +
 drivers/soc/qcom/rpmhpd.c                       |   21 +
 drivers/soc/qcom/rpmpd.c                        |   22 +
 drivers/soc/qcom/smd-rpm.c                      |    2 +
 drivers/soc/qcom/socinfo.c                      |   56 +-
 drivers/soc/renesas/Kconfig                     |    5 +
 drivers/soc/renesas/renesas-soc.c               |   33 +-
 drivers/soc/rockchip/pm_domains.c               |  252 +--
 drivers/soc/ti/smartreflex.c                    |    4 +-
 drivers/soc/ti/wkup_m3_ipc.c                    |    4 +-
 include/dt-bindings/power/imx8mm-power.h        |   22 +
 include/dt-bindings/power/imx8mn-power.h        |   15 +
 include/dt-bindings/power/qcom-rpmpd.h          |   21 +
 include/dt-bindings/power/rk3568-power.h        |   32 +
 include/linux/arm_ffa.h                         |  267 +++
 include/linux/reset-controller.h                |   22 +
 include/memory/renesas-rpc-if.h                 |    6 +-
 include/soc/tegra/mc.h                          |   65 +-
 97 files changed, 8428 insertions(+), 5174 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 drivers/firmware/arm_ffa/Kconfig
 create mode 100644 drivers/firmware/arm_ffa/Makefile
 create mode 100644 drivers/firmware/arm_ffa/bus.c
 create mode 100644 drivers/firmware/arm_ffa/common.h
 create mode 100644 drivers/firmware/arm_ffa/driver.c
 create mode 100644 drivers/firmware/arm_ffa/smccc.c
 create mode 100644 drivers/memory/tegra/tegra194.c
 create mode 100644 drivers/reset/reset-microchip-sparx5.c
 create mode 100644 include/dt-bindings/power/imx8mm-power.h
 create mode 100644 include/dt-bindings/power/imx8mn-power.h
 create mode 100644 include/dt-bindings/power/rk3568-power.h
 create mode 100644 include/linux/arm_ffa.h
