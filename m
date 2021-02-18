Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4631EA89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBRNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:45:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:54008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhBRLyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:54:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613648079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TFxIBRAKMHuHcpBq2IZWUcGVdfo4mM9eHke2Rk/zmNY=;
        b=d7XJr9r6VY1EV1u4Z0ihCOauHFWxUeg8QU33AfmPFeRO0V1gzx+e3Bjc8K08EEmZEV6rqq
        XXHaWbNwecRtCLZCeV3AcPhiW6oKYWmVLhd58Wwybh6uheW6983hjb+z2JPytpIvemoJ58
        h8V2VJk1xhMZ6KwNcZ0ETImqbFSu/X4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EDBEAEBE;
        Thu, 18 Feb 2021 11:34:39 +0000 (UTC)
Date:   Thu, 18 Feb 2021 12:34:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: output: was: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC5QzlkrVp3sPg/4@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvqdrBc3wLDClhv@alley>
 <YCv4V5EFeuEmyxSz@chrisdown.name>
 <YC0n3vRO788sXqud@alley>
 <YC02GBghuhmlvrXk@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC02GBghuhmlvrXk@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-17 15:28:24, Chris Down wrote:
> Petr Mladek writes:
> > I guess that you already use it internally and have its own tooling
> > around it.
> 
> Hmm, we're actually not using it yet widely because I don't want to backport
> it to our prod kernel until we're reasonably agreed on the format :-)
> 
> My main concern is making sure that parsing is reliable, and there's as
> little "well, there shouldn't ever be a <char> here" as possible. That's why I
> preferred originally to use the already well established char array/printk
> rules where possible, since they're mature and well tested.
> 
> I'm not against some other solution though, as long as it meets these
> requirements. It looks like your proposed format with escaping prior to
> sending to userspace also meets that requirement.

Great.

> >    $ cat pf.py
> >    #!/usr/bin/env python
> >    with open("/sys/kernel/debug/printk/formats/vmlinux") as f:
> >        raw_fmts = f.read().split("\x00")[:-1]
> >        for raw_fmt in raw_fmts:
> >            level, fmt = raw_fmt[1], raw_fmt[2:]
> >            print(f"Level {level}: {fmt!r}")
> > 
> > I wonder how it would look in another scripting languages, like
> > bash or perl. Any non-printable character is tricky and would
> > complicate it.
> 
> It's really not that complicated there, either. Since you bring up bash, it's
> even less work than the Python solution:
> 
>     while IFS= read -r -d $'\0' fmt; do
>         printf 'Level %s: %q\n' "${fmt:1:1}" "${fmt:2}"
>     done < /sys/kernel/debug/printk/formats/vmlinux

I do not see how it handles KERN_SOH. Are they silently ignored?
Is it caused by -r -d read options?

And this is one big problem. Non-printable characters sucks. And in
this particular case, we are even disclosing more implementation details
than it is really necessary.


> The changelog describes the use case: automated detection of printk fmts
> changing. For that reason, I don't understand why there's a desire to produce a
> human readable format by default when the only known consumer of this is going
> to be automation anyway.
> 
> If a use case for that comes up, we can always have a directory producing
> human readable versions. I personally don't see the need though.
> 
> As long as it's reliably parseable though, I won't die on this hill, I just
> don't understand the rationale :-)
> 
> > > Re: not being not safe for machine processing because it only works for a
> > > single digit, I'm a little confused. KERN_* levels are, as far as I know,
> > > only a single byte wide, and we rely on that already (eg. in
> > > printk_skip_header()).
> > 
> > It is great that you mentioned it. KERN_ levels are implementation
> > detail.
> > 
> > It used to be "<level>". The binary KERN_SOH has been introduced
> > in v3.6-rc1 by the commit 04d2c8c83d0e3ac5f ("printk: convert
> > the format for KERN_<LEVEL> to a 2 byte pattern").
> > 
> > In v4.9-rc1, the commit 4bcc595ccd80decb4 ("printk: reinstate KERN_CONT
> > for printing continuation lines") added the possibility to define
> > both KERN_LEVEL + KERN_CONT at the same time. It is not handled
> > by your python snippet above.
> 
> Thanks, this is a good callout. I will make sure v5 handles that.
> 
> In a hypothetical scenario where we do go towards something human-readable,
> how do you perceive that should look? Something like this?
> 
>     % less ...
>     <c, 5> 'Some fmt with cont + level 5\n'
>     <5> 'Some fmt with only level 5\n'
>     <c> 'Some fmt with only LOG_CONT\n'

The main question is whether 'c' is really important. But it might be.
It is a hint that it might have different log level depending if it
was successfully connected or not.

Note that it is not connected when messages are printed from another
context, CPU, or process in the meantime.

The space in <c, 5> makes it more human readable. But it might
unnecessary complicate machine processing. I would use a compromise
here:

    <c,5> "Some fmt with cont + level 5\n"

Alternative might be the following format. But it also might be worse
for machine processing:

	<c><5> "Some fmt with cont + level 5\n"


Note, that I used double quotation marks "" instead of single ones ''.
The quotation marks would make sense. And I would prefer the double
ones because they are used in the sources and also in other
interfaces, for example, /sys/kernel/debug/dynamic_debug/control

What about the file name and line number? IMHO, it would be
pretty useful.


> > > We also already have precedent for
> > > null-separation/control characters in (for example) /proc/pid/cmdline.
> > 
> > Yes, there is a precedent. But it does not mean that we should not
> > try to do it better.
> 
> To be clear, I'm actually asserting that I believe the machine-readable
> version _is_ better, not that it's simply unnecessary to produce a
> human-readable version :-)

I am sorry but I still haven't hear any convincing arguments why it is better.

> As mentioned earlier in this e-mail though, it's not a hill I want to die
> on.  If you believe it should be human-readable, as long as its reliably
> parseable, I'm happy to do that.

I believe that it should be human readable :-)

Best Regards,
Petr
