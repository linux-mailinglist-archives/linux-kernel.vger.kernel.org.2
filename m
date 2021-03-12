Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF925339309
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhCLQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhCLQUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:20:43 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFE764F9E;
        Fri, 12 Mar 2021 16:20:43 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lKkWn-001GPo-GO; Fri, 12 Mar 2021 16:20:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip/irqdomain fixes for 5.12, take #1
Date:   Fri, 12 Mar 2021 16:20:16 +0000
Message-Id: <20210312162016.3921500-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, gregkh@linuxfoundation.org, marcan@marcan.st, mark.rutland@arm.com, paul@crapouillou.net, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the very small first set of irqchip/irqdomain fixes for
5.12. We have the usual DT updates for new SoCs, a debugfs cleanup,
and some Kconfig cleanups ahead of the arm64 changes that are planned
for 5.13.

Please pull,

	M.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.12-1

for you to fetch changes up to 5fbecd2389f48e1415799c63130d0cdce1cf3f60:

  irqchip/ingenic: Add support for the JZ4760 (2021-03-09 08:45:17 +0000)

----------------------------------------------------------------
irqchip fixes for 5.12, take #1

- More compatible strings for the Ingenic irqchip (introducing the
  JZ4760B SoC)
- Select GENERIC_IRQ_MULTI_HANDLER on the ARM ep93xx platform
- Drop all GENERIC_IRQ_MULTI_HANDLER selections from the irqchip
  Kconfig, now relying on the architecture to get it right
- Drop the debugfs_file field from struct irq_domain, now that
  debugfs can track things on its own

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      irqdomain: Remove debugfs_file from struct irq_domain

Marc Zyngier (2):
      ARM: ep93xx: Select GENERIC_IRQ_MULTI_HANDLER directly
      irqchip: Do not blindly select CONFIG_GENERIC_IRQ_MULTI_HANDLER

Paul Cercueil (2):
      dt-bindings/irq: Add compatible string for the JZ4760B
      irqchip/ingenic: Add support for the JZ4760

 .../devicetree/bindings/interrupt-controller/ingenic,intc.yaml   | 1 +
 arch/arm/Kconfig                                                 | 1 +
 drivers/irqchip/Kconfig                                          | 9 ---------
 drivers/irqchip/irq-ingenic-tcu.c                                | 1 +
 drivers/irqchip/irq-ingenic.c                                    | 1 +
 include/linux/irqdomain.h                                        | 4 ----
 kernel/irq/irqdomain.c                                           | 9 ++++-----
 7 files changed, 8 insertions(+), 18 deletions(-)
