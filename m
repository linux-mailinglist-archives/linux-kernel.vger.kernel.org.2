Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0006C39D907
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFGJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhFGJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:47:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC421C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XvU/QbyJGn8lDvoM8QDZ+4TpGmjEvYLZdccDnBNTbJM=; b=KsNviXN3hHuqdwXAV6LUHs99zV
        MMpfEEoveGbVBT/TXYMl+muqT2+8em8fghXwA8lF5waV96iuDCKyRTchbJ4O0JZUK7Mnyv7K/9nWk
        IyZ5it1PJyjJlGKOF/fOLzXz1xJFP3lDGjkbx3cGYvXotSaTeZMmodrKm9chwGbplylA+Tqod/NVC
        EIP+FZ8ADG05tTJOhmr43ZYNEZzyqfQ92wUav5ytOSKTRhifOxL7H+hEBbGsnK2iPq78e3ouBTQRN
        m+ieYXnqg1+Sy4XGQ6agCjaVgJvpl+Llb0AUTSgWAlzqN6oubkZRN0LCoTBdZhX9fgAIb1atVDWP7
        pI2FmIGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqBpR-004LRQ-54; Mon, 07 Jun 2021 09:46:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 018C630018A;
        Mon,  7 Jun 2021 11:45:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0C462CEABC10; Mon,  7 Jun 2021 11:45:58 +0200 (CEST)
Date:   Mon, 7 Jun 2021 11:45:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:22:11AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 07, 2021 at 09:56:48AM +0200, Peter Zijlstra wrote:
> > On Sat, Jun 05, 2021 at 06:58:39PM -0700, Fāng-ruì Sòng wrote:
> > > On Sat, Jun 5, 2021 at 3:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > I think you've absolutely nailed it; but would you have more information
> > > > or a code reference to what you're speaking about? My complete ELF
> > > > and libelf knowledge is very limited and as demonstrated here, I'm not
> > > > at all sure how all that extended index stuff is supposed to work.
> > > 
> > > The section index field of an Elf{32,64}_Sym (st_shndx) is 16-bit, so
> > > it cannot represent a section index greater than 0xffff.
> > > ELF actually reserves values in 0xff00~0xff00 for other purposes, so
> > > st_shndx cannot represent a section whose index is greater or equal to
> > > 0xff00.
> > 
> > Right, that's about as far as I got, but never could find details on how
> > the extension worked in detail, and I clearly muddled it :/
> 
> OK, so I'm all confused again...
> 
> So a .symtab entry has:
> 
> 	st_name  -- strtab offset for the name string
> 	st_value -- where this symbol lives
> 	st_size  -- size of symbol in bytes
> 	st_shndx -- section index to interpret the @st_value above
> 	st_info  -- type+bind
> 	st_other -- visibility
> 
> The thing is, we're adding UNDEF symbols, for the linker to resolve.
> UNDEF has:
> 
> 	st_value := 0
> 	st_size  := 0
> 	st_shndx := 0
> 	st_info  := GLOBAL + NOTYPE
> 	st_other := 0
> 
> Per that, sh_shndx isn't >= SHN_LORESERVE, and I figured we all good.
> 
> 
> Is the problem that .symtab_shndx is expected to contain the exact same
> number of entries as .symtab? And I'm adding to .symtab and not to
> .symtab_shndx, hence getting them out of sync?
> 
> Let me try adding 0s to .symtab_shndx. See if that makes readelf
> happier.

That does indeed seem to do the trick. Bit daft if you ask me, anybody
reading that file ought to have a handy bucket of 0s available, but
whatever.

---
 tools/objtool/elf.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 743c2e9d0f56..41bca1d13d8e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -717,7 +717,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 
 struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 {
-	struct section *symtab;
+	struct section *symtab, *symtab_shndx;
 	struct symbol *sym;
 	Elf_Data *data;
 	Elf_Scn *s;
@@ -769,6 +769,29 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	symtab->len += data->d_size;
 	symtab->changed = true;
 
+	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+	if (symtab_shndx) {
+		s = elf_getscn(elf->elf, symtab_shndx->idx);
+		if (!s) {
+			WARN_ELF("elf_getscn");
+			return NULL;
+		}
+
+		data = elf_newdata(s);
+		if (!data) {
+			WARN_ELF("elf_newdata");
+			return NULL;
+		}
+
+		data->d_buf = &sym->sym.st_size; /* conveniently 0 */
+		data->d_size = sizeof(Elf32_Word);
+		data->d_align = 4;
+		data->d_type = ELF_T_WORD;
+
+		symtab_shndx->len += 4;
+		symtab_shndx->changed = true;
+	}
+
 	sym->sec = find_section_by_index(elf, 0);
 
 	elf_add_symbol(elf, sym);
