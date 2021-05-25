Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED939051E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhEYPVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:21:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhEYPUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:20:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621955961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQv6TmXPL8R9PpLyyV10o10pyc+idpsWttCSOSU2vdw=;
        b=fWpGz4fQWAB0ROlMAjOgi3UA8rFJBd4elGoxjaNdC1Utp/Yq+j/Yl6KP+dhWiH+Tg1S+48
        kEpGwvZDopboFXR8v0MEqNNkzOS28NPJtMs3/bUDyyHhMF3msNiYkKsul5Nu3kbUyXd8iJ
        cghrGE0GG7J2M836P0cyVNzi9qOcU24=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01C9BAB71;
        Tue, 25 May 2021 15:19:21 +0000 (UTC)
Date:   Tue, 25 May 2021 17:19:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YK0VeJsPMVwvK+vG@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
 <YKPKMCNz2hccaXfR@chrisdown.name>
 <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
 <bdbcf438-50d3-7429-36e8-c077e31bc695@rasmusvillemoes.dk>
 <YKYrIzUGV7VlDu9D@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKYrIzUGV7VlDu9D@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-05-20 12:25:55, Andy Shevchenko wrote:
> On Wed, May 19, 2021 at 08:59:06AM +0200, Rasmus Villemoes wrote:
> > On 18/05/2021 18.00, Andy Shevchenko wrote:
> > > On Tue, May 18, 2021 at 03:07:44PM +0100, Chris Down wrote:
> > >>>> +static int __init pi_init(void)
> > > 
> > >>> No __exit? (There is a corresponding call for exit)
> > >>
> > >> Hmm, can't printk only be built in to the kernel, so it can't be unloaded?
> > >> At least it looks that way from Kconfig. Maybe I'm missing something and
> > >> there's some other way that might be invoked?
> > > 
> > > While it's true, it may help in these cases:
> > >  1) getting things done in a clean way
> > 
> > Huh?
> > 
> > >  2) finding bugs during boot cycle
> > 
> > What bugs would code that doesn't get executed find?
> > 
> > >  3) (possibly) making better debugging in virtual environments
> > 
> > How?
> > 
> > >  4) (also possibly) clean up something which shouldn't be seen by the next
> > >     (unsecure) kernel, like kexec.
> > 
> > Tearing down a few debugfs files wouldn't touch a lot of memory, the
> > printk format strings are very unlikely to be sensitive, and I highly
> > doubt __exit code is kept around and run at kexec time anyway.
> 
> I admit that I'm on a learning curve in this area, and perhaps it was unclear
> from the above that the list I gave is what I think may or might be relevant.
> 
> > IOW, please do not bloat the kernel image with __exit code in things
> > which cannot be built modular.
> 
> Why we have exitcall in the code which can't be modular? Is somebody going to
> clean that up? (Ex. `git grep -w __exitcall`)

Most exit calls are in "um" arch code. AFAIK, it is a kernel that can be
booted in userspace. And it is very special.

Anyway, this functionality (printk index) do not need any special
handling during suspend, reboot, halt, or other system state
changes.

It only has to be initialized during boot at the right time.
It is after debugfs is initialized and before modules can be
loaded.

Best Regards,
Petr
