Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06145ED4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377123AbhKZMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:04:47 -0500
Received: from foss.arm.com ([217.140.110.172]:32946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237917AbhKZMCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:02:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9E851FB;
        Fri, 26 Nov 2021 03:59:32 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8C5E3F66F;
        Fri, 26 Nov 2021 03:59:31 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     arnd@arndb.de, boqun.feng@gmail.com, lkp@intel.com,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH] locking/atomic: atomic64: remove unusable atomics
Date:   Fri, 26 Nov 2021 11:59:23 +0000
Message-Id: <20211126115923.41489-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic atomic64 implementation provides:

* atomic64_and_return()
* atomic64_or_return()
* atomic64_xor_return()

... but none of these exist in the standard atomic64 API as described by
scripts/atomic/atomics.tbl, and none of these have prototypes exposed by
<asm-generic/atomic64.h>.

The lkp kernel test robot noted this results in warnings when building with
W=1:

  lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_and_return' [-Wmissing-prototypes]

  lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_or_return' [-Wmissing-prototypes]

  lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_xor_return' [-Wmissing-prototypes]

This appears to have been a thinko in commit:

  28aa2bda2211f432 ("locking/atomic: Implement atomic{,64,_long}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()")

... where we grouped add/sub separately from and/ox/xor, so that we could avoid
implementing _return forms for the latter group, but forgot to remove
ATOMIC64_OP_RETURN() for that group.

This doesn't cause any functional problem, but it's pointless to build code
which cannot be used. Remove the unusable code. This does not affect add/sub,
for which _return forms will still be built.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202111120712.RtQHZohY-lkp@intel.com
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 lib/atomic64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/atomic64.c b/lib/atomic64.c
index 3df653994177..caf895789a1e 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -118,7 +118,6 @@ ATOMIC64_OPS(sub, -=)
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op, c_op)						\
 	ATOMIC64_OP(op, c_op)						\
-	ATOMIC64_OP_RETURN(op, c_op)					\
 	ATOMIC64_FETCH_OP(op, c_op)
 
 ATOMIC64_OPS(and, &=)
@@ -127,7 +126,6 @@ ATOMIC64_OPS(xor, ^=)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
-#undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
 s64 generic_atomic64_dec_if_positive(atomic64_t *v)
-- 
2.30.2

