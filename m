Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3840BB85
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhINWcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbhINWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:32:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m9-20020a17090ade09b029017903cc8d6cso2667901pjv.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S2j8r1BCKqhVhJ+8bR7t/dA2J/PIIE/Rns3zAg7zZww=;
        b=SF+8jytE6tsk7OdA1EjKqcwdx9BTnDEREQgH6nl2uYaQV6EsWg9JbEN1WShtL0KrTK
         nIJrAF8y6vYLIizVYUdOeQM3tqJNxxCw25p/g7bhvEHMt0ttYN5R5m4oqvgDEttZJYNp
         jGhndv6Q7RT3FSoSJyS2jvzSCkY3lH5Vb+skzup8e1pD3ppCKZhFcxdVKtRVhOp1H40U
         Ehg1qIXzFtqoy3sgq12X2c1wb0cLIVod97evqV5ZXRyTDhW001I2Uo5WcNl35wkl/TG4
         DF42qFBq26VDenW/Kz1W7jxnPPAD53T19C1mYz8TTNRznLL5dZ+UsN77LxSTxVTbMBMQ
         IeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S2j8r1BCKqhVhJ+8bR7t/dA2J/PIIE/Rns3zAg7zZww=;
        b=nSli39FFoT60d/MdoQw2YvqHfiFTBsTtkJ4zeJQExgFhwmk2kMrkp0SlbyzejZMfY+
         IYxr05qrC+OMo5IjYTa6YQmkoxz36iSYK0T0WSiEcyQ6TjYHA8fhFK4C28rcftkJUaoV
         /qz1Kthbv57xV4owRmUi+ihIR0ztnBR7fCExd2wIx/F35qAUoJhpWcSXit9ZSwjrEo6E
         YkdZuZyCreyAAB8eVHpdlGLRAfyef0U7tlg7EO77xPQpWmMXU8V6D+J1Mm6wWTFPLeCV
         T5BMSRmX0pVkpScRMAGrWDybFY4mTXIJ71FDb7tbTF0BG/hCe2ZujmHx0P3JY3iBzvTC
         k6zQ==
X-Gm-Message-State: AOAM532lU0yUoeITkIek6FnaQh9j4YeibofQh/k2wD7sj6jbgnBB79ro
        KKIFplfqWWh2plliZKyEaJD77MY0A9vY
X-Google-Smtp-Source: ABdhPJznyX0vOJEHN8tDK0ykFp8Ok1BU6n72Ike+NrTzqOrtDgUxbHGRXF1d5AyiWweWcLPS52UxS5UGLckH
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90b:fd7:: with SMTP id
 gd23mr57225pjb.1.1631658684598; Tue, 14 Sep 2021 15:31:24 -0700 (PDT)
Date:   Tue, 14 Sep 2021 22:31:00 +0000
In-Reply-To: <20210914223114.435273-1-rananta@google.com>
Message-Id: <20210914223114.435273-2-rananta@google.com>
Mime-Version: 1.0
References: <20210914223114.435273-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v7 01/15] KVM: arm64: selftests: Add MMIO readl/writel support
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the readl() and writel() functions for the guests to
access (4-byte) the MMIO region.

The routines, and their dependents, are inspired from the kernel's
arch/arm64/include/asm/io.h and arch/arm64/include/asm/barrier.h.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 .../selftests/kvm/include/aarch64/processor.h | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index c0273aefa63d..96578bd46a85 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -9,6 +9,7 @@
 
 #include "kvm_util.h"
 #include <linux/stringify.h>
+#include <linux/types.h>
 
 
 #define ARM64_CORE_REG(x) (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
@@ -130,6 +131,49 @@ void vm_install_sync_handler(struct kvm_vm *vm,
 	val;								  \
 })
 
-#define isb()	asm volatile("isb" : : : "memory")
+#define isb()		asm volatile("isb" : : : "memory")
+#define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
+#define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
+
+#define dma_wmb()	dmb(oshst)
+#define __iowmb()	dma_wmb()
+
+#define dma_rmb()	dmb(oshld)
+
+#define __iormb(v)							\
+({									\
+	unsigned long tmp;						\
+									\
+	dma_rmb();							\
+									\
+	/*								\
+	 * Courtesy of arch/arm64/include/asm/io.h:			\
+	 * Create a dummy control dependency from the IO read to any	\
+	 * later instructions. This ensures that a subsequent call	\
+	 * to udelay() will be ordered due to the ISB in __delay().	\
+	 */								\
+	asm volatile("eor	%0, %1, %1\n"				\
+		     "cbnz	%0, ."					\
+		     : "=r" (tmp) : "r" ((unsigned long)(v))		\
+		     : "memory");					\
+})
+
+static __always_inline void __raw_writel(u32 val, volatile void *addr)
+{
+	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
+}
+
+static __always_inline u32 __raw_readl(const volatile void *addr)
+{
+	u32 val;
+	asm volatile("ldr %w0, [%1]" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define writel_relaxed(v,c)	((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
+#define readl_relaxed(c)	({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
+
+#define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c));})
+#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
 
 #endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.33.0.309.g3052b89438-goog

