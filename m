Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE334AB37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCZPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhCZPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:13:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2539CC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9UZwhEdTZIWzuKJCBvisbhXRBLCBRVkqI9z6qW4xhqM=; b=mgdOPPKJ6Bp0gRSwdmfYCJELdY
        NtZULLvcdV7fZBcHu4X5JARNmT97MgAmUtvyrCHuEcHMI+rH0VQL90Ay8x3a2O0Ja+6pnW/nWnGcY
        JV3Y1kBlxUtB+Xw4oA8gJ+jdqwxZK/No8VfO6GrZFEfoUlxuuLs4kWk+GxJuCKOOQ592lTaX+S6xg
        1c+MrcJCM00SM022kQJjJvgWOkdhvOtmkZPn1H2omfFOS6bOMA3MKA6f33zUbL/oFSUeHzCGWPBGT
        0ukgI5GrkcOR5/AdVcWYV+azfx+5k7JfbrNb8N/sTmwJeJeqyeJdH+FC/qZsAj0iP69VmSo3oOAfI
        JRsr8BTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9Y-003s0Q-FD; Fri, 26 Mar 2021 15:13:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE4403079A1;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69B172BD7339C; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151300.064743095@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 12/16] objtool: Add elf_create_undef_symbol()
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow objtool to create undefined symbols; this allows creating
relocations to symbols not currently in the symbol table.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c                 |   60 ++++++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |    1 
 2 files changed, 61 insertions(+)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -715,6 +715,66 @@ static int elf_add_string(struct elf *el
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
+	sym->sym.st_name = elf_add_string(elf, NULL, sym->name);
+	if (sym->sym.st_name == -1)
+		return NULL;
+
+	sym->sym.st_info = GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);
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
+	elf_add_symbol(elf, sym);
+
+	return sym;
+}
+
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -133,6 +133,7 @@ int elf_write_insn(struct elf *elf, stru
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
 int elf_write_reloc(struct elf *elf, struct reloc *reloc);
+struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 


