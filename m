Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023F142B3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhJMDg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhJMDgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:36:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6329C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:34:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i20so4112335edj.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7z6HLb7TxUOZtVc7lI7zJJI1gkXKIe6NTiOZrtX5pv0=;
        b=Hqs/wzomMxYgcmrIxO240B7CCT/KAm8xJy+c4/u8pBs80HFCIj+zxHcDwqur4CoPLn
         XYbo66qwMKx4CTFMHSyAcbOfgosaJ+reHQam1//ddzvSQJNVlVjJvP3cvyRUGMKhbmQX
         MRCXPZCnH16I+jbFWfmvlMmFX5W4MS5q/LJZdCEMai7DkbAUaTmNSew+lPCSu5le6MgW
         MCH3JAhKsS2SHxIuZoBm2q/lUf5w4zapSVzWDYlDCNNsPUlucEk9N8B8rMBXXHt0wf7K
         lsdGCNbwhCDSjI8q+BhI7u+jZeYR+kRnkq9txuDsdQUnknAsNU34+JrR2NNTiabsbhoW
         oXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7z6HLb7TxUOZtVc7lI7zJJI1gkXKIe6NTiOZrtX5pv0=;
        b=2m1ApwZm8WY1Q1+7JkvnoHvMN4Dg6BzO/jJHjhONz78HJufG9S9227qBgR1GUnmA1D
         VcDw22Fu5pmLDSY/JlEdmnfP96+7Ns8ZVawFfkKsLT0iuo0LqyhWUjafHWp9wRoYxFey
         9iYDtKeldXqMY8P0DhbdQN5k9+RWAvPvy0sDEXz7FhEq/r1qxfAxfBmBaplbusyC/Yat
         RNxqlxk+f+C7FfxRlT2GRzxTG3d0BYsQX4gEUKnuZdIKTdDaZUh0ZJDImcHoRoOdz0Td
         BHxaWpf1xxmwzsrS+pBvHds/QEvmhaGHTFD6sKNrzmX2hbY7XShivnvjn3BmHddkWWMV
         F6oA==
X-Gm-Message-State: AOAM533hQIhzFxftNKCiSzFC9TFnqBDd/kpSHe/Nrc4WipU/Z2Xi6Vsh
        J1S59y+rq1E7hcC8h1UGZdKdhUggiOoxD4ysoAyFZQ==
X-Google-Smtp-Source: ABdhPJxCC8f0/CKIU5AksYY4tpInzjIwdjIyoqOQaVeH0e76NkPhh2ldjzOnt4kN62Oiymky9SRrU/0QTZIxbSAunRA=
X-Received: by 2002:a17:906:f2d0:: with SMTP id gz16mr24503093ejb.102.1634096091316;
 Tue, 12 Oct 2021 20:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <YWXwQ2P0M0uzHo0o@zn.tnic> <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <20211013030131.GD4253@1wt.eu> <CAGzmLMVaKdBSQrpQFsqEw=Vs240vZANa+1-OLC-nNcKDDevnFQ@mail.gmail.com>
In-Reply-To: <CAGzmLMVaKdBSQrpQFsqEw=Vs240vZANa+1-OLC-nNcKDDevnFQ@mail.gmail.com>
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Date:   Wed, 13 Oct 2021 10:34:39 +0700
Message-ID: <CAGzmLMXhez2Vvw8+iuBiEe-XRc+vNn8jDww9=aWe=mNk1rHgzA@mail.gmail.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
To:     Willy Tarreau <w@1wt.eu>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:32 AM Ammar Faizi
<ammar.faizi@students.amikom.ac.id> wrote:
>
> On Wed, Oct 13, 2021 at 10:01 AM Willy Tarreau <w@1wt.eu> wrote:
> >
> > On Wed, Oct 13, 2021 at 05:23:11AM +0700, Ammar Faizi wrote:
> > > According to x86-64 ABI about syscall section A.2 AMD64 Linux Kernel
> > > Conventions, A.2.1 Calling Conventions [1]:
> > >
> > > 1) User-level applications use as integer registers for passing the
> > >    sequence %rdi, %rsi, %rdx, %rcx, %r8 and %r9. The kernel interface
> > >    uses %rdi, %rsi, %rdx, %r10, %r8 and %r9.
> > >
> > > 2) A system-call is done via the syscall instruction. The kernel
> > >    destroys registers %rcx and %r11.
> > >
> > > 3) The number of the syscall has to be passed in register %rax.
> > >
> > > 4) System-calls are limited to six arguments, no argument is passed
> > >    directly on the stack.
> > >
> > > 5) Returning from the syscall, register %rax contains the result of
> > >    the system-call. A value in the range between -4095 and -1
> > >    indicates an error, it is -errno.
> > >
> > > 6) Only values of class INTEGER or class MEMORY are passed to the
> > >    kernel.
> > >
> > > From (2), (5) and (6), we can conclude that Linux x86-64 syscall only
> > > clobbers rax, rcx and r11 (and "memory").
> > >
> > >   - rax for the return value.
> > >   - rcx to save the return address.
> > >   - r11 to save the rflags.
> > >
> > > Other registers are preserved. Right?
> >
> > I totally agree, and this doc is perfectly clear on this. I think it
> > would be worth updating the comments in calling.h to reference this
> > document and remind these rules, given that they're not trivial to
> > figure from the code itself.
> >
>
> Alright, I will wire up patch v2 for this :-)
>

Not for calling.h, nolibc.h I mean.
