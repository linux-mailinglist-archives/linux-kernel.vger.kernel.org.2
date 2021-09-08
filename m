Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785AF403E91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352574AbhIHRsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352557AbhIHRr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A5C0617AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:46:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t1so3416174pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=maGY6THRp1T65p0hgMojOL1EiKy9jGkK4UEsKBY1Ryw=;
        b=c8zWOcw6kVX4vOv8/1rp4/9fSdZBgQiJdf4qtqOwd+3sCAijC/eJmsx6k0GO8VPrwv
         5dQpLrvWlyGrx4YuMm5xwr9wmuwgXZb871YRIyZLYfmbVi3/NYoeUUmHwbZYFqLrjLwH
         aZ8iJTXXsuIS1/1fF2ZOLcWk2N71a8fC2cmhGPAqYjszycLG0lZCwp3J9sL4HADJtXr3
         f49YRXZkdN2tvsOxysdnKINjBKSwmSZTXs3VRhPCRsIJjoTmRWxRLMalOuYpFwyfXxQG
         0wKr8xV/eAJoO00sfqLPU9mCxzan5a08VxuNWDnDfEVF8AQfYoYakCt8ZEqKeijkz4CZ
         pJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=maGY6THRp1T65p0hgMojOL1EiKy9jGkK4UEsKBY1Ryw=;
        b=BGDGFMnWui1feO3zYxVeb0Zh30PrzxNQ3ATzPnwij77rlet7U2nZNyuZWqoy5NlgJ6
         BLdqU7LVgFlC4cisjvdeXYbZSdhAGp/baD4+qO4GmWQtsfdEg0skKSWUSXpcUc25DqqF
         W1mY7R7N3R6XUTeDHKNmutkHafxQGSsPgpOblBaIFGd/eo07yqYvHc+8TrmXfpFXamMf
         Da1DGhjnisXpipmIuSGOEEVgAM4WyzJuXTHOymp3iAreAfyIBX+zBK20w0ifG8OIEcbW
         4zAlvX22iEkQvwzINAvt1wDgf1RyazmP2Ohv3gRUC1RgTZG8KcOrOtDhIrIo62udpPGK
         7nbQ==
X-Gm-Message-State: AOAM533vKN9rEjJF7hYTj6BJ152uGN74pgVmggztotPAUacelN3oa4UP
        wKUhpJr91UU6+M6Zr04+jARSkQ==
X-Google-Smtp-Source: ABdhPJx39mwALbCWBwg4LOgrBWcFxVIgln0X2S9qnl1d/SXuIT4BnnFvMuO5riwDoLVVFbmz8kFakA==
X-Received: by 2002:aa7:86cb:0:b0:412:448c:89c8 with SMTP id h11-20020aa786cb000000b00412448c89c8mr4883991pfo.84.1631123168723;
        Wed, 08 Sep 2021 10:46:08 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:46:08 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 21/21] riscv: Turn has_vector into a static key if VECTOR=y
Date:   Thu,  9 Sep 2021 01:45:33 +0800
Message-Id: <56e2328d133045c79b420ecbcaf37cf9d0b2248c.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like fpu, we can use static key for has_vector.
The has_vector check sits at hot code path: switch_to(). Currently,
has_vector is a bool variable if VECTOR=y, switch_to() checks it each time,
we can optimize out this check by turning the has_vector into a static key.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/switch_to.h     | 10 +++++++---
 arch/riscv/kernel/cpufeature.c         |  4 ++--
 arch/riscv/kernel/kernel_mode_vector.c |  4 ++--
 arch/riscv/kernel/process.c            |  8 ++++----
 arch/riscv/kernel/signal.c             |  6 +++---
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index b48c9c974564..576204217e0f 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -71,7 +71,11 @@ static __always_inline bool has_fpu(void) { return false; }
 #endif
 
 #ifdef CONFIG_VECTOR
-extern bool has_vector;
+extern struct static_key_false cpu_hwcap_vector;
+static __always_inline bool has_vector(void)
+{
+	return static_branch_likely(&cpu_hwcap_vector);
+}
 extern unsigned long riscv_vsize;
 extern void __vstate_save(struct __riscv_v_state *save_to, void *datap);
 extern void __vstate_restore(struct __riscv_v_state *restore_from, void *datap);
@@ -120,7 +124,7 @@ static inline void __switch_to_vector(struct task_struct *prev,
 }
 
 #else
-#define has_vector false
+static __always_inline bool has_vector(void) { return false; }
 #define riscv_vsize (0)
 #define vstate_save(task, regs) do { } while (0)
 #define vstate_restore(task, regs) do { } while (0)
@@ -136,7 +140,7 @@ do {							\
 	struct task_struct *__next = (next);		\
 	if (has_fpu())					\
 		__switch_to_fpu(__prev, __next);	\
-	if (has_vector)					\
+	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index af984f875f60..0139ec20adce 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -23,7 +23,7 @@ __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
 #ifdef CONFIG_VECTOR
 #include <asm/vector.h>
-bool has_vector __read_mostly;
+__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_vector);
 unsigned long riscv_vsize __read_mostly;
 #endif
 
@@ -157,7 +157,7 @@ void __init riscv_fill_hwcap(void)
 
 #ifdef CONFIG_VECTOR
 	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
-		has_vector = true;
+		static_branch_enable(&cpu_hwcap_vector);
 		/* There are 32 vector registers with vlenb length. */
 		rvv_enable();
 		riscv_vsize = csr_read(CSR_VLENB) * 32;
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 0d990bd8b8dd..0d08954c30af 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -110,7 +110,7 @@ static void vector_flush_cpu_state(void)
  */
 void kernel_rvv_begin(void)
 {
-	if (WARN_ON(!has_vector))
+	if (WARN_ON(!has_vector()))
 		return;
 
 	WARN_ON(!may_use_vector());
@@ -140,7 +140,7 @@ EXPORT_SYMBOL(kernel_rvv_begin);
  */
 void kernel_rvv_end(void)
 {
-	if (WARN_ON(!has_vector))
+	if (WARN_ON(!has_vector()))
 		return;
 
 	/* Invalidate vector regs */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 05ff5f934e7e..62540815ba1c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -96,7 +96,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 		fstate_restore(current, regs);
 	}
 
-	if (has_vector) {
+	if (has_vector()) {
 		struct __riscv_v_state *vstate = &(current->thread.vstate);
 
 		/* Enable vector and allocate memory for vector registers. */
@@ -141,11 +141,11 @@ void flush_thread(void)
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	fstate_save(src, task_pt_regs(src));
-	if (has_vector)
+	if (has_vector())
 		/* To make sure every dirty vector context is saved. */
 		vstate_save(src, task_pt_regs(src));
 	*dst = *src;
-	if (has_vector) {
+	if (has_vector()) {
 		/* Copy vector context to the forked task from parent. */
 		if ((task_pt_regs(src)->status & SR_VS) != SR_VS_OFF) {
 			dst->thread.vstate.datap = kzalloc(riscv_vsize, GFP_KERNEL);
@@ -164,7 +164,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	/* Free the vector context of datap. */
-	if (has_vector)
+	if (has_vector())
 		kfree(tsk->thread.vstate.datap);
 }
 
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index d30a3b588156..6a19b4b7b206 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -192,7 +192,7 @@ static long restore_sigcontext(struct pt_regs *regs,
 				goto invalid;
 			goto done;
 		case RVV_MAGIC:
-			if (!has_vector)
+			if (!has_vector())
 				goto invalid;
 			if (size != rvv_sc_size)
 				goto invalid;
@@ -221,7 +221,7 @@ static size_t cal_rt_frame_size(void)
 
 	frame_size = sizeof(*frame);
 
-	if (has_vector)
+	if (has_vector())
 		total_context_size += rvv_sc_size;
 	/* Preserved a __riscv_ctx_hdr for END signal context header. */
 	total_context_size += sizeof(struct __riscv_ctx_hdr);
@@ -288,7 +288,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	if (has_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
 	/* Save the vector state. */
-	if (has_vector)
+	if (has_vector())
 		err |= save_v_state(regs, &sc_reserved_free_ptr);
 
 	/* Put END __riscv_ctx_hdr at the end. */
-- 
2.31.1

