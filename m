Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED136B521
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhDZOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233953AbhDZOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:41:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0C4F61289;
        Mon, 26 Apr 2021 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619448054;
        bh=ZpY1kGDUww7ixdjlZ/bCphkYOb4lTlMledi08esvgz8=;
        h=From:To:Cc:Subject:Date:From;
        b=iS/REbiwn3amd/5KzTL6iCqgorkEoBd0HgzPijGvqNEUMHL/s0uOqm3W84a99QZZM
         RekUd1aWLiE4ZsaKBu6LGQJa0Krqn6YgcZU5qWipYTSqAiMXAzqJxKuXXNK0WrrKS9
         FzbGM2VBtsEgRW6LjjYxO3lMi5WNUC2IwwPKXAL7FF1u7uVD0Q11/U5pHavFAZZenl
         9hJEanQPH0UjrX7VBTiTLPTbhIZmORkXmRWpV8xPXLgaMWirvVLE7bHECmbvrmFXys
         82YRQeTyNyT6+0lt3+NjLp/cg2622kkeqHVpJ3S8HOHNSSfD8Bi/geCL27tOvEI0+8
         zb7GbPo1YwoqA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.13
Date:   Mon, 26 Apr 2021 15:40:10 +0100
Message-Id: <20210426144053.F0C4F61289@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

  Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.13

for you to fetch changes up to 4dd1c95306980c997b9a32e72877e060c25dc6f3:

  Merge remote-tracking branch 'regulator/for-5.13' into regulator-next (2021-04-23 19:01:23 +0100)

----------------------------------------------------------------
regulator: Updates for v5.13

Not much going on with regulator this cycle, even in terms of cleanups
and fixes things were fairly quiet.

 - New helper for setting ramp delay.
 - Conversion of the Qualcomm RPMH bindings to YAML.
 - Support for Tang Cheng TCS4525.

----------------------------------------------------------------
Adam Ward (1):
      regulator: da9121: automotive variants identity fix

AngeloGioacchino Del Regno (1):
      regulator: spmi: Add support for ULT LV_P50 and ULT P300

Axel Lin (2):
      regulator: mt6315: Return REGULATOR_MODE_INVALID for invalid mode
      regulator: pf8x00: Use regulator_map_voltage_ascend for pf8x00_buck7_ops

Christophe JAILLET (1):
      regulator: Avoid a double 'of_node_get' in 'regulator_of_get_init_node()'

Dan Carpenter (1):
      regulator: bd9576: Fix return from bd957x_probe()

Ezequiel Garcia (2):
      dt-bindings: vendor-prefixes: Add Tang Cheng (TCS)
      regulator: Add binding for TCS4525

Frieder Schrempf (1):
      regulator: pca9450: Fix return value when failing to get sd-vsel GPIO

Jian Dong (1):
      regulator: mt6360: remove redundant error print

Joseph Chen (1):
      regulator: fan53555: Add TCS4525 DCDC support

Krzysztof Kozlowski (2):
      regulator: s2mpa01: Drop initialization via platform data
      regulator: s2mps11: Drop initialization via platform data

Mark Brown (6):
      Merge existing fixes from regulator/for-5.12
      Merge series "Support ROHM BD71815 PMIC" from Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>:
      Merge series "mfd/rtc/regulator: Drop board file support for Samsung PMIC" from Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>:
      Merge branch 'for-5.12' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator into regulator-5.13
      Merge remote-tracking branch 'regulator/for-5.12' into regulator-linus
      Merge remote-tracking branch 'regulator/for-5.13' into regulator-next

Matti Vaittinen (2):
      regulator: helpers: Export helper voltage listing
      regulator: Add regmap helper for ramp-delay setting

Sebastian Fricke (1):
      regulator: core.c: Improve a comment

Shubhankar Kuranagatti (1):
      regulator: core.c: Fix indentation of comment

Vincent Whitchurch (2):
      regulator: core: Respect off_on_delay at startup
      regulator: core: Fix off_on_delay handling

Yang Li (1):
      regulator: add missing call to of_node_put()

satya priya (6):
      regulator: qcom-rpmh: Correct the pmic5_hfsmps515 buck
      regulator: qcom-rpmh: Use correct buck for S1C regulator
      regulator: qcom-rpmh: Add pmic5_ftsmps520 buck
      regulator: qcom-rpmh: Add PM7325/PMR735A regulator support
      regulator: Convert RPMh regulator bindings to YAML
      regulator: Add compatibles for PM7325/PMR735A

 .../devicetree/bindings/regulator/fan53555.txt     |   4 +-
 .../bindings/regulator/qcom,rpmh-regulator.txt     | 180 ---------------------
 .../bindings/regulator/qcom,rpmh-regulator.yaml    | 162 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/regulator/bd9576-regulator.c               |  11 +-
 drivers/regulator/core.c                           |  59 ++++---
 drivers/regulator/da9121-regulator.c               |  80 +++++----
 drivers/regulator/da9121-regulator.h               |  13 ++
 drivers/regulator/fan53555.c                       | 136 ++++++++++++++--
 drivers/regulator/helpers.c                        | 101 +++++++++++-
 drivers/regulator/mt6360-regulator.c               |   4 +-
 drivers/regulator/of_regulator.c                   |   6 +-
 drivers/regulator/pf8x00-regulator.c               |   1 +
 drivers/regulator/qcom-rpmh-regulator.c            |  62 ++++++-
 drivers/regulator/qcom_spmi-regulator.c            |   2 +
 drivers/regulator/s2mpa01.c                        |   4 -
 drivers/regulator/s2mps11.c                        |  22 +--
 drivers/regulator/scmi-regulator.c                 |   4 +-
 include/linux/regulator/driver.h                   |   9 +-
 19 files changed, 560 insertions(+), 302 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
