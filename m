Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89F441DFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351090AbhI3RAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350497AbhI3RAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:00:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 173F6617E5;
        Thu, 30 Sep 2021 16:59:05 +0000 (UTC)
Date:   Thu, 30 Sep 2021 12:59:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <20210930125903.0783b06e@oasis.local.home>
In-Reply-To: <YVWAPXSzFNbHz6+U@alley>
References: <20210929185823.499268-1-alex.popov@linux.com>
        <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
        <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1>
        <YVWAPXSzFNbHz6+U@alley>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 11:15:41 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2021-09-29 12:49:24, Paul E. McKenney wrote:
> > On Wed, Sep 29, 2021 at 10:01:33PM +0300, Alexander Popov wrote:  
> > > On 29.09.2021 21:58, Alexander Popov wrote:  
> > > > Currently, the Linux kernel provides two types of reaction to kernel
> > > > warnings:
> > > >  1. Do nothing (by default),
> > > >  2. Call panic() if panic_on_warn is set. That's a very strong reaction,
> > > >     so panic_on_warn is usually disabled on production systems.  
> 
> Honestly, I am not sure if panic_on_warn() or the new pkill_on_warn()
> work as expected. I wonder who uses it in practice and what is
> the experience.

Several people use it, as I see reports all the time when someone can
trigger a warn on from user space, and it's listed as a DOS of the
system.

> 
> The problem is that many developers do not know about this behavior.
> They use WARN() when they are lazy to write more useful message or when
> they want to see all the provided details: task, registry, backtrace.

WARN() Should never be used just because of laziness. If it is, then
that's a bug. Let's not use that as an excuse to shoot down this
proposal. WARN() should only be used to test assumptions where you do
not believe something can happen. I use it all the time when the logic
prevents some state, and have the WARN() enabled if that state is hit.
Because to me, it shows something that shouldn't happen happened, and I
need to fix the code.

Basically, WARN should be used just like BUG. But Linus hates BUG,
because in most cases, these bad areas shouldn't take down the entire
kernel, but for some people, they WANT it to take down the system.

> 
> Also it is inconsistent with pr_warn() behavior. Why a single line
> warning would be innocent and full info WARN() cause panic/pkill?

pr_warn() can be used for things that the user can hit. I'll use
pr_warn, for memory failures, and such. Something that says "we ran out
of resources, this will not work the way you expect". That is perfect
for pr_warn. But not something that requires a stack dump.

> 
> What about pr_err(), pr_crit(), pr_alert(), pr_emerg()? They inform
> about even more serious problems. Why a warning should cause panic/pkill
> while an alert message is just printed?

Because really, WARN() == BUG() but like I said, Linus doesn't like
taking down the entire system on these areas.

> 
> 
> It somehow reminds me the saga with %pK. We were not able to teach
> developers to use it correctly for years and ended with hashed
> pointers.
> 
> Well, this might be different. Developers might learn this the hard
> way from bug reports. But there will be bug reports only when
> anyone really enables this behavior. They will enable it only
> when it works the right way most of the time.

The panic_on_warn() has been used for years now. I do not think this is
an issue.

> 
> I wonder if kernel could survive killing of any kthread. I have never
> seen a code that would check whether a kthread was killed and
> restart it.

We can easily check if the thread is a kernel thread or a user thread,
and make the decision on that.

-- Steve
