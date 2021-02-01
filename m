Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DCC30AFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhBASmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhBASO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:56 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C3C061352
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:08 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w18so12132736pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+NFDJGlpM5QpztMeS6Hm1Oc/dcOLaVrzObDSDa29bg=;
        b=vwP8Z6xXnL1m8asUdIB5g/jSNUuoeJo832/cnhJcP+SRHzXWvY6621sRnh3dcErbA5
         kZTVk0+87+UkkY4PDmUj44GVoAFd4PNtAaPgrJbmOQ4czK+oDKwiyCSkgSkIqkvVCaB4
         CUoC8uyYQT3XJiw5Uarb6pKatffWr4YnfOavLy1tJ1jcfE0blh9SZpa0inviO6rHGzuY
         HdewBE7+wbXQkO+rSJoevUlxirpQehQg9VI1Q2g3XCpPTWza1c7M4w5hoq+h4a1+FAj0
         oWWp3thkIa+5akxDSgsV/hb7FT7dGrS5elIGEY9P1dHIcB+lHb+0OMOhiXnf9+YJ3cuf
         QlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+NFDJGlpM5QpztMeS6Hm1Oc/dcOLaVrzObDSDa29bg=;
        b=Yhh7mW6LzGdT8C0jzcXNrJeHf5zd2hR10RJY4o63d1CWCRyDz9rgOyDNIa5gqGY7HN
         2DxH9xJPNXqPokK8IzxE8Hko36V46XC9205RE6Zg7lYdgETfbQ/imxOm5iGOXwNuqOSV
         AKzv3RsbO6liQOk+sTR7M0HDdabXiJ6D1VTgbVuv//ZTrWoY8Fj1n8D+4uop010kGNHO
         aeB7hcJoP81YXB5ZgeAGOz04x3gq0NCSr6W+OATetnJc3P4qBTLlRboFOB9iMxW+kVPJ
         Xm76qdqxK9ogFxU/n6wECEaHCmXbZMnQH/Uva110rVpS1PYCPB6NaDUL7KfscvReXm2l
         jA8w==
X-Gm-Message-State: AOAM530n+vmD8Bgw1/iUpzlPU3eisyljmC2DXHQFYjRtkdGPbmPhp/s8
        0hsM8tNfOLCYDaiGokosVokhcg==
X-Google-Smtp-Source: ABdhPJyLPgMuvrK3hefT02NxHJD58kX7+rr5r5xo4RABFSohcu2Ss2Jzcy++56LRNZ1jbzsyXxPk1A==
X-Received: by 2002:a63:405:: with SMTP id 5mr18182162pge.44.1612203247911;
        Mon, 01 Feb 2021 10:14:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:07 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/31] coresight: etm4x: Add sysreg access helpers
Date:   Mon,  1 Feb 2021 11:13:33 -0700
Message-Id: <20210201181351.1475223-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

ETM architecture defines the system instructions for accessing
via register accesses. Add basic support for accessing a given
register via system instructions.

We split the list of registers as :
 1) Accessible only from memory mapped interface
 2) Accessible from system register instructions.

All registers are accessible via the memory-mapped interface.
However, some registers are not accessible via the system
instructions. This list is then used to further filter out
the files we expose via sysfs.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-12-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          |  32 ++
 drivers/hwtracing/coresight/coresight-etm4x.h | 343 ++++++++++++++++--
 2 files changed, 353 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 9331281b931f..37f90d380436 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -75,6 +75,38 @@ static inline bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
 	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
 }
 
+u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
+{
+	u64 res = 0;
+
+	switch (offset) {
+	ETM4x_READ_SYSREG_CASES(res)
+	default :
+		pr_warn_ratelimited("etm4x: trying to read unsupported register @%x\n",
+			 offset);
+	}
+
+	if (!_relaxed)
+		__iormb(res);	/* Imitate the !relaxed I/O helpers */
+
+	return res;
+}
+
+void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
+{
+	if (!_relaxed)
+		__iowmb();	/* Imitate the !relaxed I/O helpers */
+	if (!_64bit)
+		val &= GENMASK(31, 0);
+
+	switch (offset) {
+	ETM4x_WRITE_SYSREG_CASES(val)
+	default :
+		pr_warn_ratelimited("etm4x: trying to write to unsupported register @%x\n",
+			offset);
+	}
+}
+
 static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
 {
 	/* Writing 0 to TRCOSLAR unlocks the trace registers */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 3c2b49ffabc8..24ba0da5b096 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -126,29 +126,325 @@
 #define TRCCIDR2			0xFF8
 #define TRCCIDR3			0xFFC
 
-#define etm4x_relaxed_read32(csa, offset)		\
-	readl_relaxed((csa)->base + (offset))
-
-#define etm4x_read32(csa, offset)			\
-	readl((csa)->base + (offset))
-
-#define etm4x_relaxed_write32(csa, val, offset)		\
-	writel_relaxed((val), (csa)->base + (offset))
-
-#define etm4x_write32(csa, val, offset)			\
-	writel((val), (csa)->base + (offset))
-
-#define etm4x_relaxed_read64(csa, offset)		\
-	readq_relaxed((csa)->base + (offset))
-
-#define etm4x_read64(csa, offset)			\
-	readq((csa)->base + (offset))
-
-#define etm4x_relaxed_write64(csa, val, offset)		\
-	writeq_relaxed((val), (csa)->base + (offset))
+/*
+ * System instructions to access ETM registers.
+ * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
+ */
+#define ETM4x_OFFSET_TO_REG(x)		((x) >> 2)
+
+#define ETM4x_CRn(n)			(((n) >> 7) & 0x7)
+#define ETM4x_Op2(n)			(((n) >> 4) & 0x7)
+#define ETM4x_CRm(n)			((n) & 0xf)
+
+#include <asm/sysreg.h>
+#define ETM4x_REG_NUM_TO_SYSREG(n)				\
+	sys_reg(2, 1, ETM4x_CRn(n), ETM4x_CRm(n), ETM4x_Op2(n))
+
+#define READ_ETM4x_REG(reg)					\
+	read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
+#define WRITE_ETM4x_REG(val, reg)				\
+	write_sysreg_s(val, ETM4x_REG_NUM_TO_SYSREG((reg)))
+
+#define read_etm4x_sysreg_const_offset(offset)			\
+	READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
+
+#define write_etm4x_sysreg_const_offset(val, offset)		\
+	WRITE_ETM4x_REG(val, ETM4x_OFFSET_TO_REG(offset))
+
+#define CASE_READ(res, x)					\
+	case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }
+
+#define CASE_WRITE(val, x)					\
+	case (x): { write_etm4x_sysreg_const_offset((val), (x)); break; }
+
+/* List of registers accessible via System instructions */
+#define ETM_SYSREG_LIST(op, val)		\
+	CASE_##op((val), TRCPRGCTLR)		\
+	CASE_##op((val), TRCPROCSELR)		\
+	CASE_##op((val), TRCSTATR)		\
+	CASE_##op((val), TRCCONFIGR)		\
+	CASE_##op((val), TRCAUXCTLR)		\
+	CASE_##op((val), TRCEVENTCTL0R)		\
+	CASE_##op((val), TRCEVENTCTL1R)		\
+	CASE_##op((val), TRCSTALLCTLR)		\
+	CASE_##op((val), TRCTSCTLR)		\
+	CASE_##op((val), TRCSYNCPR)		\
+	CASE_##op((val), TRCCCCTLR)		\
+	CASE_##op((val), TRCBBCTLR)		\
+	CASE_##op((val), TRCTRACEIDR)		\
+	CASE_##op((val), TRCQCTLR)		\
+	CASE_##op((val), TRCVICTLR)		\
+	CASE_##op((val), TRCVIIECTLR)		\
+	CASE_##op((val), TRCVISSCTLR)		\
+	CASE_##op((val), TRCVIPCSSCTLR)		\
+	CASE_##op((val), TRCVDCTLR)		\
+	CASE_##op((val), TRCVDSACCTLR)		\
+	CASE_##op((val), TRCVDARCCTLR)		\
+	CASE_##op((val), TRCSEQEVRn(0))		\
+	CASE_##op((val), TRCSEQEVRn(1))		\
+	CASE_##op((val), TRCSEQEVRn(2))		\
+	CASE_##op((val), TRCSEQRSTEVR)		\
+	CASE_##op((val), TRCSEQSTR)		\
+	CASE_##op((val), TRCEXTINSELR)		\
+	CASE_##op((val), TRCCNTRLDVRn(0))	\
+	CASE_##op((val), TRCCNTRLDVRn(1))	\
+	CASE_##op((val), TRCCNTRLDVRn(2))	\
+	CASE_##op((val), TRCCNTRLDVRn(3))	\
+	CASE_##op((val), TRCCNTCTLRn(0))	\
+	CASE_##op((val), TRCCNTCTLRn(1))	\
+	CASE_##op((val), TRCCNTCTLRn(2))	\
+	CASE_##op((val), TRCCNTCTLRn(3))	\
+	CASE_##op((val), TRCCNTVRn(0))		\
+	CASE_##op((val), TRCCNTVRn(1))		\
+	CASE_##op((val), TRCCNTVRn(2))		\
+	CASE_##op((val), TRCCNTVRn(3))		\
+	CASE_##op((val), TRCIDR8)		\
+	CASE_##op((val), TRCIDR9)		\
+	CASE_##op((val), TRCIDR10)		\
+	CASE_##op((val), TRCIDR11)		\
+	CASE_##op((val), TRCIDR12)		\
+	CASE_##op((val), TRCIDR13)		\
+	CASE_##op((val), TRCIMSPECn(0))		\
+	CASE_##op((val), TRCIMSPECn(1))		\
+	CASE_##op((val), TRCIMSPECn(2))		\
+	CASE_##op((val), TRCIMSPECn(3))		\
+	CASE_##op((val), TRCIMSPECn(4))		\
+	CASE_##op((val), TRCIMSPECn(5))		\
+	CASE_##op((val), TRCIMSPECn(6))		\
+	CASE_##op((val), TRCIMSPECn(7))		\
+	CASE_##op((val), TRCIDR0)		\
+	CASE_##op((val), TRCIDR1)		\
+	CASE_##op((val), TRCIDR2)		\
+	CASE_##op((val), TRCIDR3)		\
+	CASE_##op((val), TRCIDR4)		\
+	CASE_##op((val), TRCIDR5)		\
+	CASE_##op((val), TRCIDR6)		\
+	CASE_##op((val), TRCIDR7)		\
+	CASE_##op((val), TRCRSCTLRn(2))		\
+	CASE_##op((val), TRCRSCTLRn(3))		\
+	CASE_##op((val), TRCRSCTLRn(4))		\
+	CASE_##op((val), TRCRSCTLRn(5))		\
+	CASE_##op((val), TRCRSCTLRn(6))		\
+	CASE_##op((val), TRCRSCTLRn(7))		\
+	CASE_##op((val), TRCRSCTLRn(8))		\
+	CASE_##op((val), TRCRSCTLRn(9))		\
+	CASE_##op((val), TRCRSCTLRn(10))	\
+	CASE_##op((val), TRCRSCTLRn(11))	\
+	CASE_##op((val), TRCRSCTLRn(12))	\
+	CASE_##op((val), TRCRSCTLRn(13))	\
+	CASE_##op((val), TRCRSCTLRn(14))	\
+	CASE_##op((val), TRCRSCTLRn(15))	\
+	CASE_##op((val), TRCRSCTLRn(16))	\
+	CASE_##op((val), TRCRSCTLRn(17))	\
+	CASE_##op((val), TRCRSCTLRn(18))	\
+	CASE_##op((val), TRCRSCTLRn(19))	\
+	CASE_##op((val), TRCRSCTLRn(20))	\
+	CASE_##op((val), TRCRSCTLRn(21))	\
+	CASE_##op((val), TRCRSCTLRn(22))	\
+	CASE_##op((val), TRCRSCTLRn(23))	\
+	CASE_##op((val), TRCRSCTLRn(24))	\
+	CASE_##op((val), TRCRSCTLRn(25))	\
+	CASE_##op((val), TRCRSCTLRn(26))	\
+	CASE_##op((val), TRCRSCTLRn(27))	\
+	CASE_##op((val), TRCRSCTLRn(28))	\
+	CASE_##op((val), TRCRSCTLRn(29))	\
+	CASE_##op((val), TRCRSCTLRn(30))	\
+	CASE_##op((val), TRCRSCTLRn(31))	\
+	CASE_##op((val), TRCSSCCRn(0))		\
+	CASE_##op((val), TRCSSCCRn(1))		\
+	CASE_##op((val), TRCSSCCRn(2))		\
+	CASE_##op((val), TRCSSCCRn(3))		\
+	CASE_##op((val), TRCSSCCRn(4))		\
+	CASE_##op((val), TRCSSCCRn(5))		\
+	CASE_##op((val), TRCSSCCRn(6))		\
+	CASE_##op((val), TRCSSCCRn(7))		\
+	CASE_##op((val), TRCSSCSRn(0))		\
+	CASE_##op((val), TRCSSCSRn(1))		\
+	CASE_##op((val), TRCSSCSRn(2))		\
+	CASE_##op((val), TRCSSCSRn(3))		\
+	CASE_##op((val), TRCSSCSRn(4))		\
+	CASE_##op((val), TRCSSCSRn(5))		\
+	CASE_##op((val), TRCSSCSRn(6))		\
+	CASE_##op((val), TRCSSCSRn(7))		\
+	CASE_##op((val), TRCSSPCICRn(0))	\
+	CASE_##op((val), TRCSSPCICRn(1))	\
+	CASE_##op((val), TRCSSPCICRn(2))	\
+	CASE_##op((val), TRCSSPCICRn(3))	\
+	CASE_##op((val), TRCSSPCICRn(4))	\
+	CASE_##op((val), TRCSSPCICRn(5))	\
+	CASE_##op((val), TRCSSPCICRn(6))	\
+	CASE_##op((val), TRCSSPCICRn(7))	\
+	CASE_##op((val), TRCOSLAR)		\
+	CASE_##op((val), TRCOSLSR)		\
+	CASE_##op((val), TRCACVRn(0))		\
+	CASE_##op((val), TRCACVRn(1))		\
+	CASE_##op((val), TRCACVRn(2))		\
+	CASE_##op((val), TRCACVRn(3))		\
+	CASE_##op((val), TRCACVRn(4))		\
+	CASE_##op((val), TRCACVRn(5))		\
+	CASE_##op((val), TRCACVRn(6))		\
+	CASE_##op((val), TRCACVRn(7))		\
+	CASE_##op((val), TRCACVRn(8))		\
+	CASE_##op((val), TRCACVRn(9))		\
+	CASE_##op((val), TRCACVRn(10))		\
+	CASE_##op((val), TRCACVRn(11))		\
+	CASE_##op((val), TRCACVRn(12))		\
+	CASE_##op((val), TRCACVRn(13))		\
+	CASE_##op((val), TRCACVRn(14))		\
+	CASE_##op((val), TRCACVRn(15))		\
+	CASE_##op((val), TRCACATRn(0))		\
+	CASE_##op((val), TRCACATRn(1))		\
+	CASE_##op((val), TRCACATRn(2))		\
+	CASE_##op((val), TRCACATRn(3))		\
+	CASE_##op((val), TRCACATRn(4))		\
+	CASE_##op((val), TRCACATRn(5))		\
+	CASE_##op((val), TRCACATRn(6))		\
+	CASE_##op((val), TRCACATRn(7))		\
+	CASE_##op((val), TRCACATRn(8))		\
+	CASE_##op((val), TRCACATRn(9))		\
+	CASE_##op((val), TRCACATRn(10))		\
+	CASE_##op((val), TRCACATRn(11))		\
+	CASE_##op((val), TRCACATRn(12))		\
+	CASE_##op((val), TRCACATRn(13))		\
+	CASE_##op((val), TRCACATRn(14))		\
+	CASE_##op((val), TRCACATRn(15))		\
+	CASE_##op((val), TRCDVCVRn(0))		\
+	CASE_##op((val), TRCDVCVRn(1))		\
+	CASE_##op((val), TRCDVCVRn(2))		\
+	CASE_##op((val), TRCDVCVRn(3))		\
+	CASE_##op((val), TRCDVCVRn(4))		\
+	CASE_##op((val), TRCDVCVRn(5))		\
+	CASE_##op((val), TRCDVCVRn(6))		\
+	CASE_##op((val), TRCDVCVRn(7))		\
+	CASE_##op((val), TRCDVCMRn(0))		\
+	CASE_##op((val), TRCDVCMRn(1))		\
+	CASE_##op((val), TRCDVCMRn(2))		\
+	CASE_##op((val), TRCDVCMRn(3))		\
+	CASE_##op((val), TRCDVCMRn(4))		\
+	CASE_##op((val), TRCDVCMRn(5))		\
+	CASE_##op((val), TRCDVCMRn(6))		\
+	CASE_##op((val), TRCDVCMRn(7))		\
+	CASE_##op((val), TRCCIDCVRn(0))		\
+	CASE_##op((val), TRCCIDCVRn(1))		\
+	CASE_##op((val), TRCCIDCVRn(2))		\
+	CASE_##op((val), TRCCIDCVRn(3))		\
+	CASE_##op((val), TRCCIDCVRn(4))		\
+	CASE_##op((val), TRCCIDCVRn(5))		\
+	CASE_##op((val), TRCCIDCVRn(6))		\
+	CASE_##op((val), TRCCIDCVRn(7))		\
+	CASE_##op((val), TRCVMIDCVRn(0))	\
+	CASE_##op((val), TRCVMIDCVRn(1))	\
+	CASE_##op((val), TRCVMIDCVRn(2))	\
+	CASE_##op((val), TRCVMIDCVRn(3))	\
+	CASE_##op((val), TRCVMIDCVRn(4))	\
+	CASE_##op((val), TRCVMIDCVRn(5))	\
+	CASE_##op((val), TRCVMIDCVRn(6))	\
+	CASE_##op((val), TRCVMIDCVRn(7))	\
+	CASE_##op((val), TRCCIDCCTLR0)		\
+	CASE_##op((val), TRCCIDCCTLR1)		\
+	CASE_##op((val), TRCVMIDCCTLR0)		\
+	CASE_##op((val), TRCVMIDCCTLR1)		\
+	CASE_##op((val), TRCCLAIMSET)		\
+	CASE_##op((val), TRCCLAIMCLR)		\
+	CASE_##op((val), TRCAUTHSTATUS)		\
+	CASE_##op((val), TRCDEVARCH)		\
+	CASE_##op((val), TRCDEVID)
+
+/* List of registers only accessible via memory-mapped interface */
+#define ETM_MMAP_LIST(op, val)			\
+	CASE_##op((val), TRCDEVTYPE)		\
+	CASE_##op((val), TRCPDCR)		\
+	CASE_##op((val), TRCPDSR)		\
+	CASE_##op((val), TRCDEVAFF0)		\
+	CASE_##op((val), TRCDEVAFF1)		\
+	CASE_##op((val), TRCLAR)		\
+	CASE_##op((val), TRCLSR)		\
+	CASE_##op((val), TRCITCTRL)		\
+	CASE_##op((val), TRCPIDR4)		\
+	CASE_##op((val), TRCPIDR0)		\
+	CASE_##op((val), TRCPIDR1)		\
+	CASE_##op((val), TRCPIDR2)		\
+	CASE_##op((val), TRCPIDR3)
+
+#define ETM4x_READ_SYSREG_CASES(res)	ETM_SYSREG_LIST(READ, (res))
+#define ETM4x_WRITE_SYSREG_CASES(val)	ETM_SYSREG_LIST(WRITE, (val))
+
+#define read_etm4x_sysreg_offset(offset, _64bit)				\
+	({									\
+		u64 __val;							\
+										\
+		if (__builtin_constant_p((offset)))				\
+			__val = read_etm4x_sysreg_const_offset((offset));	\
+		else								\
+			__val = etm4x_sysreg_read((offset), true, (_64bit));	\
+		__val;								\
+	 })
+
+#define write_etm4x_sysreg_offset(val, offset, _64bit)			\
+	do {								\
+		if (__builtin_constant_p((offset)))			\
+			write_etm4x_sysreg_const_offset((val),		\
+							(offset));	\
+		else							\
+			etm4x_sysreg_write((val), (offset), true,	\
+					   (_64bit));			\
+	} while (0)
+
+
+#define etm4x_relaxed_read32(csa, offset)				\
+	((u32)((csa)->io_mem ?						\
+		 readl_relaxed((csa)->base + (offset)) :		\
+		 read_etm4x_sysreg_offset((offset), false)))
+
+#define etm4x_relaxed_read64(csa, offset)				\
+	((u64)((csa)->io_mem ?						\
+		 readq_relaxed((csa)->base + (offset)) :		\
+		 read_etm4x_sysreg_offset((offset), true)))
+
+#define etm4x_read32(csa, offset)					\
+	({								\
+		u32 __val = etm4x_relaxed_read32((csa), (offset));	\
+		__iormb(__val);						\
+		__val;							\
+	 })
+
+#define etm4x_read64(csa, offset)					\
+	({								\
+		u64 __val = etm4x_relaxed_read64((csa), (offset));	\
+		__iormb(__val);						\
+		__val;							\
+	 })
+
+#define etm4x_relaxed_write32(csa, val, offset)				\
+	do {								\
+		if ((csa)->io_mem)					\
+			writel_relaxed((val), (csa)->base + (offset));	\
+		else							\
+			write_etm4x_sysreg_offset((val), (offset),	\
+						  false);		\
+	} while (0)
+
+#define etm4x_relaxed_write64(csa, val, offset)				\
+	do {								\
+		if ((csa)->io_mem)					\
+			writeq_relaxed((val), (csa)->base + (offset));	\
+		else							\
+			write_etm4x_sysreg_offset((val), (offset),	\
+						  true);		\
+	} while (0)
+
+#define etm4x_write32(csa, val, offset)					\
+	do {								\
+		__iowmb();						\
+		etm4x_relaxed_write32((csa), (val), (offset));		\
+	} while (0)
+
+#define etm4x_write64(csa, val, offset)					\
+	do {								\
+		__iowmb();						\
+		etm4x_relaxed_write64((csa), (val), (offset));		\
+	} while (0)
 
-#define etm4x_write64(csa, val, offset)			\
-	writeq((val), (csa)->base + (offset))
 
 /* ETMv4 resources */
 #define ETM_MAX_NR_PE			8
@@ -522,4 +818,7 @@ enum etm_addr_ctxtype {
 
 extern const struct attribute_group *coresight_etmv4_groups[];
 void etm4_config_trace_mode(struct etmv4_config *config);
+
+u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
+void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);
 #endif
-- 
2.25.1

