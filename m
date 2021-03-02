Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA932A916
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350194AbhCBSKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578851AbhCBP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:27:40 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5216C061D73
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:23 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id m9so5489537wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8bbnvPt9CW/Bw+xbxj5kVgoG1b0td8h29usK6cRvX/g=;
        b=bGP9S11iy12yWIq+SRzbBLfrqT/KxZQvr6+/zzIfBr0VHxpTLgSqLY3ympRI037cHJ
         FxOsE9QbT27L1i81ENsqMxD0lPJqOB0UmjGmWO7tge8huWR/oBFRJjyMSiIJc2lR154S
         5finKE3AWj9R06EYW87A4qaOVLD5Day1XvI+OagN8jGtEV7m4mJXayfCPPGXOt3aoew/
         wsRsVfJg1PP9dlOMKX3SgrvZEZQLqsUFaGe4s0bItLVcgfCwDzCYWj21VoDgYAWcDP6O
         eqW5Eh2E5q87g4In7/DR+Nre1cgbN3My1wHSZp675LMlravcQ+CGT22oGNOxrV0hCGiR
         AAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8bbnvPt9CW/Bw+xbxj5kVgoG1b0td8h29usK6cRvX/g=;
        b=GF/AJyKLZcATOf9GNkXnHU5C1HjK7Iw7kmjBsaZqp5DGlyBHnFpOdD1YUHIJOpHwDz
         ySOHi+J1IvylVkj6r8Pb4AEtvwLJuTb4U0s+F9Q1+DOFkGK7wC+xeilifkAE1mpdGmeY
         QtfDtsBKZtdE7/7Ej9CS60sAxxxdKE1+7eKLAI9Kr1p6lrdDAR6eQEtIu4oLKys2dFrm
         vLtUQoAMaY2R0auxBqD3SaA/Y+j3+rpCsXcjHTqFdyFpocMgxsW+oVUlfXORa60isCXm
         WoXtljvQaPNblfEEXtNu5p4L2/EqkNLOjaGpConIast/JeSqaPE+/QMImAprs153MwE5
         uCBQ==
X-Gm-Message-State: AOAM532AkuGgHi2lHLLYCWqv0k36KNIiNP143izFuTDFcxrJutFlHxoX
        3/xptLz55byNIbu9V0fY4RHfNK1Nr4no
X-Google-Smtp-Source: ABdhPJyVmg/89pOwnrWFLDSfYM5uH/qd3yEnMJU8ydZC+pYcedTms4XYjP3iwCvWd4XucfLqxTMPiadxX0ey
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr495456wmi.1.1614697222067; Tue, 02 Mar 2021 07:00:22 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:37 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-8-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 07/32] KVM: arm64: Introduce a BSS section for use at Hyp
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

Currently, the hyp code cannot make full use of a bss, as the kernel
section is mapped read-only.

While this mapping could simply be changed to read-write, it would
intermingle even more the hyp and kernel state than they currently are.
Instead, introduce a __hyp_bss section, that uses reserved pages, and
create the appropriate RW hyp mappings during KVM init.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   | 52 ++++++++++++++++++++-----------
 arch/arm64/kvm/arm.c              | 14 ++++++++-
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  1 +
 4 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 2f36b16a5b5d..e4ad9db53af1 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -13,6 +13,7 @@ extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
 extern char __hyp_rodata_start[], __hyp_rodata_end[];
 extern char __hyp_reloc_begin[], __hyp_reloc_end[];
+extern char __hyp_bss_start[], __hyp_bss_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7eea7888bb02..e96173ce211b 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -5,24 +5,7 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  */
 
-#define RO_EXCEPTION_TABLE_ALIGN	8
-#define RUNTIME_DISCARD_EXIT
-
-#include <asm-generic/vmlinux.lds.h>
-#include <asm/cache.h>
 #include <asm/hyp_image.h>
-#include <asm/kernel-pgtable.h>
-#include <asm/memory.h>
-#include <asm/page.h>
-
-#include "image.h"
-
-OUTPUT_ARCH(aarch64)
-ENTRY(_text)
-
-jiffies = jiffies_64;
-
-
 #ifdef CONFIG_KVM
 #define HYPERVISOR_EXTABLE					\
 	. = ALIGN(SZ_8);					\
@@ -51,13 +34,43 @@ jiffies = jiffies_64;
 		__hyp_reloc_end = .;				\
 	}
 
+#define BSS_FIRST_SECTIONS					\
+	__hyp_bss_start = .;					\
+	*(HYP_SECTION_NAME(.bss))				\
+	. = ALIGN(PAGE_SIZE);					\
+	__hyp_bss_end = .;
+
+/*
+ * We require that __hyp_bss_start and __bss_start are aligned, and enforce it
+ * with an assertion. But the BSS_SECTION macro places an empty .sbss section
+ * between them, which can in some cases cause the linker to misalign them. To
+ * work around the issue, force a page alignment for __bss_start.
+ */
+#define SBSS_ALIGN			PAGE_SIZE
 #else /* CONFIG_KVM */
 #define HYPERVISOR_EXTABLE
 #define HYPERVISOR_DATA_SECTIONS
 #define HYPERVISOR_PERCPU_SECTION
 #define HYPERVISOR_RELOC_SECTION
+#define SBSS_ALIGN			0
 #endif
 
+#define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
+
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
+#include <asm/kernel-pgtable.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+
+#include "image.h"
+
+OUTPUT_ARCH(aarch64)
+ENTRY(_text)
+
+jiffies = jiffies_64;
+
 #define HYPERVISOR_TEXT					\
 	/*						\
 	 * Align to 4 KB so that			\
@@ -276,7 +289,7 @@ SECTIONS
 	__pecoff_data_rawsize = ABSOLUTE(. - __initdata_begin);
 	_edata = .;
 
-	BSS_SECTION(0, 0, 0)
+	BSS_SECTION(SBSS_ALIGN, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
 	init_pg_dir = .;
@@ -324,6 +337,9 @@ ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
 ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
 	"Entry trampoline text too big")
 #endif
+#ifdef CONFIG_KVM
+ASSERT(__hyp_bss_start == __bss_start, "HYP and Host BSS are misaligned")
+#endif
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 2d1e7ef69c04..3f8bcf8db036 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1770,7 +1770,19 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
-	err = create_hyp_mappings(kvm_ksym_ref(__bss_start),
+	/*
+	 * .hyp.bss is guaranteed to be placed at the beginning of the .bss
+	 * section thanks to an assertion in the linker script. Map it RW and
+	 * the rest of .bss RO.
+	 */
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_bss_start),
+				  kvm_ksym_ref(__hyp_bss_end), PAGE_HYP);
+	if (err) {
+		kvm_err("Cannot map hyp bss section: %d\n", err);
+		goto out_err;
+	}
+
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_bss_end),
 				  kvm_ksym_ref(__bss_stop), PAGE_HYP_RO);
 	if (err) {
 		kvm_err("Cannot map bss section\n");
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index cd119d82d8e3..f4562f417d3f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -25,4 +25,5 @@ SECTIONS {
 	BEGIN_HYP_SECTION(.data..percpu)
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	END_HYP_SECTION
+	HYP_SECTION(.bss)
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

