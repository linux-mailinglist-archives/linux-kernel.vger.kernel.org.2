Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3A3D8492
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhG1ARi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 20:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232885AbhG1ARh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 20:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52F4460EBB;
        Wed, 28 Jul 2021 00:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627431456;
        bh=R091R1EdVgUe6e6xsiZzOhnDa+5d7tNd55ALyjN6NYk=;
        h=From:To:Cc:Subject:Date:From;
        b=AqyI+ulmGEnfHIJjk7i3DFjlehviw61gEnWnPpzZ7DPRC5e4F8Sr1/AuGkny2uhaZ
         HlWYCw6DkC871jn50WHEpUMwb9vMB6d+nSg10Tj5PIA/w+rNes52ZMJDGmwxtf/k7t
         2sC5SMLZg/CpBy/cCnSjxlv4YPAYJulrXTxi2k4WCV3BxkVe7eb6Z/XXnGgD6I8WsF
         d8SSDg2qMBP73pgQuqfRyiBpK1HwbM7ph07eB5dKtn+ugZj4OjtRijEvW7iqvy2Nqa
         AU4zXLj01XUa6GA6/pEInOcxA8NMZ/uvTmlu+MBt2Qsn+uv5a8TmgLMiWgtsaK3NRt
         0KBnuxDUnKzRQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] hexagon: Clean up timer-regs.h
Date:   Tue, 27 Jul 2021 17:17:29 -0700
Message-Id: <20210728001729.1960182-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.264.g75ae10bc75
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allmodconfig, there is a warning about TIMER_ENABLE being
redefined:

 drivers/clocksource/timer-oxnas-rps.c:39:9: warning: 'TIMER_ENABLE'
 macro redefined [-Wmacro-redefined]
 #define TIMER_ENABLE            BIT(7)
         ^
 arch/hexagon/include/asm/timer-regs.h:13:9: note: previous definition
 is here
 #define TIMER_ENABLE            0
         ^
 1 warning generated.

The values in this header are only used in one file each, if they are
used at all. Remove the header and sink all of the constants into their
respective files.

TCX0_CLK_RATE is only used in arch/hexagon/include/asm/timex.h

TIMER_ENABLE, RTOS_TIMER_INT, RTOS_TIMER_REGS_ADDR are only used in
arch/hexagon/kernel/time.c.

SLEEP_CLK_RATE and TIMER_CLR_ON_MATCH have both been unused since the
file's introduction in commit 71e4a47f32f4 ("Hexagon: Add time and timer
functions").

TIMER_ENABLE is redefined as BIT(0) so the shift is moved into the
definition, rather than its use.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/hexagon/include/asm/timer-regs.h | 26 --------------------------
 arch/hexagon/include/asm/timex.h      |  3 +--
 arch/hexagon/kernel/time.c            | 12 ++++++++++--
 3 files changed, 11 insertions(+), 30 deletions(-)
 delete mode 100644 arch/hexagon/include/asm/timer-regs.h

diff --git a/arch/hexagon/include/asm/timer-regs.h b/arch/hexagon/include/asm/timer-regs.h
deleted file mode 100644
index ee6c61423a05..000000000000
--- a/arch/hexagon/include/asm/timer-regs.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Timer support for Hexagon
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- */
-
-#ifndef _ASM_TIMER_REGS_H
-#define _ASM_TIMER_REGS_H
-
-/*  This stuff should go into a platform specific file  */
-#define TCX0_CLK_RATE		19200
-#define TIMER_ENABLE		0
-#define TIMER_CLR_ON_MATCH	1
-
-/*
- * 8x50 HDD Specs 5-8.  Simulator co-sim not fixed until
- * release 1.1, and then it's "adjustable" and probably not defaulted.
- */
-#define RTOS_TIMER_INT		3
-#ifdef CONFIG_HEXAGON_COMET
-#define RTOS_TIMER_REGS_ADDR	0xAB000000UL
-#endif
-#define SLEEP_CLK_RATE		32000
-
-#endif
diff --git a/arch/hexagon/include/asm/timex.h b/arch/hexagon/include/asm/timex.h
index 8d4ec76fceb4..dfe69e118b2b 100644
--- a/arch/hexagon/include/asm/timex.h
+++ b/arch/hexagon/include/asm/timex.h
@@ -7,11 +7,10 @@
 #define _ASM_TIMEX_H
 
 #include <asm-generic/timex.h>
-#include <asm/timer-regs.h>
 #include <asm/hexagon_vm.h>
 
 /* Using TCX0 as our clock.  CLOCK_TICK_RATE scheduled to be removed. */
-#define CLOCK_TICK_RATE              TCX0_CLK_RATE
+#define CLOCK_TICK_RATE              19200
 
 #define ARCH_HAS_READ_CURRENT_TIMER
 
diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index feffe527ac92..febc95714d75 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -17,9 +17,10 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 
-#include <asm/timer-regs.h>
 #include <asm/hexagon_vm.h>
 
+#define TIMER_ENABLE		BIT(0)
+
 /*
  * For the clocksource we need:
  *	pcycle frequency (600MHz)
@@ -33,6 +34,13 @@ cycles_t	pcycle_freq_mhz;
 cycles_t	thread_freq_mhz;
 cycles_t	sleep_clk_freq;
 
+/*
+ * 8x50 HDD Specs 5-8.  Simulator co-sim not fixed until
+ * release 1.1, and then it's "adjustable" and probably not defaulted.
+ */
+#define RTOS_TIMER_INT		3
+#define RTOS_TIMER_REGS_ADDR	0xAB000000UL
+
 static struct resource rtos_timer_resources[] = {
 	{
 		.start	= RTOS_TIMER_REGS_ADDR,
@@ -80,7 +88,7 @@ static int set_next_event(unsigned long delta, struct clock_event_device *evt)
 	iowrite32(0, &rtos_timer->clear);
 
 	iowrite32(delta, &rtos_timer->match);
-	iowrite32(1 << TIMER_ENABLE, &rtos_timer->enable);
+	iowrite32(TIMER_ENABLE, &rtos_timer->enable);
 	return 0;
 }
 

base-commit: 7d549995d4e0d99b68e8a7793a0d23da6fc40fe8
-- 
2.32.0.264.g75ae10bc75

