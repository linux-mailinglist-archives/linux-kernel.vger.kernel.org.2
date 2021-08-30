Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4C3FBB3B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhH3Rx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:53:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234054AbhH3RxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:53:25 -0400
Received: from zn.tnic (p200300ec2f0b3b00d8cdf5b388faf601.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3b00:d8cd:f5b3:88fa:f601])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC34A1EC046C;
        Mon, 30 Aug 2021 19:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630345946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qwqY/e8zAFEbnfzfmwuOFVfbvtAHUourgChAT3n9jFs=;
        b=f+vXe6fX6EuRw6PSCH4fdw4lFpiIGWwSGeLAE7vflk1k496J4EgkzIjHrgQZ/iA+MB0u+Q
        MvCXwjUZudXuHgsitOJKZ0a+17JKJvuAqSLZN9bWRQdOsRifdqb0yQUZakvT2PFofw/U4t
        xwgDM1BOQBLso6sLHE5kZWKdJac8iU4=
Date:   Mon, 30 Aug 2021 19:53:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, thiago.macieira@intel.com,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Message-ID: <YS0bAPaDGcDKftUp@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com>
 <YR00U19168BGoRB9@zn.tnic>
 <CAJvTdKn09GiAOgdsOR-+ooEO=bmj8VDL9e9sSAsu2UPx73a-Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKn09GiAOgdsOR-+ooEO=bmj8VDL9e9sSAsu2UPx73a-Mw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 07:17:49PM -0400, Len Brown wrote:
> The problem with a system call to pre-allocate an AMX context switch
> buffer is that it doesn't actually deliver on the goal of guaranteeing
> no subsequent run-time failures due to OOM.

You mean you pre-allocate *everything*, i.e., you won't do any more
allocations but then you still might OOM?

Yeah, right.

Maybe from something else but not from your AMX-using process which has
prepared everything already.

> Even if your AMX thread pool threads were to invoke this system call
> as soon as possible... What is to say that the thread pool is created
> only at a time when memory is available? A thread could be created
> 24 hours into program execution under OOM conditions and this system
> call will return ENOMEM, and your program will in all likelihood
> throw up its arms and exit at the exact same place it would exit for
> transparently allocated buffers.

Well, if you preallocate everything you won't have to run for 24 hours,
encounter -ENOMEM and *lose* 24 hours worth of AMX computation. And then
the kernel won't have to do all kinds of crazy dance with dynamically
resizing buffers just because some small percentage of luserspace apps
decided to do AMX stuff.

> The program can equally cause the kernel to allocate an AMX context
> switch buffer by simply touching a TMM register -- and this can
> be done at exactly the same place in the program that calling a
> pre-allocate system call.

If the program touches a TMM register and it hasn't requested AMX
support upfront, it'll get killed.

> The advantage of the #NM over the syscall is that the programmer
> doesn't actually have to do anything. Also, transparently allocated
> buffers offer a theoretical benefit that a program may have many
> threads, but only a few may actually touch AMX, and so there is
> savings to be had by allocating buffers only for the threads that
> actually use the buffers.

The program already asked the kernel whether it can use AMX - it can
allocate the buffers for the threads too.

> XFD is used to *enforce* that AMX is not used without permission.
> Were we to not use the XFD feature, users would be able to stash
> data in TMM registers and even use TMUL without the kernel
> being able to prevent them from doing so.  Then when they
> context switch or take a signal, the data in their TMM registers
> would mysteriously vanish...
>
> Much better to be able to tell them immediately that they are doing it
> wrong...

Ok, killing the program in the #NM handler if it hasn't requested AMX
prior makes sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
