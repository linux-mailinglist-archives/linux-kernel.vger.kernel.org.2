Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F47323AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhBXLFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:05:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39642 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234963AbhBXLDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:20 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 244A61EC05A0;
        Wed, 24 Feb 2021 12:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rga5epFagvpVBhbvM1F4tdaeKAILbreYR0KNXNLWFBY=;
        b=rMziyCZLEHRsnIjtF1uR9EqjwWd0mGmm+I0o5pNgzLU8YqgCDy3bKT6kqT27x2UxVpp+jy
        sKtZyp1TYSBdbB4BjzKrfjkxEepKhLKoLFBUgd4WqAXTviN+khc+3RZhlRFzDxoRystZe8
        ZF6Pf8XM044zdMRs1HGtmwgK4qWcIVM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/21] x86/insn: Add a __ignore_sync_check__ marker
Date:   Wed, 24 Feb 2021 12:02:15 +0100
Message-Id: <20210224110233.19715-4-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add an explicit __ignore_sync_check__ marker which will be used to mark
lines which are supposed to be ignored by file synchronization check
scripts, its advantage being that it explicitly denotes such lines in
the code.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/inat.h       |  2 +-
 arch/x86/include/asm/insn.h       |  2 +-
 arch/x86/lib/inat.c               |  2 +-
 arch/x86/lib/insn.c               |  6 +++---
 tools/arch/x86/include/asm/inat.h |  2 +-
 tools/arch/x86/include/asm/insn.h |  2 +-
 tools/arch/x86/lib/inat.c         |  2 +-
 tools/arch/x86/lib/insn.c         |  6 +++---
 tools/objtool/sync-check.sh       | 17 +++++++++++++----
 tools/perf/check-headers.sh       | 15 +++++++++++----
 10 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 4cf2ad521f65..b56c5741581a 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/inat_types.h>
+#include <asm/inat_types.h> /* __ignore_sync_check__ */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index a8c3d284fa46..17c130f1ba57 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include <asm/inat.h>
+#include <asm/inat.h> /* __ignore_sync_check__ */
 
 struct insn_field {
 	union {
diff --git a/arch/x86/lib/inat.c b/arch/x86/lib/inat.c
index 12539fca75c4..b0f3b2a62ae2 100644
--- a/arch/x86/lib/inat.c
+++ b/arch/x86/lib/inat.c
@@ -4,7 +4,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/insn.h>
+#include <asm/insn.h> /* __ignore_sync_check__ */
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 1ba994862b56..745c704f7c78 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -10,10 +10,10 @@
 #else
 #include <string.h>
 #endif
-#include <asm/inat.h>
-#include <asm/insn.h>
+#include <asm/inat.h> /*__ignore_sync_check__ */
+#include <asm/insn.h> /* __ignore_sync_check__ */
 
-#include <asm/emulate_prefix.h>
+#include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 877827b7c2c3..a61051400311 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include "inat_types.h"
+#include "inat_types.h" /* __ignore_sync_check__ */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 52c6262e6bfd..33d41982a5dd 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -8,7 +8,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include "inat.h"
+#include "inat.h" /* __ignore_sync_check__ */
 
 struct insn_field {
 	union {
diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
index 4f5ed49e1b4e..dfbcc6405941 100644
--- a/tools/arch/x86/lib/inat.c
+++ b/tools/arch/x86/lib/inat.c
@@ -4,7 +4,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include "../include/asm/insn.h"
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index f3277d6e4ef2..dedcfd67f90c 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -10,10 +10,10 @@
 #else
 #include <string.h>
 #endif
-#include "../include/asm/inat.h"
-#include "../include/asm/insn.h"
+#include "../include/asm/inat.h" /* __ignore_sync_check__ */
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
-#include "../include/asm/emulate_prefix.h"
+#include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 606a4b5e929f..4bbabaecab14 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -16,11 +16,14 @@ arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 include/linux/static_call_types.h
-arch/x86/include/asm/inat.h     -I '^#include [\"<]\(asm/\)*inat_types.h[\">]'
-arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
-arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
-arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+
+SYNC_CHECK_FILES='
+arch/x86/include/asm/inat.h
+arch/x86/include/asm/insn.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+'
 fi
 
 check_2 () {
@@ -63,3 +66,9 @@ while read -r file_entry; do
 done <<EOF
 $FILES
 EOF
+
+if [ "$SRCARCH" = "x86" ]; then
+	for i in $SYNC_CHECK_FILES; do
+		check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+	done
+fi
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index dded93a2bc89..07857dfb4d91 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -75,6 +75,13 @@ include/uapi/asm-generic/mman-common.h
 include/uapi/asm-generic/unistd.h
 '
 
+SYNC_CHECK_FILES='
+arch/x86/include/asm/inat.h
+arch/x86/include/asm/insn.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+'
+
 # These copies are under tools/perf/trace/beauty/ as they are not used to in
 # building object files only by scripts in tools/perf/trace/beauty/ to generate
 # tables that then gets included in .c files for things like id->string syscall
@@ -129,6 +136,10 @@ for i in $FILES; do
   check $i -B
 done
 
+for i in $SYNC_CHECK_FILES; do
+  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+done
+
 # diff with extra ignore lines
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
@@ -137,10 +148,6 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
-check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
-check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
-check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
-- 
2.29.2

