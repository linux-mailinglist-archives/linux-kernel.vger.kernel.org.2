Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687EA39B6E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFDKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:21:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51876 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:21:00 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3A88C21A05;
        Fri,  4 Jun 2021 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622801953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8W89YNP+89WJux4AtYJr4cyJlxUEv/wtI3bC7TpRIQ=;
        b=l5D0gl6DTXepa9NzQx45n4UbicDLk49UGoR+RRiHEBi+7OzeyY8XO790KUoA/RmZCuxeiK
        8LitiDD3W8VUMEAaNod+3noD6+0+MF1trP6Dr4EbMuUKhpMfHudtPLE5ioDODM1bp2cvF8
        I5e2D/iPoh2r30xGyXkLrrKmAOKdTrI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6735A3B81;
        Fri,  4 Jun 2021 10:19:12 +0000 (UTC)
Date:   Fri, 4 Jun 2021 12:19:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YLn+IEf3iEZpEeQZ@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YK0ShqdTSVTYXGPF@alley>
 <YLZPJpTC6YpJwAJk@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLZPJpTC6YpJwAJk@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-01 16:15:50, Chris Down wrote:
> Hey Petr,
> 
> Thanks for the feedback -- apologies for the delay in getting back.

No problem at all.

> Petr Mladek writes:
> > Note that we do not store the value defined by pr_fmt() which
> > is yet another automatically added prefix.
> 
> Hmm, we do actually store pr_fmt, since it's known at compile time (or we
> wouldn't store it at all if it was dynamic due to the __builtin_constant_p
> check). Or are you seeing something different?

I see. Well, the prefix defined by pr_fmt() becomes part of entry.fmt.
It is _not_ stored in entry.pre_fmt which confused me.

As I mentioned in the previous mail. I think about using "subsys_fmt"
or "subsys_prefix" instead of "pre_fmt".

Anyway, we should improve the comment. For example, something like:

	/*
	 * The format string used by various subsystem specific printk()
	 * wrappers to prefix the message.
	 *
	 * Note that the static prefix defined by pr_fmt() macro is handled
	 * another way. It is stored directly in the message format (@fmt).
	 */
	const char *subsys_fmt;


> > I would personally omit these prefixes. The most important
> 
> Having this information means that system monitors know that they can anchor
> the matching at both ends when linking a printk format with some output,
> rather than having to look for a substring (in which case things become more
> difficult to determine).
>
> I agree that in this particular case with dev_printk it's not incredibly
> useful, but there are certainly others we may want to have in future (like
> the btrfs case) where it would certainly help disambiguate. :-)

Fair enough.

> > > +} __packed;
> > > +
> > > +#define __printk_index_emit(_fmt, _level, _pre_fmt, _post_fmt)		       \
> > > +	({								       \
> > > +		if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
> > > +			/*
> > > +			 * The compiler may not be able to eliminate the
> > > +			 * non-constant variants of _fmt and _level, so we need
> > > +			 * to make sure that it doesn't see any hypothetical
> > > +			 * assignment for non-constants even though this is
> > > +			 * already inside the __builtin_constant_p guard.
> > > +			 */						       \
> > > +			static const struct pi_entry _entry		       \
> > > +			__used = {		       \
> > > +				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
> > > +				.func = __func__,			       \
> > > +				.file = __FILE__,			       \
> > > +				.line = __LINE__,			       \
> > > +				.level = __builtin_constant_p(_level) ? (_level) : NULL, \
> > > +				.pre_fmt = _pre_fmt,			       \
> > 
> > Should this also be?
> > 
> > 	.pre_fmt = __builtin_constant_p(_pre_fmt) ? _pre_fmt : NULL
> > 
> 
> Hmm, if pre_fmt for a subsystem isn't known at compile time, it's an error
> on the developer's end -- otherwise things can't be stored anyway and
> there's no point.

I see.

> > > + * pre and post must be known at compile time, or compilation will fail (since
> > > + * this is a mistake). If fmt or level is not known at compile time, no index
> > > + * entry will be made (since this can legitimately happen).
> > 
> > How is this achieved, please?
> > 
> > __printk_index_emit() creates the entry when the following check is true:
> > 
> >       if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level))
> > 
> > It checks neither _pre_fmt nor _post_fmt.
> 
> Maybe my phrasing wasn't clear, but compilation would fail in that case
> because `.pre_fmt = _pre_fmt` will be a non-constant static initialiser, no?

I see. It was not obvious to me.


> > > +	if (!entry->fmt)
> > > +		return 0;
> > 
> > Is this just a paranoid check or is it a valid case?
> 
> It happens only for the following printk:
> 
> 	arch/x86/mm/fault.c:534 show_fault_oops "BUG: kernel NULL pointer dereference, address: %px\n"

I actually see the above format in the index/vmlinux. So, I added some
debugging info ad the problem seems to be with

   [   94.840349] Err: Printk index entry without format defined
   [   94.841160]   arch/x86/mm/fault.c:435, is_errata93

The string is defined as:

static const char errata93_warning[] =
KERN_ERR 
"******* Your BIOS seems to not contain a fix for K8 errata #93\n"
"******* Working around it, but it may cause SEGVs or burn power.\n"
"******* Please consider a BIOS update.\n"
"******* Disabling USB legacy in the BIOS may also help.\n";

And it is used:
		printk_once(errata93_warning);

Strange. I do not understand what is so special about it. The string
is constant so it should not be the problem handled by the double
__builtin_constant_p.

Anyway, we should keep the check for entry->fmt == NULL to be
on the same side. And it is likely needed also in situations
that are handled by the double __builtin_constant_p.


> > Is is possible to update __printk_index_emit() to do not create
> > entries with fmt = NULL ?
> > 
> > We should either remove the above check or add a comment
> > explaining why it is necessary.
> 
> The trick is unfortunately necessary for the reason described in the comment
> above the double check:
> 
>     /*
>      * The compiler may not be able to eliminate the
>      * non-constant variants of _fmt and _level, so we need
>      * to make sure that it doesn't see any hypothetical
>      * assignment for non-constants even though this is
>      * already inside the __builtin_constant_p guard.
>      */
> 
> Happy to add another comment if it helps.

I re-read the discussion about this,
namely https://lore.kernel.org/r/3Kf896Zt9O+/Yh@chrisdown.name

Frankly, the comment above ftrace_vprintk() is easier to understand
for me. I mean:

/*
 * The double __builtin_constant_p is because gcc will give us an error
 * if we try to allocate the static variable to fmt if it is not a
 * constant. Even with the outer if statement.
 */

> > > +
> > > +	if (entry->level)
> > > +		printk_parse_prefix(entry->level, &level, &flags);
> > > +	else
> > > +		prefix_len = printk_parse_prefix(entry->fmt, &level, &flags);
> > 
> > This is missing:
> > 
> > 	if (level == LOGLEVEL_DEFAULT)
> > 		level = default_message_loglevel;
> > 
> > Without it, it produces lines with loglevel <-1>, for example:
> > 
> > <-1> init/do_mounts.c:457 mount_block_root "\n"
> > <-1> init/do_mounts.c:456 mount_block_root " %s"
> > <-1> init/do_mounts.c:454 mount_block_root "No filesystem could mount root, tried: "
> 
> Hmm, from the perspective of someone building this printk-checking
> infrastructure, I want -1 here instead of dynamically changing the output to
> default_message_loglevel, because default_message_loglevel may not be the
> same across systems. For example, having "-1" allows people to know these
> will come out at whatever the default message loglevel is, rather than
> necessarily being always at (say) level 4 or whatever it happens to be set
> at on the running system.
> 
> Without that, it's also not possible to compare entries across systems or
> across time, because the default loglevel may dynamically change at runtime,
> and it's not possible to disambiguate "will always be KERN_X" from "happens
> to be KERN_X" on this system.
> 
> And if someone really does want to know what value it will be right now,
> they can just look at /proc/sys/kernel/printk and change it out as desired.

Fair enough.

Best Regards,
Petr
