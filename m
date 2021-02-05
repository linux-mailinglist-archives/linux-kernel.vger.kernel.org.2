Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007FF311389
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhBEV2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:28:07 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:52150 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232802AbhBEPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:00:32 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.69.177;
Received: from build.alporthouse.com (unverified [78.156.69.177]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 23800349-1500050 
        for multiple; Fri, 05 Feb 2021 16:38:03 +0000
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] kernel: Expose SYS_kcmp by default
Date:   Fri,  5 Feb 2021 16:37:52 +0000
Message-Id: <20210205163752.11932-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace has discovered the functionality offered by SYS_kcmp and has
started to depend upon it. In particular, Mesa uses SYS_kcmp for
os_same_file_description() in order to identify when two fd (e.g. device
or dmabuf) point to the same struct file. Since they depend on it for
core functionality, lift SYS_kcmp out of the non-default
CONFIG_CHECKPOINT_RESTORE into the selectable syscall category.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>
---
 init/Kconfig                                  | 11 +++++++++++
 kernel/Makefile                               |  2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index b77c60f8b963..f62fca13ac5b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1194,6 +1194,7 @@ endif # NAMESPACES
 config CHECKPOINT_RESTORE
 	bool "Checkpoint/restore support"
 	select PROC_CHILDREN
+	select KCMP
 	default n
 	help
 	  Enables additional kernel features in a sake of checkpoint/restore.
@@ -1737,6 +1738,16 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
+config KCMP
+	bool "Enable kcmp() system call" if EXPERT
+	default y
+	help
+	  Enable the file descriptor comparison system call. It provides
+	  user-space with the ability to compare two fd to see if they
+	  point to the same file, and check other attributes.
+
+	  If unsure, say Y.
+
 config RSEQ
 	bool "Enable rseq() system call" if EXPERT
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index aa7368c7eabf..320f1f3941b7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -51,7 +51,7 @@ obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
 
-obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
+obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
 obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 26c72f2b61b1..1b6c7d33c4ff 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -315,7 +315,7 @@ TEST(kcmp)
 	ret = __filecmp(getpid(), getpid(), 1, 1);
 	EXPECT_EQ(ret, 0);
 	if (ret != 0 && errno == ENOSYS)
-		SKIP(return, "Kernel does not support kcmp() (missing CONFIG_CHECKPOINT_RESTORE?)");
+		SKIP(return, "Kernel does not support kcmp() (missing CONFIG_KCMP?)");
 }
 
 TEST(mode_strict_support)
-- 
2.20.1

