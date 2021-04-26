Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C836C155
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhD0Izz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhD0Izx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:55:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 01:55:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t13so4463185pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OADY8rhy9wlX4GWPe0A2iQ0iiHfi3rxFGD9C3CUDGdo=;
        b=iO+kCnWE4DuF/PsrSO+M63zX9k6jotFhqAy9LpNiR+i0HII9pAUiEG4BvcQKr0uI/q
         XwjFymtdOOA0BB84p+mtd3Lx0dV1LMxgndKWGCirgXcN/u3HA03JriDhLXwdK+uOHAGv
         c2uum1AVuJ0zPtkAgJzUDWwB/q1HuFG/B195kgdzHz0QW8nd9XXUKIlXyGvh5N+9AIrd
         QYOx5MKrPYO8q3ZnM9Na616iHuTtfSb3IVpYJpaf97A5kUiah4JqvsSkvNZe3Uq4XNvS
         rZrG7hhFMj80SOgHY3qEEmPAVGKjGrBRhIWu9E/4NaN39J+N4PTcqUcysxzcBHoFrtc7
         BJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OADY8rhy9wlX4GWPe0A2iQ0iiHfi3rxFGD9C3CUDGdo=;
        b=r+OUEw2WhC0Fw82DsXWJXLI9ubFxcADyoilyL1YtvAAsJzuXbYBAEYKseQK5Uefz3x
         9iNiPFlAe6wAVsdFhKlxlrn9gY9XfoCYpSlSxgYIsUstTYnzMVvCAy6anTvtKI8BUrma
         P5EdGykZyA5qBsUNFArD1vAt3UDeIt4jQDO09YSDAYJEVnMh+FAo84HpQTDR3YwaN9vx
         /QXwO+ThwuLbU00uE7iEK4t9ENdLoLtK+4Akhk7IsrC4e8Zl1tMd4v9uz/nZdqCZ6dcV
         Pcn8Qa2h7GoPhkEOdWnwtPN/Jv66JdlWN9NOez3D0v/aHymcMqYQSsol2aBLCrVmc9A/
         HQ8w==
X-Gm-Message-State: AOAM533UuDvhjM9kUD3Tpzrj8wa6d5qeaVpP38cyaXPOzcfivCSH5naQ
        Lw9Q43/FQXWLvc70VGYbAzSJXkm3K7Q=
X-Google-Smtp-Source: ABdhPJwpYvj8p9GOZuEwoyVv6HO4sXDL05DaWEjIzjbZv5fjxbJY+zOzPTTVbKRCp+ayugYNyUEPug==
X-Received: by 2002:a17:90b:b05:: with SMTP id bf5mr6216041pjb.123.1619513707739;
        Tue, 27 Apr 2021 01:55:07 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id l10sm1945784pfc.125.2021.04.27.01.55.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Apr 2021 01:55:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Subject: [PATCH 2/4] x86/entry: Use asm_noist_exc_nmi() for NMI in early booting stage
Date:   Tue, 27 Apr 2021 07:09:47 +0800
Message-Id: <20210426230949.3561-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210426230949.3561-1-jiangshanlai@gmail.com>
References: <20210426230949.3561-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

While the other entries for the exceptions which use Interrupt stacks can
be also used on the kernel stack, asm_exc_nmi() can not be used on the
kernel stack for it relies on the RSP-located "NMI executing" variable
which expects to on a fixed location in the NMI IST stack.  When it is
unexpectedly called from the kernel stack, the RSP-located "NMI executing"
variable is also on the kernel stack and is "uninitialized" and can cause
the NMI entry to run in the wrong way.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 2 --
 arch/x86/kernel/idt.c           | 8 +++++++-
 arch/x86/kernel/nmi.c           | 7 ++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 5b11d2ddbb5c..0831c0da5957 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -589,9 +589,7 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	xenpv_exc_machine_check);
 
 /* NMI */
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
-#ifdef CONFIG_XEN_PV
 DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	noist_exc_nmi);
-#endif
 
 /* #DB */
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d552f177eca0..c75409633f16 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -71,10 +71,16 @@ static const __initconst struct idt_data early_idts[] = {
  * cpu_init() is invoked. Interrupt stacks cannot be used at that point and
  * the traps which use them are reinitialized with IST after cpu_init() has
  * set up TSS.
+ *
+ * While the other entries for the exceptions which use Interrupt stacks can
+ * be also used on the kernel stack, asm_exc_nmi() can not be used on the
+ * kernel stack for it relies on the RSP-located "NMI executing" variable
+ * which expects to on a fixed location in the NMI IST stack.  For early
+ * booting stage, asm_noist_exc_nmi() is used for NMI.
  */
 static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
-	INTG(X86_TRAP_NMI,		asm_exc_nmi),
+	INTG(X86_TRAP_NMI,		asm_noist_exc_nmi),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 2b907a76d0a1..2fb1fd59d714 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -524,13 +524,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 		mds_user_clear_cpu_buffers();
 }
 
-#ifdef CONFIG_XEN_PV
 DEFINE_IDTENTRY_RAW(noist_exc_nmi)
 {
-	/* On Xen PV, NMI doesn't use IST.  The C part is the same as native. */
+	/*
+	 * On Xen PV and early booting stage, NMI doesn't use IST.
+	 * The C part is the same as native.
+	 */
 	exc_nmi(regs);
 }
-#endif
 
 void stop_nmi(void)
 {
-- 
2.19.1.6.gb485710b

