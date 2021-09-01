Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04D03FE4A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbhIAVPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbhIAVPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:15:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54147C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:14:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y1-20020a17090a154100b00196156bbc18so269724pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OokNsp4UrykZT+eQauxAuXTbijFxZkIyiItq0d2NkZg=;
        b=LeLO9YasI1ErOQb/vinX44cN5Hwo7mmkpUPF+9ML76u/0KVlxzGqVByFdPvHAnaZRX
         EkJhg+gtBeD7S0uSpyKgG8b4p5nFpX/8EvcaJ5VjMEj8FeCNr7FJ7mxhsDgLxrtkaILq
         Ff5ZEiM1Txg1VjF8zSdgtXlw0iODfldcMo4rKLUc40GsHW16CfsX+c9eu0jbsu+OGohK
         Z52BbVQiAJkRvsQbjmEn7E9/ijiNivUv/Cj0FxNN9mb8zIJ+pAev2w/KxIJpIK/CmUHd
         80GpBgJoGwu0ZuIJKonQSTzSezNovuGb/L+0slFUVWv9EVrVFUH0Vb66sapi9qoMk2VV
         TbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OokNsp4UrykZT+eQauxAuXTbijFxZkIyiItq0d2NkZg=;
        b=UtDy0UoJ9qU3N6up2h7pw703BDg3hN1OkzbWL23KMiQEpc16VhB+/dNmtM8XryhNkY
         JbG3eIcGnwfo8jxCQn5lrGS0YRDknwY/MLGiwhA/gbb1quclgXmjta1RhoMRmL2doQE/
         3apMxYlzgEE7q5x8KbLxx8yr0UfAuLKKpfp4L3z/J2J7wvbeV7Hg4sTBO6/ST733+8LI
         2MlOJwFozz+3JJJEpgaW7ZZmyT1enAsz+8ECi1wsJnVtifuXKxL3oC70IH2WB1/vnTkp
         DvKnpCQmOZJD+6c/h8C/ghbStckYs73l3IKnKGhSO/l2R7lOQ1WeUPDJBNWDpLTz8HQH
         Ly/A==
X-Gm-Message-State: AOAM530V1MIGR/9ql7PuQF719HWzid55hMZyixDGe7U/aa5YVh+PsfS0
        hZYxOv7Mr64NaHPwbq0jWuVyWBURrWn4
X-Google-Smtp-Source: ABdhPJxSWGOyZwi4D2GXt5uKUhKM9UW+tMa8wIA0hudMgNLWQfS+Ej5bFEFcs6Bkw/wJbg8pOB4VH/lar4+A
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90b:ed7:: with SMTP id
 gz23mr124364pjb.1.1630530862296; Wed, 01 Sep 2021 14:14:22 -0700 (PDT)
Date:   Wed,  1 Sep 2021 21:14:01 +0000
In-Reply-To: <20210901211412.4171835-1-rananta@google.com>
Message-Id: <20210901211412.4171835-2-rananta@google.com>
Mime-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 01/12] KVM: arm64: selftests: Add MMIO readl/writel support
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
---
 .../selftests/kvm/include/aarch64/processor.h | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index c0273aefa63d..3cbaf5c1e26b 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -130,6 +130,49 @@ void vm_install_sync_handler(struct kvm_vm *vm,
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
2.33.0.153.gba50c8fa24-goog

