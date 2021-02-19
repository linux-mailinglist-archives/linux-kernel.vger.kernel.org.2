Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778FB320020
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBSVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBSVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:10:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B44BC06178B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3vPoZkrKeiK4JPBw7+vZIWdXmKr4+YumvsYH8ORDDis=; b=FFtAgiJtTpyvmlMdZTSOKena+Y
        5rtWOnfFfVJYs0g+ZaB9m2MgN6+wg37fpq2siZxUU1qRWQqB9pkrxS0suc1BA1Zq3tjnvuRpWkUwy
        l2QSTxAemvz929CNpYPpkvit88To8GoRNJHGOwtc5fHsNhEJCS14DvlYR9gVzeUvoDXejXySJX1oe
        d3gT24XwiInHmx+x3SUKkHwujDQbJCs8ygsjhF/PSFAgVJnBHijCH1EvIh0KxezQRat4Rd1J9fuvW
        +pWNaCCfz0DsTboEozeJ64jOGsJ9TKVZhq66fWhx/2qIiMfWjR3V0QIUcUFCAcrmQbP312w8jJNBg
        +LIO626A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDD2N-0006Gc-U3; Fri, 19 Feb 2021 21:10:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 697BC306099;
        Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4A8DA20215560; Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Message-ID: <20210219210535.312773268@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Feb 2021 21:43:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, x86@kernel.org, pjt@google.com,
        mbenes@suze.cz, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 3/6] objtool: Rework rebuild_reloc logic
References: <20210219204300.749932493@infradead.org>
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


