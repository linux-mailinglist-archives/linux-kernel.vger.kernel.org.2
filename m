Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED92340BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhCRRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhCRRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:23:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEA0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YeJKBwcy7zD5wcq0dNlGGtT9/kcm1Yj8/J/6AIz2Pfs=; b=Flpk4+yOu+6NEYRNRot1TO3uSG
        krrOT7j2O999xnYUJqCC8oSc47gbR+bHpIhoFxeyszn8bqPfJYX+cGZVPeDCT+ohzON4FTsRnofus
        /nTugMXC4PXzII2IH8JXq+/H54q4WrAC230AK/PgUUFrdCTKAUja9rMnk/kpJTcehIDR0sCnhQ9Tb
        TZN8yKVQVX448NaGFE2EHAoJ4HNeugo7eKXk1Nqbmz52tJiAHQe37ukTthe8u8Ze/kgpUuG1rpQAV
        u4CBl3W9bfBNk997RZVdum8uFm4Clca8qL9Xev2Y3qtx/6ncaeezkBZ4BoR8Gjlb6twgiDYGkd+3/
        n85H93Mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-005kEz-K6; Thu, 18 Mar 2021 17:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EE653077E1;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2E69C238A4647; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.826338610@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 07/14] objtool: Rework rebuild_reloc logic
References: <20210318171103.577093939@infradead.org>
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
+			if (sec->reloc &&
+			    elf_rebuild_reloc_section(elf, sec->reloc)) {
+				WARN_ELF("elf_rebuild_reloc_section");
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


