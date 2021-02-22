Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A3321E36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhBVRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:36:30 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39518 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBVRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:36:25 -0500
Received: by mail-oi1-f182.google.com with SMTP id 12so11989942oij.6;
        Mon, 22 Feb 2021 09:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JB+fVv42VaaIcmXsu6yezSEmbv2nk8DPl6KQaLdlAns=;
        b=DZF5McGSjhWMVPG/ZCk1I1NI384fxDIsRaAhdqkhQO/9mWXglriJ0rx8eAtjlNCp8S
         DM2+HrMQX5q4J5+jh7pxQVJ5WfzZR2cNsSog2AXXnofCmfFvMGZ9i/CyTXjwR4vIbYuh
         ZLRn1jW+fIHpiAu813xeHzf2/XGJceKofb4IEfqvNUlwa5jg7tpAC8fCN68DKdgLbrxt
         l/Sg6xRO1j4XJbpttDZEj0dZaWl7zu+aqVmVJMUDBUKZ+7nkjrpUt5GjHsCPzA/lQ/Kq
         RbX5IRmBB0FjkzMA+qWaYqpDAkmeT+B2kFtt/ZOodgBE9kogWsKiuxHCH0j/Ov5fDeHI
         kGGQ==
X-Gm-Message-State: AOAM531kQ/A1h8Ka+eaw21fF3Jydu9/zBk3IzTQLDb+G39EuIKfN9BcT
        qCAP5kuWKMr1QUVZivZVBz/0kQ+flw==
X-Google-Smtp-Source: ABdhPJwODZn/yI5X7lhXevYAF2fYUq+dQ5+U108nR5DvCZQzaoK131xWpe5qE5BlGYW6AgjyqDNpEQ==
X-Received: by 2002:a05:6808:10f:: with SMTP id b15mr16424011oie.92.1614015343113;
        Mon, 22 Feb 2021 09:35:43 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l3sm3835462oil.17.2021.02.22.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 09:35:42 -0800 (PST)
Received: (nullmailer pid 1701536 invoked by uid 1000);
        Mon, 22 Feb 2021 17:35:41 -0000
Date:   Mon, 22 Feb 2021 11:35:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [GIT PULL] Devicetree updates for v5.12
Message-ID: <20210222173541.GA1677515@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v5.12.

I dropped the conflicting changes with the powerpc tree that Michael 
noted.

There's a conflict with the kbuild tree in scripts/Makefile.lib. The 
resolution is use 'always-' instead of 'extra-' everywhere. There's 
another conflict with your tree in ti,k3-am654-cpsw-nuss.yaml. Take 
'description' line from your tree and 'maxItems: 1' from mine. 
linux-next has the correct resolution for both.

Rob


The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.12

for you to fetch changes up to cb8be8b4b27f6eea88268d6991175df1a27e557e:

  driver core: platform: Drop of_device_node_put() wrapper (2021-02-12 19:23:57 -0600)

----------------------------------------------------------------
Devicetree updates for v5.12:

- Sync dtc to upstream version v1.6.0-51-g183df9e9c2b9 and build
  host fdtoverlay

- Add kbuild support to build DT overlays (%.dtbo)

- Drop NULLifying match table in of_match_device(). In preparation for
  this, there are several driver cleanups to use
  (of_)?device_get_match_data().

- Drop pointless wrappers from DT struct device API

- Convert USB binding schemas to use graph schema and remove old plain
  text graph binding doc

- Convert spi-nor and v3d GPU bindings to DT schema

- Tree wide schema fixes for if/then schemas, array size constraints,
  and undocumented compatible strings in examples

- Handle 'no-map' correctly for already reserved memblock regions

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      dt-bindings: usb: Change descibe to describe in usbmisc-imx.txt

Enrico Weigelt, metux IT consult (1):
      of: base: improve error msg in of_phandle_iterator_next()

Geert Uytterhoeven (2):
      dt-bindings: power: renesas,apmu: Group tuples in cpus properties
      dt-bindings: can: rcar_canfd: Group tuples in pin control properties

Georgi Djakov (1):
      dt-bindings: interconnect: Fix the expected number of cells

Iskren Chernev (1):
      dt-bindings: Use portable sort for version cmp

Jonathan Cameron (1):
      dt-bindings:iio:health:ti,afe4404: Fix wrong compatible value.

KarimAllah Ahmed (1):
      fdt: Properly handle "no-map" field in the memory region

Nicolas Boichat (1):
      of/fdt: Make sure no-map does not remove already reserved regions

Rob Herring (14):
      dt-bindings: Add missing array size constraints
      dt-bindings: usb-connector: Use OF graph schema
      dt-bindings: usb: Use OF graph schema
      dt-bindings: Remove plain text OF graph binding
      dt-bindings: iio: dac: Fix AD5686 references
      dt-bindings: thermal: sun8i: Fix misplaced schema keyword in compatible strings
      scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9
      dt-bindings: Fix undocumented compatible strings in examples
      dt-bindings: iommu: renesas,ipmmu-vmsa: Make 'power-domains' conditionally required
      dt-bindings: Fix errors in 'if' schemas
      Merge branch 'dt/dtc-sync' into dt/next
      dt-bindings: mtd: spi-nor: Convert to DT schema format
      of: Remove of_dev_{get,put}()
      driver core: platform: Drop of_device_node_put() wrapper

Russell King (1):
      dt-bindings: ethernet-controller: fix fixed-link specification

Stefan Wahren (1):
      dt-bindings: gpu: Convert v3d to json-schema

Stephen Boyd (6):
      media: renesas-ceu: Use of_device_get_match_data()
      drivers: net: davinci_mdio: Use of_device_get_match_data()
      serial: stm32: Use of_device_get_match_data()
      usb: usb251xb: Use of_device_get_match_data()
      hwmon: (lm70) Use device_get_match_data()
      of/device: Don't NULLify match table in of_match_device() with CONFIG_OF=n

Suman Anna (1):
      dt-bindings: irqchip: Add node name to PRUSS INTC

Viresh Kumar (4):
      scripts: dtc: Fetch fdtoverlay.c from external DTC project
      scripts: dtc: Build fdtoverlay tool
      scripts: dtc: Remove the unused fdtdump.c file
      kbuild: Add support to build overlays (%.dtbo)

 .gitignore                                         |   1 +
 Documentation/devicetree/bindings/Makefile         |   2 +-
 .../socionext/socionext,uniphier-system-cache.yaml |   4 +-
 .../devicetree/bindings/ata/sata_highbank.yaml     |   1 +
 ...ocks.yaml => allwinner,sun9i-a80-usb-clks.yaml} |   4 +-
 .../devicetree/bindings/clock/arm,syscon-icst.yaml |   4 +-
 .../devicetree/bindings/clock/canaan,k210-clk.yaml |   1 +
 .../bindings/connector/usb-connector.yaml          |  17 +-
 .../bindings/crypto/allwinner,sun8i-ce.yaml        |   3 +-
 .../devicetree/bindings/crypto/ti,sa2ul.yaml       |   2 +-
 .../bindings/display/brcm,bcm2711-hdmi.yaml        |   1 +
 .../bindings/display/brcm,bcm2835-hdmi.yaml        |   1 +
 .../bindings/display/brcm,bcm2835-hvs.yaml         |   2 +-
 .../bindings/display/panel/jdi,lt070me05000.yaml   |   1 +
 .../display/panel/mantix,mlaf057we51-x.yaml        |   3 +-
 .../bindings/display/panel/novatek,nt36672a.yaml   |   1 +
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml |   2 +-
 Documentation/devicetree/bindings/eeprom/at25.yaml |   3 +-
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml |   2 +
 .../devicetree/bindings/gpio/gpio-pca95xx.yaml     |   1 +
 .../bindings/gpio/mstar,msc313-gpio.yaml           |   2 +-
 .../devicetree/bindings/gpu/brcm,bcm-v3d.txt       |  33 ----
 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml      |  75 ++++++++
 Documentation/devicetree/bindings/graph.txt        | 129 +------------
 .../bindings/i2c/nuvoton,npcm7xx-i2c.yaml          |   2 +-
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |   2 +
 .../bindings/iio/adc/aspeed,ast2400-adc.yaml       |   1 +
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |   2 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |   1 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   2 +
 .../iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml}   |  10 +-
 .../devicetree/bindings/iio/health/ti,afe4404.yaml |   2 +-
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |   1 +
 .../bindings/iio/potentiometer/adi,ad5272.yaml     |   1 +
 .../input/touchscreen/elan,elants_i2c.yaml         |   1 +
 .../bindings/interconnect/qcom,rpmh.yaml           |   2 +-
 .../bindings/interrupt-controller/fsl,intmux.yaml  |   2 +-
 .../interrupt-controller/st,stm32-exti.yaml        |   2 +
 .../interrupt-controller/ti,pruss-intc.yaml        |   3 +
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |  14 +-
 .../devicetree/bindings/leds/ti,tca6507.yaml       |   1 +
 .../media/allwinner,sun4i-a10-video-engine.yaml    |   1 +
 .../devicetree/bindings/media/i2c/imx219.yaml      |   1 +
 .../bindings/memory-controllers/exynos-srom.yaml   |   2 +
 .../bindings/misc/fsl,dpaa2-console.yaml           |   1 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   2 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   2 +-
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  91 ---------
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml     | 102 ++++++++++
 .../devicetree/bindings/net/can/rcar_canfd.txt     |   2 +-
 .../bindings/net/ethernet-controller.yaml          |   5 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   1 +
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |   1 +
 .../bindings/phy/allwinner,sun4i-a10-usb-phy.yaml  |   2 +
 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml |   2 +
 .../bindings/phy/allwinner,sun50i-h6-usb-phy.yaml  |   2 +
 .../bindings/phy/allwinner,sun5i-a13-usb-phy.yaml  |   2 +
 .../bindings/phy/allwinner,sun6i-a31-usb-phy.yaml  |   2 +
 .../bindings/phy/allwinner,sun8i-a23-usb-phy.yaml  |   2 +
 .../bindings/phy/allwinner,sun8i-a83t-usb-phy.yaml |   2 +
 .../bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   |   2 +
 .../bindings/phy/allwinner,sun8i-r40-usb-phy.yaml  |   2 +
 .../bindings/phy/allwinner,sun8i-v3s-usb-phy.yaml  |   2 +
 .../bindings/phy/allwinner,sun9i-a80-usb-phy.yaml  |  19 +-
 .../devicetree/bindings/phy/brcm,sata-phy.yaml     |   3 +-
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   5 +-
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   2 +-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |   2 +-
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |   2 +-
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |   2 +-
 .../devicetree/bindings/phy/ti,phy-gmii-sel.yaml   |   2 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |   5 +-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |   6 +-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |   2 +-
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml   |   9 +-
 .../devicetree/bindings/power/renesas,apmu.yaml    |   2 +-
 .../devicetree/bindings/power/supply/bq25980.yaml  |   1 +
 .../devicetree/bindings/ptp/ptp-idtcm.yaml         |   4 +-
 .../bindings/remoteproc/ingenic,vpu.yaml           |   2 +-
 .../bindings/remoteproc/ti,omap-remoteproc.yaml    |   3 +
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml |   1 +
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   2 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   2 +
 .../devicetree/bindings/serial/renesas,scifa.yaml  |   2 +
 .../devicetree/bindings/serial/renesas,scifb.yaml  |   2 +
 .../bindings/sound/allwinner,sun4i-a10-codec.yaml  |   1 +
 .../bindings/sound/google,sc7180-trogdor.yaml      |   1 +
 .../bindings/sound/samsung,aries-wm8994.yaml       |   3 +
 .../bindings/sound/samsung,midas-audio.yaml        |   2 +
 .../devicetree/bindings/sound/tas2562.yaml         |   2 +
 .../devicetree/bindings/sound/tas2770.yaml         |   2 +
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |   1 +
 .../devicetree/bindings/spi/renesas,rspi.yaml      |   2 +
 Documentation/devicetree/bindings/sram/sram.yaml   |   2 +
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  12 +-
 .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |   2 +
 .../timer/allwinner,sun5i-a13-hstimer.yaml         |   3 +-
 .../bindings/timer/intel,ixp4xx-timer.yaml         |   2 +-
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     |   2 +-
 .../devicetree/bindings/usb/brcm,usb-pinmap.yaml   |   3 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |   2 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |   2 +-
 .../devicetree/bindings/usb/ingenic,musb.yaml      |   2 +-
 .../devicetree/bindings/usb/renesas,usb3-peri.yaml |   7 +-
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   1 +
 .../devicetree/bindings/usb/ti,hd3ss3220.yaml      |   8 +-
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   3 +-
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |   2 +
 .../devicetree/bindings/usb/usbmisc-imx.txt        |   2 +-
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml   |   4 +-
 Makefile                                           |   5 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   4 +-
 drivers/base/platform.c                            |   2 +-
 drivers/hwmon/lm70.c                               |  20 +-
 drivers/media/platform/renesas-ceu.c               |   2 +-
 drivers/net/ethernet/ibm/emac/core.c               |  15 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |  12 +-
 drivers/of/base.c                                  |   4 +-
 drivers/of/device.c                                |  21 ---
 drivers/of/fdt.c                                   |  12 +-
 drivers/of/platform.c                              |   4 +-
 drivers/of/unittest.c                              |   2 +-
 drivers/tty/serial/stm32-usart.c                   |  71 ++++---
 drivers/tty/serial/stm32-usart.h                   |   2 +-
 drivers/usb/dwc3/dwc3-st.c                         |   2 +-
 drivers/usb/misc/usb251xb.c                        |  12 +-
 include/linux/of_device.h                          |  14 +-
 scripts/Makefile.dtbinst                           |   3 +
 scripts/Makefile.lib                               |   5 +
 scripts/coccinelle/free/put_device.cocci           |   1 -
 scripts/dtc/Makefile                               |   8 +-
 scripts/dtc/data.c                                 |   6 +-
 scripts/dtc/dtc.c                                  |   4 +
 scripts/dtc/dtc.h                                  |   8 +-
 scripts/dtc/fdtdump.c                              | 163 ----------------
 scripts/dtc/fdtoverlay.c                           | 208 +++++++++++++++++++++
 scripts/dtc/flattree.c                             |   8 +-
 scripts/dtc/libfdt/fdt.c                           |   4 +
 scripts/dtc/libfdt/fdt_ro.c                        |  20 +-
 scripts/dtc/libfdt/fdt_rw.c                        |   4 +-
 scripts/dtc/libfdt/fdt_sw.c                        |   2 +-
 scripts/dtc/libfdt/libfdt.h                        | 126 ++++++++-----
 scripts/dtc/libfdt/libfdt_internal.h               |  19 ++
 scripts/dtc/livetree.c                             |   2 +-
 scripts/dtc/srcpos.c                               |   2 +-
 scripts/dtc/update-dtc-source.sh                   |   3 +-
 scripts/dtc/version_gen.h                          |   2 +-
 scripts/dtc/yamltree.c                             |   6 +-
 148 files changed, 825 insertions(+), 711 deletions(-)
 rename Documentation/devicetree/bindings/clock/{allwinner,sun9i-a80-usb-clocks.yaml => allwinner,sun9i-a80-usb-clks.yaml} (95%)
 delete mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
 rename Documentation/devicetree/bindings/iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml} (77%)
 delete mode 100644 Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
 delete mode 100644 scripts/dtc/fdtdump.c
 create mode 100644 scripts/dtc/fdtoverlay.c
