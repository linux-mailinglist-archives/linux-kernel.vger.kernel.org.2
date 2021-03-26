Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586DC34AB36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhCZPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCZPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:13:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD5C0613B5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cvpRtMp9Dj+4WOV7V5UJ0l1VlXpxuOgTyLUzpXXcnyc=; b=Zg1zC7x+SZJ601VknW/c6cxJuU
        bSwntd77lkl8WrNumVL3RxdIvgxrOhENHV+0EnITHxuSxFpCNBGYQOHYUvCCt5tygKPkEohra/id7
        jVAgp41jO84ocfZutXpQmXDtFzbxHe51KvGawCD+l7HE9b4kUhZP/FIJ5bEaeaJs3T3a9Mtj5RAwP
        nLYOmwI3HtNHC8BFZejqFRmNLpjVXDuV07dxjsoIk9fgLVffRG0AQggT9CpmVzuiXTs1gUkoyY0I6
        kneACKPCWnreKsbbYJqYpcify+xiYezjfIQGBUohxhP8TuOXNjF2qf7DeENyII6oje4NN1ZOX9ove
        cCx8UYQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9Y-003s0R-Fb; Fri, 26 Mar 2021 15:13:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC6FE30799A;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 604AF2BD7339B; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151300.003468981@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 11/16] objtool: Extract elf_symbol_add()
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common helper to add symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   56 ++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -290,12 +290,39 @@ static int read_sections(struct elf *elf
 	return 0;
 }
 
+static void elf_add_symbol(struct elf *elf, struct symbol *sym)
+{
+	struct list_head *entry;
+	struct rb_node *pnode;
+
+	sym->type = GELF_ST_TYPE(sym->sym.st_info);
+	sym->bind = GELF_ST_BIND(sym->sym.st_info);
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
@@ -340,9 +367,6 @@ static int read_symbols(struct elf *elf)
 			goto err;
 		}
 
-		sym->type = GELF_ST_TYPE(sym->sym.st_info);
-		sym->bind = GELF_ST_BIND(sym->sym.st_info);
-
 		if ((sym->sym.st_shndx > SHN_UNDEF &&
 		     sym->sym.st_shndx < SHN_LORESERVE) ||
 		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
@@ -355,32 +379,14 @@ static int read_symbols(struct elf *elf)
 				     sym->name);
 				goto err;
 			}
-			if (sym->type == STT_SECTION) {
+			if (GELF_ST_TYPE(sym->sym.st_info) == STT_SECTION) {
 				sym->name = sym->sec->name;
 				sym->sec->sym = sym;
 			}
 		} else
 			sym->sec = find_section_by_index(elf, 0);
 
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
+		elf_add_symbol(elf, sym);
 	}
 
 	if (stats)


