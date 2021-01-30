Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87063309460
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhA3KVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhA3A16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:27:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BA3764E00;
        Sat, 30 Jan 2021 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611966435;
        bh=T6CSjbBhjBe08pyip59nu5BecvICMTSZdw9QpUPIIHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGK18VaLZTQOfi8+66QN4kHlHzjo23VuSHdPsntDxYAH64wUjqHh8FkoPFo4CmDbv
         i8shE68JzyhYJ/rj5eFy34Ib90yTqJZf6NEd3UydvmB5MqqsZ6aHb4l8FWRGq2TNQx
         Uo2TqIAzhaxzpOEmoh9SGvIotQs/5UFvH+qj6z1WD393ZsH30P4JCQpEAVXNQwP8wH
         5CslTXVdLI/1RumHZiO/ZhyYmgrYkh8Db6162j/Hum045SyCuOI9Gs0wDJgHk74ZcD
         mbknya/pJmNNz4cPaNXyBa3a0ihkY2tcdYqilb8zCEtNDf5DH5QSSpoRK20FQ5pLU7
         DeLsvWCvzJMQg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Fangrui Song <maskray@google.com>
Subject: [PATCH v2] vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y
Date:   Fri, 29 Jan 2021 17:25:58 -0700
Message-Id: <20210130002557.2681512-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129201116.2658179-1-nathan@kernel.org>
References: <20210129201116.2658179-1-nathan@kernel.org>
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
Reviewed-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2:

* Keep configs and flag names alphabetized.

* Drop mention of -ftest-coverage since it does not cause this issue per
  Fangrui.

* Pick up review tags from Fangrui and Nick.

 include/asm-generic/vmlinux.lds.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..0e6c5da667a7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -988,12 +988,13 @@
 #endif
 
 /*
- * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
- * unwanted sections (.eh_frame and .init_array.*), but
- * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * Clang's -fprofile-arcs, -fsanitize=kernel-address, and
+ * -fsanitize=thread produce unwanted unwanted sections
+ * (.eh_frame and .init_array.*), but CONFIG_CONSTRUCTORS
+ * wants to keep any .init_array.* sections.
  * https://bugs.llvm.org/show_bug.cgi?id=46478
  */
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
+#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
 # ifdef CONFIG_CONSTRUCTORS
 #  define SANITIZER_DISCARDS						\
 	*(.eh_frame)

base-commit: bec4c2968fce2f44ce62d05288a633cd99a722eb
-- 
2.30.0

