Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780E8415466
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhIWAJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhIWAJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:09:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F69C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:07:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id r7so2672964pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tjDFQ89haLFkfjLZ//mqE1aJB12EUBcrs5NUPo8ZHjk=;
        b=l4+egiCj4mXf372to+86ctBjJnFYvrIbPPAswgmGlnChpBNsj1nrv+C7aNfGMxcsKP
         QuJIYdYaFdc6OCmybG6i/vucjIGoK5DAv1KEYhl8v6HF+lm3WBpcpvtC8YYXupHVDeIM
         QRN1sK2kt2ESLgDV/e6Lm60lsolGQKVFRHgjNVvJSj8Q8BRykCdGJ3a3KWPL4j9jYECG
         TZ+vOWNn1z7N9EEYldbpimGJ9IVjdndPInyKKgSB9teunFFiNQJL3K0F2ngkJ0RDnazq
         ocDw96ScrMf23BjJy5Nzlg9aHgY1ZNloYsEmIQbDqGrj11VPVH8g2Lc22HfKOtuS3Zm2
         aopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tjDFQ89haLFkfjLZ//mqE1aJB12EUBcrs5NUPo8ZHjk=;
        b=cb56SjffM9XVvZhKF6aDlQdIqaunOt5tQILH+HlNPdjasIINmaDB/14xyX8VSQ8F3X
         GRXT1xfcHHeOy/vr68LH8hBk8h40R9fvnHo3cIfB+awilcI+lCVyxL79yRkAxCKOUWd/
         zApltDBQNq4xY+8Pp9JUmhIk3KwA+yAJmkqQOK2ETIBTQ8/Ef8hAsOjdPNCyP4aKalNU
         jX5qBwwjmQJUVXpijzuVhoVU6LOe/CwsDa9+c1hOWzqd8VOese6mldZYw0/tfc0hT/XT
         2eJHkriv97XAiuZ+LF2uM9hPKvJddrNOHinZNErtB9B+idN3h7YDpb/gPBWS5wuWHwBt
         GHJw==
X-Gm-Message-State: AOAM533WHeg7UGR56Oo+O0Gid7AkDrq8uv7PPyPX7o+i2XY2qRDZYrKa
        3pq55mSj3gJsAl21wx1rh4qHJPySoph2HgOBNQA=
X-Google-Smtp-Source: ABdhPJzWr0QVGsC3zSwYwPnCnWRne64rY0ks2muB2qECW0tYP3OcqEklKI84j5NgDyr8vLrxlxvBxjDlI8wqtJ57lEo=
X-Received: by 2002:a17:90a:9292:: with SMTP id n18mr14390380pjo.120.1632355675438;
 Wed, 22 Sep 2021 17:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
 <20210207141104.ikxbdxhoisgqaoio@box> <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
 <CAMe9rOog08O8xmhhXuJ6aTO+ctv8D2yw1_vu8XjQWwsfw707Mg@mail.gmail.com>
 <MWHPR11MB00787E70E2E0316E5124741DD3A29@MWHPR11MB0078.namprd11.prod.outlook.com>
 <CACT4Y+anEXw18nT47gxBTA7BEh3GUhqm6qb+PUdVPf6E4Fs6cg@mail.gmail.com>
In-Reply-To: <CACT4Y+anEXw18nT47gxBTA7BEh3GUhqm6qb+PUdVPf6E4Fs6cg@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 22 Sep 2021 17:07:19 -0700
Message-ID: <CAMe9rOp9ihmjTNMV7WxDuFmwcOYvEGVEzCZDTa2nQri8DvPx8Q@mail.gmail.com>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Zhang, Xiang1" <xiang1.zhang@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Marco Elver <elver@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Hongtao Liu <hongtao.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 5:54 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 22 Sept 2021 at 03:15, Zhang, Xiang1 <xiang1.zhang@intel.com> wro=
te:
> >
> > There are already in llvm.org.
> > One of my old patch is https://reviews.llvm.org/D102472 which has been =
committed by https://reviews.llvm.org/D102901  and https://reviews.llvm.org=
/D109790
>
> Hi Xiang,
>
> Good sanitizer patches are upstream!
>
> Please help me to understand the status of other pieces (H.J. you
> probably talked about this yesterday, but I wasn't able to build a
> complete picture during the talk, I think it will be useful to have
> this in written form).
>
> 1. The presentation mentions "GCC: enable memory tagging with LAM in
> x86 codegen".
> What exactly is needed? Isn't LAM transparent for codegen? What's the
> status in gcc? Does a corresponding change need to be done in llvm?

The current LAM enabled GCC is on users/intel/lam/master branch at

https://gitlab.com/x86-gcc/gcc/-/tree/users/intel/lam/master

Hongtao, please sync libsanitizer with compiler-rt and check if
compiler-rt is up to date.  The LAM enabled GCC run-time uses
the proposed tagged address API.

> 2. "Enable LAM in binutils".
> This is already upstream in binutils 2.36, right?

Correct.

> 3. The mentioned glibc patch:
> http://patchwork.ozlabs.org/project/glibc/patch/20210211173711.71736-1-hj=
l.tools@gmail.com/
> Not upstream yet, targeting glibc 2.34.

It is targeting glibc 2.35 now.

> 4. "Avoid pointer operations incompatible with LAM. memmove: mask out
> memory tags before comparing pointers".
> Is this upstream? Where is the patch? Are there other similar patches?

The LAM enabled glibc is on users/intel/lam/master branch at:

https://gitlab.com/x86-glibc/glibc/-/tree/users/intel/lam/master

I am considering moving the tagged address API to libc_nonshared.a
for easy backport.

> As a side note, regarding the memmove change: do we really need it?
> Memory regions can overlap only if they come from the same
> allocation/base object. If they come from different allocations, they
> can't overlap (undefined behavior already).

The change isn't needed and has been removed.

> 5. Do we need any additional enabling changes in clang/llvm?

I proposed the tagged address API to support LAM.  compiler-rt
should use it.

> 6. The kernel patches (this email thread) depend on the CET patches
> (for the interface part only). And the CET patches is this, right?
> https://lore.kernel.org/linux-doc/?q=3Dx86%2Fcet%2Fshstk

Yes.

> 7. Do I miss anything else?

No.

> H.J. please upload your slides here:
> https://linuxplumbersconf.org/event/11/contributions/1010/
> It would help with links and copy-pasting text.

Done.

H.J.
> FTR here is the link to the Plumbers talk:
> https://youtu.be/zUw0ZVXCwoM?t=3D10456
>
> Thank you
>
>
> > BR
> > Xiang
> >
> > -----Original Message-----
> > From: H.J. Lu <hjl.tools@gmail.com>
> > Sent: Wednesday, September 22, 2021 1:16 AM
> > To: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>; Kirill A. Shutemov <kiri=
ll.shutemov@linux.intel.com>; Dave Hansen <dave.hansen@linux.intel.com>; Lu=
tomirski, Andy <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>; th=
e arch/x86 maintainers <x86@kernel.org>; Andrey Ryabinin <aryabinin@virtuoz=
zo.com>; Alexander Potapenko <glider@google.com>; Catalin Marinas <catalin.=
marinas@arm.com>; Will Deacon <will@kernel.org>; Andi Kleen <ak@linux.intel=
.com>; Linux-MM <linux-mm@kvack.org>; LKML <linux-kernel@vger.kernel.org>; =
Carlos O'Donell <carlos@redhat.com>; Marco Elver <elver@google.com>; Taras =
Madan <tarasmadan@google.com>; Zhang, Xiang1 <xiang1.zhang@intel.com>
> > Subject: Re: [RFC 0/9] Linear Address Masking enabling
> >
> > On Tue, Sep 21, 2021 at 9:52 AM Dmitry Vyukov <dvyukov@google.com> wrot=
e:
> > >
> > > On Sun, 7 Feb 2021 at 15:11, Kirill A. Shutemov <kirill@shutemov.name=
> wrote:
> > > >
> > > > On Sun, Feb 07, 2021 at 09:24:23AM +0100, Dmitry Vyukov wrote:
> > > > > On Fri, Feb 5, 2021 at 4:16 PM Kirill A. Shutemov
> > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > >
> > > > > > Linear Address Masking[1] (LAM) modifies the checking that is
> > > > > > applied to 64-bit linear addresses, allowing software to use of
> > > > > > the untranslated address bits for metadata.
> > > > > >
> > > > > > The patchset brings support for LAM for userspace addresses.
> > > > > >
> > > > > > The most sensitive part of enabling is change in tlb.c, where
> > > > > > CR3 flags get set. Please take a look that what I'm doing makes=
 sense.
> > > > > >
> > > > > > The patchset is RFC quality and the code requires more testing
> > > > > > before it can be applied.
> > > > > >
> > > > > > The userspace API is not finalized yet. The patchset extends AP=
I
> > > > > > used by
> > > > > > ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to not
> > > > > > imply ARM
> > > > > > TBI: it now allows to request a number of bits of metadata
> > > > > > needed and report where these bits are located in the address.
> > > > > >
> > > > > > There's an alternative proposal[2] for the API based on Intel
> > > > > > CET interface. Please let us know if you prefer one over anothe=
r.
> > > > > >
> > > > > > The feature competes for bits with 5-level paging: LAM_U48 make=
s
> > > > > > it impossible to map anything about 47-bits. The patchset made
> > > > > > these capability mutually exclusive: whatever used first wins.
> > > > > > LAM_U57 can be combined with mappings above 47-bits.
> > > > > >
> > > > > > I include QEMU patch in case if somebody wants to play with the=
 feature.
> > > > >
> > > > > Exciting! Do you plan to send the QEMU patch to QEMU?
> > > >
> > > > Sure. After more testing, once I'm sure it's conforming to the hard=
ware.
> > >
> > > A follow up after H.J.'s LPC talk:
> > > https://linuxplumbersconf.org/event/11/contributions/1010/
> > > (also +Carlos)
> > >
> > > As far as I understood, this kernel series depends on the Intel CET p=
atches.
> > >
> > > Where are these compiler-rt patches that block gcc support?
> >
> > Hi Xiang,
> >
> > Please share your compiler-rt changes for LAM.
> >
> > --
> > H.J.



--
H.J.
