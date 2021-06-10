Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A173A341E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFJTgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:36:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D740C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0WsSSFAZtWvDuAL5HUXTcX5Z6Hke2LSIWc8Z2dlCrBA=; b=glc1Sg7deBg5NLFOBUbJTmkByJ
        VAVxjvD2bUgJfpfxdxahgXgaX6v131VnSgn/pX1N1j+IaeVsGCCMUWKkPd+Z8SDV8UdEMIiPj709S
        D+eOIQ0tP6eYfhfZK3FZHeh4WEkBgyGZ3QQmkiiGNEHlC4k33JEjUVbc1ttGROxSd5zuhHatKMP5V
        QBRsVfe8E5BTYYYPwr9L7Mo6WZLLQuJWyyhfDqt45oHRvi/pST+fPzw3BpbV1wY3vbWkKfiP20ls4
        iM4JVO0oLBfpTPkSfrC+XM4uu4RuwKf9o1OTk3kKasP2lSLqn/izW0T4WQBCXHeE9oacq46FfG5KX
        dI7ExUag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrQQs-005cFg-19; Thu, 10 Jun 2021 19:33:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 308CF3001E4;
        Thu, 10 Jun 2021 21:33:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C2032081180A; Thu, 10 Jun 2021 21:33:44 +0200 (CEST)
Date:   Thu, 10 Jun 2021 21:33:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
Message-ID: <YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net>
References: <20210506193352.719596001@infradead.org>
 <20210506194157.452881700@infradead.org>
 <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
 <CABCJKudzC-Nss_LGrpYwRqwdDxeWOf1o6Bvp3J2fBQthEB=WGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudzC-Nss_LGrpYwRqwdDxeWOf1o6Bvp3J2fBQthEB=WGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:50:36AM -0700, Sami Tolvanen wrote:
> On Thu, Jun 10, 2021 at 11:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > Adding Sami because I am not sure why this patch would have much of an impact
> > in relation to LTO. https://git.kernel.org/tip/25cf0d8aa2a3 is the patch in
> > question.
> 
> It's because LLVM enables -ffunction-sections with LTO, so using .text
> section size to estimate the reloc hash table size isn't going to be
> accurate, as confirmed by objtool output with --stats:
> 
>   OBJTOOL vmlinux.o
> nr_sections: 141481
> section_bits: 17
> nr_symbols: 215262
> symbol_bits: 17
> max_reloc: 24850
> tot_reloc: 590890
> reloc_bits: 10

Bah. Would something like the *completely* untested below help with that?

---
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 25f6d293bc86..8676c7598728 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -288,6 +288,9 @@ static int read_sections(struct elf *elf)
 		}
 		sec->len = sec->sh.sh_size;
 
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
+			elf->text_size += sec->len;
+
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(section, &sec->hash, sec->idx);
 		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
@@ -581,13 +584,7 @@ static int read_relocs(struct elf *elf)
 	unsigned int symndx;
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 
-	sec = find_section_by_name(elf, ".text");
-	if (!sec) {
-		WARN("no .text");
-		return -1;
-	}
-
-	if (!elf_alloc_hash(reloc, sec->len / 16))
+	if (!elf_alloc_hash(reloc, elf->text_size / 16))
 		return -1;
 
 	list_for_each_entry(sec, &elf->sections, list) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 90082751f851..e34395047530 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -83,6 +83,7 @@ struct elf {
 	int fd;
 	bool changed;
 	char *name;
+	unsigned int text_size;
 	struct list_head sections;
 
 	int symbol_bits;
