Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104E0339486
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhCLRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhCLRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:18:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF9CC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Rook4fYxEFvspuo0gkFACiC9RJ6QYhXIbzPllSfjTyQ=; b=lieaZsHonoIdWtM6NTQcI8Ik0G
        gxk3eug0O5axAgN503/zGQ5N71EG6R53Qk8Or0SjxjPlRw3BCyUbbl08el4zHDIaK6XKF62p0onCg
        eiTuVKtI04GFyR94r7uwA6l4oaFeXMFmixK4S4yHixS7Qa3kyW8COpeWFlfOQBO4b1ywKTtH4jOt7
        feOYFQrJXb1jkyNgbTIRsfytFqMRQgO1KWvwMGF4jmu6UnBH2tCzTyOKd8xfTVdqkDdw+LeQUqCYs
        RCTQNDQAFGpfu68+UcNwUWrHc134hLcydsoiaBCdI1weVtt9bOkPGht9tCWBiSo4ET5a8o6RKxJHN
        +LgZYkyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQ9-00C533-VD; Fri, 12 Mar 2021 17:17:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46C6930768E;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1483B23CC2296; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.710872453@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 6/9] objtool: Add elf_create_undef_symbol()
References: <20210312171613.533405394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow objtool to create undefined symbols; this allows creating
relocations to symbols not currently in the symbol table.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c                 |  180 +++++++++++++++++++++++++++---------
 tools/objtool/include/objtool/elf.h |    1 
 2 files changed, 139 insertions(+), 42 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -316,12 +316,60 @@ static int read_sections(struct elf *elf
 	return 0;
 }
 
+static bool elf_symbol_add(struct elf *elf, struct symbol *sym, Elf32_Word shndx)
+{
+	struct list_head *entry;
+	struct rb_node *pnode;
+
+	sym->type = GELF_ST_TYPE(sym->sym.st_info);
+	sym->bind = GELF_ST_BIND(sym->sym.st_info);
+
+	if ((sym->sym.st_shndx > SHN_UNDEF &&
+	     sym->sym.st_shndx < SHN_LORESERVE) ||
+	    (shndx != SHN_XINDEX && sym->sym.st_shndx == SHN_XINDEX)) {
+		if (sym->sym.st_shndx != SHN_XINDEX)
+			shndx = sym->sym.st_shndx;
+
+		sym->sec = find_section_by_index(elf, shndx);
+		if (!sym->sec) {
+			WARN("couldn't find section for symbol %s",
+			     sym->name);
+			return false;
+		}
+		if (sym->type == STT_SECTION) {
+			sym->name = sym->sec->name;
+			sym->sec->sym = sym;
+		}
+	} else
+		sym->sec = find_section_by_index(elf, 0);
+
+	sym->offset = sym->sym.st_value;
+	sym->len = sym->sym.st_size;
+
+	rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
+	pnode = rb_prev(&sym->node);
+	if (pnode)
+		entry = &rb_entry(pnode, struct symbol, node)->list;
+	else
+		entry = &sym->sec->symbol_list;
+	list_add(&sym->list, entry);
+	elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+	elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+
+	/*
+	 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
+	 * can exist within a function, confusing the sorting.
+	 */
+	if (!sym->len)
+		rb_erase(&sym->node, &sym->sec->symbol_tree);
+
+	return true;
+}
+
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *symtab_shndx, *sec;
 	struct symbol *sym, *pfunc;
-	struct list_head *entry;
-	struct rb_node *pnode;
 	int symbols_nr, i;
 	char *coldstr;
 	Elf_Data *shndx_data = NULL;
@@ -366,47 +414,11 @@ static int read_symbols(struct elf *elf)
 			goto err;
 		}
 
-		sym->type = GELF_ST_TYPE(sym->sym.st_info);
-		sym->bind = GELF_ST_BIND(sym->sym.st_info);
+		if (!shndx_data)
+			shndx = SHN_XINDEX;
 
-		if ((sym->sym.st_shndx > SHN_UNDEF &&
-		     sym->sym.st_shndx < SHN_LORESERVE) ||
-		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
-			if (sym->sym.st_shndx != SHN_XINDEX)
-				shndx = sym->sym.st_shndx;
-
-			sym->sec = find_section_by_index(elf, shndx);
-			if (!sym->sec) {
-				WARN("couldn't find section for symbol %s",
-				     sym->name);
-				goto err;
-			}
-			if (sym->type == STT_SECTION) {
-				sym->name = sym->sec->name;
-				sym->sec->sym = sym;
-			}
-		} else
-			sym->sec = find_section_by_index(elf, 0);
-
-		sym->offset = sym->sym.st_value;
-		sym->len = sym->sym.st_size;
-
-		rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
-		pnode = rb_prev(&sym->node);
-		if (pnode)
-			entry = &rb_entry(pnode, struct symbol, node)->list;
-		else
-			entry = &sym->sec->symbol_list;
-		list_add(&sym->list, entry);
-		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
-
-		/*
-		 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
-		 * can exist within a function, confusing the sorting.
-		 */
-		if (!sym->len)
-			rb_erase(&sym->node, &sym->sec->symbol_tree);
+		if (!elf_symbol_add(elf, sym, shndx))
+			goto err;
 	}
 
 	if (stats)
@@ -640,6 +652,90 @@ struct elf *elf_open_read(const char *na
 	return NULL;
 }
 
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
+{
+	struct section *strtab, *symtab;
+	struct symbol *sym;
+	Elf_Scn *s;
+	Elf_Data *data;
+
+	sym = malloc(sizeof(*sym));
+	if (!sym) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(sym, 0, sizeof(*sym));
+
+	sym->name = strdup(name);
+
+	strtab = find_section_by_name(elf, ".strtab");
+	if (!strtab) {
+		WARN("can't find .strtab");
+		return NULL;
+	}
+
+	s = elf_getscn(elf->elf, strtab->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return NULL;
+	}
+
+	data = elf_newdata(s);
+	if (!data) {
+		WARN_ELF("elf_newdata");
+		return NULL;
+	}
+
+	data->d_buf = sym->name;
+	data->d_size = strlen(sym->name) + 1;
+	data->d_align = 1;
+
+	sym->sym.st_name = strtab->len;
+	sym->sym.st_info = 0x10; /* STB_GLOBAL, STT_NOTYPE */
+	// st_other 0
+	// st_shndx 0
+	// st_value 0
+	// st_size 0
+
+	strtab->len += data->d_size;
+	strtab->changed = true;
+
+
+	symtab = find_section_by_name(elf, ".symtab");
+	if (!symtab) {
+		WARN("can't find .symtab");
+		return NULL;
+	}
+
+	s = elf_getscn(elf->elf, symtab->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return NULL;
+	}
+
+	data = elf_newdata(s);
+	if (!data) {
+		WARN_ELF("elf_newdata");
+		return NULL;
+	}
+
+	data->d_buf = &sym->sym;
+	data->d_size = sizeof(sym->sym);
+	data->d_align = 1;
+
+	sym->idx = symtab->len / sizeof(sym->sym);
+
+	symtab->len += data->d_size;
+	symtab->changed = true;
+
+	if (!elf_symbol_add(elf, sym, SHN_XINDEX)) {
+		WARN("elf_symbol_add");
+		return NULL;
+	}
+
+	return sym;
+}
+
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -128,6 +128,7 @@ int elf_write_insn(struct elf *elf, stru
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
 int elf_write_reloc(struct elf *elf, struct reloc *reloc);
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 


