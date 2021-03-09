Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC6333134
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhCIVnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhCIVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:43:12 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E79C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:43:12 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g4so9726752pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcTnVacz4A0tmKEIIvO2n/EpgXlfdRl1ckINTgAR5oI=;
        b=g9mbVr6V7xJGugC2gPTw2AMctj391Z+XCiZu7k+SK//LiTMM+QBj3M/FHgckF+qI9K
         N7xliOCzmIGrsjVEKNOpDcoZWE/5lvFz/52as57ruksFXts4vF46jhV46Xp9QyBFJci2
         1Uo819VKYBW9PfGRN67ylRVMUWziyI7JyosFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcTnVacz4A0tmKEIIvO2n/EpgXlfdRl1ckINTgAR5oI=;
        b=PeEsdWiehRct5b4KDVlLCYG32JbbEYYdibj1VvZbeXQEFUngtdeJPjC8JHYMxuF/uS
         +l8uYKQEZ+MZXwNGE/CU6/JQ4GhoKYpog1VTJTj8auIUoMeEBkELLP9EqVJIA8f1nAHd
         K/B5HLMdhK06Qh375PFouWZx7a+JIkI0iuly33vV3fj1hMPWlSm8tXaf75cf1j3SNV3q
         ZPBYECQWHiCgqeTz1WHmOIVbOuV0t5mVhbWrb6pGktzEgraubrqM5z6fPRpxRqU20kox
         GfSwHLO0PDJ5434rV3pjvwGyC0vkQmjCyDrgSkDTGs/2zxC3lHW9p9XitdhOc+2QWSBm
         6LWQ==
X-Gm-Message-State: AOAM530fwkmniyQ8fDFWicQH/KQgFqA2nHh1AYLnbRNgYd5QssUWdQzk
        ruwo3Ze6Z4f74Zw2IWfP5XfxFQ==
X-Google-Smtp-Source: ABdhPJxgaMq60/8LT1KyAa101Khr91ahTpw6YQ74MnNFEX+siGaxShBO638RxRvX1u9rVkRXcE8twg==
X-Received: by 2002:a05:6a00:2cd:b029:1f4:c3db:4191 with SMTP id b13-20020a056a0002cdb02901f4c3db4191mr3893pft.71.1615326192428;
        Tue, 09 Mar 2021 13:43:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm5917461pfn.62.2021.03.09.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:43:11 -0800 (PST)
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
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 5/7] x86/entry: Enable random_kstack_offset support
Date:   Tue,  9 Mar 2021 13:42:59 -0800
Message-Id: <20210309214301.678739-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309214301.678739-1-keescook@chromium.org>
References: <20210309214301.678739-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=1a3993b6371bcc7c9fa1576e563a724a70c25875; i=np7yed3mY+gWIWkexmB7CyDLgwsIh0xV2RGaksJc7tI=; m=cc9SLz8pm+mdXOKZLHtRjH7FITDzwHCOKmwFrX1p7io=; p=UyRR1nzRrbUXeUU5ICay1xt2wYZVgu7b/Eh0FjkN2Hc=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBH6+QACgkQiXL039xtwCYLvQ//ZVV jKPhAQU2IVFJZBsGYqSYa3g8Q8uXNjqNouwYZkGdZqCp2yYRsOzmXFeH0qyZJScVL7wk5Ocm/QTFW OZermriCXaGfjKrBkgIjBKWkpovFITXMioqiiczOh7oKZdo8pNVZ1ORyZoNOeQS3VBXKjN+07PE3h dMMzX56qSTd9WKxNPLKAo2kcBNV1vyrAW8pz2WcZvQEqImlpKpR4XxS7IYdK3YivXvt98Ny1/RRJS RfubXI54V4KwvZGGc13jwp1UsZfgnRAcxEHTSz+jlpK5CyZkfqgBNOQBIJd/bmUi8iMIPRB1fkHMY vTp2Nn3+PBSlIpGQiDyMoHW03a92fqONW5g98Ci048GC5vwFsjQbWB66SuAg/sf5qWZRmLYhxaHqR 8l56FZXXqzdjtLYuQvLxARNqgiYjjON93W1qxsHO1MoNsGbTGYOwvdHF+/70kZjRRS+4a4z21qQcL Rxvaadi1lQYfNlwgu0D7FoJcOxT12AJ8O7U1wLiIWroeJVxpYfq3sdQ5UT7Bgw/+Myc/ElGZhVK7m L0S/dtlbsTNa2yVUxTFGp4+UXIaH3CYIsAlrK63FimB7nbe4+a0mzl5DhJ+6+Of1ZGbvMlJnGyFsL 3EmbxC4ZdezBe/5xGxUELY+eR9ndl+C3u2gZzoCCKkJL+vEtcYX35II8VFuA2ab4=
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

