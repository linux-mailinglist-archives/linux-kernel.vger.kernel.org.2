Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B8374C55
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhEFA3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhEFA3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:29:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A7E61090;
        Thu,  6 May 2021 00:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620260892;
        bh=q7IDlMGI6xpMvyU4SnCUl+S8bj1v2u/RUGU5QhZTaRg=;
        h=From:To:Cc:Subject:Date:From;
        b=aXMzLTxaQdRhtLL2BuaGd2t4RSdoCkEh03m80QkyfDzdg/J3sgMzo+rg2uG/3N+R3
         476WXcXMKefA/3kdSqkEz6OmvT2KDS7YMbCB9yJg6Hm+ETLv6Plb0Omr6gppPKKAZ+
         dR6eSUJRaMZ3MI0HfpanEbG3GmB+ORrN9R095/swWaZUkia3VW3sZbDnDSM3FJaoFJ
         yfn2RAqcOYEnJsEx3EHlRKD2sNVuj5CUHAz5C5y9ha9nxBpnpDxddfUfhJAx0Jnlhq
         9T7vcnTHxPuypzlCj3UBLJg+tYHt9UgZ5qHfepEfhiooDhWpZdlqKlZauEC4Twt1LL
         HlnPUNME8rNSA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] vmlinux.lds.h: Handle decrypted data section with !SMP
Date:   Wed,  5 May 2021 17:14:11 -0700
Message-Id: <20210506001410.1026691-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.442.g7e39198978
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With x86_64_defconfig and the following configs, there is an orphan
section warning:

CONFIG_SMP=n
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_KVM=y
CONFIG_PARAVIRT=y

ld: warning: orphan section `.data..decrypted' from `arch/x86/kernel/cpu/vmware.o' being placed in section `.data..decrypted'
ld: warning: orphan section `.data..decrypted' from `arch/x86/kernel/kvm.o' being placed in section `.data..decrypted'

These sections are created with DEFINE_PER_CPU_DECRYPTED, which
ultimately turns into __PCPU_ATTRS, which in turn has a section
attribute with a value of PER_CPU_BASE_SECTION + the section name. When
CONFIG_SMP is not set, the base section is .data and that is not
currently handled in any linker script.

Add .data..decrypted to PERCPU_DECRYPTED_SECTION, which is included in
PERCPU_INPUT -> PERCPU_SECTION, which is include in the x86 linker
script when either CONFIG_X86_64 or CONFIG_SMP is unset, taking care of
the warning.

Fixes: ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED")
Link: https://github.com/ClangBuiltLinux/linux/issues/1360
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

I took the simple fix route with this patch since I highly doubt someone
is actually running a CONFIG_AMD_MEM_ENCRYPT=y + CONFIG_SMP=n kernel. If
this section should actually be in .data, I can respin.

 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 40a9c101565e..17325416e2de 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -960,6 +960,7 @@
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
+	*(.data..decrypted)						\
 	*(.data..percpu..decrypted)					\
 	. = ALIGN(PAGE_SIZE);
 #else

base-commit: 8404c9fbc84b741f66cff7d4934a25dd2c344452
-- 
2.31.1.442.g7e39198978

