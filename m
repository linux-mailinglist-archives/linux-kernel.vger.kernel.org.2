Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8490733C524
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhCOSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhCOSCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:02:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FBAC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:38 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n9so19958159pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcTnVacz4A0tmKEIIvO2n/EpgXlfdRl1ckINTgAR5oI=;
        b=PQ3XGnvMsKcXU4s5p+F5dfZF6FA/iSbcSn0nswwcqPExK09KIRLEltkz0Bh8wiwE7N
         1XkNp1GfB55SBD6zDGJQRjdRpTR4DYjid5msGEofOSSYqbipdCIbWhBqrPM9AWy1UM52
         l+EaNe1XtG5skHL76gK0sXV38Rb8Lgh4egJtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcTnVacz4A0tmKEIIvO2n/EpgXlfdRl1ckINTgAR5oI=;
        b=lRwTlYSJBMnP6LmNk+vIW4g/DsiPlsHtbJCgjPtZVIfTEyWIMkdWIEIW3VXSWua0BN
         jmI4/R6yise3Vf8SiCzEmoELw3vnBeYZjhyJ7UTRV514XRzUiCrpm4V0l49/9yM6HoyD
         sKCwbRywUNl9ta+eV5FWAx83uGtff/F34hoTRjudazRh73u2gLvG2Y7CygGl7bJC86Kx
         5+gYWOxaMDlCCPuWziNcgWNqNJSxboKcb/daTPe21a+KFoA+qTW8x/6oMnHfvLO/iADV
         vlBWf8C/DHJKVJSfcdTUWd5TXFw+wBWdwtBYNd+4d2haU0yzjV6qabAmOVQa4S/CAnb+
         qKIg==
X-Gm-Message-State: AOAM530d6aujnLbKPIINRw5LG5clrafnkq5fzN6uJvKT3DE/tkJcAi1F
        Ri2wk1wFoKMirmMqHV4ks0PiBA==
X-Google-Smtp-Source: ABdhPJxy/jBx4lbYUG9dTL/BSOwG++1sLNIRxLhlf/Aak5xk+P2rM72P6uwME362sOaUIYrG0OIg4w==
X-Received: by 2002:a65:4c86:: with SMTP id m6mr314819pgt.174.1615831358475;
        Mon, 15 Mar 2021 11:02:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e20sm13764419pgm.1.2021.03.15.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] x86/entry: Enable random_kstack_offset support
Date:   Mon, 15 Mar 2021 11:02:27 -0700
Message-Id: <20210315180229.1224655-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315180229.1224655-1-keescook@chromium.org>
References: <20210315180229.1224655-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=1a3993b6371bcc7c9fa1576e563a724a70c25875; i=np7yed3mY+gWIWkexmB7CyDLgwsIh0xV2RGaksJc7tI=; m=cc9SLz8pm+mdXOKZLHtRjH7FITDzwHCOKmwFrX1p7io=; p=UyRR1nzRrbUXeUU5ICay1xt2wYZVgu7b/Eh0FjkN2Hc=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBPoTQACgkQiXL039xtwCb9dw/8CDN Ir13NcCLMJOuRm2LpzDYbdgOc9JQ2QokpXPH/jLGBVXWXwV2g8Nk5TYJJcm7X/yj75HbSyNJLBUVU c8QbEGqzcBxjyIZUTKBDrYfApusLejywRj5YCmq1CONO5XBcJTMPuNAo1ZlzyQ0fI+754FraF3eU/ O8qcOD18DBVIsRP7e9ASpSyjqINb46mpEDrlvXa+uJyzGfAGLz+B0NLm6WPK0eaKzRmPC3mUs5gXU 9pL8/JlmcsD3Ne3kzSexmn7+uvYXEcwRagE8A76gkzE69JK3Lq8uIAyFARV2VO8mXZcUD/loxowRK vpn44j3EK04VB/Nf0IEDP6SNkNmSFvdqOSbp8gXcBI+rAJgA91SXLBf+ld9pIsIkGf6+uvY+rKqb7 XT7pyiu/3f7C3m64R7FFFUsWH6waSp2VR4ccIbNM97N6o5FY5keipPsjJNinKedZwOGjmY2O+FMkE nxUr2FjxcwFOBCbAkwJL+rgVv9UPOprPnq+Gxi6axTrDjRe3JoWtapLhbdDjHYLos7Gh5+UhghIj/ vYKfMHbHOOlKyhcrufiMXbcy0dkK6EK9ES3KNDmWu0cpxS2QAPrJvyrC6eCIxT9T0fko/eWgdUhWi ZNc8RzQeH2jVopqqCkmd8L74weZxz2gnh8S5w2OW3/yb5VWZ8VjJWDr3879m6aVE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5-6 bits of entropy, depending on compiler and word size. Since the
method of offsetting uses macros, this cannot live in the common entry
code (the stack offset needs to be retained for the life of the syscall,
which means it needs to happen at the actual entry point).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig                    | 1 +
 arch/x86/entry/common.c             | 3 +++
 arch/x86/include/asm/entry-common.h | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..4b4ad8ec10d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -165,6 +165,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index a2433ae8a65e..810983d7c26f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -38,6 +38,7 @@
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
+	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
@@ -83,6 +84,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	unsigned int nr = syscall_32_enter(regs);
 
+	add_random_kstack_offset();
 	/*
 	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
 	 * orig_ax, the unsigned int return value truncates it.  This may
@@ -102,6 +104,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	unsigned int nr = syscall_32_enter(regs);
 	int res;
 
+	add_random_kstack_offset();
 	/*
 	 * This cannot use syscall_enter_from_user_mode() as it has to
 	 * fetch EBP before invoking any of the syscall entry work
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 2b87b191b3b8..8e41566e154a 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
+#include <linux/randomize_kstack.h>
 #include <linux/user-return-notifier.h>
 
 #include <asm/nospec-branch.h>
@@ -70,6 +71,13 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 */
 	current_thread_info()->status &= ~(TS_COMPAT | TS_I386_REGS_POKED);
 #endif
+
+	/*
+	 * x86_64 stack alignment means 3 bits are ignored, so keep
+	 * the top 5 bits. x86_32 needs only 2 bits of alignment, so
+	 * the top 6 bits will be used.
+	 */
+	choose_random_kstack_offset(rdtsc() & 0xFF);
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
-- 
2.25.1

