Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08830FCEE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhBDOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:52:03 -0500
Received: from sym2.noone.org ([178.63.92.236]:51026 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236737AbhBDOvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:51:41 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4DWhLW17lHzvjfp; Thu,  4 Feb 2021 15:50:42 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] selftests/vDSO: fix ABI selftest on riscv
Date:   Thu,  4 Feb 2021 15:50:42 +0100
Message-Id: <20210204145042.7345-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only older versions of the RISC-V GCC toolchain define __riscv__. Check
for __riscv as well, which is used by newer GCC toolchains. Also set
VDSO_32BIT based on __riscv_xlen.

Before (on riscv64):

$ ./vdso_test_abi
[vDSO kselftest] VDSO_VERSION: LINUX_4
Could not find __vdso_gettimeofday
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_REALTIME [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_BOOTTIME [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_TAI [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_REALTIME_COARSE [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_MONOTONIC [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_MONOTONIC_RAW [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_MONOTONIC_COARSE [PASS]
Could not find __vdso_time

After (on riscv32):

$ ./vdso_test_abi
[vDSO kselftest] VDSO_VERSION: LINUX_4.15
The time is 1612449376.015086
The time is 1612449376.18340784
The resolution is 0 1
clock_id: CLOCK_REALTIME [PASS]
The time is 774.842586182
The resolution is 0 1
clock_id: CLOCK_BOOTTIME [PASS]
The time is 1612449376.22536565
The resolution is 0 1
clock_id: CLOCK_TAI [PASS]
The time is 1612449376.20885172
The resolution is 0 4000000
clock_id: CLOCK_REALTIME_COARSE [PASS]
The time is 774.845491269
The resolution is 0 1
clock_id: CLOCK_MONOTONIC [PASS]
The time is 774.849534200
The resolution is 0 1
clock_id: CLOCK_MONOTONIC_RAW [PASS]
The time is 774.842139684
The resolution is 0 4000000
clock_id: CLOCK_MONOTONIC_COARSE [PASS]
Could not find __vdso_time

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/vDSO/vdso_config.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 6a6fe8d4ff55..6188b16827d1 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -47,10 +47,12 @@
 #elif defined(__x86_64__)
 #define VDSO_VERSION		0
 #define VDSO_NAMES		1
-#elif defined(__riscv__)
+#elif defined(__riscv__) || defined(__riscv)
 #define VDSO_VERSION		5
 #define VDSO_NAMES		1
+#if __riscv_xlen == 32
 #define VDSO_32BIT		1
+#endif
 #else /* nds32 */
 #define VDSO_VERSION		4
 #define VDSO_NAMES		1
-- 
2.30.0

