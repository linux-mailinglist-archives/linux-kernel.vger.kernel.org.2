Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB734123A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhCSBnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhCSBm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616118173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yn6DYgLXA9uSMx1W5KUy9hx7Cp+m7nZmn9UCB7n3UbA=;
        b=egvUCusiXAIAnTVBNpn1ZQv4MRbfHAFQNuzI2VjKmtWdNkAu9lW5qLy49b82JlJ3ub3GpH
        L+qrHT8JA5c2ad5bFuG+lsJQNzV0y8sEsQdqBzlqf0/7TjZ1ob2Zkxy2g8yDL6qHboNCVF
        wFiCqcoPzKhXnFqM6zS0xtLvTLS6lPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-O04Sg8R4NPOmRHtgCNl23A-1; Thu, 18 Mar 2021 21:42:51 -0400
X-MC-Unique: O04Sg8R4NPOmRHtgCNl23A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD1A2107ACCD;
        Fri, 19 Mar 2021 01:42:50 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D541A3D8;
        Fri, 19 Mar 2021 01:42:49 +0000 (UTC)
Date:   Thu, 18 Mar 2021 20:42:46 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] objtool: Add elf_create_reloc() helper
Message-ID: <20210319014246.c6trc4x3qewro32c@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.887152166@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171919.887152166@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:11PM +0100, Peter Zijlstra wrote:
> We have 4 instances of adding a relocation. Create a common helper
> to avoid growing even more.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'm not a fan of the API -- how about squashing this in?  Untested, of
course.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6a52d56504b1..38ffa3b2595e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -469,12 +469,11 @@ static int create_static_call_sections(struct objtool_file *file)
 		memset(site, 0, sizeof(struct static_call_site));
 
 		/* populate reloc for 'addr' */
-		if (!elf_create_reloc(file->elf, sec, idx * sizeof(struct static_call_site),
-				      R_X86_64_PC32,
-				      reloc_to_insn, insn, 0)) {
-			WARN_ELF("elf_create_reloc: static_call_site::addr");
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(struct static_call_site),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset))
 			return -1;
-		}
 
 		/* find key symbol */
 		key_name = strdup(insn->call_dest->name);
@@ -511,13 +510,11 @@ static int create_static_call_sections(struct objtool_file *file)
 		free(key_name);
 
 		/* populate reloc for 'key' */
-		if (!elf_create_reloc(file->elf, sec, idx * sizeof(struct static_call_site) + 4,
-				      R_X86_64_PC32,
-				      reloc_to_sym, key_sym,
-				      is_sibling_call(insn) * STATIC_CALL_SITE_TAIL)) {
-			WARN_ELF("elf_create_reloc: static_call_site::key");
+		if (elf_add_reloc(file->elf, sec,
+				  idx * sizeof(struct static_call_site) + 4,
+				  R_X86_64_PC32, key_sym,
+				  is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
-		}
 
 		idx++;
 	}
@@ -559,12 +556,11 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		loc = (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
 
-		if (!elf_create_reloc(file->elf, sec, idx * sizeof(unsigned long),
-				      R_X86_64_64,
-				      reloc_to_insn, insn, 0)) {
-			WARN_ELF("elf_create_reloc: __mcount_loc");
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(unsigned long),
+					  R_X86_64_64,
+					  insn->sec, insn->offset))
 			return -1;
-		}
 
 		idx++;
 	}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d2afe2454de4..b3bd97b2b034 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -447,76 +447,73 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
-static void elf_add_reloc(struct elf *elf, struct reloc *reloc)
+int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
+		  unsigned int type, struct symbol *sym, int addend)
 {
-	struct section *sec = reloc->sec;
+	struct reloc *reloc;
+
+	reloc = malloc(sizeof(*reloc));
+	if (!reloc) {
+		perror("malloc");
+		return -1;
+	}
+	memset(reloc, 0, sizeof(*reloc));
+
+	reloc->sec = sec->reloc;
+	reloc->offset = offset;
+	reloc->type = type;
+	reloc->sym = sym;
+	reloc->addend = addend;
 
 	list_add_tail(&reloc->list, &sec->reloc_list);
 	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
 
-	sec->changed = true;
-}
-
-void reloc_to_sym(struct reloc *reloc, void *dst)
-{
-	struct symbol *sym = dst;
-	reloc->sym = sym;
+	return 0;
 }
 
-void __reloc_to_insn(struct reloc *reloc, struct section *sec, unsigned long offset)
+static int insn_to_sym_addend(struct section *sec, unsigned long offset,
+			      struct symbol **sym, int *addend)
 {
 	if (sec->sym) {
-		reloc->sym = sec->sym;
-		reloc->addend = offset;
-		return;
+		*sym = sec->sym;
+		*addend = offset;
+		return 0;
 	}
 
 	/*
 	 * The Clang assembler strips section symbols, so we have to reference
 	 * the function symbol instead:
 	 */
-	reloc->sym = find_symbol_containing(sec, offset);
-	if (!reloc->sym) {
+	*sym = find_symbol_containing(sec, offset);
+	if (!*sym) {
 		/*
 		 * Hack alert.  This happens when we need to reference the NOP
 		 * pad insn immediately after the function.
 		 */
-		reloc->sym = find_symbol_containing(sec, offset - 1);
+		*sym = find_symbol_containing(sec, offset - 1);
 	}
 
-	if (reloc->sym)
-		reloc->addend = offset - reloc->sym->offset;
-}
-
-struct reloc *elf_create_reloc(struct elf *elf,
-			       struct section *sec, unsigned long offset,
-			       unsigned int type,
-			       void (*set_dest)(struct reloc *, void *), void *dst, int addend)
-{
-	struct reloc *reloc;
-
-	reloc = malloc(sizeof(*reloc));
-	if (!reloc) {
-		perror("malloc");
-		return NULL;
+	if (!*sym) {
+		WARN("can't find symbol containing %s+0x%lx", sec->name, offset);
+		return -1;
 	}
-	memset(reloc, 0, sizeof(*reloc));
 
-	reloc->sec = sec->reloc;
-	reloc->offset = offset;
-	reloc->type = type;
+	*addend = offset - (*sym)->offset;
+	return 0;
+}
 
-	set_dest(reloc, dst);
-	if (!reloc->sym) {
-		WARN("failed to create reloc");
-		return NULL;
-	}
 
-	reloc->addend += addend;
+int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
+			  unsigned long offset, unsigned int type,
+			  struct section *insn_sec, unsigned long insn_off)
+{
+	struct symbol *sym;
+	int addend;
 
-	elf_add_reloc(elf, reloc);
+	if (insn_to_sym_addend(insn_sec, insn_off, &sym, &addend))
+		return -1;
 
-	return reloc;
+	return elf_add_reloc(elf, sec, offset, type, sym, addend);
 }
 
 static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 8f31f96c8fe1..f5be798107bc 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -9,7 +9,6 @@
 #include <stdbool.h>
 #include <objtool/cfi.h>
 #include <objtool/arch.h>
-#include <objtool/elf.h>
 
 struct insn_state {
 	struct cfi_state cfi;
@@ -92,10 +91,4 @@ struct instruction *find_insn(struct objtool_file *file,
 			insn->sec == sec;				\
 	     insn = list_next_entry(insn, list))
 
-static inline void reloc_to_insn(struct reloc *reloc, void *dst)
-{
-	struct instruction *insn = dst;
-	__reloc_to_insn(reloc, insn->sec, insn->offset);
-}
-
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 8b11f3cdad98..825ad326201d 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -124,13 +124,11 @@ struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 
-void reloc_to_sym(struct reloc *reloc, void *sym);
-void __reloc_to_insn(struct reloc *reloc, struct section *sec, unsigned long offset);
-
-struct reloc *elf_create_reloc(struct elf *elf,
-			       struct section *sec, unsigned long offset,
-			       unsigned int type,
-			       void (*set_dest)(struct reloc *reloc, void *), void *dst, int addend);
+int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
+		  unsigned int type, struct symbol *sym, int addend);
+int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
+			  unsigned long offset, unsigned int type,
+			  struct section *insn_sec, unsigned long insn_off);
 
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
@@ -148,8 +146,6 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
-			      struct reloc *reloc);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dfc3cc6ef4aa..1b57be6508f4 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -81,24 +81,11 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
 	return 0;
 }
 
-struct orc_list_entry {
-	struct list_head list;
-	struct orc_entry orc;
-	struct section *insn_sec;
-	unsigned long insn_off;
-};
-
-static void reloc_to_orc(struct reloc *reloc, void *dst)
-{
-	struct orc_list_entry *entry = dst;
-	__reloc_to_insn(reloc, entry->insn_sec, entry->insn_off);
-}
-
 static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 			   struct section *ip_sec, unsigned int idx,
-			   struct orc_list_entry *entry)
+			   struct section *insn_sec, unsigned long insn_off,
+			   struct orc_entry *o)
 {
-	struct orc_entry *o = &entry->orc;
 	struct orc_entry *orc;
 
 	/* populate ORC data */
@@ -108,16 +95,20 @@ static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	orc->bp_offset = bswap_if_needed(orc->bp_offset);
 
 	/* populate reloc for ip */
-	if (!elf_create_reloc(elf, ip_sec, idx * sizeof(int),
-			      R_X86_64_PC32,
-			      reloc_to_orc, entry, 0)) {
-		WARN_ELF("elf_create_reloc: ORC ip");
+	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_X86_64_PC32,
+				  insn_sec, insn_off))
 		return -1;
-	}
 
 	return 0;
 }
 
+struct orc_list_entry {
+	struct list_head list;
+	struct orc_entry orc;
+	struct section *insn_sec;
+	unsigned long insn_off;
+};
+
 static int orc_list_add(struct list_head *orc_list, struct orc_entry *orc,
 			struct section *sec, unsigned long offset)
 {
@@ -239,7 +230,9 @@ int orc_create(struct objtool_file *file)
 
 	/* Write ORC entries to sections: */
 	list_for_each_entry(entry, &orc_list, list) {
-		if (write_orc_entry(file->elf, orc_sec, sec, idx++, entry))
+		if (write_orc_entry(file->elf, orc_sec, sec, idx++,
+				    entry->insn_sec, entry->insn_off,
+				    &entry->orc))
 			return -1;
 	}
 

