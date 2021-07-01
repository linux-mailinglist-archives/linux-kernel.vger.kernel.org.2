Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2737B3B96EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhGAUI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhGAUIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:08:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B5C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 13:06:23 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d24-20020a05620a1378b02903b477b3922bso721706qkl.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Zm3VMH16iGKr7rpa1UnB4+yqcdqybw2ZiN/OuZmenR0=;
        b=rjmNK8L6t1QnCy05qXiWRCzBMnT7LO5Qv33Nix7wHo1LC/Yi4OI3FBgZfUFm0azIvF
         uTom4hnh6KdA3gb1DTWnKLbn+k1Al3oTBLWsdB68EdPrZmtyis1WLwTuipHLmaA28NtW
         KmVN4Xox1vJQ/kcuexkboK+83m2bqx/+pLsf8VOPH03Yq4mlNLCJ6cEJR0589xbCV2Pl
         YiGCAdyGirIFi4kl8LuBUyjU14MJy8VWumFfDMhYVXJuJBff88RFpBm02n5uAurIK9Xg
         8DK64WdOAYcaj+s75mfM9/hrabPtwDQxLRYlSdQEiI29eLjlj2UY6czl8sNdfy+ue9TT
         UTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Zm3VMH16iGKr7rpa1UnB4+yqcdqybw2ZiN/OuZmenR0=;
        b=GPdSbvSPaoGw8BPq4nSxJmpgldj+d6NXZVyGha7oCWjJVj4LZvwJkIC3/7AtJ9icN9
         ApZiiXn0Ts1yUhqq6aho1HK63Gidzx2Pc5dWRCj66b0jjMZoWN2yMTt6hGpvTGIJ0rYA
         HqTfJ0WhkRzYwRgG39U7QPQUu8mvkdfREeHQKeGdU5ILS5JkwTFSw/hW6aUmUPVqiddq
         +PlDYQ8yjh/ubPsj8KFI7ineuSgjxRBI8dGTRpPjijO7Qd/jjR5tgXMTiOMabMHfp1YE
         psNBxoGojxvLwXKFPQrd17a84eZAvP8qbeXoVEU2ObMuFTkNDNGP9nzobBGwTDzFgTEE
         w2kA==
X-Gm-Message-State: AOAM531SkBQCgaKwlQ22ukYt3yLCxdxMsTcMTk2/rd0qm1oY7493i/6Q
        i9RwOKr8ILbXDxTeoHAxEkCyLpO2cho/iA==
X-Google-Smtp-Source: ABdhPJyRzyYf+smvmr8BOc/VQwHIxtG/UtnR/gtz6WquYYVYLA5f5ltAf6CNYpHP6jsAO4BBQUigZVl2QAEJeQ==
X-Received: from abdulras.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:41e1])
 (user=abdulras job=sendgmr) by 2002:a05:6214:76c:: with SMTP id
 f12mr1644705qvz.3.1625169982626; Thu, 01 Jul 2021 13:06:22 -0700 (PDT)
Date:   Thu,  1 Jul 2021 20:05:47 +0000
Message-Id: <20210701200547.355742-1-abdulras@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] riscv: allow building the kernel with medany and lld
From:   Saleem Abdulrasool <abdulras@google.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux@googlegroups.com,
        Saleem Abdulrasool <abdulras@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of the `__rt_sigaction` reference computed an
absolute offset relative to the mapped base of the VDSO.  While this can
be handled in the medlow model, the medany model cannot handle this as
it is meant to be position independent.  The current implementation
relied on the BFD linker relaxing the pc-relative relocation into an
absolute relocation as it was a near-zero address allowing it to be
referenced relative to `zero`.  The constant offsets relative to the
image base should be just that - constants.  However, this takes a
slightly more tricky approach of rebasing the address against the text
base (`PAGE_OFFSET`) and then accounting for the image base at runtime
to allow us to compute the VDSO relative address for the stub function.
This allows the symbolic resolution to remain within the range of the
pc-relative relocation, allowing the kernel to build with LLVM/lld.

Thanks to Palmer Dabbelt for his assistance with this!

Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
---
 arch/riscv/include/asm/vdso.h   | 2 +-
 arch/riscv/kernel/vdso/Makefile | 2 +-
 arch/riscv/kernel/vdso/so2s.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 1453a2f563bc..1240d3790abf 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -26,7 +26,7 @@ struct vdso_data {
 #define VDSO_SYMBOL(base, name)							\
 ({										\
 	extern const char __vdso_##name[];					\
-	(void __user *)((unsigned long)(base) + __vdso_##name);			\
+	(void __user *)((unsigned long)(base) + __vdso_##name - PAGE_OFFSET);	\
 })
 
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 24d936c147cd..384f1cc8e044 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -68,7 +68,7 @@ quiet_cmd_vdsold = VDSOLD  $@
 # Extracts symbol offsets from the VDSO, converting them into an assembly file
 # that contains the same symbols at the same offsets.
 quiet_cmd_so2s = SO2S    $@
-      cmd_so2s = $(NM) -D $< | $(srctree)/$(src)/so2s.sh > $@
+      cmd_so2s = $(NM) -D $< | $(srctree)/$(src)/so2s.sh $(CONFIG_PAGE_OFFSET) > $@
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/riscv/kernel/vdso/so2s.sh b/arch/riscv/kernel/vdso/so2s.sh
index e64cb6d9440e..9e5afc2fcc07 100755
--- a/arch/riscv/kernel/vdso/so2s.sh
+++ b/arch/riscv/kernel/vdso/so2s.sh
@@ -2,5 +2,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright 2020 Palmer Dabbelt <palmerdabbelt@google.com>
 
-sed 's!\([0-9a-f]*\) T \([a-z0-9_]*\)\(@@LINUX_4.15\)*!.global \2\n.set \2,0x\1!' \
+sed 's!\([0-9a-f]*\) T \([a-z0-9_]*\)\(@@LINUX_4.15\)*!.global \2\n.set \2,'${1}'+0x\1!' \
 | grep '^\.'
-- 
2.32.0.93.g670b81a890-goog

