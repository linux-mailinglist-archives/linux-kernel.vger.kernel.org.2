Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955754234CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhJFAL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhJFAL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:11:29 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AECF6115A;
        Wed,  6 Oct 2021 00:09:37 +0000 (UTC)
Date:   Tue, 5 Oct 2021 20:09:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211005200935.2429ec2c@rorschach.local.home>
In-Reply-To: <20211005193557.GA881195@embeddedor>
References: <20211005053922.GA702049@embeddedor>
        <20211005111714.18ebea2b@gandalf.local.home>
        <20211005161812.GA768055@embeddedor>
        <20211005123522.244281e6@gandalf.local.home>
        <20211005165027.GA797862@embeddedor>
        <20211005150807.03da5e54@gandalf.local.home>
        <20211005193557.GA881195@embeddedor>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 14:35:57 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> On Tue, Oct 05, 2021 at 03:08:07PM -0400, Steven Rostedt wrote:
> [..]
> > Or did you not remove your patch first?  
> 
> Yep; that was the problem. 
> 
> I now applied it to a clean tree and the warnings went away.
> 
> However, I'm a bit concerned about the following Jann's comments:

I should have replied back then, but I'll do that now (and added Jann
to the CC) 

> 
> "the real issue here is that ftrace_func_t is defined as a fixed
> type, but actually has different types depending on the architecture?
> If so, it might be cleaner to define ftrace_func_t differently
> depending on architecture, or something like that?"[1]

It's not dependent on the architecture. It's dependent on what the
architecture has implemented. There's nothing limiting the arch to use
the normal method, except that nobody implemented the updates.

As I changed the core API, it affected the architectures, and since I
don't know how to update all the architectures that use that API, and
do not have the hardware to test it, I made it so architectures can
slowly be updated when their maintainers get time to. This was years
ago, and not much has been done.

> 
> "Would it not be possible to have two function types (#define'd as the
> same if ARCH_SUPPORTS_FTRACE_OPS), and then ensure that ftrace_func_t
> is only used as ftrace_asm_func_t if ARCH_SUPPORTS_FTRACE_OPS?"[2]
> 
> "Essentially my idea here is to take the high-level rule "you can only
> directly call ftrace_func_t-typed functions from assembly if
> ARCH_SUPPORTS_FTRACE_OPS", and encode it in the type system. And then
> the compiler won't complain as long as we make sure that we never cast
> between the two types under ARCH_SUPPORTS_FTRACE_OPS==0."[3]
> 
> So, is this linker approach really a good solution to this problem? :)
> 
> What's the main problem with what Jann suggests?

The main issue is I want no more #ifdef's in the main code. There's too
many already and it makes it difficult to maintain. I want to get rid
of them, not add more. So anything that adds more #ifdef's to the main
code, I will NACK.

Which I guess leaves us with either the linker trick, or having all
the archs get updated to support the latest ftrace features, and we can
remove the current #ifdefs.

-- Steve


> 
> Thanks!
> --
> Gustavo
> 
> [1] https://lore.kernel.org/all/CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAG48ez04Fj=1p61KAxAQWZ3f_z073fVUr8LsQgtKA9c-kcHmDQ@mail.gmail.com/#t
> [3] https://lore.kernel.org/all/CAG48ez1LoTLmHnAKFZCQFSvcb13Em6kc8y1xO8sNwyvzB=D2Lg@mail.gmail.com/

