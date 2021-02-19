Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BF531F87F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhBSLj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:39:59 -0500
Received: from foss.arm.com ([217.140.110.172]:34158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSLj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:39:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBBDA106F;
        Fri, 19 Feb 2021 03:39:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 852903F694;
        Fri, 19 Feb 2021 03:39:09 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 0/8] arm64: Support FIQ controller registration
Date:   Fri, 19 Feb 2021 11:38:56 +0000
Message-Id: <20210219113904.41736-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hector's M1 support series [1] shows that some platforms have critical
interrupts wired to FIQ, and to support these platforms we need to support
handling FIQ exceptions. Other contemporary platforms don't use FIQ (since e.g.
this is usually routed to EL3), and as we never expect to take an FIQ, we have
the FIQ vector cause a panic.

Since the use of FIQ is a platform integration detail (which can differ across
bare-metal and virtualized environments), we need be able to explicitly opt-in
to handling FIQs while retaining the existing behaviour otherwise. This series
adds a new set_handle_fiq() hook so that the FIQ controller can do so, and
where no controller is registered the default handler will panic(). For
consistency the set_handle_irq() code is made to do the same.

The first couple of patches are from Marc's irq/drop-generic_irq_multi_handler
branch [2] on kernel.org, and clean up CONFIG_GENERIC_IRQ_MULTI_HANDLER usage.
The next four patches move arm64 over to a local set_handle_irq()
implementation, which is written to share code with a set_handle_fiq() function
in the last two patches. The only functional difference here is that if an IRQ
is somehow taken prior to set_handle_irq() the default handler will directly
panic() rather than the vector branching to NULL.

The penultimate patch is cherry-picked from the v2 M1 series, and as per
discussion there [3] will need a few additional fixups. I've included it for
now as the DAIF.IF alignment is necessary for the FIQ exception handling added
in the final patch.

The final patch adds the low-level FIQ exception handling and registration
mechanism atop the prior rework.

I'm hoping that we can somehow queue the first 6 patches of this series as a
base for the M1 support. With that we can either cherry-pick a later version of
the DAIF.IF patch here, or the M1 support series can take the FIQ handling
patch. I've pushed the series out to my arm64/fiq branch [4] on kernel.org,
atop v5.11.

Thanks,
Mark.

[1] https://http://lore.kernel.org/r/20210215121713.57687-1-marcan@marcan.st
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/drop-generic_irq_multi_handler
[3] https://lore.kernelo.org/r/20210215121713.57687-9-marcan@marcan.st
[4] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/fiq

Hector Martin (1):
  arm64: Always keep DAIF.[IF] in sync

Marc Zyngier (5):
  ARM: ep93xx: Select GENERIC_IRQ_MULTI_HANDLER directly
  irqchip: Do not blindly select CONFIG_GENERIC_IRQ_MULTI_HANDLER
  genirq: Allow architectures to override set_handle_irq() fallback
  arm64: don't use GENERIC_IRQ_MULTI_HANDLER
  arm64: entry: factor irq triage logic into macros

Mark Rutland (2):
  arm64: irq: add a default handle_irq panic function
  arm64: irq: allow FIQs to be handled

 arch/arm/Kconfig                   |   1 +
 arch/arm64/Kconfig                 |   1 -
 arch/arm64/include/asm/assembler.h |   6 +--
 arch/arm64/include/asm/daifflags.h |   4 +-
 arch/arm64/include/asm/irq.h       |   4 ++
 arch/arm64/include/asm/irqflags.h  |  19 ++++---
 arch/arm64/kernel/entry.S          | 108 ++++++++++++++++++++++---------------
 arch/arm64/kernel/irq.c            |  33 +++++++++++-
 drivers/irqchip/Kconfig            |   9 ----
 include/linux/irq.h                |   2 +
 10 files changed, 121 insertions(+), 66 deletions(-)

-- 
2.11.0

