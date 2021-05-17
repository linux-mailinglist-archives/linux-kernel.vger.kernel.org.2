Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F338257B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhEQHl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:41:28 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:34168 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhEQHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:41:26 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 14H7cLoN027919;
        Mon, 17 May 2021 16:38:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 14H7cLoN027919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621237106;
        bh=s1wiLTH91EKAgG1RLCAKeMhWZ7J2zh+/Hi2ne1w2pKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sv+el2cvTNsB2UE/y1bR2Nv/6xXovT+yaJJ0lqqrtyUv7mCzCrW9y/UNlK+gwuQ14
         5Hhg3AiedFt81jV3on2INOupe9dxM7aiH449AZ7faA6A/TMxg1iIfWph1SSxhrR8aD
         j9wwQ1vjghIA+EzJgE95LjevIVcr0j6+lHChf1qeZbyjQauXnJmOU7yXw26yZV8W9f
         Mxj2hVdXvw8WEH+wXi86LVj3DvcwINAdh/F0yGXkAkksmGQJ36KVC0qu2Z+U+Oeef3
         XqSBBpvpmW4ZgBVdNpaCBk6TTiv3bFhtYC+ZzVGBG7Apo96Tj7z0AFjGhq6keFrrBU
         erDhbS02giVRA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: [RESEND PATCH 5/6] x86/syscalls: use __NR_syscalls instead of __NR_syscall_max
Date:   Mon, 17 May 2021 16:38:13 +0900
Message-Id: <20210517073815.97426-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517073815.97426-1-masahiroy@kernel.org>
References: <20210517073815.97426-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscall_max is only used by x86 and UML in the following two files:

  - arch/um/kernel/skas/syscall.c
  - arch/x86/include/asm/unistd.h

In contrast, __NR_syscalls is widely used by all the architectures.

Let's convert __NR_syscall_max to __NR_syscalls by adding one.

This makes arch/x86/include/asm/unistd.h look cleaner, and also
prepares x86 to switch to the generic scripts/syscallhdr.sh from
arch/x86/entry/syscalls/syscallhdr.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/kernel/skas/syscall.c         | 2 +-
 arch/x86/entry/syscalls/syscallhdr.sh | 2 +-
 arch/x86/include/asm/unistd.h         | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 3d91f89fd852..9ee19e566da3 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -41,7 +41,7 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-	if (syscall >= 0 && syscall <= __NR_syscall_max)
+	if (syscall >= 0 && syscall < __NR_syscalls)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
diff --git a/arch/x86/entry/syscalls/syscallhdr.sh b/arch/x86/entry/syscalls/syscallhdr.sh
index cc1e63857427..75e66af06773 100644
--- a/arch/x86/entry/syscalls/syscallhdr.sh
+++ b/arch/x86/entry/syscalls/syscallhdr.sh
@@ -28,7 +28,7 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 
     echo ""
     echo "#ifdef __KERNEL__"
-    echo "#define __NR_${prefix}syscall_max $max"
+    echo "#define __NR_${prefix}syscalls $(($max + 1))"
     echo "#endif"
     echo ""
     echo "#endif /* ${fileguard} */"
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 1bc6020bc58d..80e9d5206a71 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -13,7 +13,7 @@
 #  define __ARCH_WANT_SYS_OLD_MMAP
 #  define __ARCH_WANT_SYS_OLD_SELECT
 
-#  define __NR_ia32_syscall_max __NR_syscall_max
+#  define IA32_NR_syscalls (__NR_syscalls)
 
 # else
 
@@ -26,12 +26,12 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
-#  define X32_NR_syscalls (__NR_x32_syscall_max + 1)
+#  define X32_NR_syscalls (__NR_x32_syscalls)
+#  define IA32_NR_syscalls (__NR_ia32_syscalls)
 
 # endif
 
-# define NR_syscalls (__NR_syscall_max + 1)
-# define IA32_NR_syscalls (__NR_ia32_syscall_max + 1)
+# define NR_syscalls (__NR_syscalls)
 
 # define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
-- 
2.27.0

