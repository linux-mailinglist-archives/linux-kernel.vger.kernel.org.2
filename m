Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB13BBE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhGEOS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGEOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:18:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB6C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 07:16:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v5so22283511wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=XJnTJS0fASql4DOP5ZjihoYbyo5Le8Rv9x1sYtj4RS0=;
        b=DmaKo8zF/1dgnmSYv6q3LVI6OqbnASqsje0ejcbb0XYRqwr+9fnBcaFJqB7jN3Azsm
         3OUKQeGfuglyAGgoP8JNKfgPA10LQefLQUH8or5wNEdVTUnMYHVz8EnJ6DGl7rukleAg
         W9s/ExJlXlB1PfGs5Ut2sNwYQjrh6B23Blo0XeOd4+vrQrLKtYGMefdPKQNqXRF8KSwu
         HZEUpJiF21xihdlyQ4tV+1uqU2usCQUqc58zs+JwkOHCnknaclylABo/8tybZtvyMnAw
         tYgfmircvhNpZCxBLJq41rz56jDwyIDyKukkcnesJjhSnBALD3pRIyMKbvZ0f3Gt+zjy
         JHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=XJnTJS0fASql4DOP5ZjihoYbyo5Le8Rv9x1sYtj4RS0=;
        b=Q9cMKp/Vf95SA+ryhfmtI59oIJrce3UiNgH2BbRuP+DPQEQTsq7fmpAg2gU3ZXvqIy
         htVk1LJpjjD5tQgt/EiD+QnDlKCqcsE5cGB8F8A0YDY9tmqPrYMzt1rxhVi++OfqmuXl
         75losK7if+8hQSy7dJnok+cTvaPxszYdi50JSA7XS8aE3vrzVTrL4gLe+tBtws5es3vy
         mL2hr+u8bqjXXJ4lG3Q90Nquu8GiA7ScjVp8nv+MHiULR8Sa7U4lXTxj1oYH24fL0Hc9
         DvFPmZ6Dlce9mZeF921ZvFhVWRyb+5qq+8bivH9si+yVIDXJSALFjpn13/VRElVf4ilp
         I7pg==
X-Gm-Message-State: AOAM532OOARp47KTjpUybwvDYnqP48EZ8lpWJXg2hL0Oj+fcRd78tUyh
        LdfYa9P2SliiW2DXAkuKZ3fpcg3aMJ+Xzg==
X-Google-Smtp-Source: ABdhPJyptfrVYq/R8gZad7QplUuQoyz9iHKSf3Q2cHcn0aUYvOyygZANwvQa0RxFywqr7jqhN7GCDg==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr15748468wrv.323.1625494578387;
        Mon, 05 Jul 2021 07:16:18 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id d17sm13433787wro.93.2021.07.05.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:16:17 -0700 (PDT)
Date:   Mon, 5 Jul 2021 15:16:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.14
Message-ID: <YOMUMLdVsCpnWPgM@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.14

for you to fetch changes up to 8a14ded5a8cb7d4146c12f984b5346bffde9b70f:

  mfd: cros_ec: Add peripheral device charger (2021-06-22 12:53:03 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Fix Software Node clean-up code

 - New Drivers
   - Add support for MediaTek MT6359 PMIC
   - Add support for Qualcomm PM8008 PMIC
   - Add support for Richtek RT4831

 - New Device Support
   - Add support for Audio CODECs to Rockchip RK817
   - Add support for Alder Lake-M to Intel LPSS PCI
   - Add support for Periph Device Charge to ChromeOS EC

 - New Functionality
   - Provide additional IRQs; wcd934x
   - Add optional Reset functionality; lp87565

 - Fix-ups
   - Namespacing & visibility; lp87565
   - Differentiate between Power and Home key IRQs; mt6358
   - Export I2C device tables; da9052-i2c, stmpe-i2c
   - Adapt IRQ flags; max8907, rn5t61, max8907
   - Make some functions/devices optional; axp20x, cros_ec_dev
   - Explicitly include used header files; ioc3
   - Remove superfluous lines; MAINTAINERS, sec-core, st,stm32-timers
   - Resolve Kerneldoc issues; omap-usb-host, omap-usb-tll, si476x-cmd, si476x-i2c
   - Convert to a module; arizona-core
   - Copyright changes; hi655x-pmic
   - Drop support for board file initialisation; sec-core
   - Trivial; spelling, whitespace etc; lp87565, si476x-cmd, mt6360-core, wm831x-core,
					twl-core, db8500-prcmu
   - Simplify various implementations; wcd934x, mt6360-core, max8997, max8998,
                                       da9052-i2c, da9062-core, sec-core,
   - Device Tree binding changes; google,cros-ec, richtek,rt4831-backlight,
                                  db8500-prcmu, qcom,pm8008, qcom,spmi-pmic
   - Use provided APIs to simplify; t7l66xb, as3722, da9055-core, tps80031, 88pm800,
                                88pm805, asic3, sun6i-prcm,
				wm831x-core, wm831x-otp,
				ucb1x00-assabet, timberdale, sm501,
				pcf50633-core, kempld-core,
				janz-cmodio, intel_soc_pmic_bxtwc, ab8500-core

 - Bug Fixes
   - Fix unused variable warning; rk817_codec
   - Fix regulator voltage configuration; rohm-bd71828
   - Fix ongoing freeing of regmap_config 'name' issue; syscon
   - Fix error handling path; da9063-i2c
   - Fix Kconfig issues; MFD_MP2629
   - Fix DMA mask warnings; motorola-cpcap

----------------------------------------------------------------
Alexandre Torgue (1):
      dt-bindings: mfd: stm32-timers: Remove #address/size cells from required properties

Andre Przywara (1):
      mfd: axp20x: Allow AXP 806 chips without interrupt lines

Andreas Kemnade (1):
      mfd: rn5t618: Fix IRQ trigger by changing it to level mode

Andy Shevchenko (2):
      mfd: intel-lpss: Add Intel Alder Lake-M PCI IDs
      mfd: Remove software node conditionally and locate at right place

Axel Lin (1):
      mfd: bd71828: Fix .n_voltages settings

ChiYuan Huang (3):
      backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight
      mfd: rt4831: Adds support for Richtek RT4831
      mfd: rt4831: Adds DT binding document for Richtek RT4831

Chris Morgan (4):
      mfd: Add Rockchip rk817 audio CODEC support
      ASoC: Add Rockchip rk817 audio CODEC support
      dt-bindings: Add Rockchip rk817 audio CODEC support
      ASoC: rk817: fix a warning in rk817_probe()

Daisuke Nojiri (1):
      mfd: cros_ec: Add peripheral device charger

Gene Chen (10):
      mfd: mt6360: Rearrange include file
      mfd: mt6360: Remove redundant brackets around raw numbers
      mfd: mt6360: Indicate sub-dev compatible name by using "-"
      mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360 regulator resources
      mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
      mfd: mt6360: Rename mt6360_pmu by mt6360
      mfd: mt6360: Remove handle_post_irq callback function
      mfd: mt6360: Fix flow which is used to check ic exist
      mfd: mt6360: Merge header file into driver and remove unuse register define
      mfd: mt6360: Merge different sub-devices I2C read/write

Guru Das Srinagesh (3):
      dt-bindings: mfd: pm8008: Add IRQ listing
      dt-bindings: mfd: pm8008: Add bindings
      mfd: pm8008: Add driver for QCOM PM8008 PMIC

Gwendal Grignou (1):
      mfd: cros_ec_dev: Load lightbar module only present

Hans de Goede (1):
      mfd: arizona: Allow building arizona MFD-core as module

Hao Fang (1):
      mfd: hisilicon: Use the correct HiSilicon copyright

Hsin-Hsiung Wang (6):
      mfd: mt6358: Refine interrupt code
      rtc: mt6397: refine RTC_TC_MTH
      dt-bindings: mfd: Add compatible for the MediaTek MT6359 PMIC
      dt-bindings: regulator: Add document for MT6359 regulator
      mfd: Add support for the MediaTek MT6359 PMIC
      regulator: mt6359: Add support for MT6359P regulator

Ikjoon Jang (1):
      mfd: google,cros-ec: add DT bindings for a baseboard's switch device

Jian Dong (1):
      mfd: si476x-cmd: Fix two typos of 'returned'

Krzysztof Kozlowski (11):
      mfd: max8997: Simplify getting of_device_id match data
      mfd: max8998: Simplify getting of_device_id match data
      mfd: da9052: Simplify getting of_device_id match data
      mfd: da9062: Simplify getting of_device_id match data
      mfd: sec: Simplify getting of_device_id match data
      mfd: sec: Drop support for board files and require devicetree
      mfd: sec: Remove unused cfg_pmic_irq in platform data
      mfd: sec: Remove unused device_type in platform data
      mfd: sec: Remove unused irq_base in platform data
      mfd: sec: Enable wakeup from suspend via devicetree property
      mfd: sec: Remove unused platform data members

Lee Jones (9):
      Merge tags 'tb-mfd-asoc-v5.14-1', 'tb-mfd-gpio-regulator-v5.14' and 'tb-mfd-regulator-rtc-v5.14' into ibs-for-mfd-merged
      Revert "MAINTAINERS: Add entry for Intel MAX 10 mfd driver"
      mfd: wm831x-core: Fix incorrect function name wm831x_reg_unlock()
      mfd: twl-core: Fix incorrect function name twl_regcache_bypass()
      mfd: db8500-prcmu: Fix multiple incorrectly documented function names
      mfd: omap-usb-host: File headers are not good candidates for kernel-doc
      mfd: omap-usb-tll: File headers are not good candidates for kernel-doc
      mfd: si476x-cmd: Fix a bunch of incorrectly documented function names
      mfd: si476x-i2c: Fix incorrectly documented function names

Limeng (1):
      mfd: syscon: Free the allocated name field of struct regmap_config

Linus Walleij (1):
      mfd: db8500-prcmu: Add devicetree bindings

Luca Ceresoli (3):
      mfd: lp87565: Fix typo in define names
      mfd: lp87565: Move LP87565_regulator_id to .c file
      mfd: lp87565: Handle optional reset pin

Marc Zyngier (1):
      mfd: ioc3: Directly include linux/irqdomain.h

Mattijs Korpershoek (3):
      mfd: mt6397: Add MT6358 register definitions for power key
      mfd: mt6397: Use named IRQs instead of index (keys)
      mfd: mt6397: Add PMIC keys for MT6358

Randy Dunlap (1):
      mfd: mp2629: Select MFD_CORE to fix build error

Sergey Larin (1):
      mfd: max8907: Remove IRQF_NO_AUTOEN flag

Srinivas Kandagatla (2):
      mfd: wcd934x: Add macro for adding new interrupts
      mfd: wcd934x: Add additional interrupts required for MBHC support

Tian Tao (1):
      mfd: max8907: Move to use request_irq by IRQF_NO_AUTOEN flag

Tony Lindgren (1):
      mfd: cpcap: Fix cpcap dmamask not set warnings

Wen Su (1):
      regulator: mt6359: Add support for MT6359 regulator

Wolfram Sang (1):
      mfd: da9063: Propagate errno when I2C mode fails

Zhen Lei (18):
      mfd: t7l66xb: Use DEFINE_RES_MEM() and DEFINE_RES_IRQ() to simplify code
      mfd: as3722: Use DEFINE_RES_IRQ_NAMED() to simplify code
      mfd: da9055: Use DEFINE_RES_IRQ_NAMED() to simplify code
      mfd: tps80031: Use DEFINE_RES_IRQ() to simplify code
      mfd: 88pm800: Use DEFINE_RES_IRQ_NAMED() to simplify code
      mfd: 88pm805: Use DEFINE_RES_IRQ_NAMED() to simplify code
      mfd: asic3: Use DEFINE_RES_MEM() and DEFINE_RES_IRQ() to simplify code
      mfd: sun6i-prcm: Use DEFINE_RES_MEM() to simplify code
      mfd: wm831x: Use DEFINE_RES_IRQ_NAMED() and DEFINE_RES_IRQ() to simplify code
      mfd: wm831x: Use DEVICE_ATTR_RO macro
      mfd: ucb1x00-assabet: Use DEVICE_ATTR_RO macro
      mfd: timberdale: Use DEVICE_ATTR_RO macro
      mfd: sm501: Use DEVICE_ATTR_RO macro
      mfd: pcf50633: Use DEVICE_ATTR_ADMIN_RO macro
      mfd: kempld-core: Use DEVICE_ATTR_RO macro
      mfd: janz-cmodio: Use DEVICE_ATTR_RO macro
      mfd: intel_soc_pmic_bxtwc: Use DEVICE_ATTR_ADMIN_RW macro
      mfd: ab8500-core: Use DEVICE_ATTR_RO/RW macro

Zou Wei (1):
      mfd: da9052/stmpe: Add and modify MODULE_DEVICE_TABLE

satya priya (1):
      mfd: qcom-spmi-pmic: Add support for four variants

 .../leds/backlight/richtek,rt4831-backlight.yaml   |   62 ++
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   20 +
 Documentation/devicetree/bindings/mfd/mt6397.txt   |    1 +
 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  121 +++
 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |    4 +
 .../devicetree/bindings/mfd/richtek,rt4831.yaml    |   90 ++
 Documentation/devicetree/bindings/mfd/rk808.txt    |  188 ++++
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |    2 -
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      |  278 ++++++
 .../bindings/regulator/mt6359-regulator.yaml       |  385 ++++++++
 MAINTAINERS                                        |   10 -
 drivers/gpio/gpio-lp87565.c                        |    6 +-
 drivers/mfd/88pm800.c                              |   14 +-
 drivers/mfd/88pm805.c                              |   29 +-
 drivers/mfd/Kconfig                                |   29 +-
 drivers/mfd/Makefile                               |   16 +-
 drivers/mfd/ab8500-core.c                          |   33 +-
 drivers/mfd/arizona-core.c                         |    2 +
 drivers/mfd/as3722.c                               |   14 +-
 drivers/mfd/asic3.c                                |   12 +-
 drivers/mfd/axp20x.c                               |   24 +-
 drivers/mfd/cros_ec_dev.c                          |   21 +-
 drivers/mfd/da9052-i2c.c                           |   10 +-
 drivers/mfd/da9055-core.c                          |   38 +-
 drivers/mfd/da9062-core.c                          |   13 +-
 drivers/mfd/da9063-i2c.c                           |    2 +-
 drivers/mfd/db8500-prcmu.c                         |    6 +-
 drivers/mfd/hi655x-pmic.c                          |    2 +-
 drivers/mfd/intel-lpss-pci.c                       |   13 +
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |   20 +-
 drivers/mfd/ioc3.c                                 |    1 +
 drivers/mfd/janz-cmodio.c                          |    6 +-
 drivers/mfd/kempld-core.c                          |   19 +-
 drivers/mfd/lp87565.c                              |   27 +
 drivers/mfd/max8907.c                              |    8 +-
 drivers/mfd/max8997.c                              |    9 +-
 drivers/mfd/max8998.c                              |    8 +-
 drivers/mfd/mfd-core.c                             |   15 +-
 drivers/mfd/motorola-cpcap.c                       |    4 +
 drivers/mfd/mt6358-irq.c                           |   89 +-
 drivers/mfd/mt6360-core.c                          |  552 +++++++----
 drivers/mfd/mt6397-core.c                          |   44 +-
 drivers/mfd/omap-usb-host.c                        |    2 +-
 drivers/mfd/omap-usb-tll.c                         |    2 +-
 drivers/mfd/pcf50633-core.c                        |   12 +-
 drivers/mfd/qcom-pm8008.c                          |  260 +++++
 drivers/mfd/rk808.c                                |   81 ++
 drivers/mfd/rn5t618.c                              |    2 +-
 drivers/mfd/rt4831.c                               |  115 +++
 drivers/mfd/sec-core.c                             |   70 +-
 drivers/mfd/sec-irq.c                              |    4 +-
 drivers/mfd/si476x-cmd.c                           |   28 +-
 drivers/mfd/si476x-i2c.c                           |   10 +-
 drivers/mfd/sm501.c                                |    8 +-
 drivers/mfd/stmpe-i2c.c                            |    2 +-
 drivers/mfd/sun6i-prcm.c                           |   30 +-
 drivers/mfd/syscon.c                               |    2 +-
 drivers/mfd/t7l66xb.c                              |   12 +-
 drivers/mfd/timberdale.c                           |    6 +-
 drivers/mfd/tps80031.c                             |    6 +-
 drivers/mfd/twl-core.c                             |    2 +-
 drivers/mfd/ucb1x00-assabet.c                      |    2 +-
 drivers/mfd/wcd934x.c                              |   50 +-
 drivers/mfd/wm831x-core.c                          |  250 +----
 drivers/mfd/wm831x-otp.c                           |    6 +-
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/lp87565-regulator.c              |   11 +
 drivers/regulator/mt6359-regulator.c               | 1036 ++++++++++++++++++++
 drivers/rtc/rtc-mt6397.c                           |    2 +-
 include/dt-bindings/leds/rt4831-backlight.h        |   23 +
 include/dt-bindings/mfd/qcom-pm8008.h              |   19 +
 include/linux/mfd/hi655x-pmic.h                    |    2 +-
 include/linux/mfd/lp87565.h                        |   40 +-
 include/linux/mfd/mt6358/core.h                    |    8 +-
 include/linux/mfd/mt6358/registers.h               |    2 +
 include/linux/mfd/mt6359/core.h                    |  133 +++
 include/linux/mfd/mt6359/registers.h               |  529 ++++++++++
 include/linux/mfd/mt6359p/registers.h              |  249 +++++
 include/linux/mfd/mt6360.h                         |  240 -----
 include/linux/mfd/mt6397/core.h                    |    1 +
 include/linux/mfd/mt6397/rtc.h                     |    1 +
 include/linux/mfd/rk808.h                          |   81 ++
 include/linux/mfd/rohm-bd71828.h                   |   10 +-
 include/linux/mfd/samsung/core.h                   |   33 -
 include/linux/regulator/mt6359-regulator.h         |   59 ++
 sound/soc/codecs/Kconfig                           |   16 +-
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/rk817_codec.c                     |  538 ++++++++++
 89 files changed, 5149 insertions(+), 1105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
 create mode 100644 drivers/mfd/qcom-pm8008.c
 create mode 100644 drivers/mfd/rt4831.c
 create mode 100644 drivers/regulator/mt6359-regulator.c
 create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
 create mode 100644 include/dt-bindings/mfd/qcom-pm8008.h
 create mode 100644 include/linux/mfd/mt6359/core.h
 create mode 100644 include/linux/mfd/mt6359/registers.h
 create mode 100644 include/linux/mfd/mt6359p/registers.h
 delete mode 100644 include/linux/mfd/mt6360.h
 create mode 100644 include/linux/regulator/mt6359-regulator.h
 create mode 100644 sound/soc/codecs/rk817_codec.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
