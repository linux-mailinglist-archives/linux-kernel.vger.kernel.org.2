Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9C3E537C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhHJG1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbhHJG0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:26:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BEDC06179A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:26:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m18so16137756ljo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWJUZP0dbskrNbtaJwK/Tbp+8mAAWASI6DAzHFq/lFg=;
        b=aVjEJN6SQwrYycsPycBz2KNKkeTGZwuzwnHT1R1uplQFzzkx3iDN7NBneR19HXIwuF
         NXIv8lWfs6zpG/K7Sux3uy9JSAPf3V7yVMRaZZZLrzrEHPvrJapDmNr3vVx2FOgj82De
         rZe/gFeTDL/bZ2kqUJ067TKudI5KVLZJz9gKXoDS9TYMqIjIqWXgsmguHUYEsfndZeJK
         JvbzHkO0CUCxjrS+0iXhg6+S5oFl8YWCh1zURsxV+nAHwhlfDyYkwLd/ZkilLCWXkunw
         6NATuUgbbguSRL1DrDkg0ne2oRm459dbrn1hVjiOP3qDLvzeCpJq6Y1/2EQqTbh9iGtk
         ySDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWJUZP0dbskrNbtaJwK/Tbp+8mAAWASI6DAzHFq/lFg=;
        b=AjqkBDqBq9bGmCvLQORT4CDX7/Pz6b761/J7KEosJUL/x3QKwVD1n/MXldSXdcamBP
         vOZAwimnXJN/1aWO7i3uK3SH88wWBfEMA5LqFJl2+q2xMMormNdpUT86PR8IKeC31Bya
         hCqlAc0FF+916Ck0eY4JyDSaEdicsDeofD8LrdMi+hwmOsRIYDWepSNY6a2+b9kFoH20
         b6fOupRQ9TBemMLjFWgIHcXuryKc9mLYfFGJnmAVhnE07MnXYnWHXD97B4twokSbjPbi
         b10TUnnjoaVzF4D9zTABUfOCXsQE0ESVOewOQqVFVQAjSN6tuCNs6e9XPtKz/KAJg1PT
         MskQ==
X-Gm-Message-State: AOAM532KfccYIuIJERnVV6GrzSsI7mBr+SkST5k+Hh8Xua9a4QXNPEJO
        qOKXppC8q6uF3RLWuNY23hRiAg==
X-Google-Smtp-Source: ABdhPJxFXIZNu8BRH3d+/+nzJFBbH2eGlX5f7qfMtPHplWcg+ebB0Wn91QuSk/T4ncwIyHb4y7E2Tw==
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr18928460ljn.360.1628576786905;
        Mon, 09 Aug 2021 23:26:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u3sm1600860lfu.151.2021.08.09.23.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:26:26 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id B7058102BDC; Tue, 10 Aug 2021 09:26:34 +0300 (+03)
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 5/5] x86/tdx: Unaccepted memory support
Date:   Tue, 10 Aug 2021 09:26:26 +0300
Message-Id: <20210810062626.1012-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All preparation is complete. Hookup TDX-specific code to accept memory.

There are two tdg_accept_memory() implementations: one in main kernel
and one in the decompresser.

The implementation in core kernel uses tdx_hcall_gpa_intent(). The
helper is not available in the decompresser, self-contained
implementation added there instead.

Note that tdx_hcall_gpa_intent() is going to be more complex once we
teach it to accept in 1G and 2M chunks.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                             |  1 +
 arch/x86/boot/compressed/tdx.c               | 29 ++++++++++++++++++++
 arch/x86/boot/compressed/unaccepted_memory.c |  5 +++-
 arch/x86/include/asm/tdx.h                   |  2 ++
 arch/x86/kernel/tdx.c                        |  8 ++++++
 arch/x86/mm/unaccepted_memory.c              |  6 +++-
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c0261cc72449..5b1b3dc84c7d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -874,6 +874,7 @@ config INTEL_TDX_GUEST
 	select ARCH_HAS_PROTECTED_GUEST
 	select X86_MEM_ENCRYPT_COMMON
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select UNACCEPTED_MEMORY
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtensions. TDX is a new Intel
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 88ed6465405b..6f13bdaf327f 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -5,6 +5,10 @@
 
 #include "../cpuflags.h"
 #include "../string.h"
+#include "error.h"
+
+#include <asm/page_types.h>
+#include <asm/tdx.h>
 
 #define TDX_CPUID_LEAF_ID                       0x21
 
@@ -32,3 +36,28 @@ bool early_is_tdx_guest(void)
 
 	return !!tdx_guest;
 }
+
+#define TDACCEPTPAGE		6
+#define TDVMCALL_MAP_GPA	0x10001
+
+void tdg_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct tdx_hypercall_output outl = {0};
+	int i;
+
+	if (__tdx_hypercall(TDX_HYPERCALL_STANDARD, TDVMCALL_MAP_GPA,
+			    start, end, 0, 0, &outl)) {
+		error("Cannot accept memory: MapGPA failed\n");
+	}
+
+	/*
+	 * For shared->private conversion, accept the page using TDACCEPTPAGE
+	 * TDX module call.
+	 */
+	for (i = 0; i < (end - start) / PAGE_SIZE; i++) {
+		if (__tdx_module_call(TDACCEPTPAGE, start + i * PAGE_SIZE,
+				      0, 0, 0, NULL)) {
+			error("Cannot accept memory: page accept failed\n");
+		}
+	}
+}
diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
index 818d32169eef..146a3a6968a8 100644
--- a/arch/x86/boot/compressed/unaccepted_memory.c
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -4,7 +4,10 @@
 static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
-	error("Cannot accept memory");
+	if (early_is_tdx_guest())
+		tdg_accept_memory(start, end);
+	else
+		error("Cannot accept memory");
 }
 
 void mark_unaccepted(struct boot_params *params, u64 start, u64 num)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index af6e4cd8078d..f74b6cfde205 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -97,6 +97,8 @@ extern phys_addr_t tdg_shared_mask(void);
 extern int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
 				enum tdx_map_type map_type);
 
+extern void tdg_accept_memory(phys_addr_t start, phys_addr_t end);
+
 int tdx_mcall_tdreport(u64 data, u64 reportdata);
 
 int tdx_mcall_rtmr_extend(u64 data, u64 rmtr);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index dc6d9441f3be..75f3804f86da 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -372,6 +372,14 @@ int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
 	return 0;
 }
 
+void tdg_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	if (tdx_hcall_gpa_intent(start, (end - start) / PAGE_SIZE,
+				 TDX_MAP_PRIVATE)) {
+		panic("Accepting memory failed\n");
+	}
+}
+
 static __cpuidle void tdg_halt(void)
 {
 	u64 ret;
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index e11933f62ead..19e0309e128b 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -5,6 +5,7 @@
 
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/tdx.h>
 #include <asm/unaccepted_memory.h>
 
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
@@ -21,7 +22,10 @@ static void __accept_memory(phys_addr_t start, phys_addr_t end)
 				   start / PMD_SIZE,
 				   DIV_ROUND_UP(end, PMD_SIZE)) {
 		/* Platform-specific memory-acceptance call goes here */
-		panic("Cannot accept memory");
+		if (prot_guest_has(PATTR_GUEST_TDX))
+			tdg_accept_memory(rs * PMD_SIZE, re * PMD_SIZE);
+		else
+			panic("Cannot accept memory");
 		bitmap_clear(unaccepted_memory, rs, re - rs);
 	}
 }
-- 
2.31.1

