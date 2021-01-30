Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E828430912D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 02:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhA3BJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 20:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233039AbhA3A67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:58:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AA4864E0C;
        Sat, 30 Jan 2021 00:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611967661;
        bh=4MU9n3dKEMA3J95RMUATsgBTduGFFuZ1jKrLeN0z26k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjfiNCTjFu6a2QGTO1XaxD0YhiaaEFNkCbj16zbpFDTVRZc+r/tBJnC1Nv1RkGNPB
         mTRpo7FEr27AODBSEc3m0w8lFVjr6ZoYeUPuYOqWHP2IQSJNPkelqtPrNafZFosGtP
         Dn+MxRK0J8YnDhSAzALpWL5zAlnFy++e4RMrcruLXB4NKLX3310GZf7NRYNzi0JGqv
         sKBAe26UgAaF0NPXP5Oy2/zXES6Y0PZXnJ5eI28RXClgypmEIqbliVHLaOgAGEA45K
         yYxN7MAqwg21X1TVS3SHGdauuc11zf0MW/KY+R/Kz9UDv/o3Ypvl3CvOrzPyWIICsQ
         ezZgnUuc67Iog==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Fangrui Song <maskray@google.com>
Subject: [PATCH v3] vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y
Date:   Fri, 29 Jan 2021 17:46:51 -0700
Message-Id: <20210130004650.2682422-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002557.2681512-1-nathan@kernel.org>
References: <20210130002557.2681512-1-nathan@kernel.org>
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

v2 -> v3:

* Fix double "unwanted" in comment section per Sedat.

v1 -> v2:

* Keep configs and flag names alphabetized.

* Drop mention of -ftest-coverage since it does not cause this issue per
  Fangrui.

* Pick up review tags from Fangrui and Nick.

 include/asm-generic/vmlinux.lds.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..b61b537177fb 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -988,12 +988,13 @@
 #endif
 
 /*
- * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
- * unwanted sections (.eh_frame and .init_array.*), but
- * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * Clang's -fprofile-arcs, -fsanitize=kernel-address, and
+ * -fsanitize=thread produce unwanted sections (.eh_frame
+ * and .init_array.*), but CONFIG_CONSTRUCTORS wants to
+ * keep any .init_array.* sections.
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

