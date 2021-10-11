Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D896D4297C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhJKT5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhJKT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:57:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23B3C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:55:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r19so75480534lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZuq6hLCB8SZOaOkyQal5SZNbEA73gBxFLwmienOXug=;
        b=EXKDlCw9/2oA8ccI7o17J7tmT0xxF9IUNjnn0mg2fSideQ/o44XfHpJb7hXz9TxpI1
         P5EBdvJdLYu7r2gTymbFIrxDpbd7URfknyinKomZAYtTfMlgcMm6/LIM2H1izvAgBOf/
         wKJkBoXT2rlVqMY5MJNfdzh1DxMK6JJhuz2ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZuq6hLCB8SZOaOkyQal5SZNbEA73gBxFLwmienOXug=;
        b=llLy6hQc+3cgLWOqDrSiR+AJPrbWT5soS4r78L+0Whq6HZ9NQIuQr8fMxiGwngqjTK
         cpHpDKawM0dOklych3iWZrRxtdGTlwUJYabs8gyM7jtTi2t49URdd6kLc77crCCwYxj5
         UBxc+FYX6WTqjCeppFeRnKWjMBuKgriHr6WX8eaOWtp0fc9yZ++nrqw0OxOcy0BtNQaJ
         s08ZxosOmtmb4PV/KtJeRPN7bdYY8Lch2/lOlKeexwoKSOnRuUMpRLD/gQHx9muscCqh
         xzgcWTmIj1hPhXD+n2Q7MxF0mVr21NIAf1XOqa4AohE2mnnd9eC6qZ+pahxYZ9vzPWSy
         +dnw==
X-Gm-Message-State: AOAM5321ZP8fNa5qbTzGXT9Gt0weQlL5D0ILVBHi9Z6SynkhaflaZpov
        DdGFp/chDKZbaK9Hc9yaxQXlKPrvUkOjyMtP
X-Google-Smtp-Source: ABdhPJypdIwt+0StEuqafUD7rG4uqtFZpNV29sYuF5qeA2hYUj43Avvqt8kpqzCZ6n6jD778LxtEEQ==
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr3309553ljf.520.1633982106538;
        Mon, 11 Oct 2021 12:55:06 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id l14sm816319lfe.124.2021.10.11.12.55.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 12:55:05 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y26so78860582lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:55:05 -0700 (PDT)
X-Received: by 2002:a05:6512:984:: with SMTP id w4mr29688628lft.141.1633982105445;
 Mon, 11 Oct 2021 12:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <YWCPyK+xotTgUMy/@arm.com> <CAHk-=whWZ4OxfKQwKVrRc-E9=w-ygKdVFn_HcAMW-DW8SgranQ@mail.gmail.com>
 <20211011104729.GB1421@C02TD0UTHF1T.local>
In-Reply-To: <20211011104729.GB1421@C02TD0UTHF1T.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Oct 2021 12:54:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTAJwMJZ-6PPxvdtDmkL0=pfRF77nJ5qWw2vbiTzT4nQ@mail.gmail.com>
Message-ID: <CAHk-=wjTAJwMJZ-6PPxvdtDmkL0=pfRF77nJ5qWw2vbiTzT4nQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc5
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 3:47 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Sorry; I agree that commit messages don't explain this thoroughly. I can
> go and rework the commit messages to clarify things, if you'd like?

So I really hate that patch, even with explanation.

Having the Kconfig option for "do the right thing" is not how this
should be fixed.

Either the generic code is generic, or it isn't.

And if the generic code doesn't work for arm64, we shouldn't add a
random Kconfig option for "this architecture wants different
behavior".

> The TL;DR is that a bunch of constraints conspire such that we can't
> defer accounting things to the irqdomain or irqchip code without making
> this even more complicated/fragile, and many architectures get this
> subtly wrong today -- it's not that arm64 is necessarily much different
> from other architectures using this code, just that we're trying to
> solve this first.

So then I think the fix is to just say "accounting in this generic
function is wrong, and the accounting needs to be moved to the
callers".

That's particularly true if you think arm64 is only the only actually
_tested_ case that gets this wrong, and other architectures most
likely have the exact same issue, but you only fixed it for arm64.

So do it unconditionally - possibly even using a coccinelle script if
there are lots of callers.

Because generic code that just isn't generic, but randomly does
different things based on subtle Kconfig options that are different
for different architectures is bad, bad, bad.

And yes, I realize that we've had that kind of stuff before (and we
have odd Kconfig option testing in that irqdesc.c file elsewhere), but
the Kconfig options we currently have are mostly either

 (a) actual real honest-to-goodness config options with semantic
meaning (ie things like CONFIG_SMP and CONFIG_NUMA)

 (b) really ugly workarounds for odd special module exports (that
CONFIG_KVM_BOOK3S_64_HV_MODULE thing for irq_to_desc() that we *tried*
but failed to remove).

And so the reason I really hate that patch is that it introduces a new
"different architectures randomly and inexplicably do different
things, and the generic behavior is very different on arm64 than it is
elsewhere".

That's just the worst kind of hack to me.

And in this case, it's really *horribly* hard to see what the call
chain is. It all ends up being actively obfuscated and obscured
through that 'handle_arch_irq' function pointer, that is sometimes set
through set_handle_irq(), and sometimes set directly.

I really think that if the rule is "we can't do accounting in
handle_domain_irq(), because it's too late for arm64", then the fix
really should be to just not do that.

Move the irq_enter()/irq_exit() to the callers - quite possibly far up
the call chain to the root of it all, and just say "architecture code
needs to do this in the low-level code before calling
handle_arch_irq".

Or, if it turns out that 99% of callers do want it - and don't have
the issues arm64 has - maybe we can have a helper wrapper that does
the irq_enter/irq_exit, and another version that doesn't do it, and at
least it's clear to the callers which one it is. But it looks like
particularly with the odd indirection through that handle_arch_irq
function, it's best to just say "this needs to be done".

What architectures actually care? From what I can follow, it's really
GENERIC_IRQ_MULTI_HANDLER that ends up doing this all, and then arm64
has it's own special case for no obvious reason (why isn't it using
GENERIC_IRQ_MULTI_HANDLER that seems to do the EXACT same thing in
generic code except for a special "default != NULL" case?)

Anyway, it _looks_ to me like the pattern is very simple:

Step 1:
 - remove irq_enter/irq_exit from handle_domain_irq(), move it to all callers.

This clearly doesn't change anything at all, but also doesn't fix the
problem you have. But it's easy to verify that the code is the same
before-and-after.

Step 2 is the pattern matching step:

 - if the caller of handle_domain_irq() ends up being a function that
is registered with set_handle_irq(), then we
   (a) remove the irq_enter/irq_exit from it
   (b) add it to the architectures that use handle_arch_irq.
   (c) make sure that if there are other callers of it (not through
handle_arch_irq) we move that irq_enter/irq_exit into them too

I _suspect_ - but didn't check - that Step 2(c) doesn't actually
exist. But who knows.

It really looks like there is a very tight connection between "uses
handle_domain_irq()" and "uses handle_arch_irq/set_handle_irq()". No?

Is this a bit more work? Yes.

Would this fix arm64? Yes - it ends up effectively doing what you did.

Would this fix _other_ architectures doing the same thing that you
suspect are broken? YES. Instead of leaving them randomly broken.

And most importantly, it would make the rules for "generic" code
clear, and actually generic.

Now, it may be that I'm wrong. I'm willing to be convinced, and if you
beat me over the head enough I guess I can take that pull request and
just be unhappy about it.

So I'm not trying to draw some line in the sand and be an arsehole and
say "you have to do it this way". But I look at that patch in that
pull request, and it really screams "this is horribly wrong" to me.

And I _think_ the above suggestion can be done almost mechanically.

And maybe it's easier to combine step1/step2 into one thing, if that
handle_domain_irq/handle_arch_irq" use is really as tightly bound as
it seems to be from a quick look.

So I'm not saying that they have to be separate steps, I wrote them
out that way mainly to kind of show the logic of the change - and in
case there are situations where you end up calling things without
going through that handle_arch_irq thing.

                       Linus
