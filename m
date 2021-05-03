Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627B537232A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhECWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhECWrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:47:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4495E61185;
        Mon,  3 May 2021 22:46:08 +0000 (UTC)
Date:   Mon, 3 May 2021 18:46:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <20210503184606.5e8461c0@gandalf.local.home>
In-Reply-To: <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
References: <20210503213400.27360-1-ahalaney@redhat.com>
        <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 14:59:31 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi--
> 
> On 5/3/21 2:34 PM, Andrew Halaney wrote:
> > It is easy to foobar setting a kernel parameter on the command line
> > without realizing it, there's not much output that you can use to
> > assess what the kernel did with that parameter by default.
> > 
> > Make it a little more explicit which parameters on the command line
> > _looked_ like a valid parameter for the kernel, but did not match
> > anything and ultimately got tossed to init. This is very similar to the
> > unknown parameter message received when loading a module.
> > 
> > This assumes the parameters are processed in a normal fashion, some
> > parameters (dyndbg= for example) don't register their
> > parameter with the rest of the kernel's parameters, and therefore
> > always show up in this list (and are also given to init - like the
> > rest of this list).  
> 
> As you say, unknown parameters are just given to init -- they are not
> errors.
> 
> However, if someone is experiencing a problem, can't they just boot
> with the addition of "debug" to the kernel command line and then they
> can see what arguments and environment are being passed to the init
> process?  E.g.:
> 
> [    9.453693] Run /sbin/init as init process
> [    9.456886]   with arguments:
> [    9.460014]     /sbin/init
> [    9.463121]     showopts
> [    9.466157]     fb=font:VGA8x8
> [    9.469172]   with environment:
> [    9.472146]     HOME=/
> [    9.475152]     TERM=linux
> [    9.478103]     BOOT_IMAGE=/boot/bzImage-next0409
> [    9.481057]     resume=/dev/sda7
> [    9.484006]     splash=native
> [    9.495272]     v1de0=vesafb
> 
> 
> Can you show an example of what this code prints?

Note, the issue this is trying to solve is to catch "typos" when someone
adds a parameter. Perhaps we should add a parameter called "check" and/or a
config option to always check.

This came out of a discussion that a developer was wondering why adding
"trace_events=x,y,z" wasn't working. It ended up being that they used
"trace_events=" and not "trace_event=" (added 's'). Having some output that
denotes this might help, where people can make sure the options they are
adding is indeed the correct ones.

Comment below about the patch.

> 
> thanks.
> 
> > Another example is BOOT_IMAGE= is highlighted as an offender, which it
> > technically is, but is passed by LILO and GRUB so most systems will see
> > that complaint.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > 
> > Hello,
> > 
> > This idea was suggested by rostedt and bpetkov, not sure what they'll
> > think of the implementation :P Please let me know if you've got
> > suggestions (or hate the idea in general).
> > 
> > Piggybacking on unknown_bootoption()'s assessment of the
> > parameters made this pretty straight forward, but I'm a bit unhappy with
> > dyndbg and BOOT_IMAGE showing up. I didn't want to make an exception for
> > them, so I left it as is and decided that their oddities ought to be
> > shown in the output still. The format of the output is borrowed from the
> > dynamic debug statements for printing init's env/argv lines.
> > 
> > Due to the BOOT_IMAGE bit I didn't actually ever get to exercise the
> > early return (limited on my test systems right now) but I think I got
> > that statement correct.
> > 
> > Thanks,
> > Andrew
> > 
> >  init/main.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index dd11bfd10ead..cd313f1bc7b0 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -872,6 +872,20 @@ void __init __weak arch_call_rest_init(void)
> >  	rest_init();
> >  }
> >  
> > +void print_unknown_bootoptions(void)
> > +{
> > +	const char *const *p;
> > +
> > +	if (panic_later || (!argv_init[1] && !envp_init[2]))
> > +		return;
> > +
> > +	pr_notice("Unknown command line parameters:\n");
> > +	for (p = &argv_init[1]; *p; p++)
> > +		pr_notice("    %s\n", *p);
> > +	for (p = &envp_init[2]; *p; p++)
> > +		pr_notice("    %s\n", *p);
> > +}

Perhaps make this one line, like "Kernel command line:" has.

-- Steve

> > +
> >  asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> >  {
> >  	char *command_line;
> > @@ -913,6 +927,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> >  				  static_command_line, __start___param,
> >  				  __stop___param - __start___param,
> >  				  -1, -1, NULL, &unknown_bootoption);
> > +	print_unknown_bootoptions();
> >  	if (!IS_ERR_OR_NULL(after_dashes))
> >  		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
> >  			   NULL, set_init_arg);
> >   
> 
> 

