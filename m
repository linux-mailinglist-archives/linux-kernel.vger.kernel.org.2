Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCE4149D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhIVM4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhIVM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:56:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F68C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:54:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c6-20020a9d2786000000b005471981d559so3292524otb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6JUrlffSvJAPtpi9707YKMMX70rhvermhAZjCLNvyF4=;
        b=juaKvmI24xrZW83BOSCpjiaApyrsyKhBiUpjRv0Iu3mEgdhM9OaF5/1BqSmpVcIs6L
         aP6U6LN+qq9oX5udXR8H03TxtlQTEfxJF4YsEkUdLsd8JVrGvIOj017VBbQDLu7Nt8x6
         y/SE5tQe/euXmI+DVfFhKQie9hCE9Aw2cp3Ug6/WtId57oAyCy3q0J3BiLWtZUeohKyU
         AL1FxJcOUJcmbjNcU7jAa+lQsa+6aCAZqTKzfy0f57bRq/fTTYXnp1FLBrimvxEAqxXm
         QrTS36dep77wTpWOQ0wNzBJT+fiZkIDFDT7siMH8Gvq064ltBPcV0Jq1NihUeQrnmQeS
         x6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6JUrlffSvJAPtpi9707YKMMX70rhvermhAZjCLNvyF4=;
        b=y1U+qTodkyEo1Av14pQyy7IepjYOy1dx77yb0j6Mu9xUP9aHleX6ITAB/U4cnXEKai
         idC+Ka075rN8KTVEP1xA2i1+DK6bXoL9Svy1hHpP5/Q+3SM44pGBXnj2/BwvaGcRParG
         gjPQ/0HZZGFuy0syHt5uB1qKXivjy83hY3ie+LSeFF/CWk7V7ORpkHEsdAEwoDi3yUfb
         VZG/otlQezpIXG/1ZUX4jiTlf71kmmP5KPs1uei5Kqx/mvKxbfA3aQoZt/MgDIg8dM6W
         HlKei4b1blrhbCPj8j19h6zEzzCYY53eQWVM/xIs9+97FPw5m7yqWpeAqg52SJ9gvVpn
         /V7Q==
X-Gm-Message-State: AOAM532zGdvdRt+al5B0eKmBrvNEVtjteEk+ilJzSh/Fccdld6wloB5Z
        wnGz0g0UIVw9Hy5xZQJSauAfz6Bmv2zvF2cF131tVw==
X-Google-Smtp-Source: ABdhPJzA9qY0629QUrOgjYgvxN3gI64C21g+N1UlQcCB10gGxbd0PO1YfB6xZqpfENIbp+55a88wGVCwtrUZVsMOd9g=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr31605681otk.137.1632315288467;
 Wed, 22 Sep 2021 05:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
 <20210207141104.ikxbdxhoisgqaoio@box> <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
 <CAMe9rOog08O8xmhhXuJ6aTO+ctv8D2yw1_vu8XjQWwsfw707Mg@mail.gmail.com> <MWHPR11MB00787E70E2E0316E5124741DD3A29@MWHPR11MB0078.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB00787E70E2E0316E5124741DD3A29@MWHPR11MB0078.namprd11.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 22 Sep 2021 14:54:36 +0200
Message-ID: <CACT4Y+anEXw18nT47gxBTA7BEh3GUhqm6qb+PUdVPf6E4Fs6cg@mail.gmail.com>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
To:     "Zhang, Xiang1" <xiang1.zhang@intel.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
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

On Wed, 22 Sept 2021 at 03:15, Zhang, Xiang1 <xiang1.zhang@intel.com> wrote=
:
>
> There are already in llvm.org.
> One of my old patch is https://reviews.llvm.org/D102472 which has been co=
mmitted by https://reviews.llvm.org/D102901  and https://reviews.llvm.org/D=
109790

Hi Xiang,

Good sanitizer patches are upstream!

Please help me to understand the status of other pieces (H.J. you
probably talked about this yesterday, but I wasn't able to build a
complete picture during the talk, I think it will be useful to have
this in written form).

1. The presentation mentions "GCC: enable memory tagging with LAM in
x86 codegen".
What exactly is needed? Isn't LAM transparent for codegen? What's the
status in gcc? Does a corresponding change need to be done in llvm?

2. "Enable LAM in binutils".
This is already upstream in binutils 2.36, right?

3. The mentioned glibc patch:
http://patchwork.ozlabs.org/project/glibc/patch/20210211173711.71736-1-hjl.=
tools@gmail.com/
Not upstream yet, targeting glibc 2.34.

4. "Avoid pointer operations incompatible with LAM. memmove: mask out
memory tags before comparing pointers".
Is this upstream? Where is the patch? Are there other similar patches?

As a side note, regarding the memmove change: do we really need it?
Memory regions can overlap only if they come from the same
allocation/base object. If they come from different allocations, they
can't overlap (undefined behavior already).

5. Do we need any additional enabling changes in clang/llvm?

6. The kernel patches (this email thread) depend on the CET patches
(for the interface part only). And the CET patches is this, right?
https://lore.kernel.org/linux-doc/?q=3Dx86%2Fcet%2Fshstk

7. Do I miss anything else?

H.J. please upload your slides here:
https://linuxplumbersconf.org/event/11/contributions/1010/
It would help with links and copy-pasting text.

FTR here is the link to the Plumbers talk:
https://youtu.be/zUw0ZVXCwoM?t=3D10456

Thank you


> BR
> Xiang
>
> -----Original Message-----
> From: H.J. Lu <hjl.tools@gmail.com>
> Sent: Wednesday, September 22, 2021 1:16 AM
> To: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>; Kirill A. Shutemov <kirill=
.shutemov@linux.intel.com>; Dave Hansen <dave.hansen@linux.intel.com>; Luto=
mirski, Andy <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>; the =
arch/x86 maintainers <x86@kernel.org>; Andrey Ryabinin <aryabinin@virtuozzo=
.com>; Alexander Potapenko <glider@google.com>; Catalin Marinas <catalin.ma=
rinas@arm.com>; Will Deacon <will@kernel.org>; Andi Kleen <ak@linux.intel.c=
om>; Linux-MM <linux-mm@kvack.org>; LKML <linux-kernel@vger.kernel.org>; Ca=
rlos O'Donell <carlos@redhat.com>; Marco Elver <elver@google.com>; Taras Ma=
dan <tarasmadan@google.com>; Zhang, Xiang1 <xiang1.zhang@intel.com>
> Subject: Re: [RFC 0/9] Linear Address Masking enabling
>
> On Tue, Sep 21, 2021 at 9:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Sun, 7 Feb 2021 at 15:11, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
> > >
> > > On Sun, Feb 07, 2021 at 09:24:23AM +0100, Dmitry Vyukov wrote:
> > > > On Fri, Feb 5, 2021 at 4:16 PM Kirill A. Shutemov
> > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > >
> > > > > Linear Address Masking[1] (LAM) modifies the checking that is
> > > > > applied to 64-bit linear addresses, allowing software to use of
> > > > > the untranslated address bits for metadata.
> > > > >
> > > > > The patchset brings support for LAM for userspace addresses.
> > > > >
> > > > > The most sensitive part of enabling is change in tlb.c, where
> > > > > CR3 flags get set. Please take a look that what I'm doing makes s=
ense.
> > > > >
> > > > > The patchset is RFC quality and the code requires more testing
> > > > > before it can be applied.
> > > > >
> > > > > The userspace API is not finalized yet. The patchset extends API
> > > > > used by
> > > > > ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to not
> > > > > imply ARM
> > > > > TBI: it now allows to request a number of bits of metadata
> > > > > needed and report where these bits are located in the address.
> > > > >
> > > > > There's an alternative proposal[2] for the API based on Intel
> > > > > CET interface. Please let us know if you prefer one over another.
> > > > >
> > > > > The feature competes for bits with 5-level paging: LAM_U48 makes
> > > > > it impossible to map anything about 47-bits. The patchset made
> > > > > these capability mutually exclusive: whatever used first wins.
> > > > > LAM_U57 can be combined with mappings above 47-bits.
> > > > >
> > > > > I include QEMU patch in case if somebody wants to play with the f=
eature.
> > > >
> > > > Exciting! Do you plan to send the QEMU patch to QEMU?
> > >
> > > Sure. After more testing, once I'm sure it's conforming to the hardwa=
re.
> >
> > A follow up after H.J.'s LPC talk:
> > https://linuxplumbersconf.org/event/11/contributions/1010/
> > (also +Carlos)
> >
> > As far as I understood, this kernel series depends on the Intel CET pat=
ches.
> >
> > Where are these compiler-rt patches that block gcc support?
>
> Hi Xiang,
>
> Please share your compiler-rt changes for LAM.
>
> --
> H.J.
