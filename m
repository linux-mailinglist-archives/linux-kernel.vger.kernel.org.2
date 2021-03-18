Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695B7340BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhCRRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhCRRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75762C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=v6Mdg3dOUdpWrz7saxFKxGQVkoKIfFRx82pjr9Ly6oc=; b=X/pRvT1ue5pR78m/+0BA8DU9XX
        t1TjPn7E0X9bamA7O+AjjvexHnrTWDkerYtZipU5Yaco5wJqNbjNTVaOJ9TiIswMEjSzXtdaG9pdL
        4sbqg9yXt/2MmvgfYNzDDDN48Cz+aXS3ObMxXZUTDQM4WIDLNizCaVmxpdW/++5f9C5MoNhGeLsBp
        5H7z64CbL4N/MMQX1e8QjeFppALZARP/DZGZuIADeFnyqfYcX8K/LwHJ7KmWNLCVudcl5xQo2eRoB
        BID/mqcQbC/Itx4ZgHXPoOAtFizFeWYOlOMOYMcAfzXnWEhxpdLKPTi984pfta6CkPwGsgi84Yr/r
        EzJGrwKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-003HIY-JH; Thu, 18 Mar 2021 17:23:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5365C307963;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 45E97238A4644; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171920.068888092@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 11/14] objtool: Add elf_create_undef_symbol()
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow objtool to create undefined symbols; this allows creating
relocations to symbols not currently in the symbol table.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c                 |   63 ++++++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |    1 
 2 files changed, 64 insertions(+)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -724,6 +724,69 @@ static int elf_strtab_concat(struct elf
 	return len;
 }
 
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
+{
+	struct section *symtab;
+	struct symbol *sym;
+	Elf_Data *data;
+	Elf_Scn *s;
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
+	sym->sym.st_name = elf_strtab_concat(elf, sym->name, NULL);
+	if (sym->sym.st_name == -1)
+		return NULL;
+
+	sym->sym.st_info = 0x10; /* STB_GLOBAL, STT_NOTYPE */
+	// st_other 0
+	// st_shndx 0
+	// st_value 0
+	// st_size 0
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
+	sym->sec = find_section_by_index(elf, 0);
+
+	if (!elf_symbol_add(elf, sym)) {
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
@@ -136,6 +136,7 @@ int elf_write_insn(struct elf *elf, stru
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
 int elf_write_reloc(struct elf *elf, struct reloc *reloc);
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 


