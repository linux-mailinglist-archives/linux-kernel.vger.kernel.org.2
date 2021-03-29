Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1C34D102
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhC2NLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhC2NK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:10:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:10:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so12224976otn.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZDdCQupz4vkgN4jX/+oDZiKTMZgeA1Nr2oj7gFHXUw=;
        b=UtjTlgk2KrBSVVX6QfFqybggc7ksk53dhIkDOVZdJLFgtMYUA9gC6nXyYennxL34eQ
         ukCoVjtDKyj6C47EkWxl33OgCt4K7pKTpiw5lyYyn6CMDfX0JHlenryd57YEIl8hUrq3
         /L4aVsEvOzrP8FDS/DoEb1JZxJhvtsQfZaaDUM5Ce3DtRn5n9fLglXwuBPzejSfMy2H9
         P0wsKEkj8dK+GnX5NzrbHpwDxoCXCAINvd80EXGbCfBDDV4NZAd1ltagmKC4CyT597oi
         8l746bhBFVPahHA18J7eblfkwQrxWxmHmCILR8Bd4bS37biQ8BG6D4k88u4ATIr0k7YJ
         x1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZDdCQupz4vkgN4jX/+oDZiKTMZgeA1Nr2oj7gFHXUw=;
        b=ttAYsCk4c/u70lEGiJqVGRooprJYEwZlaS9oN6G9wzuOZn9Yg/te+g9OOlhhZNGGZl
         /lI/T0Uyt2k9REz76x1Gh5bg9x02389ysjb/HRCy8k+LV0GhADx6si8RjNIKRK2ks4Qb
         10MJfRn0+H5ZuxFQQAabI+Yfi67yGlZKOxFKKF0S31mj8aw4fv26OA0PCt/A9651qBW3
         Gc3bPm+Oxxs2YD7hcYFV03K5gm5x3FJGwakp04F/XT7uojwgM2E0ggwmrku/+rjnnX5b
         a3vhnKepZDW4pKRYb1ifEspCNcjcKTqvPtzNRWsGvOjkBdEWtz+DJQ4V10Oe7sXksNb3
         eGqw==
X-Gm-Message-State: AOAM530o7oce7OSVBx6NoKt2ncfLVJC+dFTMEWWt49qou8LgjHOsFURE
        yCWYbe0tvgi7Xd/dh223nP2yHy6c87OL06me7qM=
X-Google-Smtp-Source: ABdhPJyAMiFKcP7TbamY2LLuAqzGGJbjHVZC72M/E3yy0mhQ1o4fwpsk0BplCz4gc8Ld8vPPeH0+M7B/jFyf6MWtwTg=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr22742403otp.269.1617023459194;
 Mon, 29 Mar 2021 06:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <d6980662-bf74-1d48-831e-ca1d7209ca2f@suse.cz> <68eb3576-66dd-9155-aae2-b3cde1ebcbdf@suse.cz>
 <nycvar.YFH.7.76.2103291136070.17979@zhemvz.fhfr.qr> <CAMe9rOpwCwOb0u8n-k1OnBSc+4kTnqM_5GVhN_qYd0SjH_8xJg@mail.gmail.com>
 <nycvar.YFH.7.76.2103291457400.17979@zhemvz.fhfr.qr>
In-Reply-To: <nycvar.YFH.7.76.2103291457400.17979@zhemvz.fhfr.qr>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 29 Mar 2021 06:10:22 -0700
Message-ID: <CAMe9rOrsNfitLpDEjssF=vr9vK-DSsCSkC=nzmGE7uNergLaNA@mail.gmail.com>
Subject: Re: perf does not resolve plt symbols from libstdc++ right (.plt.sec problem)
To:     Richard Biener <rguenther@suse.de>
Cc:     Jiri Slaby <jslaby@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 6:06 AM Richard Biener <rguenther@suse.de> wrote:
>
> On Mon, 29 Mar 2021, H.J. Lu wrote:
>
> > On Mon, Mar 29, 2021 at 2:38 AM Richard Biener <rguenther@suse.de> wrote:
> > >
> > > On Mon, 29 Mar 2021, Jiri Slaby wrote:
> > >
> > > > Any ideas on this?
> > > >
> > > > On 11. 01. 21, 7:31, Jiri Slaby wrote:
> > > > > Hi,
> > > > >
> > > > > this e-mails is a follow-up of my report at:
> > > > > https://bugzilla.suse.com/show_bug.cgi?id=1180681
> > > > >
> > > > > There is a problem with *@plt symbols in some libraries, they are unresolved
> > > > > by perf (memcmp@plt in this case):
> > > > >  >     0.26%  main2    /usr/lib64/libstdc++.so.6.0.28            0xa51a0
> > > > >             l [.] 0x00000000000a51a0
> > > > >
> > > > > On the other hand, plt symbols in other libraries are fine (memset@plt in
> > > > > this case):
> > > > >  >     0.17%  main2    /usr/lib64/libantlr4-runtime.so.4.8       0x4ed10
> > > > >             l [.] memset@plt
> > > > >
> > > > > I dumped memcmp's .plt.rela entries in perf:
> > > > > /usr/lib64/libantlr4-runtime.so.4.8: 154th addr=4e9d0 plt_off=4e020 hdr=10
> > > > > entry=10
> > > > > /usr/lib64/libstdc++.so.6.0.28: 772th addr=a1070 plt_off=9e020 hdr=10
> > > > > entry=10
> > > > >
> > > > > The difference (offset) of stdc++'s memcmp is 0xa51a0 (correct) - 0xa1070
> > > > > (perf's computed) = 0x4130.
> > > > >
> > > > > The problem is perf assumes nth entry of .plt.rela to correspond to nth
> > > > > function in .plt, but memcmp is in .plt.sec in libstdc++.so:
> > > > >
> > > > >  >Relocation section '.rela.plt' at offset 0x97900 contains 1018 entries:
> > > > >  >     Offset             Info             Type               Symbol's
> > > > > Value  Symbol's Name + Addend
> > > > >  > ...
> > > > >  > 00000000001dc838  0000007800000007 R_X86_64_JUMP_SLOT
> > > > > 0000000000000000 memcmp@GLIBC_2.2.5 + 0
> > > > >
> > > > > Perf does this with the rela entries:
> > > > > https://github.com/torvalds/linux/blob/f5e6c330254ae691f6d7befe61c786eb5056007e/tools/perf/util/symbol-elf.c#L385
> > > > >
> > > > > It takes a symbol index from sym.r_info. Then it resolves its name from
> > > > > .dynsym, appending "@plt" to it. Then this name is added to perf's symbol
> > > > > table along with address which is computed as .rela.plt index multiplied by
> > > > > entry size (shdr_plt.sh_entsize) plus plt header (shdr_plt.sh_entsize on
> > > > > x86_64 too).
> > > > >
> > > > > And from this comes (almost) the offset above:
> > > > >  >$ objdump -h /usr/lib64/libstdc++.so.6|grep -E ' .plt(\.sec)? '
> > > > >  >  12 .plt          00003fb0  000000000009e020  000000000009e020
> > > > > 0009e020  2**4
> > > > >  >  14 .plt.sec      00003fa0  00000000000a2160  00000000000a2160
> > > > > 000a2160  2**4
> > > > >
> > > > > 0xa2160-0x9e020 = 0x4140. I assume the 0x10 difference is that perf adds
> > > > > shdr_plt.sh_entsize (0x10) to the offset to skip the first .plt entry
> > > > > (header).
> > > > >
> > > > > Richard writes:
> > > > > ======
> > > > > .plt.sec is IIRC the "second" (sec) PLT entry - the one that will be used on
> > > > > the second call (and on).  This is used / emitted for ELF object
> > > > > instrumented for Intel CET.  The details escape me for the moment but I hope
> > > > > the x86 ABI documents this (and the constraints) in detail.
> > >
> > > I just checked and the x86_64 psABI doesn't say anything about .plt.sec
> >
> > The second PLT is documented in section 13.2 Dynamic Linking in x86-64
> > psABI.  Please see elf_x86_64_get_synthetic_symtab in binutils for PLT symbol
> > processing.
>
> Hmm, google pointed me to https://gitlab.com/x86-psABIs/ and that
> version does not have a section 13 (but the last is section 12 on MPX).
> There's also references to a pdf which contain the section but
> that's on github and the github page says gitlab is the home...
> So I'm a bit confused here.
>

https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/13


-- 
H.J.
