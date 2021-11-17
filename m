Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D6454AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhKQQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:34:32 -0500
Received: from foss.arm.com ([217.140.110.172]:60396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239112AbhKQQe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:34:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F069213A1;
        Wed, 17 Nov 2021 08:31:29 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EB143F5A1;
        Wed, 17 Nov 2021 08:31:26 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, efuller@redhat.com,
        elver@google.com, ink@jurassic.park.msu.ru, joey.gouly@arm.com,
        jonas@southpole.se, juri.lelli@redhat.com, linux@armlinux.org.uk,
        luto@kernel.org, mark.rutland@arm.com, mattst88@gmail.com,
        michal.simek@xilinx.com, mingo@redhat.com, mpe@ellerman.id.au,
        npiggin@gmail.com, paulmck@kernel.org, paulus@samba.org,
        peterz@infradead.org, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCHv7 05/11] arm: snapshot thread flags
Date:   Wed, 17 Nov 2021 16:30:43 +0000
Message-Id: <20211117163050.53986-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117163050.53986-1-mark.rutland@arm.com>
References: <20211117163050.53986-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kernel/signal.c | 2 +-
 arch/arm/mm/alignment.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a41e27ace391..c532a6041066 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -631,7 +631,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 	return 0;
 }
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index ea81e89e7740..adbb3817d0be 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -990,7 +990,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		 * there is no work pending for this thread.
 		 */
 		raw_local_irq_disable();
-		if (!(current_thread_info()->flags & _TIF_WORK_MASK))
+		if (!(read_thread_flags() & _TIF_WORK_MASK))
 			set_cr(cr_no_alignment);
 	}
 
-- 
2.11.0

