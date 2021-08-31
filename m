Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34B3FCF84
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbhHaWR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:17:57 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37676 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhHaWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:17:56 -0400
Received: by mail-ed1-f51.google.com with SMTP id g21so833220edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4B5jdyViI96DN84wW84Y3euEgDpX1hvP6eo+cVDlPQ=;
        b=ki5d3W3Sib90k/JXlO7lTtluLI5lWLYpgrPyk/Duoc6UD+/EII1bbF2ddBeo/vBytF
         5aPmKXiGgOu0nHmsULDXAEfQByMYC4FrajJouM9e6dP9iYSr7qvX/gymCKS5mx1WYMUf
         KPfSQksGYGiGLbV+vBe3BQayZkXMVuP0oP7GW6zB6KALnwT63wCbFA+V8RhdN+6zsHh7
         DCaDjIrsWIPZ6UwA4NNzrt7DJSuK+giM3oU7NgCz5lEL0zOUhphti8LNr+KGhrxrmnFy
         8RoliyNjlxTWIq9qq9m/z6DpfTF3n4AlEERQoqvhzwtHu45Ai6DKxdPrB56iOjgG8dB2
         qUnA==
X-Gm-Message-State: AOAM532MMxu3JJPHWdnx5IqyqGmeh6WAJ38kFSB6hLg48+l/Qamm/yMF
        7nFYfBAXJVI1UtfX/yf/od6SjkOlGEu+ETr9Sik=
X-Google-Smtp-Source: ABdhPJwtuElL/tBzoe+jW0VJTVhS4vDa7Rw+c1PepcY+wR/qzNomCt2s8ZdSyh6H7mzO0U+A7Eb2hMYN3P4bIjN1vw4=
X-Received: by 2002:aa7:d681:: with SMTP id d1mr32521163edr.186.1630448219630;
 Tue, 31 Aug 2021 15:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <CAJvTdKn09GiAOgdsOR-+ooEO=bmj8VDL9e9sSAsu2UPx73a-Mw@mail.gmail.com>
 <a96a65fc-061b-e94b-cee7-16201ac0820f@intel.com> <CAJvTdKkZ==89-rDeBUDy1GJEzU9FGiAb2m3rtMAGQPJQa1A2fA@mail.gmail.com>
In-Reply-To: <CAJvTdKkZ==89-rDeBUDy1GJEzU9FGiAb2m3rtMAGQPJQa1A2fA@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 31 Aug 2021 18:16:48 -0400
Message-ID: <CAJvTdKmKORbA4poEPq6uKjtrqj_L8C_umKFLVnbsUsD7Vbjhjw@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 6:15 PM Len Brown <lenb@kernel.org> wrote:
>
> On Mon, Aug 30, 2021 at 2:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 8/24/21 4:17 PM, Len Brown wrote:
> > > Even if your AMX thread pool threads were to invoke this system call
> > > as soon as possible...
> > > What is to say that the thread pool is created only at a time when memory
> > > is available?  A thread could be created 24 hours into program execution
> > > under OOM conditions and this system call will return ENOMEM, and your program
> > > will in all likelihood throw up its arms and exit at the exact same place
> > > it would exit for transparently allocated buffers.
> >
> > I tried this exact line of reasoning with Thomas: it doesn't matter
> > where we run out of memory, we still need the same memory and we're
> > screwed either way.
> >
> > However, Thomas expressed a clear preference for ABIs which return
> > memory failures explicitly at syscalls versus implicit failures which
> > can happen on random instructions.
> >
> > One might say that the odds of checking for and handling a NULL value
> > (or ENOMEM) are the same as installing a signal handler.  *But*, it's
> > infinitely easier to unroll state and recover from a NULL than it is to
> > handle it from within a signal handler.  In other words, the explicit
> > ones *encourage* better programming.
>
> I agree.
> Indeed, I believe that there is universal agreement that a synchronous
> return code
> from a system call is a far superior programming model than decoding
> the location of a failure in a system call.  (no, the IP isn't random -- it is

decoding the location of the failure in a *signal hander*

> always the 1st instruction in that thread to touch a TMM register).
>
> > I'd prefer removing the demand-driven allocation at this point.
>
> Adding a pre-allocate system call that can gracefully fail
> (even though it never will) is independent from removing
> demand-driver allocation.  I would leave this to application
> developers.  Honestly, the kernel shouldn't care.
>
> --
> Len Brown, Intel Open Source Technology Center



-- 
Len Brown, Intel Open Source Technology Center
