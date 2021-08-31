Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475303FCF82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbhHaWRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:17:04 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:44569 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbhHaWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:17:03 -0400
Received: by mail-ed1-f41.google.com with SMTP id n11so759166edv.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHqLzHOU5w6GE8viA7VBL7rpO2AVuZg/dxclEvKZqX8=;
        b=jEQcrNM4B0kOAWqmuepF9bt35AHbXxt9vl2QG1IEqrGlUXI4dfIgHzyOLXN14giBEz
         Ift69HiOtecdgAzcVNQnE/+NQAaw15SUZCdRnFUnnniCwxOqVpofzF/J3u7IKgTRAqhn
         4ZOnvNcsJgqAZDhgqbVsCSWAs1VLFg49I9MR3vUJ1IQX4Lyq6tlg/nZ5UZmmm5pbdzCL
         AMyn7w/NED7x/Qhvu2i9dRxSkIWoS06LrDcpYxxAdX0RkJIbehKFlROdENo0inALalzc
         XmHT8op2SNUqfAqK3mWypyQbuJ27QQqNqOBhAOB9vxRHKU0rpuaMet12uGWXcF0nnx2d
         8dRg==
X-Gm-Message-State: AOAM5325c97/QYcFxR/sQfa8iJYf5SJLxcqnA02H5GAjzwih/dIxJEjz
        6eak0oZmA7xnqNoVI4XCx6o3DkAd2Fq0GpiRqNY=
X-Google-Smtp-Source: ABdhPJwh9cDj/SVQqtVAMl3mqZ0Uu/+26ei/COg69EKl8H4zQXaRuxmVeXVJaCG3gEszqAGjs1eRj5xWLZa0L7r7ppI=
X-Received: by 2002:a05:6402:2050:: with SMTP id bc16mr12027591edb.92.1630448166812;
 Tue, 31 Aug 2021 15:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <CAJvTdKn09GiAOgdsOR-+ooEO=bmj8VDL9e9sSAsu2UPx73a-Mw@mail.gmail.com> <a96a65fc-061b-e94b-cee7-16201ac0820f@intel.com>
In-Reply-To: <a96a65fc-061b-e94b-cee7-16201ac0820f@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 31 Aug 2021 18:15:55 -0400
Message-ID: <CAJvTdKkZ==89-rDeBUDy1GJEzU9FGiAb2m3rtMAGQPJQa1A2fA@mail.gmail.com>
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

On Mon, Aug 30, 2021 at 2:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/24/21 4:17 PM, Len Brown wrote:
> > Even if your AMX thread pool threads were to invoke this system call
> > as soon as possible...
> > What is to say that the thread pool is created only at a time when memory
> > is available?  A thread could be created 24 hours into program execution
> > under OOM conditions and this system call will return ENOMEM, and your program
> > will in all likelihood throw up its arms and exit at the exact same place
> > it would exit for transparently allocated buffers.
>
> I tried this exact line of reasoning with Thomas: it doesn't matter
> where we run out of memory, we still need the same memory and we're
> screwed either way.
>
> However, Thomas expressed a clear preference for ABIs which return
> memory failures explicitly at syscalls versus implicit failures which
> can happen on random instructions.
>
> One might say that the odds of checking for and handling a NULL value
> (or ENOMEM) are the same as installing a signal handler.  *But*, it's
> infinitely easier to unroll state and recover from a NULL than it is to
> handle it from within a signal handler.  In other words, the explicit
> ones *encourage* better programming.

I agree.
Indeed, I believe that there is universal agreement that a synchronous
return code
from a system call is a far superior programming model than decoding
the location of a failure in a system call.  (no, the IP isn't random -- it is
always the 1st instruction in that thread to touch a TMM register).

> I'd prefer removing the demand-driven allocation at this point.

Adding a pre-allocate system call that can gracefully fail
(even though it never will) is independent from removing
demand-driver allocation.  I would leave this to application
developers.  Honestly, the kernel shouldn't care.

-- 
Len Brown, Intel Open Source Technology Center
