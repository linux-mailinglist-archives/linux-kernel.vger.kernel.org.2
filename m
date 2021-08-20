Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9687B3F34BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhHTTpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237764AbhHTTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629488706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3TcvmcNHKsnKhmw6ey2X4V4f1tEW1gioXo6IBLQ6b4=;
        b=JpIUDat77XkT24+a9C8HrpqWLrLqzlynHu7qmC9PW0LWBOZFaEnFgrvHTQr4o3hALytD11
        DryzeuM7U2vHpGFGe0YjKGyQiHKQ5mixAiB+aQ4agNYfIvXcQjdup+Kfom6DuYS4RhMDWy
        b7SX3ngD0vu2p5WOm7yK5H5OWqXBng4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-lsrFOuOBPTWKWEeyRAynJQ-1; Fri, 20 Aug 2021 15:45:02 -0400
X-MC-Unique: lsrFOuOBPTWKWEeyRAynJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA5A760C1;
        Fri, 20 Aug 2021 19:45:01 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.16.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00D7F6A8FA;
        Fri, 20 Aug 2021 19:45:00 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 2/2] objtool: remove redundant len value from struct section
Date:   Fri, 20 Aug 2021 15:44:53 -0400
Message-Id: <20210820194453.395548-3-joe.lawrence@redhat.com>
In-Reply-To: <20210820194453.395548-1-joe.lawrence@redhat.com>
References: <20210820194453.395548-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section structure already contains sh_size, so just remove the extra
'len' member that requires extra mirroring and potential confusion.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/arch/x86/decode.c      |  2 +-
 tools/objtool/check.c                | 19 ++++++++++---------
 tools/objtool/elf.c                  | 15 +++++++--------
 tools/objtool/include/objtool/arch.h |  2 +-
 tools/objtool/include/objtool/elf.h  |  1 -
 tools/objtool/orc_gen.c              |  2 +-
 tools/objtool/special.c              |  4 ++--
 7 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0893436cc09f..a33756ff2672 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -104,7 +104,7 @@ unsigned long arch_jump_destination(struct instruction *insn)
 
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
+			    unsigned long *len, enum insn_type *type,
 			    unsigned long *immediate,
 			    struct list_head *ops_list)
 {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fbb9e7a..1d7dbd469896 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -292,7 +292,7 @@ static int decode_instructions(struct objtool_file *file)
 		    !strcmp(sec->name, ".entry.text"))
 			sec->noinstr = true;
 
-		for (offset = 0; offset < sec->len; offset += insn->len) {
+		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
 				WARN("malloc failed");
@@ -307,8 +307,9 @@ static int decode_instructions(struct objtool_file *file)
 			insn->offset = offset;
 
 			ret = arch_decode_instruction(file->elf, sec, offset,
-						      sec->len - offset,
-						      &insn->len, &insn->type,
+						      sec->sh.sh_size - offset,
+						      &insn->sec->sh.sh_size,
+						      &insn->type,
 						      &insn->immediate,
 						      &insn->stack_ops);
 			if (ret)
@@ -349,9 +350,9 @@ static struct instruction *find_last_insn(struct objtool_file *file,
 {
 	struct instruction *insn = NULL;
 	unsigned int offset;
-	unsigned int end = (sec->len > 10) ? sec->len - 10 : 0;
+	unsigned int end = (sec->sh.sh_size > 10) ? sec->sh.sh_size - 10 : 0;
 
-	for (offset = sec->len - 1; offset >= end && !insn; offset--)
+	for (offset = sec->sh.sh_size - 1; offset >= end && !insn; offset--)
 		insn = find_insn(file, sec, offset);
 
 	return insn;
@@ -389,7 +390,7 @@ static int add_dead_ends(struct objtool_file *file)
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
 			insn = list_prev_entry(insn, list);
-		else if (reloc->addend == reloc->sym->sec->len) {
+		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%x",
@@ -424,7 +425,7 @@ static int add_dead_ends(struct objtool_file *file)
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
 			insn = list_prev_entry(insn, list);
-		else if (reloc->addend == reloc->sym->sec->len) {
+		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%x",
@@ -1561,14 +1562,14 @@ static int read_unwind_hints(struct objtool_file *file)
 		return -1;
 	}
 
-	if (sec->len % sizeof(struct unwind_hint)) {
+	if (sec->sh.sh_size % sizeof(struct unwind_hint)) {
 		WARN("struct unwind_hint size mismatch");
 		return -1;
 	}
 
 	file->hints = true;
 
-	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
+	for (i = 0; i < sec->sh.sh_size / sizeof(struct unwind_hint); i++) {
 		hint = (struct unwind_hint *)sec->data->d_buf + i;
 
 		reloc = find_reloc_by_dest(file->elf, sec, i * sizeof(*hint));
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8676c7598728..7f66b542f53e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -286,10 +286,9 @@ static int read_sections(struct elf *elf)
 				return -1;
 			}
 		}
-		sec->len = sec->sh.sh_size;
 
 		if (sec->sh.sh_flags & SHF_EXECINSTR)
-			elf->text_size += sec->len;
+			elf->text_size += sec->sh.sh_size;
 
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(section, &sec->hash, sec->idx);
@@ -734,8 +733,8 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 	data->d_size = strlen(str) + 1;
 	data->d_align = 1;
 
-	len = strtab->len;
-	strtab->len += data->d_size;
+	len = strtab->sh.sh_size;
+	strtab->sh.sh_size += data->d_size;
 	strtab->changed = true;
 
 	return len;
@@ -790,9 +789,9 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	data->d_align = 1;
 	data->d_type = ELF_T_SYM;
 
-	sym->idx = symtab->len / sizeof(sym->sym);
+	sym->idx = symtab->sh.sh_size / sizeof(sym->sym);
 
-	symtab->len += data->d_size;
+	symtab->sh.sh_size += data->d_size;
 	symtab->changed = true;
 
 	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
@@ -814,7 +813,7 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 		data->d_align = 4;
 		data->d_type = ELF_T_WORD;
 
-		symtab_shndx->len += 4;
+		symtab_shndx->sh.sh_size += 4;
 		symtab_shndx->changed = true;
 	}
 
@@ -855,7 +854,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	}
 
 	sec->idx = elf_ndxscn(s);
-	sec->len = size;
+	sec->sh.sh_size = size;
 	sec->changed = true;
 
 	sec->data = elf_newdata(s);
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 062bb6e9b865..958617ce03ef 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -71,7 +71,7 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
+			    unsigned long *len, enum insn_type *type,
 			    unsigned long *immediate,
 			    struct list_head *ops_list);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index e34395047530..075d8291b854 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -38,7 +38,6 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	unsigned int len;
 	bool changed, text, rodata, noinstr;
 };
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dc9b7dd314b0..b5865e2450cb 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -204,7 +204,7 @@ int orc_create(struct objtool_file *file)
 
 		/* Add a section terminator */
 		if (!empty) {
-			orc_list_add(&orc_list, &null, sec, sec->len);
+			orc_list_add(&orc_list, &null, sec, sec->sh.sh_size);
 			nr++;
 		}
 	}
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index bc925cf19e2d..7a0c49421cd8 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -159,13 +159,13 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 		if (!sec)
 			continue;
 
-		if (sec->len % entry->size != 0) {
+		if (sec->sh.sh_size % entry->size != 0) {
 			WARN("%s size not a multiple of %d",
 			     sec->name, entry->size);
 			return -1;
 		}
 
-		nr_entries = sec->len / entry->size;
+		nr_entries = sec->sh.sh_size / entry->size;
 
 		for (idx = 0; idx < nr_entries; idx++) {
 			alt = malloc(sizeof(*alt));
-- 
2.26.3

