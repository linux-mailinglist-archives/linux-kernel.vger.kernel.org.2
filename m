Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0963403C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCRKq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:46080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhCRKqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:46:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616064382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tclB5QrQoHhEUb27d5IkFSRDjX313FKOkBJ+z2UTxSo=;
        b=NbpQexOkLEqAdFbc7qpZtb93qCOBZcT02OfL+Pluwab7swBXIc0KRGicHiUP6lNoIET47S
        Gqm/1a7n6uMttpfBdoOPfoxcu7/QRekFz51js8XOLtHKBzY4FUdetcUXOrU0+w3TPQ8Pa6
        r72ILedSgpilLpvm/f/yaKD+GAjXBMA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 388FAACBF;
        Thu, 18 Mar 2021 10:46:22 +0000 (UTC)
Date:   Thu, 18 Mar 2021 11:46:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YFMvfawY+0CncS8G@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-17 11:03:20, Rasmus Villemoes wrote:
> On 17/03/2021 09.40, Petr Mladek wrote:
> > On Tue 2021-03-16 14:28:12, Chris Down wrote:
> >> Rasmus Villemoes writes:
> >>> I think it's pointless renaming the symbol to _printk, with all the
> >>> churn and reduced readability that involves (especially when reading
> >>> assembly "why are we calling _printk and not printk here?"). There's
> >>> nothing wrong with providing a macro wrapper by the same name
> >>>
> >>> #define printk(bla bla) ({ do_stuff; printk(bla bla); })
> >>>
> >>> Only two places would need to be updated to surround the word printk in
> >>> parentheses to suppress macro expansion: The declaration and the
> >>> definition of printk. I.e.
> >>>
> >>> int (printk)(const char *s, ...)
> 
> [Of course, one could avoid that on the declaration by making sure the
> macro wrapper is defined below.]
> 
> >> Hmm, I'm indifferent to either. Personally I don't like the ambiguity of
> >> having both a macro and function share the same name and having to think
> >> "what's the preprocessor context here?".
> > 
> > I would prefer to keep _printk. I agree that it creates some churn but
> > it is easier to see what is going on.
> 
> It is? Nobody except the few who happen to remember about the
> printk_index thing are going to understand why, when looking at
> disassembly, there's now calls of a _printk function. "Huh, my code just
> does pr_err(), I'm not calling some internal printk function". But it's
> not up to me, so I'll stop there.

Sure, it makes sense. But I still think that it won't be easy to
follow where the macro is expanded and where it is not expanded.
It might make things comlicated when people debug printk or try
to understand it's code.

BTW: Is the trick with int (printk)(const char *s, ...) documented
somewhere? Is it portable?

Honestly, I was not aware of this behavior. I did some googling.
It looks like something specific for the gcc implementation,
see the section "Looking for a function-like macro’s opening
parenthesis" at
https://gcc.gnu.org/onlinedocs/cppinternals/Macro-Expansion.html



> Anyway, on to the other thing I mentioned on dev_err and friends: I
> think it would improve readability and make it a lot easier to (probably
> in a later patch) add support for all those dev_* and net_* and whatever
> other subsystems have their own wrappers

This is great point! There are many other subsystem specific wrappers,
e,g, ata_dev_printk(), netdev_printk(), snd_printk(), dprintk().
We should make it easy to index them as well.

> if one created a new header,
> linux/printk-index.h, doing something like
> 
> #ifdef CONFIG_PRINTK_INDEX
> #define __printk_index_emit(fmt) do {the appropriate magic} while (0)
> #else
> #define __printk_index_emit(fmt) do {} while (0)
> #endif
> 
> #define printk_index_wrap(fmt, real_func, ...) ({ \
>   __printk_index_emit(fmt); \
>   real_func(__VA_ARGS__); \
> })
> 
> and then it's a matter of doing
> 
> #define printk(fmt, ...) printk_index_wrap(fmt, _printk, fmt, ##__VA_ARGS__)
> 
> or
> 
> #define _dev_err(dev, fmt, ...) printk_index_wrap(fmt, __dev_err, dev,
> fmt, ##__VA_ARGS__)
> 
> (yeah, _dev_err is the real function, dev_err is already a macro, so
> doing it for dev_* would involve renaming _dev_err to __dev_err. Or one
> could fold the printk_index logic into the existing dev_err macro).
> 
> That is, avoid defining two different versions of each and every
> required wrapper macro depending on CONFIG_PRINTK_INDEX.
> 
> One could also record the function a format is being used with - without
> that, the display probably can't show a reasonable <level> for those
> dev_* function.

Makes sense. I would do this way.

Best Regards,
Petr
