Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E93336F13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhCKJnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhCKJnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:43:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DA4A64F38;
        Thu, 11 Mar 2021 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615455826;
        bh=J8Jxz9e8okdXOazQPLeITn0YDWgZhVvBfqAaIZA7/5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9kMxhDQOgu7bmak3puPXUM5oqPm+l1jssvTS8AgrsJNDzzyrutLfKJs3d7P42Qdh
         6xNPaO/V9C3lYU3zBj7nwTI86nd8I5A+N1FhRLTRaYTucItaYg6cFcoK2Fjnmse74w
         HqBBm7KDFt/cqHUn4UQjgLhK8JkX2eteFoWPPTzs=
Date:   Thu, 11 Mar 2021 10:43:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEnmUEscWfcmDE+5@kroah.com>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEhsHELBM20f4MRE@kroah.com>
 <YEi3ySLkw3hZinnS@chrisdown.name>
 <YEi4qwBAd/O+sXyq@kroah.com>
 <YEnkNrUYAj66li9B@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnkNrUYAj66li9B@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:34:46AM +0100, Petr Mladek wrote:
> On Wed 2021-03-10 13:16:43, Greg Kroah-Hartman wrote:
> > On Wed, Mar 10, 2021 at 12:12:57PM +0000, Chris Down wrote:
> > > Greg Kroah-Hartman writes:
> > > > On Wed, Mar 10, 2021 at 02:30:31AM +0000, Chris Down wrote:
> > > > > +	ps->file = debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
> > > > > +				       ps, &dfs_index_fops);
> > > > > +
> > > > > +	if (IS_ERR(ps->file)) {
> > > > > +		pi_sec_remove(mod);
> > > > > +		return;
> > > > > +	}
> > > > 
> > > > No need to check this and try to clean up if there is a problem, just
> > > > save the pointer off and call debugfs_remove() when you want to clean
> > > > up.
> > > 
> > > Petr, what are your thoughts on this, since you requested the cleanup on
> > > debugfs failure? :-)
> > 
> > There is nothing to "clean up" if there is a debugfs failure here so I
> > don't see the need.
> 
> My main concern is that the allocated struct pi_sec must not be leaked
> when debugfs file was not created.
> 
> I still have to check if it would be freed even without the file
> when the module is going out.

To me it looks like it still will happen as pi_sec_remove() will be
called either way.

thanks,

greg k-h
