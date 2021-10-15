Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF00042F89F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhJOQtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbhJOQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:49:28 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC3C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:47:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s64so24129374yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uHSnz8D1DIWQcjU5/N5hH4GTJpS+yuQBb1AWvYk624w=;
        b=a7O6f8UVoWX1Jh4/B8imWuGC/qXP5rujqE2kd9JOc3F0/CS0vBBNXumKcCh8QMSonM
         UdiXmmvRljhji/HhIfUWed2GsvE8VLaSl7VhM/6NlyGtqalnTikHvOcRc968gKOlJ5MR
         NbXvdoNjQgMiQaTg+bJ8kmvQa5S6vyTa6o5e1GQNd3WiG2SHGwVQoVb4Anj8hXIip+/T
         lEfnDnu85sr7dSfBu7dqu5943MpPHWTiUdczrTTkqmxTWZhk+UDHuO6mLulD1Q9yQS++
         qTKU/kY9oq+lwsoIFNq5+QJJGjEzE6IGCBSqv7z37KBfOBs3oMu93sBC6GRpioUW3CTd
         jJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uHSnz8D1DIWQcjU5/N5hH4GTJpS+yuQBb1AWvYk624w=;
        b=6H4J70YhzVPX16GSNCNIfXqA0qHLi0x7JLe16mh88aFMooQliByPo0zEOu87iDcgre
         5gVXy/sm/cK1NxnGtXash9lxv3q7x4s+WzM0dMVgNQ43VAHHYkf3y2MgmzOMWBw8uqKP
         /6B+KE3fNrFTOIL/5DL3dSTjZfWtOhuwzNrMzZ+Zavil6EI/FR3b34qSec3Tq8NxmOiM
         49B6Msjsziy0bg5I+rjYYJioEUU95RWWmcrpOtOrgXnN/Mz00o2HNSSU57PmkSAbhdkY
         g4ChO76UCmB1LwpQCaG1jG27D8EjFzqVPlkUQKPKnLyhfnv3pqNZF7fcCTEUUVNUNKxy
         IZwA==
X-Gm-Message-State: AOAM530gdGbzvmdwjWtCS0K1HJH3a9JUQVR8aF3n6ZglWL78TyPhkPXC
        FQFK9NkGTTNk84Y0ey1OWcqq2dXv1TnNtHdBiZIa3w==
X-Google-Smtp-Source: ABdhPJwwmioX7wCg8t/xa5JPWcEB/oetYkdp2SF7YZ4CuHuSUiCY9JO3eVJBxkwFi7dOljmz3v9ATSNHQcYhsnloJeE=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr15023659ybl.160.1634316437824;
 Fri, 15 Oct 2021 09:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com> <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx> <eda70a35-33a8-43b4-a839-65f2a1f91bb5@www.fastmail.com>
In-Reply-To: <eda70a35-33a8-43b4-a839-65f2a1f91bb5@www.fastmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 15 Oct 2021 09:47:06 -0700
Message-ID: <CABCJKufhd3=6PR=WmteJBQ5xBnmvzQb7h3cJxDSJZjLHSSH22g@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 9:22 AM Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Fri, Oct 15, 2021, at 8:55 AM, Thomas Gleixner wrote:
> > On Thu, Oct 14 2021 at 19:51, Andy Lutomirski wrote:
> >> On Wed, Oct 13, 2021, at 11:16 AM, Sami Tolvanen wrote:
> >>>
> >>> +/*
> >>> + * Declares a function not callable from C using an opaque type. Def=
ined as
> >>> + * an array to allow the address of the symbol to be taken without '=
&'.
> >>> + */
> >> I=E2=80=99m not convinced that taking the address without using & is a
> >> laudable goal.  The magical arrays-are-pointers-too behavior of C is a
> >> mistake, not a delightful simplification.
> >
> >>> +#ifndef DECLARE_NOT_CALLED_FROM_C
> >>> +#define DECLARE_NOT_CALLED_FROM_C(sym) \
> >>> +   extern const u8 sym[]
> >>> +#endif
> >>
> >
> >> The relevant property of these symbols isn=E2=80=99t that they=E2=80=
=99re not called
> >> from C.  The relevant thing is that they are just and not objects of a
> >> type that the programmer cares to tell the compiler about. (Or that
> >> the compiler understands, for that matter. On a system with XO memory
> >> or if they=E2=80=99re in a funny section, dereferencing them may fail.=
)
> >
> > I agree.
> >
> >> So I think we should use incomplete structs, which can=E2=80=99t be
> >> dereferenced and will therefore be less error prone.
> >
> > While being late to that bike shed painting party, I really have to ask
> > the question _why_ can't the compiler provide an annotation for these
> > kind of things which:
> >
> >     1) Make the build fail when invoked directly
> >
> >     2) Tell CFI that this is _NOT_ something it can understand
> >
> > -void clear_page_erms(void *page);
> > +void __bikeshedme clear_page_erms(void *page);
> >
> > That still tells me:
> >
> >     1) This is a function
> >
> >     2) It has a regular argument which is expected to be in RDI
> >
> > which even allows to do analyis of e.g. the alternative call which
> > invokes that function.
> >
> > DECLARE_NOT_CALLED_FROM_C(clear_page_erms);
> >
> > loses these properties and IMO it's a tasteless hack.
> >
>
>
> Ah, but clear_page_erms is a different beast entirely as compared to, say=
, the syscall entry. It *is* a C function.  So I see two ways to handle it:
>
> 1. Make it completely opaque.  Tglx doesn=E2=80=99t like it, and I agree,=
 but it would *work*.
>
> 2. Make it a correctly typed function. In clang CFI land, this may or may=
 not be =E2=80=9Ccanonical=E2=80=9D (or non canonical?).

Technically speaking the clear_page_* declarations don't need to be
changed for CFI, they do work fine as is, but I included them in the
patch as they're not actually called from C code right now. But you're
right, we should use a proper function declarations for these. I'll
drop the changes to this file in the next version.

I wouldn't mind having a consensus on how to deal with exception
handlers etc. though. Should I still use opaque types for those?

Sami
