Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014B30AF09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBASVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhBASPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:39 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C8C061226
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b145so5349407pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFqKuZ77avnBtk4IXulMi5+rMq2IVk2aYxin4FMvrHc=;
        b=tNNaYYA/FAcx8YboDKjEYK/Wz/LrfjztgM5lacaRKXdWUchh2exQCqCnSGcd4pwP/J
         x883SkfZtJXTAa7Ums8VNSySNpP+avQLDWK3tE0isDG69mbmsZZ+cmBCJoFIGzye5kmI
         /dQYBzVFq4IaupP2yakuWg7qslDt7+4hGuvQ4LHzF4oxG6ge3jZqFo1oxW1e7YcQ/DOZ
         4vz+iFW7DLx0JZwZwxaqj4dm0ucOirZNsXByPCWnqC3QQlvRBw1q1eOXPl+W895PJTxa
         l1ORRKEttD/18O0eoI7b2T0XqM2wTWlpjNreTQftgW5K2nVl6mlM8cwCecZNPo/bYgGs
         XHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFqKuZ77avnBtk4IXulMi5+rMq2IVk2aYxin4FMvrHc=;
        b=CTgnZbvneKQOi+puzMjjYlFooRvEujFO6g1ihJ7GQGJnIak/sVM6ht0kK7DHOBt0DR
         kfh1QseMH85Lebjt1dLbUYi7E1/kt3rr5V4BwYWD5zi1SLwlfveU7u7gEfEaJLb2KAIl
         KDeZicQ9d+28no+CAunSHYW2HioP0oopbeXEwTbIe2lI0+vaKBKz9EhGmimQcRjkKrh0
         DJgyoZ78Cm3Z8qkyMNmLxnEt5jtom/vADjwcRuJd33abdUylKN00wgyYu3PVIvHn4uaW
         L7oqbSCOwYQv72CdrdYniwprQS/HuBh1SOkJR90jdEAJ3lZdP5tO2t/1Cn8QvAglZn6B
         13Ug==
X-Gm-Message-State: AOAM5325dGEEBP9MLIgybVZNIwt7wLaYQcPUoqdrQDGT5DNSaoxodwml
        Xw/SV59J95zGDZnr+QLUKfzvEw==
X-Google-Smtp-Source: ABdhPJydvY3uPmmMFUTcp+l1QuiF/pjOU53aOlMUba7lcWpTTYa8bHT6ZxhKjX7IFLTet5G927uiKA==
X-Received: by 2002:a65:498e:: with SMTP id r14mr18021647pgs.235.1612203264546;
        Mon, 01 Feb 2021 10:14:24 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:23 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/31] arm64: Add TRFCR_ELx definitions
Date:   Mon,  1 Feb 2021 11:13:49 -0700
Message-Id: <20210201181351.1475223-30-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Zhou <jonathan.zhouwen@huawei.com>

Add definitions for the Arm v8.4 SelfHosted trace extensions registers.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
[ split the register definitions to separate patch
  rename some of the symbols ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-28-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm64/include/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 8b5e7e5c3cc8..4acff97519b9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -191,6 +191,7 @@
 #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
 
 #define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
+#define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
 
 #define SYS_TTBR0_EL1			sys_reg(3, 0, 2, 0, 0)
 #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
@@ -471,6 +472,7 @@
 
 #define SYS_SCTLR_EL2			sys_reg(3, 4, 1, 0, 0)
 #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
+#define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
 #define SYS_DACR32_EL2			sys_reg(3, 4, 3, 0, 0)
 #define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
 #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
@@ -829,6 +831,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_TRACE_FILT_SHIFT	40
 #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
 #define ID_AA64DFR0_PMSVER_SHIFT	32
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
@@ -1003,6 +1006,14 @@
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
+#define TRFCR_ELx_TS_SHIFT		5
+#define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
+#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
+#define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
+#define TRFCR_EL2_CX			BIT(3)
+#define TRFCR_ELx_ExTRE			BIT(1)
+#define TRFCR_ELx_E0TRE			BIT(0)
+
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
-- 
2.25.1

