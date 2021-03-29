Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7934D079
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhC2MxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhC2Mwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:52:49 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 05:52:49 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c16so12980082oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07ucOofB7zcsGyyJKm4ISf4GrAIYGQtWh34ROBldfO0=;
        b=m6uYSUXR41iZftxZ34b6fmS1fMT8pEqiWXwwDOCn8Sv6Dw99hw75B7AfcGYCACTZPF
         vqN93QI9aYr/4paDyJp0awudvn7Hvm011xidjb6/PQglC2bUXDyS6aNZQ3EqtXRry7Dr
         rNKQM7lxZYtXpQaea9iipxQfXaN7Qje9uiYAxvxhHXjaW3APtzuXWdMVWXpmYQcCAKQQ
         YZPigamhsYPI3RwQdla76FQ7U2Kg6bLifac0k7vZyMn6EC89BiJuko38pmsqadZjIjlm
         dWOX2IpfezqP/XT7w6Mz0yMNwWgmIDehoZMGoi1+1cGLkgHRraXrJDuK6jzWaGBhn/20
         r/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07ucOofB7zcsGyyJKm4ISf4GrAIYGQtWh34ROBldfO0=;
        b=Zt6rblNZF0P1J20ApcWaOzQ0chWlCfOYagbAk3o/xSfEneZXjYGNGvg/eUU/iYQm7/
         0PfRh7kRiZ4l1Og7//4AA63tEKxBa/n9u3Sq6SW8dD6opMkRUpU3uv4s1X66xOPh8Qys
         NrHQETWRtoB4BFSB9yGkjPMbjD3PyX+JXMkvNR1kFM/0IpKoi/PU3iHyG9eGL9ZbdyMS
         xkE3sEknvH80kJCHCfKBX8PMh5XTkoMHEi5qArduJKt6Nd5x3acUsef+vWd1EkKMvIxo
         CHr4qvUnJplWDRq+AFE7tddcxyDiRNnAg+tluBADg+1AsWdrTv9sovpaRGzLZRUnaues
         L5pw==
X-Gm-Message-State: AOAM533k1DIh2+deacx7I19CKzAX5TXmoPo5+Q9br78m4CEKyg8P/tgU
        cYBZcJRN4Ya7q9Ztvgj6cX1Yn7BMUh1SFjVBhzs=
X-Google-Smtp-Source: ABdhPJwSgqoYesmnzxQv7RTswuIW99BsMBTJL3fQ7GzxugnClX4mVwd7y3z0J+hR0Vvz+xWxOPXXhP2RnakqDEE3XlM=
X-Received: by 2002:a05:6808:94:: with SMTP id s20mr18336337oic.25.1617022369122;
 Mon, 29 Mar 2021 05:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <d6980662-bf74-1d48-831e-ca1d7209ca2f@suse.cz> <68eb3576-66dd-9155-aae2-b3cde1ebcbdf@suse.cz>
 <nycvar.YFH.7.76.2103291136070.17979@zhemvz.fhfr.qr>
In-Reply-To: <nycvar.YFH.7.76.2103291136070.17979@zhemvz.fhfr.qr>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 29 Mar 2021 05:52:13 -0700
Message-ID: <CAMe9rOpwCwOb0u8n-k1OnBSc+4kTnqM_5GVhN_qYd0SjH_8xJg@mail.gmail.com>
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

On Mon, Mar 29, 2021 at 2:38 AM Richard Biener <rguenther@suse.de> wrote:
>
> On Mon, 29 Mar 2021, Jiri Slaby wrote:
>
> > Any ideas on this?
> >
> > On 11. 01. 21, 7:31, Jiri Slaby wrote:
> > > Hi,
> > >
> > > this e-mails is a follow-up of my report at:
> > > https://bugzilla.suse.com/show_bug.cgi?id=1180681
> > >
> > > There is a problem with *@plt symbols in some libraries, they are unresolved
> > > by perf (memcmp@plt in this case):
> > >  >     0.26%  main2    /usr/lib64/libstdc++.so.6.0.28            0xa51a0
> > >             l [.] 0x00000000000a51a0
> > >
> > > On the other hand, plt symbols in other libraries are fine (memset@plt in
> > > this case):
> > >  >     0.17%  main2    /usr/lib64/libantlr4-runtime.so.4.8       0x4ed10
> > >             l [.] memset@plt
> > >
> > > I dumped memcmp's .plt.rela entries in perf:
> > > /usr/lib64/libantlr4-runtime.so.4.8: 154th addr=4e9d0 plt_off=4e020 hdr=10
> > > entry=10
> > > /usr/lib64/libstdc++.so.6.0.28: 772th addr=a1070 plt_off=9e020 hdr=10
> > > entry=10
> > >
> > > The difference (offset) of stdc++'s memcmp is 0xa51a0 (correct) - 0xa1070
> > > (perf's computed) = 0x4130.
> > >
> > > The problem is perf assumes nth entry of .plt.rela to correspond to nth
> > > function in .plt, but memcmp is in .plt.sec in libstdc++.so:
> > >
> > >  >Relocation section '.rela.plt' at offset 0x97900 contains 1018 entries:
> > >  >     Offset             Info             Type               Symbol's
> > > Value  Symbol's Name + Addend
> > >  > ...
> > >  > 00000000001dc838  0000007800000007 R_X86_64_JUMP_SLOT
> > > 0000000000000000 memcmp@GLIBC_2.2.5 + 0
> > >
> > > Perf does this with the rela entries:
> > > https://github.com/torvalds/linux/blob/f5e6c330254ae691f6d7befe61c786eb5056007e/tools/perf/util/symbol-elf.c#L385
> > >
> > > It takes a symbol index from sym.r_info. Then it resolves its name from
> > > .dynsym, appending "@plt" to it. Then this name is added to perf's symbol
> > > table along with address which is computed as .rela.plt index multiplied by
> > > entry size (shdr_plt.sh_entsize) plus plt header (shdr_plt.sh_entsize on
> > > x86_64 too).
> > >
> > > And from this comes (almost) the offset above:
> > >  >$ objdump -h /usr/lib64/libstdc++.so.6|grep -E ' .plt(\.sec)? '
> > >  >  12 .plt          00003fb0  000000000009e020  000000000009e020
> > > 0009e020  2**4
> > >  >  14 .plt.sec      00003fa0  00000000000a2160  00000000000a2160
> > > 000a2160  2**4
> > >
> > > 0xa2160-0x9e020 = 0x4140. I assume the 0x10 difference is that perf adds
> > > shdr_plt.sh_entsize (0x10) to the offset to skip the first .plt entry
> > > (header).
> > >
> > > Richard writes:
> > > ======
> > > .plt.sec is IIRC the "second" (sec) PLT entry - the one that will be used on
> > > the second call (and on).  This is used / emitted for ELF object
> > > instrumented for Intel CET.  The details escape me for the moment but I hope
> > > the x86 ABI documents this (and the constraints) in detail.
>
> I just checked and the x86_64 psABI doesn't say anything about .plt.sec

The second PLT is documented in section 13.2 Dynamic Linking in x86-64
psABI.  Please see elf_x86_64_get_synthetic_symtab in binutils for PLT symbol
processing.

-- 
H.J.
