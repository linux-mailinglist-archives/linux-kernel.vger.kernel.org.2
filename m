Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C405041FF05
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 03:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhJCBHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 21:07:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhJCBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 21:07:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633223157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0i8Hp752UlOEh08Tba/6o+62fWeinAiVkCS777Vkklk=;
        b=UuDRfkJPN1UsSqxn0EH4ruysXGooyk31H2A26rdNsmhfQV5Kv0E2Ce+BazDOkQ7FCh+ud2
        YEgvOheCsIWoABCLziBpubyd1bqhJvLeqWAJ6or99PvpvhaA6jw1PCawAsAvQC76yz2ukq
        HQ43U5uWPjA7TaisHhvl6sQtnKOqyYcGG8BcRyQeBWJSV2A2jJynrL3+l/FKWBKw9k3c9o
        /qSQmUX4DRoV6FqsrqxYNAH/W4rSmeW1XuWusTYWuzk1pORlYobvVXM8wNwrJ7xeqbxlST
        G8cWQTBL6+zef5x7vRVBZvLG3/j92QNJYvfgloMi1KupDLOvQzQSGuvP9KgvGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633223157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0i8Hp752UlOEh08Tba/6o+62fWeinAiVkCS777Vkklk=;
        b=EmxY0FCvX1ou/teCDaOp4/sMbQr3ElbkCpllWssZeM1TifkOHOjwcjYNkHgJOOZ74Ntxrr
        CwixNS/ViYvRDyDg==
To:     "Brown, Len" <len.brown@intel.com>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
In-Reply-To: <89BFDA7D-C27F-4527-B494-1397876CA6F2@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <89BFDA7D-C27F-4527-B494-1397876CA6F2@intel.com>
Date:   Sun, 03 Oct 2021 03:05:56 +0200
Message-ID: <87k0iuhq8b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

On Fri, Oct 01 2021 at 22:50, Chang Seok Bae wrote:
> Sending this version as it follows up the discussion [1] with some code
> changes from v10. This is not intended to ignore your comment on v10 at all.
> Appreciate your points on my oversights that I will address in v12 soon.

why on earth did you make Chang send these patches out when there are
fundamental review comments on the fly vs. the previous version?

The changes vs. V10 just try to address the recently discussed updates
to the permission interface, which we agreed on a couple of days ago,
but all of that still is built on top of something which has serious
flaws at all ends.

Rushing stuff out just to get an internal checkbox ticked off might be
interesting for Intel internal managerial reasons about which I don't
care at all.

But I very much care about the noise in my inbox and the time I have to
spend^W waste on this. Aside of that I care about how this shifts the
blame to someone else. See below. 

Looking at the delta between v10 and v11, it's entirely clear that this
is just a hastily cobbled together update which hasn't even seen any
reasonable scrunity. Just looking at this gem:

> +long do_arch_prctl_state(struct task_struct *tsk, int option, unsigned long arg2,

...

> +	case ARCH_GET_FEATURES_WITH_KERNEL_ASSISTANCE:
> +		return put_user(features_mask, (unsigned long __user *)arg2);
> +	case ARCH_SET_STATE_ENABLE: {

> +		if (arg3 != ARCH_SET_STATE_ENABLE_ALLOC) {

A suboption in the same namespace? Why? What's wrong with having
explicit options to make the user space interface sensible?

> +			tsk->group_leader->thread.fpu.state_perm |= state_perm;

Accessing tsk->group_leaader is safe here because?

> +			return 0;
> +		}
> +
> +		for_each_thread(tsk, t) {

Walking the threads is safe here because?

> +			spin_lock_irq(&t->thread.fpu.prealloc.lock);

Nesting the lock acquisitions for potentially hundreds of threads is
correct in which way?

Also what is disabling interrupts protecting against?

If nesting these locks would be sensible in any way, then how is _irq()
the correct mechanism to use?

> +			if (!err)
> +				err = prealloc_xstate_buffer(t, state_perm);

Surely continuing the list walk when an error happened is a brilliant
idea.

Aside of that this still calls into vzalloc() with interrupts
disabled which is wrong to begin with.

> +		}
> +
> +		for_each_thread(tsk, t) {
> +			if (err)
> +				free_xstate_prealloc_buffer(&t->thread.fpu);
> +			spin_unlock_irq(&t->thread.fpu.prealloc.lock);

If this ever gets invoked from a process which has threads then the
unconditional enabling of interrupts here is protecting the rest of the
threads against interrupts in which way?

Not that the interrupt disable above is protecting anything, but that's
just beyond hillarious, really.

> +		}
> +
> +		if (err)
> +			return -ENOMEM;
> +
> +		tsk->group_leader->thread.fpu.state_perm |= state_perm;
> +		set_tsk_thread_flag(tsk->group_leader, TIF_FPU_PREALLOC);

Again, accessing tsk->group_leaader is still safe here because?

> +		return 0;

IOW a total of at least 5 obvious bugs in 60 lines of code (including
new lines and comment). That's an achievement.

Len, it's sad that an experienced kernel developer like you is sticking
a Reviewed-by tag on something like that. Either you forgot anything
about kernel development since you became a manager or you simply do not
care anymore and just want to tick your checkboxes. Neither one of these
options is acceptable.

What's even worse is that you made Chang to send that out, instead of
guiding him with your experience to do the right thing. IOW, you make
Chang look bad instead of helping him. Big coporate culture I assume,
but that does not justify that in any way.

Yours seriously grumpy

     Thomas
