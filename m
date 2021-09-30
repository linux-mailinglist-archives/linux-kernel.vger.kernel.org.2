Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8D41E093
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353042AbhI3SHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353007AbhI3SHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6DC06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w11-20020a25ef4b000000b005b7151afcc4so1951056ybm.22
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Bgjsb/aFIkQSrBisCHUYv6SIuQmEnOivW87M1Xcmdk=;
        b=s0beKCqxZCrTzjfSpjjhqmcXy69zfpSvJZh6o5GNgcM7uZ+AeqtB2GWSr7r195f1rK
         VZ/B+6UwrM+mpMRnK9345tRnKs/YgbEAZ9eOsJNJfk6wUEJ90MUZV+kfc3tj4eTaxLOa
         kXHyqrh0xzdYEclp3Nm6OAFz0RjI/UPdG/tI8wpaG6YAY0EO/TCH4wUmOFDrXfj7t5Fz
         lsuvqjkL7pjJ/SIX0nrZVGPhr1o7LWxyJR++PqBbXm1Nz8UhjtglXISZqOi6H+M5mqkg
         nkK6xeNJ2N4Ikm9NMPJx3jXCpgZd7KGG1eIiwC3+fClS8JUDOLOX1Bo3z7R6uQLhFRFK
         YrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Bgjsb/aFIkQSrBisCHUYv6SIuQmEnOivW87M1Xcmdk=;
        b=qCME8Mjkj9kwi4HZKKkhSR68hJ/3+CjNXnl3cSDFmoeb3X74GJFgLxHFfeZSn506xT
         iWPyzolnmXYS0F3N/n9XHdl6ikTZHy86Q6kbbojx17qaX676ZOhWkL/DvUN4lbE5PtAp
         gJP4hSP9Dm4bkybtrqI8w+OzlU88xMtxn2UmDEgmfpPetkZ7vRxExF7qy+Ce+a4IwyIc
         Mzx4dBy9gvffIBNzHC6Vw/06Fg6/OpBPZlr00MT0dkltBtC+/ncIL+7c5K31OdrlR5EG
         4KuXZyw703oZ4rJUiUwx/2YOdvElxTVtQvVVC8Wxb3sTOgwvic2R48uSfEky27UDgwUS
         yE7Q==
X-Gm-Message-State: AOAM533i5TS/Iay4pnG1gs4tmjQBV+Ng+jpVC8/p+77g2uI6V8mf5ipH
        kXDol2PZTCKNrwo58pqQdRcj8AuzdCSe4fl4N1E=
X-Google-Smtp-Source: ABdhPJwMUV55QPso5VdV9CHYlDd3r2gw61pUnbXkeOQ8hmaSknJheUch0PSQN+nbLOJkSRKUdHc28TAc0FWFceGTOrI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a5b:1c4:: with SMTP id
 f4mr677911ybp.47.1633025137173; Thu, 30 Sep 2021 11:05:37 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:17 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 01/15] objtool: Add CONFIG_CFI_CLANG support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function references with
references to the CFI jump table, which confuses objtool. This change,
based on Josh's initial patch [1], goes through the list of relocations
and replaces jump table symbols with the actual function symbols.

[1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/arch/x86/decode.c      | 17 ++++++++++
 tools/objtool/elf.c                  | 51 ++++++++++++++++++++++++++++
 tools/objtool/include/objtool/arch.h |  3 ++
 tools/objtool/include/objtool/elf.h  |  2 +-
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3172983bf808..9b043220b0af 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -63,6 +63,23 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
+unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc)
+{
+	if (!reloc->addend)
+		return 0;
+
+	if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+		return reloc->addend + 4;
+
+	return reloc->addend;
+}
+
+unsigned long arch_cfi_jump_reloc_offset(unsigned long offset)
+{
+	/* offset to the relocation in a jmp instruction */
+	return offset + 1;
+}
+
 unsigned long arch_dest_reloc_offset(int addend)
 {
 	return addend + 4;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8676c7598728..05a5f51aad2c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -18,6 +18,7 @@
 #include <errno.h>
 #include <objtool/builtin.h>
 
+#include <objtool/arch.h>
 #include <objtool/elf.h>
 #include <objtool/warn.h>
 
@@ -291,6 +292,10 @@ static int read_sections(struct elf *elf)
 		if (sec->sh.sh_flags & SHF_EXECINSTR)
 			elf->text_size += sec->len;
 
+		/* Detect -fsanitize=cfi jump table sections */
+		if (!strncmp(sec->name, ".text..L.cfi.jumptable", 22))
+			sec->cfi_jt = true;
+
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(section, &sec->hash, sec->idx);
 		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
@@ -576,6 +581,49 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
 	return 0;
 }
 
+/*
+ * CONFIG_CFI_CLANG replaces function relocations to refer to an intermediate
+ * jump table. Undo the conversion so objtool can make sense of things.
+ */
+static int fix_cfi_relocs(const struct elf *elf)
+{
+	struct section *sec;
+	struct reloc *reloc;
+
+	list_for_each_entry(sec, &elf->sections, list) {
+		list_for_each_entry(reloc, &sec->reloc_list, list) {
+			struct reloc *cfi_reloc;
+			unsigned long offset;
+
+			if (!reloc->sym->sec->cfi_jt)
+				continue;
+
+			if (reloc->sym->type == STT_SECTION)
+				offset = arch_cfi_section_reloc_offset(reloc);
+			else
+				offset = reloc->sym->offset;
+
+			/*
+			 * The jump table immediately jumps to the actual function,
+			 * so look up the relocation there.
+			 */
+			offset = arch_cfi_jump_reloc_offset(offset);
+			cfi_reloc = find_reloc_by_dest(elf, reloc->sym->sec, offset);
+
+			if (!cfi_reloc || !cfi_reloc->sym) {
+				WARN("can't find a CFI jump table relocation at %s+0x%lx",
+					reloc->sym->sec->name, offset);
+				return -1;
+			}
+
+			reloc->sym = cfi_reloc->sym;
+			reloc->addend = 0;
+		}
+	}
+
+	return 0;
+}
+
 static int read_relocs(struct elf *elf)
 {
 	struct section *sec;
@@ -639,6 +687,9 @@ static int read_relocs(struct elf *elf)
 		tot_reloc += nr_reloc;
 	}
 
+	if (fix_cfi_relocs(elf))
+		return -1;
+
 	if (stats) {
 		printf("max_reloc: %lu\n", max_reloc);
 		printf("tot_reloc: %lu\n", tot_reloc);
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 589ff58426ab..93bde8aaf2e3 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -81,6 +81,9 @@ unsigned long arch_jump_destination(struct instruction *insn);
 
 unsigned long arch_dest_reloc_offset(int addend);
 
+unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc);
+unsigned long arch_cfi_jump_reloc_offset(unsigned long offset);
+
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c3857fadee7a..e8d838217c77 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, cfi_jt;
 };
 
 struct symbol {
-- 
2.33.0.800.g4c38ced690-goog

