Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21076367699
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbhDVA5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbhDVA5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:57:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25CC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:56:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 137-20020a250d8f0000b02904e7bf943359so17990586ybn.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nQ/zpK/kz603934NoaeU4Gk/eDpKeLkLBX1Q9YclUPA=;
        b=eP0O7z+LQB2aToODGjmklTU4/ZEqYkoE5cnDIg2lo7Q+vpJ9bR12OhCB4CdXqay1zU
         77yav77ko4Ygni13AIZ16v+K0y/18AcUBfAuRlm+kSdBvwI6G6MIqX5wJvPWr1vjpjOT
         RY8cp2nkuurYbZjYKn1mnbrj8FVF5olWJPGwy2dCCUeMAY5P/AC+h6GTyXluGrb70v6R
         x49xRasTZeVZhhIpM4E8MDgPWfehTjBizf1sIKQb41Tlqee3lYIoFIBzemfr1TeLQ35q
         4XTfr+dmAHno0tDXFgncMkcFOZrVGxqV/7CWSSPqfwqqyUFZzQgP2L4eIhcLZJxQbFBz
         8X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nQ/zpK/kz603934NoaeU4Gk/eDpKeLkLBX1Q9YclUPA=;
        b=dXVQZO6caJH9rvvdV8HZu4vBSaP+qZr9evlEAq6P8SoW513X8AbdKxZSLJyHNkaOs0
         hHfps3AFZJxVHZEqz61ur20PF4pWRDQ75rrM5rz6iHMnOhjpFEoeCozR6MH8R5RTRrj7
         5GNTLBeQ4cEyTLBMJrI+ss33XD95JMskUltSsSi4lBbkCmP5XLrEeg+jBkCKa80BKiUI
         X1yktgoSfxVmKKPJJvjbNiHOgwwromdfJGa1a98993vLzaQ+gOoBNxdB9kKBtNDADPxn
         Qq4mG0aFPZsjtfSVkx7ZAJyeVvvpIn44mNoIeFIMGruUtnpWb0X1UMoeT51denkizfHU
         gPcQ==
X-Gm-Message-State: AOAM531pUh6hJbV6l8IZtfSEF5euXEw2i04S1D3j0yDPUfc/JOR43gjj
        R7PcBhQavlpd7Tnno8t6N4K5agVJ4nhDBw==
X-Google-Smtp-Source: ABdhPJwRNsexrlF6Et7Tudrdqp8qhO7el0jKsQTvh4PiuQzg//HU3EEJk0WGdQkuBV0VKD9bmeLOfOp/jgfbcg==
X-Received: from ricarkol2.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a25:b9c1:: with SMTP id
 y1mr979521ybj.321.1619053001722; Wed, 21 Apr 2021 17:56:41 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:56:23 -0700
In-Reply-To: <20210422005626.564163-1-ricarkol@google.com>
Message-Id: <20210422005626.564163-3-ricarkol@google.com>
Mime-Version: 1.0
References: <20210422005626.564163-1-ricarkol@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 2/5] x86/cpu: Expose CPUID regs, leaf and index definitions to tools
From:   Ricardo Koller <ricarkol@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move cpuid_regs, cpuid_regs_idx, and cpuid_leafs out of their
'#ifdef __KERNEL__' guards so that KVM selftests can reuse the
definitions in future patches.  Move cpuid_regs and cpuid_regs_idx from
processor.h to cpufeature.h to avoid blasting processor.h with several
'#ifdefs'.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/events/intel/pt.c        |  1 +
 arch/x86/include/asm/cpufeature.h | 23 ++++++++++++++++++-----
 arch/x86/include/asm/processor.h  | 11 -----------
 arch/x86/kernel/cpu/scattered.c   |  2 +-
 arch/x86/kernel/cpuid.c           |  2 +-
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e94af4a54d0d..882b1478556e 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -21,6 +21,7 @@
 #include <asm/io.h>
 #include <asm/intel_pt.h>
 #include <asm/intel-family.h>
+#include <asm/cpufeature.h>
 
 #include "../perf_event.h"
 #include "pt.h"
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1728d4ce5730..22458ab5aac4 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -2,12 +2,19 @@
 #ifndef _ASM_X86_CPUFEATURE_H
 #define _ASM_X86_CPUFEATURE_H
 
-#include <asm/processor.h>
+#include <linux/types.h>
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#ifndef __ASSEMBLY__
+struct cpuid_regs {
+	u32 eax, ebx, ecx, edx;
+};
 
-#include <asm/asm.h>
-#include <linux/bitops.h>
+enum cpuid_regs_idx {
+	CPUID_EAX = 0,
+	CPUID_EBX,
+	CPUID_ECX,
+	CPUID_EDX,
+};
 
 enum cpuid_leafs
 {
@@ -32,6 +39,11 @@ enum cpuid_leafs
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 };
+#ifdef __KERNEL__
+
+#include <asm/processor.h>
+#include <asm/asm.h>
+#include <linux/bitops.h>
 
 #ifdef CONFIG_X86_FEATURE_NAMES
 extern const char * const x86_cap_flags[NCAPINTS*32];
@@ -240,5 +252,6 @@ static __always_inline bool _static_cpu_has(u16 bit)
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) */
+#endif /* !defined(__ASSEMBLY__) */
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index dc6d149bf851..bc7fa3de7ccc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -142,17 +142,6 @@ struct cpuinfo_x86 {
 	unsigned		initialized : 1;
 } __randomize_layout;
 
-struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
-};
-
-enum cpuid_regs_idx {
-	CPUID_EAX = 0,
-	CPUID_EBX,
-	CPUID_ECX,
-	CPUID_EDX,
-};
-
 #define X86_VENDOR_INTEL	0
 #define X86_VENDOR_CYRIX	1
 #define X86_VENDOR_AMD		2
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 21d1f062895a..bcbcda1e329b 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -6,7 +6,7 @@
 
 #include <asm/memtype.h>
 #include <asm/apic.h>
-#include <asm/processor.h>
+#include <asm/cpufeature.h>
 
 #include "cpu.h"
 
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 6f7b8cc1bc9f..23e67220445b 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -37,7 +37,7 @@
 #include <linux/gfp.h>
 #include <linux/completion.h>
 
-#include <asm/processor.h>
+#include <asm/cpufeature.h>
 #include <asm/msr.h>
 
 static struct class *cpuid_class;
-- 
2.31.1.368.gbe11c130af-goog

