Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815903C6F02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhGMK4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:56:00 -0400
Received: from foss.arm.com ([217.140.110.172]:40762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235814AbhGMKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:55:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDEC31FB;
        Tue, 13 Jul 2021 03:53:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1BB23F7D8;
        Tue, 13 Jul 2021 03:53:03 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/5] locking/atomic: centralize generated headers
Date:   Tue, 13 Jul 2021 11:52:51 +0100
Message-Id: <20210713105253.7615-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210713105253.7615-1-mark.rutland@arm.com>
References: <20210713105253.7615-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generated atomic headers are only intended to be included directly
by <linux/atomic.h>, but are spread across include/linux/ and
include/asm-generic/, where people mnay be encouraged to include them.

This patch centralizes them under include/linux/atomic/.

Other than the header guards and hashes, there is no change to any of
the generated headers as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/atomic.h                                      | 7 +++----
 include/linux/{ => atomic}/atomic-arch-fallback.h           | 0
 include/{asm-generic => linux/atomic}/atomic-instrumented.h | 8 ++++----
 include/{asm-generic => linux/atomic}/atomic-long.h         | 8 ++++----
 scripts/atomic/check-atomics.sh                             | 6 +++---
 scripts/atomic/gen-atomic-instrumented.sh                   | 6 +++---
 scripts/atomic/gen-atomic-long.sh                           | 6 +++---
 scripts/atomic/gen-atomics.sh                               | 6 +++---
 8 files changed, 23 insertions(+), 24 deletions(-)
 rename include/linux/{ => atomic}/atomic-arch-fallback.h (100%)
 rename include/{asm-generic => linux/atomic}/atomic-instrumented.h (99%)
 rename include/{asm-generic => linux/atomic}/atomic-long.h (99%)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index ed1d3ffd5b9d..1896a58b5aba 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,9 +77,8 @@
 	__ret;								\
 })
 
-#include <linux/atomic-arch-fallback.h>
-#include <asm-generic/atomic-instrumented.h>
-
-#include <asm-generic/atomic-long.h>
+#include <linux/atomic/atomic-arch-fallback.h>
+#include <linux/atomic/atomic-instrumented.h>
+#include <linux/atomic/atomic-long.h>
 
 #endif /* _LINUX_ATOMIC_H */
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
similarity index 100%
rename from include/linux/atomic-arch-fallback.h
rename to include/linux/atomic/atomic-arch-fallback.h
diff --git a/include/asm-generic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
similarity index 99%
rename from include/asm-generic/atomic-instrumented.h
rename to include/linux/atomic/atomic-instrumented.h
index bc45af52c93b..f6fe36c428df 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -14,8 +14,8 @@
  * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
  * double instrumentation.
  */
-#ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
-#define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
+#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
+#define _LINUX_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
@@ -1333,5 +1333,5 @@ atomic64_dec_if_positive(atomic64_t *v)
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
 
-#endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 1d7c3a25aca5c7fb031c307be4c3d24c7b48fcd5
+#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
+// 5edd72f105b6f54b7e9492d794abee88e6912d29
diff --git a/include/asm-generic/atomic-long.h b/include/linux/atomic/atomic-long.h
similarity index 99%
rename from include/asm-generic/atomic-long.h
rename to include/linux/atomic/atomic-long.h
index 073cf40f431b..e40e480e175f 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -3,8 +3,8 @@
 // Generated by scripts/atomic/gen-atomic-long.sh
 // DO NOT MODIFY THIS FILE DIRECTLY
 
-#ifndef _ASM_GENERIC_ATOMIC_LONG_H
-#define _ASM_GENERIC_ATOMIC_LONG_H
+#ifndef _LINUX_ATOMIC_LONG_H
+#define _LINUX_ATOMIC_LONG_H
 
 #include <linux/compiler.h>
 #include <asm/types.h>
@@ -1010,5 +1010,5 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* CONFIG_64BIT */
-#endif /* _ASM_GENERIC_ATOMIC_LONG_H */
-// a624200981f552b2c6be4f32fe44da8289f30d87
+#endif /* _LINUX_ATOMIC_LONG_H */
+// c5552b5d78a0c7584dfd03cba985e78a1a86bbed
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 9c7fbd4bcbce..0e7bab3eb0d1 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -14,9 +14,9 @@ if [ $? -ne 0 ]; then
 fi
 
 cat <<EOF |
-asm-generic/atomic-instrumented.h
-asm-generic/atomic-long.h
-linux/atomic-arch-fallback.h
+linux/atomic/atomic-instrumented.h
+linux/atomic/atomic-long.h
+linux/atomic/atomic-arch-fallback.h
 EOF
 while read header; do
 	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index b0c45aee19d7..6fc1ab772e40 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -121,8 +121,8 @@ cat << EOF
  * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
  * double instrumentation.
  */
-#ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
-#define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
+#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
+#define _LINUX_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
@@ -158,5 +158,5 @@ gen_xchg "cmpxchg_double_local" "2 * "
 
 cat <<EOF
 
-#endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
+#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
 EOF
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index e318d3f92e53..db69572609df 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -61,8 +61,8 @@ cat << EOF
 // Generated by $0
 // DO NOT MODIFY THIS FILE DIRECTLY
 
-#ifndef _ASM_GENERIC_ATOMIC_LONG_H
-#define _ASM_GENERIC_ATOMIC_LONG_H
+#ifndef _LINUX_ATOMIC_LONG_H
+#define _LINUX_ATOMIC_LONG_H
 
 #include <linux/compiler.h>
 #include <asm/types.h>
@@ -98,5 +98,5 @@ done
 
 cat <<EOF
 #endif /* CONFIG_64BIT */
-#endif /* _ASM_GENERIC_ATOMIC_LONG_H */
+#endif /* _LINUX_ATOMIC_LONG_H */
 EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 56b119f7d1c2..5b98a8307693 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -8,9 +8,9 @@ ATOMICTBL=${ATOMICDIR}/atomics.tbl
 LINUXDIR=${ATOMICDIR}/../..
 
 cat <<EOF |
-gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
-gen-atomic-long.sh              asm-generic/atomic-long.h
-gen-atomic-fallback.sh          linux/atomic-arch-fallback.h
+gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
+gen-atomic-long.sh              linux/atomic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
-- 
2.11.0

