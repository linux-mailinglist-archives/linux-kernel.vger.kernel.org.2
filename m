Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8FF31DF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhBQTSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhBQTSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:18:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71A4C64E62;
        Wed, 17 Feb 2021 19:17:19 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:17:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: output: was: Re: [PATCH v4] printk: Userspace format
 enumeration support
Message-ID: <20210217141717.52089bbc@gandalf.local.home>
In-Reply-To: <YC02GBghuhmlvrXk@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
        <YCvqdrBc3wLDClhv@alley>
        <YCv4V5EFeuEmyxSz@chrisdown.name>
        <YC0n3vRO788sXqud@alley>
        <YC02GBghuhmlvrXk@chrisdown.name>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 15:28:24 +0000
Chris Down <chris@chrisdown.name> wrote:

> Petr Mladek writes:
> >I guess that you already use it internally and have its own tooling
> >around it.  
> 
> Hmm, we're actually not using it yet widely because I don't want to backport it 
> to our prod kernel until we're reasonably agreed on the format :-)
> 
> My main concern is making sure that parsing is reliable, and there's as
> little "well, there shouldn't ever be a <char> here" as possible. That's why I
> preferred originally to use the already well established char array/printk
> rules where possible, since they're mature and well tested.
> 
> I'm not against some other solution though, as long as it meets these
> requirements. It looks like your proposed format with escaping prior to sending 
> to userspace also meets that requirement.
> 
> >    $ cat pf.py
> >    #!/usr/bin/env python
> >    with open("/sys/kernel/debug/printk/formats/vmlinux") as f:
> >        raw_fmts = f.read().split("\x00")[:-1]
> >        for raw_fmt in raw_fmts:
> >            level, fmt = raw_fmt[1], raw_fmt[2:]
> >            print(f"Level {level}: {fmt!r}")

Honestly, I have no idea what the above is doing. And python people tell me
that Perl is hard to read :-p


> >
> >I wonder how it would look in another scripting languages, like
> >bash or perl. Any non-printable character is tricky and would
> >complicate it.  
> 
> It's really not that complicated there, either. Since you bring up bash, it's
> even less work than the Python solution:
> 
>      while IFS= read -r -d $'\0' fmt; do
>          printf 'Level %s: %q\n' "${fmt:1:1}" "${fmt:2}"

OK, now do the same in C. "%q" "and I guess that "f" in the print statement
in python (but I don't know for sure) does some magic with converting the
"\n" and such.

I agree with Petr on this. Print the format itself, and not what is
converted. It's much easier to convert "\t" and such to what they mean,
than to go the other way around.


>      done < /sys/kernel/debug/printk/formats/vmlinux
> 
> The changelog describes the use case: automated detection of printk fmts
> changing. For that reason, I don't understand why there's a desire to produce a
> human readable format by default when the only known consumer of this is going
> to be automation anyway.

It may be the reason its being added, but that doesn't mean it will be the
only use case. Otherwise I would just throw a NAK at this whole thing.

> 
> If a use case for that comes up, we can always have a directory producing human 
> readable versions. I personally don't see the need though.

I rather not add more cruft then needed.

> 
> As long as it's reliably parseable though, I won't die on this hill, I just 
> don't understand the rationale :-)

I rather not have a binary file listing for printk format listings.  Just
for sanity sake if not for anything else.

> 
> >> Re: not being not safe for machine processing because it only works for a
> >> single digit, I'm a little confused. KERN_* levels are, as far as I know,
> >> only a single byte wide, and we rely on that already (eg. in
> >> printk_skip_header()).  
> >
> >It is great that you mentioned it. KERN_ levels are implementation
> >detail.
> >
> >It used to be "<level>". The binary KERN_SOH has been introduced
> >in v3.6-rc1 by the commit 04d2c8c83d0e3ac5f ("printk: convert
> >the format for KERN_<LEVEL> to a 2 byte pattern").
> >
> >In v4.9-rc1, the commit 4bcc595ccd80decb4 ("printk: reinstate KERN_CONT
> >for printing continuation lines") added the possibility to define
> >both KERN_LEVEL + KERN_CONT at the same time. It is not handled
> >by your python snippet above.  
> 
> Thanks, this is a good callout. I will make sure v5 handles that.
> 
> In a hypothetical scenario where we do go towards something human-readable, how 
> do you perceive that should look? Something like this?
> 
>      % less ...
>      <c, 5> 'Some fmt with cont + level 5\n'
>      <5> 'Some fmt with only level 5\n'
>      <c> 'Some fmt with only LOG_CONT\n'
> 
> >> We also already have precedent for
> >> null-separation/control characters in (for example) /proc/pid/cmdline.  
> >
> >Yes, there is a precedent. But it does not mean that we should not
> >try to do it better.  
> 
> To be clear, I'm actually asserting that I believe the machine-readable version 
> _is_ better, not that it's simply unnecessary to produce a human-readable 
> version :-)
> 
> As mentioned earlier in this e-mail though, it's not a hill I want to die on.  
> If you believe it should be human-readable, as long as its reliably parseable, 
> I'm happy to do that.

I too vote for a human readable machine parseable format ;-)

-- Steve
