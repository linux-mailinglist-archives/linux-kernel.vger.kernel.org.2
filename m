Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C9336EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhCKJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:35:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:54688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhCKJes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:34:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615455287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9o690LFgyqpfmms3h5IXjlLESHjKX5ZfdgbVv24agE=;
        b=GquV5dckyOd1vcHAkKcLMkh7armwz6a+/XhsBrmmMR57JBw57OaYyLTVjYpkYJzS3ItCUl
        n964MZQwIdkEdqW0I76xsI8UdaWcH32IuCdg1ryXLugInxDxdugqBI2bgPJDWrMA4/k/lF
        ZsMgP/N/c0VxHtc+e39W+gjpGgn/zrI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15332AC23;
        Thu, 11 Mar 2021 09:34:47 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:34:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEnkNrUYAj66li9B@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEhsHELBM20f4MRE@kroah.com>
 <YEi3ySLkw3hZinnS@chrisdown.name>
 <YEi4qwBAd/O+sXyq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEi4qwBAd/O+sXyq@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-10 13:16:43, Greg Kroah-Hartman wrote:
> On Wed, Mar 10, 2021 at 12:12:57PM +0000, Chris Down wrote:
> > Greg Kroah-Hartman writes:
> > > On Wed, Mar 10, 2021 at 02:30:31AM +0000, Chris Down wrote:
> > > > +	ps->file = debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
> > > > +				       ps, &dfs_index_fops);
> > > > +
> > > > +	if (IS_ERR(ps->file)) {
> > > > +		pi_sec_remove(mod);
> > > > +		return;
> > > > +	}
> > > 
> > > No need to check this and try to clean up if there is a problem, just
> > > save the pointer off and call debugfs_remove() when you want to clean
> > > up.
> > 
> > Petr, what are your thoughts on this, since you requested the cleanup on
> > debugfs failure? :-)
> 
> There is nothing to "clean up" if there is a debugfs failure here so I
> don't see the need.

My main concern is that the allocated struct pi_sec must not be leaked
when debugfs file was not created.

I still have to check if it would be freed even without the file
when the module is going out.


> > > Or better yet, no need to save anything, you can always look it up when
> > > you want to remove it, that will save you one pointer per module.
> > 
> > That's a good point, and with that maybe we can even do away with the pi_sec
> > entirely then since that only leaves start/end pointers which we can
> > calculate on demand from existing data.
> 
> Please do, that makes the code simpler overall.

Yup, that might make things even easier. Well, I still have to go and
try to better understand the new patch.

Best Regards,
Petr
