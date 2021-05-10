Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4696377F94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhEJJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:41:15 -0400
Received: from foss.arm.com ([217.140.110.172]:50782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhEJJlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:41:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB599142F;
        Mon, 10 May 2021 02:40:07 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A8C13F73B;
        Mon, 10 May 2021 02:40:03 -0700 (PDT)
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
Subject: [PATCH 07/33] locking/atomic: atomic: remove redundant include
Date:   Mon, 10 May 2021 10:37:27 +0100
Message-Id: <20210510093753.40683-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit:

  560cb12a4080a48b ("locking,arch: Rewrite generic atomic support")

... we conditionally include <linux/irqflags.h> before defining atomics
using locking, and hence do not need to do so unconditionally later in
the header.

This patch removes the redundant include.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/asm-generic/atomic.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index ebacbc6b363b..d4bf803d6491 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -143,8 +143,6 @@ ATOMIC_OP(xor, ^)
 
 #define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
-#include <linux/irqflags.h>
-
 static inline void atomic_add(int i, atomic_t *v)
 {
 	atomic_add_return(i, v);
-- 
2.11.0

