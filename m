Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233BB3F6C20
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhHXXSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:18:47 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41972 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhHXXSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:18:46 -0400
Received: by mail-ed1-f54.google.com with SMTP id y5so3281608edp.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MCUfys+HO1lzcqQvWGW3v8nowXsfjP4JrD4Jo2HAiQ=;
        b=FhOYGcvPgjv8/xpMjxlk/IH74AEkwk6V/qcZsDTAQ5eb5qFpWME2SFHNbt7q/MUbQ3
         vgEeU/LwTcetNcRqq7dT62xlG2cpip+aLKmQbJs0MOo2GOoV801kcJ1hUS2KrAlsed4C
         k+Z6gUcNY6Wq0ZfBAEcy5MEvrVdhHAwWWL6sMYBYS2AbmncEJOKslps28Srwc+WR9RD5
         rfYQKVAlw68j1EpbXrNIlYGhqVlilo/CS9Do64UnhIj0tnBLOyqLalgUt5YO67Y8YRn3
         c27KUbOwtSqwUZW4OfXiVqfOiSr9SMki2iD20wILjELv8UqPFniB6HlY3jkCrtPFzXlM
         L3Dg==
X-Gm-Message-State: AOAM5337SpyIkpcBwC+b2I30QerWgxLQx/3Z3PXNpLP9fDEkRhZ2vco9
        RINx+gYW6/bwvfaIKBBZvH5gWe9fjF9URwmD2Ow=
X-Google-Smtp-Source: ABdhPJzZIXTjnkN/p4riUQbp+YECqPvy50kFJavOmDfRaVY9dmh/esMcW/+MxfKuRZT716MryDAwYXxkYXZMNBmE334=
X-Received: by 2002:a05:6402:445:: with SMTP id p5mr46149106edw.208.1629847080783;
 Tue, 24 Aug 2021 16:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
In-Reply-To: <YR00U19168BGoRB9@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 24 Aug 2021 19:17:49 -0400
Message-ID: <CAJvTdKn09GiAOgdsOR-+ooEO=bmj8VDL9e9sSAsu2UPx73a-Mw@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, thiago.macieira@intel.com,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:24 PM Borislav Petkov <bp@alien8.de> wrote:

> Why isn't the buffer pre-allocated for the process after latter having
> done prctl() so that when an #NM happens, no allocation happens at all?

The problem with a system call to pre-allocate an AMX context switch buffer
is that it doesn't actually deliver on the goal of guaranteeing no subsequent
run-time failures due to OOM.

Even if your AMX thread pool threads were to invoke this system call
as soon as possible...
What is to say that the thread pool is created only at a time when memory
is available?  A thread could be created 24 hours into program execution
under OOM conditions and this system call will return ENOMEM, and your program
will in all likelihood throw up its arms and exit at the exact same place
it would exit for transparently allocated buffers.

What if you don't care about 24-hours in, and you do care about
allocating at program start?
The program can equally cause the kernel to allocate an AMX context switch
buffer by simply touching a TMM register -- and this can be done at exactly the
same place in the program that calling a pre-allocate system call.

The difference in these two methods is that the system call returns a synchronus
ENOMEM, while the touching of a TMM register sends you a signal at
that location.
In theory, a program may have a thoughtfully implemented and thoroughly tested
*else* clause for ENOMEM -- but you and I know that is a fantasy --
they will exit anyway.

The advantage of the #NM over the syscall is that  the programmer doesn't
actually have to do anything.  Also, transparently allocated buffers offer
a theoretical benefit that a program may have many threads, but only a few
may actually touch AMX, and so there is savings to be had by allocating buffers
only for the threads that actually use the buffers.

Finally, the XFD/NM mechanism opens the door in the future for the
kernel to actually
harvest allocated, but unused buffers -- though we didn't bother
implementing that for AMX.

> And with those buffers preallocated, all that XFD muck is not needed either.

Independent of context switch buffer allocation...

XFD is used to *enforce* that AMX is not used without permission.
Were we to not use the XFD feature, users would be able to stash
data in TMM registers and even use TMUL without the kernel
being able to prevent them from doing so.  Then when they
context switch or take a signal, the data in their TMM registers
would mysteriously vanish...

Much better to be able to tell them immediately that they are doing it wrong...

-- 
Len Brown, Intel Open Source Technology Center
