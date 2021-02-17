Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA731DB76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBQO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:28:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:50080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233328AbhBQO23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:28:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613572063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJfigc0P3lOfjtoEjyN84pW/CZyXl1dkXC8DnZ9Jzfw=;
        b=Ecl+J9GBRCzXmCthe3lMBXRF4gym/h8/sTTLuN2tCFVpq+vq/FU4IClgLdNRUUrnfQmPLg
        lPdKnevMKZ/h1d5W+tOiiN32dcZvC5TqjrtgmOQ+zvEbq1Af5g86m6IuNVqkMZx3pekOGX
        +eT3DhPKd7rtGsaxnO8b1Xw5WepdojQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5912AB009;
        Wed, 17 Feb 2021 14:27:43 +0000 (UTC)
Date:   Wed, 17 Feb 2021 15:27:42 +0100
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
Message-ID: <YC0n3vRO788sXqud@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvqdrBc3wLDClhv@alley>
 <YCv4V5EFeuEmyxSz@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCv4V5EFeuEmyxSz@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-16 16:52:39, Chris Down wrote:
> Hey Petr,
> 
> Petr Mladek writes:
> > This produces something like:
> > 
> > 3Warning: unable to open an initial console.
> > 3Failed to execute %s (error %d)
> > 6Kernel memory protection disabled.
> > 3Starting init: %s exists but couldn't execute it (error %d)
> > 6Run %s as init process
> > 7initcall %pS returned %d after %lld usecs
> > 7calling  %pS @ %i
> > 2initrd overwritten (0x%08lx < 0x%08lx) - disabling it.
> > 
> > The loglevel is not well separated. It is neither human readable
> > nor safe for a machine processing . It works only for single digit.
> > [...]
> > It looks in less like: [...]
> 
> Hmm, why is it important that debugfs output is human readable? My
> impression was that it's fine to have machine-readable stuff there.

We do not know how different people would want to use the
interface. Why not make it easier out of box when it is simple?

I guess that you already use it internally and have its own tooling
around it. You actually provided a snippet that made the context
better readable:

    $ cat pf.py
    #!/usr/bin/env python
    with open("/sys/kernel/debug/printk/formats/vmlinux") as f:
        raw_fmts = f.read().split("\x00")[:-1]
        for raw_fmt in raw_fmts:
            level, fmt = raw_fmt[1], raw_fmt[2:]
            print(f"Level {level}: {fmt!r}")

I wonder how it would look in another scripting languages, like
bash or perl. Any non-printable character is tricky and would
complicate it.

> Re: not being not safe for machine processing because it only works for a
> single digit, I'm a little confused. KERN_* levels are, as far as I know,
> only a single byte wide, and we rely on that already (eg. in
> printk_skip_header()).

It is great that you mentioned it. KERN_ levels are implementation
detail.

It used to be "<level>". The binary KERN_SOH has been introduced
in v3.6-rc1 by the commit 04d2c8c83d0e3ac5f ("printk: convert
the format for KERN_<LEVEL> to a 2 byte pattern").

In v4.9-rc1, the commit 4bcc595ccd80decb4 ("printk: reinstate KERN_CONT
for printing continuation lines") added the possibility to define
both KERN_LEVEL + KERN_CONT at the same time. It is not handled
by your python snippet above.

The levels 0-7 are there basically from the beginning. But nobody
knows if one digit will be enough forever like 640kB mem.

Actually level 'c' has been added later for continuous lines which
is not even number. There are the following limits defined
in the sources.

#define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
#define CONSOLE_LOGLEVEL_MOTORMOUTH 15	/* You can't shut this one up */

No I rally do not want to expose this binary blobs to the user space
where we need to maintain backward compatibility.


> We also already have precedent for
> null-separation/control characters in (for example) /proc/pid/cmdline.

Yes, there is a precedent. But it does not mean that we should not
try to do it better.


> What am I missing? :-)
> 
> > Well, it still might be non-trivial to find the string in the code
> > and see what exactly has changed. It might be pretty useful
> > to mention even the source_file:line, for example:
> > 
> > <3> init/main.c:1489: Warning: unable to open an initial console.\n
> > <3> init/main.c:1446: Failed to execute %s (error %d)\n
> > <6> init/main.c:1398: Kernel memory protection disabled.\n
> > <3> init/main.c:1366: Starting init: %s exists but couldn't execute it (error %d)\n
> 
> Almost certainly a theoretical concern, but I am not a big fan of this
> format, because it relies on a character (":") which is legal in paths
> (although as you'd expect, we don't have any cases in the kernel right now).
> That's one of the reasons why I preferred to use nulls, which can't be in a
> filename.

Well, it is also a very common format used almost anywhere,
for example, compilers, grep -n.

I think that many tools around kernel will have problems when
such problematic file names are used.

The main question is whether we want the information. IMHO, it might
safe a lot of time when solving problems about the modified strings.

Best Regards,
Petr
