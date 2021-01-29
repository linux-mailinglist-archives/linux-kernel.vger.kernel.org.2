Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71027308E37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhA2UNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233156AbhA2UML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:12:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C9B361492;
        Fri, 29 Jan 2021 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611951091;
        bh=hloW2izlFMsnTTBuy5yCGZ3fvih3JrmByu4e1J6hmus=;
        h=From:To:Cc:Subject:Date:From;
        b=qTsQEjnmv9F+oRG+EPyPofJ0eO8y+2b2dVupdXUsfZTWc8Ufvn86McCouKpJCsfYB
         2xh9OFzrq8yrmLW7UmfzYn9LHjOF7vsehRp9l14tvDM7QpbzpNZMT/5Cj4OUpqgH0l
         52mQ6WgJxDENkmxke+BdFU4dRP1OOWoBnp3XUHwiDYU4eZjj3ylRrCaIK56uG+Urpl
         aSdpwTzmw+iaPgR/hMMT8UIY3ViMUz0W93tc3jZ+AqbBIvzCzcoPeqHZcmBjKPBZn1
         cB5AWOs6ZICeDAghoYlQACrXHsPdyBvFxt+61GN997M7TmdWgLVR1aaeu2USqA5yqe
         3QInPF9Wb+CxQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y
Date:   Fri, 29 Jan 2021 13:11:16 -0700
Message-Id: <20210129201116.2658179-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang produces .eh_frame sections when CONFIG_GCOV_KERNEL is enabled,
even when -fno-asynchronous-unwind-tables is in KBUILD_CFLAGS:

$ make CC=clang vmlinux
...
ld: warning: orphan section `.eh_frame' from `init/main.o' being placed in section `.eh_frame'
ld: warning: orphan section `.eh_frame' from `init/version.o' being placed in section `.eh_frame'
ld: warning: orphan section `.eh_frame' from `init/do_mounts.o' being placed in section `.eh_frame'
ld: warning: orphan section `.eh_frame' from `init/do_mounts_initrd.o' being placed in section `.eh_frame'
ld: warning: orphan section `.eh_frame' from `init/initramfs.o' being placed in section `.eh_frame'
ld: warning: orphan section `.eh_frame' from `init/calibrate.o' being placed in section `.eh_frame'
ld: warning: orphan section `.eh_frame' from `init/init_task.o' being placed in section `.eh_frame'
...

$ rg "GCOV_KERNEL|GCOV_PROFILE_ALL" .config
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y

This was already handled for a couple of other options in
commit d812db78288d ("vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted
sections") and there is an open LLVM bug for this issue. Take advantage
of that section for this config as well so that there are no more orphan
warnings.

Link: https://bugs.llvm.org/show_bug.cgi?id=46478
Link: https://github.com/ClangBuiltLinux/linux/issues/1069
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..f753fd449436 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -988,12 +988,13 @@
 #endif
 
 /*
- * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
+ * Clang's -fsanitize=kernel-address, -fsanitize=thread,
+ * and -fprofile-arcs -ftest-coverage produce unwanted
  * unwanted sections (.eh_frame and .init_array.*), but
  * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
  * https://bugs.llvm.org/show_bug.cgi?id=46478
  */
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN) || defined(CONFIG_GCOV_KERNEL)
 # ifdef CONFIG_CONSTRUCTORS
 #  define SANITIZER_DISCARDS						\
 	*(.eh_frame)

base-commit: bec4c2968fce2f44ce62d05288a633cd99a722eb
-- 
2.30.0

