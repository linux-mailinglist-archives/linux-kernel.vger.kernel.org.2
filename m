Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A13A377F93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEJJlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:41:09 -0400
Received: from foss.arm.com ([217.140.110.172]:50712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhEJJlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:41:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81F871424;
        Mon, 10 May 2021 02:39:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C9CE3F73B;
        Mon, 10 May 2021 02:39:53 -0700 (PDT)
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
Subject: [PATCH 06/33] locking/atomic: atomic: remove stale comments
Date:   Mon, 10 May 2021 10:37:26 +0100
Message-Id: <20210510093753.40683-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commentary in asm-generic/atomic.h is stale; let's bring it up-to
date:

* The block comment at the start of the file mentions this is only
  usable on UP systems, but is immediately followed by an SMP
  implementation using cmpxchg. Let's delete the misleading statement.

* A comment near the end of the file was originally at the top of the
  file, but over time rework has shuffled it near the end, and it's long
  been superceded by the block comment at the top of the file. Let's
  remove it.

* Since asm-generic/atomic.h isn't the canonical documentation for the
  atomic ops, and since the existing comments are not in kerneldoc
  format, we don't need to document the semantics of each operation here
  (and this would be better done in a centralised document). Let's
  remove these comments.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/asm-generic/atomic.h | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 11f96f40f4a7..ebacbc6b363b 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Generic C implementation of atomic counter operations. Usable on
- * UP systems only. Do not include in machine independent code.
+ * Generic C implementation of atomic counter operations. Do not include in
+ * machine independent code.
  *
  * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -12,23 +12,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-/*
- * atomic_$op() - $op integer to atomic variable
- * @i: integer value to $op
- * @v: pointer to the atomic variable
- *
- * Atomically $ops @i to @v. Does not strictly guarantee a memory-barrier, use
- * smp_mb__{before,after}_atomic().
- */
-
-/*
- * atomic_$op_return() - $op interer to atomic variable and returns the result
- * @i: integer value to $op
- * @v: pointer to the atomic variable
- *
- * Atomically $ops @i to @v. Does imply a full memory barrier.
- */
-
 #ifdef CONFIG_SMP
 
 /* we can build all atomic primitives from cmpxchg */
@@ -154,28 +137,10 @@ ATOMIC_OP(xor, ^)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- */
-
-/**
- * atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
 #ifndef atomic_read
 #define atomic_read(v)	READ_ONCE((v)->counter)
 #endif
 
-/**
- * atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 #define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
 #include <linux/irqflags.h>
-- 
2.11.0

