Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E739CC2B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFFCBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 22:01:55 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:40920 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFCBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 22:01:55 -0400
Received: by mail-yb1-f175.google.com with SMTP id e10so19578772ybb.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cYyrGjaBUAmVv/YqrB3kqZUIXcDyhBPIOEKwA4ICIM8=;
        b=k5QllBMpAbOOICxq67Ifot6mFNeBIKxqn6AObjfS3qU9eUGVonodREz0M2nEtteCuH
         1TKoppXL7Q9DCUgHOJjtAAGce50Xt7ok2lN+n/HCt1lSNFv/myluIyBBAXZOpWABE9aK
         qzkFwPuBo1DzLoTcEC41/IsNTNfK5goeBQVjhIbD9g6gZznMiQamc/g9NW9eWKgBcCnw
         lqIwmpKbXjghfsPewlSWeLsMF7FbiRsR5Y6K14E+7aH3ixImk8PB8sjls8x5vk6ut64k
         f/tc+HL4xWR+l0LibD0SrLvixe4UFconFw2d3CGnA8FDTa0rqhMyLYFQu9duq0XAh1tP
         c6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cYyrGjaBUAmVv/YqrB3kqZUIXcDyhBPIOEKwA4ICIM8=;
        b=Nm60FrbsryCrwlOCEusxTZfVtLtFdBtdk32zyFLoS4x0c8EK5D6U7jAGAkJLZFpRuT
         dlxdl9FW3oem6dBU8vhAfxhd1tDQzrMDQK94uOfJEmvFKeKQe3VQbBrz4RBqD06Ss1NU
         wiYLbaHjCAA6icnclpIrt7OUobtIoedmz6HoeMsNyHfnI3lO6M+eWK0WiyDpBpbYKWjq
         BEkrwTL/+xgUBSakjVRnxNCOlqXZXnsbZ5D4+GcjayszgjxJHVqSO5eBHEbeemI0nLsA
         fzY9N6JsvOtEEvA51Ty3ulzTo+OKFg3IPCnIjoD9z0/wb67zTk0mSJn4iRRbY3+Md30l
         IcNA==
X-Gm-Message-State: AOAM530e1diD/J5PygpvyqBL1/OK68VslixyZ9lVNTOq3FRge8XzTfFY
        84xZKG2VxEEvJYDvMEu90Sc0In+4DBBPR9k6mbRzN/Ga+SgtasuV
X-Google-Smtp-Source: ABdhPJyl6JsyzfB5Tq568U87K85f3x5cVODVFW/VFLTEkOxm+R8fny/NO6Jn7cyhGWer8pkT8XBJfMJj16Hf8Mswr4A=
X-Received: by 2002:a25:bbd1:: with SMTP id c17mr15378175ybk.507.1622944730650;
 Sat, 05 Jun 2021 18:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com> <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com> <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
In-Reply-To: <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Sat, 5 Jun 2021 18:58:39 -0700
Message-ID: <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 3:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 04, 2021 at 04:50:46PM -0700, Fangrui Song wrote:
> > On 2021-06-04, 'Nick Desaulniers' via Clang Built Linux wrote:
>
> > > is producing the linker error:
> > >
> > > ld.lld: error: drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o:
> > > SHT_SYMTAB_SHNDX has 79581 entries, but the symbol table associated
> > > has 79582
> > >
> > > Readelf having issues with the output:
> > > $ readelf -s amdgpu.lto.o.orig
> > > <works fine>
> > > $ readelf -s amdgpu.lto.o
> > > readelf: Error: Reading 73014451695 bytes extends past end of file fo=
r
> > > string table
> > > $ llvm-readelf -s amdgpu.lto.o
> > > llvm-readelf: error: 'amdgpu.lto.o': unable to continue dumping, the
> > > file is corrupt: section table goes past the end of file
> > >
>
> > tools/objtool/elf.c:elf_add_symbol may not update .symtab_shndx .
> > Speaking of llvm-objcopy, it finalizes the content of .symtab_shndx whe=
n .symtab
> > is finalized. objtool may want to adopt a similar approach.
> >
> > read_symbols searches for the section ".symtab_shndx". It'd be better t=
o
> > use the section type SHT_SYMTAB_SHNDX.
>
> I think you've absolutely nailed it; but would you have more information
> or a code reference to what you're speaking about? My complete ELF
> and libelf knowledge is very limited and as demonstrated here, I'm not
> at all sure how all that extended index stuff is supposed to work.

The section index field of an Elf{32,64}_Sym (st_shndx) is 16-bit, so
it cannot represent a section index greater than 0xffff.
ELF actually reserves values in 0xff00~0xff00 for other purposes, so
st_shndx cannot represent a section whose index is greater or equal to
0xff00.
To overcome the 16-bit section index limitation, .symtab_shndx was designed=
.

http://www.sco.com/developers/gabi/latest/ch4.symtab.html says

> SHN_XINDEX
> This value is an escape value. It indicates that the symbol refers to a s=
pecific location within a section, but that the section header index for th=
at section is too large to be represented directly in the symbol table entr=
y. The actual section header index is found in the associated SHT_SYMTAB_SH=
NDX section. The entries in that section correspond one to one with the ent=
ries in the symbol table. Only those entries in SHT_SYMTAB_SHNDX that corre=
spond to symbol table entries with SHN_XINDEX will hold valid section heade=
r indexes; all other entries will have value 0.

You may use https://github.com/llvm/llvm-project/blob/main/llvm/tools/llvm-=
objcopy/ELF/Object.cpp#L843
as a reference.
