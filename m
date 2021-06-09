Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFEE3A1CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhFIS2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:28:49 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:33361 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:28:48 -0400
Received: by mail-lj1-f173.google.com with SMTP id r16so1177458ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFQd3zAD8lpUyxGScL5+vdciPUdoe8anCwZ/Pot9vr8=;
        b=buypirlxci94sxOGbi+7kSMs1iSYy0ZicxwYsW9OVNC15G9EZTp5mpVkZytFoVCSqf
         KVWjrEyyIi3Cg3hAC/szqXXHzHz7n+fyN6GsW0ii+AaZ+ugC2LJF9qadg07T+AKyMKVR
         M56q0HKD/t0ucenNnyisNBKXGXANZ8TGiRLew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFQd3zAD8lpUyxGScL5+vdciPUdoe8anCwZ/Pot9vr8=;
        b=WohXZfb81AgQQShxCateal9Oe227bTxqplM9rWaas49pTaMxuZ1QGlk1YBp83qdtDW
         SakpLN5w4QkrYXvMjVfLn41wPtHZeAAU4/ZWbLoNox7xp3JNry61oatNVxgTBSkAgo4D
         GSOSw5Q8U0ZC1LlE4X/yDhiJLuPBmBTrl66TtIbbMAjyVbvi/KNrCC/XEKc295IwF9RH
         b/s+6m/6IRPDprFU1+DhUmvb3w2w+gvk84uRMrIpjCI95vKCOVydoyyWPVyB/TBiXc9C
         IlA+ep4nlU5kVe7ra9ApivoqsolsA43B9MuOQxQOeY1TEpDLggkLzeBhcvbu5PZEv1of
         v1xw==
X-Gm-Message-State: AOAM5303EpQIS+2q63rrxmENV76vHb4y+N2/uJO8NsAb5FtpcpKGgjGR
        stIbBzhA32n0qruFk1udFU49M/ibYFNKSljQ
X-Google-Smtp-Source: ABdhPJw9dn8qf5fJRC/OZ65W2CCFSm9mrVQ2Y+RlHFWQDyQs55PhCfXtqWUICtjFdugOk/ebCNbAYA==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr872004ljq.119.1623263141846;
        Wed, 09 Jun 2021 11:25:41 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s9sm53145ljp.62.2021.06.09.11.25.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 11:25:41 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id m21so23807870lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:25:40 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr460411lfa.421.1623263140500;
 Wed, 09 Jun 2021 11:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
 <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com>
 <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com>
 <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net> <20210608152851.GX18427@gate.crashing.org>
 <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com>
 <20210609153133.GF18427@gate.crashing.org> <CANpmjNPq3NBhi_pFpNd6TwXOVjw0LE2NuQ63dWZrYSfEet3ChQ@mail.gmail.com>
In-Reply-To: <CANpmjNPq3NBhi_pFpNd6TwXOVjw0LE2NuQ63dWZrYSfEet3ChQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 11:25:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJZVjdZYO7iNb0hFz-iynrEBcxNcT8_u317J0-nzv59w@mail.gmail.com>
Message-ID: <CAHk-=wgJZVjdZYO7iNb0hFz-iynrEBcxNcT8_u317J0-nzv59w@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Marco Elver <elver@google.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 9:13 AM Marco Elver <elver@google.com> wrote:
>
> I had a longer discussion with someone offline about it, and the
> problem with a builtin is similar to the "memory_order_consume
> implementation problem"

The "memory_order_consume" problem is *entirely* artificial, and due
to the C standards body incompetence.

Really. I was there. Only very peripherally, but I was involved enough
to know what the problem was.

And the problem wasn't the concept of 'consume'. The problem was
entirely and 100% the incorrect model that the C standards people used
to describe the problem.

The C standards people took a "syntax and type based" approach to the
whole thing, and it was an utter disaster. It's the wrong model
entirely, because it became very very hard to describe the issue in
terms of optimizations of expressions and ordering at a syntactic
level.

What the standard _should_ have done, is to describe it in the same
terms that "volatile" is described - make all memory accesses "visible
in the virtual machine", and then specify the memory ordering
requirements within that virtual machine.

We have successful examples of that from other languages. I'm sorry if
this hurts some C language lawyers fragile ego, but Christ, Java did
it better. Java! A language that a lot of people love to piss on. But
it did memory ordering fundamentally better.

And it's not like it would even have been a new concept. The notion of
"volatile" has been there since the very beginning of C. Yes, yes, the
C++ people screwed it up mightily and confused themselves about what
an "access" means. But "volatile" is actually a lot better specified
than the memory ordering requirements were, and the specifications are
(a) simpler and (b) much *much* easier for a compiler person to
understand.

Plus with memory ordering described as an operation - rather than as a
type - even the C++ confusion of volatile would have gone away. So the
very thing that likely made people want to avoid the "visible access
in the virtual machine" model didn't even _exist_ in the first place.

So the language committee pointlessly said "volatile is bad, we need
to do something else", and came up with something that was an order of
magnitude worse than volatile, and that simply _couldn't_ possibly
sanely handle that "problem of consume".

But the problem was always purely about the model used to _describe_
the issue being bad, not the issue itself.

The "consume" memory ordering is actually very easy to describe in the
"as if" virtual machine memory model (well, as easy as _any_ memory
ordering is). If the C standards committee hadn't picked the wrong way
to describe things, the problem simply would not exist.

Really.

And I guarantee you that compiler writes would have had an easier time
with that "virtual memory model" approach too. No, memory ordering
sure as hell isn't simple to understand for *anybody*, but it got
about a million times worse by using the wrong abstraction layer to
try to "explain" it.

It really is fairly easy to explain what "acquire" is at a virtual
machine model level. About as easy as memory ordering gets. For a
compiler writer, it basically turns into "you have to do the actual
access using XYZ, and then you can't move later memory operations to
before it". End of story.

So you can actually describe these things in fairly straighforward
manner if you actually do it at that virtual machine level, because
that's literally the language that the hardware itself works at.

And then you could easily have defined "consume" as being the same
thing as "acquire", except that you can drop the special XYZ access
(fence, ld.acq, whatever) and replace it with a plain load if there
are only data dependencies on the loaded value (assuming, of course,
that your target hardware then supports that ordering requirements:
alpha would _always_ need the barrier).

That could literally have been done as a peephole optimization, and a
compiler writer would never have had to even really worry about it.
Easy peasy. 99% of all compiler writers would not have to know
anything about the issue, there would be just one very special
optimization at the end that allows you to drop a barrier (or turn a
"ld.acq" into just an "ld") once you see all the uses of that loaded
value. A trivial peephole will handle 99% of all cases, and then for
the rest you just keep it as acquire.

So anybody who tells you that "consume is complicated" is wrong.
Consume is *not* complicated. They've just chosen the wrong model to
describe it.

Look, memory ordering pretty much _is_ the rocket science of CS, but
the C standards committee basically made it a ton harder by specifying
"we have to make the rocket out of duct tape and bricks, and only use
liquid hydrogen as a propellant".

               Linus
