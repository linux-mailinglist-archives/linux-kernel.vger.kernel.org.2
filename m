Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3639F90C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhFHO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhFHO2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:28:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A585D60FDB;
        Tue,  8 Jun 2021 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623162420;
        bh=Z8fEMmWlqWDlXYS/x++QWYE8lKr7Z6rduKmNo70yTo4=;
        h=From:To:Cc:Subject:Date:From;
        b=OpRx9OzQPBhiTolVc6TXdUJLuqsFVwupXDplSueETbJ5i2ty6AecnJE0hzFmnI9yk
         h7+ejS+2+0OZ2Xu1CchqPZuw/DN+9lFsEmtqb9bvhphndiwAfwk0rE2HJam4HlBAEY
         h2sSZk2mxPuF/e30Mu/0MUaXZ0MncXCI38VSKYTeACcNVllt2v9Ou/ZMetgjIrY8WF
         NQD2D0BTf8Sb5rrwO4yum5AK+KRsB2FiIm2AQVRxRM7E1RunmVPQtay2fqWABVkOJf
         PjRzWXlFg5FCCxXXsb8uV1uOgA8nRuTsns0do2EqrMk0vysk5BlIVb3RguDBBOVrsR
         oC6V6rF57GAmg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.13-rc4
Date:   Tue, 08 Jun 2021 15:26:33 +0100
Message-Id: <20210608142659.A585D60FDB@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f80505fdff771c89c9350895e99140ffc824e564:

  regulator: Add binding for TCS4525 (2021-04-23 15:36:16 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.13-rc4

for you to fetch changes up to cb2381cbecb81a8893b2d1e1af29bc2e5531df27:

  regulator: rt4801: Fix NULL pointer dereference if priv->enable_gpios is NULL (2021-06-03 19:35:48 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.14

A collection of fixes for the regulator API that have come up since the
merge window, including a big batch of fixes from Axel Lin's usual
careful and detailed review.  The one stand out fix here is Dmitry
Baryshkov's fix for an issue where we fail to power on the parents of
always on regulators during system startup if they weren't already
powered on.

----------------------------------------------------------------
Axel Lin (14):
      regulator: cros-ec: Fix error code in dev_err message
      regulator: da9121: Return REGULATOR_MODE_INVALID for invalid mode
      regulator: fan53880: Fix missing n_voltages setting
      regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
      regulator: fixed: Ensure enable_counter is correct if reg_domain_disable fails
      regulator: scmi: Fix off-by-one for linear regulators .n_voltages setting
      regulator: bd70528: Fix off-by-one for buck123 .n_voltages setting
      regulator: bd71828: Fix .n_voltages settings
      regulator: rtmv20: Fix .set_current_limit/.get_current_limit callbacks
      regulator: rtmv20: Add Richtek to Kconfig text
      regulator: mt6315: Fix function prototype for mt6315_map_mode
      regulator: atc260x: Fix n_voltages and min_sel for pickable linear ranges
      regulator: hi6421v600: Fix .vsel_mask setting
      regulator: rt4801: Fix NULL pointer dereference if priv->enable_gpios is NULL

ChiYuan Huang (1):
      regulator: rtmv20: Fix to make regcache value first reading back from HW

Dmitry Baryshkov (1):
      regulator: core: resolve supply for boot-on/always-on regulators

Dmitry Osipenko (2):
      regulator: max77620: Use device_set_of_node_from_dev()
      regulator: max77620: Silence deferred probe error

Hao Fang (1):
      regulator: hisilicon: use the correct HiSilicon copyright

Mark Brown (2):
      Merge series "regulator: fan53555: tcs4525 fix and cleanup" from Peter Geis <pgwipeout@gmail.com>:
      Merge series "Fix MAX77620 regulator driver regression" from Dmitry Osipenko <digetx@gmail.com>:

Matti Vaittinen (1):
      regulator: bd718x7: Fix the BUCK7 voltage setting on BD71837

Peter Geis (1):
      regulator: fan53555: fix TCS4525 voltage calulation

 drivers/regulator/Kconfig                       |  2 +-
 drivers/regulator/atc260x-regulator.c           | 19 ++++++-----
 drivers/regulator/bd718x7-regulator.c           |  2 +-
 drivers/regulator/core.c                        |  6 ++++
 drivers/regulator/cros-ec-regulator.c           |  3 +-
 drivers/regulator/da9121-regulator.c            | 10 ++++--
 drivers/regulator/fan53555.c                    |  3 +-
 drivers/regulator/fan53880.c                    |  3 ++
 drivers/regulator/fixed.c                       |  7 +++-
 drivers/regulator/helpers.c                     |  2 +-
 drivers/regulator/hi655x-regulator.c            |  2 +-
 drivers/regulator/max77620-regulator.c          | 17 ++++++----
 drivers/regulator/mt6315-regulator.c            |  2 +-
 drivers/regulator/rt4801-regulator.c            |  4 +--
 drivers/regulator/rtmv20-regulator.c            | 44 +++++++++++++++++++++++--
 drivers/regulator/scmi-regulator.c              |  2 +-
 drivers/staging/hikey9xx/hi6421v600-regulator.c |  4 +--
 include/linux/mfd/rohm-bd70528.h                |  4 +--
 include/linux/mfd/rohm-bd71828.h                | 10 +++---
 19 files changed, 104 insertions(+), 42 deletions(-)
