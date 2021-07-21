Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3B3D130B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhGUPRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:17:48 -0400
Received: from foss.arm.com ([217.140.110.172]:58352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240098AbhGUPRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:17:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76C631FB;
        Wed, 21 Jul 2021 08:58:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF42D3F73D;
        Wed, 21 Jul 2021 08:58:22 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org
Cc:     elver@google.com, mark.rutland@arm.com
Subject: [PATCH] locking/atomic: simplify non-atomic wrappers
Date:   Wed, 21 Jul 2021 16:58:13 +0100
Message-Id: <20210721155813.17082-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the non-atomic arch_*() bitops use plain accesses, they are
implicitly instrumnted by the compiler, and we work around this in the
instrumented wrappers to avoid double instrumentation.

It's simpler to avoid the wrappers entirely, and use the preprocessor to
alias the arch_*() bitops to their regular versions, removing the need
for checks in the instrumented wrappers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 .../asm-generic/bitops/instrumented-non-atomic.h    | 21 +++++++--------------
 include/asm-generic/bitops/non-atomic.h             | 16 +++++++---------
 2 files changed, 14 insertions(+), 23 deletions(-)

Hi Peter,

Are you happy to take this atop your queue/locking/core branch?

This was suggested by Marco in [1], and also sidesteps some particularly bad
stack spills as in [2].

[1] https://lore.kernel.org/r/CANpmjNNVn4UxBCMg1ke9xaQNv52OMuQjr17GxUXojZKwiAFzzg@mail.gmail.com
[2] https://lore.kernel.org/r/20210719100719.GB12806@C02TD0UTHF1T.local/

Thanks,
Mark.

diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index e6c1540965d6..37363d570b9b 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -24,8 +24,7 @@
  */
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___set_bit_uses_plain_access))
-		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -40,8 +39,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___clear_bit_uses_plain_access))
-		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -56,8 +54,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___change_bit_uses_plain_access))
-		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -95,8 +92,7 @@ static inline void __instrument_read_write_bitop(long nr, volatile unsigned long
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___test_and_set_bit_uses_plain_access))
-		__instrument_read_write_bitop(nr, addr);
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -110,8 +106,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___test_and_clear_bit_uses_plain_access))
-		__instrument_read_write_bitop(nr, addr);
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -125,8 +120,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___test_and_change_bit_uses_plain_access))
-		__instrument_read_write_bitop(nr, addr);
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -137,8 +131,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
-	if (!__is_defined(arch_test_bit_uses_plain_access))
-		instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index c8149cd52730..365377fb104b 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -21,7 +21,7 @@ arch___set_bit(int nr, volatile unsigned long *addr)
 
 	*p  |= mask;
 }
-#define arch___set_bit_uses_plain_access
+#define __set_bit arch___set_bit
 
 static __always_inline void
 arch___clear_bit(int nr, volatile unsigned long *addr)
@@ -31,7 +31,7 @@ arch___clear_bit(int nr, volatile unsigned long *addr)
 
 	*p &= ~mask;
 }
-#define arch___clear_bit_uses_plain_access
+#define __clear_bit arch___clear_bit
 
 /**
  * arch___change_bit - Toggle a bit in memory
@@ -50,7 +50,7 @@ void arch___change_bit(int nr, volatile unsigned long *addr)
 
 	*p ^= mask;
 }
-#define arch___change_bit_uses_plain_access
+#define __change_bit arch___change_bit
 
 /**
  * arch___test_and_set_bit - Set a bit and return its old value
@@ -71,7 +71,7 @@ arch___test_and_set_bit(int nr, volatile unsigned long *addr)
 	*p = old | mask;
 	return (old & mask) != 0;
 }
-#define arch___test_and_set_bit_uses_plain_access
+#define __test_and_set_bit arch___test_and_set_bit
 
 /**
  * arch___test_and_clear_bit - Clear a bit and return its old value
@@ -92,7 +92,7 @@ arch___test_and_clear_bit(int nr, volatile unsigned long *addr)
 	*p = old & ~mask;
 	return (old & mask) != 0;
 }
-#define arch___test_and_clear_bit_uses_plain_access
+#define __test_and_clear_bit arch___test_and_clear_bit
 
 /* WARNING: non atomic and it can be reordered! */
 static __always_inline int
@@ -105,7 +105,7 @@ arch___test_and_change_bit(int nr, volatile unsigned long *addr)
 	*p = old ^ mask;
 	return (old & mask) != 0;
 }
-#define arch___test_and_change_bit_uses_plain_access
+#define __test_and_change_bit arch___test_and_change_bit
 
 /**
  * arch_test_bit - Determine whether a bit is set
@@ -117,8 +117,6 @@ arch_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
-#define arch_test_bit_uses_plain_access
-
-#include <asm-generic/bitops/instrumented-non-atomic.h>
+#define test_bit arch_test_bit
 
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
-- 
2.11.0

