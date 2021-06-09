Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB363A1431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbhFIMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:22:39 -0400
Received: from foss.arm.com ([217.140.110.172]:58674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235996AbhFIMW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:22:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC8A814FF;
        Wed,  9 Jun 2021 05:20:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CAC133F73D;
        Wed,  9 Jun 2021 05:20:30 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, vincent.guittot@linaro.org, will@kernel.org
Subject: [RFC PATCH 07/10] microblaze: snapshot thread flags
Date:   Wed,  9 Jun 2021 13:19:58 +0100
Message-Id: <20210609122001.18277-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210609122001.18277-1-mark.rutland@arm.com>
References: <20210609122001.18277-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, we should snapshot the flags prior to using them.
Let's use the new helpers to do so on microblaze.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index fc61eb0eb8dd..23e8a9336a29 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -283,7 +283,7 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
 #ifdef DEBUG_SIG
 	pr_info("do signal: %p %d\n", regs, in_syscall);
 	pr_info("do signal2: %lx %lx %ld [%lx]\n", regs->pc, regs->r1,
-			regs->r12, current_thread_info()->flags);
+			regs->r12, read_thread_flags());
 #endif
 
 	if (get_signal(&ksig)) {
-- 
2.11.0

