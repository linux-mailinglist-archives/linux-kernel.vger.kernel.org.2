Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A82390367
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhEYOHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:07:48 -0400
Received: from foss.arm.com ([217.140.110.172]:57684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233679AbhEYOHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:07:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B883153B;
        Tue, 25 May 2021 07:06:06 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08EF43F73D;
        Tue, 25 May 2021 07:06:01 -0700 (PDT)
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
Subject: [PATCH v2 17/33] locking/atomic: h8300: move to ARCH_ATOMIC
Date:   Tue, 25 May 2021 15:02:16 +0100
Message-Id: <20210525140232.53872-18-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210525140232.53872-1-mark.rutland@arm.com>
References: <20210525140232.53872-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates h8300 to ARCH_ATOMIC, using
the asm-generic implementations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3e3e0f16f7e0..bdf05ad3206a 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -2,6 +2,7 @@
 config H8300
         def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BINFMT_FLAT_OLD_ALWAYS_RAM
-- 
2.11.0

