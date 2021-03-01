Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5B327F4B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhCANTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:19:25 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:37601 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhCANSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:18:40 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121DFe7X026106;
        Mon, 1 Mar 2021 22:15:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121DFe7X026106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614604548;
        bh=s1wiLTH91EKAgG1RLCAKeMhWZ7J2zh+/Hi2ne1w2pKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHfRSyXdAonFPtB4C66dvw6iYP3sUpIAEesqYif1NZxbwlNs7YlmuYZZLe2dJPyBN
         WVYYeXQd/iXIF9tCxgxaMwr1ENIbDxvzwmBLhCXEomNimcjFjuMWIXVNubO+g8rFGN
         xFWmqI5KqXJjsUz074MM4jCUB01jFVc0ZCCirFwTJgOQBnG/kkB9XrNf5H8WvqfM8x
         KCPnftb31x0dJAZmwgJW4vm5ndUA88QictPjHheDGHQBihhmwYRDVuQkjgNaMw+lgh
         ku7SOf9apLbi8iQO6psSmx2Ru9GkKa2jW/stsOVNGpwSp+21ffpNnqPPSjgz8+ZYib
         fKIhxHN9THtRQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Gerst <brgerst@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCH 6/7] x86/syscalls: use __NR_syscalls instead of __NR_syscall_max
Date:   Mon,  1 Mar 2021 22:15:31 +0900
Message-Id: <20210301131533.64671-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301131533.64671-1-masahiroy@kernel.org>
References: <20210301131533.64671-1-masahiroy@kernel.org>
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

