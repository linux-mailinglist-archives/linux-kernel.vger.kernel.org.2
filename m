Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118213F4F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhHWROJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhHWROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA3C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a62-20020a254d410000b0290592f360b0ccso16945263ybb.14
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BMOEEwZTh6kWZcClZ1xfFJLdcX1zczi/t2HYJexMlig=;
        b=ixZPqytD7WzOVXfCdTZr3Aa0G9Igllgsjp+W+Me6ydrLCI6hpcEffN/fsanp6XbAJm
         8OmH6RWH7MpOv3cBr8HqVn7Oy9u7JiiGvnIfLZkl01Cri5lbTfCAX13k0tz2SSq4eBVV
         Ki42i9Hh15OdVrM9Z7esZKPhwsybLRc03XVp05msK5D65B0d6t1goUuyAw+4TA2iGfef
         XyoEuVU0nfLr0DeT4N9ds1FGXMY6gyOdXW8aajLt/XavNaNT/EkEGT2iub1wTSNxc0df
         YRJRCEBV7CHz8W57FymRlYhn7T9Au4QLAdQPblHdJoHildUOfEgms2Fs2SnpkrCRtSim
         6ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BMOEEwZTh6kWZcClZ1xfFJLdcX1zczi/t2HYJexMlig=;
        b=lqAd6JteQAqwsLYIhAO6eB2Pfwtmvgddmh22gjFH0TdhuuPk9ZMttSbBdwlOga8ZVF
         Yetjzl1gUaUfR9QRz0kgevzbzqfcIRujOFrhtW13Lth565aD5tDzSwaRh1zxAWkot8sH
         zPTEQQzeTtmd8f47a7on2hgADEK8l9BaZyoKLgMHecWInczktRd936XKOh+DiIwPnYeA
         3LdNgAsCmv3LjRBzHHLyP6YTw4/Wg/dZmSImBURFJHr45uXoSer+HBzLHNYvV1ppE1rK
         BCBvRoTs5c2nnRVvtPCSPAOh8fRbdy1l2moRyHXAk6Dp0Mv7nuGY5mjAVOrxIVpgTRh1
         XpyQ==
X-Gm-Message-State: AOAM531xA495md2IfaX5AcatwQjWHAReJ/hppEchbR4LvCbqQgjmbbVR
        hZY0NSENzEQ17962PK2PLelFw+5w+v5l+9sezKw=
X-Google-Smtp-Source: ABdhPJxY5Ed4uHA+6rJSj8mEBtNL3YBP6+BvJBNLHfShDO7oGi9a+Mm7LN4bmZ0WLwfPHHNBQydXbRf9o3TN4dSvj8Q=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:da13:: with SMTP id
 n19mr12374471ybf.127.1629738803432; Mon, 23 Aug 2021 10:13:23 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:05 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 01/14] objtool: Add CONFIG_CFI_CLANG support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
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
 tools/objtool/arch/x86/decode.c      | 16 +++++++++
 tools/objtool/elf.c                  | 51 ++++++++++++++++++++++++++++
 tools/objtool/include/objtool/arch.h |  3 ++
 tools/objtool/include/objtool/elf.h  |  2 +-
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index bc821056aba9..318189c8065e 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -62,6 +62,22 @@ bool arch_callee_saved_reg(unsigned char reg)
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
index 062bb6e9b865..2205b2b08268 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -81,6 +81,9 @@ unsigned long arch_jump_destination(struct instruction *insn);
 
 unsigned long arch_dest_reloc_offset(int addend);
 
+unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc);
+unsigned long arch_cfi_jump_reloc_offset(unsigned long offset);
+
 const char *arch_nop_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index e34395047530..d9c1dacc6572 100644
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
2.33.0.rc2.250.ged5fa647cd-goog

