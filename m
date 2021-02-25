Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61434324D21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhBYJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhBYJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:44:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D089E64EC3;
        Thu, 25 Feb 2021 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614246211;
        bh=odGN/l6Xb2ytitM63vIjEdZTX1y5B18NzqzfOchHsh4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ln2UawM5nhBIhmRdWNcyJi0CABNMIAoVnbUASjMqsHadLUo6Aa2LcMNsvyRWaBbg0
         4GaMxu0T0qFNkQjnvTYddbS/v+8uBL04vjEGvM9tY/5qex0jYTqE+twQs8byVewyMX
         dovDSC25zsAWE84uyLmfX8zD2Z34XLAgjmpxN03bMfMiYYKiuSvdO1whaV8/6I/+QX
         NqSs5fALDovY1ooE8EpcSEMYqEYE3Uq+0Yrsjt8K/WfCayzFROu41tMky+pbmZ56Qw
         h55ONofq8SN/zHmAvP6HUX+rybCvpqs08wFm21d01v+jBv/H3+SS9gla/TXgj4Mr9k
         3ad+Rj2n4Vnsw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] coresight: etm4x: work around clang-12+ build failure
Date:   Thu, 25 Feb 2021 10:42:58 +0100
Message-Id: <20210225094324.3542511-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang-12 fails to build the etm4x driver with -fsanitize=array-bounds:

<instantiation>:1:7: error: expected constant expression in '.inst' directive
.inst (0xd5200000|((((2) << 19) | ((1) << 16) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 7) & 0x7)) << 12) | ((((((((((0x160 + (i * 4))))) >> 2))) & 0xf)) << 8) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 4) & 0x7)) << 5)))|(.L__reg_num_x8))
      ^
drivers/hwtracing/coresight/coresight-etm4x-core.c:702:4: note: while in macro instantiation
                        etm4x_relaxed_read32(csa, TRCCNTVRn(i));
                        ^
drivers/hwtracing/coresight/coresight-etm4x.h:403:4: note: expanded from macro 'etm4x_relaxed_read32'
                 read_etm4x_sysreg_offset((offset), false)))
                 ^
drivers/hwtracing/coresight/coresight-etm4x.h:383:12: note: expanded from macro 'read_etm4x_sysreg_offset'
                        __val = read_etm4x_sysreg_const_offset((offset));       \
                                ^
drivers/hwtracing/coresight/coresight-etm4x.h:149:2: note: expanded from macro 'read_etm4x_sysreg_const_offset'
        READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
        ^
drivers/hwtracing/coresight/coresight-etm4x.h:144:2: note: expanded from macro 'READ_ETM4x_REG'
        read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
        ^
arch/arm64/include/asm/sysreg.h:1108:15: note: expanded from macro 'read_sysreg_s'
        asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
                     ^
arch/arm64/include/asm/sysreg.h:1074:2: note: expanded from macro '__mrs_s'
"       mrs_s " v ", " __stringify(r) "\n"                      \
 ^

It appears that the __builin_constant_p() check in
read_etm4x_sysreg_offset() falsely returns 'true' here because clang
decides finds that an out-of-bounds access to config->cntr_val[] cannot
happen, and then it unrolls the loop with constant register numbers. Then
when actually emitting the output, it fails to figure out the value again.

While this is incorrect behavior in clang, it is easy to work around
by avoiding the out-of-bounds array access. Do this by limiting the
loop counter to the actual dimension of the array.

Link: https://github.com/ClangBuiltLinux/linux/issues/1310
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 15016f757828..4cccf874a602 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -691,13 +691,13 @@ static void etm4_disable_hw(void *info)
 			"timeout while waiting for PM stable Trace Status\n");
 
 	/* read the status of the single shot comparators */
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+	for (i = 0; i < min_t(u32, drvdata->nr_ss_cmp, ETM_MAX_SS_CMP); i++) {
 		config->ss_status[i] =
 			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 
 	/* read back the current counter values */
-	for (i = 0; i < drvdata->nr_cntr; i++) {
+	for (i = 0; i < min_t(u32, drvdata->nr_cntr, ETMv4_MAX_CNTR); i++) {
 		config->cntr_val[i] =
 			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
 	}
-- 
2.29.2

