Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314583B65AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhF1Pdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhF1PHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C5CB61221;
        Mon, 28 Jun 2021 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624892082;
        bh=YktmvOo6I/38VMesbg8uHTU9HrJHbfBNO3dk0+9OyGA=;
        h=From:To:Cc:Subject:Date:From;
        b=afWBYeXsQ3VAcL8j9kO6VP01f7pkStwgluFxv4TlfuSGvLCfRhVbNsQwtB7tLlaOV
         Btp/VqMWQIolUSDZEmYSKJpq7/vW5VegE7VvceYP+BYErksF/LQqXnaTJA/gtgLC7w
         /tBf/nrHj9/tuHcsA3ZwSRibETfL3Ko99L7Waf3SeyVDPetwFOD4YuiNvoMUp+A6Yi
         +VM3ueKc+mpcpyjgdingyI/pfBhcCMcLyf3+nOJ+8SFfAEGA0iimRVUwAwCPIeS9dd
         8yFsp06k92LCzgfxt98FFkRqpQr9RGvFMnHp2QHgBc3JarCxU7uxLA1aDkfVE/m+VI
         cA+alvoWweDgg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.14
Date:   Mon, 28 Jun 2021 15:54:02 +0100
Message-Id: <20210628145442.0C5CB61221@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.14

for you to fetch changes up to d17032f2befaceef2c8c6b761ae657bc700b0be3:

  Merge remote-tracking branch 'regmap/for-5.14' into regmap-next (2021-06-14 20:41:59 +0100)

----------------------------------------------------------------
regmap: Updates for v5.14

The big thing this release is support for accessing the register maps of
MDIO devices via the framework.  We've also added support for 7/17
register formats on bytestream transports and inverted status registers
in regmap-irq.

----------------------------------------------------------------
Andy Shevchenko (1):
      regmap: mdio: Don't modify output if error happened

Antoniu Miclaus (1):
      regmap: add support for 7/17 register formating

Lucas Tanure (1):
      regmap-i2c: Set regmap max raw r/w from quirks

Mark Brown (2):
      Merge series "RTL8231 GPIO expander support" from Sander Vanheule <sander@svanheule.net>:
      Merge remote-tracking branch 'regmap/for-5.14' into regmap-next

Maxim Kochetkov (1):
      regmap-irq: Introduce inverted status registers support

Sander Vanheule (5):
      regmap: Add MDIO bus support
      regmap: mdio: Clean up invalid clause-22 addresses
      regmap: mdio: Add clause-45 support
      regmap: mdio: Fix regmap_bus pointer constness
      regmap: mdio: Reject invalid addresses

 drivers/base/regmap/Kconfig       |   6 +-
 drivers/base/regmap/Makefile      |   1 +
 drivers/base/regmap/regmap-i2c.c  |  45 ++++++++++++---
 drivers/base/regmap/regmap-irq.c  |   7 +++
 drivers/base/regmap/regmap-mdio.c | 116 ++++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap.c      |  15 +++++
 include/linux/regmap.h            |  40 +++++++++++++
 7 files changed, 222 insertions(+), 8 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-mdio.c
