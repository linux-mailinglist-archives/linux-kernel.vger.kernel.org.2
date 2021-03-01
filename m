Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D032828E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbhCAPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:33:25 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:41514 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhCAPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:33:19 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 121FUTYP004032;
        Tue, 2 Mar 2021 00:30:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 121FUTYP004032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614612631;
        bh=m5BEroMGeIUiadj/RSTW31YN9SmSSZvY3G0oo0FkkdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6JDGDqvHM3semXwXDeIqSufTvNdwP6Ib9PK9lX4w/t8yETP304reQ0M0Ck8QZjSF
         clJdT7C1Eo5YDRqIeDd6dm8tnFg4ELheu9N0PUstlFJeQU0CuyHJGUGEcCDtzk5lJS
         HFjFUVSXlpy/I/HSrIee+dgOBIhTYEr0ff9MZ6r5oLG0O26Ry7FXEGXKc0ymczdIAI
         NAFKLS5grheoejWXjvVMFtedbF9Mln6wD9pHtYCpgCMvVsUxxff+SkC2PXncqJlz+k
         C1/5tbHdYE9jaQ0WQn8FU6r5cHZ12tyjLDnEjNCxnEDhIdv2J1D2tK6w8FEGNzWn1f
         2zjuHYVcprjrg==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH 2/2] powerpc: syscalls: switch to generic syscallhdr.sh
Date:   Tue,  2 Mar 2021 00:30:19 +0900
Message-Id: <20210301153019.362742-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301153019.362742-1-masahiroy@kernel.org>
References: <20210301153019.362742-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts powerpc to use scripts/syscallhdr.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/syscalls/Makefile      | 11 +++----
 arch/powerpc/kernel/syscalls/syscallhdr.sh | 36 ----------------------
 2 files changed, 4 insertions(+), 43 deletions(-)
 delete mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh

diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index df21c731c806..5476f62eb80f 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
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
 
-syshdr_abis_unistd_32 := common,nospu,32
+$(uapi)/unistd_32.h: abis := common,nospu,32
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abis_unistd_64 := common,nospu,64
+$(uapi)/unistd_64.h: abis := common,nospu,64
 $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
diff --git a/arch/powerpc/kernel/syscalls/syscallhdr.sh b/arch/powerpc/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index 02d6751f3be3..000000000000
--- a/arch/powerpc/kernel/syscalls/syscallhdr.sh
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
-fileguard=_UAPI_ASM_POWERPC_`basename "$out" | sed \
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

