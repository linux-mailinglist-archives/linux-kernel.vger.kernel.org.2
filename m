Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6023E339487
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhCLRSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhCLRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:18:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F76C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3vPoZkrKeiK4JPBw7+vZIWdXmKr4+YumvsYH8ORDDis=; b=ZiHvwoQExFfcNPkuGTgfTZYMFr
        E3X58qVO+ksvAmS9KoBn4ZepF9lO61lJVOAajuHzuZrcqQysEljGCyE0bVcldra0OeypWchJSV7fI
        aq4fd10TKEj3EULLBDo4Q3Lo4blU5eh5EFrrz6O8JDbeZEGtzbZ8hcl1VFnwOIuDJ4+kjhORahUHO
        dXhs/pm5EqKjHc3AatVGG+SeviBNlvRwi3caf82S/pXArxkcOW0DqKRvSA8me/vkVwomtbtDmf1BF
        tWbycGiCaoLN2CNgC7yBjzk8M/oYWa2jLk7rgR4+JLKxyiYJDwAlhAwQ4slrNNphs4+3bCDOGsv9m
        v4WKflZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQA-00C53G-Me; Fri, 12 Mar 2021 17:17:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46C57306E0C;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 10C9423CC2295; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.649709484@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 5/9] objtool: Rework rebuild_reloc logic
References: <20210312171613.533405394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually calling elf_rebuild_reloc_section() on sections
we've called elf_add_reloc() on, have elf_write() DTRT.

This makes it easier to add random relocations in places without
carefully tracking when we're done and need to flush what section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c               |    3 ---
 tools/objtool/elf.c                 |   13 ++++++++++++-
 tools/objtool/include/objtool/elf.h |    2 +-
 tools/objtool/orc_gen.c             |    3 ---
 4 files changed, 13 insertions(+), 8 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -542,9 +542,6 @@ static int create_static_call_sections(s
 		idx++;
 	}
 
-	if (elf_rebuild_reloc_section(file->elf, reloc_sec))
-		return -1;
-
 	return 0;
 }
 
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -479,6 +479,8 @@ void elf_add_reloc(struct elf *elf, stru
 
 	list_add_tail(&reloc->list, &sec->reloc_list);
 	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+
+	sec->rereloc = true;
 }
 
 static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
@@ -558,7 +560,9 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 
-			elf_add_reloc(elf, reloc);
+			list_add_tail(&reloc->list, &sec->reloc_list);
+			elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+
 			nr_reloc++;
 		}
 		max_reloc = max(max_reloc, nr_reloc);
@@ -890,6 +894,8 @@ int elf_rebuild_reloc_section(struct elf
 	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec, nr);
 	default:       return -1;
 	}
+
+	sec->rereloc = false;
 }
 
 int elf_write_insn(struct elf *elf, struct section *sec,
@@ -944,6 +950,11 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
+	list_for_each_entry(sec, &elf->sections, list) {
+		if (sec->reloc && sec->reloc->rereloc)
+			elf_rebuild_reloc_section(elf, sec->reloc);
+	}
+
 	/* Update section headers for changed sections: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, rereloc;
 };
 
 struct symbol {
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -254,8 +254,5 @@ int orc_create(struct objtool_file *file
 			return -1;
 	}
 
-	if (elf_rebuild_reloc_section(file->elf, ip_rsec))
-		return -1;
-
 	return 0;
 }


