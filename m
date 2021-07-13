Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25BD3C6FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhGMLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:42:32 -0400
Received: from foss.arm.com ([217.140.110.172]:42190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236068AbhGMLma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:42:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A465CD6E;
        Tue, 13 Jul 2021 04:39:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8770C3F7D8;
        Tue, 13 Jul 2021 04:39:37 -0700 (PDT)
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
Subject: [PATCH v3 08/10] openrisc: snapshot thread flags
Date:   Tue, 13 Jul 2021 12:38:40 +0100
Message-Id: <20210713113842.2106-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210713113842.2106-1-mark.rutland@arm.com>
References: <20210713113842.2106-1-mark.rutland@arm.com>
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
Acked-by: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
---
 arch/openrisc/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 1ebcff271096..a730a914c2b4 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -315,7 +315,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 	return 0;
 }
-- 
2.11.0

