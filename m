Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24D23B65B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhF1Pd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236080AbhF1PHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC10F60C3E;
        Mon, 28 Jun 2021 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624892102;
        bh=+/kNPYi5HnVH/v7NpZIT3/VI+DMCvKvLdjglBQ4mda0=;
        h=From:To:Cc:Subject:Date:From;
        b=g11VL+aetqVdHIywE3MxL6lqELMJ5rnxXOmzD4wVdFob6x2GXcEGeLyPSpmD9i6F0
         DIObQOe3swqc/vQpO8flL4Ibhgvf5yQhtapaRn94Lp5R1fZu+kftItWiz3mjbPVb6Y
         x4rBoIYc9M4esX9Cb2crEhZThF+D0ivyzggfvmes1qwNcOjNZ1nITbedFSt4JuB/x2
         9VZ6BaloLP1qkor6RHtRk7foF86u8wN8cJZ63l6lwOYmZUHNGb2eaTXNAFe/J+T2L9
         effCJeoO8k/CUFwBLgIYl1UQO9aC50bPk6w0Ww0T7mDBdxxypFfw1b1ZHOQErBbE4Y
         lc2aKn56CvGNA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.14
Date:   Mon, 28 Jun 2021 15:54:23 +0100
Message-Id: <20210628145501.EC10F60C3E@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.14

for you to fetch changes up to 7fb593cbd88cf4df01c096d4dc320f027dfa2560:

  Merge remote-tracking branch 'regulator/for-5.14' into regulator-next (2021-06-23 16:56:31 +0100)

----------------------------------------------------------------
regulator: Updates for v5.14

The main core change this release is generic support for handling of
hardware errors from Matti Vaittinen, including some small updates to
the reboot and thermal code so we can share support for powering off the
system if things are going wrong enough.  Otherwise this release we've
mainly seen the addition of new drivers, including MT6359 which has
pulled in some small changes from the MFD tree for build dependencies.

 - Support for controlling the trigger points for hardware error
   detection, and shared handlers for this.
 - Support for Maxim MAX8993, Mediatek MT6359 and MT6359P, Qualcomm
   PM8226 and SA8115P-ADP, and Sylergy TCS4526.

----------------------------------------------------------------
Alistair Francis (1):
      regulator: sy7636a: Initial commit

Axel Lin (43):
      regulator: hi6421v600: Remove unneeded *pmic from struct hi6421_spmi_reg_info
      regulator: bd71815: Fix missing include files
      regulator: fan53880: Convert to use .probe_new
      regulator: fan53555: Fix slew_shift setting for tcs4525
      regulator: fan53555: Cleanup unused define and redundant assignment
      regulator: max8973: Convert to use regulator_set_ramp_delay_regmap
      regulator: bd70528: Convert to use regulator_set_ramp_delay_regmap
      regulator: qcom_smd: Make pm8953_lnldo linear_ranges entries properly sorted
      regulator: mp886x: Convert to use regulator_set_ramp_delay_regmap
      regulator: mp5416: Convert to use regulator_set_ramp_delay_regmap
      regulator: rt4831: Add missing .owner field in regulator_desc
      regulator: rk808: Convert to use regulator_set_ramp_delay_regmap
      regulator: pca9450: Convert to use regulator_set_ramp_delay_regmap
      regulator: mt6315: Don't ignore devm_regulator_register failure
      regulator: lp8755: Convert to use regulator_set_ramp_delay_regmap
      regulator: mcp16502: Convert to use .probe_new
      regulator: mcp16502: Convert to use regulator_set_ramp_delay_regmap
      regulator: max77802: Remove .set_ramp_delay from max77802_buck_dvs_ops
      regulator: max77802: Convert to use regulator_set_ramp_delay_regmap
      regulator: fan53555: Fix missing slew_reg/mask/shift settings for FAN53526
      regulator: fan53555: Convert to use regulator_set_ramp_delay_regmap
      regulator: bd9576: Constify the voltage tables
      regulator: max77686: Convert to use regulator_set_ramp_delay_regmap
      regulator: mt6358: Use unsigned int for volt_tables
      regulator: mt6359: Use unsigned int for volt_tables
      regulator: mt6359: Get rid of linear_range tables
      regulator: ltc3589: Convert to use regulator_set_ramp_delay_regmap
      regulator: bd71815: Get rid of struct bd71815_pmic
      regulator: fan53880: Fix vsel_mask setting for FAN53880_BUCK
      regulator: rt6160: Convert to use regulator_set_ramp_delay_regmap
      regulator: hi6421v600: Use regulator_map_voltage_ascend
      regulator: rt6160: Remove vsel_active_low from struct rt6160_priv
      regulator: mt6315: Fix checking return value of devm_regmap_init_spmi_ext
      regulator: rt6160: Fix setting suspend voltage
      regulator: sy7636a: Add terminating entry for platform_device_id table
      regulator: sy7636a: Make regulator_desc static const
      regulator: sy7636a: Use rdev_get_drvdata at proper place
      regulator: hi655x: Fix pass wrong pointer to config.driver_data
      regulator: hi6421: Use correct variable type for regmap api val argument
      regulator: hi6421v600: Fix setting idle mode
      regulator: hi6421v600: Fix setting wrong driver_data
      regulator: da9052: Ensure enough delay time for .set_voltage_time_sel
      regulator: max8893: Select REGMAP_I2C to fix build error

Bartosz Dudziak (2):
      regulator: qcom_smd: Add PM8226 regulator support
      regulator: qcom: Document PM8226 smd regulator

Bhupesh Sharma (5):
      regulator: qcom-rpmh: Cleanup terminator line commas
      regulator: qcom-rpmh: Add terminator at the end of pm7325x_vreg_data[] array
      regulator: qcom-rpmh: Add new regulator found on SA8155p adp board
      regulator: qcom,rpmh-regulator: Arrange compatibles alphabetically
      regulator: qcom,rpmh-regulator: Add compatible for SA8155p-adp board pmic

Bryan O'Donoghue (1):
      regulator: Add a routine to set the current limit for QCOM PMIC VBUS

ChiYuan Huang (5):
      regulator: rt6160: Add DT binding document for Richtek RT6160
      regulator: rt6160: Add support for Richtek RT6160
      regulator: rt6245: Add the binding document for Richtek RT6245
      regulator: rt6245: Add support for Richtek RT6245
      regulator: rt6160: Remove dummy line and add module description

Colin Ian King (1):
      regulator: bd9576: Fix uninitializes variable may_have_irqs

Dmitry Osipenko (1):
      regulator: core: Add regulator_sync_voltage_rdev()

Hsin-Hsiung Wang (7):
      mfd: mt6358: Refine interrupt code
      rtc: mt6397: refine RTC_TC_MTH
      dt-bindings: mfd: Add compatible for the MediaTek MT6359 PMIC
      dt-bindings: regulator: Add document for MT6359 regulator
      mfd: Add support for the MediaTek MT6359 PMIC
      regulator: mt6359: Add support for MT6359P regulator
      regulator: mt6358: Fix vdram2 .vsel_mask

Mark Brown (8):
      Merge series "Enable VBUS current boost on pm8150b platforms" from Bryan O'Donoghue <bryan.odonoghue@linaro.org>:
      Merge branch 'for-5.13' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator into regulator-5.14
      Merge tag 'tb-mfd-regulator-rtc-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into regulator-5.14
      Merge tag 'for-5.14-regulator' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into regulator-5.14
      Merge series "Extend regulator notification support" from Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>:
      Merge series "regulator: qcom,rpmh-regulator: Add support for pmic available on SA8155p-adp board" from Bhupesh Sharma <bhupesh.sharma@linaro.org>:
      Merge remote-tracking branch 'regulator/for-5.13' into regulator-linus
      Merge remote-tracking branch 'regulator/for-5.14' into regulator-next

Matti Vaittinen (12):
      regulator: bd70528: Drop BD70528 support
      regulator: Add protection limit properties
      reboot: Add hardware protection power-off
      thermal: Use generic HW-protection shutdown API
      regulator: add warning flags
      regulator: move rdev_print helpers to internal.h
      regulator: IRQ based event/error notification helpers
      regulator: add property parsing and callbacks to set protection limits
      regulator: bd9576 add FET ON-resistance for OCW
      regulator: bd9576: Support error reporting
      regulator: bd9576: Fix the driver name in id table
      MAINTAINERS: Add reviewer for regulator irq_helpers

Peter Geis (3):
      regulator: fan53555: fix TCS4525 voltage calulation
      regulator: fan53555: only bind tcs4525 to correct chip id
      regulator: fan53555: fix tcs4525 function names

Randy Dunlap (1):
      regulator: bd71815: add select to fix build

Rouven Czerwinski (1):
      regulator: fixed: use dev_err_probe for gpio

Rudi Heitbaum (1):
      regulator: fan53555: add tcs4526

Sergey Larin (2):
      regulator: max8893: add regulator driver
      regulator: Add MAX8893 bindings

Wen Su (1):
      regulator: mt6359: Add support for MT6359 regulator

YueHaibing (1):
      regulator: core: Use DEVICE_ATTR_RO macro

Zhen Lei (1):
      regulator: userspace-consumer: use DEVICE_ATTR_RO/RW macro

Zou Wei (2):
      regulator: uniphier: Add missing MODULE_DEVICE_TABLE
      regulator: bd71815: fix platform_no_drv_owner.cocci warnings

 Documentation/devicetree/bindings/mfd/mt6397.txt   |    1 +
 .../devicetree/bindings/regulator/max8893.yaml     |   88 ++
 .../bindings/regulator/mt6359-regulator.yaml       |  385 +++++++
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |   17 +-
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |    5 +
 .../devicetree/bindings/regulator/regulator.yaml   |   82 ++
 .../regulator/richtek,rt6160-regulator.yaml        |   61 ++
 .../regulator/richtek,rt6245-regulator.yaml        |   89 ++
 .../bindings/regulator/rohm,bd9576-regulator.yaml  |    6 +
 Documentation/driver-api/thermal/sysfs-api.rst     |   24 +-
 MAINTAINERS                                        |    4 +
 drivers/mfd/mt6358-irq.c                           |   89 +-
 drivers/mfd/mt6397-core.c                          |   24 +
 drivers/regulator/Kconfig                          |   55 +-
 drivers/regulator/Makefile                         |    8 +-
 drivers/regulator/bd70528-regulator.c              |  283 -----
 drivers/regulator/bd71815-regulator.c              |   60 +-
 drivers/regulator/bd9576-regulator.c               | 1084 +++++++++++++++++---
 drivers/regulator/core.c                           |  316 ++++--
 drivers/regulator/da9052-regulator.c               |    3 +-
 drivers/regulator/devres.c                         |   52 +
 drivers/regulator/fan53555.c                       |  118 +--
 drivers/regulator/fan53880.c                       |    7 +-
 drivers/regulator/fixed.c                          |    3 +-
 drivers/regulator/hi6421-regulator.c               |    8 +-
 drivers/regulator/hi6421v600-regulator.c           |   59 +-
 drivers/regulator/hi655x-regulator.c               |   16 +-
 drivers/regulator/internal.h                       |   11 +
 drivers/regulator/irq_helpers.c                    |  397 +++++++
 drivers/regulator/lp8755.c                         |   55 +-
 drivers/regulator/ltc3589.c                        |   73 +-
 drivers/regulator/max77686-regulator.c             |   42 +-
 drivers/regulator/max77802-regulator.c             |   70 +-
 drivers/regulator/max8893.c                        |  183 ++++
 drivers/regulator/max8973-regulator.c              |   37 +-
 drivers/regulator/mcp16502.c                       |   79 +-
 drivers/regulator/mp5416.c                         |   44 +-
 drivers/regulator/mp886x.c                         |   32 +-
 drivers/regulator/mt6315-regulator.c               |   21 +-
 drivers/regulator/mt6358-regulator.c               |   24 +-
 drivers/regulator/mt6359-regulator.c               |  997 ++++++++++++++++++
 drivers/regulator/of_regulator.c                   |   58 ++
 drivers/regulator/pca9450-regulator.c              |   51 +-
 drivers/regulator/qcom-labibb-regulator.c          |   10 +-
 drivers/regulator/qcom-rpmh-regulator.c            |   62 +-
 drivers/regulator/qcom_smd-regulator.c             |   85 +-
 drivers/regulator/qcom_spmi-regulator.c            |    6 +-
 drivers/regulator/qcom_usb_vbus-regulator.c        |   12 +
 drivers/regulator/rk808-regulator.c                |  116 +--
 drivers/regulator/rt4831-regulator.c               |    3 +
 drivers/regulator/rt6160-regulator.c               |  319 ++++++
 drivers/regulator/rt6245-regulator.c               |  254 +++++
 drivers/regulator/stpmic1_regulator.c              |   20 +-
 drivers/regulator/sy7636a-regulator.c              |  128 +++
 drivers/regulator/uniphier-regulator.c             |    1 +
 drivers/regulator/userspace-consumer.c             |   14 +-
 drivers/rtc/rtc-mt6397.c                           |    2 +-
 drivers/thermal/thermal_core.c                     |   63 +-
 include/linux/mfd/mt6358/core.h                    |    8 +-
 include/linux/mfd/mt6359/core.h                    |  133 +++
 include/linux/mfd/mt6359/registers.h               |  529 ++++++++++
 include/linux/mfd/mt6359p/registers.h              |  249 +++++
 include/linux/mfd/mt6397/core.h                    |    1 +
 include/linux/mfd/mt6397/rtc.h                     |    1 +
 include/linux/reboot.h                             |    1 +
 include/linux/regulator/consumer.h                 |   14 +
 include/linux/regulator/coupler.h                  |    5 -
 include/linux/regulator/driver.h                   |  187 +++-
 include/linux/regulator/machine.h                  |   26 +
 include/linux/regulator/mt6359-regulator.h         |   59 ++
 kernel/reboot.c                                    |   79 ++
 71 files changed, 6262 insertions(+), 1246 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/max8893.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml
 delete mode 100644 drivers/regulator/bd70528-regulator.c
 create mode 100644 drivers/regulator/irq_helpers.c
 create mode 100644 drivers/regulator/max8893.c
 create mode 100644 drivers/regulator/mt6359-regulator.c
 create mode 100644 drivers/regulator/rt6160-regulator.c
 create mode 100644 drivers/regulator/rt6245-regulator.c
 create mode 100644 drivers/regulator/sy7636a-regulator.c
 create mode 100644 include/linux/mfd/mt6359/core.h
 create mode 100644 include/linux/mfd/mt6359/registers.h
 create mode 100644 include/linux/mfd/mt6359p/registers.h
 create mode 100644 include/linux/regulator/mt6359-regulator.h
