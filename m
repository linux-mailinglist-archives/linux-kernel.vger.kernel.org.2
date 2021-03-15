Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94433B1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCOL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:56:48 -0400
Received: from foss.arm.com ([217.140.110.172]:35028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhCOL4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:56:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E979D6E;
        Mon, 15 Mar 2021 04:56:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56EF03F792;
        Mon, 15 Mar 2021 04:56:36 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com
Cc:     james.morse@arm.com, marcan@marcan.st, mark.rutland@arm.com,
        maz@kernel.org, tglx@linutronix.de
Subject: [PATCHv3 0/6] arm64: Support FIQ controller registration
Date:   Mon, 15 Mar 2021 11:56:23 +0000
Message-Id: <20210315115629.57191-1-mark.rutland@arm.com>
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

The first four patches move arm64 over to a local set_handle_irq()
implementation, which is written to share code with a set_handle_fiq() function
in the last two patches. This adds a default handler which will directly
panic() rather than branching to NULL if an IRQ is taken unexpectedly, and the
boot-time panic in the absence of a handler is removed (for consistently with
FIQ support added later).

The penultimate patch reworks arm64's IRQ masking to always keep DAIF.[IF] in
sync, so that we can treat IRQ and FIQ as equals. This is cherry-picked from
Hector's reply [2] to the first version of this series.

The final patch adds the low-level FIQ exception handling and registration
mechanism atop the prior rework.

I'm hoping this is ready to be merged into the arm64 tree, given the
preparatory cleanup made it into v5.12-rc3. I've pushed the series out to my
arm64/fiq branch [3] on kernel.org, also tagged as arm64-fiq-20210315, atop
v5.12-rc3.

Since v1 [4]:
* Rebase to v5.12-rc1
* Pick up Hector's latest DAIF.[IF] patch
* Use "root {IRQ,FIQ} handler" rather than "{IRQ,FIQ} controller"
* Remove existing panic per Marc's comments
* Log registered root handlers
* Make default root handlers static
* Remove redundant el0_fiq_invalid_compat, per Joey's comments

Since v2 [5]:
* Fold in Hector's Tested-by tags
* Rebase to v5.12-rc3
* Drop patches merged in v5.12-rc3

[1] https://http://lore.kernel.org/r/20210215121713.57687-1-marcan@marcan.st
[2] https://lore.kernel.org/r/20210219172530.45805-1-marcan@marcan.st
[3] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/fiq
[4] https://lore.kernel.org/r/20210219113904.41736-1-mark.rutland@arm.com
[5] https://lore.kernel.org/r/20210302101211.2328-1-mark.rutland@arm.com

Thanks,
Mark.

Hector Martin (1):
  arm64: Always keep DAIF.[IF] in sync

Marc Zyngier (3):
  genirq: Allow architectures to override set_handle_irq() fallback
  arm64: don't use GENERIC_IRQ_MULTI_HANDLER
  arm64: entry: factor irq triage logic into macros

Mark Rutland (2):
  arm64: irq: rework root IRQ handler registration
  arm64: irq: allow FIQs to be handled

 arch/arm64/Kconfig                  |   1 -
 arch/arm64/include/asm/arch_gicv3.h |   2 +-
 arch/arm64/include/asm/assembler.h  |   8 +--
 arch/arm64/include/asm/daifflags.h  |  10 ++--
 arch/arm64/include/asm/irq.h        |   4 ++
 arch/arm64/include/asm/irqflags.h   |  16 +++--
 arch/arm64/kernel/entry.S           | 114 +++++++++++++++++++++---------------
 arch/arm64/kernel/irq.c             |  35 ++++++++++-
 arch/arm64/kernel/process.c         |   2 +-
 arch/arm64/kernel/smp.c             |   1 +
 include/linux/irq.h                 |   2 +
 11 files changed, 125 insertions(+), 70 deletions(-)

-- 
2.11.0

