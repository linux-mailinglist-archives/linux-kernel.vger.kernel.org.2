Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97C0341949
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCSKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCSKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:07 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E877C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:06 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id l16so8113337wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oul0y1YRwu6Xp/Stomf5Vmvh7DCtXCVsizSXHMFv9oc=;
        b=gpEARtig1c/yAeen7RZ7yreYc0sx0xJY1WDhAzbU9tn6sWOwkZH9IdOPsMww/3IgYC
         GNhizOETCs5hJWyJ7sEOb7MjOenRZMyjVFg6+aqfoe3SjbijZfgpl3IQStUEp41tpvQv
         EKalXJyimZ5tI+NC4c4MYyMLgv6o8EkbuSSueWNu2rYKxx4JlD7DftB6A6IfDar+Q1Ot
         jSlJN4hpK9H0b07jlJTikhwiFDvLj1fv1GPo/joERhFY6eqS46OZj+uKJa2Mva75LF12
         DF0t/XOGl+dPNqB8Y5+W2E26R4ohQf+0k9C+GBYe7LTAJU00tz88gKsgIis+RmC3EkF5
         voQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oul0y1YRwu6Xp/Stomf5Vmvh7DCtXCVsizSXHMFv9oc=;
        b=ULONzkUW3kPsN13Sj4G42uok2f1tGzAcn2W1OPKiLURSi4Z6GuxJJcn+p9IvlX4LWB
         JB1+FcAqvZoGTidRXe4z00i2+YCU+ESPXrCBAwxkjCcyVCkghvDm0ZGIC0HKLTjzUadN
         aS19KqKSdy/tHOgCAbIS5y7ZXSB6Fv8Ii4/plfHmQxxQOvcoYNwbsTbxt8XGLlodKojg
         lp47I8XXBi7THRWdACwgIWN9/T4kHKDtzhUu/mYtDDTI2GtPktpPzYGMEmAyxyF8VFo+
         df1UDmY8qUFdJkE1m2rz3ZElURepIu419Mpdl3YcCrIT5mJv+4g2T+uOMFRMVmGcffet
         VACg==
X-Gm-Message-State: AOAM5335Smz7SWI/Ri4hFKcEcZIFXmuN65z3cQpEA4sGx7qcnu3SQaYL
        4ucB6P6zR8KWrntrx60SJYfQ0MB9ksxD
X-Google-Smtp-Source: ABdhPJxTCVkd35ftfSx/StLzKJXeTz5bBgJWKVmT5cQ4QgJGcv0Ne1fDUB89kkpZtO34Y+P+VpxOx4uHw9//
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:198c:: with SMTP id
 t12mr2920666wmq.183.1616148125189; Fri, 19 Mar 2021 03:02:05 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:15 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-8-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 07/38] KVM: arm64: Introduce a BSS section for use at Hyp
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
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

Acked-by: Will Deacon <will@kernel.org>
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
index 2adb8d878bb9..22d6df525254 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1775,7 +1775,19 @@ static int init_hyp_mode(void)
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
2.31.0.rc2.261.g7f71774620-goog

