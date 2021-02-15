Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7134631C32C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 21:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBOUp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 15:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhBOUpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 15:45:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B9DE64DF4;
        Mon, 15 Feb 2021 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613421911;
        bh=2HkmB4VAQx9NGbvvLKS4kUfeuqrfh4POMtyy/yZL710=;
        h=From:To:Cc:Subject:Date:From;
        b=L9GPHPRZmIHEnVvfk0cSGAjCwN/NtSMdxAZaJkPYK6Mcr/4yfC+79edepCn3zxS+O
         RoxgB3hs9F2oR74fMD8duaXki87R3RdRjpIim5y7VzkY3RlbioIIoncVF8ZIMfuBSb
         8kVmKI8HrsR9vapaaXM6NWbjXQHMzhqxKL6vboNSmS+mHk5i/VFr+boXAlrMKrsUqC
         Zg7EhORHcJR6MSh7bSmrx9rYa6VCNb6wKxRgIYO8Qbqv3jmT+plJEpCrEWZgpBHmtI
         yw6lJwPPZ1VDD8d/iv4hZ+ID92pQEFQLDYfg4gV/YA8lB+7fXxk3eicIbVPub+6kME
         cXWl5tLGJY6EA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.12
Date:   Mon, 15 Feb 2021 20:44:00 +0000
Message-Id: <20210215204511.0B9DE64DF4@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.12

for you to fetch changes up to f03e2a72e5e8772ba0c2a0fc4539e4ffd03d411b:

  Merge remote-tracking branch 'regulator/for-5.12' into regulator-next (2021-02-12 14:00:07 +0000)

----------------------------------------------------------------
regulator: Updates for v5.12

Quite an active release for driver specific updates but very little
going on at the subsystem level this time for the regulator API.

 - Overhaul of the Qualcomm LABIBB driver.
 - Allow use of regulator_sync_voltage() on coupled regulators.
 - Support for Action ATC260x, Mediatek DVSRC and MT6315, Qualcomm
   PCM8180/c and PM8009-1 and Richtek RT4831
 - Removal of the AB3100 driver.

----------------------------------------------------------------
Adrien Grassein (6):
      regulator: pf8x00: add a doc for the module
      regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
      regulator: dt-bindings: pf8x00: mark nxp,ilim-ma property as deprecated
      regulator: pf8x00: mark nxp,ilim-ma property as deprecated
      regulator: pf8x00: use linear range for buck 1-6
      regulator: pf8x00: fix nxp,phase-shift

AngeloGioacchino Del Regno (7):
      regulator: qcom-labibb: Implement voltage selector ops
      regulator: qcom-labibb: Switch voltage ops from linear_range to linear
      regulator: qcom-labibb: Implement current limiting
      regulator: qcom-labibb: Implement pull-down, softstart, active discharge
      regulator: qcom-labibb: Implement short-circuit and over-current IRQs
      regulator: qcom-labibb: Document soft start properties
      regulator: qcom-labibb: Document SCP/OCP interrupts

Arnd Bergmann (1):
      regulator: remove ab3100 driver

Axel Lin (1):
      regulator: pf8x00: Fix typo for PF8200 chip name

Bjorn Andersson (2):
      regulator: qcom-rpmh: Add pmc8180 and pmc8180c
      regulator: qcom-rpmh: Add pmc8180 and pmc8180c

ChiYuan Huang (2):
      regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator
      regulator: rt4831: Adds support for Richtek RT4831 DSV regulator

Christoph Fritz (2):
      regulator: pf8x00: Add suspend support
      regulator: pf8x00: set ramp_delay for bucks

Claudiu Beznea (3):
      regulator: mcp16502: lpm pin can be optional on some platforms
      MAINTAINERS: add myself as maintainer for mcp16502
      regulator: mcp16502: document lpm as optional

Cristian Ciocaltea (1):
      regulator: Add regulator driver for ATC260x PMICs

Daniel Scally (1):
      regulator: core.c: Replace references to non-existent function

Dmitry Baryshkov (2):
      regulator: qcom-rpmh-regulator: add pm8009-1 chip revision
      arm64: dts: qcom: qrb5165-rb5: fix pm8009 regulators

Dmitry Osipenko (1):
      regulator: Make regulator_sync_voltage() usable by coupled regulators

Frieder Schrempf (3):
      regulator: pca9450: Add SD_VSEL GPIO for LDO5
      regulator: pca9450: Enable system reset on WDOG_B assertion
      regulator: pca9450: Add sd-vsel GPIO

Hans de Goede (1):
      regulator: core: Avoid debugfs: Directory ... already present! error

Hsin-Hsiung Wang (2):
      regulator: document binding for MT6315 regulator
      regulator: mt6315: Add support for MT6315 regulator

Jonathan Marek (1):
      regulator: qcom-rpmh: fix pm8009 ldo7

Krzysztof Kozlowski (1):
      regulator: s5m8767: Drop regulators OF node reference

Linus Walleij (2):
      regulator: ab8500: Remove unused platform data
      regulator: ab8500: Decomission platform data header

Mark Brown (10):
      Merge existing fixes from regulator/for-5.11
      Merge series "regulator: fix pm8009 bindings on sm8250" from Dmitry Baryshkov <dmitry.baryshkov@linaro.org>:
      Merge branch 'regulator-5.11' into regulator-5.12
      Merge series "Add driver for dvfsrc, support for active state of scpsys" from Henry Chen <henryc.chen@mediatek.com>:
      Merge series "regulator: mcp16502: make lpm pin optional" from Claudiu Beznea <claudiu.beznea@microchip.com>:
      Merge v5.11-rc3
      Merge series "Really implement Qualcomm LAB/IBB regulators" from AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>:
      Merge series "Really implement Qualcomm LAB/IBB regulators" from AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>:
      Merge remote-tracking branch 'regulator/for-5.11' into regulator-linus
      Merge remote-tracking branch 'regulator/for-5.12' into regulator-next

Matti Vaittinen (4):
      regulator: ROHM bd7xxxx: Do not depend on parent driver data
      regulator: bd718x7: Stop using parent data
      regulator: qcom-labibb: Use disable_irq_nosync from isr
      regulator: bd718x7, bd71828, Fix dvs voltage levels

Pan Bian (2):
      regulator: axp20x: Fix reference cout leak
      regulator: s5m8767: Fix reference count leak

Randy Dunlap (2):
      lib/linear_ranges: fix repeated words & one typo
      regulator: qcom-rpmh: fix build after QCOM_COMMAND_DB is tristate

Timon Baetz (1):
      regulator: dt-bindings: Document charger-supply for max8997

henryc.chen (1):
      regulator: Regulator driver for the Mediatek DVFSRC

 .../bindings/regulator/max8997-regulator.txt       |   1 +
 .../bindings/regulator/mcp16502-regulator.txt      |   3 +-
 .../bindings/regulator/mt6315-regulator.yaml       |  69 ++
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |   5 +
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   |  17 +-
 .../bindings/regulator/qcom,rpmh-regulator.txt     |   2 +
 .../bindings/regulator/qcom-labibb-regulator.yaml  |  30 +-
 .../regulator/richtek,rt4831-regulator.yaml        |  35 +
 MAINTAINERS                                        |   4 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   9 +-
 drivers/mfd/ab8500-core.c                          |   1 -
 drivers/regulator/Kconfig                          |  51 +-
 drivers/regulator/Makefile                         |   5 +-
 drivers/regulator/ab3100.c                         | 724 --------------------
 drivers/regulator/ab8500-ext.c                     | 422 +-----------
 drivers/regulator/ab8500.c                         | 116 +++-
 drivers/regulator/atc260x-regulator.c              | 539 +++++++++++++++
 drivers/regulator/axp20x-regulator.c               |   7 +-
 drivers/regulator/bd70528-regulator.c              |  11 +-
 drivers/regulator/bd71828-regulator.c              |  13 +-
 drivers/regulator/bd718x7-regulator.c              |  20 +-
 drivers/regulator/core.c                           |  18 +-
 drivers/regulator/mcp16502.c                       |   2 +-
 drivers/regulator/mt6315-regulator.c               | 299 +++++++++
 drivers/regulator/mtk-dvfsrc-regulator.c           | 215 ++++++
 drivers/regulator/pca9450-regulator.c              |  22 +
 drivers/regulator/pf8x00-regulator.c               | 278 +++++---
 drivers/regulator/qcom-labibb-regulator.c          | 728 ++++++++++++++++++++-
 drivers/regulator/qcom-rpmh-regulator.c            |  34 +
 drivers/regulator/rohm-regulator.c                 |   9 +-
 drivers/regulator/rt4831-regulator.c               | 198 ++++++
 drivers/regulator/s5m8767.c                        |  15 +-
 include/linux/mfd/abx500/ab8500.h                  |   3 -
 include/linux/mfd/rohm-generic.h                   |  14 +-
 include/linux/regulator/ab8500.h                   | 166 -----
 include/linux/regulator/mt6315-regulator.h         |  44 ++
 include/linux/regulator/pca9450.h                  |   7 +
 lib/linear_ranges.c                                |   8 +-
 38 files changed, 2661 insertions(+), 1483 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
 delete mode 100644 drivers/regulator/ab3100.c
 create mode 100644 drivers/regulator/atc260x-regulator.c
 create mode 100644 drivers/regulator/mt6315-regulator.c
 create mode 100644 drivers/regulator/mtk-dvfsrc-regulator.c
 create mode 100644 drivers/regulator/rt4831-regulator.c
 delete mode 100644 include/linux/regulator/ab8500.h
 create mode 100644 include/linux/regulator/mt6315-regulator.h
