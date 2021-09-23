Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53B4157E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhIWFhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 01:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhIWFhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:37:17 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D45C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 22:35:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r26so8130838oij.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1X6LECpSC8sOgZ2IPShM8TcXogbm9qgnqSa48C/9ums=;
        b=Xygv4l8wYFBY2H7zQS5hEsNS8yv5YUdVWM4iBGel+oXovkmpFoChdiosY5IUM7IRYJ
         jD8UrjPZZwWqlWAcTxc3gcZF15gfGNN/XwSiQct5cz4XfLCKb0cxTJZXQL9qfqK7n+78
         Y9WGoyznoWQe0JODshjtqnryzv4By+phaGHbL1kI7RVQu6gtQ+YZmfr92PpHl0lhLy8I
         LLLrRZcOc2MaHLRyJTqkMJfmNQEqe4JVON0S8xQpi8O4v85QaZcNZqiCosdtiozHlMqq
         wF7h+GB3m99B97KcTUbb4jX7JDh9tVacFrPxbjlcsDR6qaJkCf1ZLFHIfAGNt1PtwQf+
         wjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1X6LECpSC8sOgZ2IPShM8TcXogbm9qgnqSa48C/9ums=;
        b=iruOC3JhCfzutjLtDLK0UR7lCFeAHu8rD2CRyUjeaiS+Kg34+lXe+MlEelYVPvsaqR
         theihDKGNsq2h09UW/DZXh7/joLNKBF9dj7fFUG7zu9Wm+u6Qjzhd63UJLf0cXEn+1r2
         aVSZ74tk/mThEQaMQrLi9IFn3pUrd2e1lW08zhM7d3Chu9nmtDqmy1hHxqFcTxzJtO4E
         J/X0RjUGtMgXqo7hkEHwjQ3zKfLrsO3AyjmX1JSikR0e9Bh5W2IeYk6XDrun5vCTmSV8
         sWaunyNuiUBK2EIybqetNTx+rwmfjfdfxB/iAIs/dFUc0Nmtr7oRSFCPApLXDCEmaUq3
         tN+Q==
X-Gm-Message-State: AOAM532yt413HryD+fXpG13JDAwHDapJ1wq0y1mwxPdRjZPYo34v9B+N
        rP0WVPR/UBr09hwpIgUyBk0JxNJED6raQALHpClPBA==
X-Google-Smtp-Source: ABdhPJyUGJMlyT/jk2+4X501ndnSIFFElvwNCVnbqLsLmtKK0jkC4nMPygkWsZt9KCgT8anUS3ZJTQIchqQ3jvaDu7w=
X-Received: by 2002:aca:f189:: with SMTP id p131mr11333080oih.128.1632375345048;
 Wed, 22 Sep 2021 22:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
 <20210207141104.ikxbdxhoisgqaoio@box> <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
 <CAMe9rOog08O8xmhhXuJ6aTO+ctv8D2yw1_vu8XjQWwsfw707Mg@mail.gmail.com>
 <MWHPR11MB00787E70E2E0316E5124741DD3A29@MWHPR11MB0078.namprd11.prod.outlook.com>
 <CACT4Y+anEXw18nT47gxBTA7BEh3GUhqm6qb+PUdVPf6E4Fs6cg@mail.gmail.com>
 <CACT4Y+ZGFdmKYZvA4kvw3iTYLJWmnNp=GeL=0Dz2xyC0EpSuCw@mail.gmail.com> <CAMe9rOp+_2LcMWcxxnJVH1CtQQT1Az1V2VW-dXA0_o0eM6iHdQ@mail.gmail.com>
In-Reply-To: <CAMe9rOp+_2LcMWcxxnJVH1CtQQT1Az1V2VW-dXA0_o0eM6iHdQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 Sep 2021 07:35:33 +0200
Message-ID: <CACT4Y+a2hiJJ1-3u-Vak305L+Qza3DrK4gzJxVOkNC83BBFsyg@mail.gmail.com>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
To:     "H.J. Lu" <hjl.tools@gmail.com>
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
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 02:15, H.J. Lu <hjl.tools@gmail.com> wrote:
> > > On Wed, 22 Sept 2021 at 03:15, Zhang, Xiang1 <xiang1.zhang@intel.com>=
 wrote:
> > > >
> > > > There are already in llvm.org.
> > > > One of my old patch is https://reviews.llvm.org/D102472 which has b=
een committed by https://reviews.llvm.org/D102901  and https://reviews.llvm=
.org/D109790
> > >
> > > Hi Xiang,
> > >
> > > Good sanitizer patches are upstream!
> > >
> > > Please help me to understand the status of other pieces (H.J. you
> > > probably talked about this yesterday, but I wasn't able to build a
> > > complete picture during the talk, I think it will be useful to have
> > > this in written form).
> > >
> > > 1. The presentation mentions "GCC: enable memory tagging with LAM in
> > > x86 codegen".
> > > What exactly is needed? Isn't LAM transparent for codegen? What's the
> > > status in gcc? Does a corresponding change need to be done in llvm?
> > >
> > > 2. "Enable LAM in binutils".
> > > This is already upstream in binutils 2.36, right?
> > >
> > > 3. The mentioned glibc patch:
> > > http://patchwork.ozlabs.org/project/glibc/patch/20210211173711.71736-=
1-hjl.tools@gmail.com/
> > > Not upstream yet, targeting glibc 2.34.
> >
> > Do we need any support in other libc's, e.g. Android bionic?
>
> Here is my tagged address API proposal:
>
> https://sourceware.org/pipermail/libc-alpha/2021-August/130382.html

Thank you, I got the large picture now.

> > > 4. "Avoid pointer operations incompatible with LAM. memmove: mask out
> > > memory tags before comparing pointers".
> > > Is this upstream? Where is the patch? Are there other similar patches=
?
> > >
> > > As a side note, regarding the memmove change: do we really need it?
> > > Memory regions can overlap only if they come from the same
> > > allocation/base object. If they come from different allocations, they
> > > can't overlap (undefined behavior already).
> > >
> > > 5. Do we need any additional enabling changes in clang/llvm?
> > >
> > > 6. The kernel patches (this email thread) depend on the CET patches
> > > (for the interface part only). And the CET patches is this, right?
> > > https://lore.kernel.org/linux-doc/?q=3Dx86%2Fcet%2Fshstk
> > >
> > > 7. Do I miss anything else?
> > >
> > > H.J. please upload your slides here:
> > > https://linuxplumbersconf.org/event/11/contributions/1010/
> > > It would help with links and copy-pasting text.
> > >
> > > FTR here is the link to the Plumbers talk:
> > > https://youtu.be/zUw0ZVXCwoM?t=3D10456
> > >
> > > Thank you
> > >
> > >
> > > > BR
> > > > Xiang
> > > >
> > > > -----Original Message-----
> > > > From: H.J. Lu <hjl.tools@gmail.com>
> > > > Sent: Wednesday, September 22, 2021 1:16 AM
> > > > To: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: Kirill A. Shutemov <kirill@shutemov.name>; Kirill A. Shutemov <=
kirill.shutemov@linux.intel.com>; Dave Hansen <dave.hansen@linux.intel.com>=
; Lutomirski, Andy <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>=
; the arch/x86 maintainers <x86@kernel.org>; Andrey Ryabinin <aryabinin@vir=
tuozzo.com>; Alexander Potapenko <glider@google.com>; Catalin Marinas <cata=
lin.marinas@arm.com>; Will Deacon <will@kernel.org>; Andi Kleen <ak@linux.i=
ntel.com>; Linux-MM <linux-mm@kvack.org>; LKML <linux-kernel@vger.kernel.or=
g>; Carlos O'Donell <carlos@redhat.com>; Marco Elver <elver@google.com>; Ta=
ras Madan <tarasmadan@google.com>; Zhang, Xiang1 <xiang1.zhang@intel.com>
> > > > Subject: Re: [RFC 0/9] Linear Address Masking enabling
> > > >
> > > > On Tue, Sep 21, 2021 at 9:52 AM Dmitry Vyukov <dvyukov@google.com> =
wrote:
> > > > >
> > > > > On Sun, 7 Feb 2021 at 15:11, Kirill A. Shutemov <kirill@shutemov.=
name> wrote:
> > > > > >
> > > > > > On Sun, Feb 07, 2021 at 09:24:23AM +0100, Dmitry Vyukov wrote:
> > > > > > > On Fri, Feb 5, 2021 at 4:16 PM Kirill A. Shutemov
> > > > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > Linear Address Masking[1] (LAM) modifies the checking that =
is
> > > > > > > > applied to 64-bit linear addresses, allowing software to us=
e of
> > > > > > > > the untranslated address bits for metadata.
> > > > > > > >
> > > > > > > > The patchset brings support for LAM for userspace addresses=
.
> > > > > > > >
> > > > > > > > The most sensitive part of enabling is change in tlb.c, whe=
re
> > > > > > > > CR3 flags get set. Please take a look that what I'm doing m=
akes sense.
> > > > > > > >
> > > > > > > > The patchset is RFC quality and the code requires more test=
ing
> > > > > > > > before it can be applied.
> > > > > > > >
> > > > > > > > The userspace API is not finalized yet. The patchset extend=
s API
> > > > > > > > used by
> > > > > > > > ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to =
not
> > > > > > > > imply ARM
> > > > > > > > TBI: it now allows to request a number of bits of metadata
> > > > > > > > needed and report where these bits are located in the addre=
ss.
> > > > > > > >
> > > > > > > > There's an alternative proposal[2] for the API based on Int=
el
> > > > > > > > CET interface. Please let us know if you prefer one over an=
other.
> > > > > > > >
> > > > > > > > The feature competes for bits with 5-level paging: LAM_U48 =
makes
> > > > > > > > it impossible to map anything about 47-bits. The patchset m=
ade
> > > > > > > > these capability mutually exclusive: whatever used first wi=
ns.
> > > > > > > > LAM_U57 can be combined with mappings above 47-bits.
> > > > > > > >
> > > > > > > > I include QEMU patch in case if somebody wants to play with=
 the feature.
> > > > > > >
> > > > > > > Exciting! Do you plan to send the QEMU patch to QEMU?
> > > > > >
> > > > > > Sure. After more testing, once I'm sure it's conforming to the =
hardware.
> > > > >
> > > > > A follow up after H.J.'s LPC talk:
> > > > > https://linuxplumbersconf.org/event/11/contributions/1010/
> > > > > (also +Carlos)
> > > > >
> > > > > As far as I understood, this kernel series depends on the Intel C=
ET patches.
> > > > >
> > > > > Where are these compiler-rt patches that block gcc support?
> > > >
> > > > Hi Xiang,
> > > >
> > > > Please share your compiler-rt changes for LAM.
> > > >
> > > > --
> > > > H.J.
>
>
>
> --
> H.J.
