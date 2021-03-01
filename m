Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899C9327F49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhCANSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:18:51 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:37088 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhCANSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:18:15 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121DFe7Y026106;
        Mon, 1 Mar 2021 22:15:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121DFe7Y026106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614604549;
        bh=2ggi49J0VZ1wo+bPnkXyf73MnfKaviktx3ill4o72ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YoQ06BfjKTJ8ZcKx8aU3LmjGw/XCQulMqLRDBWvCheJ/+6/4orv6dCt/h2jtAyd3X
         aLvMUcVgQV3yx+1l43ggd3UZZYIuYdMrJjY1P8s1ENq0QNiJVW9PmmLkRKzSz2zj5E
         PgAdcKatOe0HdGWbti1dzzLvOApyHcNgrP5TTbtb9m+A2jd2I739qUBn8wlK5+7/wL
         a7YN901rhSAWFra3smCfrpALZ+ANvNkROv/zfBXc2cZCX6+EOMI4mKO+TZHG2tNpK9
         qxEMTUazSAzlAiGDpZLcYyAzWolMBX7gtcs48iB4Y4TW8OEEFra43SDnQLC50+dj4C
         iE0BX7qjiLozg==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 7/7] x86/syscalls: switch to generic syscallhdr.sh
Date:   Mon,  1 Mar 2021 22:15:32 +0900
Message-Id: <20210301131533.64671-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301131533.64671-1-masahiroy@kernel.org>
References: <20210301131533.64671-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts x86 to use scripts/syscallhdr.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/syscalls/Makefile      | 26 ++++++++++----------
 arch/x86/entry/syscalls/syscallhdr.sh | 35 ---------------------------
 2 files changed, 13 insertions(+), 48 deletions(-)
 delete mode 100644 arch/x86/entry/syscalls/syscallhdr.sh

diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index c4bd8dd82bb1..8eb014bca8c9 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -9,40 +9,40 @@ _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)') \
 syscall32 := $(src)/syscall_32.tbl
 syscall64 := $(src)/syscall_64.tbl
 
-syshdr := $(srctree)/$(src)/syscallhdr.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
-		   '$(syshdr_abi_$(basetarget))' \
-		   '$(syshdr_pfx_$(basetarget))' \
-		   '$(syshdr_offset_$(basetarget))'
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis) --emit-nr \
+		$(if $(offset),--offset $(offset)) \
+		$(if $(prefix),--prefix $(prefix)) \
+		$< $@
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
 quiet_cmd_hypercalls = HYPERCALLS $@
       cmd_hypercalls = $(CONFIG_SHELL) '$<' $@ $(filter-out $<, $(real-prereqs))
 
-syshdr_abi_unistd_32 := i386
+$(uapi)/unistd_32.h: abis := i386
 $(uapi)/unistd_32.h: $(syscall32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_32_ia32 := i386
-syshdr_pfx_unistd_32_ia32 := ia32_
+$(out)/unistd_32_ia32.h: abis := i386
+$(out)/unistd_32_ia32.h: prefix := ia32_
 $(out)/unistd_32_ia32.h: $(syscall32) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_x32 := common,x32
-syshdr_offset_unistd_x32 := __X32_SYSCALL_BIT
+$(uapi)/unistd_x32.h: abis := common,x32
+$(uapi)/unistd_x32.h: offset := __X32_SYSCALL_BIT
 $(uapi)/unistd_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_64 := common,64
+$(uapi)/unistd_64.h: abis := common,64
 $(uapi)/unistd_64.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd_64_x32 := x32
-syshdr_pfx_unistd_64_x32 := x32_
+$(out)/unistd_64_x32.h: abis := x32
+$(out)/unistd_64_x32.h: prefix := x32_
 $(out)/unistd_64_x32.h: $(syscall64) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
diff --git a/arch/x86/entry/syscalls/syscallhdr.sh b/arch/x86/entry/syscalls/syscallhdr.sh
deleted file mode 100644
index 75e66af06773..000000000000
--- a/arch/x86/entry/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_ASM_X86_`basename "$out" | sed \
-    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-    echo "#ifndef ${fileguard}"
-    echo "#define ${fileguard} 1"
-    echo ""
-
-    max=0
-    while read nr abi name entry ; do
-	if [ -z "$offset" ]; then
-	    echo "#define __NR_${prefix}${name} $nr"
-	else
-	    echo "#define __NR_${prefix}${name} ($offset + $nr)"
-        fi
-
-	max=$nr
-    done
-
-    echo ""
-    echo "#ifdef __KERNEL__"
-    echo "#define __NR_${prefix}syscalls $(($max + 1))"
-    echo "#endif"
-    echo ""
-    echo "#endif /* ${fileguard} */"
-) > "$out"
-- 
2.27.0

