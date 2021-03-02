Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76FA32A968
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580903AbhCBSWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578857AbhCBP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:03 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58454C0610CE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:14 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id e29so11206800wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nEicUMjcQyXP0pA9FIMjfTzv1YgzRd5C/+30qtrzjc8=;
        b=IWWlsrxoA4/VxGyh8bUKvZgzoCrsAILxDoeJNc3FK3cKMETE655OoJhqjhur1cilCo
         LYMhoMHTidPCmYEdxDntem+etgADvVUzHzOW5PAiTOjO1sxQz4TD7miwsbP4bqNvgZRY
         GlZRhT8A/bOsfAFAa73IPeR9tNI/bBCdkf7nnRVUDgwoAz6Myk3gOAqETYRQmdfeuwDY
         8lBXQN3iPad2h8Ls6GQLyVj6IEr29AuM9kgnxAvmC7NESy44kzshGuXQ3dD7/Q0a9qA3
         OFFXEc6wzEJ7OPcIwYWrU4XqEJ8dFiy2sRgH0Sm3Ojhm/myIj/5hcEc+9CMBFz1e24oI
         1/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nEicUMjcQyXP0pA9FIMjfTzv1YgzRd5C/+30qtrzjc8=;
        b=qQnZ/DdpPvOWkx7zntOxrn7pbsDvGAc4QfgQF2hZ9a7XwCn5zasVFiBMIGR0ZuytbW
         srHC1nFN/0S9T9IiEtYbCcQX1eh8Gmc9FrcCVCuG7A7zeLyobFH4iyiquP4I52f2amtB
         zVSqSuJYt4iFr0LkIgg2KqFA11pZEer8QykHmMUv5JtyPeTdKtQ3k2y3l9Wa7twBbjkJ
         3iUF+HLERjsPVayE+I3LmefAB239OLMi2wSKMxN+cFcMQIUQ4/dF7KVhVj0sZFhOv/3K
         fHWIzCr8WwdyhzhBMcq5d6xH0bTxtJyhDeIhO1w65YENjaIhCa+dAzhp+8IYFTmbUa/Y
         hZRw==
X-Gm-Message-State: AOAM530a3IKku+KwXAHVJ8JuyUPryaSvRyh3dMqrfRMxmKLyyCITAj5F
        +NRNe7vgcL1cd0vTX+i+xYkdQWviF6qr
X-Google-Smtp-Source: ABdhPJyhRguqkBiAL8rawxftQTL4cQe8tkMBmRvxwBQhjvtLIZuZAUV1pK/Un8+K/eUrAfebq5+z4KnW7CHU
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:5f89:: with SMTP id
 t131mr4235263wmb.173.1614697212949; Tue, 02 Mar 2021 07:00:12 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:33 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-4-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 03/32] arm64: kvm: Add standalone ticket spinlock
 implementation for use at hyp
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

We will soon need to synchronise multiple CPUs in the hyp text at EL2.
The qspinlock-based locking used by the host is overkill for this purpose
and relies on the kernel's "percpu" implementation for the MCS nodes.

Implement a simple ticket locking scheme based heavily on the code removed
by commit c11090474d70 ("arm64: locking: Replace ticket lock implementation
with qspinlock").

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h

diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
new file mode 100644
index 000000000000..76b537f8d1c6
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * A stand-alone ticket spinlock implementation for use by the non-VHE
+ * KVM hypervisor code running at EL2.
+ *
+ * Copyright (C) 2020 Google LLC
+ * Author: Will Deacon <will@kernel.org>
+ *
+ * Heavily based on the implementation removed by c11090474d70 which was:
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __ARM64_KVM_NVHE_SPINLOCK_H__
+#define __ARM64_KVM_NVHE_SPINLOCK_H__
+
+#include <asm/alternative.h>
+#include <asm/lse.h>
+
+typedef union hyp_spinlock {
+	u32	__val;
+	struct {
+#ifdef __AARCH64EB__
+		u16 next, owner;
+#else
+		u16 owner, next;
+#endif
+	};
+} hyp_spinlock_t;
+
+#define hyp_spin_lock_init(l)						\
+do {									\
+	*(l) = (hyp_spinlock_t){ .__val = 0 };				\
+} while (0)
+
+static inline void hyp_spin_lock(hyp_spinlock_t *lock)
+{
+	u32 tmp;
+	hyp_spinlock_t lockval, newval;
+
+	asm volatile(
+	/* Atomically increment the next ticket. */
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+"	prfm	pstl1strm, %3\n"
+"1:	ldaxr	%w0, %3\n"
+"	add	%w1, %w0, #(1 << 16)\n"
+"	stxr	%w2, %w1, %3\n"
+"	cbnz	%w2, 1b\n",
+	/* LSE atomics */
+"	mov	%w2, #(1 << 16)\n"
+"	ldadda	%w2, %w0, %3\n"
+	__nops(3))
+
+	/* Did we get the lock? */
+"	eor	%w1, %w0, %w0, ror #16\n"
+"	cbz	%w1, 3f\n"
+	/*
+	 * No: spin on the owner. Send a local event to avoid missing an
+	 * unlock before the exclusive load.
+	 */
+"	sevl\n"
+"2:	wfe\n"
+"	ldaxrh	%w2, %4\n"
+"	eor	%w1, %w2, %w0, lsr #16\n"
+"	cbnz	%w1, 2b\n"
+	/* We got the lock. Critical section starts here. */
+"3:"
+	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp), "+Q" (*lock)
+	: "Q" (lock->owner)
+	: "memory");
+}
+
+static inline void hyp_spin_unlock(hyp_spinlock_t *lock)
+{
+	u64 tmp;
+
+	asm volatile(
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+	"	ldrh	%w1, %0\n"
+	"	add	%w1, %w1, #1\n"
+	"	stlrh	%w1, %0",
+	/* LSE atomics */
+	"	mov	%w1, #1\n"
+	"	staddlh	%w1, %0\n"
+	__nops(1))
+	: "=Q" (lock->owner), "=&r" (tmp)
+	:
+	: "memory");
+}
+
+#endif /* __ARM64_KVM_NVHE_SPINLOCK_H__ */
-- 
2.30.1.766.gb4fecdf3b7-goog

