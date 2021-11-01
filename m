Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63230441D58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhKAPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAPXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E62660F3A;
        Mon,  1 Nov 2021 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635780077;
        bh=dv4WiP6lP1x1/ELom89oT453wCCo4ZMJ6cxrLTTHpwM=;
        h=From:To:Cc:Subject:Date:From;
        b=kbI+6zWQTgTDoh/DhA7iBCHwrRQmx0rZ5Q/Nbcsc8uaKCQU2J4HPVvOj/azvmCNqT
         fNJIQ4rewpa6cURMBuTYjOOUwmCWyJbMJnU9DXxt/qbRJAyEgp5Z21hD6Dts32Os+Q
         EQ0DRcivC6qOHQtLrBxhJy/6V/1Y4cvIy+lt2g3iDayL4nlaafZiIUBvmtKnoyKo1s
         48VdoB3cYgAsQtX2kj7yDcP+9bWVnoS8VURAH6PBU8n6V06ihOvyaqGeQaWztSJ/NI
         e6mSPun3MBlc5gK5tiqrJiR/uXhohozvi6A6D6GguM1HBr3tSAY+YCBXqBUn5ax75r
         TzVM/G6c9H+2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.16
Date:   Mon, 01 Nov 2021 15:21:03 +0000
Message-Id: <20211101152117.5E62660F3A@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.16

for you to fetch changes up to 7492b724df4d33ca3d5b38b70fb4acb93e6d02bf:

  Merge series "Remove TPS80031 driver" from Dmitry Osipenko <digetx@gmail.com>: (2021-10-23 17:30:21 +0100)

----------------------------------------------------------------
regulator: Updates for v5.16

Thanks to the removal of the unused TPS80021 driver the regulator
updates for this cycle actually have a negative diffstat.  Otherwise
it's been quite a quiet release, lots of fixes and small improvements
with the biggest individual changes being several conversions of DT
bindings to YAML format.

----------------------------------------------------------------
Alistair Francis (1):
      regulator: sy7636a: Remove requirement on sy7636a mfd

Anand Moon (1):
      regulator: pwm-regulator: Make use of the helper function dev_err_probe()

Brian Norris (1):
      regulator: core: resolve supply voltage deferral silently

Cai Huoqing (3):
      regulator: ti-abb: Make use of the helper function devm_ioremap related
      regulator: ti-abb: Kconfig: Add helper dependency on COMPILE_TEST
      regulator: vqmmc-ipq4019: Make use of the helper function devm_platform_ioremap_resource()

ChiYuan Huang (1):
      regulator: rtq6752: Enclose 'enable' gpio control by enable flag

Dmitry Osipenko (2):
      regulator: tps80031: Remove driver
      regulator: Don't error out fixed regulator in regulator_sync_voltage()

Krzysztof Kozlowski (9):
      regulator: dt-bindings: maxim,max8952: convert to dtschema
      regulator: dt-bindings: maxim,max8997: convert to dtschema
      regulator: dt-bindings: maxim,max8973: convert to dtschema
      regulator: s5m8767: do not use reset value as DVS voltage if GPIO DVS is disabled
      regulator: dt-bindings: samsung,s5m8767: correct s5m8767,pmic-buck-default-dvs-idx property
      dt-bindings: clock: samsung,s2mps11: convert to dtschema
      regulator: dt-bindings: samsung,s2m: convert to dtschema
      regulator: dt-bindings: samsung,s2mpa01: convert to dtschema
      regulator: dt-bindings: samsung,s5m8767: convert to dtschema

Kunihiko Hayashi (2):
      regulator: uniphier: Add USB-VBUS compatible string for NX1 SoC
      regulator: uniphier: Add binding for NX1 SoC

Luca Weiss (2):
      regulator: qcom-rpmh: Add PM6350 regulators
      regulator: qcom,rpmh: Add compatible for PM6350

Mark Brown (10):
      Merge existing fixes from regulator/for-5.15
      spi: Check we have a spi_device_id for each DT compatible
      regulator: Lower priority of logging when setting supply
      Merge series "regulator/mfd/clock: dt-bindings: Samsung S2M and S5M to dtschema" from Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>:
      Merge tag 'v5.15-rc6' into regulator-5.16
      Merge series "Add support for the silergy,sy7636a" from Alistair Francis <alistair@alistair23.me>:
      Merge series "Initial Fairphone 4 support" from Luca Weiss <luca@z3ntu.xyz>:
      Merge series "regulator: Introduce UniPhier NX1 SoC support" from Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
      regulator: Fix SY7636A breakage
      Merge series "Remove TPS80031 driver" from Dmitry Osipenko <digetx@gmail.com>:

Matti Vaittinen (1):
      regulator: bd71815: Use defined mask values

Maxime Ripard (1):
      regulator: Convert SY8106A binding to a schema

Maíra Canal (2):
      regulator: lp872x: replacing legacy gpio interface for gpiod
      regulator: tps62360: replacing legacy gpio interface for gpiod

Nathan Chancellor (1):
      regulator: lp872x: Remove lp872x_dvs_state

Ramona Alexandra Nechita (1):
      regulator: fix typo in Kconfig and max8973-regulator

Shawn Guo (2):
      regulator: Document PM2250 smd-rpm regulators
      regulator: qcom_smd: Add PM2250 regulators

Zenghui Yu (1):
      regulator: dummy: Use devm_regulator_register()

 .../devicetree/bindings/clock/samsung,s2mps11.txt  |  49 --
 .../devicetree/bindings/clock/samsung,s2mps11.yaml |  45 ++
 .../devicetree/bindings/regulator/max8952.txt      |  52 --
 .../bindings/regulator/max8973-regulator.txt       |  52 --
 .../bindings/regulator/max8997-regulator.txt       | 145 ----
 .../bindings/regulator/maxim,max8952.yaml          | 109 +++
 .../bindings/regulator/maxim,max8973.yaml          | 139 ++++
 .../bindings/regulator/maxim,max8997.yaml          | 445 ++++++++++++
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |   2 +
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   4 +
 .../bindings/regulator/samsung,s2mpa01.txt         |  79 ---
 .../bindings/regulator/samsung,s2mpa01.yaml        |  62 ++
 .../bindings/regulator/samsung,s2mps11.txt         | 102 ---
 .../bindings/regulator/samsung,s2mps11.yaml        |  44 ++
 .../bindings/regulator/samsung,s2mps13.yaml        |  44 ++
 .../bindings/regulator/samsung,s2mps14.yaml        |  44 ++
 .../bindings/regulator/samsung,s2mps15.yaml        |  44 ++
 .../bindings/regulator/samsung,s2mpu02.yaml        |  44 ++
 .../bindings/regulator/samsung,s5m8767.txt         | 145 ----
 .../bindings/regulator/samsung,s5m8767.yaml        |  74 ++
 .../bindings/regulator/silergy,sy8106a.yaml        |  52 ++
 .../regulator/socionext,uniphier-regulator.yaml    |   1 +
 .../bindings/regulator/sy8106a-regulator.txt       |  23 -
 MAINTAINERS                                        |   6 +-
 drivers/regulator/Kconfig                          |  15 +-
 drivers/regulator/Makefile                         |   1 -
 drivers/regulator/bd71815-regulator.c              |   4 +-
 drivers/regulator/core.c                           |  12 +-
 drivers/regulator/dummy.c                          |   3 +-
 drivers/regulator/lp872x.c                         |  52 +-
 drivers/regulator/max8973-regulator.c              |   4 +-
 drivers/regulator/pwm-regulator.c                  |  12 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  32 +
 drivers/regulator/qcom_smd-regulator.c             |  49 ++
 drivers/regulator/rtq6752-regulator.c              |  18 +-
 drivers/regulator/s5m8767.c                        |  21 +-
 drivers/regulator/sy7636a-regulator.c              |   2 +-
 drivers/regulator/ti-abb-regulator.c               |  31 +-
 drivers/regulator/tps62360-regulator.c             |  59 +-
 drivers/regulator/tps80031-regulator.c             | 753 ---------------------
 drivers/regulator/uniphier-regulator.c             |   4 +
 drivers/regulator/vqmmc-ipq4019-regulator.c        |   4 +-
 drivers/spi/spi.c                                  |  41 ++
 include/linux/regulator/lp872x.h                   |  17 +-
 include/linux/regulator/tps62360.h                 |   6 -
 45 files changed, 1382 insertions(+), 1564 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8952.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8973-regulator.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8997-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8952.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
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
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8106a.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
 delete mode 100644 drivers/regulator/tps80031-regulator.c
