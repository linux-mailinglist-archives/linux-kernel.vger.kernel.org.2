Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2942337B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhJEW3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJEW3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:29:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA022C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:27:51 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id n9-20020a63f809000000b0026930ed1b24so371482pgh.23
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=o49cNReT7tbfFW4OkGuUsna7W/I8mcpECmrtMrISc18=;
        b=Vxl/bf+LUXZC1//yKKpG9OYg0qf5nGN2uy9H995MvZr27pbAnrcs/IusJVn7bevmGl
         lRhar8aAR3BQ6JjR7xfadGcRbfCkr+s8OrApuB88P3N9mdEcO0s/ug3JRjSk7aWZtcXC
         TZdE5pNclMlQ6174hiy4cOsoTu5ZT4WHuWYlfip4GnjZb3BvBZg8t6hKTXlK4GSeSxKv
         nH4lVAfvgW/RX+738gkk2W91EO57rXPlblGvLYB6P5P7yMiUKUv8w/4ObO9CnU88pQO2
         ADuwkTMXbZy4v2QXP8cFkMg4SvfozGVDys7krlO+dTCAUN1nKu7v2+4c57r6LlslZSJ6
         PsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=o49cNReT7tbfFW4OkGuUsna7W/I8mcpECmrtMrISc18=;
        b=EuY4n046EV5QYurfX+gZLOfzpTyUe7/z3zCLa1RjUaHbCp8pb0i4QX4VaDSKRSbT5n
         NX8l6XZCCXBqiwqwJ92awWZ077gmmjaba1dNuNvACRPDAFE69S/+jFnnHNV6LDuIVDmY
         vE3+Ol2K5u0LDP6zRR8LRDXBr/vgHeV3IcVFIf8s2/B23TWaEdCaUY0478uG3qr0qoa6
         PL52InA48DmkJGR9mvQK56a1tQO9gxfUTwJjrV3rQUpBEYjm8d2kNtIVEgngSAPnQhnQ
         z1hQEXrk3XKBxGY/ObsUUXefd6soVMusnosYA9X8blvFo3yjwyQsdhK32lgWJnF+dyhi
         xK5g==
X-Gm-Message-State: AOAM530RzaN4mgroUNcyxuIMpR5YKXd7TTmf9OxrurrAV7cfDu32UWwh
        NIFxdJrQxbK0XTbHu89y8tGaVd5p8w==
X-Google-Smtp-Source: ABdhPJzbzhJQMhlmNALwq8tGwon8ljqHAnXSC6vZyy7SapyV65Y9SnCSQz+1SuSxo4rCKpETTMZCCfi60g==
X-Received: from adelg-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d1f])
 (user=adelg job=sendgmr) by 2002:a62:5fc6:0:b0:44c:591a:5bf6 with SMTP id
 t189-20020a625fc6000000b0044c591a5bf6mr15037342pfb.36.1633472871291; Tue, 05
 Oct 2021 15:27:51 -0700 (PDT)
Date:   Tue,  5 Oct 2021 22:27:39 +0000
Message-Id: <20211005222739.2491124-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2] selftests: Include directories of header files
From:   Andrew Delgadilo <adelg@google.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, gthelen@google.com,
        Andrew Delgadillo <adelg@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Delgadillo <adelg@google.com>

clang complains about using -o when one specifies header files on the
commandline. An example can be seen when building the futex selftests:

$ make -C tools/testing/selftests TARGETS=futex
clang -Wall   -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include \
-I../../ -I../../../../../usr/include/ -I/kselftest/usr/include \
futex_wait_timeout.c ../include/futextest.h ../include/atomic.h \
../include/logging.h -lpthread -lrt -o \
tools/testing/selftests/futex/functional/futex_wait_timeout
clang: error: cannot specify -o when generating multiple output files

To fix this, instead of specifying the headers explicitliy, we include
(with -I) their directories. Note that -I does not work with files, only
directories [1,2]

There are still errors when building with clang, but this patch does a
way with one class of those errors.

Tested: No new errors when building with LLVM=0/1. In fact, clang no
longer errors out with "cannot specify -o ..." anymore.

[1] https://gcc.gnu.org/onlinedocs/gcc-11.2.0/gcc/Directory-Options.html#Directory-Options
[2] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-i-dir

Suggested-by: gthelen@google.com
Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
Changes since v1:
- Instead of removing the headers from the cmdline altogether, include
  their directories.
- Add more detail to the tested tag.
- Add missing Suggested-By tag from original patch.

 tools/testing/selftests/filesystems/binderfs/Makefile | 4 ++--
 tools/testing/selftests/lib.mk                        | 5 ++++-
 tools/testing/selftests/x86/Makefile                  | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index 8af25ae96049..e2f09acb15b4 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I../../../../../usr/include/ -pthread
+CFLAGS += -I../../../../../usr/include/ -I$(selfdir) -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
+binderfs_test: binderfs_test.c
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index fa2ac0e56b43..0edf2a421771 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -137,12 +137,15 @@ COMPILE.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
 LINK.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 endif
 
+
 # Selftest makefiles can override those targets by setting
 # OVERRIDE_TARGETS = 1.
 ifeq ($(OVERRIDE_TARGETS),)
 LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
 $(OUTPUT)/%:%.c $(LOCAL_HDRS)
-	$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
+	$(LINK.c) $(filter-out %.h,$^) \
+		$(addprefix -I,$(dir $(filter %.h,$^))) \
+			$(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
 	$(COMPILE.S) $^ -o $@
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index b4142cd1c5c2..f794d431f289 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -72,10 +72,10 @@ all_64: $(BINARIES_64)
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
-	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
+	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h,$^) $(addprefix -I,$(dir $(filter %.h,$^))) -lrt -ldl -lm
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h,$^) $(addprefix -I,$(dir $(filter %.h,$^))) -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
-- 
2.33.0.800.g4c38ced690-goog

