Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AD034AB41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCZPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhCZPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:14:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928FC0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7XDCXuUgEAQwZNkBPHsOPvnJihRn+w4tU0oySokV9RA=; b=OInUWHXJbga4ybeyx4W8/3hTNS
        VAodUwxb4XixxhAuNs9N1I9pm7priSCYcS605QemQaKyYcgIuQlqx2ER0iU8y2ytCsJmp2L47P4+6
        RnC1wWvx3VauyEHpi2zcov7XJ8PLZadbCUIAoyRQQMTrRbNL4GBuBfP8llhgp/VKWaIPsPGLLpHwP
        CY5gHQV0IRAA2hBQAX70X7ce6PkAr9pZMT9b7oAxvh5qfGIWyZ4htIVelA3gXfrB6TjyxwZlRMN9x
        +zWiiyQCj4fKWD9y0RoQVNINswFEuL0C8KIsN8EytQfdD7yf1qGvIqJFOrB3O2/zoQz4VZPqFXchh
        +AjkO3MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9Y-00F0oX-EL; Fri, 26 Mar 2021 15:14:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7C53307993;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4FF202BD73396; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151259.754213408@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 07/16] objtool: Rework rebuild_reloc logic
References: <20210326151159.128534163@infradead.org>
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
 tools/objtool/check.c               |    6 ------
 tools/objtool/elf.c                 |   20 ++++++++++++++------
 tools/objtool/include/objtool/elf.h |    1 -
 tools/objtool/orc_gen.c             |    3 ---
 4 files changed, 14 insertions(+), 16 deletions(-)

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
 
@@ -614,9 +611,6 @@ static int create_mcount_loc_sections(st
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
+	sec->changed = true;
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
@@ -873,14 +877,11 @@ static int elf_rebuild_rela_reloc_sectio
 	return 0;
 }
 
-int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
+static int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 {
 	struct reloc *reloc;
 	int nr;
 
-	sec->changed = true;
-	elf->changed = true;
-
 	nr = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list)
 		nr++;
@@ -944,9 +945,15 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
-	/* Update section headers for changed sections: */
+	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
+			if (sec->base &&
+			    elf_rebuild_reloc_section(elf, sec)) {
+				WARN("elf_rebuild_reloc_section");
+				return -1;
+			}
+
 			s = elf_getscn(elf->elf, sec->idx);
 			if (!s) {
 				WARN_ELF("elf_getscn");
@@ -958,6 +965,7 @@ int elf_write(struct elf *elf)
 			}
 
 			sec->changed = false;
+			elf->changed = true;
 		}
 	}
 
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -142,7 +142,6 @@ struct reloc *find_reloc_by_dest_range(c
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
 			      struct reloc *reloc);
-int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
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


