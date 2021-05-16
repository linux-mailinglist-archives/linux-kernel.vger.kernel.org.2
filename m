Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1730381EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhEPMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhEPMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:23:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD9C601FC;
        Sun, 16 May 2021 12:22:36 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1liFn0-001eaK-OP; Sun, 16 May 2021 13:22:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Hector Martin <marcan@marcan.st>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.13, take #1
Date:   Sun, 16 May 2021 13:22:17 +0100
Message-Id: <20210516122217.13234-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, geert+renesas@glider.be, linux@roeck-us.net, marcan@marcan.st, thunder.leizhen@huawei.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a very small set of irqchip fixes for 5.13, two being
regressions introduced in the last merge window. One fixes an irqdesc
allocation issue on a PXA machine, the other limits the selection of
the Apple AIC controller to configuration that select support for the
Apple M1 system. Finally, a few useless error messages are removed.

Please pull,

	M.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.13-1

for you to fetch changes up to fbb80d5ad400a12ec67214a0e7e9f9497dc9e615:

  irqchip: Remove redundant error printing (2021-05-16 13:07:18 +0100)

----------------------------------------------------------------
irqchip fixes for 5.13, take #1

- Fix PXA Mainstone CPLD irq allocation in legacy mode
- Restrict the Apple AIC controller to the Apple platform
- Remove a few supperfluous messages on devm_ioremap_resource() failure

----------------------------------------------------------------
Geert Uytterhoeven (1):
      irqchip/apple-aic: APPLE_AIC should depend on ARCH_APPLE

Marc Zyngier (1):
      ARM: PXA: Fix cplds irqdesc allocation when using legacy mode

Zhen Lei (1):
      irqchip: Remove redundant error printing

 arch/arm/mach-pxa/pxa_cplds_irqs.c | 7 ++++++-
 drivers/irqchip/Kconfig            | 2 +-
 drivers/irqchip/irq-mvebu-icu.c    | 4 +---
 drivers/irqchip/irq-mvebu-sei.c    | 4 +---
 drivers/irqchip/irq-stm32-exti.c   | 4 +---
 5 files changed, 10 insertions(+), 11 deletions(-)
