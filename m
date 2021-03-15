Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0333B240
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCOMJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhCOMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:09:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LnkvBLQo1oDTbEhidBlt/auC2+gvICC3FjVkyNa3o6Q=; b=DUlr+N5PBeGKH6zs0tQOS5S/FK
        hDLD9NDcmV/xKafUngH1KJd1DU8Fy4enMx6i40lDJmq8/lBkhV+94s2iWh4gedeunmC+4TbLih5XA
        7GKXiZL1jHCwqJGJ93OfRP6VvyIlpxECRkBL4Vw+zueSZRHOz2OsxxRulDSfroEbCfg6z59TSr9Ux
        3YM4do5N6gmGwDnOgXuIJrcWq4VZpxyRveby5D9tw5QvMVIwd2DHGDZi71KbW0jcR8roQZEqHH2fu
        ztgjxZpEVUpHrk15gw9mY0Bqieu4M5DiOTcE4NotE/UWYpEavV/aVW5au9DoOz0vvTtQkuIRt1NHa
        bsciY3zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLm1M-0007sV-J2; Mon, 15 Mar 2021 12:08:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D00E6305C22;
        Mon, 15 Mar 2021 13:08:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88B3020D71CF8; Mon, 15 Mar 2021 13:08:27 +0100 (CET)
Date:   Mon, 15 Mar 2021 13:08:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
 <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
 <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net>
 <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
 <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 12:26:12PM +0100, Peter Zijlstra wrote:
> Ooooh, modules don't have this. They still have regular
> .static_call_sites sections, and *those* are unaligned.
> 
> Section Headers:
> [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
> 
> [16] .static_call_sites PROGBITS        0000000000000000 008aa1 0006f0 00  WA  0   0  1
> 
> And that goes *BOOM*.. Let me ses if I can figure out how to make
> objtool align those sections.

The below seems to have cured it:

[16] .static_call_sites PROGBITS        0000000000000000 008aa8 0006f0 00  WA  0   0  8


So, anybody any opinion on if we ought to do this?


---
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -683,7 +683,7 @@ static int elf_add_alternative(struct el
 	sec = find_section_by_name(elf, ".altinstructions");
 	if (!sec) {
 		sec = elf_create_section(elf, ".altinstructions",
-					 SHF_WRITE, size, 0);
+					 SHF_WRITE, size, 1, 0);
 
 		if (!sec) {
 			WARN_ELF("elf_create_section");
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -456,7 +456,7 @@ static int create_static_call_sections(s
 		idx++;
 
 	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
-				 sizeof(struct static_call_site), idx);
+				 sizeof(struct static_call_site), sizeof(unsigned long), idx);
 	if (!sec)
 		return -1;
 
@@ -567,7 +567,8 @@ static int create_mcount_loc_sections(st
 	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
+	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long),
+				sizeof(unsigned long), idx);
 	if (!sec)
 		return -1;
 
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -737,7 +737,8 @@ struct symbol *elf_create_undef_symbol(s
 }
 
 struct section *elf_create_section(struct elf *elf, const char *name,
-				   unsigned int sh_flags, size_t entsize, int nr)
+				   unsigned int sh_flags, size_t entsize,
+				   size_t entalign, int nr)
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
@@ -777,7 +778,7 @@ struct section *elf_create_section(struc
 	}
 
 	sec->data->d_size = size;
-	sec->data->d_align = 1;
+	sec->data->d_align = entalign;
 
 	if (size) {
 		sec->data->d_buf = malloc(size);
@@ -796,7 +797,7 @@ struct section *elf_create_section(struc
 	sec->sh.sh_size = size;
 	sec->sh.sh_entsize = entsize;
 	sec->sh.sh_type = SHT_PROGBITS;
-	sec->sh.sh_addralign = 1;
+	sec->sh.sh_addralign = entalign;
 	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
 
 
@@ -852,7 +853,7 @@ static struct section *elf_create_rel_re
 	strcpy(relocname, ".rel");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rel), 0);
+	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rel), 1, 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
@@ -882,7 +883,7 @@ static struct section *elf_create_rela_r
 	strcpy(relocname, ".rela");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);
+	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 1, 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -121,7 +121,7 @@ static inline u32 reloc_hash(struct relo
 }
 
 struct elf *elf_open_read(const char *name, int flags);
-struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
+struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, size_t entalign, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 void elf_add_reloc(struct elf *elf, struct reloc *reloc);
 int elf_write_insn(struct elf *elf, struct section *sec,
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -235,11 +235,11 @@ int orc_create(struct objtool_file *file
 		return -1;
 	}
 	orc_sec = elf_create_section(file->elf, ".orc_unwind", 0,
-				     sizeof(struct orc_entry), nr);
+				     sizeof(struct orc_entry), 1, nr);
 	if (!orc_sec)
 		return -1;
 
-	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
+	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), 1, nr);
 	if (!sec)
 		return -1;
 	ip_rsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
