Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF25144F90A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhKNQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:35:35 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:40564 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhKNQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:35:23 -0500
Received: by mail-oo1-f48.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so4927245ooi.7;
        Sun, 14 Nov 2021 08:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xrpDe/ose11cQBJX1Huz22rnXYGgWJuAaBAjrqyhk0U=;
        b=kLJyBogpXnGyXRqzG6MzvXKCpXTZaVubRsmAghvCKxrrNY/Y86wzxbME4f6kP8IdO5
         gEXqEJ5F+oGsmFzROwVKsD2Q3q3oK7rU8Wzr1EaNvxR52vawxUJeJMb7Y5u0o8I9w5OU
         Xn8maEgKnpcyk/6go4l5na5f/0h6JarepwYyrGJnEpY7UOsn8/x/epXRHkPY6sA9L19W
         wiJfUZ3EgrBJoVz73z4GWBjH2oGBBfgCQTUurNezWivm8ri538Zg0WDPxui/xEVkqtiI
         vdGdIIQg+Q0dKdNz7gdrMlQLfw7cx3rFcm5053iIJEe4PHNoVW9eb+l1y6xi0RPMaCdI
         fiKQ==
X-Gm-Message-State: AOAM531GDQdWrzmbKr+sis1yNg3EYnEODYqp6uX467uV7yRexjpb+hMR
        ngrJOL8j1ORCnciaS5GC57nel6YVKg==
X-Google-Smtp-Source: ABdhPJyvW40M14qdyVh3vRdW11Wp7Gd8xyxXMgmf2LUaryASHrhPQYYUMQ96XmOcr1hT9SekpgKSUQ==
X-Received: by 2002:a4a:9609:: with SMTP id q9mr16432785ooi.45.1636907544717;
        Sun, 14 Nov 2021 08:32:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a16sm2414808otj.79.2021.11.14.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:32:24 -0800 (PST)
Received: (nullmailer pid 2882362 invoked by uid 1000);
        Sun, 14 Nov 2021 16:32:23 -0000
Date:   Sun, 14 Nov 2021 10:32:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.16, take 1
Message-ID: <YZE6F+5f4ckFmxZg@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes for 5.16-rc. Most of this was in next, but I had to 
rebase to pickup another schema fix.

Rob


The following changes since commit 5833291ab6de9c3e2374336b51c814e515e8f3a5:

  Merge tag 'pci-v5.16-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2021-11-11 15:10:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.16-1

for you to fetch changes up to 913d3a3f84085e168177ec2ca843403fe2af2838:

  dt-bindings: watchdog: sunxi: fix error in schema (2021-11-11 22:27:27 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.16, take 1:

- 2 fixes due to DT node name changes on Arm, Ltd. boards

- Treewide rename of Ingenic CGU headers

- Update ST email addresses

- Remove Netlogic DT bindings

- Dropping few more cases of redundant 'maxItems' in schemas

- Convert toshiba,tc358767 bridge binding to schema

----------------------------------------------------------------
David Heidelberg (2):
      dt-bindings: i2c: imx: hardware do not restrict clock-frequency to only 100 and 400 kHz
      dt-bindings: watchdog: sunxi: fix error in schema

Geert Uytterhoeven (1):
      bindings: media: venus: Drop redundant maxItems for power-domain-names

Patrice Chotard (5):
      dt-bindings: timer: Update maintainers for st,stm32-timer
      dt-bindings: mfd: timers: Update maintainers for st,stm32-timers
      dt-bindings: media: Update maintainers for st,stm32-cec.yaml
      dt-bindings: media: Update maintainers for st,stm32-hwspinlock.yaml
      dt-bindings: treewide: Update @st.com email address to @foss.st.com

Paul Cercueil (1):
      dt-bindings: Rename Ingenic CGU headers to ingenic,*.h

Rahul T R (1):
      dt-bindings: display: bridge: Convert toshiba,tc358767.txt to yaml

Rob Herring (3):
      of: Support using 'mask' in making device bus id
      clk: versatile: clk-icst: Ensure clock names are unique
      dt-bindings: Remove Netlogic bindings

 Documentation/devicetree/bindings/arm/sti.yaml     |   2 +-
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |   4 +-
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |   4 +-
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   2 +-
 .../devicetree/bindings/clock/ingenic,cgu.yaml     |   2 +-
 .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml |   2 +-
 .../devicetree/bindings/crypto/st,stm32-crc.yaml   |   2 +-
 .../devicetree/bindings/crypto/st,stm32-cryp.yaml  |   2 +-
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  |   2 +-
 .../bindings/display/bridge/snps,dw-mipi-dsi.yaml  |   2 +-
 .../bindings/display/bridge/toshiba,tc358767.txt   |  54 -------
 .../bindings/display/bridge/toshiba,tc358767.yaml  | 158 +++++++++++++++++++++
 .../devicetree/bindings/display/ingenic,ipu.yaml   |   2 +-
 .../devicetree/bindings/display/ingenic,lcd.yaml   |   4 +-
 .../bindings/display/panel/orisetech,otm8009a.yaml |   2 +-
 .../bindings/display/panel/raydium,rm68200.yaml    |   2 +-
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |   4 +-
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |   4 +-
 .../devicetree/bindings/dma/ingenic,dma.yaml       |   2 +-
 .../devicetree/bindings/dma/st,stm32-dma.yaml      |   2 +-
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |   2 +-
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     |   2 +-
 .../devicetree/bindings/gpio/gpio-xlp.txt          |  49 -------
 .../bindings/hwlock/st,stm32-hwspinlock.yaml       |   3 +-
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml |   4 +-
 .../devicetree/bindings/i2c/i2c-xlp9xx.txt         |  22 ---
 .../devicetree/bindings/i2c/ingenic,i2c.yaml       |   2 +-
 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      |   2 +-
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |   2 +-
 .../bindings/iio/adc/sigma-delta-modulator.yaml    |   2 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   2 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |   4 +-
 .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  |   2 +-
 .../interrupt-controller/st,stm32-exti.yaml        |   4 +-
 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml |   4 +-
 .../bindings/media/qcom,sc7280-venus.yaml          |   1 -
 .../devicetree/bindings/media/st,stm32-cec.yaml    |   3 +-
 .../devicetree/bindings/media/st,stm32-dcmi.yaml   |   2 +-
 .../bindings/memory-controllers/ingenic,nemc.yaml  |   2 +-
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |   2 +-
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   2 +-
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |   3 +-
 .../devicetree/bindings/mfd/st,stmfx.yaml          |   2 +-
 .../devicetree/bindings/mfd/st,stpmic1.yaml        |   2 +-
 .../bindings/mips/ingenic/ingenic,cpu.yaml         |   2 +-
 .../devicetree/bindings/mmc/ingenic,mmc.yaml       |   2 +-
 .../devicetree/bindings/mtd/ingenic,nand.yaml      |   2 +-
 .../bindings/mtd/st,stm32-fmc2-nand.yaml           |   2 +-
 .../devicetree/bindings/net/ingenic,mac.yaml       |   2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +-
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   4 +-
 .../bindings/nvmem/ingenic,jz4780-efuse.yaml       |   2 +-
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |   2 +-
 .../devicetree/bindings/phy/ingenic,phy-usb.yaml   |   2 +-
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   2 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   2 +-
 .../bindings/regulator/st,stm32-booster.yaml       |   2 +-
 .../bindings/regulator/st,stm32-vrefbuf.yaml       |   2 +-
 .../bindings/regulator/st,stm32mp1-pwr-reg.yaml    |   2 +-
 .../bindings/remoteproc/ingenic,vpu.yaml           |   2 +-
 .../bindings/remoteproc/st,stm32-rproc.yaml        |   4 +-
 .../devicetree/bindings/rng/ingenic,trng.yaml      |   2 +-
 .../devicetree/bindings/rng/st,stm32-rng.yaml      |   2 +-
 .../devicetree/bindings/rtc/ingenic,rtc.yaml       |   2 +-
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml      |   2 +-
 .../devicetree/bindings/serial/ingenic,uart.yaml   |   2 +-
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   2 +-
 .../devicetree/bindings/sound/cirrus,cs42l51.yaml  |   2 +-
 .../devicetree/bindings/sound/ingenic,aic.yaml     |   2 +-
 .../devicetree/bindings/sound/ingenic,codec.yaml   |   2 +-
 .../devicetree/bindings/sound/st,stm32-i2s.yaml    |   2 +-
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   2 +-
 .../bindings/sound/st,stm32-spdifrx.yaml           |   2 +-
 .../devicetree/bindings/spi/ingenic,spi.yaml       |   2 +-
 Documentation/devicetree/bindings/spi/spi-xlp.txt  |  38 -----
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |   4 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |   4 +-
 .../bindings/thermal/st,stm32-thermal.yaml         |   2 +-
 .../devicetree/bindings/timer/ingenic,sysost.yaml  |   2 +-
 .../devicetree/bindings/timer/ingenic,tcu.yaml     |   2 +-
 .../devicetree/bindings/timer/st,stm32-timer.yaml  |   3 +-
 .../devicetree/bindings/usb/ingenic,musb.yaml      |   2 +-
 .../devicetree/bindings/usb/st,stusb160x.yaml      |   2 +-
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml |   2 -
 .../bindings/watchdog/st,stm32-iwdg.yaml           |   4 +-
 arch/mips/boot/dts/ingenic/jz4725b.dtsi            |   2 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |   2 +-
 arch/mips/boot/dts/ingenic/jz4770.dtsi             |   2 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   2 +-
 arch/mips/boot/dts/ingenic/x1000.dtsi              |   2 +-
 arch/mips/boot/dts/ingenic/x1830.dtsi              |   2 +-
 drivers/clk/ingenic/jz4725b-cgu.c                  |   2 +-
 drivers/clk/ingenic/jz4740-cgu.c                   |   2 +-
 drivers/clk/ingenic/jz4760-cgu.c                   |   2 +-
 drivers/clk/ingenic/jz4770-cgu.c                   |   2 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |   2 +-
 drivers/clk/ingenic/x1000-cgu.c                    |   2 +-
 drivers/clk/ingenic/x1830-cgu.c                    |   2 +-
 drivers/clk/versatile/clk-icst.c                   |   6 +-
 drivers/of/platform.c                              |  10 +-
 .../clock/{jz4725b-cgu.h => ingenic,jz4725b-cgu.h} |   0
 .../clock/{jz4740-cgu.h => ingenic,jz4740-cgu.h}   |   0
 .../clock/{jz4760-cgu.h => ingenic,jz4760-cgu.h}   |   0
 .../clock/{jz4770-cgu.h => ingenic,jz4770-cgu.h}   |   0
 .../clock/{jz4780-cgu.h => ingenic,jz4780-cgu.h}   |   0
 .../clock/{x1000-cgu.h => ingenic,x1000-cgu.h}     |   0
 .../clock/{x1830-cgu.h => ingenic,x1830-cgu.h}     |   0
 107 files changed, 277 insertions(+), 277 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-xlp.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-xlp.txt
 rename include/dt-bindings/clock/{jz4725b-cgu.h => ingenic,jz4725b-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4740-cgu.h => ingenic,jz4740-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4760-cgu.h => ingenic,jz4760-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4770-cgu.h => ingenic,jz4770-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4780-cgu.h => ingenic,jz4780-cgu.h} (100%)
 rename include/dt-bindings/clock/{x1000-cgu.h => ingenic,x1000-cgu.h} (100%)
 rename include/dt-bindings/clock/{x1830-cgu.h => ingenic,x1830-cgu.h} (100%)
