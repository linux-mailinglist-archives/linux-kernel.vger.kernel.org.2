Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDD454CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbhKQSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbhKQSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:18:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC988C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:15:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b40so12732297lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RB6dDWbUUTqxz+0YO8FW5ID4OCgtq+gbB1dDAPy8Kpo=;
        b=PNYtwSBjF8itSP4SbR6F3vN3OiD6kSvP/zg5HCuav7UBlF7QPWozN1boh3OZO3KPbv
         ySHBQkAdyS1J4wvhBAzwORtnDCqMza7ceyIHiVdQciKflN26AQsbOeMS4hZ1EO+4n8Dg
         tQMEcFGzOEPD3lKJXCuK2f3N1XkYDtlnhUaSZkpEcdjv5Gb5lHQm5FkXiLYM6BrjqYJj
         DeEq18Xjclio1+hCSUJUvKilyNqAtTLeSFEtNuYCVEOty5y9ob8itUN4JSZiLorEMumL
         CsFCZDoJhb2O+LI9rBYJ5EDlmbJmxQoVuE9LykoX6FXekmGdgQZCp05EuBHEiQUkcSoh
         /rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RB6dDWbUUTqxz+0YO8FW5ID4OCgtq+gbB1dDAPy8Kpo=;
        b=aoKmmhV4HaiMtUIhsuTUFBxDP2ykJlnu12Dha+hmQ+PbKWYB0Kj6M/Z8XqUhDxj7X1
         MSNzsHdg/prYTD3mqhQaI5XxVmqUFbLaQjh0oxqal1cnNVPmNpckLsB+HnCn0WRh+3ti
         PSh4AoUqb1/3ODm1DFj9GsTxhO3iyZcrG5YSczfY5vysXMEBQXV8rYFXB0hZYJvrgVED
         +WEOfE5O2z9FQpOyL1EjN01T9N9kmmaNeowSddw7ZU4+Y9Fbm/2ukjv/Wy/vaOTTHO1e
         SX5pYG8nZgp20rH4p121VyH8lm0/leu6M1+rqG9GxMKvxUm5wrX0CiYDqNq4PcsJGHaQ
         /dEA==
X-Gm-Message-State: AOAM530PFBm8RgiB82Cz2lPXp9w5tGjh/+rGi42UrpWkQVxFpT/OWjyo
        urRUCwAQo9e+plp81OuQRmhGJg==
X-Google-Smtp-Source: ABdhPJyieRgvXw4bFq6SVnJWpkoUl0lQ/4qFmsSv+OC46BmV/Uctn5c3ayGtPAjGCZAFaGWkklsxPg==
X-Received: by 2002:a2e:b4a6:: with SMTP id q6mr9661413ljm.7.1637172905076;
        Wed, 17 Nov 2021 10:15:05 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 3sm51917lfr.77.2021.11.17.10.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:15:04 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id E829C103139; Wed, 17 Nov 2021 21:15:09 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
Date:   Wed, 17 Nov 2021 21:14:39 +0300
Message-Id: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX is going to use CONFIG_PARAVIRT_XXL, but kernel fails to compile if
XEN_PV is not enabled:

	ld.lld: error: undefined symbol: xen_iret

It happens because INTERRUPT_RETURN defined to use xen_iret if
CONFIG_PARAVIRT_XXL enabled regardless of CONFIG_XEN_PV.

The issue is not visible in the current kernel because CONFIG_XEN_PV is
the only user of CONFIG_PARAVIRT_XXL and there's no way to enable them
separately.

Rework code to define INTERRUPT_RETURN based on CONFIG_XEN_PV, not
CONFIG_PARAVIRT_XXL.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Deep Shah <sdeep@vmware.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>
---
 arch/x86/include/asm/irqflags.h | 7 +++++--
 arch/x86/include/asm/paravirt.h | 5 -----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index b794b6da3214..3b8ddcb7be76 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -118,8 +118,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #define SAVE_FLAGS		pushfq; popq %rax
 #endif
 
-#define INTERRUPT_RETURN	jmp native_iret
-
 #endif
 
 #endif /* __ASSEMBLY__ */
@@ -147,8 +145,13 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
 #define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
+#define INTERRUPT_RETURN						\
+	ANNOTATE_RETPOLINE_SAFE;					\
+	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
+		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 #else
 #define SWAPGS	swapgs
+#define INTERRUPT_RETURN	jmp native_iret
 #endif
 #endif
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 8e04268d7c10..865f78635af1 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -745,11 +745,6 @@ extern void default_banner(void);
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
-#define INTERRUPT_RETURN						\
-	ANNOTATE_RETPOLINE_SAFE;					\
-	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
-		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
-
 #ifdef CONFIG_DEBUG_ENTRY
 .macro PARA_IRQ_save_fl
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
-- 
2.32.0

