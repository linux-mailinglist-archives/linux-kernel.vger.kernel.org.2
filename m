Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFF390356
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhEYOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:06:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233542AbhEYOFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:05:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B611A142F;
        Tue, 25 May 2021 07:04:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E2213F792;
        Tue, 25 May 2021 07:04:20 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, gerg@linux-m68k.org, green.hu@gmail.com,
        guoren@kernel.org, ink@jurassic.park.msu.ru,
        James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
        jonas@southpole.se, ley.foon.tan@intel.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Subject: [PATCH v2 04/33] locking/atomic: microblaze: use asm-generic exclusively
Date:   Tue, 25 May 2021 15:02:03 +0100
Message-Id: <20210525140232.53872-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210525140232.53872-1-mark.rutland@arm.com>
References: <20210525140232.53872-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microblaze provides its own implementation of atomic_dec_if_positive(),
but nothing else. For a while now, the conditional inc/dec ops have been
optional, and the core code will provide generic implementations using
the code templates in scripts/atomic/fallbacks/.

For simplicity, and for consistency with the other conditional atomic
ops, let's drop the microblaze implementation of
atomic_dec_if_positive(), and use the generic implementation.

With that, we can also drop the local asm/atomic.h and asm/cmpxchg.h
headers, as asm-generic/atomic.h is mandatory-y, and we can pull in
asm-generic/cmpxchg.h via generic-y. This matches what nios2 and nds32
do today.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/microblaze/include/asm/Kbuild    |  1 +
 arch/microblaze/include/asm/atomic.h  | 28 ----------------------------
 arch/microblaze/include/asm/cmpxchg.h |  9 ---------
 3 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/atomic.h
 delete mode 100644 arch/microblaze/include/asm/cmpxchg.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 29b0e557aa7c..a055f5dbe00a 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
+generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/microblaze/include/asm/atomic.h b/arch/microblaze/include/asm/atomic.h
deleted file mode 100644
index 41e9aff23a62..000000000000
diff --git a/arch/microblaze/include/asm/cmpxchg.h b/arch/microblaze/include/asm/cmpxchg.h
deleted file mode 100644
index 3523b51aab36..000000000000
-- 
2.11.0

