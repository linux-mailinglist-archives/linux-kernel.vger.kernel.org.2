Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E045932BFB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580081AbhCCSdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348084AbhCCRHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/vE76ypT+y/+5pQJJOf6TQekKJTWzPC+T2W1EkSpYk=;
        b=N9NEdO1sjHHzMW3cNn1PDcwn0pnzN5uQ5fcTEOqULMX5nYsWDlAqLm7oSNzdQdpC1Zt3R3
        DXcPy6Fh8JNbjQ4K8s/lQce45noB7KIM69yPxZ7FVaVBNJGD6zREFlBFSzNcdcoVGGn/Gm
        60NST/Srx/8L0SxW5MwEXnvthcWavPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-VKkEZuR6NDSsi1sP3jID3A-1; Wed, 03 Mar 2021 12:05:48 -0500
X-MC-Unique: VKkEZuR6NDSsi1sP3jID3A-1
Received: by mail-wm1-f70.google.com with SMTP id s192so3267583wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/vE76ypT+y/+5pQJJOf6TQekKJTWzPC+T2W1EkSpYk=;
        b=hswd1fO3EpRWCO8Y/ZPm6jxkoX0aSVEqSyy+kEqR3sTkaBmmD71AnxU5e0Jd7nS59q
         9mFXo//KhBuLC8Gp8/M4IwaAMs6o6fcsT9GM4MYtMFE3iFfOnyBdB76ITLQM4FtbqV/c
         nTGSEIYGq3qTz0iXl48/xvp3FB437+/v80Z7TAYbgGi1ixrZGXI/QEKUqNtTfgjmrqV3
         NmwvmesJqlGs3Pqxc3TBQ2IjypRHYj9JT1WzlcjDIBPT60hKiBNHvKRGKeWIQObtvyC7
         m2M1LPxJsSUKzWdbG0jIUpn/2pbSxMblY6XohYsTYbSdBBSJhQLngXikrDXQfRyuN5Lf
         oF/w==
X-Gm-Message-State: AOAM530aSXrePLDw0UkIUNeXHrKZG2A+uyfNTP4yWQEySI8Zn7osv81P
        QCvzng/FCffG/elwqRJzBZAFCqJZvP86R9533bQvvx64Wd9nrMnwetTGXnqN0HDcTyBLsb5O7ik
        LuZ/ks53J2S86OxyJJVW7qvBgIrfYxn0ah+Dod+zEeluEoK3HwjmLya31lWmyqaUfGO/D9XtrPO
        0x
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr27858277wra.47.1614791145784;
        Wed, 03 Mar 2021 09:05:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGBNOH4F57UqVuCyTJBRKoSzkjw7DOF9KE+Q+4TH+LKMycY/5xU/FcBzcYGoS4PdpYoDqh9Q==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr27858129wra.47.1614791143481;
        Wed, 03 Mar 2021 09:05:43 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:05:43 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 2/8] arm64: Move aarch32 condition check functions
Date:   Wed,  3 Mar 2021 18:05:30 +0100
Message-Id: <20210303170536.1838032-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions to check condition flags for aarch32 execution is only
used to emulate aarch32 instructions. Move them from the instruction
encoding/decoding code to the trap handling files.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/insn.h            |  2 -
 arch/arm64/include/asm/probes.h          |  2 +-
 arch/arm64/include/asm/traps.h           |  3 +
 arch/arm64/kernel/insn.c                 | 98 -----------------------
 arch/arm64/kernel/probes/simulate-insn.c |  1 +
 arch/arm64/kernel/traps.c                | 99 +++++++++++++++++++++++-
 6 files changed, 103 insertions(+), 102 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 7437b7e7e7eb..14aa2f3aebfe 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -499,8 +499,6 @@ u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
 u32 aarch32_insn_mcr_extract_opc2(u32 insn);
 u32 aarch32_insn_mcr_extract_crm(u32 insn);
 
-typedef bool (pstate_check_t)(unsigned long);
-extern pstate_check_t * const aarch32_opcode_cond_checks[16];
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 006946745352..462ca74a94ac 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -7,7 +7,7 @@
 #ifndef _ARM_PROBES_H
 #define _ARM_PROBES_H
 
-#include <asm/insn.h>
+#include <asm/traps.h>
 
 typedef u32 probe_opcode_t;
 typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 54f32a0675df..6f33ff55a9f0 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -100,4 +100,7 @@ static inline u32 arm64_ras_serror_get_severity(u32 esr)
 
 bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr);
 void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr);
+
+typedef bool (pstate_check_t)(unsigned long);
+extern pstate_check_t * const aarch32_opcode_cond_checks[16];
 #endif
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 952e7d6fe60e..6ff8826ae7ea 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -1289,104 +1289,6 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn)
 	return insn & CRM_MASK;
 }
 
-static bool __kprobes __check_eq(unsigned long pstate)
-{
-	return (pstate & PSR_Z_BIT) != 0;
-}
-
-static bool __kprobes __check_ne(unsigned long pstate)
-{
-	return (pstate & PSR_Z_BIT) == 0;
-}
-
-static bool __kprobes __check_cs(unsigned long pstate)
-{
-	return (pstate & PSR_C_BIT) != 0;
-}
-
-static bool __kprobes __check_cc(unsigned long pstate)
-{
-	return (pstate & PSR_C_BIT) == 0;
-}
-
-static bool __kprobes __check_mi(unsigned long pstate)
-{
-	return (pstate & PSR_N_BIT) != 0;
-}
-
-static bool __kprobes __check_pl(unsigned long pstate)
-{
-	return (pstate & PSR_N_BIT) == 0;
-}
-
-static bool __kprobes __check_vs(unsigned long pstate)
-{
-	return (pstate & PSR_V_BIT) != 0;
-}
-
-static bool __kprobes __check_vc(unsigned long pstate)
-{
-	return (pstate & PSR_V_BIT) == 0;
-}
-
-static bool __kprobes __check_hi(unsigned long pstate)
-{
-	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
-	return (pstate & PSR_C_BIT) != 0;
-}
-
-static bool __kprobes __check_ls(unsigned long pstate)
-{
-	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
-	return (pstate & PSR_C_BIT) == 0;
-}
-
-static bool __kprobes __check_ge(unsigned long pstate)
-{
-	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
-	return (pstate & PSR_N_BIT) == 0;
-}
-
-static bool __kprobes __check_lt(unsigned long pstate)
-{
-	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
-	return (pstate & PSR_N_BIT) != 0;
-}
-
-static bool __kprobes __check_gt(unsigned long pstate)
-{
-	/*PSR_N_BIT ^= PSR_V_BIT */
-	unsigned long temp = pstate ^ (pstate << 3);
-
-	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
-	return (temp & PSR_N_BIT) == 0;
-}
-
-static bool __kprobes __check_le(unsigned long pstate)
-{
-	/*PSR_N_BIT ^= PSR_V_BIT */
-	unsigned long temp = pstate ^ (pstate << 3);
-
-	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
-	return (temp & PSR_N_BIT) != 0;
-}
-
-static bool __kprobes __check_al(unsigned long pstate)
-{
-	return true;
-}
-
-/*
- * Note that the ARMv8 ARM calls condition code 0b1111 "nv", but states that
- * it behaves identically to 0b1110 ("al").
- */
-pstate_check_t * const aarch32_opcode_cond_checks[16] = {
-	__check_eq, __check_ne, __check_cs, __check_cc,
-	__check_mi, __check_pl, __check_vs, __check_vc,
-	__check_hi, __check_ls, __check_ge, __check_lt,
-	__check_gt, __check_le, __check_al, __check_al
-};
-
 static bool range_of_ones(u64 val)
 {
 	/* Doesn't handle full ones or full zeroes */
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 25f67ec59635..22d0b3252476 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -10,6 +10,7 @@
 #include <linux/kprobes.h>
 
 #include <asm/ptrace.h>
+#include <asm/traps.h>
 
 #include "simulate-insn.h"
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d7057e307bca..48ff6fb888e0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -36,7 +36,6 @@
 #include <asm/esr.h>
 #include <asm/exception.h>
 #include <asm/extable.h>
-#include <asm/insn.h>
 #include <asm/kprobes.h>
 #include <asm/patching.h>
 #include <asm/traps.h>
@@ -46,6 +45,104 @@
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
 
+static bool __kprobes __check_eq(unsigned long pstate)
+{
+	return (pstate & PSR_Z_BIT) != 0;
+}
+
+static bool __kprobes __check_ne(unsigned long pstate)
+{
+	return (pstate & PSR_Z_BIT) == 0;
+}
+
+static bool __kprobes __check_cs(unsigned long pstate)
+{
+	return (pstate & PSR_C_BIT) != 0;
+}
+
+static bool __kprobes __check_cc(unsigned long pstate)
+{
+	return (pstate & PSR_C_BIT) == 0;
+}
+
+static bool __kprobes __check_mi(unsigned long pstate)
+{
+	return (pstate & PSR_N_BIT) != 0;
+}
+
+static bool __kprobes __check_pl(unsigned long pstate)
+{
+	return (pstate & PSR_N_BIT) == 0;
+}
+
+static bool __kprobes __check_vs(unsigned long pstate)
+{
+	return (pstate & PSR_V_BIT) != 0;
+}
+
+static bool __kprobes __check_vc(unsigned long pstate)
+{
+	return (pstate & PSR_V_BIT) == 0;
+}
+
+static bool __kprobes __check_hi(unsigned long pstate)
+{
+	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
+	return (pstate & PSR_C_BIT) != 0;
+}
+
+static bool __kprobes __check_ls(unsigned long pstate)
+{
+	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
+	return (pstate & PSR_C_BIT) == 0;
+}
+
+static bool __kprobes __check_ge(unsigned long pstate)
+{
+	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
+	return (pstate & PSR_N_BIT) == 0;
+}
+
+static bool __kprobes __check_lt(unsigned long pstate)
+{
+	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
+	return (pstate & PSR_N_BIT) != 0;
+}
+
+static bool __kprobes __check_gt(unsigned long pstate)
+{
+	/*PSR_N_BIT ^= PSR_V_BIT */
+	unsigned long temp = pstate ^ (pstate << 3);
+
+	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
+	return (temp & PSR_N_BIT) == 0;
+}
+
+static bool __kprobes __check_le(unsigned long pstate)
+{
+	/*PSR_N_BIT ^= PSR_V_BIT */
+	unsigned long temp = pstate ^ (pstate << 3);
+
+	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
+	return (temp & PSR_N_BIT) != 0;
+}
+
+static bool __kprobes __check_al(unsigned long pstate)
+{
+	return true;
+}
+
+/*
+ * Note that the ARMv8 ARM calls condition code 0b1111 "nv", but states that
+ * it behaves identically to 0b1110 ("al").
+ */
+pstate_check_t * const aarch32_opcode_cond_checks[16] = {
+	__check_eq, __check_ne, __check_cs, __check_cc,
+	__check_mi, __check_pl, __check_vs, __check_vc,
+	__check_hi, __check_ls, __check_ge, __check_lt,
+	__check_gt, __check_le, __check_al, __check_al
+};
+
 static const char *handler[] = {
 	"Synchronous Abort",
 	"IRQ",
-- 
2.25.4

