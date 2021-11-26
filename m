Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ABB45EB41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376767AbhKZK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhKZKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:24:12 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1697C061758
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 8so8483786pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/JsKbfMes+8HN/WC8BxQrxJb7eO4f1vtnbbvoObfIw=;
        b=qAEXRhJCQualuXUI/E9TTZKF+vyX2KzxEvmGfinCNMQN3bZc4v5qw3+auBqPTn+kKu
         M+3yBhQ9LskJvs7Q/3TRBzenI80zV6/EYs6sk1uLx9XviHrar+L9NvzCIJqtwm2S2GrH
         lWvF7UeRX4zY/2QoY7wT0yR/2sl3S08YxRA7654v7s6infsNz74W//YjCQgEHUuKhMrZ
         2m17i10/Sx8RwyaFqN4DhtC4TweDXrlOyLXpYhFpPgupCUjLoWkzYGJm9z6TddPtex55
         j44Gtoy91BW19/Bq4WUmCnpxueDztG3aTN7yG1DtiCT6i5jKAXHRemC2Bl7j2sJDrjrW
         rJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/JsKbfMes+8HN/WC8BxQrxJb7eO4f1vtnbbvoObfIw=;
        b=BIZ3cY3FbMl/TFEZplGH8RYYJe8amWq/w7ceGiKIUZNKj+pRd2L0757e0nYv3G8kH9
         6zg3VsveULAE1gY6tRa/7G00RmWxqBVwN8N07sdZBIW9Z32VPPV+XVuA1qR8hkH4hrLB
         nXndhu8ohrVGlrRXVrG2nrLpXLNiGM0hvSwu8Gskh/hG8o9TFrziR0Zz//0bczJGzoNe
         jDy/okSVKF177k3OacbtnJAyUyYpjXElCvWedW6198YMfDsFiQRZufWlghjMVnSVH5lo
         zc9AuDuIxAkxYwwu8De3bLgy0ODIt0k8QIx+avmtMHDvXUCtXhnoEU16OLHYiRAZ8aS7
         iv8A==
X-Gm-Message-State: AOAM532dLt+5Mjzts/6BPyrgaWflj1+soHiiXazcffxP2XPqKvYVRA7j
        EOFupVZL+oXOOnL2Taox0eXb0/ZF/bM=
X-Google-Smtp-Source: ABdhPJwQkD5yFxnX+taigMIodM5mVwgcHezaHYIaCCLRC2t7bnJOlp6G7/Oyuib5tURhRHES5mL3XQ==
X-Received: by 2002:a05:6a00:1412:b0:4a7:ec46:29d1 with SMTP id l18-20020a056a00141200b004a7ec4629d1mr12919164pfu.16.1637921533272;
        Fri, 26 Nov 2021 02:12:13 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id j2sm3870184pgl.73.2021.11.26.02.12.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:12 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, Peter Anvin <hpa@zytor.com>,
        xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH V6 03/49] x86/xen: Add xenpv_restore_regs_and_return_to_usermode()
Date:   Fri, 26 Nov 2021 18:11:23 +0800
Message-Id: <20211126101209.8613-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

While in the native case, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is the
trampoline stack.  But XEN pv doesn't use trampoline stack, so
PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is also the kernel stack.  Hence source
and destination stacks are identical in that case, which means reusing
swapgs_restore_regs_and_return_to_usermode() in XEN pv would cause %rsp
to move up to the top of the kernel stack and leave the IRET frame below
%rsp, which is dangerous to be corrupted if #NMI / #MC hit as either of
these events occurring in the middle of the stack pushing would clobber
data on the (original) stack.

And, when XEN pv, swapgs_restore_regs_and_return_to_usermode() pushing
the IRET frame on to the original address is useless and error-prone
when there is any future attempt to modify the code.

Fixes: 7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Anvin <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S |  4 ++++
 arch/x86/xen/xen-asm.S    | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4967edded48d..68e697acefac 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -574,6 +574,10 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	ud2
 1:
 #endif
+#ifdef CONFIG_XEN_PV
+	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+#endif
+
 	POP_REGS pop_rdi=0
 
 	/*
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 220dd9678494..444d824775f6 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <../entry/calling.h>
 
 .pushsection .noinstr.text, "ax"
 /*
@@ -192,6 +193,25 @@ SYM_CODE_START(xen_iret)
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
 
+/*
+ * XEN pv doesn't use trampoline stack, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is
+ * also the kernel stack.  Reusing swapgs_restore_regs_and_return_to_usermode()
+ * in XEN pv would cause %rsp to move up to the top of the kernel stack and
+ * leave the IRET frame below %rsp, which is dangerous to be corrupted if #NMI
+ * interrupts. And swapgs_restore_regs_and_return_to_usermode() pushing the IRET
+ * frame at the same address is useless.
+ */
+SYM_CODE_START(xenpv_restore_regs_and_return_to_usermode)
+	UNWIND_HINT_REGS
+	POP_REGS
+
+	/* stackleak_erase() can work safely on the kernel stack. */
+	STACKLEAK_ERASE_NOCLOBBER
+
+	addq	$8, %rsp	/* skip regs->orig_ax */
+	jmp xen_iret
+SYM_CODE_END(xenpv_restore_regs_and_return_to_usermode)
+
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
  * means we have:
-- 
2.19.1.6.gb485710b

