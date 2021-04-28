Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB036D455
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhD1I7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhD1I7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:59:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE5EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:58:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a22-20020a05600c2256b029014294520f18so3995653wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=jxi3qiC1PJLxVyVbV2falcwmXXe6fvXaeMF3Su2gVU8=;
        b=bwLNKtKCEbqhjqpjGT1vRTF3Xr6LpKYEbMePgbFUp2bn+BZc+DXRBbAouaSahx7V9z
         tN5lfAwFSejJCZflh70HABEoTHyM7pLMBTDcwTBon+XQFu6YaSn4WYAdvw0OezZxvdfs
         gT0cgy7DZ83+tkUVyKC9G3ut/8Hd4YrgcjIS51dFHfKyqmIPoDp1jvIRY5fOG2jkfyts
         wlC0r5dpHvM5rP5EAGgw1rDnFumFPencmje92zSuKr4UGoPSiqQSl+TiuSyox3/Kl4WU
         C1LUOJBPViHDiMjbPPWCo8eOfCOn1MD7SSPkIQ1GziNrUqvuJmPTHzxCvwodU7Pm4UGD
         DkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=jxi3qiC1PJLxVyVbV2falcwmXXe6fvXaeMF3Su2gVU8=;
        b=biDeJiY3TvSkZGtuK3/x4tJEOu6H4S54lftl1miBS1ia+7Mfr4JiI2oPJF2AGFB5xc
         sOGW5odj2xS6xzy1joa+/yS4781yqPR8G38afdRc56DOt3rIxooWCHDU5eQlTn2SWvCW
         XuziZ0S+ix+eHZke0nfyW3tQUKC9zTdKRG+H2CRwHH5+SRCQfE2lNAsMPyZYN7vMHky+
         XVXu4wh2BYM639GA4Ri+624gH+ORnb5bmlgdIw8rMRz78lnpMWVVhdu7p0Qt8gCZBNY3
         TfKHQE7i/QnG6PvJZYSTDUShv42Hje5LtyNCAxi5JBRPQm4P6eeLaERF/KjB/Rk9OwCV
         H3uw==
X-Gm-Message-State: AOAM532A9QzUCuw4w1FefQn27CyJ9VnkpsCLxvMdNhJD9Es8R410LsK9
        hP4ympWzxWtaL4UN12npdmKlxABxfwoWOg==
X-Google-Smtp-Source: ABdhPJxdUGJXintGfXKQhUibw2SDxi9PZUCQGd34KHHxpTsp+jRfduXkNqA2E0eoS7sZH9+Jn7PJ4A==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr30034068wmc.41.1619600307486;
        Wed, 28 Apr 2021 01:58:27 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id b8sm7501850wrx.15.2021.04.28.01.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:58:26 -0700 (PDT)
Date:   Wed, 28 Apr 2021 09:58:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.13
Message-ID: <20210428085825.GH6446@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.13

for you to fetch changes up to f9386c91574fe6da9f4fca9a47734816b0db0019:

  mfd: intel-m10-bmc: Add support for MAX10 BMC Secure Updates (2021-04-14 16:06:57 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Add support for Software Nodes to MFD Core
   - Remove support for Device Properties from MFD Core
   - Use standard APIs in MFD Core

 - New Drivers
   - Add support for ROHM BD9576MUF and BD9573MUF PMICs
   - Add support for Netronix Embedded Controller, PWM and RTC
   - Add support for Actions Semi ATC260x PMICs and OnKey

 - New Device Support
   - Add support for DG1 PCIe Graphics Card to Intel PMT
   - Add support for ROHM BD71815 PMIC to ROHM BD71828
   - Add support for Tolino Shine 2 HD to Netronix Embedded Controller
   - Add support for AX10 BMC Secure Updates to Intel M10 BMC

 - Removed Device Support
   - Remove Arizona Extcon support from MFD
   - Remove ST-E AB8500 Power Supply code from MFD
   - Remove AB3100 altogether

 - New Functionality
   - Add support for SMBus and I2C modes to Dialog DA9063
   - Switch to using Software Nodes in Intel (various)

 - New/converted Device Tree bindings; rohm,bd71815-pmic, rohm,bd9576-pmic,
                                       netronix,ntxec, actions,atc260x,
				       ricoh,rn5t618, qcom-pm8xxx

- Fix-ups
   - Fix error handling/path; intel_pmt
   - Simplify code; rohm-bd718x7, ab8500-core, intel-m10-bmc
   - Trivial clean-ups (reordering, spelling); rohm-generic, rn5t618, max8997
   - Use correct data-type; db8500-prcmu
   - Remove superfluous code; lp87565, intel_quark_i2c_gpi, lpc_sch, twl
   - Use generic APIs/defines; lm3533-core, intel_quark_i2c_gpio
   - Regmap related fix-ups; intel-m10-bmc, sec-core
   - Reorder resource freeing during remove; intel_quark_i2c_gpio
   - Make table indexing more robust; intel_quark_i2c_gpio
   - Fix reference imbalances; arizona-irq
   - Staticify and (un)constify things; arizona-spi, stmpe, ene-kb3930,
                                        intel-lpss-acpi, intel-lpss-pci,
                                        atc260x-i2c, intel_quark_i2c_gpio

 - Bug Fixes
   - Fix incorrect (register) values; intel-m10-bmc
   - Kconfig related fixes; ABX500_CORE
   - Do not clear the Auto Reload Register; stm32-timers

----------------------------------------------------------------
Andreas Kemnade (3):
      dt-bindings: mfd: Convert rn5t618 to json-schema
      mfd: rn5t618: Do not cache various USB related registers
      mfd: ntxec: Support for EC in Tolino Shine 2 HD

Andy Shevchenko (11):
      mfd: intel-lpss: Constify device property structures
      mfd: intel_quark_i2c_gpio: Unregister resources in reversed order
      mfd: intel_quark_i2c_gpio: Remove unused struct device member
      mfd: intel_quark_i2c_gpio: Replace I²C speeds with descriptive definitions
      mfd: intel_quark_i2c_gpio: Reuse BAR definitions for MFD cell indexing
      mfd: intel_quark_i2c_gpio: Enable MSI interrupt
      mfd: intel_quark_i2c_gpio: Don't play dirty trick with const
      mfd: core: Use acpi_find_child_device() for child devices lookup
      mfd: lpc_sch: Partially revert "Add support for Intel Quark X1000"
      mfd: intel_quark_i2c_gpio: Convert I²C to use software nodes
      i2c: designware: Get rid of legacy platform data

Arnd Bergmann (1):
      mfd: Remove support for AB3100

Cristian Ciocaltea (4):
      dt-bindings: input: Add reset-time-sec common property
      dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
      mfd: Add MFD driver for ATC260x PMICs
      input: atc260x: Add onkey driver for ATC260x PMICs

David E. Box (2):
      mfd: intel_pmt: Fix nuisance messages and handling of disabled capabilities
      mfd: intel_pmt: Add support for DG1

Dinghao Liu (1):
      mfd: arizona: Fix rumtime PM imbalance on error

Fabrice Gasnier (1):
      mfd: stm32-timers: Avoid clearing auto reload register

Geert Uytterhoeven (1):
      mfd: Kconfig: ABX500_CORE should depend on ARCH_U8500

Hans de Goede (6):
      mfd: arizona: Drop arizona-extcon cells
      extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
      extcon: arizona: Fix various races on driver unbind
      extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
      extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
      ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c

Heikki Krogerus (3):
      mfd: core: Add support for software nodes
      mfd: intel-lpss: Switch to use the software nodes
      mfd: core: Remove support for dangling device properties

Hubert Streidl (1):
      mfd: da9063: Support SMBus and I2C mode

Jiapeng Chong (1):
      mfd: dbx500-prcmu: Use true and false for bool variable

Jonathan Neuschäfer (6):
      dt-bindings: Add vendor prefix for Netronix, Inc.
      dt-bindings: mfd: Add binding for Netronix embedded controller
      mfd: Add base driver for Netronix embedded controller
      pwm: ntxec: Add driver for PWM function in Netronix EC
      rtc: New driver for RTC in Netronix embedded controller
      MAINTAINERS: Add entry for Netronix embedded controller

Krzysztof Kozlowski (2):
      MAINTAINERS: Move Milo Kim to credits
      mfd: sec: Initialize driver via module_platform_driver()

Lee Jones (3):
      Merge tags 'ib-mfd-clk-gpio-regulator-rtc-v5.13', 'ib-mfd-extcon-v5.13', 'ib-mfd-input-v5.13-1', 'ib-mfd-platform-x86-v5.13', 'ib-mfd-power-v5.13', 'ib-mfd-pwm-rtc-v5.13-1' and 'ib-regulator-list-ramp-helpers-v5.13' into ibs-for-mfd-merged
      Merge tag 'ib-mfd-watchdog-v5.13' into ibs-for-mfd-merged
      dt-bindings: mfd: ricoh,rn5t618: Trivial: Fix spelling mistake of 'additionally'

Linus Walleij (5):
      power: ab8500: Require device tree
      mfd/power: ab8500: Push data to power supply code
      mfd/power: ab8500: Push algorithm to power supply code
      mfd/power: ab8500: Push data to power supply code
      mfd: ab8500: Drop bm disable parameter

Luca Ceresoli (2):
      mfd: lp87565: Remove unused define 'LP87565_NUM_BUCK'
      dt-bindings: mfd: lp875xx: Add optional reset GPIO

Manivannan Sadhasivam (1):
      MAINTAINERS: Add entry for ATC260x PMIC

Matthew Gerlach (1):
      mfd: intel-m10-bmc: Add access table configuration to the regmap

Matti Vaittinen (24):
      dt_bindings: mfd: Add ROHM BD9576MUF and BD9573MUF PMICs
      mfd: Support ROHM BD9576MUF and BD9573MUF
      mfd: bd9576: Add IRQ support
      wdt: Support wdt on ROHM BD9576MUF and BD9573MUF
      MAINTAINERS: Add ROHM BD9576MUF and BD9573MUF drivers
      mfd: bd9576: Add safety limit/monitoring registers
      regulator: helpers: Export helper voltage listing
      regulator: Add regmap helper for ramp-delay setting
      rtc: bd70528: Do not require parent data
      mfd: bd718x7: simplify by cleaning unnecessary device data
      dt_bindings: bd71828: Add clock output mode
      dt_bindings: regulator: Add ROHM BD71815 PMIC regulators
      dt_bindings: mfd: Add ROHM BD71815 PMIC
      mfd: Add ROHM BD71815 ID
      mfd: Sort ROHM chip ID list for better readability
      mfd: Support for ROHM BD71815 PMIC core
      gpio: Support ROHM BD71815 GPOs
      regulator: rohm-regulator: linear voltage support
      regulator: rohm-regulator: Support SNVS HW state.
      regulator: bd718x7, bd71828: Use ramp-delay helper
      regulator: Support ROHM BD71815 regulators
      clk: bd718x7: Add support for clk gate on ROHM BD71815 PMIC
      rtc: bd70528: Support RTC on ROHM BD71815
      MAINTAINERS: Add ROHM BD71815AGW

Rikard Falkeborn (1):
      mfd: stmpe: Revert "Constify static struct resource"

Russ Weight (1):
      mfd: intel-m10-bmc: Add support for MAX10 BMC Secure Updates

Timon Baetz (2):
      mfd: max8997: Replace 8998 with 8997
      Revert "mfd: max8997: Add of_compatible to Extcon and Charger mfd_cell"

Wei Yongjun (3):
      mfd: arizona: Make some symbols static
      mfd: ene-kb3930: Make local symbol 'kb3930_power_off' static
      mfd: Make symbol 'atc260x_i2c_of_match' static

Xu Yilun (4):
      MAINTAINERS: Add entry for Intel MAX 10 mfd driver
      mfd: intel-m10-bmc: Fix the register access range
      mfd: intel-m10-bmc: Simplify the legacy version reg definition
      MAINTAINERS: Add entry for Intel MAX 10 mfd driver

Yang Li (1):
      mfd: lm3533: Switch to using the new API kobj_to_dev()

YueHaibing (1):
      mfd: twl: Remove unused inline function twl4030charger_usb_en()

satya priya (2):
      dt-bindings: mfd: Add compatible for pmk8350 rtc
      dt-bindings: mfd: Convert pm8xxx bindings to yaml

 CREDITS                                            |   3 +
 Documentation/devicetree/bindings/input/input.yaml |   7 +
 .../devicetree/bindings/mfd/actions,atc260x.yaml   | 183 ++++
 .../devicetree/bindings/mfd/netronix,ntxec.yaml    |  76 ++
 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |  99 ---
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  54 ++
 .../devicetree/bindings/mfd/ricoh,rn5t618.yaml     | 111 +++
 Documentation/devicetree/bindings/mfd/rn5t618.txt  |  52 --
 .../devicetree/bindings/mfd/rohm,bd71815-pmic.yaml | 201 +++++
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |   6 +
 .../devicetree/bindings/mfd/rohm,bd9576-pmic.yaml  | 123 +++
 .../devicetree/bindings/mfd/ti,lp87524-q1.yaml     |   4 +
 .../devicetree/bindings/mfd/ti,lp87561-q1.yaml     |   4 +
 .../devicetree/bindings/mfd/ti,lp87565-q1.yaml     |   4 +
 .../bindings/regulator/rohm,bd71815-regulator.yaml | 116 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  74 +-
 drivers/clk/clk-bd718x7.c                          |   9 +-
 drivers/extcon/Kconfig                             |   8 -
 drivers/extcon/Makefile                            |   1 -
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd71815.c                        | 185 ++++
 drivers/i2c/busses/i2c-designware-platdrv.c        |   7 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   2 +-
 drivers/input/misc/atc260x-onkey.c                 | 305 +++++++
 drivers/mfd/Kconfig                                |  82 +-
 drivers/mfd/Makefile                               |   7 +-
 drivers/mfd/ab3100-core.c                          | 929 ---------------------
 drivers/mfd/ab3100-otp.c                           | 240 ------
 drivers/mfd/ab8500-core.c                          |  37 +-
 drivers/mfd/arizona-core.c                         |  20 -
 drivers/mfd/arizona-irq.c                          |   2 +-
 drivers/mfd/arizona-spi.c                          |   4 +-
 drivers/mfd/atc260x-core.c                         | 310 +++++++
 drivers/mfd/atc260x-i2c.c                          |  64 ++
 drivers/mfd/da9063-i2c.c                           |  10 +
 drivers/mfd/ene-kb3930.c                           |   2 +-
 drivers/mfd/intel-lpss-acpi.c                      |  32 +-
 drivers/mfd/intel-lpss-pci.c                       |  46 +-
 drivers/mfd/intel-lpss.c                           |   2 +-
 drivers/mfd/intel-lpss.h                           |   4 +-
 drivers/mfd/intel-m10-bmc.c                        |  30 +-
 drivers/mfd/intel_pmt.c                            | 112 ++-
 drivers/mfd/intel_quark_i2c_gpio.c                 | 112 +--
 drivers/mfd/lm3533-core.c                          |   2 +-
 drivers/mfd/lpc_sch.c                              |  32 +-
 drivers/mfd/max8997.c                              |   4 +-
 drivers/mfd/mfd-core.c                             |  29 +-
 drivers/mfd/ntxec.c                                | 271 ++++++
 drivers/mfd/rn5t618.c                              |   3 +
 drivers/mfd/rohm-bd71828.c                         | 486 ++++++++---
 drivers/mfd/rohm-bd718x7.c                         |  43 +-
 drivers/mfd/rohm-bd9576.c                          | 189 +++++
 drivers/mfd/sec-core.c                             |  14 +-
 drivers/mfd/stm32-timers.c                         |   7 +-
 drivers/mfd/stmpe.c                                |  14 +-
 drivers/platform/x86/intel_pmt_class.c             |  46 +
 drivers/platform/x86/intel_pmt_class.h             |   1 +
 drivers/platform/x86/intel_pmt_telemetry.c         |  20 -
 drivers/power/supply/Kconfig                       |   2 +-
 .../abx500 => drivers/power/supply}/ab8500-bm.h    | 297 ++++++-
 .../power/supply/ab8500-chargalg.h                 |   6 +-
 drivers/power/supply/ab8500_bmdata.c               |   3 +-
 drivers/power/supply/ab8500_btemp.c                |  45 +-
 drivers/power/supply/ab8500_charger.c              |  27 +-
 drivers/power/supply/ab8500_fg.c                   |  20 +-
 drivers/power/supply/abx500_chargalg.c             |  22 +-
 drivers/power/supply/pm2301_charger.c              |   4 +-
 drivers/pwm/Kconfig                                |   8 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-ntxec.c                            | 184 ++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bd71815-regulator.c              | 652 +++++++++++++++
 drivers/regulator/bd71828-regulator.c              |  51 +-
 drivers/regulator/bd718x7-regulator.c              |  60 +-
 drivers/regulator/helpers.c                        | 101 ++-
 drivers/regulator/rohm-regulator.c                 |  23 +-
 drivers/rtc/Kconfig                                |  14 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 104 ++-
 drivers/rtc/rtc-ntxec.c                            | 145 ++++
 drivers/watchdog/Kconfig                           |  13 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bd9576_wdt.c                      | 291 +++++++
 include/linux/mfd/ab3100.h                         | 128 ---
 include/linux/mfd/abx500.h                         | 276 ------
 include/linux/mfd/atc260x/atc2603c.h               | 281 +++++++
 include/linux/mfd/atc260x/atc2609a.h               | 308 +++++++
 include/linux/mfd/atc260x/core.h                   |  58 ++
 include/linux/mfd/core.h                           |   6 +-
 include/linux/mfd/da9063/registers.h               |   3 +
 include/linux/mfd/db8500-prcmu.h                   |   2 +-
 include/linux/mfd/intel-m10-bmc.h                  |  92 +-
 include/linux/mfd/lp87565.h                        |   3 -
 include/linux/mfd/max8997.h                        |   8 +-
 include/linux/mfd/ntxec.h                          |  38 +
 include/linux/mfd/rn5t618.h                        |   1 +
 include/linux/mfd/rohm-bd71815.h                   | 562 +++++++++++++
 include/linux/mfd/rohm-bd71828.h                   |   3 +
 include/linux/mfd/rohm-bd718x7.h                   |  13 -
 include/linux/mfd/rohm-bd957x.h                    | 140 ++++
 include/linux/mfd/rohm-generic.h                   |  17 +-
 include/linux/mfd/twl.h                            |   2 -
 include/linux/platform_data/i2c-designware.h       |  13 -
 include/linux/regulator/driver.h                   |   7 +
 .../soc/codecs/arizona-jack.c                      |  63 +-
 109 files changed, 6467 insertions(+), 2508 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd71815.c
 create mode 100644 drivers/input/misc/atc260x-onkey.c
 delete mode 100644 drivers/mfd/ab3100-core.c
 delete mode 100644 drivers/mfd/ab3100-otp.c
 create mode 100644 drivers/mfd/atc260x-core.c
 create mode 100644 drivers/mfd/atc260x-i2c.c
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/mfd/rohm-bd9576.c
 rename {include/linux/mfd/abx500 => drivers/power/supply}/ab8500-bm.h (58%)
 rename include/linux/mfd/abx500/ux500_chargalg.h => drivers/power/supply/ab8500-chargalg.h (93%)
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/regulator/bd71815-regulator.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 drivers/watchdog/bd9576_wdt.c
 delete mode 100644 include/linux/mfd/ab3100.h
 create mode 100644 include/linux/mfd/atc260x/atc2603c.h
 create mode 100644 include/linux/mfd/atc260x/atc2609a.h
 create mode 100644 include/linux/mfd/atc260x/core.h
 create mode 100644 include/linux/mfd/ntxec.h
 create mode 100644 include/linux/mfd/rohm-bd71815.h
 create mode 100644 include/linux/mfd/rohm-bd957x.h
 delete mode 100644 include/linux/platform_data/i2c-designware.h
 rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (98%)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
