Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFF454B05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbhKQQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:34:52 -0500
Received: from foss.arm.com ([217.140.110.172]:60574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239159AbhKQQen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:34:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AEAF1474;
        Wed, 17 Nov 2021 08:31:44 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 296653F5A1;
        Wed, 17 Nov 2021 08:31:41 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, efuller@redhat.com,
        elver@google.com, ink@jurassic.park.msu.ru, joey.gouly@arm.com,
        jonas@southpole.se, juri.lelli@redhat.com, linux@armlinux.org.uk,
        luto@kernel.org, mark.rutland@arm.com, mattst88@gmail.com,
        michal.simek@xilinx.com, mingo@redhat.com, npiggin@gmail.com,
        paulmck@kernel.org, paulus@samba.org, peterz@infradead.org,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCHv7 09/11] powerpc: avoid discarding flags in system_call_exception()
Date:   Wed, 17 Nov 2021 16:30:47 +0000
Message-Id: <20211117163050.53986-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117163050.53986-1-mark.rutland@arm.com>
References: <20211117163050.53986-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Thus, when setting flags
we must use an atomic operation rather than a plain read-modify-write
sequence, as a plain read-modify-write may discard flags which are
concurrently set by a remote thread, e.g.

	// task A			// task B
	tmp = A->thread_info.flags;
					set_tsk_thread_flag(A, NEWFLAG_B);
	tmp |= NEWFLAG_A;
	A->thread_info.flags = tmp;

In arch/powerpc/kernel/interrupt.c's system_call_exception(), we set
_TIF_RESTOREALL in the thread info flags with a read-modify-write, which
may result in other flags being discarded.

Elsewhere in the file we use clear_bits() to atomically remove flag
bits, so let's use set_bits() here for consistency with those.

I presume there may be reasons (e.g. instrumentation) that prevent the
use of set_thread_flag() and clear_thread_flag() here, which would
otherwise be preferable.

Fixes: ae7aaecc3f2f78b7 ("powerpc/64s: system call rfscv workaround for TM bugs")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Eirik Fuller <efuller@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Michael, I found this by inspection when rebasing the rest of the series
to v5.16-rc1. Is this something you'd like to pick on its own? As the
commit message says, I'm not sure whether you can use
{set,clear}_thread_flag() here, or whether it was a deliberate choice to
avoid those.

Mark.

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 835b626cd476..1c821b76c2d1 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -148,7 +148,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	 */
 	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
 			unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
-		current_thread_info()->flags |= _TIF_RESTOREALL;
+		set_bits(_TIF_RESTOREALL, current_thread_info()->flags);
 
 	/*
 	 * If the system call was made with a transaction active, doom it and
-- 
2.11.0

