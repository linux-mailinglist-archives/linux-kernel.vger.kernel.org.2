Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22EC3C21BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhGIJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231827AbhGIJpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:45:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A37613C7;
        Fri,  9 Jul 2021 09:43:11 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1m1n2L-00CEGs-LW; Fri, 09 Jul 2021 10:43:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.14, take #1
Date:   Fri,  9 Jul 2021 10:43:06 +0100
Message-Id: <20210709094306.1459561-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux@roeck-us.net, rdunlap@infradead.org, fancer.lancer@gmail.com, tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here the first batch of fixes for 5.14. Only two patches this time,
both fixing issues introduced by the large irqdomain update during the
merge window.

One is a simple documentation update. The other is an interesting bug
affecting MIPS, where we were able to perform irqdomain look-ups
(which now implies using RCU at all times) without being in the right
context (straight out of idle, for example). The issue was always
there, we were just 'lucky' not to use RCU consistently in the
irqdomain code...

Please pull,

	M.

The following changes since commit c51e96dace68a67f1fcfa49d4ad1577875f50bf1:

  Merge branch irq/irqchip-driver-updates into irq/irqchip-next (2021-06-11 14:50:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.14-1

for you to fetch changes up to 1fee9db9b42d821e8007289d4eea74bdf85b1543:

  irqchip/mips: Fix RCU violation when using irqdomain lookup on interrupt entry (2021-07-09 10:18:58 +0100)

----------------------------------------------------------------
irqchip fixes for 5.14, take #1

- Fix a MIPS bug where irqdomain loopkups could occur in a context
  where RCU is not allowed

- Fix a documentation bug for handle_domain_irq

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/mips: Fix RCU violation when using irqdomain lookup on interrupt entry

Randy Dunlap (1):
      genirq/irqdesc: Drop excess kernel-doc entry @lookup

 arch/mips/include/asm/irq.h      |  3 +++
 arch/mips/kernel/irq.c           | 16 ++++++++++++++++
 drivers/irqchip/irq-mips-cpu.c   | 10 ++++++----
 drivers/irqchip/irq-mips-gic.c   |  8 ++++----
 drivers/irqchip/irq-pic32-evic.c |  5 ++---
 kernel/irq/irqdesc.c             |  1 -
 6 files changed, 31 insertions(+), 12 deletions(-)
