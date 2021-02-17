Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8431DCA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhBQPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:47:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233666AbhBQPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:46:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613576752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FUn7QE4j9n1Ke4FG2h/jPjvP9Wt9kP4O0SUWhsu5TQ0=;
        b=N4OZq7gXUPKaU2Q/R6QAWbED8XySuySJqkmJlCCmN+U2tDf0kCEGF+SN+rL3G1Ih/+IwgV
        qlSWochGv5Gt5A8bIfQ+S/+EHQ84lQfZ+cMxM1KdXCyRJjmROtp1FI/jAO4ogm9UfW0boY
        vtJQF91ixs7xfiYXk7WWJPcX0Hh0uk8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AE42B11F;
        Wed, 17 Feb 2021 15:45:52 +0000 (UTC)
Date:   Wed, 17 Feb 2021 16:45:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC06LyPGmytXJ8Iu@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YCwycC8hPsPD7ArU@cmpxchg.org>
 <YCwzrLTaE9PwNihj@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCwzrLTaE9PwNihj@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-16 21:05:48, Chris Down wrote:
> Johannes Weiner writes:
> > On Tue, Feb 16, 2021 at 05:27:08PM +0000, Chris Down wrote:
> > > Petr Mladek writes:
> > > > I wonder if we could find a better name for the configure switch.
> > > > I have troubles to imagine what printk enumeration might mean.
> > > > Well, it might be because I am not a native speaker.
> > > >
> > > > Anyway, the word "enumeration" is used only in the configure option.
> > > > Everything else is "printk_fmt"
> > > >
> > > > What about DEBUG_PRINTK_FORMATS?
> > > 
> > > Hmm, I don't like DEBUG_PRINTK_FMTS because it's not about debugging, it's
> > > about enumeration, I guess :-)
> > > 
> > > The name should reflect that this catalogues the available printks in the
> > > kernel -- "debugging" seems to imply something different.
> > > 
> > > I'm ok with a different name like "printk catalogue" or something like that
> > > if you prefer. Personally I think "printk enumeration" is fairly clear --
> > > it's about enumerating the available printks -- but anything that captures
> > > that spirit is fine.
> > 
> > How about config PRINTK_INDEX?
> 
> Ah yes, I also like that. PRINTK_INDEX is fine from my perspective and is
> more straightforward than "enumeration", thanks.

It is better than enumeration. But there is still the same
problem. The word "index" is used neither in the code
nor in the debugfs interface. It is like enabling cars and
seeing apples.

What about CONFIG_PRINTK_DEBUGFS?

It seems that various subsystems use CONFIG_<SUBSYSTEM>_DEBUGFS
pattern when they expose some internals in debugfs.

Best Regards,
Petr
