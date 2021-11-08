Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944CD44995F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbhKHQWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbhKHQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:22:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41DEC061746
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 08:19:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b12so27862554wrh.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=/LJlE5nQtR8QF3JJiUgvc2WbEkpRXdhLKY+fxxTXfRk=;
        b=W1cMUKQkqrWNZihjmr1992OlCZQ/qp/JkHRReZWu/hjHsbC285UCvDxT7KduYDf0MZ
         zF24xZvuDNi4k+PKaveqaR3ao3RFTnP+vJ1B3PPCZjXgY9WFnjbI9RpUH7LIJMcY1lzG
         t67IzVPEx1y/CYwmTgAalXOoT3kggwJYce/pVZiUkGQGadwD3YJVDa7Kf3JXDToJFV57
         bltnF54ZZBSu+GT7PGK06Tha8vk+vtPrdjMKog7eKBF+8y++QWss+DD/P0nR6M/h07Z3
         yYNgtyda6N60R5qguzVuNg3PHO/d9+fkNVtwnSqoof8rU20R/pa/9BPSRcVRNSvxcNIN
         H+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=/LJlE5nQtR8QF3JJiUgvc2WbEkpRXdhLKY+fxxTXfRk=;
        b=vxNygLq9NQy4tHTrWhIhYEq+fT3uFTx9o7xNzRwyaM5zD7nQtaNXKK7Vzx+9pS2IZu
         YSg4FzKZ34HgC7awQ5+RA9fcSdu7fncl6G67wXugGKhsX59NuKNVtqrPKOprnYLTYfx+
         kUS4U1TxvwMhWiLF1mAlMk5gQWm7aS8CZ1FuxaBEG04iQfLipdWcKxiW3OGojVbVz8q6
         LLM6l5gMToO++LarnI1SShdwHZwjmrhwws+9c/H7xBCCFEZW8a/Th92REm4Ctc0fRo6v
         0LBe0nPgyRjww+SDPFVxPS8l6XE5jAlULMnlzBbMFm1RdJ0rBkIgSkf5r6VYQhIR5pfz
         /4iw==
X-Gm-Message-State: AOAM5307rp2vepdnbNqUZdCQH53TNEIfS2zDoj06pPBl3qQkkDg3WscI
        NX9BS0B7OztTNJOWS++EOOFtDfwiO0J0tg==
X-Google-Smtp-Source: ABdhPJypc4l7Zo+XDyeHCiegso+E3OE9ErygzAqExfY3JASqlMPsR9cKV1Ed96O72hqRIrERvim2IA==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr466009wrj.84.1636388390149;
        Mon, 08 Nov 2021 08:19:50 -0800 (PST)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id n7sm17013893wra.37.2021.11.08.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 08:19:49 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:19:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.16
Message-ID: <YYlOHmhpII5vIbxL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.16

for you to fetch changes up to 5dc6dafe62099ade0e7232ce9db4013b7673d860:

  mfd: simple-mfd-i2c: Select MFD_CORE to fix build error (2021-11-05 14:40:28 +0000)

----------------------------------------------------------------
 - Remove Drivers
   - Remove support for TI TPS80031/TPS80032 PMICs

 - New Device Support
   - Add support for Magnetic Reader to TI AM335x
   - Add support for DA9063_EA to Dialog DA9063
   - Add support for SC2730 PMIC to Spreadtrum SC27xx
   - Add support for MacBookPro16,2 ICL-N UART Intel LPSS PCI
   - Add support for lots of new PMICS in QCom SPMI PMIC
   - Add support for ADC to Diolan DLN2

 - New Functionality
   - Add support for Power Off to Rockchip RK817

 - Fix-ups
   - Simplify Regmap passing to child devices; hi6421-spmi-pmic
   - SPDX licensing updates; ti_am335x_tscadc
   - Improve error handling; ti_am335x_tscadc
   - Expedite clock search; ti_am335x_tscadc
   - Generic simplifications; ti_am335x_tscadc
   - Use generic macros/defines; ti_am335x_tscadc
   - Remove unused code; ti_am335x_tscadc, cros_ec_dev
   - Convert to GPIOD; wcd934x
   - Add namespacing; ti_am335x_tscadc
   - Restrict compilation to relevant arches; intel_pmt
   - Provide better description/documentation; exynos_lpass
   - Add SPI device ID table; altera-a10sr, motorola-cpcap, sprd-sc27xx-spi
   - Change IRQ handling; qcom-pm8xxx
   - Split out I2C and SPI code; arizona
   - Explicitly include used headers; altera-a10sr
   - Convert sysfs show() function to; sysfs_emit
   - Standardise *_exit() and *_remove() return values; mc13xxx, stmpe, tps65912
   - Trivial (style/spelling/whitespace) fixups; ti_am335x_tscadc, qcom-spmi-pmic,
                                                 max77686-private
   - Device Tree fix-ups; ti,am3359-tscadc, samsung,s2mps11, samsung,s2mpa01,
                          samsung,s5m8767, brcm,misc, brcm,cru, syscon, qcom,tcsr,
			  xylon,logicvc, max77686, x-powers,ac100, x-powers,axp152,
			  x-powers,axp209-gpio, syscon, qcom,spmi-pmic

 - Bug Fixes
   - Balance refcounting (get/put); ti_am335x_tscadc, mfd-core
   - Fix IRQ trigger type; sec-irq, max77693, max14577
   - Repair off-by-one; altera-sysmgr
   - Add explicit 'select MFD_CORE' to MFD_SIMPLE_MFD_I2C

----------------------------------------------------------------
Arnd Bergmann (1):
      mfd: altera-a10sr: Include linux/module.h

Baruch Siach (1):
      dt-bindings: mfd: qcom,tcsr: Document ipq6018 compatible

Bjorn Andersson (4):
      mfd: qcom-spmi-pmic: Sort the compatibles in the binding
      mfd: qcom-spmi-pmic: Sort compatibles in the driver
      mfd: qcom-spmi-pmic: Document ten more PMICs in the binding
      mfd: qcom-spmi-pmic: Add missing PMICs supported by socinfo

Carlos de Paula (1):
      mfd: da9063: Add support for latest EA silicon revision

Chanho Park (1):
      dt-bindings: mfd: syscon: Add samsung,exynosautov9-sysreg compatible

Charles Keepax (1):
      mfd: arizona: Split of_match table into I2C and SPI versions

Chunyan Zhang (1):
      mfd: sprd: Add support for SC2730 PMIC

Colin Ian King (1):
      mfd: ti_am335x_tscadc: Fix spelling mistake "atleast" -> "at least"

David Heidelberg (1):
      dt-bindings: mfd: qcom: pm8xxx: Add pm8018 compatible

Dmitry Baryshkov (1):
      mfd: qcom-pm8xxx: switch away from using chained IRQ handlers

Dmitry Osipenko (1):
      mfd: tps80031: Remove driver

Heiko Stuebner (1):
      dt-bindings: mfd: syscon: Add rk3368 QoS register compatible

Jack Andersen (1):
      mfd: dln2: Add cell for initializing DLN2 ADC

Kai Song (1):
      mfd: altera-sysmgr: Fix a mistake caused by resource_size conversion

Krzysztof Kozlowski (17):
      regulator: s5m8767: do not use reset value as DVS voltage if GPIO DVS is disabled
      regulator: dt-bindings: samsung,s5m8767: correct s5m8767,pmic-buck-default-dvs-idx property
      dt-bindings: clock: samsung,s2mps11: convert to dtschema
      regulator: dt-bindings: samsung,s2m: convert to dtschema
      regulator: dt-bindings: samsung,s2mpa01: convert to dtschema
      regulator: dt-bindings: samsung,s5m8767: convert to dtschema
      dt-bindings: mfd: samsung,s2mps11: Convert to dtschema
      dt-bindings: mfd: samsung,s2mpa01: Convert to dtschema
      dt-bindings: mfd: samsung,s5m8767: Convert to dtschema
      dt-bindings: mfd: samsung,s5m8767: Document buck and LDO supplies
      mfd: cros_ec: Drop unneeded MODULE_ALIAS
      mfd: sec-irq: Do not enforce (incorrect) interrupt trigger type
      mfd: max77686: Do not enforce (incorrect) interrupt trigger type
      mfd: max77693: Do not enforce (incorrect) interrupt trigger type
      mfd: max14577: Do not enforce (incorrect) interrupt trigger type
      mfd: core: Add missing of_node_put for loop iteration
      mfd: exynos-lpass: Describe driver in KConfig

Lee Jones (2):
      Merge tag 'tags/s2m_s5m_dtschema' into tb-mfd-from-regulator-5.16
      Merge branches 'ib-mfd-iio-touchscreen-clk-5.16', 'ib-mfd-misc-regulator-5.16' and 'tb-mfd-from-regulator-5.16' into ibs-for-mfd-merged

Luca Ceresoli (1):
      mfd: max77686: Correct tab-based alignment of register addresses

Mark Brown (3):
      mfd: altr_a10sr: Add SPI device ID table
      mfd: cpcap: Add SPI device ID table
      mfd: sprd: Add SPI device ID table

Mauro Carvalho Chehab (1):
      mfd: hi6421-spmi-pmic: Cleanup drvdata to only include regmap

Maxime Ripard (3):
      dt-bindings: mfd: Convert X-Powers AC100 binding to a schema
      dt-bindings: mfd: Convert X-Powers AXP binding to a schema
      dt-bindings: gpio: Convert X-Powers AXP209 GPIO binding to a schema

Maíra Canal (1):
      mfd: wcd934x: Replace legacy gpio interface for gpiod

Miquel Raynal (45):
      clk: ti: am43xx: Add clkctrl data for am43xx ADC1
      dt-bindings: mfd: ti,am3359-tscadc: Add a yaml description for this MFD
      dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
      dt-bindings: iio: adc: ti,am3359-adc: New yaml description
      dt-bindings: touchscreen: ti,am3359-tsc: Remove deprecated text file
      dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
      dt-bindings: iio: adc: ti,am3359-adc: Describe am4372 ADC compatible
      mfd: ti_am335x_tscadc: Ensure a balanced number of node get/put
      mfd: ti_am335x_tscadc: Replace license text with SPDX tag
      mfd: ti_am335x_tscadc: Fix style
      mfd: ti_am335x_tscadc: Get rid of useless gotos
      mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack variables
      mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
      mfd: ti_am335x_tscadc: Don't search the tree for our clock
      mfd: ti_am335x_tscadc: Simplify divisor calculation
      mfd: ti_am335x_tscadc: Move the driver structure allocation earlier
      mfd: ti_am335x_tscadc: Use driver data
      mfd: ti_am335x_tscadc: Mimic the probe from resume()
      mfd: ti_am335x_tscadc: Drop useless variables from the driver structure
      mfd: ti_am335x_tscadc: Always provide an idle configuration
      mfd: ti_am335x_tscadc: Reorder the initialization steps
      mfd: ti_am335x_tscadc: Gather the ctrl register logic in one place
      mfd: ti_am335x_tscadc: Replace the header license text with SPDX tag
      mfd: ti_am335x_tscadc: Fix header spacing
      mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ macro
      mfd: ti_am335x_tscadc: Drop unused definitions from the header
      mfd: ti_am335x_tscadc: Use BIT(), GENMASK() and FIELD_PREP() when relevant
      mfd: ti_am335x_tscadc: Clarify the maximum values for DT entries
      mfd: ti_am335x_tscadc: Drop useless definitions from the header
      mfd: ti_am335x_tscadc: Rename the subsystem enable macro
      mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
      mfd: ti_am335x_tscadc: Rename a variable
      mfd: ti_am335x_tscadc: Fix an error message
      mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a touchscreen
      mfd: ti_am335x_tscadc: Introduce a helper to deal with the type of hardware
      mfd: ti_am335x_tscadc: Add ADC1/magnetic reader support
      mfd: ti_am335x_tscadc: Support the correctly spelled DT property
      iio: adc: ti_am335x_adc: Wait the idle state to avoid stalls
      iio: adc: ti_am335x_adc: Replace license text with SPDX tag
      iio: adc: ti_am335x_adc: Fix style
      iio: adc: ti_am335x_adc: Get rid of useless gotos
      iio: adc: ti_am335x_adc: Gather the checks on the delays
      iio: adc: ti_am335x_adc: Add a unit to the timeout delay
      iio: adc: ti_am335x_adc: Add the scale information
      iio: adc: ti_am335x_adc: Add the am437x compatible

Ondrej Jirman (1):
      mfd: rk808: Add support for power off on RK817

Orlando Chamberlain (1):
      mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N UART

Paul Kocialkowski (1):
      dt-bindings: mfd: logicvc: Add patternProperties for the display

Prarit Bhargava (1):
      mfd: intel_pmt: Only compile on x86

Qing Wang (1):
      mfd: janz-cmoio: Replace snprintf in show functions with sysfs_emit

Rafał Miłecki (3):
      dt-bindings: mfd: Add Broadcom's MISC block
      dt-bindings: mfd: brcm,cru: Add clkset syscon
      dt-bindings: mfd: brcm,cru: Add USB 2.0 PHY

Ramona Alexandra Nechita (1):
      mfd: Kconfig: Fix typo in PMIC_ADP5520 from AD5520 to ADP5520

Robert Marko (1):
      mfd: simple-mfd-i2c: Select MFD_CORE to fix build error

Uwe Kleine-König (3):
      mfd: mc13xxx: Make mc13xxx_common_exit() return void
      mfd: stmpe: Make stmpe_remove() return void
      mfd: tps65912: Make tps65912_device_exit() return void

 Documentation/devicetree/bindings/clock/maxim,max77686.txt             |   4 +-
 Documentation/devicetree/bindings/clock/samsung,s2mps11.txt            |  49 ----
 Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml           |  45 ++++
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt                 |  75 ------
 Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml       |  55 ++++
 Documentation/devicetree/bindings/i2c/allwinner,sun6i-a31-p2wi.yaml    |   2 +-
 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml           |  70 ++++++
 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml |  76 ++++++
 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt     |  91 -------
 Documentation/devicetree/bindings/mfd/ac100.txt                        |  50 ----
 Documentation/devicetree/bindings/mfd/axp20x.txt                       | 273 --------------------
 Documentation/devicetree/bindings/mfd/brcm,cru.yaml                    |  21 ++
 Documentation/devicetree/bindings/mfd/brcm,misc.yaml                   |  60 +++++
 Documentation/devicetree/bindings/mfd/max14577.txt                     |   4 +-
 Documentation/devicetree/bindings/mfd/max77686.txt                     |   2 +-
 Documentation/devicetree/bindings/mfd/max77693.txt                     |   2 +-
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt               |  39 +--
 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt                    |   1 +
 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml                 |   1 +
 Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml             |  91 +++++++
 Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml             | 267 ++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml             | 307 +++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/samsung,sec-core.txt             |  86 -------
 Documentation/devicetree/bindings/mfd/syscon.yaml                      |   3 +
 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml            |  84 +++++++
 Documentation/devicetree/bindings/mfd/x-powers,ac100.yaml              | 116 +++++++++
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml             | 400 +++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml               |   3 +
 Documentation/devicetree/bindings/regulator/max77686.txt               |   2 +-
 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.txt        |  79 ------
 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml       |  62 +++++
 Documentation/devicetree/bindings/regulator/samsung,s2mps11.txt        | 102 --------
 Documentation/devicetree/bindings/regulator/samsung,s2mps11.yaml       |  44 ++++
 Documentation/devicetree/bindings/regulator/samsung,s2mps13.yaml       |  44 ++++
 Documentation/devicetree/bindings/regulator/samsung,s2mps14.yaml       |  44 ++++
 Documentation/devicetree/bindings/regulator/samsung,s2mps15.yaml       |  44 ++++
 Documentation/devicetree/bindings/regulator/samsung,s2mpu02.yaml       |  44 ++++
 Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt        | 145 -----------
 Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml       |  74 ++++++
 MAINTAINERS                                                            |   9 +-
 drivers/clk/ti/clk-43xx.c                                              |   1 +
 drivers/iio/adc/ti_am335x_adc.c                                        | 220 +++++++++-------
 drivers/mfd/Kconfig                                                    |  23 +-
 drivers/mfd/Makefile                                                   |   1 -
 drivers/mfd/altera-a10sr.c                                             |   9 +
 drivers/mfd/altera-sysmgr.c                                            |   2 +-
 drivers/mfd/arizona-core.c                                             |  13 -
 drivers/mfd/arizona-i2c.c                                              |  14 +-
 drivers/mfd/arizona-spi.c                                              |  13 +-
 drivers/mfd/arizona.h                                                  |   2 -
 drivers/mfd/cros_ec_dev.c                                              |   1 -
 drivers/mfd/da9063-i2c.c                                               |   2 +
 drivers/mfd/dln2.c                                                     |  18 ++
 drivers/mfd/hi6421-spmi-pmic.c                                         |  16 +-
 drivers/mfd/intel-lpss-pci.c                                           |   2 +
 drivers/mfd/janz-cmodio.c                                              |   2 +-
 drivers/mfd/max14577.c                                                 |   6 +-
 drivers/mfd/max77686.c                                                 |   3 +-
 drivers/mfd/max77693.c                                                 |  12 +-
 drivers/mfd/mc13xxx-core.c                                             |   4 +-
 drivers/mfd/mc13xxx-i2c.c                                              |   3 +-
 drivers/mfd/mc13xxx-spi.c                                              |   3 +-
 drivers/mfd/mc13xxx.h                                                  |   2 +-
 drivers/mfd/mfd-core.c                                                 |   2 +
 drivers/mfd/motorola-cpcap.c                                           |   8 +
 drivers/mfd/qcom-pm8xxx.c                                              |  39 ++-
 drivers/mfd/qcom-spmi-pmic.c                                           |  47 ++--
 drivers/mfd/rk808.c                                                    |   4 +
 drivers/mfd/sec-irq.c                                                  |   3 +-
 drivers/mfd/sprd-sc27xx-spi.c                                          |  17 ++
 drivers/mfd/stmpe-i2c.c                                                |   4 +-
 drivers/mfd/stmpe-spi.c                                                |   4 +-
 drivers/mfd/stmpe.c                                                    |   4 +-
 drivers/mfd/stmpe.h                                                    |   2 +-
 drivers/mfd/ti_am335x_tscadc.c                                         | 237 ++++++++++--------
 drivers/mfd/tps65912-core.c                                            |   4 +-
 drivers/mfd/tps65912-i2c.c                                             |   4 +-
 drivers/mfd/tps65912-spi.c                                             |   4 +-
 drivers/mfd/tps80031.c                                                 | 526 --------------------------------------
 drivers/mfd/wcd934x.c                                                  |  21 +-
 drivers/misc/hi6421v600-irq.c                                          |   9 +-
 drivers/regulator/hi6421v600-regulator.c                               |  10 +-
 drivers/regulator/s5m8767.c                                            |  21 +-
 include/dt-bindings/clock/am4.h                                        |   1 +
 include/linux/mfd/da9063/core.h                                        |   1 +
 include/linux/mfd/hi6421-spmi-pmic.h                                   |  25 --
 include/linux/mfd/max77686-private.h                                   |  26 +-
 include/linux/mfd/ti_am335x_tscadc.h                                   | 119 +++++----
 include/linux/mfd/tps65912.h                                           |   2 +-
 include/linux/mfd/tps80031.h                                           | 637 -----------------------------------------------
 90 files changed, 2533 insertions(+), 2590 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-axp209.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/brcm,misc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,sec-core.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/x-powers,ac100.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps11.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps11.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps13.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps14.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps15.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpu02.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
 delete mode 100644 drivers/mfd/tps80031.c
 delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h
 delete mode 100644 include/linux/mfd/tps80031.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
