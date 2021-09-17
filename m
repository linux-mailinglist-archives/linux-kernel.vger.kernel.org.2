Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8640F07D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbhIQDuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:50:04 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40648 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhIQDuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:50:02 -0400
Received: by mail-lf1-f52.google.com with SMTP id b15so8666546lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61OxAUogSkIxWB3LFzIT2/uAznnOFi3ElTX70XMTJyw=;
        b=aKHinXsbhUNCq4ZMhMT8IGzIlEUjstoc+YtSLBqTtgPhpFDSR1AQzuDBDK6fZ75iGI
         fFR2g3W26L7xPYwagWxpiTFw0wX4oi5Bl74QlgUZbQVq3p6b7ct0kvRJ4kECV/4u3fyh
         fVGLiES/5vvjHuGt9dEv9ygFzV6tjM+X/eX0WGTs06vUIB+LgMTWfRQN9fZGnd6KSnBv
         gg69VdFMfnNsMqn/Xlpeyjw1rsgUTp5RQm6ux0bHFT9QaAcC9mfp6jnLg0I2iXPWd3v5
         fbA/bpnlqEG+Zg9oP7mmeBzhdbFKEjXsTwlltwEhwoV9Z0oXXt1g30it4bF00f9ghZab
         4+cw==
X-Gm-Message-State: AOAM531VIWUFpJ73yOroEEhtmoWCfM1h56al5K/6zGZHCJKEewoVe9I5
        BLpZszHarqhm0N4cY1D5xRkLQBN9R7pKzbZYy9M=
X-Google-Smtp-Source: ABdhPJxi+3DcBAX8v0TMi1IjyzgzK4mQK7DOdBYFFt4RSgClpkGpa+I7SdJStP5+0NZTfLbUOhaKDYhLkCm8JXh0jHY=
X-Received: by 2002:a2e:9798:: with SMTP id y24mr7484195lji.165.1631850519537;
 Thu, 16 Sep 2021 20:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5> <YR1HYRRN0HMTxXrw@zn.tnic>
 <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com> <YR14zq2LaExjhFR+@zn.tnic>
 <CAJvTdKnhn8rOKUJ0VKvM08sFYkvmEsSWBsH2ynncxH9_z49bxA@mail.gmail.com> <YS0V//png0YVPWHG@zn.tnic>
In-Reply-To: <YS0V//png0YVPWHG@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 16 Sep 2021 23:48:28 -0400
Message-ID: <CAJvTdKnXy9D=CWHhYEC=W8=+O=ebD9katC5uKXLYCoErAYMQvw@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 1:31 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Aug 24, 2021 at 07:22:18PM -0400, Len Brown wrote:
> > We are forced to complicate their life for AMX (and subsequent features)
> > because of the legacy Linux signal ABI.
>
> No, we need to design this interface properly because you folks went and
> put this AMX thing in xstates. Where it doesn't belong at all.

Years ago, somebody, other than you or I, decided to use uncompacted
XSTATE on the Linux signal stack.

Years ago, somebody else, also other than you or I, decided that AMX should
be implemented using XSTATE.

Today, we are all working together to deal with this collision, in as
graceful a manner as possible.  Yes?

> > We require that new apps invoke a system call to tell us that they
> > are not indeed a legacy program, but that they are a program that
> > understands if they use an alt-sig-stack that it must be big enough to
> > handle whatever current hardware requires.
>
> Yes, because of the reason I gave above. If no additional 8K fat wasn't
> an xstate, we wouldn't be having this conversation.

While not as huge, AVX-512 has the  same XSTATE bloat issue as AMX --
including the demonstrated ability to overflow the signal stack and kill apps.

The silver lining is that due to the AMX enabling effort, we updated
the glibc ABI
to comprehend variable sigstacksize.  So glibc 2.34, which released Aug 1st,
comprehends whatever the current hardware supports.

> > The secondary motivation for the system call is the desire to give the
> > kernel a hook so that it can refuse to give permission for some apps
> > to use AMX, should the need arise.
>
> Yes.
>
> > > prctl(GET_FEATURES_WITH_KERNEL_ASSISTANCE);
> >
> > The problem is that it adds zero value over the currently used xgetbv(XCR0).
> > As it adds no value, programmers will not use it.

[expletive deleted]

> First of all, it is a new interface we're introducing and if it is
> there from the get-go along with examples how to use it and proper
> documentation, people will.

The application people I talk to are not asking for more system calls.
They would prefer zero system calls (which was our initial proposal).

> Secondly, from a previous email of mine: "What if this modus operandi of
> features userspace can use with kernel assistance but need an explicit
> request and are off otherwise, gets extended beyond XSAVE-managed
> features?"
>
> In that case you can xgetbv() all you want but the new fat feature is
> not even in XCR0. So *then* you *have* to introduce a new prctl() to
> query supported features. And right then and there you wish you would've
> done that from the very beginning!

Sorry, I don't recall seeing that previous note -- maybe it flew past
when I was out.

I have no problem with the quest to develop a universal ABI
to layer over or otherwise replace CPUID and XCR0 and allow kernel override etc.

My point is simply that I haven't seen a case where somebody wanting to use AMX
would need it, and so I don't think developing such an ABI should gate
AMX support.

thanks,
Len Brown, Intel Open Source Technology Center
