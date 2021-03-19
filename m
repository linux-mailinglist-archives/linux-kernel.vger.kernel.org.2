Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3AC3418BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCSJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:48:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54432C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FL98dJe6LUC1UXgwxrVI5N5yKW62jyZF78cRbTNAVD8=; b=wBtJly1FjwocHJ6rUJoK7HIWgX
        8w6fNgu1LYTG9WhO9VQmgOaXDEilzy/4GnfDmB7SRhYK5CRiA7wXr+YBDxoxNZJmWMlgGgeL1ssnB
        shayrtqqOclFEANR/KmXWnz83RJxF1wckQ9+VekGYqq+lXJNVGlJGGADW0bxVesd6AxufMZt0mmq7
        ppDavv0jpSMTvWBW56rbfeEetVFcPgHzC3bi3K/oTYnyMCw2sjlCsHc9IVcvukYgvfTfRwblwtmpo
        wWzgxl/r7JUNBkL2tlILcgiA0E65aBzjT1Bl8ZUKqZVckHKbP/KrUO8+CnpqJv/e3arHC9qyLJ1sF
        +b4/xgXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNBjF-004F3k-Pe; Fri, 19 Mar 2021 09:47:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5CE630018A;
        Fri, 19 Mar 2021 10:47:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2E862B4C3BDF; Fri, 19 Mar 2021 10:47:36 +0100 (CET)
Date:   Fri, 19 Mar 2021 10:47:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] objtool: Add elf_create_reloc() helper
Message-ID: <YFRzOFp5/pHaLDti@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.887152166@infradead.org>
 <20210319014246.c6trc4x3qewro32c@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319014246.c6trc4x3qewro32c@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:42:46PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:11:11PM +0100, Peter Zijlstra wrote:
> > We have 4 instances of adding a relocation. Create a common helper
> > to avoid growing even more.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I'm not a fan of the API -- how about squashing this in?  Untested, of
> course.

Can do.. I do seem to have over-cooked it a bit.

> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index d2afe2454de4..b3bd97b2b034 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -447,76 +447,73 @@ static int read_symbols(struct elf *elf)
>  	return -1;
>  }
>  
> -static void elf_add_reloc(struct elf *elf, struct reloc *reloc)
> +int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
> +		  unsigned int type, struct symbol *sym, int addend)
>  {
> -	struct section *sec = reloc->sec;
> +	struct reloc *reloc;
> +
> +	reloc = malloc(sizeof(*reloc));
> +	if (!reloc) {
> +		perror("malloc");
> +		return -1;
> +	}
> +	memset(reloc, 0, sizeof(*reloc));
> +
> +	reloc->sec = sec->reloc;
> +	reloc->offset = offset;
> +	reloc->type = type;
> +	reloc->sym = sym;
> +	reloc->addend = addend;
>  
>  	list_add_tail(&reloc->list, &sec->reloc_list);
>  	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
>  
> -	sec->changed = true;
> -}

I'm thinking we have to mark something changed though; I've added
sec->reloc->changed = true; there.

> +static int insn_to_sym_addend(struct section *sec, unsigned long offset,
> +			      struct symbol **sym, int *addend)
>  {
>  	if (sec->sym) {
> +		*sym = sec->sym;
> +		*addend = offset;
> +		return 0;
>  	}
>  
>  	/*
>  	 * The Clang assembler strips section symbols, so we have to reference
>  	 * the function symbol instead:
>  	 */
> +	*sym = find_symbol_containing(sec, offset);
> +	if (!*sym) {
>  		/*
>  		 * Hack alert.  This happens when we need to reference the NOP
>  		 * pad insn immediately after the function.
>  		 */
> +		*sym = find_symbol_containing(sec, offset - 1);
>  	}
>  
> +	if (!*sym) {
> +		WARN("can't find symbol containing %s+0x%lx", sec->name, offset);
> +		return -1;
>  	}
>  
> +	*addend = offset - (*sym)->offset;
> +	return 0;
> +}
>  
> +int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
> +			  unsigned long offset, unsigned int type,
> +			  struct section *insn_sec, unsigned long insn_off)
> +{
> +	struct symbol *sym;
> +	int addend;
>  
> +	if (insn_to_sym_addend(insn_sec, insn_off, &sym, &addend))
> +		return -1;

Might be simpler to not have that function and just do it here instead.

>  
> +	return elf_add_reloc(elf, sec, offset, type, sym, addend);
>  }



Full patch, because diff on a diff on a diff is getting ludicrous hard
to read :-)

---
 check.c               |   78 +++++++++-------------------------------------
 elf.c                 |   84 ++++++++++++++++++++++++++++++++------------------
 include/objtool/elf.h |   10 ++++-
 orc_gen.c             |   30 +++--------------
 4 files changed, 84 insertions(+), 118 deletions(-)

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
@@ -471,25 +469,11 @@ static int create_static_call_sections(s
 		memset(site, 0, sizeof(struct static_call_site));
 
 		/* populate reloc for 'addr' */
-		reloc = malloc(sizeof(*reloc));
-
-		if (!reloc) {
-			perror("malloc");
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(struct static_call_site),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset))
 			return -1;
-		}
-		memset(reloc, 0, sizeof(*reloc));
-
-		insn_to_reloc_sym_addend(insn->sec, insn->offset, reloc);
-		if (!reloc->sym) {
-			WARN_FUNC("static call tramp: missing containing symbol",
-				  insn->sec, insn->offset);
-			return -1;
-		}
-
-		reloc->type = R_X86_64_PC32;
-		reloc->offset = idx * sizeof(struct static_call_site);
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
 
 		/* find key symbol */
 		key_name = strdup(insn->call_dest->name);
@@ -526,18 +510,11 @@ static int create_static_call_sections(s
 		free(key_name);
 
 		/* populate reloc for 'key' */
-		reloc = malloc(sizeof(*reloc));
-		if (!reloc) {
-			perror("malloc");
+		if (elf_add_reloc(file->elf, sec,
+				  idx * sizeof(struct static_call_site) + 4,
+				  R_X86_64_PC32, key_sym,
+				  is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
-		}
-		memset(reloc, 0, sizeof(*reloc));
-		reloc->sym = key_sym;
-		reloc->addend = is_sibling_call(insn) ? STATIC_CALL_SITE_TAIL : 0;
-		reloc->type = R_X86_64_PC32;
-		reloc->offset = idx * sizeof(struct static_call_site) + 4;
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
 
 		idx++;
 	}
@@ -547,8 +524,7 @@ static int create_static_call_sections(s
 
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
-	struct section *sec, *reloc_sec;
-	struct reloc *reloc;
+	struct section *sec;
 	unsigned long *loc;
 	struct instruction *insn;
 	int idx;
@@ -571,8 +547,7 @@ static int create_mcount_loc_sections(st
 	if (!sec)
 		return -1;
 
-	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!reloc_sec)
+	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
 		return -1;
 
 	idx = 0;
@@ -581,32 +556,11 @@ static int create_mcount_loc_sections(st
 		loc = (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
 
-		reloc = malloc(sizeof(*reloc));
-		if (!reloc) {
-			perror("malloc");
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(unsigned long),
+					  R_X86_64_64,
+					  insn->sec, insn->offset))
 			return -1;
-		}
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
@@ -473,14 +447,66 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
-void elf_add_reloc(struct elf *elf, struct reloc *reloc)
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
+	sec->reloc->changed = true;
+
+	return 0;
+}
+
+int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
+			  unsigned long offset, unsigned int type,
+			  struct section *insn_sec, unsigned long insn_off)
+{
+	struct symbol *sym;
+	int addend;
+
+	if (sec->sym) {
+		sym = sec->sym;
+		addend = offset;
+
+	} else {
+		/*
+		 * The Clang assembler strips section symbols, so we have to
+		 * reference the function symbol instead:
+		 */
+		sym = find_symbol_containing(sec, offset);
+		if (!sym) {
+			/*
+			 * Hack alert.  This happens when we need to reference
+			 * the NOP pad insn immediately after the function.
+			 */
+			sym = find_symbol_containing(sec, offset - 1);
+		}
+
+		if (!sym) {
+			WARN("can't find symbol containing %s+0x%lx", sec->name, offset);
+			return -1;
+		}
+
+		addend = offset - sym->offset;
+	}
+
+	return elf_add_reloc(elf, sec, offset, type, sym, addend);
 }
 
 static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -123,7 +123,13 @@ static inline u32 reloc_hash(struct relo
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
-void elf_add_reloc(struct elf *elf, struct reloc *reloc);
+
+int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
+		  unsigned int type, struct symbol *sym, int addend);
+int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
+			  unsigned long offset, unsigned int type,
+			  struct section *insn_sec, unsigned long insn_off);
+
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
@@ -140,8 +146,6 @@ struct reloc *find_reloc_by_dest(const s
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
-			      struct reloc *reloc);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -82,12 +82,11 @@ static int init_orc_entry(struct orc_ent
 }
 
 static int write_orc_entry(struct elf *elf, struct section *orc_sec,
-			   struct section *ip_rsec, unsigned int idx,
+			   struct section *ip_sec, unsigned int idx,
 			   struct section *insn_sec, unsigned long insn_off,
 			   struct orc_entry *o)
 {
 	struct orc_entry *orc;
-	struct reloc *reloc;
 
 	/* populate ORC data */
 	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
@@ -96,25 +95,9 @@ static int write_orc_entry(struct elf *e
 	orc->bp_offset = bswap_if_needed(orc->bp_offset);
 
 	/* populate reloc for ip */
-	reloc = malloc(sizeof(*reloc));
-	if (!reloc) {
-		perror("malloc");
+	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_X86_64_PC32,
+				  insn_sec, insn_off))
 		return -1;
-	}
-	memset(reloc, 0, sizeof(*reloc));
-
-	insn_to_reloc_sym_addend(insn_sec, insn_off, reloc);
-	if (!reloc->sym) {
-		WARN("missing symbol for insn at offset 0x%lx",
-		     insn_off);
-		return -1;
-	}
-
-	reloc->type = R_X86_64_PC32;
-	reloc->offset = idx * sizeof(int);
-	reloc->sec = ip_rsec;
-
-	elf_add_reloc(elf, reloc);
 
 	return 0;
 }
@@ -153,7 +136,7 @@ static unsigned long alt_group_len(struc
 
 int orc_create(struct objtool_file *file)
 {
-	struct section *sec, *ip_rsec, *orc_sec;
+	struct section *sec, *orc_sec;
 	unsigned int nr = 0, idx = 0;
 	struct orc_list_entry *entry;
 	struct list_head orc_list;
@@ -242,13 +225,12 @@ int orc_create(struct objtool_file *file
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
+		if (write_orc_entry(file->elf, orc_sec, sec, idx++,
 				    entry->insn_sec, entry->insn_off,
 				    &entry->orc))
 			return -1;
