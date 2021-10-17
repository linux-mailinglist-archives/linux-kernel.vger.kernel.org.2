Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF2430714
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbhJQHow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbhJQHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 03:44:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A4C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 00:42:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c29so12250998pfp.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cA31YHoAojFMXfvWIq1mbnRWY4u6SaL5BET0d5T/ktw=;
        b=qnF4rTeRZDNSrp9fYaIMA+NmTnQdkkydcDZnUGGvt9G7E4U6das5WLceavH1fz7W2R
         ROi6ZjQ0sJNwTvaHRw0zpTB2g95nWy6L9tDYzEpRFCsPAgj2eUMxpUUQHyB6prfOuvW+
         mmWtdhGQjqeRUodYPOLgdzXuOuy7TwemrGhH5qIJ85P9kK3qHcwPpa13bmTAVebAEUQr
         DsFyJCW8EhN9c7JptPjp3NZjr9wF1vDmzCJWwqGlkcIs3DGu22Hidv/AVOpA8lnT3OLG
         0i0hX525+IcXKZaKWU4EFfY1vKFGB/MipL3D3yeyErO/dJsFRQjJBT7bQM3AUBNln1Oe
         T1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cA31YHoAojFMXfvWIq1mbnRWY4u6SaL5BET0d5T/ktw=;
        b=WbStcjva88NcDcz65uKxjE+6x+VQz5zIALU/ZyQil2DQiLnBue33k/8m/S3wC2KraF
         TyMqNEHUg8P5efYe8wJ7xOmYiSEdzY+3/f8rShFzIEkN8ECwt3CiCmavgsHJv1M0WJYH
         aP8hZfBK2lJpSjLJZ2rqQXbnSlHbeYCJonZN9pfMnizHkIqWMAMaoE3ReJK+/xVCMl5e
         5nnz8UVCCzGUtsz3SgZoXocmfDYbPb0Xza3iCAAfgntW08qqA8bXuyXOUbpTSi+l+Edg
         BlG4n66Xg5aK98U5bEJg34aUxCA53me+pzShnY2nfGw9rZ4dVLj5rTXaxFTl78oZ3TVn
         ftGA==
X-Gm-Message-State: AOAM530MzW6U0te1vxWyRjT6HTUVg4Fi/46RoVsOfiUKjwmMDFN5HDuk
        yTg+7mlci3p0zSyPNef9bQ==
X-Google-Smtp-Source: ABdhPJwDOxO5q67+iounQrxtmhizWndA71VCMYH4kGmfb7B5+E/poyFPWGQKM4KpUlMPudG6gKshTA==
X-Received: by 2002:a63:3e84:: with SMTP id l126mr12995435pga.55.1634456561089;
        Sun, 17 Oct 2021 00:42:41 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n7sm9589763pfd.37.2021.10.17.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 00:42:40 -0700 (PDT)
Date:   Sun, 17 Oct 2021 15:42:34 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc5
Message-ID: <YWvT6hQWODTFaMwA@piliu.users.ipa.redhat.com>
References: <YWCPyK+xotTgUMy/@arm.com>
 <CAHk-=whWZ4OxfKQwKVrRc-E9=w-ygKdVFn_HcAMW-DW8SgranQ@mail.gmail.com>
 <20211011104729.GB1421@C02TD0UTHF1T.local>
 <CAHk-=wjTAJwMJZ-6PPxvdtDmkL0=pfRF77nJ5qWw2vbiTzT4nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTAJwMJZ-6PPxvdtDmkL0=pfRF77nJ5qWw2vbiTzT4nQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I am not in the Cc list, so just aware of it the day before yesterday.

On Mon, Oct 11, 2021 at 12:54:49PM -0700, Linus Torvalds wrote:
> On Mon, Oct 11, 2021 at 3:47 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Sorry; I agree that commit messages don't explain this thoroughly. I can
> > go and rework the commit messages to clarify things, if you'd like?
> 
> So I really hate that patch, even with explanation.
> 
> Having the Kconfig option for "do the right thing" is not how this
> should be fixed.
> 
> Either the generic code is generic, or it isn't.
> 
> And if the generic code doesn't work for arm64, we shouldn't add a
> random Kconfig option for "this architecture wants different
> behavior".
> 
> > The TL;DR is that a bunch of constraints conspire such that we can't
> > defer accounting things to the irqdomain or irqchip code without making
> > this even more complicated/fragile, and many architectures get this
> > subtly wrong today -- it's not that arm64 is necessarily much different
> > from other architectures using this code, just that we're trying to
> > solve this first.
> 
> So then I think the fix is to just say "accounting in this generic
> function is wrong, and the accounting needs to be moved to the
> callers".
> 
> That's particularly true if you think arm64 is only the only actually
> _tested_ case that gets this wrong, and other architectures most
> likely have the exact same issue, but you only fixed it for arm64.
> 
> So do it unconditionally - possibly even using a coccinelle script if
> there are lots of callers.
> 
> Because generic code that just isn't generic, but randomly does
> different things based on subtle Kconfig options that are different
> for different architectures is bad, bad, bad.
> 

When composing the patch, I failed to realize it, but now, I learn.

> And yes, I realize that we've had that kind of stuff before (and we
> have odd Kconfig option testing in that irqdesc.c file elsewhere), but
> the Kconfig options we currently have are mostly either
> 
>  (a) actual real honest-to-goodness config options with semantic
> meaning (ie things like CONFIG_SMP and CONFIG_NUMA)
> 
>  (b) really ugly workarounds for odd special module exports (that
> CONFIG_KVM_BOOK3S_64_HV_MODULE thing for irq_to_desc() that we *tried*
> but failed to remove).
> 
> And so the reason I really hate that patch is that it introduces a new
> "different architectures randomly and inexplicably do different
> things, and the generic behavior is very different on arm64 than it is
> elsewhere".
> 
> That's just the worst kind of hack to me.
> 
> And in this case, it's really *horribly* hard to see what the call
> chain is. It all ends up being actively obfuscated and obscured
> through that 'handle_arch_irq' function pointer, that is sometimes set
> through set_handle_irq(), and sometimes set directly.
> 
> I really think that if the rule is "we can't do accounting in
> handle_domain_irq(), because it's too late for arm64", then the fix
> really should be to just not do that.
> 
> Move the irq_enter()/irq_exit() to the callers - quite possibly far up
> the call chain to the root of it all, and just say "architecture code
> needs to do this in the low-level code before calling
> handle_arch_irq".
> 
> Or, if it turns out that 99% of callers do want it - and don't have
> the issues arm64 has - maybe we can have a helper wrapper that does
> the irq_enter/irq_exit, and another version that doesn't do it, and at
> least it's clear to the callers which one it is. But it looks like
> particularly with the odd indirection through that handle_arch_irq
> function, it's best to just say "this needs to be done".
> 
> What architectures actually care? From what I can follow, it's really
> GENERIC_IRQ_MULTI_HANDLER that ends up doing this all, and then arm64
> has it's own special case for no obvious reason (why isn't it using
> GENERIC_IRQ_MULTI_HANDLER that seems to do the EXACT same thing in
> generic code except for a special "default != NULL" case?)
> 
> Anyway, it _looks_ to me like the pattern is very simple:
> 
> Step 1:
>  - remove irq_enter/irq_exit from handle_domain_irq(), move it to all callers.
> 
> This clearly doesn't change anything at all, but also doesn't fix the
> problem you have. But it's easy to verify that the code is the same
> before-and-after.
> 
> Step 2 is the pattern matching step:
> 
>  - if the caller of handle_domain_irq() ends up being a function that
> is registered with set_handle_irq(), then we
>    (a) remove the irq_enter/irq_exit from it
>    (b) add it to the architectures that use handle_arch_irq.
>    (c) make sure that if there are other callers of it (not through
> handle_arch_irq) we move that irq_enter/irq_exit into them too
> 
> I _suspect_ - but didn't check - that Step 2(c) doesn't actually
> exist. But who knows.
> 
> It really looks like there is a very tight connection between "uses
> handle_domain_irq()" and "uses handle_arch_irq/set_handle_irq()". No?
> 
> Is this a bit more work? Yes.
> 
> Would this fix arm64? Yes - it ends up effectively doing what you did.
> 
> Would this fix _other_ architectures doing the same thing that you
> suspect are broken? YES. Instead of leaving them randomly broken.
> 
> And most importantly, it would make the rules for "generic" code
> clear, and actually generic.
> 
> Now, it may be that I'm wrong. I'm willing to be convinced, and if you
> beat me over the head enough I guess I can take that pull request and
> just be unhappy about it.
> 

I had thought if any arch adapts GENERIC_ENTRY, then handle_domain_irq()
can be a bug. As GENERIC_ENTRY is a not _random_ config option, so try
to re-anchor the config depending on GENERIC_ENTRY.

But finally I gave up, since there is no direct link between them at a
glance. And what is more, as you said, "the rules for "generic" code
clear, and actually generic", so it is better to go in that way.

I think Mark has started the work or I will be happy to re-work on these
patches.

Thanks,

	Pingfan

