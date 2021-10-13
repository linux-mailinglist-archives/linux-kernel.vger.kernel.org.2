Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3508342B39F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhJMDeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhJMDeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:34:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCC4C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:32:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w14so4078537edv.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RexNcTerqIGq/MGP5OwpXL3CaOSSUXudN7n1NoiqAQ4=;
        b=cHVV0VQ99oxKORa6gR86JmGUqyBOFBdzmpAq6xJChp9PQ4kZaXIolaNI0gzIJeWW/8
         hbChLx7AY2mNUgIScJBC1RDvIt3X3b9bw/nggkte4ON5p4PiAJUknT/KQYX1LAxyIQqR
         9UWJHnXCjRSuMpsdfvFKDuvBVqs8BphvnHcR0LSnFEfLHwsE3DfSWk+Ie+G28dVHN8FP
         wJO5B51jH7+SncxWIi1+KzV04eqUFtNCOnFUwwollb/qrzp9ueFezc81fABXWyq/lyxW
         oR5IXVz1MTSRj/L1cnfbsEP6NxgLjkW77B1fd47NxltPQ+Y85Mfn6quGH97ohvjLbsDI
         eZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RexNcTerqIGq/MGP5OwpXL3CaOSSUXudN7n1NoiqAQ4=;
        b=eONgMtogjqAs9b2aUUyt3gKedCU3YijebxzRKpjyMe9FkspvS2GGP45kFVh+bmHqFS
         /dVMC0Ueu1SMkUpB6ib4VyZw6RfnbE7raDeejmC4O3EAQOGxk4oc3mbe7l/e5ty3dnAv
         8/JQ4lpzrNlzg4afh/U0lt+DwE+oZmPqIp3FE4TWmOTrMZrskq2luTtmEjbk9VAcnF/7
         0ahiPbfeJXq0C7RSN4/AdRY/4+8DEsbKAEijGlqUAukk9wrqf6cqx+C34VpwBmoei3eb
         VGBeyAmx7b/fn39ZBnzzCTx+291V5HvACAc458DqN/dCgJxz2DlS42TVnYUqnwMvMrQ4
         LKCw==
X-Gm-Message-State: AOAM530pzIM37TUH8a5fET+tok6lD2ZGjzM4abBhSyNSZYJHIGwI3T+q
        1oQxoDX0o7BjJM62m8GA0EaZ4ZSk5SrmdANcziMqQw==
X-Google-Smtp-Source: ABdhPJxXD9Wcadpt35tHX038UmmH1PCQ5YO+6m7atzaI09lBtDKdO55VQmHd//1SI8nMWmueJ1Rq1cN3v378fVZ4QEc=
X-Received: by 2002:a17:906:b184:: with SMTP id w4mr36600812ejy.418.1634095936475;
 Tue, 12 Oct 2021 20:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <YWXwQ2P0M0uzHo0o@zn.tnic> <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <20211013030131.GD4253@1wt.eu>
In-Reply-To: <20211013030131.GD4253@1wt.eu>
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Date:   Wed, 13 Oct 2021 10:32:03 +0700
Message-ID: <CAGzmLMVaKdBSQrpQFsqEw=Vs240vZANa+1-OLC-nNcKDDevnFQ@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 10:01 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Wed, Oct 13, 2021 at 05:23:11AM +0700, Ammar Faizi wrote:
> > According to x86-64 ABI about syscall section A.2 AMD64 Linux Kernel
> > Conventions, A.2.1 Calling Conventions [1]:
> >
> > 1) User-level applications use as integer registers for passing the
> >    sequence %rdi, %rsi, %rdx, %rcx, %r8 and %r9. The kernel interface
> >    uses %rdi, %rsi, %rdx, %r10, %r8 and %r9.
> >
> > 2) A system-call is done via the syscall instruction. The kernel
> >    destroys registers %rcx and %r11.
> >
> > 3) The number of the syscall has to be passed in register %rax.
> >
> > 4) System-calls are limited to six arguments, no argument is passed
> >    directly on the stack.
> >
> > 5) Returning from the syscall, register %rax contains the result of
> >    the system-call. A value in the range between -4095 and -1
> >    indicates an error, it is -errno.
> >
> > 6) Only values of class INTEGER or class MEMORY are passed to the
> >    kernel.
> >
> > From (2), (5) and (6), we can conclude that Linux x86-64 syscall only
> > clobbers rax, rcx and r11 (and "memory").
> >
> >   - rax for the return value.
> >   - rcx to save the return address.
> >   - r11 to save the rflags.
> >
> > Other registers are preserved. Right?
>
> I totally agree, and this doc is perfectly clear on this. I think it
> would be worth updating the comments in calling.h to reference this
> document and remind these rules, given that they're not trivial to
> figure from the code itself.
>

Alright, I will wire up patch v2 for this :-)

-- 
Ammar Faizi
