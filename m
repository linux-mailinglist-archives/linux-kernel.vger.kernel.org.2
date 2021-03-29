Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6F34D0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhC2NHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:07:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhC2NGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:06:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 365C7B473;
        Mon, 29 Mar 2021 13:06:33 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:06:32 +0200 (CEST)
From:   Richard Biener <rguenther@suse.de>
To:     "H.J. Lu" <hjl.tools@gmail.com>
cc:     Jiri Slaby <jslaby@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: perf does not resolve plt symbols from libstdc++ right (.plt.sec
 problem)
In-Reply-To: <CAMe9rOpwCwOb0u8n-k1OnBSc+4kTnqM_5GVhN_qYd0SjH_8xJg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2103291457400.17979@zhemvz.fhfr.qr>
References: <d6980662-bf74-1d48-831e-ca1d7209ca2f@suse.cz> <68eb3576-66dd-9155-aae2-b3cde1ebcbdf@suse.cz> <nycvar.YFH.7.76.2103291136070.17979@zhemvz.fhfr.qr> <CAMe9rOpwCwOb0u8n-k1OnBSc+4kTnqM_5GVhN_qYd0SjH_8xJg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1609908220-831296595-1617023193=:17979"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1609908220-831296595-1617023193=:17979
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 Mar 2021, H.J. Lu wrote:

> On Mon, Mar 29, 2021 at 2:38 AM Richard Biener <rguenther@suse.de> wrote:
> >
> > On Mon, 29 Mar 2021, Jiri Slaby wrote:
> >
> > > Any ideas on this?
> > >
> > > On 11. 01. 21, 7:31, Jiri Slaby wrote:
> > > > Hi,
> > > >
> > > > this e-mails is a follow-up of my report at:
> > > > https://bugzilla.suse.com/show_bug.cgi?id=1180681
> > > >
> > > > There is a problem with *@plt symbols in some libraries, they are unresolved
> > > > by perf (memcmp@plt in this case):
> > > >  >     0.26%  main2    /usr/lib64/libstdc++.so.6.0.28            0xa51a0
> > > >             l [.] 0x00000000000a51a0
> > > >
> > > > On the other hand, plt symbols in other libraries are fine (memset@plt in
> > > > this case):
> > > >  >     0.17%  main2    /usr/lib64/libantlr4-runtime.so.4.8       0x4ed10
> > > >             l [.] memset@plt
> > > >
> > > > I dumped memcmp's .plt.rela entries in perf:
> > > > /usr/lib64/libantlr4-runtime.so.4.8: 154th addr=4e9d0 plt_off=4e020 hdr=10
> > > > entry=10
> > > > /usr/lib64/libstdc++.so.6.0.28: 772th addr=a1070 plt_off=9e020 hdr=10
> > > > entry=10
> > > >
> > > > The difference (offset) of stdc++'s memcmp is 0xa51a0 (correct) - 0xa1070
> > > > (perf's computed) = 0x4130.
> > > >
> > > > The problem is perf assumes nth entry of .plt.rela to correspond to nth
> > > > function in .plt, but memcmp is in .plt.sec in libstdc++.so:
> > > >
> > > >  >Relocation section '.rela.plt' at offset 0x97900 contains 1018 entries:
> > > >  >     Offset             Info             Type               Symbol's
> > > > Value  Symbol's Name + Addend
> > > >  > ...
> > > >  > 00000000001dc838  0000007800000007 R_X86_64_JUMP_SLOT
> > > > 0000000000000000 memcmp@GLIBC_2.2.5 + 0
> > > >
> > > > Perf does this with the rela entries:
> > > > https://github.com/torvalds/linux/blob/f5e6c330254ae691f6d7befe61c786eb5056007e/tools/perf/util/symbol-elf.c#L385
> > > >
> > > > It takes a symbol index from sym.r_info. Then it resolves its name from
> > > > .dynsym, appending "@plt" to it. Then this name is added to perf's symbol
> > > > table along with address which is computed as .rela.plt index multiplied by
> > > > entry size (shdr_plt.sh_entsize) plus plt header (shdr_plt.sh_entsize on
> > > > x86_64 too).
> > > >
> > > > And from this comes (almost) the offset above:
> > > >  >$ objdump -h /usr/lib64/libstdc++.so.6|grep -E ' .plt(\.sec)? '
> > > >  >  12 .plt          00003fb0  000000000009e020  000000000009e020
> > > > 0009e020  2**4
> > > >  >  14 .plt.sec      00003fa0  00000000000a2160  00000000000a2160
> > > > 000a2160  2**4
> > > >
> > > > 0xa2160-0x9e020 = 0x4140. I assume the 0x10 difference is that perf adds
> > > > shdr_plt.sh_entsize (0x10) to the offset to skip the first .plt entry
> > > > (header).
> > > >
> > > > Richard writes:
> > > > ======
> > > > .plt.sec is IIRC the "second" (sec) PLT entry - the one that will be used on
> > > > the second call (and on).  This is used / emitted for ELF object
> > > > instrumented for Intel CET.  The details escape me for the moment but I hope
> > > > the x86 ABI documents this (and the constraints) in detail.
> >
> > I just checked and the x86_64 psABI doesn't say anything about .plt.sec
> 
> The second PLT is documented in section 13.2 Dynamic Linking in x86-64
> psABI.  Please see elf_x86_64_get_synthetic_symtab in binutils for PLT symbol
> processing.

Hmm, google pointed me to https://gitlab.com/x86-psABIs/ and that
version does not have a section 13 (but the last is section 12 on MPX).
There's also references to a pdf which contain the section but
that's on github and the github page says gitlab is the home...
So I'm a bit confused here.

Richard.

-- 
Richard Biener <rguenther@suse.de>
SUSE Software Solutions Germany GmbH, Maxfeldstrasse 5, 90409 Nuernberg,
Germany; GF: Felix Imendörffer; HRB 36809 (AG Nuernberg)
---1609908220-831296595-1617023193=:17979--
