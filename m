Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C53340BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhCRRYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhCRRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BF8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dHAzkwZvCqitMmamq6KJXTcsHxHLZq24/Li81EOLf+U=; b=aGmz5sZ3+8H3NyGpZ3Zm1wSg4m
        T+KAfp4Ye0lZkV1CX22tO4vpPAI8tJTc/eviUF+YWbnfNzn1FkP6Byxf9GjYDgmSQk0Sprgl32+0h
        XXGrTeif8j+o7lMn1dgzBO4jHQvY2RRHDjC5Szeu1MVKvzwVyEJMMWBTTOj+waQgCXrzIwj7u+mr1
        ztRWyeB9+l1GvlGKgMZwdLc4+PhZJheyYb/gmjkwYQDp26ocYvsHin/q6KJ+b/Rv+Tm4JVeOj9rh5
        CcHCC8Ubx8jTUVy2DLr3x4dhZAg73fnoltjWwXpdoB3G989990kWMxpJLjw25T07V3jbF38Yf56Bi
        n0kNRDaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-003HIX-J6; Thu, 18 Mar 2021 17:23:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42CE930785A;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 341E4238A4644; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.887152166@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 08/14] objtool: Add elf_create_reloc() helper
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have 4 instances of adding a relocation. Create a common helper
to avoid growing even more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |   76 ++++++----------------------
 tools/objtool/elf.c                   |   90 +++++++++++++++++++++++-----------
 tools/objtool/include/objtool/check.h |    7 ++
 tools/objtool/include/objtool/elf.h   |   10 +++
 tools/objtool/orc_gen.c               |   57 ++++++++-------------
 5 files changed, 119 insertions(+), 121 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -433,8 +433,7 @@ static int add_dead_ends(struct objtool_
 
 static int create_static_call_sections(struct objtool_file *file)
 {
-	struct section *sec, *reloc_sec;
-	struct reloc *reloc;
+	struct section *sec;
 	struct static_call_site *site;
 	struct instruction *insn;
 	struct symbol *key_sym;
@@ -460,8 +459,7 @@ static int create_static_call_sections(s
 	if (!sec)
 		return -1;
 
-	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!reloc_sec)
+	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
 		return -1;
 
 	idx = 0;
@@ -471,26 +469,13 @@ static int create_static_call_sections(s
 		memset(site, 0, sizeof(struct static_call_site));
 
 		/* populate reloc for 'addr' */
-		reloc = malloc(sizeof(*reloc));
-
-		if (!reloc) {
-			perror("malloc");
-			return -1;
-		}
-		memset(reloc, 0, sizeof(*reloc));
-
-		insn_to_reloc_sym_addend(insn->sec, insn->offset, reloc);
-		if (!reloc->sym) {
-			WARN_FUNC("static call tramp: missing containing symbol",
-				  insn->sec, insn->offset);
+		if (!elf_create_reloc(file->elf, sec, idx * sizeof(struct static_call_site),
+				      R_X86_64_PC32,
+				      reloc_to_insn, insn, 0)) {
+			WARN_ELF("elf_create_reloc: static_call_site::addr");
 			return -1;
 		}
 
-		reloc->type = R_X86_64_PC32;
-		reloc->offset = idx * sizeof(struct static_call_site);
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
-
 		/* find key symbol */
 		key_name = strdup(insn->call_dest->name);
 		if (!key_name) {
@@ -526,18 +511,13 @@ static int create_static_call_sections(s
 		free(key_name);
 
 		/* populate reloc for 'key' */
-		reloc = malloc(sizeof(*reloc));
-		if (!reloc) {
-			perror("malloc");
+		if (!elf_create_reloc(file->elf, sec, idx * sizeof(struct static_call_site) + 4,
+				      R_X86_64_PC32,
+				      reloc_to_sym, key_sym,
+				      is_sibling_call(insn) * STATIC_CALL_SITE_TAIL)) {
+			WARN_ELF("elf_create_reloc: static_call_site::key");
 			return -1;
 		}
-		memset(reloc, 0, sizeof(*reloc));
-		reloc->sym = key_sym;
-		reloc->addend = is_sibling_call(insn) ? STATIC_CALL_SITE_TAIL : 0;
-		reloc->type = R_X86_64_PC32;
-		reloc->offset = idx * sizeof(struct static_call_site) + 4;
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
 
 		idx++;
 	}
@@ -547,8 +527,7 @@ static int create_static_call_sections(s
 
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
-	struct section *sec, *reloc_sec;
-	struct reloc *reloc;
+	struct section *sec;
 	unsigned long *loc;
 	struct instruction *insn;
 	int idx;
@@ -571,8 +550,7 @@ static int create_mcount_loc_sections(st
 	if (!sec)
 		return -1;
 
-	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!reloc_sec)
+	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
 		return -1;
 
 	idx = 0;
@@ -581,32 +559,12 @@ static int create_mcount_loc_sections(st
 		loc = (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
 
-		reloc = malloc(sizeof(*reloc));
-		if (!reloc) {
-			perror("malloc");
+		if (!elf_create_reloc(file->elf, sec, idx * sizeof(unsigned long),
+				      R_X86_64_64,
+				      reloc_to_insn, insn, 0)) {
+			WARN_ELF("elf_create_reloc: __mcount_loc");
 			return -1;
 		}
-		memset(reloc, 0, sizeof(*reloc));
-
-		if (insn->sec->sym) {
-			reloc->sym = insn->sec->sym;
-			reloc->addend = insn->offset;
-		} else {
-			reloc->sym = find_symbol_containing(insn->sec, insn->offset);
-
-			if (!reloc->sym) {
-				WARN("missing symbol for insn at offset 0x%lx\n",
-				     insn->offset);
-				return -1;
-			}
-
-			reloc->addend = insn->offset - reloc->sym->offset;
-		}
-
-		reloc->type = R_X86_64_64;
-		reloc->offset = idx * sizeof(unsigned long);
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
 
 		idx++;
 	}
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -211,32 +211,6 @@ struct reloc *find_reloc_by_dest(const s
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
-void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
-			      struct reloc *reloc)
-{
-	if (sec->sym) {
-		reloc->sym = sec->sym;
-		reloc->addend = offset;
-		return;
-	}
-
-	/*
-	 * The Clang assembler strips section symbols, so we have to reference
-	 * the function symbol instead:
-	 */
-	reloc->sym = find_symbol_containing(sec, offset);
-	if (!reloc->sym) {
-		/*
-		 * Hack alert.  This happens when we need to reference the NOP
-		 * pad insn immediately after the function.
-		 */
-		reloc->sym = find_symbol_containing(sec, offset - 1);
-	}
-
-	if (reloc->sym)
-		reloc->addend = offset - reloc->sym->offset;
-}
-
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
@@ -473,7 +447,7 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
-void elf_add_reloc(struct elf *elf, struct reloc *reloc)
+static void elf_add_reloc(struct elf *elf, struct reloc *reloc)
 {
 	struct section *sec = reloc->sec;
 
@@ -483,6 +457,68 @@ void elf_add_reloc(struct elf *elf, stru
 	sec->changed = true;
 }
 
+void reloc_to_sym(struct reloc *reloc, void *dst)
+{
+	struct symbol *sym = dst;
+	reloc->sym = sym;
+}
+
+void __reloc_to_insn(struct reloc *reloc, struct section *sec, unsigned long offset)
+{
+	if (sec->sym) {
+		reloc->sym = sec->sym;
+		reloc->addend = offset;
+		return;
+	}
+
+	/*
+	 * The Clang assembler strips section symbols, so we have to reference
+	 * the function symbol instead:
+	 */
+	reloc->sym = find_symbol_containing(sec, offset);
+	if (!reloc->sym) {
+		/*
+		 * Hack alert.  This happens when we need to reference the NOP
+		 * pad insn immediately after the function.
+		 */
+		reloc->sym = find_symbol_containing(sec, offset - 1);
+	}
+
+	if (reloc->sym)
+		reloc->addend = offset - reloc->sym->offset;
+}
+
+struct reloc *elf_create_reloc(struct elf *elf,
+			       struct section *sec, unsigned long offset,
+			       unsigned int type,
+			       void (*set_dest)(struct reloc *, void *), void *dst, int addend)
+{
+	struct reloc *reloc;
+
+	reloc = malloc(sizeof(*reloc));
+	if (!reloc) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(reloc, 0, sizeof(*reloc));
+
+	reloc->sec = sec->reloc;
+	reloc->offset = offset;
+	reloc->type = type;
+
+	set_dest(reloc, dst);
+	if (!reloc->sym) {
+		WARN("failed to create reloc");
+		return NULL;
+	}
+
+	reloc->addend += addend;
+
+	elf_add_reloc(elf, reloc);
+
+	return reloc;
+}
+
 static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
 {
 	if (!gelf_getrel(sec->data, i, &reloc->rel)) {
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include <objtool/cfi.h>
 #include <objtool/arch.h>
+#include <objtool/elf.h>
 
 struct insn_state {
 	struct cfi_state cfi;
@@ -91,4 +92,10 @@ struct instruction *find_insn(struct obj
 			insn->sec == sec;				\
 	     insn = list_next_entry(insn, list))
 
+static inline void reloc_to_insn(struct reloc *reloc, void *dst)
+{
+	struct instruction *insn = dst;
+	__reloc_to_insn(reloc, insn->sec, insn->offset);
+}
+
 #endif /* _CHECK_H */
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -123,7 +123,15 @@ static inline u32 reloc_hash(struct relo
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
-void elf_add_reloc(struct elf *elf, struct reloc *reloc);
+
+void reloc_to_sym(struct reloc *reloc, void *sym);
+void __reloc_to_insn(struct reloc *reloc, struct section *sec, unsigned long offset);
+
+struct reloc *elf_create_reloc(struct elf *elf,
+			       struct section *sec, unsigned long offset,
+			       unsigned int type,
+			       void (*set_dest)(struct reloc *reloc, void *), void *dst, int addend);
+
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -81,13 +81,25 @@ static int init_orc_entry(struct orc_ent
 	return 0;
 }
 
+struct orc_list_entry {
+	struct list_head list;
+	struct orc_entry orc;
+	struct section *insn_sec;
+	unsigned long insn_off;
+};
+
+static void reloc_to_orc(struct reloc *reloc, void *dst)
+{
+	struct orc_list_entry *entry = dst;
+	__reloc_to_insn(reloc, entry->insn_sec, entry->insn_off);
+}
+
 static int write_orc_entry(struct elf *elf, struct section *orc_sec,
-			   struct section *ip_rsec, unsigned int idx,
-			   struct section *insn_sec, unsigned long insn_off,
-			   struct orc_entry *o)
+			   struct section *ip_sec, unsigned int idx,
+			   struct orc_list_entry *entry)
 {
+	struct orc_entry *o = &entry->orc;
 	struct orc_entry *orc;
-	struct reloc *reloc;
 
 	/* populate ORC data */
 	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
@@ -96,36 +108,16 @@ static int write_orc_entry(struct elf *e
 	orc->bp_offset = bswap_if_needed(orc->bp_offset);
 
 	/* populate reloc for ip */
-	reloc = malloc(sizeof(*reloc));
-	if (!reloc) {
-		perror("malloc");
-		return -1;
-	}
-	memset(reloc, 0, sizeof(*reloc));
-
-	insn_to_reloc_sym_addend(insn_sec, insn_off, reloc);
-	if (!reloc->sym) {
-		WARN("missing symbol for insn at offset 0x%lx",
-		     insn_off);
+	if (!elf_create_reloc(elf, ip_sec, idx * sizeof(int),
+			      R_X86_64_PC32,
+			      reloc_to_orc, entry, 0)) {
+		WARN_ELF("elf_create_reloc: ORC ip");
 		return -1;
 	}
 
-	reloc->type = R_X86_64_PC32;
-	reloc->offset = idx * sizeof(int);
-	reloc->sec = ip_rsec;
-
-	elf_add_reloc(elf, reloc);
-
 	return 0;
 }
 
-struct orc_list_entry {
-	struct list_head list;
-	struct orc_entry orc;
-	struct section *insn_sec;
-	unsigned long insn_off;
-};
-
 static int orc_list_add(struct list_head *orc_list, struct orc_entry *orc,
 			struct section *sec, unsigned long offset)
 {
@@ -153,7 +145,7 @@ static unsigned long alt_group_len(struc
 
 int orc_create(struct objtool_file *file)
 {
-	struct section *sec, *ip_rsec, *orc_sec;
+	struct section *sec, *orc_sec;
 	unsigned int nr = 0, idx = 0;
 	struct orc_list_entry *entry;
 	struct list_head orc_list;
@@ -242,15 +234,12 @@ int orc_create(struct objtool_file *file
 	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
 	if (!sec)
 		return -1;
-	ip_rsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!ip_rsec)
+	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
 		return -1;
 
 	/* Write ORC entries to sections: */
 	list_for_each_entry(entry, &orc_list, list) {
-		if (write_orc_entry(file->elf, orc_sec, ip_rsec, idx++,
-				    entry->insn_sec, entry->insn_off,
-				    &entry->orc))
+		if (write_orc_entry(file->elf, orc_sec, sec, idx++, entry))
 			return -1;
 	}
 


