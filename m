Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560B141ECF2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354294AbhJAMLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:11:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354146AbhJAMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:11:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7D55223FF;
        Fri,  1 Oct 2021 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633090196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMNtJrbC0GnzRHpRVHcvpxd5r5byMIwvTLIh1FKx91I=;
        b=sXm0w2uUnG8p6tiV2Z1mK1CVCNFn3B50GQ0XrAGn2QOR5GIUB+/8cEE6DSKYRJgsyCmxev
        PSwoqv6ESRnPMVUC+IJNmxsyjyv7E2S2IoGx/0BdkhUcz41PQ7cHBX/YAbnJgobD9cAFk4
        vUr0IHQweYKklazQJmidOEv16+HHW1s=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C1854A3B81;
        Fri,  1 Oct 2021 12:09:55 +0000 (UTC)
Date:   Fri, 1 Oct 2021 14:09:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Garnier <thgarnie@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, notify@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
Message-ID: <20211001120955.GA965@pathway.suse.cz>
References: <20210929185823.499268-1-alex.popov@linux.com>
 <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1>
 <YVWAPXSzFNbHz6+U@alley>
 <20210930125903.0783b06e@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930125903.0783b06e@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-09-30 12:59:03, Steven Rostedt wrote:
> On Thu, 30 Sep 2021 11:15:41 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Wed 2021-09-29 12:49:24, Paul E. McKenney wrote:
> > > On Wed, Sep 29, 2021 at 10:01:33PM +0300, Alexander Popov wrote:  
> > > > On 29.09.2021 21:58, Alexander Popov wrote:  
> > > > > Currently, the Linux kernel provides two types of reaction to kernel
> > > > > warnings:
> > > > >  1. Do nothing (by default),
> > > > >  2. Call panic() if panic_on_warn is set. That's a very strong reaction,
> > > > >     so panic_on_warn is usually disabled on production systems.  
> > 
> > Honestly, I am not sure if panic_on_warn() or the new pkill_on_warn()
> > work as expected. I wonder who uses it in practice and what is
> > the experience.
> 
> Several people use it, as I see reports all the time when someone can
> trigger a warn on from user space, and it's listed as a DOS of the
> system.

Good to know.

> > The problem is that many developers do not know about this behavior.
> > They use WARN() when they are lazy to write more useful message or when
> > they want to see all the provided details: task, registry, backtrace.
> 
> WARN() Should never be used just because of laziness. If it is, then
> that's a bug. Let's not use that as an excuse to shoot down this
> proposal. WARN() should only be used to test assumptions where you do
> not believe something can happen. I use it all the time when the logic
> prevents some state, and have the WARN() enabled if that state is hit.
> Because to me, it shows something that shouldn't happen happened, and I
> need to fix the code.

I have just double checked code written or reviewed by me and it
mostly follow the rules. But it is partly just by chance. I did not
have these rather clear rules in my head.

But for example, the following older WARN() in format_decode() in
lib/vsprintf.c is questionable:

	WARN_ONCE(1, "Please remove unsupported %%%c in format string\n", *fmt);

I guess that the WARN() was used to easily locate the caller. But it
is not a reason the reboot the system or kill the process, definitely.

Maybe, we could implement an alternative macro for these situations,
e.g. DEBUG() or warn().

> > Well, this might be different. Developers might learn this the hard
> > way from bug reports. But there will be bug reports only when
> > anyone really enables this behavior. They will enable it only
> > when it works the right way most of the time.
> 
> The panic_on_warn() has been used for years now. I do not think this is
> an issue.

If panic_on_warn() is widely used then pkill_on_warn() is fine as well.

Best Regards,
Petr
