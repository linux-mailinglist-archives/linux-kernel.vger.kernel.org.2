Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61636ECDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbhD2O7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhD2O7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:59:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A117061441;
        Thu, 29 Apr 2021 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619708298;
        bh=W4TD3W6V5SOgxX7cxybrxqGaW1QHMmYHzuCzShYY/Ps=;
        h=From:To:Cc:Subject:Date:From;
        b=kwQJLKfOc853dxC6C9nmlZH9bcWWp7OTo/I+x/LXpojreiDhenW8RbMvFRjHzHY6o
         DHGyY7gjJ6NtoEIE0Ku3e6Wjz6WtOCQSt1NtzzGv1zCpisoGdGG4ECZA9Fh52CU2gH
         JOrjmzL4TOlXxKHhODbbPn55UpXNSeK2e8/6yj/A+Xq7VKheil5lCD0XKti/VvK9uO
         bW6OxoJDv0sMVx59x5e3sWdjeBkgGolHcQagdGjWRgk/kGeH5Ybl2d+DZ+3cBKM4NL
         dFGpdZ7vl1iY2jKLrDyUXhTOhSPONG2Bgjsj0ZRvaTnMWXZEUAO+K9ID9kgpZDF7S1
         tmFQNEcsIMprg==
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
        Qi Liu <liuqi115@huawei.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] coresight: etm4x: avoid build failure with unrolled loops
Date:   Thu, 29 Apr 2021 16:57:26 +0200
Message-Id: <20210429145752.3218324-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang-12 fails to build the etm4x driver with -fsanitize=array-bounds,
where it decides to unroll certain loops in a way that result in a
C variable getting put into an inline assembly

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

This only happened in a few loops in which the array bounds sanitizer
added a special case for an array overflow that clang determined to be
possible, but any compiler is free to unroll any of the loops in the
same way that breaks the sysreg macros.

Introduce helper functions that perform a sysreg access with a
non-constant register number and use them in each call that passes
a loop counter.

Link: https://github.com/ClangBuiltLinux/linux/issues/1310
Link: https://lore.kernel.org/lkml/20210225094324.3542511-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../coresight/coresight-etm4x-core.c          | 78 +++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h | 69 ++++++++++++++++
 2 files changed, 108 insertions(+), 39 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index db881993c211..73649d9c89d2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -381,14 +381,14 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	if (drvdata->nr_pe_cmp)
 		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
-		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
+		etm4x_relaxed_write32_varreg(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
 	etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
 	etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
 	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
-		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
-		etm4x_relaxed_write32(csa, config->cntr_val[i], TRCCNTVRn(i));
+		etm4x_relaxed_write32_varreg(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
+		etm4x_relaxed_write32_varreg(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
+		etm4x_relaxed_write32_varreg(csa, config->cntr_val[i], TRCCNTVRn(i));
 	}
 
 	/*
@@ -396,29 +396,29 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	 * such start at 2.
 	 */
 	for (i = 2; i < drvdata->nr_resource * 2; i++)
-		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
+		etm4x_relaxed_write32_varreg(csa, config->res_ctrl[i], TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		/* always clear status bit on restart if using single-shot */
 		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
 			config->ss_status[i] &= ~BIT(31);
-		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
-		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
+		etm4x_relaxed_write32_varreg(csa, config->ss_ctrl[i], TRCSSCCRn(i));
+		etm4x_relaxed_write32_varreg(csa, config->ss_status[i], TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
-			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
+			etm4x_relaxed_write32_varreg(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
 	}
 	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
-		etm4x_relaxed_write64(csa, config->addr_val[i], TRCACVRn(i));
-		etm4x_relaxed_write64(csa, config->addr_acc[i], TRCACATRn(i));
+		etm4x_relaxed_write64_varreg(csa, config->addr_val[i], TRCACVRn(i));
+		etm4x_relaxed_write64_varreg(csa, config->addr_acc[i], TRCACATRn(i));
 	}
 	for (i = 0; i < drvdata->numcidc; i++)
-		etm4x_relaxed_write64(csa, config->ctxid_pid[i], TRCCIDCVRn(i));
+		etm4x_relaxed_write64_varreg(csa, config->ctxid_pid[i], TRCCIDCVRn(i));
 	etm4x_relaxed_write32(csa, config->ctxid_mask0, TRCCIDCCTLR0);
 	if (drvdata->numcidc > 4)
 		etm4x_relaxed_write32(csa, config->ctxid_mask1, TRCCIDCCTLR1);
 
 	for (i = 0; i < drvdata->numvmidc; i++)
-		etm4x_relaxed_write64(csa, config->vmid_val[i], TRCVMIDCVRn(i));
+		etm4x_relaxed_write64_varreg(csa, config->vmid_val[i], TRCVMIDCVRn(i));
 	etm4x_relaxed_write32(csa, config->vmid_mask0, TRCVMIDCCTLR0);
 	if (drvdata->numvmidc > 4)
 		etm4x_relaxed_write32(csa, config->vmid_mask1, TRCVMIDCCTLR1);
@@ -777,13 +777,13 @@ static void etm4_disable_hw(void *info)
 	/* read the status of the single shot comparators */
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		config->ss_status[i] =
-			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
+			etm4x_relaxed_read32_varreg(csa, TRCSSCSRn(i));
 	}
 
 	/* read back the current counter values */
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		config->cntr_val[i] =
-			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
+			etm4x_relaxed_read32_varreg(csa, TRCCNTVRn(i));
 	}
 
 	coresight_disclaim_device_unlocked(csdev);
@@ -1151,7 +1151,7 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nr_ss_cmp = BMVAL(etmidr4, 20, 23);
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		drvdata->config.ss_status[i] =
-			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
+			etm4x_relaxed_read32_varreg(csa, TRCSSCSRn(i));
 	}
 	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
 	drvdata->numcidc = BMVAL(etmidr4, 24, 27);
@@ -1595,31 +1595,31 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcvdarcctlr = etm4x_read32(csa, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
-		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
+		state->trcseqevr[i] = etm4x_read32_varreg(csa, TRCSEQEVRn(i));
 
 	state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
 	state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
 	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-		state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
-		state->trccntctlr[i] = etm4x_read32(csa, TRCCNTCTLRn(i));
-		state->trccntvr[i] = etm4x_read32(csa, TRCCNTVRn(i));
+		state->trccntrldvr[i] = etm4x_read32_varreg(csa, TRCCNTRLDVRn(i));
+		state->trccntctlr[i] = etm4x_read32_varreg(csa, TRCCNTCTLRn(i));
+		state->trccntvr[i] = etm4x_read32_varreg(csa, TRCCNTVRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_resource * 2; i++)
-		state->trcrsctlr[i] = etm4x_read32(csa, TRCRSCTLRn(i));
+		state->trcrsctlr[i] = etm4x_read32_varreg(csa, TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
-		state->trcssccr[i] = etm4x_read32(csa, TRCSSCCRn(i));
-		state->trcsscsr[i] = etm4x_read32(csa, TRCSSCSRn(i));
+		state->trcssccr[i] = etm4x_read32_varreg(csa, TRCSSCCRn(i));
+		state->trcsscsr[i] = etm4x_read32_varreg(csa, TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
-			state->trcsspcicr[i] = etm4x_read32(csa, TRCSSPCICRn(i));
+			state->trcsspcicr[i] = etm4x_read32_varreg(csa, TRCSSPCICRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
-		state->trcacvr[i] = etm4x_read64(csa, TRCACVRn(i));
-		state->trcacatr[i] = etm4x_read64(csa, TRCACATRn(i));
+		state->trcacvr[i] = etm4x_read64_varreg(csa, TRCACVRn(i));
+		state->trcacatr[i] = etm4x_read64_varreg(csa, TRCACATRn(i));
 	}
 
 	/*
@@ -1630,10 +1630,10 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	 */
 
 	for (i = 0; i < drvdata->numcidc; i++)
-		state->trccidcvr[i] = etm4x_read64(csa, TRCCIDCVRn(i));
+		state->trccidcvr[i] = etm4x_read64_varreg(csa, TRCCIDCVRn(i));
 
 	for (i = 0; i < drvdata->numvmidc; i++)
-		state->trcvmidcvr[i] = etm4x_read64(csa, TRCVMIDCVRn(i));
+		state->trcvmidcvr[i] = etm4x_read64_varreg(csa, TRCVMIDCVRn(i));
 
 	state->trccidcctlr0 = etm4x_read32(csa, TRCCIDCCTLR0);
 	if (drvdata->numcidc > 4)
@@ -1708,38 +1708,38 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, state->trcvdarcctlr, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
-		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
+		etm4x_relaxed_write32_varreg(csa, state->trcseqevr[i], TRCSEQEVRn(i));
 
 	etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
 	etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
 	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-		etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
-		etm4x_relaxed_write32(csa, state->trccntctlr[i], TRCCNTCTLRn(i));
-		etm4x_relaxed_write32(csa, state->trccntvr[i], TRCCNTVRn(i));
+		etm4x_relaxed_write32_varreg(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
+		etm4x_relaxed_write32_varreg(csa, state->trccntctlr[i], TRCCNTCTLRn(i));
+		etm4x_relaxed_write32_varreg(csa, state->trccntvr[i], TRCCNTVRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_resource * 2; i++)
-		etm4x_relaxed_write32(csa, state->trcrsctlr[i], TRCRSCTLRn(i));
+		etm4x_relaxed_write32_varreg(csa, state->trcrsctlr[i], TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
-		etm4x_relaxed_write32(csa, state->trcssccr[i], TRCSSCCRn(i));
-		etm4x_relaxed_write32(csa, state->trcsscsr[i], TRCSSCSRn(i));
+		etm4x_relaxed_write32_varreg(csa, state->trcssccr[i], TRCSSCCRn(i));
+		etm4x_relaxed_write32_varreg(csa, state->trcsscsr[i], TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
-			etm4x_relaxed_write32(csa, state->trcsspcicr[i], TRCSSPCICRn(i));
+			etm4x_relaxed_write32_varreg(csa, state->trcsspcicr[i], TRCSSPCICRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
-		etm4x_relaxed_write64(csa, state->trcacvr[i], TRCACVRn(i));
-		etm4x_relaxed_write64(csa, state->trcacatr[i], TRCACATRn(i));
+		etm4x_relaxed_write64_varreg(csa, state->trcacvr[i], TRCACVRn(i));
+		etm4x_relaxed_write64_varreg(csa, state->trcacatr[i], TRCACATRn(i));
 	}
 
 	for (i = 0; i < drvdata->numcidc; i++)
-		etm4x_relaxed_write64(csa, state->trccidcvr[i], TRCCIDCVRn(i));
+		etm4x_relaxed_write64_varreg(csa, state->trccidcvr[i], TRCCIDCVRn(i));
 
 	for (i = 0; i < drvdata->numvmidc; i++)
-		etm4x_relaxed_write64(csa, state->trcvmidcvr[i], TRCVMIDCVRn(i));
+		etm4x_relaxed_write64_varreg(csa, state->trcvmidcvr[i], TRCVMIDCVRn(i));
 
 	etm4x_relaxed_write32(csa, state->trccidcctlr0, TRCCIDCCTLR0);
 	if (drvdata->numcidc > 4)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index e5b79bdb9851..acad1befa207 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1001,6 +1001,75 @@ void etm4_config_trace_mode(struct etmv4_config *config);
 u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
 void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);
 
+/*
+ * Register accessors for variable register number, use in a loop
+ * when 'reg' is not a constant that can be passed into an inline
+ * assembly.
+ */
+static inline void etm4x_relaxed_write32_varreg(struct csdev_access *csa, u32 val, u32 offset)
+{
+	if (csa->io_mem)
+		writel_relaxed(val, csa->base + offset);
+	else
+		etm4x_sysreg_write(val, offset, true, false);
+}
+
+static inline void etm4x_relaxed_write64_varreg(struct csdev_access *csa, u64 val, u32 offset)
+{
+	if (csa->io_mem)
+		writeq_relaxed(val, csa->base + offset);
+	else
+		etm4x_sysreg_write(val, offset, true, true);
+}
+
+static inline void etm4x_write32_varreg(struct csdev_access *csa, u32 val, u32 offset)
+{
+	if (csa->io_mem)
+		writel(val, csa->base + offset);
+	else
+		etm4x_sysreg_write(val, offset, false, false);
+}
+
+static inline void etm4x_write64_varreg(struct csdev_access *csa, u64 val, u32 offset)
+{
+	if (csa->io_mem)
+		writeq(val, csa->base + offset);
+	else
+		etm4x_sysreg_write(val, offset, false, true);
+}
+
+static inline u32 etm4x_relaxed_read32_varreg(struct csdev_access *csa, u32 offset)
+{
+	if (csa->io_mem)
+		return readl_relaxed(csa->base + offset);
+	else
+		return etm4x_sysreg_read(offset, true, false);
+}
+
+static inline u64 etm4x_relaxed_read64_varreg(struct csdev_access *csa, u32 offset)
+{
+	if (csa->io_mem)
+		return readq(csa->base + offset);
+	else
+		return etm4x_sysreg_read(offset, true, true);
+}
+
+static inline u32 etm4x_read32_varreg(struct csdev_access *csa, u32 offset)
+{
+	if (csa->io_mem)
+		return readl(csa->base + offset);
+	else
+		return etm4x_sysreg_read(offset, false, false);
+}
+
+static inline u64 etm4x_read64_varreg(struct csdev_access *csa, u32 offset)
+{
+	if (csa->io_mem)
+		return readl(csa->base + offset);
+	else
+		return etm4x_sysreg_read(offset, false, true);
+}
+
 static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
 {
 	return drvdata->arch >= ETM_ARCH_ETE;
-- 
2.29.2

