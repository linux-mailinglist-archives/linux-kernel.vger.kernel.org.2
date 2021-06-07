Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB239E53E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFGRZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFGRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:25:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2497FC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:23:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 11so9073152plk.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lzmLs1jCz0nheAy5QcLHpTMKZyU5KXq7lJsvla/Bzqc=;
        b=FGdQAr6rOLjErww9tM6OomsNyjzGHZd6UfPAJRjJKQPLsYNF0hQbrmjxxqYLZxol7E
         ZfzVD6921ns0l1UrdpHdV8tQ++jfbMIGKIr2RvLw7rqdC7DvvfVec7eWGUIK4aRGo78p
         DI/+TdUiTvG+lE4YK/R+0xyJnXtloTEn9JiqpzsGfTREbTmzooVN+FDgMjkYIU5de2fG
         GG4nhqD6zZzA8cLcRHOnfJafFV7WbSIFhjiatcyDQ6I/HWQBA3vG38ypFRf7pfc34T+S
         av7lhz8IySUi4nPURrrP/ALY16QGKbYd7lr0g6rSp2qodjy2az7ywOAfqDz++JsobPA5
         uZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lzmLs1jCz0nheAy5QcLHpTMKZyU5KXq7lJsvla/Bzqc=;
        b=ojhFoNtdOZYIGvkb9r7v0A5e1ct+vXilbeCVam5REEp4/BMQSkEkwvEsXiIK/xKjOO
         Ey391VDATT89rZyla9/D3B2lry95HQRzT9oOAyvbl3+TYK7SmLvKk4NminegOXTO/qnZ
         DmiJc65gcj+ZMrAqDiwdkgr1Fucar6QpJVFKyqgJpqHzTPFb7MSQ6MxE9d31U0Qd1JDe
         WMV+O2gJoGScXHt6YWBoPJ0biq4tEAFckt+tysEOkMdGWD1O2fbcpIAnR6TPJZME2JHA
         w3avwlueUKRilrj51aMJRRVmih4YYLDS6Mi2aq1EUEUEQjcSDirtv38y7+0GKjKJnxkm
         Oiug==
X-Gm-Message-State: AOAM530StreTeHI/KZcEbCQpTLM9pdIvf4HK2jesI6hgCvGLre8ZMpIv
        v4PI9zj3sn9p7uziFzJJ3I7UBQ==
X-Google-Smtp-Source: ABdhPJxjKL0BhKmKFKJh3G5MU2tactuY+JqrMI6evd24RR6eYXD84drZio0mf5bzU6Op3TIKzknEQg==
X-Received: by 2002:a17:90a:ab90:: with SMTP id n16mr168259pjq.223.1623086597440;
        Mon, 07 Jun 2021 10:23:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:949b:d340:d21:48a0])
        by smtp.gmail.com with ESMTPSA id d131sm8896063pfd.176.2021.06.07.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:23:15 -0700 (PDT)
Date:   Mon, 7 Jun 2021 10:23:11 -0700
From:   =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20210607172311.ynnrzihgz74vdyjq@google.com>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-07, Peter Zijlstra wrote:
>On Mon, Jun 07, 2021 at 11:22:11AM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 07, 2021 at 09:56:48AM +0200, Peter Zijlstra wrote:
>> > On Sat, Jun 05, 2021 at 06:58:39PM -0700, Fāng-ruì Sòng wrote:
>> > > On Sat, Jun 5, 2021 at 3:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> > > > I think you've absolutely nailed it; but would you have more information
>> > > > or a code reference to what you're speaking about? My complete ELF
>> > > > and libelf knowledge is very limited and as demonstrated here, I'm not
>> > > > at all sure how all that extended index stuff is supposed to work.
>> > >
>> > > The section index field of an Elf{32,64}_Sym (st_shndx) is 16-bit, so
>> > > it cannot represent a section index greater than 0xffff.
>> > > ELF actually reserves values in 0xff00~0xff00 for other purposes, so
>> > > st_shndx cannot represent a section whose index is greater or equal to
>> > > 0xff00.
>> >
>> > Right, that's about as far as I got, but never could find details on how
>> > the extension worked in detail, and I clearly muddled it :/
>>
>> OK, so I'm all confused again...
>>
>> So a .symtab entry has:
>>
>> 	st_name  -- strtab offset for the name string
>> 	st_value -- where this symbol lives
>> 	st_size  -- size of symbol in bytes
>> 	st_shndx -- section index to interpret the @st_value above
>> 	st_info  -- type+bind
>> 	st_other -- visibility
>>
>> The thing is, we're adding UNDEF symbols, for the linker to resolve.
>> UNDEF has:
>>
>> 	st_value := 0
>> 	st_size  := 0
>> 	st_shndx := 0
>> 	st_info  := GLOBAL + NOTYPE
>> 	st_other := 0
>>
>> Per that, sh_shndx isn't >= SHN_LORESERVE, and I figured we all good.
>>
>>
>> Is the problem that .symtab_shndx is expected to contain the exact same
>> number of entries as .symtab? And I'm adding to .symtab and not to
>> .symtab_shndx, hence getting them out of sync?

Yes. http://www.sco.com/developers/gabi/latest/ch4.sheader.html says
"Each value corresponds one to one with a symbol table entry and appear in the same order as those entries."

>> Let me try adding 0s to .symtab_shndx. See if that makes readelf
>> happier.
>
>That does indeed seem to do the trick. Bit daft if you ask me, anybody
>reading that file ought to have a handy bucket of 0s available, but
>whatever.

Does the representation use the section index directly? (sym->sym.st_shndx)
This can be fragile when the number of sections changes..., e.g. elf_add_section

So in llvm-objcopy's representation, the section index is represented as
the section object.

struct Symbol {
   ...
   SectionBase *DefinedIn = nullptr;
   ...
};

In the writer stage, sections are assigned 32-bit indexes and the writer
knows that an SHN_XINDEX for a symbol is needed if the index is >= 0xff00.

>---
> tools/objtool/elf.c | 25 ++++++++++++++++++++++++-
> 1 file changed, 24 insertions(+), 1 deletion(-)
>
>diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
>index 743c2e9d0f56..41bca1d13d8e 100644
>--- a/tools/objtool/elf.c
>+++ b/tools/objtool/elf.c
>@@ -717,7 +717,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
>
> struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
> {
>-	struct section *symtab;
>+	struct section *symtab, *symtab_shndx;
> 	struct symbol *sym;
> 	Elf_Data *data;
> 	Elf_Scn *s;
>@@ -769,6 +769,29 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
> 	symtab->len += data->d_size;
> 	symtab->changed = true;
>
>+	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
>+	if (symtab_shndx) {
>+		s = elf_getscn(elf->elf, symtab_shndx->idx);
>+		if (!s) {
>+			WARN_ELF("elf_getscn");
>+			return NULL;
>+		}
>+
>+		data = elf_newdata(s);
>+		if (!data) {
>+			WARN_ELF("elf_newdata");
>+			return NULL;
>+		}
>+
>+		data->d_buf = &sym->sym.st_size; /* conveniently 0 */
>+		data->d_size = sizeof(Elf32_Word);
>+		data->d_align = 4;
>+		data->d_type = ELF_T_WORD;
>+
>+		symtab_shndx->len += 4;
>+		symtab_shndx->changed = true;
>+	}
>+
> 	sym->sec = find_section_by_index(elf, 0);
>
> 	elf_add_symbol(elf, sym);
