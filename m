Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C969403E86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352595AbhIHRrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352015AbhIHRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1653CC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q22so2733147pfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pSiPeFKJFYMukSt/z6kM3xPQTQJ5rRNs0AebXPpOAjY=;
        b=lvDh9GGZLkgD7T0MpO6mJqO1zKn4Emh27aECvcIM/oARYff0Ld9qG7tSgXq/CedXB5
         fB4xf0oyhzvsa5cp+yMJ7zpr/aZWxgfh3Q4o9V8tP3yxJN30Wvy0ob9eJjq6evhpMjGc
         nUi7RVymNQRvkd2CSh/EAKt8hf/i6dhyDrXcYRXqwCDoMPLbNDMErGzU3qYVYEdgzr0m
         eRZGCi/XKc9JeqT/pzEhrrvezbhODxi60WN+IZLJKQ8J2/ojcrKdEE9siFPjlgkIgldb
         X0BhnfDzrhytB7YAe0w1MyBH/dNucHkXULpkUO7Qp7OYcTvGlDFRjn3DWq8wuZV1CA//
         9VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSiPeFKJFYMukSt/z6kM3xPQTQJ5rRNs0AebXPpOAjY=;
        b=BG0NKlXur9PdICowCLflYGgL2mbvOmXxDiOMKtw8v7L86bjPXuybrcNSQ1PgFzzqFG
         9z2NY02tPMZmH6vECUifqcEDzCVRmnS/YkVnloojm6+FzDczYLyZExoVRuUB4xOUS9gY
         r1p2rRUK2S2qRvfVt1Wqjx/hWQmstkclgGPfjvBEfTtzpsL2M53JODTS1xsDerb4vvmM
         F0hS7KRcv8YuCCLGk9rH/HkBYa2UYGrkHE6YA2pOfD1gDenwHNtU4P8m4Z48aYxLJFfg
         34z+63VAkPB95ODKqS3/9sN9bIThoSjJQvKGKIRoEMgWTZzkt2mBHy/vzpTtsRb8DJWL
         RO5g==
X-Gm-Message-State: AOAM532DoPinqdo6WqK4U8UoG9LV5Q84QKj3Rd5Z36fJLCatcCP4mI7Y
        SGFbDfJZNqyQgLa1/wm/v9TeEg==
X-Google-Smtp-Source: ABdhPJxHoYFO23X9FyxyyPQJjwZQsR3NlqqKuP+9I8AaPra5xplC/o8GCPTR2QWd9hMmYO6/aaTvxw==
X-Received: by 2002:a63:f512:: with SMTP id w18mr4762050pgh.280.1631123151561;
        Wed, 08 Sep 2021 10:45:51 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:51 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 10/21] riscv: Add ptrace vector support
Date:   Thu,  9 Sep 2021 01:45:22 +0800
Message-Id: <07afb9f4c528e5209ce07e81496920f595932aec.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ptrace support for riscv vector. The vector registers will
be saved in datap pointer of __riscv_v_state. This pointer will be set
right after the __riscv_v_state data structure then it will be put in ubuf
for ptrace system call to get or set. It will check if the datap got from
ubuf is set to the correct address or not when the ptrace system call is
trying to set the vector registers.

Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/uapi/asm/ptrace.h | 14 ++++++
 arch/riscv/kernel/ptrace.c           | 71 ++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 86 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index bd3b8a710246..c3760395236c 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -83,11 +83,25 @@ struct __riscv_v_state {
 	unsigned long vtype;
 	unsigned long vcsr;
 	void *datap;
+	/*
+	 * In signal handler, datap will be set a correct user stack offset
+	 * and vector registers will be copied to the address of datap
+	 * pointer.
+	 *
+	 * In ptrace syscall, datap will be set to zero and the vector
+	 * registers will be copied to the address right after this
+	 * structure.
+	 */
 #if __riscv_xlen == 32
 	__u32 __padding;
 #endif
 };
 
+/*
+ * To define a practical maximum vlenb for ptrace and it may need to be
+ * extended someday.
+ */
+#define RISCV_MAX_VLENB (16384)
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 9c0511119bad..0bc11a70090c 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -27,6 +27,9 @@ enum riscv_regset {
 #ifdef CONFIG_FPU
 	REGSET_F,
 #endif
+#ifdef CONFIG_VECTOR
+	REGSET_V,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -85,6 +88,64 @@ static int riscv_fpr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_VECTOR
+static int riscv_vr_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+
+	/*
+	 * Ensure the vector registers have been saved to the memory before
+	 * copying them to membuf.
+	 */
+	if (target == current)
+		vstate_save(current, task_pt_regs(current));
+
+	/* Copy vector header from vstate. */
+	membuf_write(&to, vstate, RISCV_V_STATE_DATAP);
+	membuf_zero(&to, sizeof(void *));
+#if __riscv_xlen == 32
+	membuf_zero(&to, sizeof(__u32));
+#endif
+
+	/* Copy all the vector registers from vstate. */
+	return membuf_write(&to, vstate->datap, riscv_vsize);
+}
+
+static int riscv_vr_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	int ret, size;
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+
+	/* Copy rest of the vstate except datap and __padding. */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate, 0,
+				 RISCV_V_STATE_DATAP);
+	if (unlikely(ret))
+		return ret;
+
+	/* Skip copy datap. */
+	size = sizeof(vstate->datap);
+	count -= size;
+	ubuf += size;
+#if __riscv_xlen == 32
+	/* Skip copy _padding. */
+	size = sizeof(vstate->__padding);
+	count -= size;
+	ubuf += size;
+#endif
+
+	/* Copy all the vector registers. */
+	pos = 0;
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate->datap,
+				 0, riscv_vsize);
+	return ret;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -104,6 +165,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = riscv_fpr_set,
 	},
 #endif
+#ifdef CONFIG_VECTOR
+	[REGSET_V] = {
+		.core_note_type = NT_RISCV_VECTOR,
+		.align = 16,
+		.n = (32 * RISCV_MAX_VLENB)/sizeof(__u32),
+		.size = sizeof(__u32),
+		.regset_get = riscv_vr_get,
+		.set = riscv_vr_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..60c5b873a8f6 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -432,6 +432,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_RISCV_VECTOR	0x900		/* RISC-V vector registers */
 
 /* Note types with note name "GNU" */
 #define NT_GNU_PROPERTY_TYPE_0	5
-- 
2.31.1

