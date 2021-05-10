Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF51D377F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEJJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:40:41 -0400
Received: from foss.arm.com ([217.140.110.172]:50506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhEJJkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:40:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963C911D4;
        Mon, 10 May 2021 02:39:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D2D83F73B;
        Mon, 10 May 2021 02:39:23 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mark.rutland@arm.com, mattst88@gmail.com,
        monstr@monstr.eu, mpe@ellerman.id.au, nickhu@andestech.com,
        palmer@dabbelt.com, paulus@samba.org, paul.walmsley@sifive.com,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: [PATCH 03/33] locking/atomic: h8300: use asm-generic exclusively
Date:   Mon, 10 May 2021 10:37:23 +0100
Message-Id: <20210510093753.40683-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As h8300's implementation of the atomics isn't using any arch-specific
functionality, and its implementation of cmpxchg only uses assembly to
non-atomically swap two elements in memory, we may as well use the
asm-generic atomic.h and cmpxchg.h, and avoid the duplicate code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/include/asm/Kbuild    |  1 +
 arch/h8300/include/asm/atomic.h  | 97 ----------------------------------------
 arch/h8300/include/asm/cmpxchg.h | 66 ---------------------------
 3 files changed, 1 insertion(+), 163 deletions(-)
 delete mode 100644 arch/h8300/include/asm/atomic.h
 delete mode 100644 arch/h8300/include/asm/cmpxchg.h

diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 60ee7f0d60a8..e23139c8fc0d 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
+generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
deleted file mode 100644
index a990d151f163..000000000000
diff --git a/arch/h8300/include/asm/cmpxchg.h b/arch/h8300/include/asm/cmpxchg.h
deleted file mode 100644
index c64bb38ce242..000000000000
-- 
2.11.0

