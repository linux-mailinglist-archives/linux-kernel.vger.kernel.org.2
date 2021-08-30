Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4AB3FB677
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhH3MwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:52:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56004 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhH3MwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Message-Id:Date:Subject:Cc:To:From
        :Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m9m4DiyIrIFxEh+n4O/L4g0eFNv5wBJTwUjab/GLEBc=; b=AcnVhCwU0SUEtl8QzZjq20JCNk
        nVbk5w0sl7WKDltkJp5Bp+WUvPi8s4vVsh17QBFVFEfYU7C1NhcwA3QYD1iyoeQH6Ua+I3FcTAh/H
        J3FeIcR/A349kCYfkT1rZWAQL1UYDTvll175fRnmE5myjDdPEhDJHEjW+yF0q3CJxI/g=;
Received: from jack.einval.com ([84.45.184.145] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mKgkk-00H5GZ-6h; Mon, 30 Aug 2021 12:51:06 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DE356D1B482; Mon, 30 Aug 2021 13:51:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.15
Date:   Mon, 30 Aug 2021 13:50:53 +0100
Message-Id: <20210830125104.DE356D1B482@fitzroy.sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.15

for you to fetch changes up to 7aa6d700b089d960a03f6459898c096f4346990c:

  Merge remote-tracking branch 'regulator/for-5.15' into regulator-next (2021-08-25 16:05:26 +0100)

----------------------------------------------------------------
regulator: Update for v5.15

A very quiet releases, some fixes and cleanups but not really
that many of them.  There were a couple of new driver specific
pieces:

 - Support for controlling the over/under voltage protection on
   BD718xx devices.
 - New drivers for Richtek RTQ2134, and RTQ6752.

----------------------------------------------------------------
Alexandru Ardelean (3):
      regulator: devres: remove devm_regulator_unregister() function
      regulator: devres: remove devm_regulator_bulk_unregister_supply_alias()
      regulator: devres: unexport devm_regulator_unregister_supply_alias()

Alistair Francis (4):
      regulator: sy7636a: Remove the poll_enable_time
      regulator: sy7636a: Use the parent driver data
      regulator: sy7636a: Store the epd-pwr-good GPIO locally
      regulator: sy7636a: Use the regmap directly

Axel Lin (3):
      regulator: mt6358: Remove shift fields from struct mt6358_regulator_info
      regulator: mt6359: Remove shift fields from struct mt6359_regulator_info
      regulator: mt6397: Remove modeset_shift from struct mt6397_regulator_info

Chen-Yu Tsai (2):
      regulator: vctrl: Use locked regulator_get_voltage in probe path
      regulator: vctrl: Avoid lockdep warning in enable/disable ops

ChiYuan Huang (9):
      regulator: rt5033: Use linear ranges to map all voltage selection
      regulator: rtq6752: Add binding document for Richtek RTQ6752
      regulator: rt6752: Add support for Richtek RTQ6752
      regulator: rtq6752: Refine binding document
      regulator: rtq6752: Fix the typo for reg define and author name
      regulator: rtq6752: fix reg reset behavior
      regulator: rtq2134: Add binding document for Richtek RTQ2134 SubPMIC
      regulator: rtq2134: Add support for Richtek RTQ2134 SubPMIC
      regulator: rtq2134: Fix coding style

Chris Morgan (1):
      regulator: fixed: use dev_err_probe for register

Colin Ian King (2):
      regulator: rt6245: make a const array func_base static, makes object smaller
      regulator: Fix a couple of spelling mistakes in Kconfig

Dmitry Osipenko (1):
      regulator: tps65910: Silence deferred probe error

Jinchao Wang (1):
      regulator: Replace symbolic permissions with octal permissions

Jisheng Zhang (2):
      regulator: sy8824x: Enable REGCACHE_FLAT
      regulator: sy8827n: Enable REGCACHE_FLAT

Kunihiko Hayashi (1):
      regulator: Convert UniPhier regulator to json-schema

Mark Brown (6):
      Merge existing fixes from regulator/for-5.14
      Merge series "Move Hisilicon 6421v600 SPMI and USB drivers out of staging" from Mauro Carvalho Chehab <mchehab+huawei@kernel.org>:
      Merge series "regulator: devres: remove unused device-managed unregister APIs" from Alexandru Ardelean <aardelean@deviqon.com>:
      Merge branch 'regulator-5.14' into regulator-5.15
      Merge remote-tracking branch 'regulator/for-5.14' into regulator-linus
      Merge remote-tracking branch 'regulator/for-5.15' into regulator-next

Matti Vaittinen (3):
      regulator: bd718x7: Suopport configuring UVP/OVP state
      regulator: Minor regulator documentation fixes.
      regulator: Documentation fix for regulator error notification helper

Mauro Carvalho Chehab (3):
      regulator: hi6421v600-regulator: add a missing dot at copyright
      regulator: hi6421v600: use lowercase for ldo
      regulator: hi6421v600: rename voltage range arrays

Randy Dunlap (1):
      regulator: machine.h: fix kernel-doc "bad line"

Vincent Pelletier (1):
      regulator: da9063: Add support for full-current mode.

 .../regulator/richtek,rtq2134-regulator.yaml       | 106 ++++++
 .../regulator/richtek,rtq6752-regulator.yaml       |  76 +++++
 .../regulator/socionext,uniphier-regulator.yaml    |  85 +++++
 .../bindings/regulator/uniphier-regulator.txt      |  58 ----
 drivers/regulator/Kconfig                          |  24 +-
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/bd718x7-regulator.c              | 369 ++++++++++++++------
 drivers/regulator/da9063-regulator.c               | 132 +++++++-
 drivers/regulator/dbx500-prcmu.c                   |   4 +-
 drivers/regulator/devres.c                         |  69 +---
 drivers/regulator/fixed.c                          |   5 +-
 drivers/regulator/hi6421v600-regulator.c           |  50 +--
 drivers/regulator/irq_helpers.c                    |   2 +-
 drivers/regulator/mt6358-regulator.c               |  87 +++--
 drivers/regulator/mt6359-regulator.c               |  19 +-
 drivers/regulator/mt6397-regulator.c               |  15 +-
 drivers/regulator/rt5033-regulator.c               |  21 +-
 drivers/regulator/rt6245-regulator.c               |   2 +-
 drivers/regulator/rtq2134-regulator.c              | 373 +++++++++++++++++++++
 drivers/regulator/rtq6752-regulator.c              | 289 ++++++++++++++++
 drivers/regulator/sy7636a-regulator.c              |  41 ++-
 drivers/regulator/sy8824x.c                        |  16 +-
 drivers/regulator/sy8827n.c                        |  14 +
 drivers/regulator/tps65910-regulator.c             |  10 +-
 drivers/regulator/vctrl-regulator.c                |  73 ++--
 include/linux/mfd/rt5033-private.h                 |   4 +-
 include/linux/regulator/consumer.h                 |  15 -
 include/linux/regulator/driver.h                   |  16 +-
 include/linux/regulator/machine.h                  |   2 +-
 29 files changed, 1562 insertions(+), 417 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2134-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
 create mode 100644 drivers/regulator/rtq2134-regulator.c
 create mode 100644 drivers/regulator/rtq6752-regulator.c
