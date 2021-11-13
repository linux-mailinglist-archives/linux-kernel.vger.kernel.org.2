Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47EC44F31D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhKMMoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 07:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhKMMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 07:44:20 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2514BC061767
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:28 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id t19so23621554oij.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdl0+bVbKQVCShGaAXh7Gbue18kYPAyPlbRt1h2vfHs=;
        b=MxfuSfczuZdwCfcPnS5//ENCCidKJ3vjCbOy1nr5QV5l4uz/QlIPLuTqDwHATkLVpk
         KqhzEsPAgzuo4Vr6Q+wIJqDauQ+sbL5OsNgr9/8wt0b834hUdZ2iz4dh/E4sFaH6/x8Y
         lLxQBbYWthHRKp48P0pQa58eSaARgC/UDqfOTvvfbyeN2WnhTYQCl5r8300/pxnS5oK0
         tbIAfM740tUeKmtvcNvVyH/irId1Gb3FflJRMe21kt5CA9swCAkj3fixnPJcakq0xDiT
         iBwCrVzXBfBDPli/Il+mnJtiEBn0GijnuugaNURqiBIwai6UvsYabJfeez+d2eIhL8Eg
         iQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdl0+bVbKQVCShGaAXh7Gbue18kYPAyPlbRt1h2vfHs=;
        b=tS7TiF5vjyBWw9F0N/himl0bBoaosU8frdAaVw+YLO+zdIUf/0mvM8UMQZP+IBRc7V
         br/tfWTh7Jmn6Mk5GvFWwGqn6HE5lXQduOykCViZUqluGhU7TQqbXq8ww3Bgm6OSut4c
         FwbjDLs9SczTXCZrgrAdOacrBm4KjZTGzR7ENMPiFQ3fHLo/MHv4naaqBYKAzXbNpjSR
         MhQXoKLUMn+Z3TY+5lREE9HmEVBSps1rQpMX4VaHihSOou+hArHsNfysnO51GITehM8c
         zYphCnhzCvYK+ZSh/PCN+uk1oMu6/Z0kJcxYxL8py2dhI0oslL8qWRy2G3Q9nHTFp5f2
         OYgg==
X-Gm-Message-State: AOAM533dAnLhBUV05VnwuRCYpBx0h40rUVOUvl3OZ5SxtyzIpJ9SqFMz
        s4LQPInUdLtl3coCm51Vzj/2udlbQw==
X-Google-Smtp-Source: ABdhPJzQRdpYmKMnwvZQgos+d8jb5bx505f73d7b+cn+8GcRRNriInr8aoNUe8ymrjY6ePnUsB8tgg==
X-Received: by 2002:a54:4791:: with SMTP id o17mr19998045oic.114.1636807287454;
        Sat, 13 Nov 2021 04:41:27 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id x8sm1796675otg.31.2021.11.13.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 04:41:27 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/3] x86_64: Use relative per-cpu offsets
Date:   Sat, 13 Nov 2021 07:40:35 -0500
Message-Id: <20211113124035.9180-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211113124035.9180-1-brgerst@gmail.com>
References: <20211113124035.9180-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-cpu section is currently linked at virtual address 0, because
older compilers hardcoded the stack protector canary value at a fixed
offset from the start of the GS segment.  Use a standard relative offset
as the GS base when the stack protector is disabled, or a newer compiler
is used that supports a configurable location for the stack canary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig               |  2 +-
 arch/x86/include/asm/percpu.h  |  4 ++--
 arch/x86/kernel/head_64.S      |  4 ----
 arch/x86/kernel/setup_percpu.c |  2 +-
 arch/x86/kernel/vmlinux.lds.S  | 14 ++++++--------
 5 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 832a6626df72..fae7724505bd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -403,7 +403,7 @@ config STACKPROTECTOR_FIXED
 	default y if !$(cc-option,-mstack-protector-guard-reg=gs)
 
 config X86_ABSOLUTE_PERCPU
-	def_bool X86_64 && SMP
+	def_bool STACKPROTECTOR_FIXED && SMP
 	select KALLSYMS_ABSOLUTE_PERCPU
 
 menu "Processor type and features"
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a3c33b79fb86..8294781bb483 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -16,7 +16,7 @@
 #define PER_CPU_VAR(var)	var
 #endif	/* SMP */
 
-#ifdef CONFIG_X86_64_SMP
+#ifdef CONFIG_X86_ABSOLUTE_PERCPU
 #define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
 #else
 #define INIT_PER_CPU_VAR(var)  var
@@ -59,7 +59,7 @@
 #define DECLARE_INIT_PER_CPU(var) \
        extern typeof(var) init_per_cpu_var(var)
 
-#ifdef CONFIG_X86_64_SMP
+#ifdef CONFIG_X86_ABSOLUTE_PERCPU
 #define init_per_cpu_var(var)  init_per_cpu__##var
 #else
 #define init_per_cpu_var(var)  var
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 6e396ffb1610..c1b6209a01ca 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -339,12 +339,8 @@ SYM_DATA(initial_code,	.quad x86_64_start_kernel)
 #ifdef CONFIG_STACKPROTECTOR_FIXED
 SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
 #else
-#ifdef CONFIG_SMP
-SYM_DATA(initial_gs,	.quad __per_cpu_load)
-#else
 SYM_DATA(initial_gs,	.quad 0)
 #endif
-#endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 5afd98559193..4c0020a6ced9 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,7 +26,7 @@
 DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_ABSOLUTE_PERCPU
 #define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
 #else
 #define BOOT_PERCPU_OFFSET 0
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index c475d21d2126..18e1deb9fa52 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -102,10 +102,10 @@ jiffies = jiffies_64;
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_ABSOLUTE_PERCPU
 	percpu PT_LOAD FLAGS(6);        /* RW_ */
 #endif
+#ifdef CONFIG_X86_64
 	init PT_LOAD FLAGS(7);          /* RWE */
 #endif
 	note PT_NOTE FLAGS(0);          /* ___ */
@@ -215,7 +215,7 @@ SECTIONS
 		__init_begin = .; /* paired with __init_end */
 	}
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
+#ifdef CONFIG_X86_ABSOLUTE_PERCPU
 	/*
 	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
 	 * output PHDR, so the next output section - .init.text - should
@@ -339,7 +339,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
+#ifndef CONFIG_X86_ABSOLUTE_PERCPU
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
 #endif
 
@@ -474,7 +474,7 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_ABSOLUTE_PERCPU
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
@@ -483,13 +483,11 @@ SECTIONS
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(irq_stack_backing_store);
 
-#ifdef CONFIG_STACKPROTECTOR_FIXED
 INIT_PER_CPU(fixed_percpu_data);
 . = ASSERT((fixed_percpu_data == 0),
            "fixed_percpu_data is not at start of per-cpu area");
-#endif
 
-#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_X86_ABSOLUTE_PERCPU */
 
 #ifdef CONFIG_KEXEC_CORE
 #include <asm/kexec.h>
-- 
2.31.1

