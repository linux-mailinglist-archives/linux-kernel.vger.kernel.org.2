Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC708375BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhEFToH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbhEFTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:43:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34909C06138A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OsER0YKCiZTSrVbCQw4h7jjWWkv95c0Xy2PO8AZA4cI=; b=FgayCJzLDFja2tB/if0VSrpWAU
        iHMaAUug7WorjnJKPRv2tGXqmM4e+OYnZbKt9Tw4pl8FM4elkySVGP90GY/0SbEq/6Zh8BMBsT+4q
        oIVP3V+TYfQl7BERWI0VPeXbQsdGLr02UvvWHjjCGqNz9x3dJHD/7i1cbmyGH5ewOn9jSoeD8uoh+
        K+JOa+uFLxtCoLL4mF8nyYAHD+PqAnfzztQZb37qm9m4hfs0zVMVcM+OZGNi1/5VvkRZVYdNlLiof
        jVkBnElkSFeWqX8y5JHnLLsQ5UBfeaKR6kc7s3k41hJgm5FNJ0xokPyF+5GNc5vXZMWc6tpdkh+Kw
        zDlMsMlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtQ-005BLN-7F; Thu, 06 May 2021 19:42:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7487300312;
        Thu,  6 May 2021 21:42:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9ABB420435D19; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.452881700@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 01/13] objtool: Rewrite hashtable sizing
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool has 5 hashtables and sizes them 16 or 20 bits
depending on the --vmlinux argument.

However, a single side doesn't really work well for the 5 tables,
which among them, cover 3 different uses. Also, while vmlinux is
larger, there is still a very wide difference between a defconfig and
allyesconfig build, which again isn't optimally covered by a single
size.

Another aspect is the cost of elf_hash_init(), which for large tables
dominates the runtime for small input files. It turns out that all it
does it assign NULL, something that is required when using malloc().
However, when we allocate memory using mmap(), we're guaranteed to get
zero filled pages.

Therefore, rewrite the whole thing to:

 1) use more dynamic sized tables, depending on the input file,
 2) avoid the need for elf_hash_init() entirely by using mmap().

This speeds up a regular kernel build (100s to 98s for
x86_64-defconfig), and potentially dramatically speeds up vmlinux
processing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c                 |   95 +++++++++++++++++++++++-------------
 tools/objtool/include/objtool/elf.h |   17 ++++--
 2 files changed, 73 insertions(+), 39 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -9,6 +9,7 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -27,21 +28,27 @@ static inline u32 str_hash(const char *s
 	return jhash(str, strlen(str), 0);
 }
 
-static inline int elf_hash_bits(void)
-{
-	return vmlinux ? ELF_HASH_BITS : 16;
-}
+#define __elf_table(name)	(elf->name##_hash)
+#define __elf_bits(name)	(elf->name##_bits)
 
-#define elf_hash_add(hashtable, node, key) \
-	hlist_add_head(node, &hashtable[hash_min(key, elf_hash_bits())])
+#define elf_hash_add(name, node, key) \
+	hlist_add_head(node, &__elf_table(name)[hash_min(key, __elf_bits(name))])
 
-static void elf_hash_init(struct hlist_head *table)
-{
-	__hash_init(table, 1U << elf_hash_bits());
-}
+#define elf_hash_for_each_possible(name, obj, member, key) \
+	hlist_for_each_entry(obj, &__elf_table(name)[hash_min(key, __elf_bits(name))], member)
 
-#define elf_hash_for_each_possible(name, obj, member, key)			\
-	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
+#define elf_alloc_hash(name, size) \
+({ \
+	__elf_bits(name) = max(10, ilog2(size)); \
+	__elf_table(name) = mmap(NULL, sizeof(struct hlist_head) << __elf_bits(name), \
+				 PROT_READ|PROT_WRITE, \
+				 MAP_PRIVATE|MAP_ANON, -1, 0); \
+	if (__elf_table(name) == (void *)-1L) { \
+		WARN("mmap fail " #name); \
+		__elf_table(name) = NULL; \
+	} \
+	__elf_table(name); \
+})
 
 static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
 {
@@ -80,9 +87,10 @@ struct section *find_section_by_name(con
 {
 	struct section *sec;
 
-	elf_hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
+	elf_hash_for_each_possible(section_name, sec, name_hash, str_hash(name)) {
 		if (!strcmp(sec->name, name))
 			return sec;
+	}
 
 	return NULL;
 }
@@ -92,9 +100,10 @@ static struct section *find_section_by_i
 {
 	struct section *sec;
 
-	elf_hash_for_each_possible(elf->section_hash, sec, hash, idx)
+	elf_hash_for_each_possible(section, sec, hash, idx) {
 		if (sec->idx == idx)
 			return sec;
+	}
 
 	return NULL;
 }
@@ -103,9 +112,10 @@ static struct symbol *find_symbol_by_ind
 {
 	struct symbol *sym;
 
-	elf_hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
+	elf_hash_for_each_possible(symbol, sym, hash, idx) {
 		if (sym->idx == idx)
 			return sym;
+	}
 
 	return NULL;
 }
@@ -170,9 +180,10 @@ struct symbol *find_symbol_by_name(const
 {
 	struct symbol *sym;
 
-	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(name)) {
 		if (!strcmp(sym->name, name))
 			return sym;
+	}
 
 	return NULL;
 }
@@ -189,8 +200,8 @@ struct reloc *find_reloc_by_dest_range(c
 	sec = sec->reloc;
 
 	for_offset_range(o, offset, offset + len) {
-		elf_hash_for_each_possible(elf->reloc_hash, reloc, hash,
-				       sec_offset_hash(sec, o)) {
+		elf_hash_for_each_possible(reloc, reloc, hash,
+					   sec_offset_hash(sec, o)) {
 			if (reloc->sec != sec)
 				continue;
 
@@ -228,6 +239,10 @@ static int read_sections(struct elf *elf
 		return -1;
 	}
 
+	if (!elf_alloc_hash(section, sections_nr) ||
+	    !elf_alloc_hash(section_name, sections_nr))
+		return -1;
+
 	for (i = 0; i < sections_nr; i++) {
 		sec = malloc(sizeof(*sec));
 		if (!sec) {
@@ -274,12 +289,14 @@ static int read_sections(struct elf *elf
 		sec->len = sec->sh.sh_size;
 
 		list_add_tail(&sec->list, &elf->sections);
-		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
-		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+		elf_hash_add(section, &sec->hash, sec->idx);
+		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 	}
 
-	if (stats)
+	if (stats) {
 		printf("nr_sections: %lu\n", (unsigned long)sections_nr);
+		printf("section_bits: %d\n", elf->section_bits);
+	}
 
 	/* sanity check, one more call to elf_nextscn() should return NULL */
 	if (elf_nextscn(elf->elf, s)) {
@@ -308,8 +325,8 @@ static void elf_add_symbol(struct elf *e
 	else
 		entry = &sym->sec->symbol_list;
 	list_add(&sym->list, entry);
-	elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-	elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+	elf_hash_add(symbol, &sym->hash, sym->idx);
+	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->name));
 
 	/*
 	 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
@@ -343,6 +360,10 @@ static int read_symbols(struct elf *elf)
 
 	symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
 
+	if (!elf_alloc_hash(symbol, symbols_nr) ||
+	    !elf_alloc_hash(symbol_name, symbols_nr))
+		return -1;
+
 	for (i = 0; i < symbols_nr; i++) {
 		sym = malloc(sizeof(*sym));
 		if (!sym) {
@@ -389,8 +410,10 @@ static int read_symbols(struct elf *elf)
 		elf_add_symbol(elf, sym);
 	}
 
-	if (stats)
+	if (stats) {
 		printf("nr_symbols: %lu\n", (unsigned long)symbols_nr);
+		printf("symbol_bits: %d\n", elf->symbol_bits);
+	}
 
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
@@ -479,7 +502,7 @@ int elf_add_reloc(struct elf *elf, struc
 	reloc->addend = addend;
 
 	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
-	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 	sec->reloc->changed = true;
 
@@ -556,6 +579,15 @@ static int read_relocs(struct elf *elf)
 	unsigned int symndx;
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 
+	sec = find_section_by_name(elf, ".text");
+	if (!sec) {
+		WARN("no .text");
+		return -1;
+	}
+
+	if (!elf_alloc_hash(reloc, sec->len / 16))
+		return -1;
+
 	list_for_each_entry(sec, &elf->sections, list) {
 		if ((sec->sh.sh_type != SHT_RELA) &&
 		    (sec->sh.sh_type != SHT_REL))
@@ -600,7 +632,7 @@ static int read_relocs(struct elf *elf)
 			}
 
 			list_add_tail(&reloc->list, &sec->reloc_list);
-			elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 			nr_reloc++;
 		}
@@ -611,6 +643,7 @@ static int read_relocs(struct elf *elf)
 	if (stats) {
 		printf("max_reloc: %lu\n", max_reloc);
 		printf("tot_reloc: %lu\n", tot_reloc);
+		printf("reloc_bits: %d\n", elf->reloc_bits);
 	}
 
 	return 0;
@@ -632,12 +665,6 @@ struct elf *elf_open_read(const char *na
 
 	INIT_LIST_HEAD(&elf->sections);
 
-	elf_hash_init(elf->symbol_hash);
-	elf_hash_init(elf->symbol_name_hash);
-	elf_hash_init(elf->section_hash);
-	elf_hash_init(elf->section_name_hash);
-	elf_hash_init(elf->reloc_hash);
-
 	elf->fd = open(name, flags);
 	if (elf->fd == -1) {
 		fprintf(stderr, "objtool: Can't open '%s': %s\n",
@@ -850,8 +877,8 @@ struct section *elf_create_section(struc
 		return NULL;
 
 	list_add_tail(&sec->list, &elf->sections);
-	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
-	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+	elf_hash_add(section, &sec->hash, sec->idx);
+	elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 
 	elf->changed = true;
 
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -84,11 +84,18 @@ struct elf {
 	bool changed;
 	char *name;
 	struct list_head sections;
-	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(symbol_name_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(section_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(section_name_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(reloc_hash, ELF_HASH_BITS);
+
+	int symbol_bits;
+	int symbol_name_bits;
+	int section_bits;
+	int section_name_bits;
+	int reloc_bits;
+
+	struct hlist_head *symbol_hash;
+	struct hlist_head *symbol_name_hash;
+	struct hlist_head *section_hash;
+	struct hlist_head *section_name_hash;
+	struct hlist_head *reloc_hash;
 };
 
 #define OFFSET_STRIDE_BITS	4


