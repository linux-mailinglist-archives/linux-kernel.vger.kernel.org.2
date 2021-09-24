Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21B5416E91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbhIXJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245142AbhIXJLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:11:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D29C6103B;
        Fri, 24 Sep 2021 09:09:39 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mThD7-00CiS2-45; Fri, 24 Sep 2021 10:09:37 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Kaige Fu <kaige.fu@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yun Wu <wuyun.wu@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.15, take #1
Date:   Fri, 24 Sep 2021 10:09:33 +0100
Message-Id: <20210924090933.2766857-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, yashsri421@gmail.com, aleksandar.markovic@mips.com, bgolaszewski@baylibre.com, cuibixuan@huawei.com, geert@linux-m68k.org, geert+renesas@glider.be, goran.ferenc@mips.com, kaige.fu@linux.alibaba.com, lkp@intel.com, miodrag.dinic@mips.com, rdunlap@infradead.org, s.trumtrar@pengutronix.de, sfr@canb.auug.org.au, uli+renesas@fpond.eu, valentin.schneider@arm.com, wuyun.wu@huawei.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a handful of irqchip/irqdomain fixes for 5.15. The biggest
items here are a fix for a regression on the Armada 370-XP platform,
as well as a workaround for an odd Renesas platform.

The rest of the usual set of cleanups and documentation update.

Please pull,

	M.

The following changes since commit 6e3b473ee06445d4eae2f8b1e143db70ed66f519:

  Merge branch irq/qcom-pdc-nowake-cleanup into irq/irqchip-next (2021-08-23 09:50:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.15-1

for you to fetch changes up to b78f26926b17cc289e4f16b63363abe0aa2e8efc:

  irqchip/gic: Work around broken Renesas integration (2021-09-22 14:44:25 +0100)

----------------------------------------------------------------
irqchip fixes for 5.15, take #1

- Work around a bad GIC integration on a Renesas platform, where the
  interconnect cannot deal with byte-sized MMIO accesses

- Cleanup another Renesas driver abusing the comma operator

- Fix a potential GICv4 memory leak on an error path

- Make the type of 'size' consistent with the rest of the code in
  __irq_domain_add()

- Fix a regression in the Armada 370-XP IPI path

- Fix the build for the obviously unloved goldfish-pic

- Some documentation fixes

----------------------------------------------------------------
Bixuan Cui (1):
      irqdomain: Change the type of 'size' in __irq_domain_add() to be consistent

Geert Uytterhoeven (1):
      irqchip/renesas-rza1: Use semicolons instead of commas

Kaige Fu (1):
      irqchip/gic-v3-its: Fix potential VPE leak on error

Marc Zyngier (3):
      Documentation: Fix irq-domain.rst build warning
      irqchip/armada-370-xp: Fix ack/eoi breakage
      irqchip/gic: Work around broken Renesas integration

Randy Dunlap (2):
      irqchip/mbigen: Repair non-kernel-doc notation
      irqchip/goldfish-pic: Select GENERIC_IRQ_CHIP to fix build

 Documentation/core-api/irq/irq-domain.rst |  5 +--
 drivers/irqchip/Kconfig                   |  1 +
 drivers/irqchip/irq-armada-370-xp.c       |  4 +--
 drivers/irqchip/irq-gic-v3-its.c          |  2 +-
 drivers/irqchip/irq-gic.c                 | 52 ++++++++++++++++++++++++++++++-
 drivers/irqchip/irq-mbigen.c              |  6 ++--
 drivers/irqchip/irq-renesas-rza1.c        | 12 +++----
 include/linux/irqdomain.h                 |  2 +-
 kernel/irq/irqdomain.c                    |  2 +-
 9 files changed, 69 insertions(+), 17 deletions(-)
