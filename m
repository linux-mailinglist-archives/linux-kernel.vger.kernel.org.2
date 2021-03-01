Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914C232816D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhCAOxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:53:43 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:51173 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbhCAOw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:52:59 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121Ep9LT003511;
        Mon, 1 Mar 2021 23:51:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121Ep9LT003511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614610271;
        bh=W78l10suX8MoXynQ8dMjtmAO598pNUKAVWNuxNc7ZAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJAANXk2BKR3SWBmWyfSjZv08FIIibO5fIngG1gz30DEcYtfScFYPN4qn/3JUgFgJ
         jdumD7mhdWJJRrxjDVGOOiwEBUJt6yTL4h+8JeAkQb9B5aTWNFqKYIslnLMSehvLLd
         toRSDLQlF0B2bRtkEEccgb3/F71ydRLVm2pkithPOS1D+NiRNNUSF/LBOS5viGEq2I
         9wjz9Vp2E3yp8g4UNt9vr6kdEqghrDu7FwHVpfogOveuB5z5A7riybmHv1/Eggogsv
         i4n2A+2RkOawS9Tjgk+TQM3ga6eCn9tnFoF85zbvkC6gfBYXfS10C2H5YB+kwI3ro6
         NoMEMJMaHOI+Q==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH 2/2] sparc: syscalls: switch to generic syscallshdr.sh
Date:   Mon,  1 Mar 2021 23:51:02 +0900
Message-Id: <20210301145102.358960-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301145102.358960-1-masahiroy@kernel.org>
References: <20210301145102.358960-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts sparc to use scripts/syscallhdr.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/kernel/syscalls/Makefile      | 11 +++-----
 arch/sparc/kernel/syscalls/syscallhdr.sh | 36 ------------------------
 2 files changed, 4 insertions(+), 43 deletions(-)
 delete mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh

diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/syscalls/Makefile
index 11424f1c8d9e..0f2ea5bcb0d7 100644
--- a/arch/sparc/kernel/syscalls/Makefile
+++ b/arch/sparc/kernel/syscalls/Makefile
@@ -6,23 +6,20 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
 syscall := $(src)/syscall.tbl
-syshdr := $(srctree)/$(src)/syscallhdr.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
-		   '$(syshdr_abis_$(basetarget))'		\
-		   '$(syshdr_pfx_$(basetarget))'		\
-		   '$(syshdr_offset_$(basetarget))'
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis $(abis) $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
 
-syshdr_abis_unistd_32 := common,32
+$(uapi)/unistd_32.h: abis := common,32
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abis_unistd_64 := common,64
+$(uapi)/unistd_64.h: abis := common,64
 $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
diff --git a/arch/sparc/kernel/syscalls/syscallhdr.sh b/arch/sparc/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index cf50a75cc0bb..000000000000
--- a/arch/sparc/kernel/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_UAPI_ASM_SPARC_`basename "$out" | sed \
-	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	printf "#ifndef %s\n" "${fileguard}"
-	printf "#define %s\n" "${fileguard}"
-	printf "\n"
-
-	nxt=0
-	while read nr abi name entry compat ; do
-		if [ -z "$offset" ]; then
-			printf "#define __NR_%s%s\t%s\n" \
-				"${prefix}" "${name}" "${nr}"
-		else
-			printf "#define __NR_%s%s\t(%s + %s)\n" \
-				"${prefix}" "${name}" "${offset}" "${nr}"
-		fi
-		nxt=$((nr+1))
-	done
-
-	printf "\n"
-	printf "#ifdef __KERNEL__\n"
-	printf "#define __NR_syscalls\t%s\n" "${nxt}"
-	printf "#endif\n"
-	printf "\n"
-	printf "#endif /* %s */\n" "${fileguard}"
-) > "$out"
-- 
2.27.0

