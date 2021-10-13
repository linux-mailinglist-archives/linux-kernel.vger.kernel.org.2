Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7FA42B3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhJMDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhJMDjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:39:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF93C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:37:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ec8so4205181edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fj2PlzmZdzE2dFpBM6mHUqIqwpnW9VcdoDdIQstMyxs=;
        b=PL6HPDxktLfEkN0UrHEDoFOErdekq7zAb8nEdrQt2CC+CsvMpB1x4wT07vs25SvCC7
         AkHQ8x/nsqE9KI3vq6iH/1tKfNFcnclgLNjR2U0j0Qf36ieMHPxHwo5miwnxdrX0uj/x
         M6C0UaksqQ0h+VH9K91tcqDLvhvzv8rvf772ZpznNCyoOmDsK1qJNDnAEqq/pUVGC92u
         /Wn8kM5Yv6hOastNTNXVuQG03YbamGY+dBtNtKNjY1++KqRvR1Fyat5iua2XYL9T/HnL
         WeqtogcQzap15t2SSyXtiNyrfZUw0PnOSk75MGBBM55Us9D7ZqyHOMfAMvdaoxN/m8nt
         uXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fj2PlzmZdzE2dFpBM6mHUqIqwpnW9VcdoDdIQstMyxs=;
        b=UUuxBc/eLUeTLWxBuYTLN+lu8QcOPTzP5brQP/WyOTp/CUYbXiSJNU6erUlIKrBDiw
         jYw5Shc52uEpHAHOvaCzMbn7LkGdEIK1Iigc8zFWlqUEnzO4Jqtqb/ye71oK2gbeTpPR
         HEIFmoMAIXgxISHZzb/pxZNT/2e2MOHF4PWmpnmwRIPK6aispSXv92hHcDR5/QLFIFro
         RW1i52nNDWpyFiCwTH1PkZ1YveyiaJLNdmHYgAT4O3treCwRz5iMUfgljmrCTTZj7+1v
         xlmigDliKe9XvGrOajA4dJZK4JMw3nx0unsdDYeRyq4gk4CECIiY1rwlndi8eBnDeB1n
         6AHw==
X-Gm-Message-State: AOAM530ByxuwUUNppEUA8u1Sr4VKzgaS1X1o0UVUPc03PLbkiNHzMV0U
        6J8rSpNO45kmUjV6x312APmS7+POC5ZLFmv3jSghag==
X-Google-Smtp-Source: ABdhPJzfsJfBtBVhbJg/+zdieqQBMhr01QT69spBcvt6to8M5+eVbDA3L62q27B6nNp3bjqeTVbsSY8BC/YrFKK7r3Y=
X-Received: by 2002:a50:d98d:: with SMTP id w13mr5907142edj.51.1634096261182;
 Tue, 12 Oct 2021 20:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <YWXwQ2P0M0uzHo0o@zn.tnic> <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <20211013030131.GD4253@1wt.eu> <CAGzmLMVaKdBSQrpQFsqEw=Vs240vZANa+1-OLC-nNcKDDevnFQ@mail.gmail.com>
 <CAGzmLMXhez2Vvw8+iuBiEe-XRc+vNn8jDww9=aWe=mNk1rHgzA@mail.gmail.com>
In-Reply-To: <CAGzmLMXhez2Vvw8+iuBiEe-XRc+vNn8jDww9=aWe=mNk1rHgzA@mail.gmail.com>
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Date:   Wed, 13 Oct 2021 10:37:29 +0700
Message-ID: <CAGzmLMVV2i1HYZ06fayUx4=1-TdvnKB=8KK_UAiLqeD4qg_NCw@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 10:34 AM Ammar Faizi
<ammar.faizi@students.amikom.ac.id> wrote:
>
> On Wed, Oct 13, 2021 at 10:32 AM Ammar Faizi
> <ammar.faizi@students.amikom.ac.id> wrote:
> >
> > On Wed, Oct 13, 2021 at 10:01 AM Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > On Wed, Oct 13, 2021 at 05:23:11AM +0700, Ammar Faizi wrote:
> > > > According to x86-64 ABI about syscall section A.2 AMD64 Linux Kernel
> > > > Conventions, A.2.1 Calling Conventions [1]:
> > > >
> > > > 1) User-level applications use as integer registers for passing the
> > > >    sequence %rdi, %rsi, %rdx, %rcx, %r8 and %r9. The kernel interface
> > > >    uses %rdi, %rsi, %rdx, %r10, %r8 and %r9.
> > > >
> > > > 2) A system-call is done via the syscall instruction. The kernel
> > > >    destroys registers %rcx and %r11.
> > > >
> > > > 3) The number of the syscall has to be passed in register %rax.
> > > >
> > > > 4) System-calls are limited to six arguments, no argument is passed
> > > >    directly on the stack.
> > > >
> > > > 5) Returning from the syscall, register %rax contains the result of
> > > >    the system-call. A value in the range between -4095 and -1
> > > >    indicates an error, it is -errno.
> > > >
> > > > 6) Only values of class INTEGER or class MEMORY are passed to the
> > > >    kernel.
> > > >
> > > > From (2), (5) and (6), we can conclude that Linux x86-64 syscall only
> > > > clobbers rax, rcx and r11 (and "memory").
> > > >
> > > >   - rax for the return value.
> > > >   - rcx to save the return address.
> > > >   - r11 to save the rflags.
> > > >
> > > > Other registers are preserved. Right?
> > >
> > > I totally agree, and this doc is perfectly clear on this. I think it
> > > would be worth updating the comments in calling.h to reference this
> > > document and remind these rules, given that they're not trivial to
> > > figure from the code itself.
> > >
> >
> > Alright, I will wire up patch v2 for this :-)
> >
>
> Not for calling.h, nolibc.h I mean.

If Borislav, or others agree with my reply above, it's fine if one can do that
for calling.h (or maybe better in entry_64.S)?

-- 
Ammar Faizi
