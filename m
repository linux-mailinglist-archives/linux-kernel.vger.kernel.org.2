Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC2430902
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhJQMpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232382AbhJQMo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:44:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFC060231;
        Sun, 17 Oct 2021 12:42:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V1-00HKfO-EH; Sun, 17 Oct 2021 13:42:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v4 00/17]  clocksource/arm_arch_timer: Add basic ARMv8.6 support
Date:   Sun, 17 Oct 2021 13:42:08 +0100
Message-Id: <20211017124225.3018098-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 (final?) of the series enabling ARMv8.6 support for timer
subsystem, and was prompted by a discussion with Oliver around the
fact that an ARMv8.6 implementation must have a 1GHz counter, which
leads to a number of things to break in the timer code:

- the counter rollover can come pretty quickly as we only advertise a
  56bit counter,
- the maximum timer delta can be remarkably small, as we use the
  countdown interface which is limited to 32bit...

Thankfully, there is a way out: we can compute the minimal width of
the counter based on the guarantees that the architecture gives us,
and we can use the 64bit comparator interface instead of the countdown
to program the timer.

Finally, we start making use of the ARMv8.6 ECV features by switching
accesses to the counters to a self-synchronising register, removing
the need for an ISB. Hopefully, implementations will *not* just stick
an invisible ISB there...

A side effect of the switch to CVAL is that XGene-1 breaks. I have
added a workaround to keep it alive.

I have added Oliver's original patch[0] to the series and tweaked a
couple of things. Blame me if I broke anything.

The whole things has been tested on Juno (sysreg + MMIO timers),
XGene-1 (broken sysreg timers), FVP (FEAT_ECV, CNT*CTSS_EL0).

To ease merging, and after discussion with Daniel, I have created two
tags from which the patches can be pulled from
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git :

- clocksource-timers-arm64-8.6 has the first 13 patches, which can
  go into Daniel's tree, and ultimately tip

- arm64-timers-8.6 has the full series, which can be pulled into
  the arm64 tree

Alternatively, Will and Daniel can synchronise independently to
build a branch of their own.

* From v3 [3]:
  - Drop the %x0 qualifiers for the registers in the asm accessors
  - Added an update to cpu-feature-registers.rst
  - Collected Acks, with thanks.

* From v2 [2]:
  - New patch adding a HWCAP (ECV) allowing userspace to probe for
    the presence of CNTVSS_EL0.

* From v1 [1]:
  - New patch adding a bunch of BUILD_BUG()s for register accesses we
    don't expect. This makes subsequent patches much simpler.
  - New patch moving the ISBs for workaround in a way that makes
    more sense for the self-synchronising accessors.
  - Rework the XGene-1 workaround to rely solely on MIDR.
  - Split the CNTVCTSS trap handling in its own patch.
  - Rebased on 5.15-rc2
  - Collected RBs, with thanks.

[0] https://lore.kernel.org/r/20210807191428.3488948-1-oupton@google.com
[1] https://lore.kernel.org/r/20210809152651.2297337-2-maz@kernel.org
[2] https://lore.kernel.org/r/20210922211941.2756270-1-maz@kernel.org
[3] https://lore.kernel.org/r/20211010114306.2910453-1-maz@kernel.org

Marc Zyngier (16):
  clocksource/arm_arch_timer: Add build-time guards for unhandled
    register accesses
  clocksource/arm_arch_timer: Drop CNT*_TVAL read accessors
  clocksource/arm_arch_timer: Extend write side of timer register
    accessors to u64
  clocksource/arm_arch_timer: Move system register timer programming
    over to CVAL
  clocksource/arm_arch_timer: Move drop _tval from erratum function
    names
  clocksource/arm_arch_timer: Fix MMIO base address vs callback ordering
    issue
  clocksource/arm_arch_timer: Move MMIO timer programming over to CVAL
  clocksource/arm_arch_timer: Advertise 56bit timer to the core code
  clocksource/arm_arch_timer: Work around broken CVAL implementations
  clocksource/arm_arch_timer: Remove any trace of the TVAL programming
    interface
  clocksource/arm_arch_timer: Drop unnecessary ISB on CVAL programming
  clocksource/arch_arm_timer: Move workaround synchronisation around
  arm64: Add a capability for FEAT_ECV
  arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0
  arm64: Add handling of CNTVCTSS traps
  arm64: Add HWCAP for self-synchronising virtual counter

Oliver Upton (1):
  clocksource/arm_arch_timer: Fix masking for high freq counters

 Documentation/arm64/cpu-feature-registers.rst |  12 +-
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 arch/arm/include/asm/arch_timer.h             |  37 +--
 arch/arm64/include/asm/arch_timer.h           |  78 +++---
 arch/arm64/include/asm/esr.h                  |   6 +
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/sysreg.h               |   3 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/kernel/cpufeature.c                |  13 +-
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/traps.c                     |  11 +
 arch/arm64/tools/cpucaps                      |   1 +
 drivers/clocksource/arm_arch_timer.c          | 243 +++++++++++-------
 include/clocksource/arm_arch_timer.h          |   2 +-
 14 files changed, 264 insertions(+), 149 deletions(-)

-- 
2.30.2

