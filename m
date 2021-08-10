Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955563E48D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhHIP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhHIP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:27:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7815F60EBB;
        Mon,  9 Aug 2021 15:26:57 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD7B1-003qjI-FU; Mon, 09 Aug 2021 16:26:55 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH 00/13] clocksource/arm_arch_timer: Add basic ARMv8.6 support
Date:   Mon,  9 Aug 2021 16:26:38 +0100
Message-Id: <20210809152651.2297337-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, will@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series has been prompted by a discussion with Oliver around
the fact that an ARMv8.6 implementation must have a 1GHz counter,
which leads to a number of things to break in the timer code:

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

[0] https://lore.kernel.org/r/20210807191428.3488948-1-oupton@google.com

Marc Zyngier (12):
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
  arm64: Add a capability for FEAT_EVC
  arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0

Oliver Upton (1):
  clocksource/arm_arch_timer: Fix masking for high freq counters

 arch/arm/include/asm/arch_timer.h    |  29 ++--
 arch/arm64/include/asm/arch_timer.h  |  65 +++----
 arch/arm64/include/asm/esr.h         |   6 +
 arch/arm64/include/asm/sysreg.h      |   3 +
 arch/arm64/kernel/cpufeature.c       |  10 ++
 arch/arm64/kernel/traps.c            |  11 ++
 arch/arm64/tools/cpucaps             |   1 +
 drivers/clocksource/arm_arch_timer.c | 249 ++++++++++++++++-----------
 include/clocksource/arm_arch_timer.h |   2 +-
 9 files changed, 234 insertions(+), 142 deletions(-)

-- 
2.30.2

