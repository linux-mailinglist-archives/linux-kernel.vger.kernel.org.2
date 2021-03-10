Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55C73345FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhCJR6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhCJR6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:10 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E5C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:10 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id o14so13271938qvn.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9K/nJk/Yl2gqbmnNeiM3LL/ayLtkmDAblR9vIKiL4JQ=;
        b=GO/2FBWOCecwwU9cbVkaCLcKOpNoYUEQxlXaOTju5rYBLJe6KVFOjZhrsr50oPi7cJ
         oixBWT8jN56XkSpGuyKtO7eFphPP+fGTZfyqjhPKFqd5yH5nSuUmj1pyzAf5pzxmu56q
         A+0qc/vZxgDTaFGM0qtohkzJjFQauPf5/o54cNNBWWToVoSBWWknU86U6JG86OhlV+G/
         vZ5/5v1tIaKV0lowHVFm2NL0U6mxRVnpTeAe53hf5LDhQ4RuUfWYqTjD1ujQMQP6H/hw
         E5lUbIgyH/HaFOtUtqmH3lb3sXaCSAfTmPfh2bO716yMOy+JBoQaPhloemCr0YtCElvV
         juvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9K/nJk/Yl2gqbmnNeiM3LL/ayLtkmDAblR9vIKiL4JQ=;
        b=eLcpPuXALwFD/ZIA9DszpAJOEVME+sMAhbTCWV84rgRzTbxBkVSf8ciP3HCDH5cwxw
         fyZBj3eBEeHqFTpAtX6gogIp8/UC9yGgySush74ZZud/iuyQZNv92lRy3uJ2SuQE1Eww
         DZbsm5rdD2BKgOmU7tYN6xGvBbVqz/7fu7qePKQG+7RFiONdtcucngLQbklLEEuo3G/F
         AGfuMjl9OYtQvmegfrE4XgS93VhKNrxfsitBix+x8Aw/v/ejZduZZZ8FWtu/WA2XXnWQ
         mA2394sxQsRbz2HArUQ0iKv98Ae0S4x/kwZa3JVeboqmD7RSEaZCq4cEmqgrbdkrnq4B
         P13A==
X-Gm-Message-State: AOAM530+Ep7d0RKI3q5NCrA8Cx8kIquzWzN2hEYrEKiqn8lYagTbI4bB
        WeW5zGIHe03GK2qclFY+MW+TG2OdPKry
X-Google-Smtp-Source: ABdhPJzB9OC6KWOlWJUJdL2k6mNjWxJq7jz6ESdJuBvXdwVSCdMLhWW4203j676QenoaxLPF0EYv6dv6kppm
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1870:: with SMTP id
 eh16mr4059145qvb.23.1615399089435; Wed, 10 Mar 2021 09:58:09 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:24 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-8-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 07/34] KVM: arm64: Introduce a BSS section for use at Hyp
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
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

