Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7A31E471
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBRDOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:14:03 -0500
Received: from foss.arm.com ([217.140.110.172]:43356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBRDOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:14:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457C51FB;
        Wed, 17 Feb 2021 19:13:16 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 111C33F694;
        Wed, 17 Feb 2021 19:13:08 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com
Cc:     Jianlin.Lv@arm.com, iecedge@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v5] perf tools: Fix arm64 build error with gcc-11
Date:   Thu, 18 Feb 2021 11:12:45 +0800
Message-Id: <20210218031245.2078492-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc version: 11.0.0 20210208 (experimental) (GCC)

Following build error on arm64:

.......
In function ‘printf’,
    inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
    inlined from ‘regs__printf’ at util/session.c:1169:2:
/usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
  error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]

107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
                __va_arg_pack ());

......
In function ‘fprintf’,
  inlined from ‘perf_sample__fprintf_regs.isra’ at \
    builtin-script.c:622:14:
/usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
    error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
  100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
  101 |                         __va_arg_pack ());

cc1: all warnings being treated as errors
.......

This patch fixes Wformat-overflow warnings. Add helper function to
convert NULL to "unknown".

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
v2: Add ternary operator to avoid similar errors in other arch.
v3: Declared reg_name in inner block.
v4: Add helper function: perf_reg_name_str, update changelog.
v5: Correct function names to follow common naming conventions.
---
 tools/perf/arch/arm/include/perf_regs.h     | 2 +-
 tools/perf/arch/arm64/include/perf_regs.h   | 2 +-
 tools/perf/arch/csky/include/perf_regs.h    | 2 +-
 tools/perf/arch/powerpc/include/perf_regs.h | 2 +-
 tools/perf/arch/riscv/include/perf_regs.h   | 2 +-
 tools/perf/arch/s390/include/perf_regs.h    | 2 +-
 tools/perf/arch/x86/include/perf_regs.h     | 2 +-
 tools/perf/util/perf_regs.h                 | 7 +++++++
 8 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
index ed20e0253e25..4085419283d0 100644
--- a/tools/perf/arch/arm/include/perf_regs.h
+++ b/tools/perf/arch/arm/include/perf_regs.h
@@ -15,7 +15,7 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP	PERF_REG_ARM_PC
 #define PERF_REG_SP	PERF_REG_ARM_SP
 
-static inline const char *perf_reg_name(int id)
+static inline const char *__perf_reg_name(int id)
 {
 	switch (id) {
 	case PERF_REG_ARM_R0:
diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index baaa5e64a3fb..fa3e07459f76 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -15,7 +15,7 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP	PERF_REG_ARM64_PC
 #define PERF_REG_SP	PERF_REG_ARM64_SP
 
-static inline const char *perf_reg_name(int id)
+static inline const char *__perf_reg_name(int id)
 {
 	switch (id) {
 	case PERF_REG_ARM64_X0:
diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch/csky/include/perf_regs.h
index 8f336ea1161a..25ac3bdcb9d1 100644
--- a/tools/perf/arch/csky/include/perf_regs.h
+++ b/tools/perf/arch/csky/include/perf_regs.h
@@ -15,7 +15,7 @@
 #define PERF_REG_IP	PERF_REG_CSKY_PC
 #define PERF_REG_SP	PERF_REG_CSKY_SP
 
-static inline const char *perf_reg_name(int id)
+static inline const char *__perf_reg_name(int id)
 {
 	switch (id) {
 	case PERF_REG_CSKY_A0:
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 63f3ac91049f..004bed228693 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -73,7 +73,7 @@ static const char *reg_names[] = {
 	[PERF_REG_POWERPC_SIER3] = "sier3",
 };
 
-static inline const char *perf_reg_name(int id)
+static inline const char *__perf_reg_name(int id)
 {
 	return reg_names[id];
 }
diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
index 7a8bcde7a2b1..6b02a767c918 100644
--- a/tools/perf/arch/riscv/include/perf_regs.h
+++ b/tools/perf/arch/riscv/include/perf_regs.h
@@ -19,7 +19,7 @@
 #define PERF_REG_IP	PERF_REG_RISCV_PC
 #define PERF_REG_SP	PERF_REG_RISCV_SP
 
-static inline const char *perf_reg_name(int id)
+static inline const char *__perf_reg_name(int id)
 {
 	switch (id) {
 	case PERF_REG_RISCV_PC:
diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch/s390/include/perf_regs.h
index bcfbaed78cc2..ce3031526623 100644
--- a/tools/perf/arch/s390/include/perf_regs.h
+++ b/tools/perf/arch/s390/include/perf_regs.h
@@ -14,7 +14,7 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP PERF_REG_S390_PC
 #define PERF_REG_SP PERF_REG_S390_R15
 
-static inline const char *perf_reg_name(int id)
+static inline const char *__perf_reg_name(int id)
 {
 	switch (id) {
 	case PERF_REG_S390_R0:
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index b7321337d100..cddc4cdc0d9b 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -23,7 +23,7 @@ void perf_regs_load(u64 *regs);
 #define PERF_REG_IP PERF_REG_X86_IP
 #define PERF_REG_SP PERF_REG_X86_SP
 
-static inline const char *perf_reg_name(int id)
+static inline const char *__perf_reg_name(int id)
 {
 	switch (id) {
 	case PERF_REG_X86_AX:
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index a45499126184..eeac181ebccf 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -33,6 +33,13 @@ extern const struct sample_reg sample_reg_masks[];
 
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
+static inline const char *perf_reg_name(int id)
+{
+	const char *reg_name = __perf_reg_name(id);
+
+	return reg_name ?: "unknown";
+}
+
 #else
 #define PERF_REGS_MASK	0
 #define PERF_REGS_MAX	0
-- 
2.25.1

