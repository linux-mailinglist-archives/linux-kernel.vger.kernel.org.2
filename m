Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5B340BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhCRRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhCRRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:23:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E4C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AWSZ5+HA8g/DABqmwv5aT73RIrYio9cC9R0m3dkXyd0=; b=MZwj4UexO7OwYstwel6eIr9h4/
        S7Fgd1WG0oiZHiylW56TFF5120QR59tX+cwyRFZK8vSMiqaEr5BSHxqG+Wn4kct1IHYosc/8xA0a0
        nJ2IDGte9oCXRsyNGxXbjXTljb6p7MD6Z0AHAr7bw9sRX11ahRkLDdT4RhCSDit66FGMcNZ8KBXeB
        CrFcolpfcjPYIRAUXMdOui8BPewojkhQ7rF6kcFy5uj3jVVq9ftOSnkmof6BhgWexdecrFVqNVMer
        jH4b7g0mY/CahA9Cx0GczH6q8lBwjfgayPK73PddsCuWYakcqvDQup0mgWOWP4AlhV9J4pKKT2A14
        XyRcpyLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-005kF0-Kj; Thu, 18 Mar 2021 17:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C9F8307938;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3D456213C0F59; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171920.007925810@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 10/14] objtool: Extract elf_symbol_add()
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common helper to add symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   57 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -290,12 +290,41 @@ static int read_sections(struct elf *elf
 	return 0;
 }
 
+static bool elf_symbol_add(struct elf *elf, struct symbol *sym)
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
@@ -340,9 +369,6 @@ static int read_symbols(struct elf *elf)
 			goto err;
 		}
 
-		sym->type = GELF_ST_TYPE(sym->sym.st_info);
-		sym->bind = GELF_ST_BIND(sym->sym.st_info);
-
 		if ((sym->sym.st_shndx > SHN_UNDEF &&
 		     sym->sym.st_shndx < SHN_LORESERVE) ||
 		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
@@ -362,25 +388,8 @@ static int read_symbols(struct elf *elf)
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
+		if (!elf_symbol_add(elf, sym))
+			goto err;
 	}
 
 	if (stats)


