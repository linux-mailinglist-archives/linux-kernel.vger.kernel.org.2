Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3E3280BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhCAO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:26:18 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:53069 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCAOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:24:35 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 121ENDK1023474;
        Mon, 1 Mar 2021 23:23:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 121ENDK1023474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614608594;
        bh=pwN6B0avyTtmWYmIHo/2BdqiXttVnbVWwKhtfhmAs8c=;
        h=From:To:Cc:Subject:Date:From;
        b=fmg7lN5IHbTOPN1je/VSAEc1PWIKjDwGdQ8YnMZLaRPUqfdWtLwAKmZ0jt7gUGwgn
         BhSfQgMZJarp/dJWXo6u/EmHoKZd7W4taZJtnaAZgxBFPrFYE/vj1UoS3Jpns7F3zP
         RjmDeMKKoZRKCRxAZX6jwyOwCpvziUfuBW8S0Q3rgml+mqwEJy34tt0AklIWTOVmii
         BT8ZnS9MOgxK9HvvQh7vvsnTKjJ+vjrAc5BpUcc5bp1SI8Eqm88SQ3fYaQwr8JVorb
         felSuLvPvE1opBY558QMqji/PILXKhcVlvrCR2tToCXMT4g8w9lc9ZqfOX2q211afz
         zkLkP8fL2Dr6w==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] microblaze: syscalls: switch to generic syscalltbl.sh
Date:   Mon,  1 Mar 2021 23:23:02 +0900
Message-Id: <20210301142303.343727-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts microblaze to use scripts/syscalltbl.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/microblaze/kernel/syscall_table.S        |  3 +-
 arch/microblaze/kernel/syscalls/Makefile      |  7 ++--
 arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 -------------------
 3 files changed, 3 insertions(+), 39 deletions(-)
 delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

diff --git a/arch/microblaze/kernel/syscall_table.S b/arch/microblaze/kernel/syscall_table.S
index ce006646f741..3bc60a2b159e 100644
--- a/arch/microblaze/kernel/syscall_table.S
+++ b/arch/microblaze/kernel/syscall_table.S
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry) .long entry
 ENTRY(sys_call_table)
 #include <asm/syscall_table.h>
-#undef __SYSCALL
diff --git a/arch/microblaze/kernel/syscalls/Makefile b/arch/microblaze/kernel/syscalls/Makefile
index 285aaba832d9..ad2492cb5568 100644
--- a/arch/microblaze/kernel/syscalls/Makefile
+++ b/arch/microblaze/kernel/syscalls/Makefile
@@ -7,7 +7,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
@@ -16,10 +16,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_offset_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
-		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
 
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
diff --git a/arch/microblaze/kernel/syscalls/syscalltbl.sh b/arch/microblaze/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 85d78d9309ad..000000000000
--- a/arch/microblaze/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-my_abi="$4"
-offset="$5"
-
-emit() {
-	t_nxt="$1"
-	t_nr="$2"
-	t_entry="$3"
-
-	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
-}
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
-
-	while read nr abi name entry ; do
-		emit $((nxt+offset)) $((nr+offset)) $entry
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
2.27.0

